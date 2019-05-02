Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D719F11330
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 08:09:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8561221B02822;
	Wed,  1 May 2019 23:09:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 462532123780B
 for <linux-nvdimm@lists.01.org>; Wed,  1 May 2019 23:09:35 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 May 2019 23:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,420,1549958400"; d="scan'208";a="166797485"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga002.fm.intel.com with ESMTP; 01 May 2019 23:09:34 -0700
Subject: [PATCH v7 05/12] mm/sparsemem: Convert kmalloc_section_memmap() to
 populate_section_memmap()
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Wed, 01 May 2019 22:55:48 -0700
Message-ID: <155677654842.2336373.17000900051843592636.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: mhocko@suse.com, linux-nvdimm@lists.01.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, osalvador@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Allow sub-section sized ranges to be added to the memmap.
populate_section_memmap() takes an explict pfn range rather than
assuming a full section, and those parameters are plumbed all the way
through to vmmemap_populate(). There should be no sub-section usage in
current deployments. New warnings are added to clarify which memmap
allocation paths are sub-section capable.

Cc: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/init_64.c |    4 ++-
 include/linux/mm.h    |    4 ++-
 mm/sparse-vmemmap.c   |   21 +++++++++++------
 mm/sparse.c           |   61 +++++++++++++++++++++++++++++++------------------
 4 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 20d14254b686..bb018d09d2dc 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1457,7 +1457,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int err;
 
-	if (boot_cpu_has(X86_FEATURE_PSE))
+	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
+		err = vmemmap_populate_basepages(start, end, node);
+	else if (boot_cpu_has(X86_FEATURE_PSE))
 		err = vmemmap_populate_hugepages(start, end, node, altmap);
 	else if (altmap) {
 		pr_err_once("%s: no cpu support for altmap allocations\n",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e8834ac32b7..5360a0e4051d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2748,8 +2748,8 @@ const char * arch_vma_name(struct vm_area_struct *vma);
 void print_vma_addr(char *prefix, unsigned long rip);
 
 void *sparse_buffer_alloc(unsigned long size);
-struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
-		struct vmem_altmap *altmap);
+struct page * __populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap);
 pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
 p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
 pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 7fec05796796..dcb023aa23d1 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -245,19 +245,26 @@ int __meminit vmemmap_populate_basepages(unsigned long start,
 	return 0;
 }
 
-struct page * __meminit sparse_mem_map_populate(unsigned long pnum, int nid,
-		struct vmem_altmap *altmap)
+struct page * __meminit __populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	unsigned long start;
 	unsigned long end;
-	struct page *map;
 
-	map = pfn_to_page(pnum * PAGES_PER_SECTION);
-	start = (unsigned long)map;
-	end = (unsigned long)(map + PAGES_PER_SECTION);
+	/*
+	 * The minimum granularity of memmap extensions is
+	 * SECTION_ACTIVE_SIZE as allocations are tracked in the
+	 * 'map_active' bitmap of the section.
+	 */
+	end = ALIGN(pfn + nr_pages, PHYS_PFN(SECTION_ACTIVE_SIZE));
+	pfn &= PHYS_PFN(SECTION_ACTIVE_MASK);
+	nr_pages = end - pfn;
+
+	start = (unsigned long) pfn_to_page(pfn);
+	end = start + nr_pages * sizeof(struct page);
 
 	if (vmemmap_populate(start, end, nid, altmap))
 		return NULL;
 
-	return map;
+	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 8d4f28e2c25e..ed26761327bf 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -452,8 +452,8 @@ static unsigned long __init section_map_size(void)
 	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
 }
 
-struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid,
-		struct vmem_altmap *altmap)
+struct page __init *__populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	unsigned long size = section_map_size();
 	struct page *map = sparse_buffer_alloc(size);
