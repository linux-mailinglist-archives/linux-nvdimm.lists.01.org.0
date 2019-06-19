Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5000D4B1D5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Jun 2019 08:06:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2FC6921296701;
	Tue, 18 Jun 2019 23:06:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 80473212966E4
 for <linux-nvdimm@lists.01.org>; Tue, 18 Jun 2019 23:06:18 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jun 2019 23:06:18 -0700
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; d="scan'208";a="358511698"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jun 2019 23:06:17 -0700
Subject: [PATCH v10 05/13] mm/sparsemem: Convert kmalloc_section_memmap() to
 populate_section_memmap()
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Tue, 18 Jun 2019 22:52:00 -0700
Message-ID: <156092352058.979959.6551283472062305149.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 David Hildenbrand <david@redhat.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Oscar Salvador <osalvador@suse.de>
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
Cc: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/init_64.c |    4 +++-
 include/linux/mm.h    |    4 ++--
 mm/sparse-vmemmap.c   |   21 ++++++++++++++-------
 mm/sparse.c           |   50 ++++++++++++++++++++++++++-----------------------
 4 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8335ac6e1112..688fb0687e55 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1520,7 +1520,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
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
index c6ae9eba645d..f7616518124e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2752,8 +2752,8 @@ const char * arch_vma_name(struct vm_area_struct *vma);
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
index 7fec05796796..200aef686722 100644
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
+	 * PAGES_PER_SUBSECTION as allocations are tracked in the
+	 * 'subsection_map' bitmap of the section.
+	 */
+	end = ALIGN(pfn + nr_pages, PAGES_PER_SUBSECTION);
+	pfn &= PAGE_SUBSECTION_MASK;
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
index e9fec3c2f7ec..49f0c03d15a3 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -439,8 +439,8 @@ static unsigned long __init section_map_size(void)
 	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
 }
 
-struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid,
-		struct vmem_altmap *altmap)
+struct page __init *__populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	unsigned long size = section_map_size();
 	struct page *map = sparse_buffer_alloc(size);
@@ -521,10 +521,13 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
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
@@ -625,17 +628,17 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
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
@@ -647,7 +650,8 @@ static void free_map_bootmem(struct page *memmap)
 	vmemmap_free(start, end, NULL);
 }
 #else
-static struct page *__kmalloc_section_memmap(void)
+struct page *populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	struct page *page, *ret;
 	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
@@ -668,15 +672,11 @@ static struct page *__kmalloc_section_memmap(void)
 	return ret;
 }
 
-static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
+static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
 {
-	return __kmalloc_section_memmap();
-}
+	struct page *memmap = pfn_to_page(pfn);
 
-static void __kfree_section_memmap(struct page *memmap,
-		struct vmem_altmap *altmap)
-{
 	if (is_vmalloc_addr(memmap))
 		vfree(memmap);
 	else
@@ -745,12 +745,13 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
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
 
@@ -772,7 +773,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 out:
 	if (ret < 0) {
 		kfree(usage);
-		__kfree_section_memmap(memmap, altmap);
+		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
 	}
 	return ret;
 }
@@ -808,7 +809,8 @@ static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 #endif
 
 static void free_section_usage(struct mem_section *ms, struct page *memmap,
-		struct mem_section_usage *usage, struct vmem_altmap *altmap)
+		struct mem_section_usage *usage, unsigned long pfn,
+		unsigned long nr_pages, struct vmem_altmap *altmap)
 {
 	if (!usage)
 		return;
@@ -819,7 +821,7 @@ static void free_section_usage(struct mem_section *ms, struct page *memmap,
 	if (!early_section(ms)) {
 		kfree(usage);
 		if (memmap)
-			__kfree_section_memmap(memmap, altmap);
+			depopulate_section_memmap(pfn, nr_pages, altmap);
 		return;
 	}
 
@@ -848,6 +850,8 @@ void sparse_remove_one_section(struct mem_section *ms, unsigned long map_offset,
 
 	clear_hwpoisoned_pages(memmap + map_offset,
 			PAGES_PER_SECTION - map_offset);
-	free_section_usage(ms, memmap, usage, altmap);
+	free_section_usage(ms, memmap, usage,
+			section_nr_to_pfn(__section_nr(ms)),
+			PAGES_PER_SECTION, altmap);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
