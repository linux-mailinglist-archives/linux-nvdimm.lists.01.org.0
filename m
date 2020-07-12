Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6371621CA5C
	for <lists+linux-nvdimm@lfdr.de>; Sun, 12 Jul 2020 18:44:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 273B611591341;
	Sun, 12 Jul 2020 09:44:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C107611591341
	for <linux-nvdimm@lists.01.org>; Sun, 12 Jul 2020 09:44:04 -0700 (PDT)
IronPort-SDR: UO6917yTk+a0hdPv71n/kAq/0QNRgXUGqYpqeJG4t+MYk73t3MvfEJRdHovHMlCTmzQqxvrj+l
 Qqa+96QyfxpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="145998919"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800";
   d="scan'208";a="145998919"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:44:04 -0700
IronPort-SDR: DCeU5wGHlBB20jBVXhj2kjanmq16+DH3XcsTZ1Qjg42c66vt7tOOSdjt23UhRZNX3szPjmTv62
 ZyGGGjpb3X7A==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800";
   d="scan'208";a="268174872"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:44:03 -0700
Subject: [PATCH v2 19/22] mm/memremap_pages: Convert to 'struct range'
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 12 Jul 2020 09:27:47 -0700
Message-ID: <159457126779.754248.3575056680831729751.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: AD74WO6EFO7QWM3NCAUQLSTQANLNGQU4
X-Message-ID-Hash: AD74WO6EFO7QWM3NCAUQLSTQANLNGQU4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jason Gunthorpe <jgg@mellanox.com>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AD74WO6EFO7QWM3NCAUQLSTQANLNGQU4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 'struct resource' in 'struct dev_pagemap' is only used for holding
resource span information. The other fields, 'name', 'flags', 'desc',
'parent', 'sibling', and 'child' are all unused wasted space.

This is in preparation for introducing a multi-range extension of
devm_memremap_pages().

The bulk of this change is unwinding all the places internal to
libnvdimm that used 'struct resource' unnecessarily.

P2PDMA had a minor usage of the flags field, but only to report failures
with "%pR". That is replaced with an open coded print of the range.

Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c     |   13 +++--
 drivers/dax/bus.c                      |   10 ++--
 drivers/dax/bus.h                      |    2 -
 drivers/dax/dax-private.h              |    5 --
 drivers/dax/device.c                   |    3 -
 drivers/dax/hmem/hmem.c                |    5 ++
 drivers/dax/pmem/core.c                |   12 ++---
 drivers/gpu/drm/nouveau/nouveau_dmem.c |    3 +
 drivers/nvdimm/badrange.c              |   26 +++++------
 drivers/nvdimm/claim.c                 |   13 +++--
 drivers/nvdimm/nd.h                    |    3 +
 drivers/nvdimm/pfn_devs.c              |   12 ++---
 drivers/nvdimm/pmem.c                  |   26 ++++++-----
 drivers/nvdimm/region.c                |   21 +++++----
 drivers/pci/p2pdma.c                   |   11 ++---
 include/linux/memremap.h               |    5 +-
 include/linux/range.h                  |    6 ++
 mm/memremap.c                          |   77 ++++++++++++++++----------------
 tools/testing/nvdimm/test/iomap.c      |    2 -
 19 files changed, 135 insertions(+), 120 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 09d8119024db..a3032cc9a4da 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -343,9 +343,9 @@ static struct page *kvmppc_uvmem_get_page(unsigned long gpa, struct kvm *kvm)
 	struct kvmppc_uvmem_page_pvt *pvt;
 	unsigned long pfn_last, pfn_first;
 
-	pfn_first = kvmppc_uvmem_pgmap.res.start >> PAGE_SHIFT;
+	pfn_first = kvmppc_uvmem_pgmap.range.start >> PAGE_SHIFT;
 	pfn_last = pfn_first +
