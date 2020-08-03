Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37109239EDB
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 07:20:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E0C1812A6D4D0;
	Sun,  2 Aug 2020 22:20:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 552D812A6D4C7
	for <linux-nvdimm@lists.01.org>; Sun,  2 Aug 2020 22:20:27 -0700 (PDT)
IronPort-SDR: pJehu77oeJrQATt1Rsy0QSqmqJoEZLZRBR4Wy+9UmaCySIIb4sqX2+aRta2F9VJdwdZXpJJZ1i
 xjcq8O6GKJag==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="132105651"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="132105651"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:20:26 -0700
IronPort-SDR: OW/hfNQQmkuv1890hUzQP7RPQRDXZ1qCXuopl9uGnI5vPSk71ZEaa72jZtoNFZwGWTRmrgQoWa
 1ECrJ/yCK/Mg==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="491698264"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:20:26 -0700
Subject: [PATCH v4 19/23] device-dax: Introduce 'mapping' devices
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Sun, 02 Aug 2020 22:04:08 -0700
Message-ID: <159643104819.4062302.13691281391423291589.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: NMGSNRS6DU54BXNFRQ6WXJJDIM4EWMK7
X-Message-ID-Hash: NMGSNRS6DU54BXNFRQ6WXJJDIM4EWMK7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, joao.m.martins@oracle.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NMGSNRS6DU54BXNFRQ6WXJJDIM4EWMK7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In support of interrogating the physical address layout of a device with
dis-contiguous ranges, introduce a sysfs directory with 'start', 'end',
and 'page_offset' attributes. The alternative is trying to parse
/proc/iomem, and that file will not reflect the extent layout until the
device is enabled.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |  191 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dax/dax-private.h |   14 +++
 2 files changed, 203 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 8dd82ea9d53d..2779c65dc7c0 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -579,6 +579,167 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 }
 EXPORT_SYMBOL_GPL(alloc_dax_region);
 
+static void dax_mapping_release(struct device *dev)
+{
+	struct dax_mapping *mapping = to_dax_mapping(dev);
+	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
+
+	ida_free(&dev_dax->ida, mapping->id);
+	kfree(mapping);
+}
+
+static void unregister_dax_mapping(void *data)
+{
+	struct device *dev = data;
+	struct dax_mapping *mapping = to_dax_mapping(dev);
+	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
+	struct dax_region *dax_region = dev_dax->region;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	device_lock_assert(dax_region->dev);
+
+	dev_dax->ranges[mapping->range_id].mapping = NULL;
+	mapping->range_id = -1;
+
+	device_del(dev);
+	put_device(dev);
+}
+
+static struct dev_dax_range *get_dax_range(struct device *dev)
+{
+	struct dax_mapping *mapping = to_dax_mapping(dev);
+	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
+	struct dax_region *dax_region = dev_dax->region;
+
+	device_lock(dax_region->dev);
+	if (mapping->range_id < 0) {
+		device_unlock(dax_region->dev);
+		return NULL;
+	}
+
+	return &dev_dax->ranges[mapping->range_id];
+}
+
+static void put_dax_range(struct dev_dax_range *dax_range)
+{
+	struct dax_mapping *mapping = dax_range->mapping;
+	struct dev_dax *dev_dax = to_dev_dax(mapping->dev.parent);
+	struct dax_region *dax_region = dev_dax->region;
+
+	device_unlock(dax_region->dev);
+}
+
+static ssize_t start_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dev_dax_range *dax_range;
+	ssize_t rc;
+
+	dax_range = get_dax_range(dev);
+	if (!dax_range)
+		return -ENXIO;
+	rc = sprintf(buf, "%#llx\n", dax_range->range.start);
+	put_dax_range(dax_range);
+
+	return rc;
+}
+static DEVICE_ATTR(start, 0400, start_show, NULL);
+
+static ssize_t end_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dev_dax_range *dax_range;
+	ssize_t rc;
+
+	dax_range = get_dax_range(dev);
+	if (!dax_range)
+		return -ENXIO;
+	rc = sprintf(buf, "%#llx\n", dax_range->range.end);
+	put_dax_range(dax_range);
+
+	return rc;
+}
+static DEVICE_ATTR(end, 0400, end_show, NULL);
+
+static ssize_t pgoff_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dev_dax_range *dax_range;
+	ssize_t rc;
+
+	dax_range = get_dax_range(dev);
+	if (!dax_range)
+		return -ENXIO;
+	rc = sprintf(buf, "%#lx\n", dax_range->pgoff);
+	put_dax_range(dax_range);
+
+	return rc;
+}
+static DEVICE_ATTR(page_offset, 0400, pgoff_show, NULL);
+
+static struct attribute *dax_mapping_attributes[] = {
+	&dev_attr_start.attr,
+	&dev_attr_end.attr,
+	&dev_attr_page_offset.attr,
+	NULL,
+};
+
+static const struct attribute_group dax_mapping_attribute_group = {
+	.attrs = dax_mapping_attributes,
+};
+
+static const struct attribute_group *dax_mapping_attribute_groups[] = {
+	&dax_mapping_attribute_group,
+	NULL,
+};
+
+static struct device_type dax_mapping_type = {
+	.release = dax_mapping_release,
+	.groups = dax_mapping_attribute_groups,
+};
+
+static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	struct dax_mapping *mapping;
+	struct device *dev;
+	int rc;
+
+	device_lock_assert(dax_region->dev);
+
+	if (dev_WARN_ONCE(&dev_dax->dev, !dax_region->dev->driver,
+				"region disabled\n"))
+		return -ENXIO;
+
+	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
+	if (!mapping)
+		return -ENOMEM;
+	mapping->range_id = range_id;
+	mapping->id = ida_alloc(&dev_dax->ida, GFP_KERNEL);
+	if (mapping->id < 0) {
+		kfree(mapping);
+		return -ENOMEM;
+	}
+	dev_dax->ranges[range_id].mapping = mapping;
+	dev = &mapping->dev;
+	device_initialize(dev);
+	dev->parent = &dev_dax->dev;
+	dev->type = &dax_mapping_type;
+	dev_set_name(dev, "mapping%d", mapping->id);
+	rc = device_add(dev);
+	if (rc) {
+		put_device(dev);
+		return rc;
+	}
+
+	rc = devm_add_action_or_reset(dax_region->dev, unregister_dax_mapping,
+			dev);
+	if (rc)
+		return rc;
+	return 0;
+}
+
 static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		resource_size_t size)
 {
@@ -588,7 +749,7 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 	struct dev_dax_range *ranges;
 	unsigned long pgoff = 0;
 	struct resource *alloc;
-	int i;
+	int i, rc;
 
 	device_lock_assert(dax_region->dev);
 
@@ -630,6 +791,22 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 
 	dev_dbg(dev, "alloc range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
 			&alloc->start, &alloc->end);
+	/*
+	 * A dev_dax instance must be registered before mapping device
+	 * children can be added. Defer to devm_create_dev_dax() to add
+	 * the initial mapping device.
+	 */
+	if (!device_is_registered(&dev_dax->dev))
+		return 0;
+
+	rc = devm_register_dax_mapping(dev_dax, dev_dax->nr_range - 1);
+	if (rc) {
+		dev_dbg(dev, "delete range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
+				&alloc->start, &alloc->end);
+		dev_dax->nr_range--;
+		__release_region(res, alloc->start, resource_size(alloc));
+		return rc;
+	}
 
 	return 0;
 }
