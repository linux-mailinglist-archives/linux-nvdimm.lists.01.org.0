Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3B190276
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 01:11:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C16E10FC388A;
	Mon, 23 Mar 2020 17:11:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7706510FC388A
	for <linux-nvdimm@lists.01.org>; Mon, 23 Mar 2020 17:11:53 -0700 (PDT)
IronPort-SDR: Kc9uonLJhSPiRh5X9/c86mB7QIXjmf9zKVIm4bNQ/3Uz3gdfDtofb1kyvVk9eBrHl7nykeAno1
 qHNxNiwO8q2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:11:02 -0700
IronPort-SDR: o7Q8jiHtwpNBIgs6DkiSX7vQ6yTPDOWz5sCBFIqFRyOToLtJ+htwlqGuSn/6rLEn1lW073F0dk
 E9Xol9yACspQ==
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200";
   d="scan'208";a="238050189"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:11:01 -0700
Subject: [PATCH 04/12] device-dax: Kill dax_kmem_res
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Mon, 23 Mar 2020 16:54:54 -0700
Message-ID: <158500769438.2088294.11339134986537700302.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: G4T6OTGKIZ23EJGNKGPUHWHSPZYP7AKK
X-Message-ID-Hash: G4T6OTGKIZ23EJGNKGPUHWHSPZYP7AKK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, hch@lst.de, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G4T6OTGKIZ23EJGNKGPUHWHSPZYP7AKK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Several related issues around this unneeded attribute:

- The dax_kmem_res property allows the kmem driver to stash the adjusted
  resource range that was used for the hotplug operation, but that can be
  recalculated from the original base range.

- kmem is using an open coded release_resource() + kfree() when an
  idiomatic release_mem_region() is sufficient.

- The driver managed resource need only manage the busy flag. Other flags
  are of no concern to the kmem driver. In fact if kmem inherits some
  memory range that add_memory() rejects that is a memory-hotplug-core
  policy that the driver is in no position to override.

- The implementation trusts that failed remove_memory() results in the
  entire resource range remaining pinned busy. The driver need not make
  that layering violation assumption and just maintain the busy state in
  its local resource.