-		   (resource_size(&kvmppc_uvmem_pgmap.res) >> PAGE_SHIFT);
+		   (range_len(&kvmppc_uvmem_pgmap.range) >> PAGE_SHIFT);
 
 	spin_lock(&kvmppc_uvmem_bitmap_lock);
 	bit = find_first_zero_bit(kvmppc_uvmem_bitmap,
@@ -661,7 +661,7 @@ static vm_fault_t kvmppc_uvmem_migrate_to_ram(struct vm_fault *vmf)
 static void kvmppc_uvmem_page_free(struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page) -
-			(kvmppc_uvmem_pgmap.res.start >> PAGE_SHIFT);
+			(kvmppc_uvmem_pgmap.range.start >> PAGE_SHIFT);
 	struct kvmppc_uvmem_page_pvt *pvt;
 
 	spin_lock(&kvmppc_uvmem_bitmap_lock);
@@ -806,7 +806,8 @@ int kvmppc_uvmem_init(void)
 	}
 
 	kvmppc_uvmem_pgmap.type = MEMORY_DEVICE_PRIVATE;
-	kvmppc_uvmem_pgmap.res = *res;
+	kvmppc_uvmem_pgmap.range.start = res->start;
+	kvmppc_uvmem_pgmap.range.end = res->end;
 	kvmppc_uvmem_pgmap.ops = &kvmppc_uvmem_ops;
 	/* just one global instance: */
 	kvmppc_uvmem_pgmap.owner = &kvmppc_uvmem_pgmap;
@@ -841,7 +842,7 @@ void kvmppc_uvmem_free(void)
 		return;
 
 	memunmap_pages(&kvmppc_uvmem_pgmap);
-	release_mem_region(kvmppc_uvmem_pgmap.res.start,
-			   resource_size(&kvmppc_uvmem_pgmap.res));
+	release_mem_region(kvmppc_uvmem_pgmap.range.start,
+			   range_len(&kvmppc_uvmem_pgmap.range));
 	kfree(kvmppc_uvmem_bitmap);
 }
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 85ff6ee3a5c5..aca7914287f5 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -515,7 +515,7 @@ static void dax_region_unregister(void *region)
 }
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, int target_node, unsigned int align,
+		struct range *range, int target_node, unsigned int align,
 		unsigned long flags)
 {
 	struct dax_region *dax_region;
@@ -530,8 +530,8 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		return NULL;
 	}
 
-	if (!IS_ALIGNED(res->start, align)
-			|| !IS_ALIGNED(resource_size(res), align))
+	if (!IS_ALIGNED(range->start, align)
+			|| !IS_ALIGNED(range_len(range), align))
 		return NULL;
 
 	dax_region = kzalloc(sizeof(*dax_region), GFP_KERNEL);
