Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A208234FD9
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Aug 2020 05:42:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CECB212963204;
	Fri, 31 Jul 2020 20:42:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 259F812963205
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 20:42:32 -0700 (PDT)
IronPort-SDR: uIhZYr7VvEjJeACMi6vMpGym8MLiBF2aNuCmWwoV9jLclke6Oi+y/G/EHEQExYeBrjAs3EpLEv
 fqDNGTU0272A==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="153118192"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800";
   d="scan'208";a="153118192"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:42:31 -0700
IronPort-SDR: dUXqp8qomai8r/67wZTeriijLHrtH2KCliioset2nCaINAd06EfOjJV1ysZtilVYHZAybhXqX+
 TfJgKykN5Cig==
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800";
   d="scan'208";a="291466105"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:42:31 -0700
Subject: [PATCH v3 13/23] device-dax: Introduce 'seed' devices
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Fri, 31 Jul 2020 20:26:13 -0700
Message-ID: <159625237316.3040297.17183519752637060780.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: ZTNW7ESNC3ICJGUBFBJ6B42P6JKQO7SB
X-Message-ID-Hash: ZTNW7ESNC3ICJGUBFBJ6B42P6JKQO7SB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, joao.m.martins@oracle.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZTNW7ESNC3ICJGUBFBJ6B42P6JKQO7SB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a seed device concept for dynamic dax regions to be able to split
the region amongst multiple sub-instances. The seed device, similar to
libnvdimm seed devices, is a device that starts with zero capacity
allocated and unbound to a driver. In contrast to libnvdimm seed devices
explicit 'create' and 'delete' interfaces are added to the region to
trigger seeds to be created and unused devices to be reclaimed. The
explicit create and delete replaces implicit create as a side effect of
probe and implicit delete when writing 0 to the size that libnvdimm
implements.

Delete can be performed on any 0-sized and idle device.  This avoids the
gymnastics of needing to move device_unregister() to its own async
context.  Specifically, it avoids the deadlock of deleting a device via
one of its own attributes. It is also less surprising to userspace which
never sees an extra device it did not request.

For now just add the device creation, teardown, and ->probe()
prevention. A later patch will arrange for the 'dax/size' attribute to
be writable to allocate capacity from the region.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |  317 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/dax/bus.h         |    4 -
 drivers/dax/dax-private.h |    9 +
 drivers/dax/device.c      |   12 +-
 drivers/dax/hmem/hmem.c   |    2 
 drivers/dax/kmem.c        |   14 +-
 drivers/dax/pmem/compat.c |    2 
 7 files changed, 304 insertions(+), 56 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 0a48ce378686..dce9413a4394 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -135,10 +135,46 @@ static bool is_static(struct dax_region *dax_region)
 	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
 }
 
+static int dax_bus_probe(struct device *dev)
+{
+	struct dax_device_driver *dax_drv = to_dax_drv(dev->driver);
+	struct dev_dax *dev_dax = to_dev_dax(dev);
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
+
+	return 0;
+}
+
+static int dax_bus_remove(struct device *dev)
+{
+	struct dax_device_driver *dax_drv = to_dax_drv(dev->driver);
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return dax_drv->remove(dev_dax);
+}
+
 static struct bus_type dax_bus_type = {
 	.name = "dax",
 	.uevent = dax_bus_uevent,
 	.match = dax_bus_match,
+	.probe = dax_bus_probe,
+	.remove = dax_bus_remove,
 	.drv_groups = dax_drv_groups,
 };
 
