Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3834A279174
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 21:30:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 074B3154F001C;
	Fri, 25 Sep 2020 12:30:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 66A5F154F0015
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 12:30:29 -0700 (PDT)
IronPort-SDR: XVcZtbCsQnJMe1FD9J6JvI5GXRPLfz3Nv36XO6Bfucl38YChjneen+5Q+6Y+U7kLd72Q2y291W
 5TU2Wi/PtdnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="225779035"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="225779035"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:29 -0700
IronPort-SDR: k6hcpSbPBvMVQ86mN8/uOcKf9nD9mfc931sCUIawi16DTlBATeL3GarmxPlR7Raftc90gbICPQ
 HTmA+SCd63Aw==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="349880015"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:28 -0700
Subject: [PATCH v5 05/17] device-dax: add an allocation interface for
 device-dax instances
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Fri, 25 Sep 2020 12:12:08 -0700
Message-ID: <160106112801.30709.14601438735305335071.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: AHAQ4YIR3LUQJ3N4GDS7FNMWCO2ZILYK
X-Message-ID-Hash: AHAQ4YIR3LUQJ3N4GDS7FNMWCO2ZILYK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Brice Goglin <Brice.Goglin@inria.fr>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Jia He <justin.he@arm.com>, Joao Martins <joao.m.martins@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AHAQ4YIR3LUQJ3N4GDS7FNMWCO2ZILYK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

;In preparation for a facility that enables dax regions to be sub-divided,
introduce infrastructure to track and allocate region capacity.

The new dax_region/available_size attribute is only enabled for volatile
hmem devices, not pmem devices that are defined by nvdimm namespace
boundaries.  This is per Jeff's feedback the last time dynamic device-dax
capacity allocation support was discussed.

Link: https://lore.kernel.org/linux-nvdimm/x49shpp3zn8.fsf@segfault.boston.devel.redhat.com
Link: https://lkml.kernel.org/r/159643101035.4062302.6785857915652647857.stgit@dwillia2-desk3.amr.corp.intel.com
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jia He <justin.he@arm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |  120 +++++++++++++++++++++++++++++++++++++++++----
 drivers/dax/bus.h         |    7 ++-
 drivers/dax/dax-private.h |    2 -
 drivers/dax/hmem/hmem.c   |    7 +--
 drivers/dax/pmem/core.c   |    8 +--
 5 files changed, 121 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 96bd64ba95a5..0a48ce378686 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -130,6 +130,11 @@ ATTRIBUTE_GROUPS(dax_drv);
 
 static int dax_bus_match(struct device *dev, struct device_driver *drv);
 
