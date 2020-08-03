Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E5F239ED4
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 07:20:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4438312A6D4C4;
	Sun,  2 Aug 2020 22:20:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 520FB12A6D4C4
	for <linux-nvdimm@lists.01.org>; Sun,  2 Aug 2020 22:20:05 -0700 (PDT)
IronPort-SDR: zRo2KB1lJ8t960/A/jnorOXgBzuto/r0FDGvtcLKwT8oD4Ow56JxvruP1O9y/6h+ThpprGL5g+
 WJ/I7/6X1IHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="149487742"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="149487742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:20:04 -0700
IronPort-SDR: Mp44Hrw3P27DFOgWm9XqgZQR4MNBmOLMHSVWxvD2ORT0VnFnPNBO48VKd5oDRQMxIUkWSVTtHA
 xUvsPaF4oUEw==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="395938380"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:20:04 -0700
Subject: [PATCH v4 15/23] device-dax: Add resize support
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Sun, 02 Aug 2020 22:03:46 -0700
Message-ID: <159643102625.4062302.7431838945566033852.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 4JTXVRTPBNYX433WTQBEHOTDXOZJB7II
X-Message-ID-Hash: 4JTXVRTPBNYX433WTQBEHOTDXOZJB7II
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, joao.m.martins@oracle.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4JTXVRTPBNYX433WTQBEHOTDXOZJB7II/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Make the device-dax 'size' attribute writable to allow capacity to be
split between multiple instances in a region. The intended consumers of
this capability are users that want to split a scarce memory resource
between device-dax and System-RAM access, or users that want to have
multiple security domains for a large region.

By default the hmem instance provider allocates an entire region to the
first instance. The process of creating a new instance (assuming a
region-id of 0) is find the region and trigger the 'create' attribute
which yields an empty instance to configure. For example:

    cd /sys/bus/dax/devices
    echo dax0.0 > dax0.0/driver/unbind
    echo $new_size > dax0.0/size
    echo 1 > $(readlink -f dax0.0)../dax_region/create
    seed=$(cat $(readlink -f dax0.0)../dax_region/seed)
    echo $new_size > $seed/size
    echo dax0.0 > ../drivers/{device_dax,kmem}/bind
    echo dax0.1 > ../drivers/{device_dax,kmem}/bind

Instances can be destroyed by:

    echo $device > $(readlink -f $device)../dax_region/delete

Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c |  161 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 152 insertions(+), 9 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index dce9413a4394..53d07f2f1285 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -6,6 +6,7 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/dax.h>
+#include <linux/io.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -562,7 +563,8 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 }
 EXPORT_SYMBOL_GPL(alloc_dax_region);
 
-static int alloc_dev_dax_range(struct dev_dax *dev_dax, resource_size_t size)
+static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
+		resource_size_t size)
 {
 	struct dax_region *dax_region = dev_dax->region;
 	struct resource *res = &dax_region->res;
@@ -580,12 +582,7 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, resource_size_t size)
 		return 0;
 	}
 
-	/* TODO: handle multiple allocations per region */
-	if (res->child)
-		return -ENOMEM;
-
-	alloc = __request_region(res, res->start, size, dev_name(dev), 0);
-
+	alloc = __request_region(res, start, size, dev_name(dev), 0);
 	if (!alloc)
 		return -ENOMEM;
 
@@ -597,6 +594,29 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, resource_size_t size)
 	return 0;
 }
 
+static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, resource_size_t size)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	struct range *range = &dev_dax->range;
+	int rc = 0;
+
+	device_lock_assert(dax_region->dev);
+
+	if (size)
+		rc = adjust_resource(res, range->start, size);
+	else
+		__release_region(&dax_region->res, range->start, range_len(range));
+	if (rc)
+		return rc;
+
+	dev_dax->range = (struct range) {
+		.start = range->start,
+		.end = range->start + size - 1,
+	};
+
+	return 0;
+}
+
 static ssize_t size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -605,7 +625,127 @@ static ssize_t size_show(struct device *dev,
 
 	return sprintf(buf, "%llu\n", size);
 }