@@ -219,14 +255,216 @@ static ssize_t available_size_show(struct device *dev,
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
 
@@ -234,6 +472,9 @@ static struct attribute *dax_region_attributes[] = {
 	&dev_attr_available_size.attr,
 	&dev_attr_region_size.attr,
 	&dev_attr_align.attr,
+	&dev_attr_create.attr,
+	&dev_attr_seed.attr,
+	&dev_attr_delete.attr,
 	&dev_attr_id.attr,
 	NULL,
 };
@@ -302,6 +543,7 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 	dax_region->align = align;
 	dax_region->dev = parent;
 	dax_region->target_node = target_node;
+	ida_init(&dax_region->ida);
 	dax_region->res = (struct resource) {
 		.start = res->start,
 		.end = res->end,
@@ -329,6 +571,15 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, resource_size_t size)
 
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
@@ -430,33 +681,15 @@ static const struct attribute_group *dax_attribute_groups[] = {
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
@@ -466,18 +699,6 @@ static const struct device_type dev_dax_type = {
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
@@ -488,17 +709,35 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
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
@@ -561,6 +800,8 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 err_pgmap:
 	free_dev_dax_range(dev_dax);
 err_range:
+	free_dev_dax_id(dev_dax);
+err_id:
 	kfree(dev_dax);
 
 	return ERR_PTR(rc);
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 44592a8cac0f..da27ea70a19a 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -38,6 +38,8 @@ struct dax_device_driver {
 	struct device_driver drv;
 	struct list_head ids;
 	int match_always;
+	int (*probe)(struct dev_dax *dev);
+	int (*remove)(struct dev_dax *dev);
 };
 
 int __dax_driver_register(struct dax_device_driver *dax_drv,
@@ -48,7 +50,7 @@ void dax_driver_unregister(struct dax_device_driver *dax_drv);
 void kill_dev_dax(struct dev_dax *dev_dax);
 
 #if IS_ENABLED(CONFIG_DEV_DAX_PMEM_COMPAT)
-int dev_dax_probe(struct device *dev);
+int dev_dax_probe(struct dev_dax *dev_dax);
 #endif
 
 /*
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 99b1273bb232..b81a1494d82b 100644
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
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index a86b2c9788c5..5496331f6eb6 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -392,11 +392,11 @@ static void dev_dax_kill(void *dev_dax)
 	kill_dev_dax(dev_dax);
 }
 
-int dev_dax_probe(struct device *dev)
+int dev_dax_probe(struct dev_dax *dev_dax)
 {
-	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct dax_device *dax_dev = dev_dax->dax_dev;
 	struct range *range = &dev_dax->range;
+	struct device *dev = &dev_dax->dev;
 	struct dev_pagemap *pgmap;
 	struct inode *inode;
 	struct cdev *cdev;
@@ -446,17 +446,15 @@ int dev_dax_probe(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_dax_probe);
 
-static int dev_dax_remove(struct device *dev)
+static int dev_dax_remove(struct dev_dax *dev_dax)
 {
 	/* all probe actions are unwound by devm */
 	return 0;
 }
 
 static struct dax_device_driver device_dax_driver = {
-	.drv = {
-		.probe = dev_dax_probe,
-		.remove = dev_dax_remove,
-	},
+	.probe = dev_dax_probe,
+	.remove = dev_dax_remove,
 	.match_always = 1,
 };
 
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
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 77e25361fbeb..b1be8a53b26a 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -30,11 +30,11 @@ static struct range dax_kmem_range(struct dev_dax *dev_dax)
 	return range;
 }
 
-int dev_dax_kmem_probe(struct device *dev)
+int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
-	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct range range = dax_kmem_range(dev_dax);
 	int numa_node = dev_dax->target_node;
+	struct device *dev = &dev_dax->dev;
 	struct resource *res;
 	char *res_name;
 	int rc;
@@ -127,17 +127,15 @@ static void dax_kmem_release(struct dev_dax *dev_dax)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-static int dev_dax_kmem_remove(struct device *dev)
+static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
-	dax_kmem_release(to_dev_dax(dev));
+	dax_kmem_release(dev_dax);
 	return 0;
 }
 
 static struct dax_device_driver device_dax_kmem_driver = {
-	.drv = {
-		.probe = dev_dax_kmem_probe,
-		.remove = dev_dax_kmem_remove,
-	},
+	.probe = dev_dax_kmem_probe,
+	.remove = dev_dax_kmem_remove,
 };
 
 static int __init dax_kmem_init(void)
diff --git a/drivers/dax/pmem/compat.c b/drivers/dax/pmem/compat.c
index d7b15e6f30c5..863c114fd88c 100644
--- a/drivers/dax/pmem/compat.c
+++ b/drivers/dax/pmem/compat.c
@@ -22,7 +22,7 @@ static int dax_pmem_compat_probe(struct device *dev)
 		return -ENOMEM;
 
 	device_lock(&dev_dax->dev);
-	rc = dev_dax_probe(&dev_dax->dev);
+	rc = dev_dax_probe(dev_dax);
 	device_unlock(&dev_dax->dev);
 
 	devres_close_group(&dev_dax->dev, dev_dax);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
