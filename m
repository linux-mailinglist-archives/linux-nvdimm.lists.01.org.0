Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C1447499
	for <lists+linux-nvdimm@lfdr.de>; Sun, 16 Jun 2019 15:11:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4C4521290D4E;
	Sun, 16 Jun 2019 06:11:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=richard.weiyang@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CCF472128D885
 for <linux-nvdimm@lists.01.org>; Sun, 16 Jun 2019 06:11:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w13so11617364eds.4
 for <linux-nvdimm@lists.01.org>; Sun, 16 Jun 2019 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ata5QGAsstc8uUnWvjTewPr11fCCz69WOh2iEsg2nB4=;
 b=AnuAH6n8hpIrngzqfFxGfx3ZwEEjVikdpTr3SlftaPD8au9ljBkxBMz/GQgvUTWvCc
 6LVmaxswrNXazajQlTTbdItCdN/qBqn1nl1ZW76k6DDb/nry9RgOZw4q2S8mWMYdKERl
 p82Fxh3QBb5l0TDgKO241a7Eg8H2JjLjVOyzQiU8vxF5u6nzMm5+ybhrzfgt8vmtLjpD
 2RzbPaXa67cVf8Risg5ZcD4xG7/GtZn9+uVcLI9EFErGT3LhjsAqWRbfIpzugnwF0d7R
 JLsddo9AE3h7DSHhRHMH8DELZ/lO+Y3YL23XHnMiWsp/142EaA+pKKch+C57A71Sdd5V
 x/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=ata5QGAsstc8uUnWvjTewPr11fCCz69WOh2iEsg2nB4=;
 b=eC3gcPTzw6jd7/iL954vfDvgqMQihKCcI/C6kV8FPk19cl6KVM43ff4guyyXd9rTK9
 wuXqX0lmv3DC2UyrB30wgVZqsBb2Q9MIjRcbT4u+++1IW0b6hUEJEtf5zcdithsQuh+g
 kEgcTRJuiRqHiu1DVkWeBPCCrROopDZj1aYqf4bE7rs/+P7GFtEm5zjWLfyzPhKLEd1H
 sq0mkfuP7OpfFOUBH3aL9o3fuEH7lvCDUrkjrHP482e2LiB1NEG+81CmHdCzOBj+XKzM
 JjuYbFQ4vOV6/SXmVECswTy7ud0Sj7LEOV8oGdaZhpQoWcHe9XT2E4gmWMvXKxi65ocz
 nlaQ==
X-Gm-Message-State: APjAAAUDz7kEytX3YzeCrcJZJV0RZb0YFk5wL95MKxyrSmBM8lLZF3LM
 ocB/iEsvGzHB67fu6ojIjb8=
X-Google-Smtp-Source: APXvYqwpCjIz1ZCq/JtF1GbQJqV7Fs8PAfOrOZryUyBA9T1syhPzFtZzSvKqVXqDrMzZl7Zvv+Cntg==
X-Received: by 2002:a50:b66f:: with SMTP id c44mr46112985ede.171.1560690685517; 
 Sun, 16 Jun 2019 06:11:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id p37sm2810575edc.14.2019.06.16.06.11.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 16 Jun 2019 06:11:24 -0700 (PDT)
