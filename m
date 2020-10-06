Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 007592846E1
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Oct 2020 09:13:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A7DC61562C585;
	Tue,  6 Oct 2020 00:13:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15A1C15623ADE
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 00:13:50 -0700 (PDT)
IronPort-SDR: 4BDzxiyp9l1XpYfP6redYlS/NCteXZ4tntPCd3SHf6xhjXSdbqgkGsoMmiOlWfmtQ4zOBs1LJt
 Fx5fshBm4FQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="181838873"
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400";
   d="scan'208";a="181838873"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:48 -0700
IronPort-SDR: iVr+lOXFIYI8iezRxO0JKzGPl9mWUMlR+IqNQ/5LbEINb99vNjGgOZZutNTmghX3HPg74AeQEV
 7sZsB7cihb8w==
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400";
   d="scan'208";a="353347707"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:48 -0700
Subject: [PATCH v6 06/11] device-dax: introduce 'seed' devices
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Mon, 05 Oct 2020 23:55:18 -0700
Message-ID: <160196731879.2166475.14771515281253454702.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: WN4VXGDJJIGB5PEWJLJOX5JNGTU3N67X
X-Message-ID-Hash: WN4VXGDJJIGB5PEWJLJOX5JNGTU3N67X
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Brice Goglin <Brice.Goglin@inria.fr>, Dave Hansen <dave.hansen@linux.intel.com>, david@redhat.com, Jia He <justin.he@arm.com>, joao.m.martins@oracle.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WN4VXGDJJIGB5PEWJLJOX5JNGTU3N67X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a seed device concept for dynamic dax regions to be able to split the
region amongst multiple sub-instances.  The seed device, similar to
libnvdimm seed devices, is a device that starts with zero capacity
allocated and unbound to a driver.  In contrast to libnvdimm seed devices
explicit 'create' and 'delete' interfaces are added to the region to
trigger seeds to be created and unused devices to be reclaimed.  The
explicit create and delete replaces implicit create as a side effect of
probe and implicit delete when writing 0 to the size that libnvdimm
implements.

Delete can be performed on any 0-sized and idle device.  This avoids the
gymnastics of needing to move device_unregister() to its own async
context.  Specifically, it avoids the deadlock of deleting a device via
one of its own attributes.  It is also less surprising to userspace which
never sees an extra device it did not request.

For now just add the device creation, teardown, and ->probe() prevention.
A later patch will arrange for the 'dax/size' attribute to be writable to
allocate capacity from the region.

Link: https://lkml.kernel.org/r/159643101583.4062302.12255093902950754962.stgit@dwillia2-desk3.amr.corp.intel.com
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
 drivers/dax/bus.c         |  301 +++++++++++++++++++++++++++++++++++++++------
 drivers/dax/dax-private.h |    9 +
 drivers/dax/hmem/hmem.c   |    2 
 3 files changed, 272 insertions(+), 40 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 9549f11ebed0..dce9413a4394 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -139,8 +139,26 @@ static int dax_bus_probe(struct device *dev)
 {
 	struct dax_device_driver *dax_drv = to_dax_drv(dev->driver);
 	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_region *dax_region = dev_dax->region;
+	struct range *range = &dev_dax->range;
+	int rc;
+
+	if (range_len(range) == 0 || dev_dax->id < 0)
+		return -ENXIO;
+
+	rc = dax_drv->probe(dev_dax);
+
+	if (rc || is_static(dax_region))
+		return rc;
+
+	/*
+	 * Track new seed creation only after successful probe of the
+	 * previous seed.
+	 */
+	if (dax_region->seed == dev)
+		dax_region->seed = NULL;
 
-	return dax_drv->probe(dev_dax);
+	return 0;
 }
 
 static int dax_bus_remove(struct device *dev)
@@ -237,14 +255,216 @@ static ssize_t available_size_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(available_size);
 
