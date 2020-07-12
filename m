Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B1D21CA51
	for <lists+linux-nvdimm@lfdr.de>; Sun, 12 Jul 2020 18:43:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C20011591338;
	Sun, 12 Jul 2020 09:43:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C93301159133C
	for <linux-nvdimm@lists.01.org>; Sun, 12 Jul 2020 09:43:37 -0700 (PDT)
IronPort-SDR: KwusbpbkabMroe4z5+PHYa5XRMCrVj208G+eH3xlwx8JJ1WriFo21gKHI+opNyJQvqEjCuceuk
 vPtigx+kKjFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146552947"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800";
   d="scan'208";a="146552947"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:37 -0700
IronPort-SDR: FKCZjifO981uKLGhA9hxcXNYYBfoLKrw8xMkVkVqXi2iigRW7uxYdErS/0fGfvHQBk2uRpsZn2
 P92mp18k+vzA==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800";
   d="scan'208";a="281166970"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:37 -0700
Subject: [PATCH v2 14/22] device-dax: Kill dax_kmem_res
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 12 Jul 2020 09:27:21 -0700
Message-ID: <159457124129.754248.10028584123818131641.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: DNKCMEPYYKX3KY3ZMMHHS5ZSZR3U4PZ7
X-Message-ID-Hash: DNKCMEPYYKX3KY3ZMMHHS5ZSZR3U4PZ7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, peterz@infradead.org, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DNKCMEPYYKX3KY3ZMMHHS5ZSZR3U4PZ7/>
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
  memory range that add_memory_driver_managed() rejects that is a
  memory-hotplug-core policy that the driver is in no position to
  override.

- The implementation trusts that failed remove_memory() results in the
  entire resource range remaining pinned busy. The driver need not make
  that layering violation assumption and just maintain the busy state in
  its local resource.

- The "Hot-remove not yet implemented." comment is stale since hotremove
  support is now included.

Cc: David Hildenbrand <david@redhat.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/dax-private.h |    3 -
 drivers/dax/kmem.c        |  123 +++++++++++++++++++++------------------------
 2 files changed, 58 insertions(+), 68 deletions(-)

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
index 5bb133df147d..77e25361fbeb 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -19,16 +19,24 @@ static const char *kmem_name;
 /* Set if any memory will remain added when the driver will be unloaded. */
 static bool any_hotremove_failed;
 
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
-	const char *new_res_name;
-	int numa_node;
+	struct range range = dax_kmem_range(dev_dax);
+	int numa_node = dev_dax->target_node;
+	struct resource *res;
+	char *res_name;
 	int rc;
 
 	/*
@@ -37,109 +45,94 @@ int dev_dax_kmem_probe(struct device *dev)
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
-	new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
-	if (!new_res_name)
+	res_name = kstrdup(dev_name(dev), GFP_KERNEL);
+	if (!res_name)
 		return -ENOMEM;
 
-	/* Region is permanently reserved if hotremove fails. */
-	new_res = request_mem_region(kmem_start, kmem_size, new_res_name);
-	if (!new_res) {
-		dev_warn(dev, "could not reserve region [%pa-%pa]\n",
-			 &kmem_start, &kmem_end);
-		kfree(new_res_name);
+	res = request_mem_region(range.start, range_len(&range), res_name);
+	if (!res) {
+		dev_warn(dev, "could not reserve region [%#llx-%#llx]\n",
+				range.start, range.end);
+		kfree(res_name);
 		return -EBUSY;
 	}
 
 	/*
-	 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
-	 * so that add_memory() can add a child resource.  Do not
-	 * inherit flags from the parent since it may set new flags
-	 * unknown to us that will break add_memory() below.
+	 * Temporarily clear busy to allow add_memory_driver_managed()
+	 * to claim it.
 	 */
-	new_res->flags = IORESOURCE_SYSTEM_RAM;
+	res->flags &= ~IORESOURCE_BUSY;
 
 	/*
 	 * Ensure that future kexec'd kernels will not treat this as RAM
 	 * automatically.
 	 */
-	rc = add_memory_driver_managed(numa_node, new_res->start,
-				       resource_size(new_res), kmem_name);
+	rc = add_memory_driver_managed(numa_node, res->start,
+				       resource_size(res), kmem_name);
+
+	res->flags |= IORESOURCE_BUSY;
 	if (rc) {
-		release_resource(new_res);
-		kfree(new_res);
-		kfree(new_res_name);
+		release_mem_region(range.start, range_len(&range));
+		kfree(res_name);
 		return rc;
 	}
-	dev_dax->dax_kmem_res = new_res;
+
+	dev_set_drvdata(dev, res_name);
 
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
-	const char *res_name = res->name;
 	int rc;
+	struct device *dev = &dev_dax->dev;
+	const char *res_name = dev_get_drvdata(dev);
+	struct range range = dax_kmem_range(dev_dax);
 
 	/*
 	 * We have one shot for removing memory, if some memory blocks were not
 	 * offline prior to calling this function remove_memory() will fail, and
 	 * there is no way to hotremove this memory until reboot because device
-	 * unbind will succeed even if we return failure.
+	 * unbind will proceed regardless of the remove_memory result.
 	 */
-	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
-	if (rc) {
-		any_hotremove_failed = true;
-		dev_err(dev,
-			"DAX region %pR cannot be hotremoved until the next reboot\n",
-			res);
-		return rc;
+	rc = remove_memory(dev_dax->target_node, range.start, range_len(&range));
+	if (rc == 0) {
+		release_mem_region(range.start, range_len(&range));
+		dev_set_drvdata(dev, NULL);
+		kfree(res_name);
+		return;
 	}
 
-	/* Release and free dax resources */
-	release_resource(res);
-	kfree(res);
-	kfree(res_name);
-	dev_dax->dax_kmem_res = NULL;
-
-	return 0;
+	any_hotremove_failed = true;
+	dev_err(dev, "%#llx-%#llx cannot be hotremoved until the next reboot\n",
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
 	any_hotremove_failed = true;
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