Date: Sun, 16 Jun 2019 13:11:23 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 01/12] mm/sparsemem: Introduce struct mem_section_usage
Message-ID: <20190616131123.fkjs4kyg32aryjq6@master>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977187407.2443951.16503493275720588454.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155977187407.2443951.16503493275720588454.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm@lists.01.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 akpm@linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 05, 2019 at 02:57:54PM -0700, Dan Williams wrote:
>Towards enabling memory hotplug to track partial population of a
>section, introduce 'struct mem_section_usage'.
>
>A pointer to a 'struct mem_section_usage' instance replaces the existing
>pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
>'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
>house a new 'subsection_map' bitmap.  The new bitmap enables the memory
>hot{plug,remove} implementation to act on incremental sub-divisions of a
>section.
>
>The default SUBSECTION_SHIFT is chosen to keep the 'subsection_map' no
>larger than a single 'unsigned long' on the major architectures.
>Alternatively an architecture can define ARCH_SUBSECTION_SHIFT to
>override the default PMD_SHIFT. Note that PowerPC needs to use
>ARCH_SUBSECTION_SHIFT to workaround PMD_SHIFT being a non-constant
>expression on PowerPC.
>
>The primary motivation for this functionality is to support platforms
>that mix "System RAM" and "Persistent Memory" within a single section,
>or multiple PMEM ranges with different mapping lifetimes within a single
>section. The section restriction for hotplug has caused an ongoing saga
>of hacks and bugs for devm_memremap_pages() users.
>
>Beyond the fixups to teach existing paths how to retrieve the 'usemap'
>from a section, and updates to usemap allocation path, there are no
>expected behavior changes.
>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Vlastimil Babka <vbabka@suse.cz>
>Cc: Logan Gunthorpe <logang@deltatee.com>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Cc: Paul Mackerras <paulus@samba.org>
>Cc: Michael Ellerman <mpe@ellerman.id.au>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>---
> arch/powerpc/include/asm/sparsemem.h |    3 +
> include/linux/mmzone.h               |   48 +++++++++++++++++++-
> mm/memory_hotplug.c                  |   18 ++++----
> mm/page_alloc.c                      |    2 -
> mm/sparse.c                          |   81 +++++++++++++++++-----------------
> 5 files changed, 99 insertions(+), 53 deletions(-)
>
>diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
>index 3192d454a733..1aa3c9303bf8 100644
>--- a/arch/powerpc/include/asm/sparsemem.h
>+++ b/arch/powerpc/include/asm/sparsemem.h
>@@ -10,6 +10,9 @@
>  */
> #define SECTION_SIZE_BITS       24
> 
>+/* Reflect the largest possible PMD-size as the subsection-size constant */
>+#define ARCH_SUBSECTION_SHIFT 24
>+
> #endif /* CONFIG_SPARSEMEM */
> 
> #ifdef CONFIG_MEMORY_HOTPLUG
>diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>index 427b79c39b3c..ac163f2f274f 100644
>--- a/include/linux/mmzone.h
>+++ b/include/linux/mmzone.h
>@@ -1161,6 +1161,44 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
> #define SECTION_ALIGN_UP(pfn)	(((pfn) + PAGES_PER_SECTION - 1) & PAGE_SECTION_MASK)
> #define SECTION_ALIGN_DOWN(pfn)	((pfn) & PAGE_SECTION_MASK)
> 
>+/*
>+ * SUBSECTION_SHIFT must be constant since it is used to declare
>+ * subsection_map and related bitmaps without triggering the generation
>+ * of variable-length arrays. The most natural size for a subsection is
>+ * a PMD-page. For architectures that do not have a constant PMD-size
>+ * ARCH_SUBSECTION_SHIFT can be set to a constant max size, or otherwise
>+ * fallback to 2MB.
>+ */
>+#if defined(ARCH_SUBSECTION_SHIFT)
>+#define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
>+#elif defined(PMD_SHIFT)
>+#define SUBSECTION_SHIFT (PMD_SHIFT)
>+#else
>+/*
>+ * Memory hotplug enabled platforms avoid this default because they
>+ * either define ARCH_SUBSECTION_SHIFT, or PMD_SHIFT is a constant, but
>+ * this is kept as a backstop to allow compilation on
>+ * !ARCH_ENABLE_MEMORY_HOTPLUG archs.
>+ */
>+#define SUBSECTION_SHIFT 21
>+#endif
>+
>+#define PFN_SUBSECTION_SHIFT (SUBSECTION_SHIFT - PAGE_SHIFT)
>+#define PAGES_PER_SUBSECTION (1UL << PFN_SUBSECTION_SHIFT)
>+#define PAGE_SUBSECTION_MASK ((~(PAGES_PER_SUBSECTION-1)))

One pair of brackets could be removed, IMHO.

