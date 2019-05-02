Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 231C71133D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 08:10:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D214721237AA5;
	Wed,  1 May 2019 23:10:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D0D91212377FF
 for <linux-nvdimm@lists.01.org>; Wed,  1 May 2019 23:10:14 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 May 2019 23:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,420,1549958400"; d="scan'208";a="166797701"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga002.fm.intel.com with ESMTP; 01 May 2019 23:10:12 -0700
Subject: [PATCH v7 12/12] libnvdimm/pfn: Stop padding pmem namespaces to
 section alignment
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Wed, 01 May 2019 22:56:26 -0700
Message-ID: <155677658661.2336373.9934181067409522929.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: mhocko@suse.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, osalvador@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Now that the mm core supports section-unaligned hotplug of ZONE_DEVICE
memory, we no longer need to add padding at pfn/dax device creation
time. The kernel will still honor padding established by older kernels.

Reported-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pfn.h      |   11 ++-----
 drivers/nvdimm/pfn_devs.c |   75 +++++++--------------------------------------
 include/linux/mmzone.h    |    4 ++
 3 files changed, 19 insertions(+), 71 deletions(-)

diff --git a/drivers/nvdimm/pfn.h b/drivers/nvdimm/pfn.h
index e901e3a3b04c..ae589cc528f2 100644
--- a/drivers/nvdimm/pfn.h
+++ b/drivers/nvdimm/pfn.h
@@ -41,18 +41,13 @@ struct nd_pfn_sb {
 	__le64 checksum;
 };
 
-#ifdef CONFIG_SPARSEMEM
-#define PFN_SECTION_ALIGN_DOWN(x) SECTION_ALIGN_DOWN(x)
-#define PFN_SECTION_ALIGN_UP(x) SECTION_ALIGN_UP(x)
-#else
 /*
  * In this case ZONE_DEVICE=n and we will disable 'pfn' device support,
  * but we still want pmem to compile.
  */
-#define PFN_SECTION_ALIGN_DOWN(x) (x)
-#define PFN_SECTION_ALIGN_UP(x) (x)
+#ifndef SUB_SECTION_ALIGN_DOWN
+#define SUB_SECTION_ALIGN_DOWN(x) (x)
+#define SUB_SECTION_ALIGN_UP(x) (x)
 #endif
 
-#define PHYS_SECTION_ALIGN_DOWN(x) PFN_PHYS(PFN_SECTION_ALIGN_DOWN(PHYS_PFN(x)))
-#define PHYS_SECTION_ALIGN_UP(x) PFN_PHYS(PFN_SECTION_ALIGN_UP(PHYS_PFN(x)))
 #endif /* __NVDIMM_PFN_H */
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index a2406253eb70..7bdaaf3dc77e 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -595,14 +595,14 @@ static u32 info_block_reserve(void)
 }
 
 /*
- * We hotplug memory at section granularity, pad the reserved area from
- * the previous section base to the namespace base address.
+ * We hotplug memory at sub-section granularity, pad the reserved area
+ * from the previous section base to the namespace base address.
  */
 static unsigned long init_altmap_base(resource_size_t base)
 {
 	unsigned long base_pfn = PHYS_PFN(base);
 
-	return PFN_SECTION_ALIGN_DOWN(base_pfn);
+	return SUB_SECTION_ALIGN_DOWN(base_pfn);
 }
 
 static unsigned long init_altmap_reserve(resource_size_t base)
@@ -610,7 +610,7 @@ static unsigned long init_altmap_reserve(resource_size_t base)
 	unsigned long reserve = info_block_reserve() >> PAGE_SHIFT;
 	unsigned long base_pfn = PHYS_PFN(base);
 
-	reserve += base_pfn - PFN_SECTION_ALIGN_DOWN(base_pfn);
+	reserve += base_pfn - SUB_SECTION_ALIGN_DOWN(base_pfn);
 	return reserve;
 }
 
