Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5F2846D7
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Oct 2020 09:13:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F86B1557A1AC;
	Tue,  6 Oct 2020 00:13:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4D90E1557A1AC
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 00:13:20 -0700 (PDT)
IronPort-SDR: r4SxI7Cz2ey/R9uGJUVvaX2PnCHJK3Oqrw2JecDYG+4xOkna+Hh4neD9lr5MkhhMx+pt4eUDRs
 UOyzVMEfCvgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="163620280"
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400";
   d="scan'208";a="163620280"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:19 -0700
IronPort-SDR: 0k9uB/ueLQiAS1PM7FY1fwtUsLowBz6aVab51vxMpjzba5zVMaGiL3fMb6tHiqmQd0ntAqQ2lH
 p/DcnZRcElXQ==
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400";
   d="scan'208";a="518157843"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:19 -0700
Subject: [PATCH v6 01/11] device-dax: make pgmap optional for instance
 creation
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Mon, 05 Oct 2020 23:54:50 -0700
Message-ID: <160196729025.2166475.18034609850460599015.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: XPP2M5YF4GI3GF5RG7XNM5ODKFR3PUT5
X-Message-ID-Hash: XPP2M5YF4GI3GF5RG7XNM5ODKFR3PUT5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: david@redhat.com, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Brice Goglin <Brice.Goglin@inria.fr>, Jia He <justin.he@arm.com>, joao.m.martins@oracle.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XPP2M5YF4GI3GF5RG7XNM5ODKFR3PUT5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The passed in dev_pagemap is only required in the pmem case as the
libnvdimm core may have reserved a vmem_altmap for dev_memremap_pages() to
place the memmap in pmem directly.  In the hmem case there is no agent
reserving an altmap so it can all be handled by a core internal default.

Pass the resource range via a new @range property of 'struct
dev_dax_data'.

Link: https://lkml.kernel.org/r/159643099958.4062302.10379230791041872886.stgit@dwillia2-desk3.amr.corp.intel.com
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
 drivers/dax/bus.c              |   29 +++++++++++++++--------------
 drivers/dax/bus.h              |    2 ++
 drivers/dax/dax-private.h      |    4 +++-
 drivers/dax/device.c           |   28 +++++++++++++++++++---------
 drivers/dax/hmem/hmem.c        |    8 ++++----
 drivers/dax/kmem.c             |   12 ++++++------
 drivers/dax/pmem/core.c        |    4 ++++
 include/linux/range.h          |    5 +++++
 tools/testing/nvdimm/dax-dev.c |    8 ++++----
 9 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index dffa4655e128..96bd64ba95a5 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -271,7 +271,7 @@ static ssize_t size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
-	unsigned long long size = resource_size(&dev_dax->region->res);
+	unsigned long long size = range_len(&dev_dax->range);
 
 	return sprintf(buf, "%llu\n", size);
 }
@@ -293,19 +293,12 @@ static ssize_t target_node_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_node);
 
-static unsigned long long dev_dax_resource(struct dev_dax *dev_dax)
-{
-	struct dax_region *dax_region = dev_dax->region;
-
-	return dax_region->res.start;
-}
-
 static ssize_t resource_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 
-	return sprintf(buf, "%#llx\n", dev_dax_resource(dev_dax));
+	return sprintf(buf, "%#llx\n", dev_dax->range.start);
 }
 static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
@@ -376,6 +369,7 @@ static void dev_dax_release(struct device *dev)
 
 	dax_region_put(dax_region);
 	put_dax(dax_dev);
+	kfree(dev_dax->pgmap);
 	kfree(dev_dax);
 }
 
@@ -412,7 +406,12 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
 
-	memcpy(&dev_dax->pgmap, data->pgmap, sizeof(struct dev_pagemap));
+	if (data->pgmap) {
+		dev_dax->pgmap = kmemdup(data->pgmap,
+				sizeof(struct dev_pagemap), GFP_KERNEL);
+		if (!dev_dax->pgmap)
+			goto err_pgmap;
+	}
 
 	/*
 	 * No 'host' or dax_operations since there is no access to this
@@ -421,18 +420,19 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	dax_dev = alloc_dax(dev_dax, NULL, NULL, DAXDEV_F_SYNC);
 	if (IS_ERR(dax_dev)) {
 		rc = PTR_ERR(dax_dev);
-		goto err;
+		goto err_alloc_dax;
 	}
 
 	/* a device_dax instance is dead while the driver is not attached */
 	kill_dax(dax_dev);
 