>+
>+#if SUBSECTION_SHIFT > SECTION_SIZE_BITS
>+#error Subsection size exceeds section size
>+#else
>+#define SUBSECTIONS_PER_SECTION (1UL << (SECTION_SIZE_BITS - SUBSECTION_SHIFT))
>+#endif
>+
>+struct mem_section_usage {
>+	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
>+	/* See declaration of similar field in struct zone */
>+	unsigned long pageblock_flags[0];
>+};
>+
> struct page;
> struct page_ext;
> struct mem_section {
>@@ -1178,8 +1216,7 @@ struct mem_section {
> 	 */
> 	unsigned long section_mem_map;
> 
>-	/* See declaration of similar field in struct zone */
>-	unsigned long *pageblock_flags;
>+	struct mem_section_usage *usage;
> #ifdef CONFIG_PAGE_EXTENSION
> 	/*
> 	 * If SPARSEMEM, pgdat doesn't have page_ext pointer. We use
>@@ -1210,6 +1247,11 @@ extern struct mem_section **mem_section;
> extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
> #endif
> 
>+static inline unsigned long *section_to_usemap(struct mem_section *ms)
>+{
>+	return ms->usage->pageblock_flags;

Do we need to consider the case when ms->usage is NULL?

>+}
>+
> static inline struct mem_section *__nr_to_section(unsigned long nr)
> {
> #ifdef CONFIG_SPARSEMEM_EXTREME
>@@ -1221,7 +1263,7 @@ static inline struct mem_section *__nr_to_section(unsigned long nr)
> 	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
> }
> extern int __section_nr(struct mem_section* ms);
>-extern unsigned long usemap_size(void);
>+extern size_t mem_section_usage_size(void);
> 
> /*
>  * We use the lower bits of the mem_map pointer to store
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index a88c5f334e5a..7b963c2d3a0d 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -166,9 +166,10 @@ void put_page_bootmem(struct page *page)
> #ifndef CONFIG_SPARSEMEM_VMEMMAP
> static void register_page_bootmem_info_section(unsigned long start_pfn)
> {
>-	unsigned long *usemap, mapsize, section_nr, i;
>+	unsigned long mapsize, section_nr, i;
> 	struct mem_section *ms;
> 	struct page *page, *memmap;
>+	struct mem_section_usage *usage;
> 
> 	section_nr = pfn_to_section_nr(start_pfn);
> 	ms = __nr_to_section(section_nr);
>@@ -188,10 +189,10 @@ static void register_page_bootmem_info_section(unsigned long start_pfn)
> 	for (i = 0; i < mapsize; i++, page++)
> 		get_page_bootmem(section_nr, page, SECTION_INFO);
> 
>-	usemap = ms->pageblock_flags;
>-	page = virt_to_page(usemap);
>+	usage = ms->usage;
>+	page = virt_to_page(usage);
> 
>-	mapsize = PAGE_ALIGN(usemap_size()) >> PAGE_SHIFT;
>+	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
> 
> 	for (i = 0; i < mapsize; i++, page++)
> 		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
>@@ -200,9 +201,10 @@ static void register_page_bootmem_info_section(unsigned long start_pfn)
> #else /* CONFIG_SPARSEMEM_VMEMMAP */
> static void register_page_bootmem_info_section(unsigned long start_pfn)
> {
>-	unsigned long *usemap, mapsize, section_nr, i;
>+	unsigned long mapsize, section_nr, i;
> 	struct mem_section *ms;
> 	struct page *page, *memmap;
>+	struct mem_section_usage *usage;
> 
> 	section_nr = pfn_to_section_nr(start_pfn);
> 	ms = __nr_to_section(section_nr);
>@@ -211,10 +213,10 @@ static void register_page_bootmem_info_section(unsigned long start_pfn)
> 
> 	register_page_bootmem_memmap(section_nr, memmap, PAGES_PER_SECTION);
> 
>-	usemap = ms->pageblock_flags;
>-	page = virt_to_page(usemap);
>+	usage = ms->usage;
>+	page = virt_to_page(usage);
> 
>-	mapsize = PAGE_ALIGN(usemap_size()) >> PAGE_SHIFT;
>+	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
> 
> 	for (i = 0; i < mapsize; i++, page++)
> 		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index c061f66c2d0c..c6d8224d792e 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -404,7 +404,7 @@ static inline unsigned long *get_pageblock_bitmap(struct page *page,
> 							unsigned long pfn)
> {
> #ifdef CONFIG_SPARSEMEM
>-	return __pfn_to_section(pfn)->pageblock_flags;
>+	return section_to_usemap(__pfn_to_section(pfn));
> #else
> 	return page_zone(page)->pageblock_flags;
> #endif /* CONFIG_SPARSEMEM */
>diff --git a/mm/sparse.c b/mm/sparse.c
>index 1552c855d62a..71da15cc7432 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -288,33 +288,31 @@ struct page *sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long pn
> 
> static void __meminit sparse_init_one_section(struct mem_section *ms,
> 		unsigned long pnum, struct page *mem_map,
>-		unsigned long *pageblock_bitmap)
>+		struct mem_section_usage *usage)
> {
> 	ms->section_mem_map &= ~SECTION_MAP_MASK;
> 	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum) |
> 							SECTION_HAS_MEM_MAP;
>- 	ms->pageblock_flags = pageblock_bitmap;
>+	ms->usage = usage;
> }
> 
>-unsigned long usemap_size(void)
>+static unsigned long usemap_size(void)
> {
> 	return BITS_TO_LONGS(SECTION_BLOCKFLAGS_BITS) * sizeof(unsigned long);
> }
> 
>-#ifdef CONFIG_MEMORY_HOTPLUG
>-static unsigned long *__kmalloc_section_usemap(void)
>+size_t mem_section_usage_size(void)
> {
>-	return kmalloc(usemap_size(), GFP_KERNEL);
>+	return sizeof(struct mem_section_usage) + usemap_size();
> }
>-#endif /* CONFIG_MEMORY_HOTPLUG */
> 
> #ifdef CONFIG_MEMORY_HOTREMOVE
>-static unsigned long * __init
>+static struct mem_section_usage * __init
> sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
> 					 unsigned long size)
> {
>+	struct mem_section_usage *usage;
> 	unsigned long goal, limit;
>-	unsigned long *p;
> 	int nid;
> 	/*
> 	 * A page may contain usemaps for other sections preventing the
>@@ -330,15 +328,16 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
> 	limit = goal + (1UL << PA_SECTION_SHIFT);
> 	nid = early_pfn_to_nid(goal >> PAGE_SHIFT);
> again:
>-	p = memblock_alloc_try_nid(size, SMP_CACHE_BYTES, goal, limit, nid);
>-	if (!p && limit) {
>+	usage = memblock_alloc_try_nid(size, SMP_CACHE_BYTES, goal, limit, nid);
>+	if (!usage && limit) {
> 		limit = 0;
> 		goto again;
> 	}
>-	return p;
>+	return usage;
> }
> 
>-static void __init check_usemap_section_nr(int nid, unsigned long *usemap)
>+static void __init check_usemap_section_nr(int nid,
>+		struct mem_section_usage *usage)
> {
> 	unsigned long usemap_snr, pgdat_snr;
> 	static unsigned long old_usemap_snr;
>@@ -352,7 +351,7 @@ static void __init check_usemap_section_nr(int nid, unsigned long *usemap)
> 		old_pgdat_snr = NR_MEM_SECTIONS;
> 	}
> 
>-	usemap_snr = pfn_to_section_nr(__pa(usemap) >> PAGE_SHIFT);
>+	usemap_snr = pfn_to_section_nr(__pa(usage) >> PAGE_SHIFT);
> 	pgdat_snr = pfn_to_section_nr(__pa(pgdat) >> PAGE_SHIFT);
> 	if (usemap_snr == pgdat_snr)
> 		return;
>@@ -380,14 +379,15 @@ static void __init check_usemap_section_nr(int nid, unsigned long *usemap)
> 		usemap_snr, pgdat_snr, nid);
> }
> #else
>-static unsigned long * __init
>+static struct mem_section_usage * __init
> sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
> 					 unsigned long size)
> {
> 	return memblock_alloc_node(size, SMP_CACHE_BYTES, pgdat->node_id);
> }
> 
>-static void __init check_usemap_section_nr(int nid, unsigned long *usemap)
>+static void __init check_usemap_section_nr(int nid,
>+		struct mem_section_usage *usage)
> {
> }
> #endif /* CONFIG_MEMORY_HOTREMOVE */
>@@ -474,14 +474,13 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> 				   unsigned long pnum_end,
> 				   unsigned long map_count)
> {
>-	unsigned long pnum, usemap_longs, *usemap;
>+	struct mem_section_usage *usage;
>+	unsigned long pnum;
> 	struct page *map;
> 
>-	usemap_longs = BITS_TO_LONGS(SECTION_BLOCKFLAGS_BITS);
>-	usemap = sparse_early_usemaps_alloc_pgdat_section(NODE_DATA(nid),
>-							  usemap_size() *
>-							  map_count);
>-	if (!usemap) {
>+	usage = sparse_early_usemaps_alloc_pgdat_section(NODE_DATA(nid),
>+			mem_section_usage_size() * map_count);
>+	if (!usage) {
> 		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
> 		goto failed;
> 	}
>@@ -497,9 +496,9 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> 			pnum_begin = pnum;
> 			goto failed;
> 		}
>-		check_usemap_section_nr(nid, usemap);
>-		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usemap);
>-		usemap += usemap_longs;
>+		check_usemap_section_nr(nid, usage);
>+		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage);
>+		usage = (void *) usage + mem_section_usage_size();
> 	}
> 	sparse_buffer_fini();
> 	return;
>@@ -697,9 +696,9 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
> 				     struct vmem_altmap *altmap)
> {
> 	unsigned long section_nr = pfn_to_section_nr(start_pfn);
>+	struct mem_section_usage *usage;
> 	struct mem_section *ms;
> 	struct page *memmap;
>-	unsigned long *usemap;
> 	int ret;
> 
> 	/*
>@@ -713,8 +712,8 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
> 	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> 	if (!memmap)
> 		return -ENOMEM;
>-	usemap = __kmalloc_section_usemap();
>-	if (!usemap) {
>+	usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
>+	if (!usage) {
> 		__kfree_section_memmap(memmap, altmap);
> 		return -ENOMEM;
> 	}
>@@ -732,11 +731,11 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
> 	page_init_poison(memmap, sizeof(struct page) * PAGES_PER_SECTION);
> 
> 	section_mark_present(ms);
>-	sparse_init_one_section(ms, section_nr, memmap, usemap);
>+	sparse_init_one_section(ms, section_nr, memmap, usage);
> 
> out:
> 	if (ret < 0) {
>-		kfree(usemap);
>+		kfree(usage);
> 		__kfree_section_memmap(memmap, altmap);
> 	}
> 	return ret;
>@@ -772,20 +771,20 @@ static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
> }
> #endif
> 
>-static void free_section_usemap(struct page *memmap, unsigned long *usemap,
>-		struct vmem_altmap *altmap)
>+static void free_section_usage(struct page *memmap,
>+		struct mem_section_usage *usage, struct vmem_altmap *altmap)
> {
>-	struct page *usemap_page;
>+	struct page *usage_page;
> 
>-	if (!usemap)
>+	if (!usage)
> 		return;
> 
>-	usemap_page = virt_to_page(usemap);
>+	usage_page = virt_to_page(usage);
> 	/*
> 	 * Check to see if allocation came from hot-plug-add
> 	 */
>-	if (PageSlab(usemap_page) || PageCompound(usemap_page)) {
>-		kfree(usemap);
>+	if (PageSlab(usage_page) || PageCompound(usage_page)) {
>+		kfree(usage);
> 		if (memmap)
> 			__kfree_section_memmap(memmap, altmap);
> 		return;
>@@ -804,18 +803,18 @@ void sparse_remove_one_section(struct mem_section *ms, unsigned long map_offset,
> 			       struct vmem_altmap *altmap)
> {
> 	struct page *memmap = NULL;
>-	unsigned long *usemap = NULL;
>+	struct mem_section_usage *usage = NULL;
> 
> 	if (ms->section_mem_map) {
>-		usemap = ms->pageblock_flags;
>+		usage = ms->usage;
> 		memmap = sparse_decode_mem_map(ms->section_mem_map,
> 						__section_nr(ms));
> 		ms->section_mem_map = 0;
>-		ms->pageblock_flags = NULL;
>+		ms->usage = NULL;
> 	}
> 
> 	clear_hwpoisoned_pages(memmap + map_offset,
> 			PAGES_PER_SECTION - map_offset);
>-	free_section_usemap(memmap, usemap, altmap);
>+	free_section_usage(memmap, usage, altmap);
> }
> #endif /* CONFIG_MEMORY_HOTPLUG */

-- 
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
