Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB02279173
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 21:30:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA521154F001B;
	Fri, 25 Sep 2020 12:30:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CF32E154F0015
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 12:30:23 -0700 (PDT)
IronPort-SDR: 0c+2F4hwQ0jP/KBo3OLoconSXxu+nmQ9tzv05Rq8HG4jN0s0VGISot3dzsSOqGQ11JOTCQaSq/
 1HxEoI8ZexmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="141641234"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="141641234"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:23 -0700
IronPort-SDR: ysA/Rkwzd/BphO4dBoKfduaGz2F+AyB+jqp6/pz6QtLPZmAY58Z5zcYyJUL5ZuH6lQgKzOvTHo
 fS3QzxV1hL2w==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="348515408"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:23 -0700
Subject: [PATCH v5 04/17] device-dax/kmem: replace release_resource() with
 release_mem_region()
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Fri, 25 Sep 2020 12:12:02 -0700
Message-ID: <160106112239.30709.15909567572288425294.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: PICGZVOIL5LBZCI4KMDXV2CM5QQMD4UR
X-Message-ID-Hash: PICGZVOIL5LBZCI4KMDXV2CM5QQMD4UR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Brice Goglin <Brice.Goglin@inria.fr>, Jia He <justin.he@arm.com>, Joao Martins <joao.m.martins@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PICGZVOIL5LBZCI4KMDXV2CM5QQMD4UR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Towards removing the mode specific @dax_kmem_res attribute from the
generic 'struct dev_dax', and preparing for multi-range support, change
the kmem driver to use the idiomatic release_mem_region() to pair with
the initial request_mem_region(). This also eliminates the need to open
code the release of the resource allocated by request_mem_region().

As there are no more dax_kmem_res users, delete this struct member.

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
 drivers/dax/dax-private.h |    3 ---
 drivers/dax/kmem.c        |   20 +++++++-------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 6779f683671d..12a2dbc43b40 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -42,8 +42,6 @@ struct dax_region {
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @range: resource range for the instance
- * @dax_mem_res: physical address range of hotadded DAX memory
- * @dax_mem_name: name for hotadded DAX memory via add_memory_driver_managed()
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -52,7 +50,6 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	struct range range;
-	struct resource *dax_kmem_res;
 };
 
 static inline u64 range_len(struct range *range)
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 6fe2cb1c5f7c..e56fc688bdc5 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -33,7 +33,7 @@ int dev_dax_kmem_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct range range = dax_kmem_range(dev_dax);
-	struct resource *new_res;
+	struct resource *res;
 	char *res_name;
 	int numa_node;
 	int rc;
@@ -56,8 +56,8 @@ int dev_dax_kmem_probe(struct device *dev)
 		return -ENOMEM;
 
 	/* Region is permanently reserved if hotremove fails. */
-	new_res = request_mem_region(range.start, range_len(&range), res_name);
-	if (!new_res) {
+	res = request_mem_region(range.start, range_len(&range), res_name);
+	if (!res) {
 		dev_warn(dev, "could not reserve region [%#llx-%#llx]\n", range.start, range.end);
 		kfree(res_name);
 		return -EBUSY;
@@ -69,23 +69,20 @@ int dev_dax_kmem_probe(struct device *dev)
 	 * inherit flags from the parent since it may set new flags
 	 * unknown to us that will break add_memory() below.
 	 */
-	new_res->flags = IORESOURCE_SYSTEM_RAM;
+	res->flags = IORESOURCE_SYSTEM_RAM;
 
 	/*
 	 * Ensure that future kexec'd kernels will not treat this as RAM
 	 * automatically.
 	 */
-	rc = add_memory_driver_managed(numa_node, new_res->start,
-				       resource_size(new_res), kmem_name);
+	rc = add_memory_driver_managed(numa_node, range.start, range_len(&range), kmem_name);
 	if (rc) {
-		release_resource(new_res);
-		kfree(new_res);
+		release_mem_region(range.start, range_len(&range));
 		kfree(res_name);
 		return rc;
 	}
 
 	dev_set_drvdata(dev, res_name);
-	dev_dax->dax_kmem_res = new_res;
 
 	return 0;
 }
@@ -95,7 +92,6 @@ static int dev_dax_kmem_remove(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct range range = dax_kmem_range(dev_dax);
-	struct resource *res = dev_dax->dax_kmem_res;
 	const char *res_name = dev_get_drvdata(dev);
 	int rc;
 
@@ -114,10 +110,8 @@ static int dev_dax_kmem_remove(struct device *dev)
 	}
 
 	/* Release and free dax resources */
-	release_resource(res);
-	kfree(res);
+	release_mem_region(range.start, range_len(&range));
 	kfree(res_name);
-	dev_dax->dax_kmem_res = NULL;
 
 	return 0;
 }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
