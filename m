Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5686F28E994
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Oct 2020 03:00:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 219EB15989D2A;
	Wed, 14 Oct 2020 18:00:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BBB0E15989D29
	for <linux-nvdimm@lists.01.org>; Wed, 14 Oct 2020 18:00:39 -0700 (PDT)
IronPort-SDR: biqlos6dCr/8kv3ZQtVOLRLEHUmZXTU2KanRyAOyLPYQQZVND2cMQzdxIZTNL8wrk2vz23unaV
 qGYWFT2bGkHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="153165811"
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400";
   d="scan'208";a="153165811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 18:00:39 -0700
IronPort-SDR: +GanhSOzVZlWa2eF4YEC17nMwSUu/4Nio4x/byPlczB6DLh+lElcwDVvtvX2fqdpq8R32Ouhil
 KS5M8ZHJU1+g==
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400";
   d="scan'208";a="464089569"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 18:00:38 -0700
Subject: [PATCH 1/2] device-dax/kmem: Fix resource release
From: Dan Williams <dan.j.williams@intel.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2020 17:42:09 -0700
Message-ID: <160272252925.3136502.17220638073995895400.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160272252400.3136502.13635752844548960833.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160272252400.3136502.13635752844548960833.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: XVRQMNMZQR2GHPTZWVWGSQN7ZM3Z6DWO
X-Message-ID-Hash: XVRQMNMZQR2GHPTZWVWGSQN7ZM3Z6DWO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Brice Goglin <Brice.Goglin@inria.fr>, Jia He <justin.he@arm.com>, Joao Martins <joao.m.martins@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, akpm@linux-foundation.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XVRQMNMZQR2GHPTZWVWGSQN7ZM3Z6DWO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The conversion to request_mem_region() is broken because it assumes that
the range is marked busy prior to release. However, due to the way that
the kmem driver manipulates the IORESOURCE_BUSY flag (clears it to
let {add,remove}_memory() handle busy) it requires a manual
release_resource() to perform cleanup.

Given that the actual 'struct resource *' needs to be recalled, not just
the range, add that tracking to the kmem driver-data.

Reported-by: David Hildenbrand <david@redhat.com>
Fixes: 0513bd5bb114 ("device-dax/kmem: replace release_resource() with release_mem_region()")
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jia He <justin.he@arm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/kmem.c |   48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 6c933f2b604e..af04b6d1d263 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -35,11 +35,17 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
 	return 0;
 }
 
+struct dax_kmem_data {
+	const char *res_name;
+	struct resource *res[];
+};
+
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
+	struct dax_kmem_data *data;
+	int rc = -ENOMEM;
 	int i, mapped = 0;
-	char *res_name;
 	int numa_node;
 
 	/*
@@ -55,14 +61,17 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		return -EINVAL;
 	}
 
-	res_name = kstrdup(dev_name(dev), GFP_KERNEL);
-	if (!res_name)
+	data = kzalloc(sizeof(*data) + sizeof(struct resource *) * dev_dax->nr_range, GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
+	data->res_name = kstrdup(dev_name(dev), GFP_KERNEL);
+	if (!data->res_name)
+		goto err_res_name;
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct resource *res;
 		struct range range;
-		int rc;
 
 		rc = dax_kmem_range(dev_dax, i, &range);
 		if (rc) {
@@ -72,7 +81,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		}
 
 		/* Region is permanently reserved if hotremove fails. */
-		res = request_mem_region(range.start, range_len(&range), res_name);
+		res = request_mem_region(range.start, range_len(&range), data->res_name);
 		if (!res) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve region\n",
 					i, range.start, range.end);
@@ -82,9 +91,10 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 			 */
 			if (mapped)
 				continue;
-			kfree(res_name);
-			return -EBUSY;
+			rc = -EBUSY;
+			goto err_request_mem;
 		}
+		data->res[i] = res;
 
 		/*
 		 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
@@ -104,18 +114,25 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		if (rc) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
 					i, range.start, range.end);
-			release_mem_region(range.start, range_len(&range));
+			release_resource(res);
+			kfree(res);
+			data->res[i] = NULL;
 			if (mapped)
 				continue;
-			kfree(res_name);
-			return rc;
+			goto err_request_mem;
 		}
 		mapped++;
 	}
 
-	dev_set_drvdata(dev, res_name);
+	dev_set_drvdata(dev, data);
 
 	return 0;
+
+err_request_mem:
+	kfree(data->res_name);
+err_res_name:
+	kfree(data);
+	return rc;
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
@@ -123,7 +140,7 @@ static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
 	int i, success = 0;
 	struct device *dev = &dev_dax->dev;
-	const char *res_name = dev_get_drvdata(dev);
+	struct dax_kmem_data *data = dev_get_drvdata(dev);
 
 	/*
 	 * We have one shot for removing memory, if some memory blocks were not
@@ -142,7 +159,9 @@ static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
 		rc = remove_memory(dev_dax->target_node, range.start,
 				range_len(&range));
 		if (rc == 0) {
-			release_mem_region(range.start, range_len(&range));
+			release_resource(data->res[i]);
+			kfree(data->res[i]);
+			data->res[i] = NULL;
 			success++;
 			continue;
 		}
@@ -153,7 +172,8 @@ static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
 	}
 
 	if (success >= dev_dax->nr_range) {
-		kfree(res_name);
+		kfree(data->res_name);
+		kfree(data);
 		dev_set_drvdata(dev, NULL);
 	}
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