-static DEVICE_ATTR_RO(size);
+
+static bool alloc_is_aligned(struct dax_region *dax_region,
+		resource_size_t size)
+{
+	/*
+	 * The minimum mapping granularity for a device instance is a
+	 * single subsection, unless the arch says otherwise.
+	 */
+	return IS_ALIGNED(size, max_t(unsigned long, dax_region->align,
+				memremap_compat_align()));
+}
+
+static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	struct range *range = &dev_dax->range;
+	struct resource *res, *adjust = NULL;
+	struct device *dev = &dev_dax->dev;
+
+	for_each_dax_region_resource(dax_region, res)
+		if (strcmp(res->name, dev_name(dev)) == 0
+				&& res->start == range->start) {
+			adjust = res;
+			break;
+		}
+
+	if (dev_WARN_ONCE(dev, !adjust, "failed to find matching resource\n"))
+		return -ENXIO;
+	return adjust_dev_dax_range(dev_dax, adjust, size);
+}
+
+static ssize_t dev_dax_resize(struct dax_region *dax_region,
+		struct dev_dax *dev_dax, resource_size_t size)
+{
+	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
+	resource_size_t dev_size = range_len(&dev_dax->range);
+	struct resource *region_res = &dax_region->res;
+	struct device *dev = &dev_dax->dev;
+	const char *name = dev_name(dev);
+	struct resource *res, *first;
+
+	if (dev->driver)
+		return -EBUSY;
+	if (size == dev_size)
+		return 0;
+	if (size > dev_size && size - dev_size > avail)
+		return -ENOSPC;
+	if (size < dev_size)
+		return dev_dax_shrink(dev_dax, size);
+
+	to_alloc = size - dev_size;
+	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dax_region, to_alloc),
+			"resize of %pa misaligned\n", &to_alloc))
+		return -ENXIO;
+
+	/*
+	 * Expand the device into the unused portion of the region. This
+	 * may involve adjusting the end of an existing resource, or
+	 * allocating a new resource.
+	 */
+	first = region_res->child;
+	if (!first)
+		return alloc_dev_dax_range(dev_dax, dax_region->res.start, to_alloc);
+	for (res = first; to_alloc && res; res = res->sibling) {
+		struct resource *next = res->sibling;
+		resource_size_t free;
+
+		/* space at the beginning of the region */
+		free = 0;
+		if (res == first && res->start > dax_region->res.start)
+			free = res->start - dax_region->res.start;
+		if (free >= to_alloc && dev_size == 0)
+			return alloc_dev_dax_range(dev_dax, dax_region->res.start, to_alloc);
+
+		free = 0;
+		/* space between allocations */
+		if (next && next->start > res->end + 1)
+			free = next->start - res->end + 1;
+
+		/* space at the end of the region */
+		if (free < to_alloc && !next && res->end < region_res->end)
+			free = region_res->end - res->end;
+
+		if (free >= to_alloc && strcmp(name, res->name) == 0)
+			return adjust_dev_dax_range(dev_dax, res, resource_size(res) + to_alloc);
+		else if (free >= to_alloc && dev_size == 0)
+			return alloc_dev_dax_range(dev_dax, res->end + 1, to_alloc);
+	}
+	return -ENOSPC;
+}
+
+static ssize_t size_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	ssize_t rc;
+	unsigned long long val;
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_region *dax_region = dev_dax->region;
+
+	rc = kstrtoull(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	if (!alloc_is_aligned(dax_region, val)) {
+		dev_dbg(dev, "%s: size: %lld misaligned\n", __func__, val);
+		return -EINVAL;
+	}
+
+	device_lock(dax_region->dev);
+	if (!dax_region->dev->driver) {
+		device_unlock(dax_region->dev);
+		return -ENXIO;
+	}
+	device_lock(dev);
+	rc = dev_dax_resize(dax_region, dev_dax, val);
+	device_unlock(dev);
+	device_unlock(dax_region->dev);
+
+	return rc == 0 ? len : rc;
+}
+static DEVICE_ATTR_RW(size);
 
 static int dev_dax_target_node(struct dev_dax *dev_dax)
 {
@@ -654,11 +794,14 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_region *dax_region = dev_dax->region;
 
 	if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)
 		return 0;
 	if (a == &dev_attr_numa_node.attr && !IS_ENABLED(CONFIG_NUMA))
 		return 0;
+	if (a == &dev_attr_size.attr && is_static(dax_region))
+		return 0444;
 	return a->mode;
 }
 
@@ -739,7 +882,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
-	rc = alloc_dev_dax_range(dev_dax, data->size);
+	rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, data->size);
 	if (rc)
 		goto err_range;
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