@@ -534,10 +534,13 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 	}
 	sparse_buffer_init(map_count * section_map_size(), nid);
 	for_each_present_section_nr(pnum_begin, pnum) {
+		unsigned long pfn = section_nr_to_pfn(pnum);
+
 		if (pnum >= pnum_end)
 			break;
 
-		map = sparse_mem_map_populate(pnum, nid, NULL);
+		map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
+				nid, NULL);
 		if (!map) {
 			pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
 			       __func__, nid);
@@ -637,17 +640,17 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
-		struct vmem_altmap *altmap)
+static struct page *populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
-	/* This will make the necessary allocations eventually. */
-	return sparse_mem_map_populate(pnum, nid, altmap);
+	return __populate_section_memmap(pfn, nr_pages, nid, altmap);
 }
-static void __kfree_section_memmap(struct page *memmap,
+
+static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
 {
-	unsigned long start = (unsigned long)memmap;
-	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
+	unsigned long start = (unsigned long) pfn_to_page(pfn);
+	unsigned long end = start + nr_pages * sizeof(struct page);
 
 	vmemmap_free(start, end, altmap);
 }
@@ -661,11 +664,18 @@ static void free_map_bootmem(struct page *memmap)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 #else
-static struct page *__kmalloc_section_memmap(void)
+struct page *populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	struct page *page, *ret;
 	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
 
+	if ((pfn & ~PAGE_SECTION_MASK) || nr_pages != PAGES_PER_SECTION) {
+		WARN(1, "%s: called with section unaligned parameters\n",
+				__func__);
+		return NULL;
+	}
+
 	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
 	if (page)
 		goto got_map_page;
@@ -682,15 +692,17 @@ static struct page *__kmalloc_section_memmap(void)
 	return ret;
 }
 
-static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
+static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
 {
-	return __kmalloc_section_memmap();
-}
+	struct page *memmap = pfn_to_page(pfn);
+
+	if ((pfn & ~PAGE_SECTION_MASK) || nr_pages != PAGES_PER_SECTION) {
+		WARN(1, "%s: called with section unaligned parameters\n",
+				__func__);
+		return;
+	}
 
-static void __kfree_section_memmap(struct page *memmap,
-		struct vmem_altmap *altmap)
-{
 	if (is_vmalloc_addr(memmap))
 		vfree(memmap);
 	else
@@ -761,12 +773,13 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 	if (ret < 0 && ret != -EEXIST)
 		return ret;
 	ret = 0;
-	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
+	memmap = populate_section_memmap(start_pfn, PAGES_PER_SECTION, nid,
+			altmap);
 	if (!memmap)
 		return -ENOMEM;
 	usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
 	if (!usage) {
-		__kfree_section_memmap(memmap, altmap);
+		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
 		return -ENOMEM;
 	}
 
@@ -788,7 +801,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 out:
 	if (ret < 0) {
 		kfree(usage);
-		__kfree_section_memmap(memmap, altmap);
+		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
 	}
 	return ret;
 }
@@ -825,7 +838,8 @@ static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 #endif
 
 static void free_section_usage(struct page *memmap,
-		struct mem_section_usage *usage, struct vmem_altmap *altmap)
+		struct mem_section_usage *usage, unsigned long pfn,
+		unsigned long nr_pages, struct vmem_altmap *altmap)
 {
 	struct page *usage_page;
 
@@ -839,7 +853,7 @@ static void free_section_usage(struct page *memmap,
 	if (PageSlab(usage_page) || PageCompound(usage_page)) {
 		kfree(usage);
 		if (memmap)
-			__kfree_section_memmap(memmap, altmap);
+			depopulate_section_memmap(pfn, nr_pages, altmap);
 		return;
 	}
 
@@ -868,7 +882,8 @@ void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
 
 	clear_hwpoisoned_pages(memmap + map_offset,
 			PAGES_PER_SECTION - map_offset);
-	free_section_usage(memmap, usage, altmap);
+	free_section_usage(memmap, usage, section_nr_to_pfn(__section_nr(ms)),
+			PAGES_PER_SECTION, altmap);
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 #endif /* CONFIG_MEMORY_HOTPLUG */

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