+static ssize_t seed_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+	struct device *seed;
+	ssize_t rc;
+
+	if (is_static(dax_region))
+		return -EINVAL;
+
+	device_lock(dev);
+	seed = dax_region->seed;
+	rc = sprintf(buf, "%s\n", seed ? dev_name(seed) : "");
+	device_unlock(dev);
+
+	return rc;
+}
+static DEVICE_ATTR_RO(seed);
+
+static ssize_t create_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+	struct device *youngest;
+	ssize_t rc;
+
+	if (is_static(dax_region))
+		return -EINVAL;
+
+	device_lock(dev);
+	youngest = dax_region->youngest;
+	rc = sprintf(buf, "%s\n", youngest ? dev_name(youngest) : "");
+	device_unlock(dev);
+
+	return rc;
+}
+
+static ssize_t create_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+	unsigned long long avail;
+	ssize_t rc;
+	int val;
+
+	if (is_static(dax_region))
+		return -EINVAL;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+	if (val != 1)
+		return -EINVAL;
+
+	device_lock(dev);
+	avail = dax_region_avail_size(dax_region);
+	if (avail == 0)
+		rc = -ENOSPC;
+	else {
+		struct dev_dax_data data = {
+			.dax_region = dax_region,
+			.size = 0,
+			.id = -1,
+		};
+		struct dev_dax *dev_dax = devm_create_dev_dax(&data);
+
+		if (IS_ERR(dev_dax))
+			rc = PTR_ERR(dev_dax);
+		else {
+			/*
+			 * In support of crafting multiple new devices
+			 * simultaneously multiple seeds can be created,
+			 * but only the first one that has not been
+			 * successfully bound is tracked as the region
+			 * seed.
+			 */
+			if (!dax_region->seed)
+				dax_region->seed = &dev_dax->dev;
+			dax_region->youngest = &dev_dax->dev;
+			rc = len;
+		}
+	}
+	device_unlock(dev);
+
+	return rc;
+}
+static DEVICE_ATTR_RW(create);
+
+void kill_dev_dax(struct dev_dax *dev_dax)
+{
+	struct dax_device *dax_dev = dev_dax->dax_dev;
+	struct inode *inode = dax_inode(dax_dev);
+
+	kill_dax(dax_dev);
+	unmap_mapping_range(inode->i_mapping, 0, 0, 1);
+}
+EXPORT_SYMBOL_GPL(kill_dev_dax);
+
+static void free_dev_dax_range(struct dev_dax *dev_dax)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	struct range *range = &dev_dax->range;
+
+	device_lock_assert(dax_region->dev);
+	if (range_len(range))
+		__release_region(&dax_region->res, range->start,
+				range_len(range));
+}
+
+static void unregister_dev_dax(void *dev)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	kill_dev_dax(dev_dax);
+	free_dev_dax_range(dev_dax);
+	device_del(dev);
+	put_device(dev);
+}
+
+/* a return value >= 0 indicates this invocation invalidated the id */
+static int __free_dev_dax_id(struct dev_dax *dev_dax)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	struct device *dev = &dev_dax->dev;
+	int rc = dev_dax->id;
+
+	device_lock_assert(dev);
+
+	if (is_static(dax_region) || dev_dax->id < 0)
+		return -1;
+	ida_free(&dax_region->ida, dev_dax->id);
+	dev_dax->id = -1;
+	return rc;
+}
+
+static int free_dev_dax_id(struct dev_dax *dev_dax)
+{
+	struct device *dev = &dev_dax->dev;
+	int rc;
+
+	device_lock(dev);
+	rc = __free_dev_dax_id(dev_dax);
+	device_unlock(dev);
+	return rc;
+}
+
+static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+	struct dev_dax *dev_dax;
+	struct device *victim;
+	bool do_del = false;
+	int rc;
+
+	if (is_static(dax_region))
+		return -EINVAL;
+
+	victim = device_find_child_by_name(dax_region->dev, buf);
+	if (!victim)
+		return -ENXIO;
+
+	device_lock(dev);
+	device_lock(victim);
+	dev_dax = to_dev_dax(victim);
+	if (victim->driver || range_len(&dev_dax->range))
+		rc = -EBUSY;
+	else {
+		/*
+		 * Invalidate the device so it does not become active
+		 * again, but always preserve device-id-0 so that
+		 * /sys/bus/dax/ is guaranteed to be populated while any
+		 * dax_region is registered.
+		 */
+		if (dev_dax->id > 0) {
+			do_del = __free_dev_dax_id(dev_dax) >= 0;
+			rc = len;
+			if (dax_region->seed == victim)
+				dax_region->seed = NULL;
+			if (dax_region->youngest == victim)
+				dax_region->youngest = NULL;
+		} else
+			rc = -EBUSY;
+	}
+	device_unlock(victim);
+
+	/* won the race to invalidate the device, clean it up */
+	if (do_del)
+		devm_release_action(dev, unregister_dev_dax, victim);
+	device_unlock(dev);
+	put_device(victim);
+
+	return rc;
+}
+static DEVICE_ATTR_WO(delete);
+
 static umode_t dax_region_visible(struct kobject *kobj, struct attribute *a,
 		int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct dax_region *dax_region = dev_get_drvdata(dev);
 
-	if (is_static(dax_region) && a == &dev_attr_available_size.attr)
-		return 0;
+	if (is_static(dax_region))
+		if (a == &dev_attr_available_size.attr
+				|| a == &dev_attr_create.attr
+				|| a == &dev_attr_seed.attr
+				|| a == &dev_attr_delete.attr)
+			return 0;
 	return a->mode;
 }
 
@@ -252,6 +472,9 @@ static struct attribute *dax_region_attributes[] = {
 	&dev_attr_available_size.attr,
 	&dev_attr_region_size.attr,
 	&dev_attr_align.attr,
+	&dev_attr_create.attr,
+	&dev_attr_seed.attr,
+	&dev_attr_delete.attr,
 	&dev_attr_id.attr,
 	NULL,
 };
@@ -320,6 +543,7 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 	dax_region->align = align;
 	dax_region->dev = parent;
 	dax_region->target_node = target_node;
+	ida_init(&dax_region->ida);
 	dax_region->res = (struct resource) {
 		.start = res->start,
 		.end = res->end,
@@ -347,6 +571,15 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, resource_size_t size)
 
 	device_lock_assert(dax_region->dev);
 