@@ -546,8 +546,8 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 	dax_region->target_node = target_node;
 	ida_init(&dax_region->ida);
 	dax_region->res = (struct resource) {
-		.start = res->start,
-		.end = res->end,
+		.start = range->start,
+		.end = range->end,
 		.flags = IORESOURCE_MEM | flags,
 	};
 
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index da27ea70a19a..72b92f95509f 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -13,7 +13,7 @@ void dax_region_put(struct dax_region *dax_region);
 
 #define IORESOURCE_DAX_STATIC (1UL << 0)
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, int target_node, unsigned int align,
+		struct range *range, int target_node, unsigned int align,
 		unsigned long flags);
 
 enum dev_dax_subsys {
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index b81a1494d82b..0cbb2ec81ca7 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -61,11 +61,6 @@ struct dev_dax {
 	struct range range;
 };
 
-static inline u64 range_len(struct range *range)
-{
-	return range->end - range->start + 1;
-}
-
 static inline struct dev_dax *to_dev_dax(struct device *dev)
 {
 	return container_of(dev, struct dev_dax, dev);
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 5496331f6eb6..fffc54ce0911 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -416,8 +416,7 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 		pgmap = devm_kzalloc(dev, sizeof(*pgmap), GFP_KERNEL);
 		if (!pgmap)
 			return -ENOMEM;
-		pgmap->res.start = range->start;
-		pgmap->res.end = range->end;
+		pgmap->range = *range;
 	}
 	pgmap->type = MEMORY_DEVICE_DEVDAX;
 	addr = devm_memremap_pages(dev, pgmap);
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index aa260009dfc7..1a3347bb6143 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -13,13 +13,16 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	struct dev_dax_data data;
 	struct dev_dax *dev_dax;
 	struct resource *res;
+	struct range range;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENOMEM;
 
 	mri = dev->platform_data;
-	dax_region = alloc_dax_region(dev, pdev->id, res, mri->target_node,
+	range.start = res->start;
+	range.end = res->end;
+	dax_region = alloc_dax_region(dev, pdev->id, &range, mri->target_node,
 			PMD_SIZE, 0);
 	if (!dax_region)
 		return -ENOMEM;
diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 4fe700884338..62b26bfceab1 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -9,7 +9,7 @@
 
 struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 {
-	struct resource res;
+	struct range range;
 	int rc, id, region_id;
 	resource_size_t offset;
 	struct nd_pfn_sb *pfn_sb;
@@ -50,10 +50,10 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	if (rc != 2)
 		return ERR_PTR(-EINVAL);
 
-	/* adjust the dax_region resource to the start of data */
-	memcpy(&res, &pgmap.res, sizeof(res));
-	res.start += offset;
-	dax_region = alloc_dax_region(dev, region_id, &res,
+	/* adjust the dax_region range to the start of data */
+	range = pgmap.range;
+	range.start += offset,
+	dax_region = alloc_dax_region(dev, region_id, &range,
 			nd_region->target_node, le32_to_cpu(pfn_sb->align),
 			IORESOURCE_DAX_STATIC);
 	if (!dax_region)
@@ -64,7 +64,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 		.id = id,
 		.pgmap = &pgmap,
 		.subsys = subsys,
-		.size = resource_size(&res),
+		.size = range_len(&range),
 	};
 	dev_dax = devm_create_dev_dax(&data);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index e5c230d9ae24..395a5b7cb76d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -239,7 +239,8 @@ nouveau_dmem_chunk_alloc(struct nouveau_drm *drm, struct page **ppage)
 
 	chunk->drm = drm;
 	chunk->pagemap.type = MEMORY_DEVICE_PRIVATE;
-	chunk->pagemap.res = *res;
+	chunk->pagemap.range.start = res->start;
+	chunk->pagemap.range.end = res->end;
 	chunk->pagemap.ops = &nouveau_dmem_pagemap_ops;
 	chunk->pagemap.owner = drm->dev;
 
diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index b9eeefa27e3a..aaf6e215a8c6 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -211,7 +211,7 @@ static void __add_badblock_range(struct badblocks *bb, u64 ns_offset, u64 len)
 }
 
 static void badblocks_populate(struct badrange *badrange,
-		struct badblocks *bb, const struct resource *res)
+		struct badblocks *bb, const struct range *range)
 {
 	struct badrange_entry *bre;
 
@@ -222,34 +222,34 @@ static void badblocks_populate(struct badrange *badrange,
 		u64 bre_end = bre->start + bre->length - 1;
 
 		/* Discard intervals with no intersection */
-		if (bre_end < res->start)
+		if (bre_end < range->start)
 			continue;
-		if (bre->start >  res->end)
+		if (bre->start > range->end)
 			continue;
 		/* Deal with any overlap after start of the namespace */
-		if (bre->start >= res->start) {
+		if (bre->start >= range->start) {
 			u64 start = bre->start;
 			u64 len;
 
-			if (bre_end <= res->end)
+			if (bre_end <= range->end)
 				len = bre->length;
 			else
-				len = res->start + resource_size(res)
+				len = range->start + range_len(range)
 					- bre->start;
-			__add_badblock_range(bb, start - res->start, len);
+			__add_badblock_range(bb, start - range->start, len);
 			continue;
 		}
 		/*
 		 * Deal with overlap for badrange starting before
 		 * the namespace.
 		 */
-		if (bre->start < res->start) {
+		if (bre->start < range->start) {
 			u64 len;
 
-			if (bre_end < res->end)
-				len = bre->start + bre->length - res->start;
+			if (bre_end < range->end)
+				len = bre->start + bre->length - range->start;
 			else
-				len = resource_size(res);
+				len = range_len(range);
 			__add_badblock_range(bb, 0, len);
 		}
 	}
@@ -267,7 +267,7 @@ static void badblocks_populate(struct badrange *badrange,
  * and add badblocks entries for all matching sub-ranges
  */
 void nvdimm_badblocks_populate(struct nd_region *nd_region,
-		struct badblocks *bb, const struct resource *res)
+		struct badblocks *bb, const struct range *range)
 {
 	struct nvdimm_bus *nvdimm_bus;
 
@@ -279,7 +279,7 @@ void nvdimm_badblocks_populate(struct nd_region *nd_region,
 	nvdimm_bus = walk_to_nvdimm_bus(&nd_region->dev);
 
 	nvdimm_bus_lock(&nvdimm_bus->dev);
-	badblocks_populate(&nvdimm_bus->badrange, bb, res);
+	badblocks_populate(&nvdimm_bus->badrange, bb, range);
 	nvdimm_bus_unlock(&nvdimm_bus->dev);
 }
 EXPORT_SYMBOL_GPL(nvdimm_badblocks_populate);
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 45964acba944..290267e1ff9f 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -303,13 +303,16 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio,
 		resource_size_t size)
 {
-	struct resource *res = &nsio->res;
 	struct nd_namespace_common *ndns = &nsio->common;
+	struct range range = {
+		.start = nsio->res.start,
+		.end = nsio->res.end,
+	};
 
 	nsio->size = size;
-	if (!devm_request_mem_region(dev, res->start, size,
+	if (!devm_request_mem_region(dev, range.start, size,
 				dev_name(&ndns->dev))) {
-		dev_warn(dev, "could not reserve region %pR\n", res);
+		dev_warn(dev, "could not reserve region %pR\n", &nsio->res);
 		return -EBUSY;
 	}
 
@@ -317,9 +320,9 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio,
 	if (devm_init_badblocks(dev, &nsio->bb))
 		return -ENOMEM;
 	nvdimm_badblocks_populate(to_nd_region(ndns->dev.parent), &nsio->bb,
-			&nsio->res);
+			&range);
 
-	nsio->addr = devm_memremap(dev, res->start, size, ARCH_MEMREMAP_PMEM);
+	nsio->addr = devm_memremap(dev, range.start, size, ARCH_MEMREMAP_PMEM);
 
 	return PTR_ERR_OR_ZERO(nsio->addr);
 }
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 85c1ae813ea3..bac90afa4604 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -377,8 +377,9 @@ int nvdimm_namespace_detach_btt(struct nd_btt *nd_btt);
 const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 		char *name);
 unsigned int pmem_sector_size(struct nd_namespace_common *ndns);
+struct range;
 void nvdimm_badblocks_populate(struct nd_region *nd_region,
-		struct badblocks *bb, const struct resource *res);
+		struct badblocks *bb, const struct range *range);
 int devm_namespace_enable(struct device *dev, struct nd_namespace_common *ndns,
 		resource_size_t size);
 void devm_namespace_disable(struct device *dev,
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 34db557dbad1..7ad9ea107810 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -672,7 +672,7 @@ static unsigned long init_altmap_reserve(resource_size_t base)
 
 static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 {
-	struct resource *res = &pgmap->res;
+	struct range *range = &pgmap->range;
 	struct vmem_altmap *altmap = &pgmap->altmap;
 	struct nd_pfn_sb *pfn_sb = nd_pfn->pfn_sb;
 	u64 offset = le64_to_cpu(pfn_sb->dataoff);
@@ -689,16 +689,16 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 		.end_pfn = PHYS_PFN(end),
 	};
 
-	memcpy(res, &nsio->res, sizeof(*res));
-	res->start += start_pad;
-	res->end -= end_trunc;
-
+	*range = (struct range) {
+		.start = nsio->res.start + start_pad,
+		.end = nsio->res.end - end_trunc,
+	};
 	if (nd_pfn->mode == PFN_MODE_RAM) {
 		if (offset < reserve)
 			return -EINVAL;
 		nd_pfn->npfns = le64_to_cpu(pfn_sb->npfns);
 	} else if (nd_pfn->mode == PFN_MODE_PMEM) {
-		nd_pfn->npfns = PHYS_PFN((resource_size(res) - offset));
+		nd_pfn->npfns = PHYS_PFN((range_len(range) - offset));
 		if (le64_to_cpu(nd_pfn->pfn_sb->npfns) > nd_pfn->npfns)
 			dev_info(&nd_pfn->dev,
 					"number of pfns truncated from %lld to %ld\n",
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index d25e66fd942d..08efe0cc9903 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -377,7 +377,7 @@ static int pmem_attach_disk(struct device *dev,
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	int nid = dev_to_node(dev), fua;
 	struct resource *res = &nsio->res;
-	struct resource bb_res;
+	struct range bb_range;
 	struct nd_pfn *nd_pfn = NULL;
 	struct dax_device *dax_dev;
 	struct nd_pfn_sb *pfn_sb;
@@ -436,24 +436,26 @@ static int pmem_attach_disk(struct device *dev,
 		pfn_sb = nd_pfn->pfn_sb;
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
 		pmem->pfn_pad = resource_size(res) -
-			resource_size(&pmem->pgmap.res);
+			range_len(&pmem->pgmap.range);
 		pmem->pfn_flags |= PFN_MAP;
-		memcpy(&bb_res, &pmem->pgmap.res, sizeof(bb_res));
-		bb_res.start += pmem->data_offset;
+		bb_range = pmem->pgmap.range;
+		bb_range.start += pmem->data_offset;
 	} else if (pmem_should_map_pages(dev)) {
-		memcpy(&pmem->pgmap.res, &nsio->res, sizeof(pmem->pgmap.res));
+		pmem->pgmap.range.start = res->start;
+		pmem->pgmap.range.end = res->end;
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pmem->pfn_flags |= PFN_MAP;
-		memcpy(&bb_res, &pmem->pgmap.res, sizeof(bb_res));
+		bb_range = pmem->pgmap.range;
 	} else {
 		if (devm_add_action_or_reset(dev, pmem_release_queue,
 					&pmem->pgmap))
 			return -ENOMEM;
 		addr = devm_memremap(dev, pmem->phys_addr,
 				pmem->size, ARCH_MEMREMAP_PMEM);
-		memcpy(&bb_res, &nsio->res, sizeof(bb_res));
+		bb_range.start =  res->start;
+		bb_range.end = res->end;
 	}
 
 	if (IS_ERR(addr))
@@ -483,7 +485,7 @@ static int pmem_attach_disk(struct device *dev,
 			/ 512);
 	if (devm_init_badblocks(dev, &pmem->bb))
 		return -ENOMEM;
-	nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_res);
+	nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_range);
 	disk->bb = &pmem->bb;
 
 	if (is_nvdimm_sync(nd_region))
@@ -594,8 +596,8 @@ static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
 	resource_size_t offset = 0, end_trunc = 0;
 	struct nd_namespace_common *ndns;
 	struct nd_namespace_io *nsio;
-	struct resource res;
 	struct badblocks *bb;
+	struct range range;
 	struct kernfs_node *bb_state;
 
 	if (event != NVDIMM_REVALIDATE_POISON)
@@ -631,9 +633,9 @@ static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
 		nsio = to_nd_namespace_io(&ndns->dev);
 	}
 
-	res.start = nsio->res.start + offset;
-	res.end = nsio->res.end - end_trunc;
-	nvdimm_badblocks_populate(nd_region, bb, &res);
+	range.start = nsio->res.start + offset;
+	range.end = nsio->res.end - end_trunc;
+	nvdimm_badblocks_populate(nd_region, bb, &range);
 	if (bb_state)
 		sysfs_notify_dirent(bb_state);
 }
diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index 0f6978e72e7c..bfce87ed72ab 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -35,7 +35,10 @@ static int nd_region_probe(struct device *dev)
 		return rc;
 
 	if (is_memory(&nd_region->dev)) {
-		struct resource ndr_res;
+		struct range range = {
+			.start = nd_region->ndr_start,
+			.end = nd_region->ndr_start + nd_region->ndr_size - 1,
+		};
 
 		if (devm_init_badblocks(dev, &nd_region->bb))
 			return -ENODEV;
@@ -44,9 +47,7 @@ static int nd_region_probe(struct device *dev)
 		if (!nd_region->bb_state)
 			dev_warn(&nd_region->dev,
 					"'badblocks' notification disabled\n");
-		ndr_res.start = nd_region->ndr_start;
-		ndr_res.end = nd_region->ndr_start + nd_region->ndr_size - 1;
-		nvdimm_badblocks_populate(nd_region, &nd_region->bb, &ndr_res);
+		nvdimm_badblocks_populate(nd_region, &nd_region->bb, &range);
 	}
 
 	rc = nd_region_register_namespaces(nd_region, &err);
@@ -121,14 +122,16 @@ static void nd_region_notify(struct device *dev, enum nvdimm_event event)
 {
 	if (event == NVDIMM_REVALIDATE_POISON) {
 		struct nd_region *nd_region = to_nd_region(dev);
-		struct resource res;
 
 		if (is_memory(&nd_region->dev)) {
-			res.start = nd_region->ndr_start;
-			res.end = nd_region->ndr_start +
-				nd_region->ndr_size - 1;
+			struct range range = {
+				.start = nd_region->ndr_start,
+				.end = nd_region->ndr_start +
+					nd_region->ndr_size - 1,
+			};
+
 			nvdimm_badblocks_populate(nd_region,
-					&nd_region->bb, &res);
+					&nd_region->bb, &range);
 			if (nd_region->bb_state)
 				sysfs_notify_dirent(nd_region->bb_state);
 		}
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e8e444eeb1cd..5ed28a8c7264 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -185,9 +185,8 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 		return -ENOMEM;
 
 	pgmap = &p2p_pgmap->pgmap;
-	pgmap->res.start = pci_resource_start(pdev, bar) + offset;
-	pgmap->res.end = pgmap->res.start + size - 1;
-	pgmap->res.flags = pci_resource_flags(pdev, bar);
+	pgmap->range.start = pci_resource_start(pdev, bar) + offset;
+	pgmap->range.end = pgmap->range.start + size - 1;
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
 
 	p2p_pgmap->provider = pdev;
@@ -202,13 +201,13 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 
 	error = gen_pool_add_owner(pdev->p2pdma->pool, (unsigned long)addr,
 			pci_bus_address(pdev, bar) + offset,
-			resource_size(&pgmap->res), dev_to_node(&pdev->dev),
+			range_len(&pgmap->range), dev_to_node(&pdev->dev),
 			pgmap->ref);
 	if (error)
 		goto pages_free;
 
-	pci_info(pdev, "added peer-to-peer DMA memory %pR\n",
-		 &pgmap->res);
+	pci_info(pdev, "added peer-to-peer DMA memory %#llx-%#llx\n",
+		 pgmap->range.start, pgmap->range.end);
 
 	return 0;
 
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 5f5b2df06e61..d5d5e37db916 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_MEMREMAP_H_
 #define _LINUX_MEMREMAP_H_
+#include <linux/range.h>
 #include <linux/ioport.h>
 #include <linux/percpu-refcount.h>
 
@@ -94,7 +95,7 @@ struct dev_pagemap_ops {
 /**
  * struct dev_pagemap - metadata for ZONE_DEVICE mappings
  * @altmap: pre-allocated/reserved memory for vmemmap allocations
- * @res: physical address range covered by @ref
+ * @range: physical address range covered by @ref
  * @ref: reference count that pins the devm_memremap_pages() mapping
  * @internal_ref: internal reference if @ref is not provided by the caller
  * @done: completion for @internal_ref
@@ -107,7 +108,7 @@ struct dev_pagemap_ops {
  */
 struct dev_pagemap {
 	struct vmem_altmap altmap;
-	struct resource res;
+	struct range range;
 	struct percpu_ref *ref;
 	struct percpu_ref internal_ref;
 	struct completion done;
diff --git a/include/linux/range.h b/include/linux/range.h
index d1fbeb664012..274681cc3154 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -1,12 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_RANGE_H
 #define _LINUX_RANGE_H
+#include <linux/types.h>
 
 struct range {
 	u64   start;
 	u64   end;
 };
 
+static inline u64 range_len(const struct range *range)
+{
+	return range->end - range->start + 1;
+}
+
 int add_range(struct range *range, int az, int nr_range,
 		u64 start, u64 end);
 
diff --git a/mm/memremap.c b/mm/memremap.c
index 03e38b7a38f1..91a79a958f66 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -70,24 +70,24 @@ static void devmap_managed_enable_put(void)
 }
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
-static void pgmap_array_delete(struct resource *res)
+static void pgmap_array_delete(struct range *range)
 {
-	xa_store_range(&pgmap_array, PHYS_PFN(res->start), PHYS_PFN(res->end),
+	xa_store_range(&pgmap_array, PHYS_PFN(range->start), PHYS_PFN(range->end),
 			NULL, GFP_KERNEL);
 	synchronize_rcu();
 }
 
 static unsigned long pfn_first(struct dev_pagemap *pgmap)
 {
-	return PHYS_PFN(pgmap->res.start) +
+	return PHYS_PFN(pgmap->range.start) +
 		vmem_altmap_offset(pgmap_altmap(pgmap));
 }
 
 static unsigned long pfn_end(struct dev_pagemap *pgmap)
 {
-	const struct resource *res = &pgmap->res;
+	const struct range *range = &pgmap->range;
 
-	return (res->start + resource_size(res)) >> PAGE_SHIFT;
+	return (range->start + range_len(range)) >> PAGE_SHIFT;
 }
 
 static unsigned long pfn_next(unsigned long pfn)
@@ -126,7 +126,7 @@ static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
 
 void memunmap_pages(struct dev_pagemap *pgmap)
 {
-	struct resource *res = &pgmap->res;
+	struct range *range = &pgmap->range;
 	struct page *first_page;
 	unsigned long pfn;
 	int nid;
@@ -143,20 +143,20 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 	nid = page_to_nid(first_page);
 
 	mem_hotplug_begin();
-	remove_pfn_range_from_zone(page_zone(first_page), PHYS_PFN(res->start),
-				   PHYS_PFN(resource_size(res)));
+	remove_pfn_range_from_zone(page_zone(first_page), PHYS_PFN(range->start),
+				   PHYS_PFN(range_len(range)));
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
-		__remove_pages(PHYS_PFN(res->start),
-			       PHYS_PFN(resource_size(res)), NULL);
+		__remove_pages(PHYS_PFN(range->start),
+			       PHYS_PFN(range_len(range)), NULL);
 	} else {
-		arch_remove_memory(nid, res->start, resource_size(res),
+		arch_remove_memory(nid, range->start, range_len(range),
 				pgmap_altmap(pgmap));
-		kasan_remove_zero_shadow(__va(res->start), resource_size(res));
+		kasan_remove_zero_shadow(__va(range->start), range_len(range));
 	}
 	mem_hotplug_done();
 
-	untrack_pfn(NULL, PHYS_PFN(res->start), resource_size(res));
-	pgmap_array_delete(res);
+	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range));
+	pgmap_array_delete(range);
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
 	devmap_managed_enable_put();
 }
@@ -182,7 +182,7 @@ static void dev_pagemap_percpu_release(struct percpu_ref *ref)
  */
 void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 {
-	struct resource *res = &pgmap->res;
+	struct range *range = &pgmap->range;
 	struct dev_pagemap *conflict_pgmap;
 	struct mhp_params params = {
 		/*
@@ -251,7 +251,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 			return ERR_PTR(error);
 	}
 
-	conflict_pgmap = get_dev_pagemap(PHYS_PFN(res->start), NULL);
+	conflict_pgmap = get_dev_pagemap(PHYS_PFN(range->start), NULL);
 	if (conflict_pgmap) {
 		WARN(1, "Conflicting mapping in same section\n");
 		put_dev_pagemap(conflict_pgmap);
@@ -259,7 +259,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		goto err_array;
 	}
 
-	conflict_pgmap = get_dev_pagemap(PHYS_PFN(res->end), NULL);
+	conflict_pgmap = get_dev_pagemap(PHYS_PFN(range->end), NULL);
 	if (conflict_pgmap) {
 		WARN(1, "Conflicting mapping in same section\n");
 		put_dev_pagemap(conflict_pgmap);
@@ -267,26 +267,27 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		goto err_array;
 	}
 
-	is_ram = region_intersects(res->start, resource_size(res),
+	is_ram = region_intersects(range->start, range_len(range),
 		IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
 
 	if (is_ram != REGION_DISJOINT) {
-		WARN_ONCE(1, "%s attempted on %s region %pr\n", __func__,
-				is_ram == REGION_MIXED ? "mixed" : "ram", res);
+		WARN_ONCE(1, "attempted on %s region %#llx-%#llx\n",
+				is_ram == REGION_MIXED ? "mixed" : "ram",
+				range->start, range->end);
 		error = -ENXIO;
 		goto err_array;
 	}
 
-	error = xa_err(xa_store_range(&pgmap_array, PHYS_PFN(res->start),
-				PHYS_PFN(res->end), pgmap, GFP_KERNEL));
+	error = xa_err(xa_store_range(&pgmap_array, PHYS_PFN(range->start),
+				PHYS_PFN(range->end), pgmap, GFP_KERNEL));
 	if (error)
 		goto err_array;
 
 	if (nid < 0)
 		nid = numa_mem_id();
 
-	error = track_pfn_remap(NULL, &params.pgprot, PHYS_PFN(res->start),
-				0, resource_size(res));
+	error = track_pfn_remap(NULL, &params.pgprot, PHYS_PFN(range->start), 0,
+			range_len(range));
 	if (error)
 		goto err_pfn_remap;
 
@@ -304,16 +305,16 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 	 * arch_add_memory().
 	 */
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
-		error = add_pages(nid, PHYS_PFN(res->start),
-				PHYS_PFN(resource_size(res)), &params);
+		error = add_pages(nid, PHYS_PFN(range->start),
+				PHYS_PFN(range_len(range)), &params);
 	} else {
-		error = kasan_add_zero_shadow(__va(res->start), resource_size(res));
+		error = kasan_add_zero_shadow(__va(range->start), range_len(range));
 		if (error) {
 			mem_hotplug_done();
 			goto err_kasan;
 		}
 
-		error = arch_add_memory(nid, res->start, resource_size(res),
+		error = arch_add_memory(nid, range->start, range_len(range),
 					&params);
 	}
 
@@ -321,8 +322,8 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		struct zone *zone;
 
 		zone = &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
-		move_pfn_range_to_zone(zone, PHYS_PFN(res->start),
-				PHYS_PFN(resource_size(res)), params.altmap);
+		move_pfn_range_to_zone(zone, PHYS_PFN(range->start),
+				PHYS_PFN(range_len(range)), params.altmap);
 	}
 
 	mem_hotplug_done();
@@ -334,17 +335,17 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 	 * to allow us to do the work while not holding the hotplug lock.
 	 */
 	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
-				PHYS_PFN(res->start),
-				PHYS_PFN(resource_size(res)), pgmap);
+				PHYS_PFN(range->start),
+				PHYS_PFN(range_len(range)), pgmap);
 	percpu_ref_get_many(pgmap->ref, pfn_end(pgmap) - pfn_first(pgmap));
-	return __va(res->start);
+	return __va(range->start);
 
  err_add_memory:
-	kasan_remove_zero_shadow(__va(res->start), resource_size(res));
+	kasan_remove_zero_shadow(__va(range->start), range_len(range));
  err_kasan:
-	untrack_pfn(NULL, PHYS_PFN(res->start), resource_size(res));
+	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range));
  err_pfn_remap:
-	pgmap_array_delete(res);
+	pgmap_array_delete(range);
  err_array:
 	dev_pagemap_kill(pgmap);
 	dev_pagemap_cleanup(pgmap);
@@ -369,7 +370,7 @@ EXPORT_SYMBOL_GPL(memremap_pages);
  *    'live' on entry and will be killed and reaped at
  *    devm_memremap_pages_release() time, or if this routine fails.
  *
- * 4/ res is expected to be a host memory range that could feasibly be
+ * 4/ range is expected to be a host memory range that could feasibly be
  *    treated as a "System RAM" range, i.e. not a device mmio range, but
  *    this is not enforced.
  */
@@ -426,7 +427,7 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 	 * In the cached case we're already holding a live reference.
 	 */
 	if (pgmap) {
-		if (phys >= pgmap->res.start && phys <= pgmap->res.end)
+		if (phys >= pgmap->range.start && phys <= pgmap->range.end)
 			return pgmap;
 		put_dev_pagemap(pgmap);
 	}
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index 03e40b3b0106..c62d372d426f 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -126,7 +126,7 @@ static void dev_pagemap_percpu_release(struct percpu_ref *ref)
 void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 {
 	int error;
-	resource_size_t offset = pgmap->res.start;
+	resource_size_t offset = pgmap->range.start;
 	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
 
 	if (!nfit_res)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
