Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9EA4B1DE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Jun 2019 08:06:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DD0B921962301;
	Tue, 18 Jun 2019 23:06:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E8DEE21296419
 for <linux-nvdimm@lists.01.org>; Tue, 18 Jun 2019 23:06:41 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jun 2019 23:06:41 -0700
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; d="scan'208";a="186352097"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jun 2019 23:06:40 -0700
Subject: [PATCH v10 09/13] mm/sparsemem: Support sub-section hotplug
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Tue, 18 Jun 2019 22:52:23 -0700
Message-ID: <156092354368.979959.6232443923440952359.stgit@dwillia2-desk3.amr.corp.intel.com>
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
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The libnvdimm sub-system has suffered a series of hacks and broken
workarounds for the memory-hotplug implementation's awkward
section-aligned (128MB) granularity. For example the following backtrace
is emitted when attempting arch_add_memory() with physical address
ranges that intersect 'System RAM' (RAM) with 'Persistent Memory' (PMEM)
within a given section:

    # cat /proc/iomem | grep -A1 -B1 Persistent\ Memory
    100000000-1ffffffff : System RAM
    200000000-303ffffff : Persistent Memory (legacy)
    304000000-43fffffff : System RAM
    440000000-23ffffffff : Persistent Memory
    2400000000-43bfffffff : Persistent Memory
      2400000000-43bfffffff : namespace2.0

    WARNING: CPU: 38 PID: 928 at arch/x86/mm/init_64.c:850 add_pages+0x5c/0x60
    [..]
    RIP: 0010:add_pages+0x5c/0x60
    [..]
    Call Trace:
     devm_memremap_pages+0x460/0x6e0
     pmem_attach_disk+0x29e/0x680 [nd_pmem]
     ? nd_dax_probe+0xfc/0x120 [libnvdimm]
     nvdimm_bus_probe+0x66/0x160 [libnvdimm]

It was discovered that the problem goes beyond RAM vs PMEM collisions as
some platform produce PMEM vs PMEM collisions within a given section.
The libnvdimm workaround for that case revealed that the libnvdimm
section-alignment-padding implementation has been broken for a long
while. A fix for that long-standing breakage introduces as many problems
as it solves as it would require a backward-incompatible change to the
namespace metadata interpretation. Instead of that dubious route [1],
address the root problem in the memory-hotplug implementation.

Note that EEXIST is no longer treated as success as that is how
sparse_add_section() reports subsection collisions, it was also obviated
by recent changes to perform the request_region() for 'System RAM'
before arch_add_memory() in the add_memory() sequence.

[1]: https://lore.kernel.org/r/155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memory_hotplug.h |    2 
 mm/memory_hotplug.c            |   27 +----
 mm/page_alloc.c                |    2 
 mm/sparse.c                    |  205 ++++++++++++++++++++++++++--------------
 4 files changed, 140 insertions(+), 96 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 3ab0282b4fe5..0b8a5e5ef2da 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -350,7 +350,7 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 extern bool is_memblock_offlined(struct memory_block *mem);
 extern int sparse_add_section(int nid, unsigned long pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap);
-extern void sparse_remove_one_section(struct mem_section *ms,
+extern void sparse_remove_section(struct mem_section *ms,
 		unsigned long pfn, unsigned long nr_pages,
 		unsigned long map_offset, struct vmem_altmap *altmap);
 extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 399bf78bccc5..4e8e65954f31 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -252,18 +252,6 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
 }
 #endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
 
-static int __meminit __add_section(int nid, unsigned long pfn,
-		unsigned long nr_pages,	struct vmem_altmap *altmap)
-{
-	int ret;
-
-	if (pfn_valid(pfn))
-		return -EEXIST;
-
-	ret = sparse_add_section(nid, pfn, nr_pages, altmap);
-	return ret < 0 ? ret : 0;
-}
-
 static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 		const char *reason)
 {
@@ -327,18 +315,11 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 
 		pfns = min(nr_pages, PAGES_PER_SECTION
 				- (pfn & ~PAGE_SECTION_MASK));
-		err = __add_section(nid, pfn, pfns, altmap);
+		err = sparse_add_section(nid, pfn, pfns, altmap);
+		if (err)
+			break;
 		pfn += pfns;
 		nr_pages -= pfns;
-
-		/*
-		 * EEXIST is finally dealt with by ioresource collision
-		 * check. see add_memory() => register_memory_resource()
-		 * Warning will be printed if there is collision.
-		 */
-		if (err && (err != -EEXIST))
-			break;
-		err = 0;
 		cond_resched();
 	}
 	vmemmap_populate_print_last();
