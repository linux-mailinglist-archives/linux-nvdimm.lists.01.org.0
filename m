Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C889213939
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Jul 2020 13:19:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BA8111487766;
	Fri,  3 Jul 2020 04:19:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=hare@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 75D49114726D1
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 04:19:01 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id A1A6BAE65;
	Fri,  3 Jul 2020 11:18:59 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Dan Williams <dan.williams@intel.com>
Subject: [PATCH] libnvdimm: call devm_namespace_disable() on error
Date: Fri,  3 Jul 2020 13:18:56 +0200
Message-Id: <20200703111856.40280-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Message-ID-Hash: 5NG3ZNPD6BZ6ZHDURQWXVMH4MLFOXYLW
X-Message-ID-Hash: 5NG3ZNPD6BZ6ZHDURQWXVMH4MLFOXYLW
X-MailFrom: hare@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Hannes Reinecke <hare@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5NG3ZNPD6BZ6ZHDURQWXVMH4MLFOXYLW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Once devm_namespace_enable() has been called the error path in the
calling function will not call devm_namespace_disable(), leaving the
namespace enabled on error.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/dax/pmem/core.c   |  2 +-
 drivers/nvdimm/btt.c      |  5 ++++-
 drivers/nvdimm/claim.c    |  8 +++++++-
 drivers/nvdimm/pfn_devs.c |  1 +
 drivers/nvdimm/pmem.c     | 20 ++++++++++----------
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 2bedf8414fff..4b26434f0aca 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -31,9 +31,9 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	if (rc)
 		return ERR_PTR(rc);
 	rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
+	devm_namespace_disable(dev, ndns);
 	if (rc)
 		return ERR_PTR(rc);
-	devm_namespace_disable(dev, ndns);
 
 	/* reserve the metadata area, device-dax will reserve the data */
 	pfn_sb = nd_pfn->pfn_sb;
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 48e9d169b6f9..bd4747f2c99b 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1704,13 +1704,16 @@ int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns)
 		dev_dbg(&nd_btt->dev, "%s must be at least %ld bytes\n",
 				dev_name(&ndns->dev),
 				ARENA_MIN_SIZE + nd_btt->initial_offset);
+		devm_namespace_disable(&nd_btt->dev, ndns);
 		return -ENXIO;
 	}
 	nd_region = to_nd_region(nd_btt->dev.parent);
 	btt = btt_init(nd_btt, rawsize, nd_btt->lbasize, nd_btt->uuid,
 			nd_region);
-	if (!btt)
+	if (!btt) {
+		devm_namespace_disable(&nd_btt->dev, ndns);
 		return -ENOMEM;
+	}
 	nd_btt->btt = btt;
 
 	return 0;
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 45964acba944..15fd1b92d32f 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -314,12 +314,18 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio,
 	}
 
 	ndns->rw_bytes = nsio_rw_bytes;
-	if (devm_init_badblocks(dev, &nsio->bb))
+	if (devm_init_badblocks(dev, &nsio->bb)) {
+		devm_release_mem_region(dev, res->start, size);
 		return -ENOMEM;
+	}
 	nvdimm_badblocks_populate(to_nd_region(ndns->dev.parent), &nsio->bb,
 			&nsio->res);
 
 	nsio->addr = devm_memremap(dev, res->start, size, ARCH_MEMREMAP_PMEM);
+	if (IS_ERR(nsio->addr)) {
+		devm_exit_badblocks(dev, &nsio->bb);
+		devm_release_mem_region(dev, res->start, size);
+	}
 
 	return PTR_ERR_OR_ZERO(nsio->addr);
 }
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 34db557dbad1..9faa92662643 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -408,6 +408,7 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
 				nsoff += chunk;
 			}
 			if (rc) {
+				devm_namespace_disable(&nd_pfn->dev, ndns);
 				dev_err(&nd_pfn->dev,
 					"error clearing %x badblocks at %llx\n",
 					num_bad, first_bad);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index d25e66fd942d..4f667fe6ef72 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -401,8 +401,10 @@ static int pmem_attach_disk(struct device *dev,
 	if (is_nd_pfn(dev)) {
 		nd_pfn = to_nd_pfn(dev);
 		rc = nvdimm_setup_pfn(nd_pfn, &pmem->pgmap);
-		if (rc)
+		if (rc) {
+			devm_namespace_disable(dev, ndns);
 			return rc;
+		}
 	}
 
 	/* we're attaching a block device, disable raw namespace access */
@@ -549,17 +551,15 @@ static int nd_pmem_probe(struct device *dev)
 	ret = nd_pfn_probe(dev, ndns);
 	if (ret == 0)
 		return -ENXIO;
-	else if (ret == -EOPNOTSUPP)
-		return ret;
-
-	ret = nd_dax_probe(dev, ndns);
-	if (ret == 0)
-		return -ENXIO;
-	else if (ret == -EOPNOTSUPP)
-		return ret;
-
+	else if (ret != EOPNOTSUPP) {
+		ret = nd_dax_probe(dev, ndns);
+		if (ret == 0)
+			return -ENXIO;
+	}
 	/* probe complete, attach handles namespace enabling */
 	devm_namespace_disable(dev, ndns);
+	if (ret == -EOPNOTSUPP)
+		return ret;
 
 	return pmem_attach_disk(dev, ndns);
 }
-- 
2.16.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
