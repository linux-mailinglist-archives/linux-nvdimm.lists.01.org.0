Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960619027D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 01:11:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 64D2410FC38A2;
	Mon, 23 Mar 2020 17:12:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 561A710FC38A1
	for <linux-nvdimm@lists.01.org>; Mon, 23 Mar 2020 17:12:32 -0700 (PDT)
IronPort-SDR: lxxicFOxlQTfmkq1hlTniYXD7XnNfsfYCCo9hWfbkryv//45kw3QxHs7Ehwgyp4vkmgiTHJXxv
 LY1ekyBAVRIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:11:41 -0700
IronPort-SDR: II9mWSQjXBt6vxQ3hwFbd6KPXmXcIQuLLceKQr4Fs/SI1UsS/7/LsFnK5CoGIYE6WDzohEY6Qc
 2wY0cI0dxH5w==
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200";
   d="scan'208";a="393091929"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:11:41 -0700
Subject: [PATCH 11/12] device-dax: Add dis-contiguous resource support
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Mon, 23 Mar 2020 16:55:35 -0700
Message-ID: <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: QPZMY5KK36LRWSUP5ZUCVNB535HTNIYK
X-Message-ID-Hash: QPZMY5KK36LRWSUP5ZUCVNB535HTNIYK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, dave.hansen@linux.intel.com, hch@lst.de, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QPZMY5KK36LRWSUP5ZUCVNB535HTNIYK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Break the requirement that device-dax instances are physically
contiguous. With this constraint removed it allows fragmented available
capacity to be fully allocated.

It can be used to help with memory-side-cache management for virtual
machines, or any other scenario where a platform address boundary also
designates a performance boundary. For example a direct mapped memory
side cache might rotate cache colors at 1GB boundaries.  With
dis-contiguous allocations a device-dax instance could be configured to
contain only 1 cache color.

It also satisfies Joao's use case:

Link: https://lore.kernel.org/lkml/20200110190313.17144-1-joao.m.martins@oracle.com/
Reported-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c              |  230 +++++++++++++++++++++++++++++-----------
 drivers/dax/dax-private.h      |    9 +-
 drivers/dax/device.c           |   55 ++++++----
 drivers/dax/kmem.c             |   98 ++++++++++++-----
 tools/testing/nvdimm/dax-dev.c |   20 ++-
 5 files changed, 289 insertions(+), 123 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 9695d70b1e80..07aeb8fa9ee8 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -136,15 +136,27 @@ static bool is_static(struct dax_region *dax_region)
 	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
 }
 
+static u64 dev_dax_size(struct dev_dax *dev_dax)
+{
+	u64 size = 0;
+	int i;
+
+	device_lock_assert(&dev_dax->dev);
+
+	for (i = 0; i < dev_dax->nr_range; i++)
+		size += range_len(&dev_dax->ranges[i].range);
+
+	return size;
+}
+
 static int dax_bus_probe(struct device *dev)
 {
 	struct dax_device_driver *dax_drv = to_dax_drv(dev->driver);
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct dax_region *dax_region = dev_dax->region;
-	struct range *range = &dev_dax->range;
 	int rc;
 
-	if (range_len(range) == 0 || dev_dax->id < 0)
+	if (dev_dax_size(dev_dax) == 0 || dev_dax->id < 0)
 		return -ENXIO;
 
 	rc = dax_drv->probe(dev_dax);
@@ -335,15 +347,19 @@ void kill_dev_dax(struct dev_dax *dev_dax)
 }
 EXPORT_SYMBOL_GPL(kill_dev_dax);
 
-static void free_dev_dax_range(struct dev_dax *dev_dax)
+static void free_dev_dax_ranges(struct dev_dax *dev_dax)
 {
 	struct dax_region *dax_region = dev_dax->region;
-	struct range *range = &dev_dax->range;
+	int i;
 
 	device_lock_assert(dax_region->dev);
-	if (range_len(range))
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct range *range = &dev_dax->ranges[i].range;
+
 		__release_region(&dax_region->res, range->start,
 				range_len(range));
+	}
+	dev_dax->nr_range = 0;
 }
 
 static void unregister_dev_dax(void *dev)