+static bool is_static(struct dax_region *dax_region)
+{
+	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
+}
+
 static struct bus_type dax_bus_type = {
 	.name = "dax",
 	.uevent = dax_bus_uevent,
@@ -185,7 +190,48 @@ static ssize_t align_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(align);
 
+#define for_each_dax_region_resource(dax_region, res) \
+	for (res = (dax_region)->res.child; res; res = res->sibling)
+
+static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
+{
+	resource_size_t size = resource_size(&dax_region->res);
+	struct resource *res;
+
+	device_lock_assert(dax_region->dev);
+
+	for_each_dax_region_resource(dax_region, res)
+		size -= resource_size(res);
+	return size;
+}
+
+static ssize_t available_size_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+	unsigned long long size;
+
+	device_lock(dev);
+	size = dax_region_avail_size(dax_region);
+	device_unlock(dev);
+
+	return sprintf(buf, "%llu\n", size);
+}
+static DEVICE_ATTR_RO(available_size);
+
+static umode_t dax_region_visible(struct kobject *kobj, struct attribute *a,
+		int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+
+	if (is_static(dax_region) && a == &dev_attr_available_size.attr)
+		return 0;
+	return a->mode;
+}
+
 static struct attribute *dax_region_attributes[] = {
+	&dev_attr_available_size.attr,
 	&dev_attr_region_size.attr,
 	&dev_attr_align.attr,
 	&dev_attr_id.attr,
@@ -195,6 +241,7 @@ static struct attribute *dax_region_attributes[] = {
 static const struct attribute_group dax_region_attribute_group = {
 	.name = "dax_region",
 	.attrs = dax_region_attributes,
+	.is_visible = dax_region_visible,
 };
 
 static const struct attribute_group *dax_region_attribute_groups[] = {
@@ -226,7 +273,8 @@ static void dax_region_unregister(void *region)
 }
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, int target_node, unsigned int align)
+		struct resource *res, int target_node, unsigned int align,
+		unsigned long flags)
 {
 	struct dax_region *dax_region;
 
@@ -249,12 +297,17 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		return NULL;
 
 	dev_set_drvdata(parent, dax_region);
-	memcpy(&dax_region->res, res, sizeof(*res));
 	kref_init(&dax_region->kref);
 	dax_region->id = region_id;
 	dax_region->align = align;
 	dax_region->dev = parent;
 	dax_region->target_node = target_node;
+	dax_region->res = (struct resource) {
+		.start = res->start,
+		.end = res->end,
+		.flags = IORESOURCE_MEM | flags,
+	};
+
 	if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups)) {
 		kfree(dax_region);
 		return NULL;
@@ -267,6 +320,32 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 }
 EXPORT_SYMBOL_GPL(alloc_dax_region);
 
+static int alloc_dev_dax_range(struct dev_dax *dev_dax, resource_size_t size)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	struct resource *res = &dax_region->res;
+	struct device *dev = &dev_dax->dev;
+	struct resource *alloc;
+
+	device_lock_assert(dax_region->dev);
+
+	/* TODO: handle multiple allocations per region */
+	if (res->child)
+		return -ENOMEM;
+
+	alloc = __request_region(res, res->start, size, dev_name(dev), 0);
+
+	if (!alloc)
+		return -ENOMEM;
+
+	dev_dax->range = (struct range) {
+		.start = alloc->start,
+		.end = alloc->end,
+	};
+
+	return 0;
+}
+
 static ssize_t size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -361,6 +440,15 @@ void kill_dev_dax(struct dev_dax *dev_dax)
 }
 EXPORT_SYMBOL_GPL(kill_dev_dax);
 
+static void free_dev_dax_range(struct dev_dax *dev_dax)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	struct range *range = &dev_dax->range;
+
+	device_lock_assert(dax_region->dev);
+	__release_region(&dax_region->res, range->start, range_len(range));
+}
+
 static void dev_dax_release(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
@@ -385,6 +473,7 @@ static void unregister_dev_dax(void *dev)
 	dev_dbg(dev, "%s\n", __func__);
 
 	kill_dev_dax(dev_dax);
+	free_dev_dax_range(dev_dax);
 	device_del(dev);
 	put_device(dev);
 }
@@ -397,7 +486,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	struct dev_dax *dev_dax;
 	struct inode *inode;
 	struct device *dev;
-	int rc = -ENOMEM;
+	int rc;
 
 	if (data->id < 0)
 		return ERR_PTR(-EINVAL);
@@ -406,11 +495,25 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
 
+	dev_dax->region = dax_region;
+	dev = &dev_dax->dev;
+	device_initialize(dev);
+	dev_set_name(dev, "dax%d.%d", dax_region->id, data->id);
+
+	rc = alloc_dev_dax_range(dev_dax, data->size);
+	if (rc)
+		goto err_range;
+
 	if (data->pgmap) {
+		dev_WARN_ONCE(parent, !is_static(dax_region),
+			"custom dev_pagemap requires a static dax_region\n");
+
 		dev_dax->pgmap = kmemdup(data->pgmap,
 				sizeof(struct dev_pagemap), GFP_KERNEL);
-		if (!dev_dax->pgmap)
+		if (!dev_dax->pgmap) {
+			rc = -ENOMEM;
 			goto err_pgmap;
+		}
 	}
 
 	/*
@@ -427,12 +530,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	kill_dax(dax_dev);
 
 	/* from here on we're committed to teardown via dev_dax_release() */