+	/* handle the seed alloc special case */
+	if (!size) {
+		dev_dax->range = (struct range) {
+			.start = res->start,
+			.end = res->start - 1,
+		};
+		return 0;
+	}
+
 	/* TODO: handle multiple allocations per region */
 	if (res->child)
 		return -ENOMEM;
@@ -448,33 +681,15 @@ static const struct attribute_group *dax_attribute_groups[] = {
 	NULL,
 };
 
-void kill_dev_dax(struct dev_dax *dev_dax)
-{
-	struct dax_device *dax_dev = dev_dax->dax_dev;
-	struct inode *inode = dax_inode(dax_dev);
-
-	kill_dax(dax_dev);
-	unmap_mapping_range(inode->i_mapping, 0, 0, 1);
-}
-EXPORT_SYMBOL_GPL(kill_dev_dax);
-
-static void free_dev_dax_range(struct dev_dax *dev_dax)
-{
-	struct dax_region *dax_region = dev_dax->region;
-	struct range *range = &dev_dax->range;
-
-	device_lock_assert(dax_region->dev);
-	__release_region(&dax_region->res, range->start, range_len(range));
-}
-
 static void dev_dax_release(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct dax_region *dax_region = dev_dax->region;
 	struct dax_device *dax_dev = dev_dax->dax_dev;
 
-	dax_region_put(dax_region);
 	put_dax(dax_dev);
+	free_dev_dax_id(dev_dax);
+	dax_region_put(dax_region);
 	kfree(dev_dax->pgmap);
 	kfree(dev_dax);
 }
@@ -484,18 +699,6 @@ static const struct device_type dev_dax_type = {
 	.groups = dax_attribute_groups,
 };
 
-static void unregister_dev_dax(void *dev)
-{
-	struct dev_dax *dev_dax = to_dev_dax(dev);
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	kill_dev_dax(dev_dax);
-	free_dev_dax_range(dev_dax);
-	device_del(dev);
-	put_device(dev);
-}
-
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 {
 	struct dax_region *dax_region = data->dax_region;
@@ -506,17 +709,35 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	struct device *dev;
 	int rc;
 
-	if (data->id < 0)
-		return ERR_PTR(-EINVAL);
-
 	dev_dax = kzalloc(sizeof(*dev_dax), GFP_KERNEL);
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
 
+	if (is_static(dax_region)) {
+		if (dev_WARN_ONCE(parent, data->id < 0,
+				"dynamic id specified to static region\n")) {
+			rc = -EINVAL;
+			goto err_id;
+		}
+
+		dev_dax->id = data->id;
+	} else {
+		if (dev_WARN_ONCE(parent, data->id >= 0,
+				"static id specified to dynamic region\n")) {
+			rc = -EINVAL;
+			goto err_id;
+		}
+
+		rc = ida_alloc(&dax_region->ida, GFP_KERNEL);
+		if (rc < 0)
+			goto err_id;
+		dev_dax->id = rc;
+	}
+
 	dev_dax->region = dax_region;
 	dev = &dev_dax->dev;
 	device_initialize(dev);
-	dev_set_name(dev, "dax%d.%d", dax_region->id, data->id);
+	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
 	rc = alloc_dev_dax_range(dev_dax, data->size);
 	if (rc)
@@ -579,6 +800,8 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 err_pgmap:
 	free_dev_dax_range(dev_dax);
 err_range:
+	free_dev_dax_id(dev_dax);
+err_id:
 	kfree(dev_dax);
 
 	return ERR_PTR(rc);
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 70f3f041800e..0cbb2ec81ca7 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -7,6 +7,7 @@
 
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/idr.h>
 
 /* private routines between core files */
 struct dax_device;
@@ -22,7 +23,10 @@ void dax_bus_exit(void);
  * @kref: to pin while other agents have a need to do lookups
  * @dev: parent device backing this region
  * @align: allocation and mapping alignment for child dax devices
+ * @ida: instance id allocator
  * @res: resource tree to track instance allocations
+ * @seed: allow userspace to find the first unbound seed device
+ * @youngest: allow userspace to find the most recently created device
  */
 struct dax_region {
 	int id;
@@ -30,7 +34,10 @@ struct dax_region {
 	struct kref kref;
 	struct device *dev;
 	unsigned int align;
+	struct ida ida;
 	struct resource res;
+	struct device *seed;
+	struct device *youngest;
 };
 
 /**
@@ -39,6 +46,7 @@ struct dax_region {
  * @region - parent region
  * @dax_dev - core dax functionality
  * @target_node: effective numa node if dev_dax memory range is onlined
+ * @id: ida allocated id
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @range: resource range for the instance
@@ -47,6 +55,7 @@ struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
 	int target_node;
+	int id;
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	struct range range;
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index e7b64539e23e..aa260009dfc7 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -26,7 +26,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
-		.id = 0,
+		.id = -1,
 		.size = resource_size(res),
 	};
 	dev_dax = devm_create_dev_dax(&data);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