@@ -641,8 +641,7 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 		nd_pfn->npfns = le64_to_cpu(pfn_sb->npfns);
 		pgmap->altmap_valid = false;
 	} else if (nd_pfn->mode == PFN_MODE_PMEM) {
-		nd_pfn->npfns = PFN_SECTION_ALIGN_UP((resource_size(res)
-					- offset) / PAGE_SIZE);
+		nd_pfn->npfns = PHYS_PFN((resource_size(res) - offset));
 		if (le64_to_cpu(nd_pfn->pfn_sb->npfns) > nd_pfn->npfns)
 			dev_info(&nd_pfn->dev,
 					"number of pfns truncated from %lld to %ld\n",
@@ -658,50 +657,10 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 	return 0;
 }
 
-static u64 phys_pmem_align_down(struct nd_pfn *nd_pfn, u64 phys)
-{
-	return min_t(u64, PHYS_SECTION_ALIGN_DOWN(phys),
-			ALIGN_DOWN(phys, nd_pfn->align));
-}
-
-/*
- * Check if pmem collides with 'System RAM', or other regions when
- * section aligned.  Trim it accordingly.
- */
-static void trim_pfn_device(struct nd_pfn *nd_pfn, u32 *start_pad, u32 *end_trunc)
-{
-	struct nd_namespace_common *ndns = nd_pfn->ndns;
-	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
-	struct nd_region *nd_region = to_nd_region(nd_pfn->dev.parent);
-	const resource_size_t start = nsio->res.start;
-	const resource_size_t end = start + resource_size(&nsio->res);
-	resource_size_t adjust, size;
-
-	*start_pad = 0;
-	*end_trunc = 0;
-
-	adjust = start - PHYS_SECTION_ALIGN_DOWN(start);
-	size = resource_size(&nsio->res) + adjust;
-	if (region_intersects(start - adjust, size, IORESOURCE_SYSTEM_RAM,
-				IORES_DESC_NONE) == REGION_MIXED
-			|| nd_region_conflict(nd_region, start - adjust, size))
-		*start_pad = PHYS_SECTION_ALIGN_UP(start) - start;
-
-	/* Now check that end of the range does not collide. */
-	adjust = PHYS_SECTION_ALIGN_UP(end) - end;
-	size = resource_size(&nsio->res) + adjust;
-	if (region_intersects(start, size, IORESOURCE_SYSTEM_RAM,
-				IORES_DESC_NONE) == REGION_MIXED
-			|| !IS_ALIGNED(end, nd_pfn->align)
-			|| nd_region_conflict(nd_region, start, size))
-		*end_trunc = end - phys_pmem_align_down(nd_pfn, end);
-}
-
 static int nd_pfn_init(struct nd_pfn *nd_pfn)
 {
 	struct nd_namespace_common *ndns = nd_pfn->ndns;
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
-	u32 start_pad, end_trunc, reserve = info_block_reserve();
 	resource_size_t start, size;
 	struct nd_region *nd_region;
 	struct nd_pfn_sb *pfn_sb;
@@ -736,43 +695,35 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		return -ENXIO;
 	}
 
-	memset(pfn_sb, 0, sizeof(*pfn_sb));
-
-	trim_pfn_device(nd_pfn, &start_pad, &end_trunc);
-	if (start_pad + end_trunc)
-		dev_info(&nd_pfn->dev, "%s alignment collision, truncate %d bytes\n",
-				dev_name(&ndns->dev), start_pad + end_trunc);
-
 	/*
 	 * Note, we use 64 here for the standard size of struct page,
 	 * debugging options may cause it to be larger in which case the
 	 * implementation will limit the pfns advertised through
 	 * ->direct_access() to those that are included in the memmap.
 	 */
-	start = nsio->res.start + start_pad;
+	start = nsio->res.start;
 	size = resource_size(&nsio->res);
-	npfns = PFN_SECTION_ALIGN_UP((size - start_pad - end_trunc - reserve)
-			/ PAGE_SIZE);
+	npfns = PHYS_PFN(size - SZ_8K);
 	if (nd_pfn->mode == PFN_MODE_PMEM) {
 		/*
 		 * The altmap should be padded out to the block size used
 		 * when populating the vmemmap. This *should* be equal to
 		 * PMD_SIZE for most architectures.
 		 */
-		offset = ALIGN(start + reserve + 64 * npfns,
-				max(nd_pfn->align, PMD_SIZE)) - start;
+		offset = ALIGN(start + SZ_8K + 64 * npfns,
+				max(nd_pfn->align, SECTION_ACTIVE_SIZE)) - start;
 	} else if (nd_pfn->mode == PFN_MODE_RAM)
-		offset = ALIGN(start + reserve, nd_pfn->align) - start;
+		offset = ALIGN(start + SZ_8K, nd_pfn->align) - start;
 	else
 		return -ENXIO;
 
-	if (offset + start_pad + end_trunc >= size) {
+	if (offset >= size) {
 		dev_err(&nd_pfn->dev, "%s unable to satisfy requested alignment\n",
 				dev_name(&ndns->dev));
 		return -ENXIO;
 	}
 
-	npfns = (size - offset - start_pad - end_trunc) / SZ_4K;
+	npfns = PHYS_PFN(size - offset);
 	pfn_sb->mode = cpu_to_le32(nd_pfn->mode);
 	pfn_sb->dataoff = cpu_to_le64(offset);
 	pfn_sb->npfns = cpu_to_le64(npfns);
@@ -781,8 +732,6 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	memcpy(pfn_sb->parent_uuid, nd_dev_to_uuid(&ndns->dev), 16);
 	pfn_sb->version_major = cpu_to_le16(1);
 	pfn_sb->version_minor = cpu_to_le16(3);
-	pfn_sb->start_pad = cpu_to_le32(start_pad);
-	pfn_sb->end_trunc = cpu_to_le32(end_trunc);
 	pfn_sb->align = cpu_to_le32(nd_pfn->align);
 	checksum = nd_sb_checksum((struct nd_gen_sb *) pfn_sb);
 	pfn_sb->checksum = cpu_to_le64(checksum);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3237c5e456df..d2445c483ad4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1155,6 +1155,10 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
 #define PAGES_PER_SUB_SECTION (SECTION_ACTIVE_SIZE / PAGE_SIZE)
 #define PAGE_SUB_SECTION_MASK (~(PAGES_PER_SUB_SECTION-1))
 
+#define SUB_SECTION_ALIGN_UP(pfn) (((pfn) + PAGES_PER_SUB_SECTION - 1) \
+		& PAGE_SUB_SECTION_MASK)
+#define SUB_SECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUB_SECTION_MASK)
+
 struct mem_section_usage {
 	/*
 	 * SECTION_ACTIVE_SIZE portions of the section that are populated in

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