- The "Hot-remove not yet implemented." comment is stale as of commit
  9f960da72b25 ("device-dax: "Hotremove" persistent memory that is used
  like normal RAM")

Cc: David Hildenbrand <david@redhat.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/dax-private.h |    2 -
 drivers/dax/kmem.c        |  104 +++++++++++++++++++--------------------------
 2 files changed, 43 insertions(+), 63 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 22d43095559a..12a2dbc43b40 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -42,7 +42,6 @@ struct dax_region {
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @range: resource range for the instance
- * @dax_mem_res: physical address range of hotadded DAX memory
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -51,7 +50,6 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	struct range range;
-	struct resource *dax_kmem_res;
 };
 
 static inline u64 range_len(struct range *range)
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 111e4c06ff49..2bb7fa0951ef 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -14,15 +14,23 @@
 #include "dax-private.h"
 #include "bus.h"
 
+static struct range dax_kmem_range(struct dev_dax *dev_dax)
+{
+	struct range range;
+
+	/* memory-block align the hotplug range */
+	range.start = ALIGN(dev_dax->range.start, memory_block_size_bytes());
+	range.end = ALIGN_DOWN(dev_dax->range.end + 1,
+			memory_block_size_bytes()) - 1;
+	return range;
+}
+
 int dev_dax_kmem_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
-	struct range *range = &dev_dax->range;
-	resource_size_t kmem_start;
-	resource_size_t kmem_size;
-	resource_size_t kmem_end;
-	struct resource *new_res;
-	int numa_node;
+	struct range range = dax_kmem_range(dev_dax);
+	int numa_node = dev_dax->target_node;
+	struct resource *res;
 	int rc;
 
 	/*
@@ -31,95 +39,69 @@ int dev_dax_kmem_probe(struct device *dev)
 	 * could be mixed in a node with faster memory, causing
 	 * unavoidable performance issues.
 	 */
-	numa_node = dev_dax->target_node;
 	if (numa_node < 0) {
 		dev_warn(dev, "rejecting DAX region with invalid node: %d\n",
 				numa_node);
 		return -EINVAL;
 	}
 
-	/* Hotplug starting at the beginning of the next block: */
-	kmem_start = ALIGN(range->start, memory_block_size_bytes());
-
-	kmem_size = range_len(range);
-	/* Adjust the size down to compensate for moving up kmem_start: */
-	kmem_size -= kmem_start - range->start;
-	/* Align the size down to cover only complete blocks: */
-	kmem_size &= ~(memory_block_size_bytes() - 1);
-	kmem_end = kmem_start + kmem_size;
-
-	/* Region is permanently reserved.  Hot-remove not yet implemented. */
-	new_res = request_mem_region(kmem_start, kmem_size, dev_name(dev));
-	if (!new_res) {
-		dev_warn(dev, "could not reserve region [%pa-%pa]\n",
-			 &kmem_start, &kmem_end);
+	res = request_mem_region(range.start, range_len(&range), dev_name(dev));
+	if (!res) {
+		dev_warn(dev, "could not reserve region [%#llx-%#llx]\n",
+				range.start, range.end);
 		return -EBUSY;
 	}
 
-	/*
-	 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
-	 * so that add_memory() can add a child resource.  Do not
-	 * inherit flags from the parent since it may set new flags
-	 * unknown to us that will break add_memory() below.
-	 */
-	new_res->flags = IORESOURCE_SYSTEM_RAM;
-	new_res->name = dev_name(dev);
-
-	rc = add_memory(numa_node, new_res->start, resource_size(new_res));
+	/* Temporarily clear busy to allow add_memory() to claim it */
+	res->flags &= ~IORESOURCE_BUSY;
+	rc = add_memory(numa_node, range.start, range_len(&range));
+	res->flags |= IORESOURCE_BUSY;
 	if (rc) {
-		release_resource(new_res);
-		kfree(new_res);
+		release_mem_region(range.start, range_len(&range));
 		return rc;
 	}
-	dev_dax->dax_kmem_res = new_res;
 
 	return 0;
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-static int dev_dax_kmem_remove(struct device *dev)
+static void dax_kmem_release(struct dev_dax *dev_dax)
 {
-	struct dev_dax *dev_dax = to_dev_dax(dev);
-	struct resource *res = dev_dax->dax_kmem_res;
-	resource_size_t kmem_start = res->start;
-	resource_size_t kmem_size = resource_size(res);
+	struct range range = dax_kmem_range(dev_dax);
 	int rc;
 
 	/*
 	 * We have one shot for removing memory, if some memory blocks were not
 	 * offline prior to calling this function remove_memory() will fail, and
 	 * there is no way to hotremove this memory until reboot because device
-	 * unbind will succeed even if we return failure.
+	 * unbind will proceed regardless of the remove_memory result.
 	 */
-	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
-	if (rc) {
-		dev_err(dev,
-			"DAX region %pR cannot be hotremoved until the next reboot\n",
-			res);
-		return rc;
+	rc = remove_memory(dev_dax->target_node, range.start, range_len(&range));
+	if (rc == 0) {
+		release_mem_region(range.start, range_len(&range));
+		return;
 	}
-
-	/* Release and free dax resources */
-	release_resource(res);
-	kfree(res);
-	dev_dax->dax_kmem_res = NULL;
-
-	return 0;
+	dev_err(&dev_dax->dev, "%#llx-%#llx cannot be hotremoved until the next reboot\n",
+			range.start, range.end);
 }
 #else
-static int dev_dax_kmem_remove(struct device *dev)
+static void dax_kmem_release(struct dev_dax *dev_dax)
 {
 	/*
-	 * Without hotremove purposely leak the request_mem_region() for the
-	 * device-dax range and return '0' to ->remove() attempts. The removal
-	 * of the device from the driver always succeeds, but the region is
-	 * permanently pinned as reserved by the unreleased
-	 * request_mem_region().
+	 * Without hotremove purposely leak the request_mem_region() for
+	 * the device-dax range attempts. The removal of the device from
+	 * the driver always succeeds, but the region is permanently
+	 * pinned as reserved by the unreleased request_mem_region().
 	 */
-	return 0;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+static int dev_dax_kmem_remove(struct device *dev)
+{
+	dax_kmem_release(to_dev_dax(dev));
+	return 0;
+}
+
 static struct dax_device_driver device_dax_kmem_driver = {
 	.drv = {
 		.probe = dev_dax_kmem_probe,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