@@ -353,7 +369,7 @@ static void unregister_dev_dax(void *dev)
 	dev_dbg(dev, "%s\n", __func__);
 
 	kill_dev_dax(dev_dax);
-	free_dev_dax_range(dev_dax);
+	free_dev_dax_ranges(dev_dax);
 	device_del(dev);
 	put_device(dev);
 }
@@ -404,7 +420,7 @@ static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
 	device_lock(dev);
 	device_lock(victim);
 	dev_dax = to_dev_dax(victim);
-	if (victim->driver || range_len(&dev_dax->range))
+	if (victim->driver || dev_dax_size(dev_dax))
 		rc = -EBUSY;
 	else {
 		/*
@@ -548,7 +564,10 @@ static int __alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 	struct dax_region *dax_region = dev_dax->region;
 	struct resource *res = &dax_region->res;
 	struct device *dev = &dev_dax->dev;
+	struct dev_dax_range *ranges;
+	unsigned long pgoff = 0;
 	struct resource *alloc;
+	int i;
 
 	device_lock_assert(dax_region->dev);
 
@@ -561,13 +580,26 @@ static int __alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 	if (start == U64_MAX)
 		return -EINVAL;
 
+	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
+			* (dev_dax->nr_range + 1), GFP_KERNEL);
+	if (!ranges)
+		return -ENOMEM;
+
 	alloc = __request_region(res, start, size, dev_name(dev), 0);
-	if (!alloc)
+	if (!alloc) {
+		kfree(ranges);
 		return -ENOMEM;
+	}
 
-	dev_dax->range = (struct range) {
-		.start = alloc->start,
-		.end = alloc->end,
+	for (i = 0; i < dev_dax->nr_range; i++)
+		pgoff += PHYS_PFN(range_len(&ranges[i].range));
+	dev_dax->ranges = ranges;
+	ranges[dev_dax->nr_range++] = (struct dev_dax_range) {
+		.pgoff = pgoff,
+		.range = {
+			.start = alloc->start,
+			.end = alloc->end,
+		},
 	};
 
 	return 0;
@@ -577,13 +609,10 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, resource_size_t size)
 {
 	/* handle the seed alloc special case */
 	if (!size) {
-		struct dax_region *dax_region = dev_dax->region;
-		struct resource *res = &dax_region->res;
-
-		dev_dax->range = (struct range) {
-			.start = res->start,
-			.end = res->start - 1,
-		};
+		if (dev_WARN_ONCE(&dev_dax->dev, dev_dax->nr_range,
+					"0-size allocation must be first\n"))
+			return -EBUSY;
+		/* special case dev_dax->nr_range == 0 as 0 size */
 		return 0;
 	}
 
@@ -593,21 +622,23 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, resource_size_t size)
 static int __adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res,
 		resource_size_t size)
 {
+	int last_range = dev_dax->nr_range - 1;
+	struct dev_dax_range *dax_range = &dev_dax->ranges[last_range];
 	struct dax_region *dax_region = dev_dax->region;
-	struct range *range = &dev_dax->range;
-	int rc = 0;
+	struct range *range = &dax_range->range;
+	int rc;
 
 	device_lock_assert(dax_region->dev);
 
-	if (size)
-		rc = adjust_resource(res, range->start, size);
-	else
-		__release_region(&dax_region->res, range->start,
-				range_len(range));
+	if (dev_WARN_ONCE(&dev_dax->dev, !size,
+				"deletion is handled by dev_dax_shrink\n"))
+		return -EINVAL;
+
+	rc = adjust_resource(res, range->start, size);
 	if (rc)
 		return rc;
 
-	dev_dax->range = (struct range) {
+	*range = (struct range) {
 		.start = range->start,
 		.end = range->start + size - 1,
 	};
@@ -619,7 +650,11 @@ static ssize_t size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
-	unsigned long long size = range_len(&dev_dax->range);
+	unsigned long long size;
+
+	device_lock(dev);
+	size = dev_dax_size(dev_dax);
+	device_unlock(dev);
 
 	return sprintf(buf, "%llu\n", size);
 }
@@ -637,32 +672,79 @@ static bool alloc_is_aligned(struct dax_region *dax_region,
 
 static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 {
+	resource_size_t to_shrink = dev_dax_size(dev_dax) - size;
 	struct dax_region *dax_region = dev_dax->region;
-	struct range *range = &dev_dax->range;
-	struct resource *res, *adjust = NULL;
 	struct device *dev = &dev_dax->dev;
-
-	for_each_dax_region_resource(dax_region, res)
-		if (strcmp(res->name, dev_name(dev)) == 0
-				&& res->start == range->start) {
-			adjust = res;
-			break;
+	int i;
+
+	for (i = dev_dax->nr_range - 1; i >= 0; i--) {
+		struct range *range = &dev_dax->ranges[i].range;
+		struct resource *adjust = NULL, *res;
+		resource_size_t shrink;
+
+		shrink = min(to_shrink, range_len(range));
+		if (shrink >= range_len(range)) {
+			__release_region(&dax_region->res, range->start,
+					range_len(range));
+			dev_dax->nr_range--;
+			to_shrink -= shrink;
+			if (!to_shrink)
+				break;
+			continue;
 		}
 
-	if (dev_WARN_ONCE(dev, !adjust, "failed to find matching resource\n"))
-		return -ENXIO;
-	return __adjust_dev_dax_range(dev_dax, adjust, size);
+		for_each_dax_region_resource(dax_region, res)
+			if (strcmp(res->name, dev_name(dev)) == 0
+					&& res->start == range->start) {
+				adjust = res;
+				break;
+			}
+
+		if (dev_WARN_ONCE(dev, !adjust || i != dev_dax->nr_range - 1,
+					"failed to find matching resource\n"))
+			return -ENXIO;
+		return __adjust_dev_dax_range(dev_dax, adjust, range_len(range)
+				- shrink);
+	}
+	return 0;
+}
+
+/*
+ * Only allow adjustments that preserve the relative pgoff of existing
+ * allocations. I.e. the dev_dax->ranges array is ordered by increasing pgoff.
+ */
+static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
+{
+	struct dev_dax_range *last;
+	int i;
+
+	if (dev_dax->nr_range == 0)
+		return false;
+	if (strcmp(res->name, dev_name(&dev_dax->dev)) != 0)
+		return false;
+	last = &dev_dax->ranges[dev_dax->nr_range - 1];
+	if (last->range.start != res->start || last->range.end != res->end)
+		return false;
+	for (i = 0; i < dev_dax->nr_range - 1; i++) {
+		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
+
+		if (dax_range->pgoff > last->pgoff)
+			return false;
+	}
+
+	return true;
 }
 
 static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		struct dev_dax *dev_dax, resource_size_t size)
 {
 	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
-	resource_size_t dev_size = range_len(&dev_dax->range);
+	resource_size_t dev_size = dev_dax_size(dev_dax);
 	struct resource *region_res = &dax_region->res;
 	struct device *dev = &dev_dax->dev;
-	const char *name = dev_name(dev);
 	struct resource *res, *first;
+	resource_size_t alloc = 0;
+	int rc;
 
 	if (dev->driver)
 		return -EBUSY;
@@ -684,38 +766,47 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 	 * allocating a new resource.
 	 */
 	first = region_res->child;
-	if (!first)
-		return __alloc_dev_dax_range(dev_dax, dax_region->res.start,
-				to_alloc);
-	for (res = first; to_alloc && res; res = res->sibling) {
+retry:
+	rc = -ENOSPC;
+	for (res = first; res; res = res->sibling) {
 		struct resource *next = res->sibling;
-		resource_size_t free;
 
 		/* space at the beginning of the region */
-		free = 0;
-		if (res == first && res->start > dax_region->res.start)
-			free = res->start - dax_region->res.start;
-		if (free >= to_alloc && dev_size == 0)
-			return __alloc_dev_dax_range(dev_dax,
-					dax_region->res.start, to_alloc);
-
-		free = 0;
+		if (res == first && res->start > dax_region->res.start) {
+			alloc = min(res->start - dax_region->res.start,
+					to_alloc);
+			rc = __alloc_dev_dax_range(dev_dax,
+					dax_region->res.start, alloc);
+			break;
+		}
+
+		alloc = 0;
 		/* space between allocations */
 		if (next && next->start > res->end + 1)
-			free = next->start - res->end + 1;
+			alloc = min(next->start - (res->end + 1), to_alloc);
 
 		/* space at the end of the region */
-		if (free < to_alloc && !next && res->end < region_res->end)
-			free = region_res->end - res->end;
-
-		if (free >= to_alloc && strcmp(name, res->name) == 0)
-			return __adjust_dev_dax_range(dev_dax, res,
-					resource_size(res) + to_alloc);
-		else if (free >= to_alloc && dev_size == 0)
-			return __alloc_dev_dax_range(dev_dax, res->end + 1,
-					to_alloc);
+		if (!alloc && !next && res->end < region_res->end)
+			alloc = min(region_res->end - res->end, to_alloc);
+
+		if (!alloc)
+			continue;
+
+		if (adjust_ok(dev_dax, res)) {
+			rc = __adjust_dev_dax_range(dev_dax, res,
+					resource_size(res) + alloc);
+			break;
+		}
+		rc = __alloc_dev_dax_range(dev_dax, res->end + 1,
+				alloc);
+		break;
 	}
-	return -ENOSPC;
+	if (rc)
+		return rc;
+	to_alloc -= alloc;
+	if (to_alloc)
+		goto retry;
+	return 0;
 }
 
 static ssize_t size_store(struct device *dev, struct device_attribute *attr,
@@ -769,8 +860,15 @@ static ssize_t resource_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_region *dax_region = dev_dax->region;
+	unsigned long long start;
+
+	if (dev_dax->nr_range < 1)
+		start = dax_region->res.start;
+	else
+		start = dev_dax->ranges[0].range.start;
 
-	return sprintf(buf, "%#llx\n", dev_dax->range.start);
+	return sprintf(buf, "%#llx\n", start);
 }
 static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
@@ -939,7 +1037,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 err_alloc_dax:
 	kfree(dev_dax->pgmap);
 err_pgmap:
-	free_dev_dax_range(dev_dax);
+	free_dev_dax_ranges(dev_dax);
 err_range:
 	free_dev_dax_id(dev_dax);
 err_id:
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 17d3b5f94de8..d6aea3eaea43 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -47,7 +47,8 @@ struct dax_region {
  * @id: ida allocated id
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
- * @range: resource range for the instance
+ * @nr_range: size of @ranges
+ * @ranges: resource-span + pgoff tuples for the instance
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -56,7 +57,11 @@ struct dev_dax {
 	int id;
 	struct device dev;
 	struct dev_pagemap *pgmap;
-	struct range range;
+	int nr_range;
+	struct dev_dax_range {
+		unsigned long pgoff;
+		struct range range;
+	} *ranges;
 };
 
 static inline struct dev_dax *to_dev_dax(struct device *dev)
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 9752f7b6cfe0..b75e902d9c2f 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -55,15 +55,22 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 		unsigned long size)
 {
-	struct range *range = &dev_dax->range;
-	phys_addr_t phys;
-
-	phys = pgoff * PAGE_SIZE + range->start;
-	if (phys >= range->start && phys <= range->end) {
+	int i;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
+		struct range *range = &dax_range->range;
+		unsigned long long pgoff_end;
+		phys_addr_t phys;
+
+		pgoff_end = dax_range->pgoff + PHYS_PFN(range_len(range)) - 1;
+		if (pgoff < dax_range->pgoff || pgoff > pgoff_end)
+			continue;
+		phys = PFN_PHYS(pgoff - dax_range->pgoff) + range->start;
 		if (phys + size - 1 <= range->end)
 			return phys;
+		break;
 	}
-
 	return -1;
 }
 
@@ -394,30 +401,40 @@ static void dev_dax_kill(void *dev_dax)
 int dev_dax_probe(struct dev_dax *dev_dax)
 {
 	struct dax_device *dax_dev = dev_dax->dax_dev;
-	struct range *range = &dev_dax->range;
 	struct device *dev = &dev_dax->dev;
 	struct dev_pagemap *pgmap;
 	struct inode *inode;
 	struct cdev *cdev;
 	void *addr;
-	int rc;
-
-	/* 1:1 map region resource range to device-dax instance range */
-	if (!devm_request_mem_region(dev, range->start, range_len(range),
-				dev_name(dev))) {
-		dev_warn(dev, "could not reserve range: %#llx - %#llx\n",
-				range->start, range->end);
-		return -EBUSY;
-	}
+	int rc, i;
 
 	pgmap = dev_dax->pgmap;
+	if (dev_WARN_ONCE(dev, pgmap && dev_dax->nr_range > 1,
+			"static pgmap / multi-range device conflict\n"))
+		return -EINVAL;
+
 	if (!pgmap) {
-		pgmap = devm_kzalloc(dev, sizeof(*pgmap), GFP_KERNEL);
+		pgmap = devm_kzalloc(dev, sizeof(*pgmap) + sizeof(struct range)
+				* (dev_dax->nr_range - 1), GFP_KERNEL);
 		if (!pgmap)
 			return -ENOMEM;
-		pgmap->range = *range;
-		pgmap->nr_range = 1;
+		pgmap->nr_range = dev_dax->nr_range;
+	}
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct range *range = &dev_dax->ranges[i].range;
+
+		if (!devm_request_mem_region(dev, range->start,
+					range_len(range), dev_name(dev))) {
+			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve range\n",
+					i, range->start, range->end);
+			return -EBUSY;
+		}
+		/* don't update the range for static pgmap */
+		if (!dev_dax->pgmap)
+			pgmap->ranges[i] = *range;
 	}
+
 	pgmap->type = MEMORY_DEVICE_DEVDAX;
 	addr = devm_memremap_pages(dev, pgmap);
 	if (IS_ERR(addr))
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index d41f6ac8b56f..8af5ec234e30 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -14,24 +14,27 @@
 #include "dax-private.h"
 #include "bus.h"
 
-static struct range dax_kmem_range(struct dev_dax *dev_dax)
+static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
 {
-	struct range range;
+	struct dev_dax_range *dax_range = &dev_dax->ranges[i];
+	struct range *range = &dax_range->range;
 
 	/* memory-block align the hotplug range */
-	range.start = ALIGN(dev_dax->range.start, memory_block_size_bytes());
-	range.end = ALIGN_DOWN(dev_dax->range.end + 1,
-			memory_block_size_bytes()) - 1;
-	return range;
+	r->start = ALIGN(range->start, memory_block_size_bytes());
+	r->end = ALIGN_DOWN(range->end + 1, memory_block_size_bytes()) - 1;
+	if (r->start >= r->end) {
+		r->start = range->start;
+		r->end = range->end;
+		return -ENOSPC;
+	}
+	return 0;
 }
 
 int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
-	struct range range = dax_kmem_range(dev_dax);
 	int numa_node = dev_dax->target_node;
 	struct device *dev = &dev_dax->dev;
-	struct resource *res;
-	int rc;
+	int i, mapped = 0;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -45,20 +48,45 @@ int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		return -EINVAL;
 	}
 
-	res = request_mem_region(range.start, range_len(&range), dev_name(dev));
-	if (!res) {
-		dev_warn(dev, "could not reserve region [%#llx-%#llx]\n",
-				range.start, range.end);
-		return -EBUSY;
-	}
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct resource *res;
+		struct range range;
+		int rc;
+
+		rc = dax_kmem_range(dev_dax, i, &range);
+		if (rc) {
+			dev_info(dev, "mapping%d: %#llx-%#llx too small after alignment\n",
+					i, range.start, range.end);
+			continue;
+		}
 
-	/* Temporarily clear busy to allow add_memory() to claim it */
-	res->flags &= ~IORESOURCE_BUSY;
-	rc = add_memory(numa_node, range.start, range_len(&range));
-	res->flags |= IORESOURCE_BUSY;
-	if (rc) {
-		release_mem_region(range.start, range_len(&range));
-		return rc;
+		res = request_mem_region(range.start, range_len(&range),
+				dev_name(dev));
+		if (!res) {
+			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve region\n",
+					i, range.start, range.end);
+			/*
+			 * Once some memory has been onlined we can't
+			 * assume that it can be un-onlined safely.
+			 */
+			if (mapped)
+				continue;
+			return -EBUSY;
+		}
+
+		/* Temporarily clear busy to allow add_memory() to claim it */
+		res->flags &= ~IORESOURCE_BUSY;
+		rc = add_memory(numa_node, range.start, range_len(&range));
+		res->flags |= IORESOURCE_BUSY;
+		if (rc) {
+			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
+					i, range.start, range.end);
+			release_mem_region(range.start, range_len(&range));
+			if (mapped)
+				continue;
+			return rc;
+		}
+		mapped++;
 	}
 
 	return 0;