-	dev = &dev_dax->dev;
-	device_initialize(dev);
-
 	dev_dax->dax_dev = dax_dev;
-	dev_dax->region = dax_region;
-	dev_dax->range = data->range;
 	dev_dax->target_node = dax_region->target_node;
 	kref_get(&dax_region->kref);
 
@@ -444,7 +542,6 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 		dev->class = dax_class;
 	dev->parent = parent;
 	dev->type = &dev_dax_type;
-	dev_set_name(dev, "dax%d.%d", dax_region->id, data->id);
 
 	rc = device_add(dev);
 	if (rc) {
@@ -458,9 +555,12 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 		return ERR_PTR(rc);
 
 	return dev_dax;
+
 err_alloc_dax:
 	kfree(dev_dax->pgmap);
 err_pgmap:
+	free_dev_dax_range(dev_dax);
+err_range:
 	kfree(dev_dax);
 
 	return ERR_PTR(rc);
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 4aeb36da83a4..44592a8cac0f 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -10,8 +10,11 @@ struct resource;
 struct dax_device;
 struct dax_region;
 void dax_region_put(struct dax_region *dax_region);
+
+#define IORESOURCE_DAX_STATIC (1UL << 0)
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, int target_node, unsigned int align);
+		struct resource *res, int target_node, unsigned int align,
+		unsigned long flags);
 
 enum dev_dax_subsys {
 	DEV_DAX_BUS = 0, /* zeroed dev_dax_data picks this by default */
@@ -22,7 +25,7 @@ struct dev_dax_data {
 	struct dax_region *dax_region;
 	struct dev_pagemap *pgmap;
 	enum dev_dax_subsys subsys;
-	struct range range;
+	resource_size_t size;
 	int id;
 };
 
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 12a2dbc43b40..99b1273bb232 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -22,7 +22,7 @@ void dax_bus_exit(void);
  * @kref: to pin while other agents have a need to do lookups
  * @dev: parent device backing this region
  * @align: allocation and mapping alignment for child dax devices
- * @res: physical address range of the region
+ * @res: resource tree to track instance allocations
  */
 struct dax_region {
 	int id;
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index af82d6ba820a..e7b64539e23e 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -20,17 +20,14 @@ static int dax_hmem_probe(struct platform_device *pdev)
 
 	mri = dev->platform_data;
 	dax_region = alloc_dax_region(dev, pdev->id, res, mri->target_node,
-			PMD_SIZE);
+			PMD_SIZE, 0);
 	if (!dax_region)
 		return -ENOMEM;
 
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
 		.id = 0,
-		.range = {
-			.start = res->start,
-			.end = res->end,
-		},
+		.size = resource_size(res),
 	};
 	dev_dax = devm_create_dev_dax(&data);
 	if (IS_ERR(dev_dax))
diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 4fa81d3d2f65..4fe700884338 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -54,7 +54,8 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	memcpy(&res, &pgmap.res, sizeof(res));
 	res.start += offset;
 	dax_region = alloc_dax_region(dev, region_id, &res,
-			nd_region->target_node, le32_to_cpu(pfn_sb->align));
+			nd_region->target_node, le32_to_cpu(pfn_sb->align),
+			IORESOURCE_DAX_STATIC);
 	if (!dax_region)
 		return ERR_PTR(-ENOMEM);
 
@@ -63,10 +64,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 		.id = id,
 		.pgmap = &pgmap,
 		.subsys = subsys,
-		.range = {
-			.start = res.start,
-			.end = res.end,
-		},
+		.size = resource_size(&res),
 	};
 	dev_dax = devm_create_dev_dax(&data);
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