@@ -698,11 +875,14 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 
 	for (i = dev_dax->nr_range - 1; i >= 0; i--) {
 		struct range *range = &dev_dax->ranges[i].range;
+		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
 		struct resource *adjust = NULL, *res;
 		resource_size_t shrink;
 
 		shrink = min_t(u64, to_shrink, range_len(range));
 		if (shrink >= range_len(range)) {
+			devm_release_action(dax_region->dev,
+					unregister_dax_mapping, &mapping->dev);
 			__release_region(&dax_region->res, range->start,
 					range_len(range));
 			dev_dax->nr_range--;
@@ -1033,9 +1213,9 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	/* a device_dax instance is dead while the driver is not attached */
 	kill_dax(dax_dev);
 
-	/* from here on we're committed to teardown via dev_dax_release() */
 	dev_dax->dax_dev = dax_dev;
 	dev_dax->target_node = dax_region->target_node;
+	ida_init(&dev_dax->ida);
 	kref_get(&dax_region->kref);
 
 	inode = dax_inode(dax_dev);
@@ -1058,6 +1238,13 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	if (rc)
 		return ERR_PTR(rc);
 
+	/* register mapping device for the initial allocation range */
+	if (dev_dax->nr_range && range_len(&dev_dax->ranges[0].range)) {
+		rc = devm_register_dax_mapping(dev_dax, 0);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
 	return dev_dax;
 
 err_alloc_dax:
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index f863287107fd..13780f62b95e 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -40,6 +40,12 @@ struct dax_region {
 	struct device *youngest;
 };
 
+struct dax_mapping {
+	struct device dev;
+	int range_id;
+	int id;
+};
+
 /**
  * struct dev_dax - instance data for a subdivision of a dax region, and
  * data while the device is activated in the driver.
@@ -47,6 +53,7 @@ struct dax_region {
  * @dax_dev - core dax functionality
  * @target_node: effective numa node if dev_dax memory range is onlined
  * @id: ida allocated id
+ * @ida: mapping id allocator
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @nr_range: size of @ranges
@@ -57,12 +64,14 @@ struct dev_dax {
 	struct dax_device *dax_dev;
 	int target_node;
 	int id;
+	struct ida ida;
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	int nr_range;
 	struct dev_dax_range {
 		unsigned long pgoff;
 		struct range range;
+		struct dax_mapping *mapping;
 	} *ranges;
 };
 
@@ -70,4 +79,9 @@ static inline struct dev_dax *to_dev_dax(struct device *dev)
 {
 	return container_of(dev, struct dev_dax, dev);
 }
+
+static inline struct dax_mapping *to_dax_mapping(struct device *dev)
+{
+	return container_of(dev, struct dax_mapping, dev);
+}
 #endif
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