@@ -67,8 +95,7 @@ int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static void dax_kmem_release(struct dev_dax *dev_dax)
 {
-	struct range range = dax_kmem_range(dev_dax);
-	int rc;
+	int i;
 
 	/*
 	 * We have one shot for removing memory, if some memory blocks were not
@@ -76,13 +103,24 @@ static void dax_kmem_release(struct dev_dax *dev_dax)
 	 * there is no way to hotremove this memory until reboot because device
 	 * unbind will proceed regardless of the remove_memory result.
 	 */
-	rc = remove_memory(dev_dax->target_node, range.start, range_len(&range));
-	if (rc == 0) {
-		release_mem_region(range.start, range_len(&range));
-		return;
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct range range;
+		int rc;
+
+		rc = dax_kmem_range(dev_dax, i, &range);
+		if (rc)
+			continue;
+
+		rc = remove_memory(dev_dax->target_node, range.start,
+				range_len(&range));
+		if (rc == 0) {
+			release_mem_region(range.start, range_len(&range));
+			continue;
+		}
+		dev_err(&dev_dax->dev,
+			"mapping%d: %#llx-%#llx cannot be hotremoved until the next reboot\n",
+				i, range.start, range.end);
 	}
-	dev_err(&dev_dax->dev, "%#llx-%#llx cannot be hotremoved until the next reboot\n",
-			range.start, range.end);
 }
 #else
 static void dax_kmem_release(struct dev_dax *dev_dax)
