Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1384C279172
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 21:30:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B9A46154F0017;
	Fri, 25 Sep 2020 12:30:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7CD1014B7EA7A
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 12:30:18 -0700 (PDT)
IronPort-SDR: 54QrU34UFyzB5vDEPCBarzKVys8zThkVxyOc6EvP9/P7aQek4xiazZ+bazanZkYmkIh/I8iRT0
 9xj9ShGNrJWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="141028432"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="141028432"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:17 -0700
IronPort-SDR: yKtywSJjUB9ZKmM9Dm1/NkFLNg6UOlkygXJcF325A3yOAu1vGWmcg+N6lHh5/cpo3GZoAsM8yX
 +euzea32KQbw==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="512356606"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:17 -0700
Subject: [PATCH v5 03/17] device-dax/kmem: move resource name tracking to
 drvdata
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Fri, 25 Sep 2020 12:11:56 -0700
Message-ID: <160106111639.30709.17624822766862009183.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 46NFUP5HQ56ZA3D2FF3SVSJFIQEXUTY4
X-Message-ID-Hash: 46NFUP5HQ56ZA3D2FF3SVSJFIQEXUTY4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Brice Goglin <Brice.Goglin@inria.fr>, Jia He <justin.he@arm.com>, Joao Martins <joao.m.martins@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/46NFUP5HQ56ZA3D2FF3SVSJFIQEXUTY4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Towards removing the mode specific @dax_kmem_res attribute from the
generic 'struct dev_dax', and preparing for multi-range support, move
resource name tracking to driver data.  The memory for the resource name
needs to have its own lifetime separate from the device bind lifetime
for cases where the driver is unbound, but the kmem range could not be
unplugged from the page allocator.

Cc: David Hildenbrand <david@redhat.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jia He <justin.he@arm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/kmem.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index b0d6a99cf12d..6fe2cb1c5f7c 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -34,7 +34,7 @@ int dev_dax_kmem_probe(struct device *dev)
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct range range = dax_kmem_range(dev_dax);
 	struct resource *new_res;
-	const char *new_res_name;
+	char *res_name;
 	int numa_node;
 	int rc;
 
@@ -51,15 +51,15 @@ int dev_dax_kmem_probe(struct device *dev)
 		return -EINVAL;
 	}
 
-	new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
-	if (!new_res_name)
+	res_name = kstrdup(dev_name(dev), GFP_KERNEL);
+	if (!res_name)
 		return -ENOMEM;
 
 	/* Region is permanently reserved if hotremove fails. */
-	new_res = request_mem_region(range.start, range_len(&range), new_res_name);
+	new_res = request_mem_region(range.start, range_len(&range), res_name);
 	if (!new_res) {
 		dev_warn(dev, "could not reserve region [%#llx-%#llx]\n", range.start, range.end);
-		kfree(new_res_name);
+		kfree(res_name);
 		return -EBUSY;
 	}
 
@@ -80,9 +80,11 @@ int dev_dax_kmem_probe(struct device *dev)
 	if (rc) {
 		release_resource(new_res);
 		kfree(new_res);
-		kfree(new_res_name);
+		kfree(res_name);
 		return rc;
 	}
+
+	dev_set_drvdata(dev, res_name);
 	dev_dax->dax_kmem_res = new_res;
 
 	return 0;
@@ -94,7 +96,7 @@ static int dev_dax_kmem_remove(struct device *dev)
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct range range = dax_kmem_range(dev_dax);
 	struct resource *res = dev_dax->dax_kmem_res;
-	const char *res_name = res->name;
+	const char *res_name = dev_get_drvdata(dev);
 	int rc;
 
 	/*
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