@@ -541,7 +522,7 @@ static void __remove_section(struct zone *zone, unsigned long pfn,
 		return;
 
 	__remove_zone(zone, pfn, nr_pages);
-	sparse_remove_one_section(ms, pfn, nr_pages, map_offset, altmap);
+	sparse_remove_section(ms, pfn, nr_pages, map_offset, altmap);
 }
 
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12b2afd3a529..5b3266d63521 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5931,7 +5931,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		 * pfn out of zone.
 		 *
 		 * Please note that MEMMAP_HOTPLUG path doesn't clear memmap
-		 * because this is done early in sparse_add_one_section
+		 * because this is done early in section_activate()
 		 */
 		if (!(pfn & (pageblock_nr_pages - 1))) {
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
diff --git a/mm/sparse.c b/mm/sparse.c
index ad47e25c8f94..b77ca21a27a4 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -83,8 +83,15 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
 	unsigned long root = SECTION_NR_TO_ROOT(section_nr);
 	struct mem_section *section;
 
+	/*
+	 * An existing section is possible in the sub-section hotplug
+	 * case. First hot-add instantiates, follow-on hot-add reuses
+	 * the existing section.
+	 *
+	 * The mem_hotplug_lock resolves the apparent race below.
+	 */
 	if (mem_section[root])
-		return -EEXIST;
+		return 0;
 
 	section = sparse_index_alloc(nid);
 	if (!section)
@@ -715,10 +722,119 @@ static void free_map_bootmem(struct page *memmap)
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
+static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap)
+{
+	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
+	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
+	struct mem_section *ms = __pfn_to_section(pfn);
+	struct page *memmap = NULL;
+	unsigned long *subsection_map = ms->usage
+		? &ms->usage->subsection_map[0] : NULL;
+
+	subsection_mask_set(map, pfn, nr_pages);
+	if (subsection_map)
+		bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
+
+	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
+				"section already deactivated (%#lx + %ld)\n",
+				pfn, nr_pages))
+		return;
+
+	/*
+	 * There are 3 cases to handle across two configurations
+	 * (SPARSEMEM_VMEMMAP={y,n}):
+	 *
+	 * 1/ deactivation of a partial hot-added section (only possible
+	 * in the SPARSEMEM_VMEMMAP=y case).
+	 *    a/ section was present at memory init
+	 *    b/ section was hot-added post memory init
+	 * 2/ deactivation of a complete hot-added section
+	 * 3/ deactivation of a complete section from memory init
+	 *
+	 * For 1/, when subsection_map does not empty we will not be
+	 * freeing the usage map, but still need to free the vmemmap
+	 * range.
+	 *
+	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
+	 */
+	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
+	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
+		unsigned long section_nr = pfn_to_section_nr(pfn);
+
+		if (!early_section(ms)) {
+			kfree(ms->usage);
+			ms->usage = NULL;
+		}
+		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
+		ms->section_mem_map = sparse_encode_mem_map(NULL, section_nr);
+	}
+
+	if (early_section(ms) && memmap)
+		free_map_bootmem(memmap);
+	else
+		depopulate_section_memmap(pfn, nr_pages, altmap);
+}
+
+static struct page * __meminit section_activate(int nid, unsigned long pfn,
+		unsigned long nr_pages, struct vmem_altmap *altmap)
+{
+	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
+	struct mem_section *ms = __pfn_to_section(pfn);
+	struct mem_section_usage *usage = NULL;
+	unsigned long *subsection_map;
+	struct page *memmap;
+	int rc = 0;
+
+	subsection_mask_set(map, pfn, nr_pages);
+
+	if (!ms->usage) {
+		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
+		if (!usage)
+			return ERR_PTR(-ENOMEM);
+		ms->usage = usage;
+	}
+	subsection_map = &ms->usage->subsection_map[0];
+
+	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
+		rc = -EINVAL;
+	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
+		rc = -EEXIST;
+	else
+		bitmap_or(subsection_map, map, subsection_map,
+				SUBSECTIONS_PER_SECTION);
+
+	if (rc) {
+		if (usage)
+			ms->usage = NULL;
+		kfree(usage);
+		return ERR_PTR(rc);
+	}
+
+	/*
+	 * The early init code does not consider partially populated
+	 * initial sections, it simply assumes that memory will never be
+	 * referenced.  If we hot-add memory into such a section then we
+	 * do not need to populate the memmap and can simply reuse what
+	 * is already there.
+	 */
+	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
+		return pfn_to_page(pfn);
+
+	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap);
+	if (!memmap) {
+		section_deactivate(pfn, nr_pages, altmap);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return memmap;
+}
+
 /**
- * sparse_add_one_section - add a memory section
+ * sparse_add_section - add a memory section, or populate an existing one
  * @nid: The node to add section on
  * @start_pfn: start pfn of the memory range
+ * @nr_pages: number of pfns to add in the section
  * @altmap: device page map
  *
  * This is only intended for hotplug.
@@ -732,50 +848,33 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap)
 {
 	unsigned long section_nr = pfn_to_section_nr(start_pfn);
-	struct mem_section_usage *usage;
 	struct mem_section *ms;
 	struct page *memmap;
 	int ret;
 
-	/*
-	 * no locking for this, because it does its own
-	 * plus, it does a kmalloc
-	 */
 	ret = sparse_index_init(section_nr, nid);
