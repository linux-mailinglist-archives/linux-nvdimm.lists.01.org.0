Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E08919027E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 01:11:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F36410FC38A0;
	Mon, 23 Mar 2020 17:12:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2B94710097DE7
	for <linux-nvdimm@lists.01.org>; Mon, 23 Mar 2020 17:12:38 -0700 (PDT)
IronPort-SDR: B4cjb1uHg8VaUztWa2nIdkoM4LcmTZXDwKZ5Lg4gY7mVY3lqZ7aDIyf5hD8Ytsfam/fKDYQ1Ch
 hI+Gr0x2xHiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:11:47 -0700
IronPort-SDR: MPtOzZQ8O+DTJvhlxtI2NGD9SAPSdmJiGoUYjEsARfhJniew7lk8sJ1FqtGKtZNWSXtHrp2SGp
 KQ+onD5VBDuA==
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200";
   d="scan'208";a="446014887"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:11:47 -0700
Subject: [PATCH 12/12] device-dax: Introduce 'mapping' devices
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Mon, 23 Mar 2020 16:55:40 -0700
Message-ID: <158500774067.2088294.1260962550701501447.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: YUTEJHT3XVVJY62V5TLMNNOTOXZIHSPO
X-Message-ID-Hash: YUTEJHT3XVVJY62V5TLMNNOTOXZIHSPO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dave.hansen@linux.intel.com, hch@lst.de, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YUTEJHT3XVVJY62V5TLMNNOTOXZIHSPO/>
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

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |  190 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dax/dax-private.h |   14 +++
 2 files changed, 202 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 07aeb8fa9ee8..645449a079bd 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -558,6 +558,167 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
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
+	if (mapping->range_id < 1) {
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
 static int __alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		resource_size_t size)
 {
@@ -567,7 +728,7 @@ static int __alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 	struct dev_dax_range *ranges;
 	unsigned long pgoff = 0;
 	struct resource *alloc;
-	int i;
+	int i, rc;
 
 	device_lock_assert(dax_region->dev);
 
@@ -602,6 +763,21 @@ static int __alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		},
 	};
 
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
+		dev_dax->nr_range--;
+		__release_region(res, alloc->start, resource_size(alloc));
+		return rc;
+	}
+
 	return 0;
 }
 
@@ -679,11 +855,14 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 
 	for (i = dev_dax->nr_range - 1; i >= 0; i--) {
 		struct range *range = &dev_dax->ranges[i].range;
+		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
 		struct resource *adjust = NULL, *res;
 		resource_size_t shrink;
 
 		shrink = min(to_shrink, range_len(range));
 		if (shrink >= range_len(range)) {
+			devm_release_action(dax_region->dev,
+					unregister_dax_mapping, &mapping->dev);
 			__release_region(&dax_region->res, range->start,
 					range_len(range));
 			dev_dax->nr_range--;
@@ -1007,9 +1186,9 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	/* a device_dax instance is dead while the driver is not attached */
 	kill_dax(dax_dev);
 
-	/* from here on we're committed to teardown via dev_dax_release() */
 	dev_dax->dax_dev = dax_dev;
 	dev_dax->target_node = dax_region->target_node;
+	ida_init(&dev_dax->ida);
 	kref_get(&dax_region->kref);
 
 	inode = dax_inode(dax_dev);
@@ -1032,6 +1211,13 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
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
index d6aea3eaea43..23f113e99c92 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -38,6 +38,12 @@ struct dax_region {
 	struct resource res;
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
@@ -45,6 +51,7 @@ struct dax_region {
  * @dax_dev - core dax functionality
  * @target_node: effective numa node if dev_dax memory range is onlined
  * @id: ida allocated id
+ * @ida: mapping id allocator
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @nr_range: size of @ranges
@@ -55,12 +62,14 @@ struct dev_dax {
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
 
@@ -68,4 +77,9 @@ static inline struct dev_dax *to_dev_dax(struct device *dev)
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