-	/* from here on we're committed to teardown via dax_dev_release() */
+	/* from here on we're committed to teardown via dev_dax_release() */
 	dev = &dev_dax->dev;
 	device_initialize(dev);
 
 	dev_dax->dax_dev = dax_dev;
 	dev_dax->region = dax_region;
+	dev_dax->range = data->range;
 	dev_dax->target_node = dax_region->target_node;
 	kref_get(&dax_region->kref);
 
@@ -458,8 +458,9 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 		return ERR_PTR(rc);
 
 	return dev_dax;
-
- err:
+err_alloc_dax:
+	kfree(dev_dax->pgmap);
+err_pgmap:
 	kfree(dev_dax);
 
 	return ERR_PTR(rc);
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 299c2e7fac09..4aeb36da83a4 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -3,6 +3,7 @@
 #ifndef __DAX_BUS_H__
 #define __DAX_BUS_H__
 #include <linux/device.h>
+#include <linux/range.h>
 
 struct dev_dax;
 struct resource;
@@ -21,6 +22,7 @@ struct dev_dax_data {
 	struct dax_region *dax_region;
 	struct dev_pagemap *pgmap;
 	enum dev_dax_subsys subsys;
+	struct range range;
 	int id;
 };
 
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 8a4c40ccd2ef..fbaea36938ae 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -41,6 +41,7 @@ struct dax_region {
  * @target_node: effective numa node if dev_dax memory range is onlined
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
+ * @range: resource range for the instance
  * @dax_mem_res: physical address range of hotadded DAX memory
  * @dax_mem_name: name for hotadded DAX memory via add_memory_driver_managed()
  */
@@ -49,7 +50,8 @@ struct dev_dax {
 	struct dax_device *dax_dev;
 	int target_node;
 	struct device dev;
-	struct dev_pagemap pgmap;
+	struct dev_pagemap *pgmap;
+	struct range range;
 	struct resource *dax_kmem_res;
 };
 
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index c528b725789b..287cf0a3db23 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -55,12 +55,12 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 		unsigned long size)
 {
-	struct resource *res = &dev_dax->region->res;
+	struct range *range = &dev_dax->range;
 	phys_addr_t phys;
 
-	phys = pgoff * PAGE_SIZE + res->start;
-	if (phys >= res->start && phys <= res->end) {
-		if (phys + size - 1 <= res->end)
+	phys = pgoff * PAGE_SIZE + range->start;
+	if (phys >= range->start && phys <= range->end) {
+		if (phys + size - 1 <= range->end)
 			return phys;
 	}
 
@@ -396,21 +396,31 @@ int dev_dax_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct dax_device *dax_dev = dev_dax->dax_dev;
-	struct resource *res = &dev_dax->region->res;
+	struct range *range = &dev_dax->range;
+	struct dev_pagemap *pgmap;
 	struct inode *inode;
 	struct cdev *cdev;
 	void *addr;
 	int rc;
 
 	/* 1:1 map region resource range to device-dax instance range */
-	if (!devm_request_mem_region(dev, res->start, resource_size(res),
+	if (!devm_request_mem_region(dev, range->start, range_len(range),
 				dev_name(dev))) {
-		dev_warn(dev, "could not reserve region %pR\n", res);
+		dev_warn(dev, "could not reserve range: %#llx - %#llx\n",
+				range->start, range->end);
 		return -EBUSY;
 	}
 
-	dev_dax->pgmap.type = MEMORY_DEVICE_GENERIC;
-	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
+	pgmap = dev_dax->pgmap;
+	if (!pgmap) {
+		pgmap = devm_kzalloc(dev, sizeof(*pgmap), GFP_KERNEL);
+		if (!pgmap)
+			return -ENOMEM;
+		pgmap->res.start = range->start;
+		pgmap->res.end = range->end;
+	}
+	pgmap->type = MEMORY_DEVICE_GENERIC;
+	addr = devm_memremap_pages(dev, pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index b84fe17178d8..af82d6ba820a 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -8,7 +8,6 @@
 static int dax_hmem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct dev_pagemap pgmap = { };
 	struct dax_region *dax_region;
 	struct memregion_info *mri;
 	struct dev_dax_data data;
@@ -20,8 +19,6 @@ static int dax_hmem_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mri = dev->platform_data;
-	memcpy(&pgmap.res, res, sizeof(*res));
-
 	dax_region = alloc_dax_region(dev, pdev->id, res, mri->target_node,
 			PMD_SIZE);
 	if (!dax_region)
@@ -30,7 +27,10 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
 		.id = 0,
-		.pgmap = &pgmap,
+		.range = {
+			.start = res->start,
+			.end = res->end,
+		},
 	};
 	dev_dax = devm_create_dev_dax(&data);
 	if (IS_ERR(dev_dax))
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 275aa5f87399..5bb133df147d 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -22,7 +22,7 @@ static bool any_hotremove_failed;
 int dev_dax_kmem_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
-	struct resource *res = &dev_dax->region->res;
+	struct range *range = &dev_dax->range;
 	resource_size_t kmem_start;
 	resource_size_t kmem_size;
 	resource_size_t kmem_end;
@@ -39,17 +39,17 @@ int dev_dax_kmem_probe(struct device *dev)
 	 */
 	numa_node = dev_dax->target_node;
 	if (numa_node < 0) {
-		dev_warn(dev, "rejecting DAX region %pR with invalid node: %d\n",
-			 res, numa_node);
+		dev_warn(dev, "rejecting DAX region with invalid node: %d\n",
+				numa_node);
 		return -EINVAL;
 	}
 
 	/* Hotplug starting at the beginning of the next block: */
-	kmem_start = ALIGN(res->start, memory_block_size_bytes());
+	kmem_start = ALIGN(range->start, memory_block_size_bytes());
 
-	kmem_size = resource_size(res);
+	kmem_size = range_len(range);
 	/* Adjust the size down to compensate for moving up kmem_start: */
-	kmem_size -= kmem_start - res->start;
+	kmem_size -= kmem_start - range->start;
 	/* Align the size down to cover only complete blocks: */
 	kmem_size &= ~(memory_block_size_bytes() - 1);
 	kmem_end = kmem_start + kmem_size;
diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 08ee5947a49c..4fa81d3d2f65 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -63,6 +63,10 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 		.id = id,
 		.pgmap = &pgmap,
 		.subsys = subsys,
+		.range = {
+			.start = res.start,
+			.end = res.end,
+		},
 	};
 	dev_dax = devm_create_dev_dax(&data);
 
diff --git a/include/linux/range.h b/include/linux/range.h
index d1fbeb664012..9c28353a1219 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -7,6 +7,11 @@ struct range {
 	u64   end;
 };
 
+static inline u64 range_len(const struct range *range)
+{
+	return range->end - range->start + 1;
+}
+
 int add_range(struct range *range, int az, int nr_range,
 		u64 start, u64 end);
 
diff --git a/tools/testing/nvdimm/dax-dev.c b/tools/testing/nvdimm/dax-dev.c
index 7e5d979e73cb..38d8e55c4a0d 100644
--- a/tools/testing/nvdimm/dax-dev.c
+++ b/tools/testing/nvdimm/dax-dev.c
@@ -9,12 +9,12 @@
 phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 		unsigned long size)
 {
-	struct resource *res = &dev_dax->region->res;
+	struct range *range = &dev_dax->range;
 	phys_addr_t addr;
 
-	addr = pgoff * PAGE_SIZE + res->start;
-	if (addr >= res->start && addr <= res->end) {
-		if (addr + size - 1 <= res->end) {
+	addr = pgoff * PAGE_SIZE + range->start;
+	if (addr >= range->start && addr <= range->end) {
+		if (addr + size - 1 <= range->end) {
 			if (get_nfit_res(addr)) {
 				struct page *page;
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