-	if (ret < 0 && ret != -EEXIST)
+	if (ret < 0)
 		return ret;
-	ret = 0;
-	memmap = populate_section_memmap(start_pfn, PAGES_PER_SECTION, nid,
-			altmap);
-	if (!memmap)
-		return -ENOMEM;
-	usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
-	if (!usage) {
-		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
-		return -ENOMEM;
-	}
 
-	ms = __pfn_to_section(start_pfn);
-	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
-		ret = -EEXIST;
-		goto out;
-	}
+	memmap = section_activate(nid, start_pfn, nr_pages, altmap);
+	if (IS_ERR(memmap))
+		return PTR_ERR(memmap);
 
 	/*
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	page_init_poison(memmap, sizeof(struct page) * PAGES_PER_SECTION);
+	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
 
+	ms = __pfn_to_section(start_pfn);
 	section_mark_present(ms);
-	sparse_init_one_section(ms, section_nr, memmap, usage, 0);
 
-out:
-	if (ret < 0) {
-		kfree(usage);
-		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
-	}
-	return ret;
+	/* Align memmap to section boundary in the subsection case */
+	if (section_nr_to_pfn(section_nr) != start_pfn)
+		memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
+	sparse_init_one_section(ms, section_nr, memmap, ms->usage, 0);
+
+	return 0;
 }
 
 #ifdef CONFIG_MEMORY_FAILURE
@@ -808,48 +907,12 @@ static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 }
 #endif
 
-static void free_section_usage(struct mem_section *ms, struct page *memmap,
-		struct mem_section_usage *usage, unsigned long pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap)
-{
-	if (!usage)
-		return;
-
-	/*
-	 * Check to see if allocation came from hot-plug-add
-	 */
-	if (!early_section(ms)) {
-		kfree(usage);
-		if (memmap)
-			depopulate_section_memmap(pfn, nr_pages, altmap);
-		return;
-	}
-
-	/*
-	 * The usemap came from bootmem. This is packed with other usemaps
-	 * on the section which has pgdat at boot time. Just keep it as is now.
-	 */
-
-	if (memmap)
-		free_map_bootmem(memmap);
-}
-
-void sparse_remove_one_section(struct mem_section *ms, unsigned long pfn,
+void sparse_remove_section(struct mem_section *ms, unsigned long pfn,
 		unsigned long nr_pages, unsigned long map_offset,
 		struct vmem_altmap *altmap)
 {
-	struct page *memmap = NULL;
-	struct mem_section_usage *usage = NULL;
-
-	if (ms->section_mem_map) {
-		usage = ms->usage;
-		memmap = sparse_decode_mem_map(ms->section_mem_map,
-						__section_nr(ms));
-		ms->section_mem_map = 0;
-		ms->usage = NULL;
-	}
-
-	clear_hwpoisoned_pages(memmap + map_offset, nr_pages - map_offset);
-	free_section_usage(ms, memmap, usage, pfn, nr_pages, altmap);
+	clear_hwpoisoned_pages(pfn_to_page(pfn) + map_offset,
+			nr_pages - map_offset);
+	section_deactivate(pfn, nr_pages, altmap);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