diff --git a/tools/testing/nvdimm/dax-dev.c b/tools/testing/nvdimm/dax-dev.c
index 38d8e55c4a0d..fb342a8c98d3 100644
--- a/tools/testing/nvdimm/dax-dev.c
+++ b/tools/testing/nvdimm/dax-dev.c
@@ -9,11 +9,18 @@
 phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 		unsigned long size)
 {
-	struct range *range = &dev_dax->range;
-	phys_addr_t addr;
+	int i;
 
-	addr = pgoff * PAGE_SIZE + range->start;
-	if (addr >= range->start && addr <= range->end) {
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
+		struct range *range = &dax_range->range;
+		unsigned long long pgoff_end;
+		phys_addr_t addr;
+
+		pgoff_end = dax_range->pgoff + PHYS_PFN(range_len(range)) - 1;
+		if (pgoff < dax_range->pgoff || pgoff > pgoff_end)
+			continue;
+		addr = PFN_PHYS(pgoff - dax_range->pgoff) + range->start;
 		if (addr + size - 1 <= range->end) {
 			if (get_nfit_res(addr)) {
 				struct page *page;
@@ -23,9 +30,10 @@ phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 
 				page = vmalloc_to_page((void *)addr);
 				return PFN_PHYS(page_to_pfn(page));
-			} else
-				return addr;
+			}
+			return addr;
 		}
+		break;
 	}
 	return -1;
 }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
