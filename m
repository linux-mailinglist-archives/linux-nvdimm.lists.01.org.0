Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9521B779
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 May 2019 15:54:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 13AEA212735AB;
	Mon, 13 May 2019 06:54:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=osalvador@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 498522126CFBE
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 06:54:54 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 47787AD64;
 Mon, 13 May 2019 13:54:52 +0000 (UTC)
Date: Mon, 13 May 2019 15:54:24 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v8 09/12] mm/sparsemem: Support sub-section hotplug
Message-ID: <20190513135317.GA31168@linux>
References: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155718601407.130019.14248061058774128227.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155718601407.130019.14248061058774128227.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
 akpm@linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, May 06, 2019 at 04:40:14PM -0700, Dan Williams wrote:
>  
> +void subsection_mask_set(unsigned long *map, unsigned long pfn,
> +		unsigned long nr_pages)
> +{
> +	int idx = subsection_map_index(pfn);
> +	int end = subsection_map_index(pfn + nr_pages - 1);
> +
> +	bitmap_set(map, idx, end - idx + 1);
> +}
> +
>  void subsection_map_init(unsigned long pfn, unsigned long nr_pages)
>  {
>  	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> @@ -219,20 +235,17 @@ void subsection_map_init(unsigned long pfn, unsigned long nr_pages)
>  		return;
>  
>  	for (i = start_sec; i <= end_sec; i++) {
> -		int idx, end;
> -		unsigned long pfns;
>  		struct mem_section *ms;
> +		unsigned long pfns;
>  
> -		idx = subsection_map_index(pfn);
>  		pfns = min(nr_pages, PAGES_PER_SECTION
>  				- (pfn & ~PAGE_SECTION_MASK));
> -		end = subsection_map_index(pfn + pfns - 1);
> -
>  		ms = __nr_to_section(i);
> -		bitmap_set(ms->usage->subsection_map, idx, end - idx + 1);
> +		subsection_mask_set(ms->usage->subsection_map, pfn, pfns);
>  
>  		pr_debug("%s: sec: %d pfns: %ld set(%d, %d)\n", __func__, i,
> -				pfns, idx, end - idx + 1);
> +				pfns, subsection_map_index(pfn),
> +				subsection_map_index(pfn + pfns - 1));

I would definetely add subsection_mask_set() and above change to Patch#3.
I think it suits there better than here.

>  
>  		pfn += pfns;
>  		nr_pages -= pfns;
> @@ -319,6 +332,15 @@ static void __meminit sparse_init_one_section(struct mem_section *ms,
>  		unsigned long pnum, struct page *mem_map,
>  		struct mem_section_usage *usage)
>  {
> +	/*
> +	 * Given that SPARSEMEM_VMEMMAP=y supports sub-section hotplug,
> +	 * ->section_mem_map can not be guaranteed to point to a full
> +	 *  section's worth of memory.  The field is only valid / used
> +	 *  in the SPARSEMEM_VMEMMAP=n case.
> +	 */
> +	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> +		mem_map = NULL;
> +
>  	ms->section_mem_map &= ~SECTION_MAP_MASK;
>  	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum) |
>  							SECTION_HAS_MEM_MAP;
> @@ -724,10 +746,142 @@ static void free_map_bootmem(struct page *memmap)
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  
> +#ifndef CONFIG_MEMORY_HOTREMOVE
> +static void free_map_bootmem(struct page *memmap)
> +{
> +}
> +#endif
> +
> +static bool is_early_section(struct mem_section *ms)
> +{
> +	struct page *usage_page;
> +
> +	usage_page = virt_to_page(ms->usage);
> +	if (PageSlab(usage_page) || PageCompound(usage_page))
> +		return false;
> +	else
> +		return true;
> +}
> +
> +static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> +		int nid, struct vmem_altmap *altmap)
> +{
> +	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> +	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> +	struct mem_section *ms = __pfn_to_section(pfn);
> +	bool early_section = is_early_section(ms);
> +	struct page *memmap = NULL;
> +	unsigned long *subsection_map = ms->usage
> +		? &ms->usage->subsection_map[0] : NULL;
> +
> +	subsection_mask_set(map, pfn, nr_pages);
> +	if (subsection_map)
> +		bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
> +
> +	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> +				"section already deactivated (%#lx + %ld)\n",
> +				pfn, nr_pages))
> +		return;
> +
> +	if (WARN(!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP)
> +				&& nr_pages < PAGES_PER_SECTION,
> +				"partial memory section removal not supported\n"))
> +		return;
> +
> +	/*
> +	 * There are 3 cases to handle across two configurations
> +	 * (SPARSEMEM_VMEMMAP={y,n}):
> +	 *
> +	 * 1/ deactivation of a partial hot-added section (only possible
> +	 * in the SPARSEMEM_VMEMMAP=y case).
> +	 *    a/ section was present at memory init
> +	 *    b/ section was hot-added post memory init
> +	 * 2/ deactivation of a complete hot-added section
> +	 * 3/ deactivation of a complete section from memory init
> +	 *
> +	 * For 1/, when subsection_map does not empty we will not be
> +	 * freeing the usage map, but still need to free the vmemmap
> +	 * range.
> +	 *
> +	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
> +	 */
> +	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> +	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
> +		unsigned long section_nr = pfn_to_section_nr(pfn);
> +
> +		if (!early_section) {
> +			kfree(ms->usage);
> +			ms->usage = NULL;
> +		}
> +		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> +		ms->section_mem_map = sparse_encode_mem_map(NULL, section_nr);
> +	}
> +
> +	if (early_section && memmap)
> +		free_map_bootmem(memmap);
> +	else
> +		depopulate_section_memmap(pfn, nr_pages, altmap);
> +}
> +
> +static struct page * __meminit section_activate(int nid, unsigned long pfn,
> +		unsigned long nr_pages, struct vmem_altmap *altmap)
> +{
> +	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> +	struct mem_section *ms = __pfn_to_section(pfn);
> +	struct mem_section_usage *usage = NULL;
> +	unsigned long *subsection_map;
> +	struct page *memmap;
> +	int rc = 0;
> +
> +	subsection_mask_set(map, pfn, nr_pages);
> +
> +	if (!ms->usage) {
> +		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> +		if (!usage)
> +			return ERR_PTR(-ENOMEM);
> +		ms->usage = usage;
> +	}
> +	subsection_map = &ms->usage->subsection_map[0];
> +
> +	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> +		rc = -EINVAL;
> +	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
> +		rc = -EEXIST;
> +	else
> +		bitmap_or(subsection_map, map, subsection_map,
> +				SUBSECTIONS_PER_SECTION);
> +
> +	if (rc) {
> +		if (usage)
> +			ms->usage = NULL;
> +		kfree(usage);
> +		return ERR_PTR(rc);
> +	}
> +
> +	/*
> +	 * The early init code does not consider partially populated
> +	 * initial sections, it simply assumes that memory will never be
> +	 * referenced.  If we hot-add memory into such a section then we
> +	 * do not need to populate the memmap and can simply reuse what
> +	 * is already there.
> +	 */
> +	if (nr_pages < PAGES_PER_SECTION && is_early_section(ms))
> +		return pfn_to_page(pfn);
> +
> +	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap);
> +	if (!memmap) {
> +		section_deactivate(pfn, nr_pages, nid, altmap);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return memmap;
> +}

I do not really like this.
Sub-section scheme is only available on CONFIG_SPARSE_VMEMMAP, so I would rather
have two internal __section_{activate,deactivate} functions for sparse-vmemmap and
sparse-non-vmemmap.
That way, we can hide all detail implementation and sub-section dance behind
the __section_{activate,deactivate} functions.

> +
> @@ -741,49 +895,31 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap)
>  {
>  	unsigned long section_nr = pfn_to_section_nr(start_pfn);
> -	struct mem_section_usage *usage;
>  	struct mem_section *ms;
>  	struct page *memmap;
>  	int ret;
>  
> -	/*
> -	 * no locking for this, because it does its own
> -	 * plus, it does a kmalloc
> -	 */
>  	ret = sparse_index_init(section_nr, nid);
>  	if (ret < 0 && ret != -EEXIST)
>  		return ret;
> -	ret = 0;
> -	memmap = populate_section_memmap(start_pfn, PAGES_PER_SECTION, nid,
> -			altmap);
> -	if (!memmap)
> -		return -ENOMEM;
> -	usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> -	if (!usage) {
> -		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
> -		return -ENOMEM;
> -	}
>  
> -	ms = __pfn_to_section(start_pfn);
> -	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
> -		ret = -EEXIST;
> -		goto out;
> -	}
> +	memmap = section_activate(nid, start_pfn, nr_pages, altmap);
> +	if (IS_ERR(memmap))
> +		return PTR_ERR(memmap);
> +	ret = 0;
>  
>  	/*
>  	 * Poison uninitialized struct pages in order to catch invalid flags
>  	 * combinations.
>  	 */
> -	page_init_poison(memmap, sizeof(struct page) * PAGES_PER_SECTION);
> +	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
>  
> +	ms = __pfn_to_section(start_pfn);
>  	section_mark_present(ms);
> -	sparse_init_one_section(ms, section_nr, memmap, usage);
> +	sparse_init_one_section(ms, section_nr, memmap, ms->usage);
>  
> -out:
> -	if (ret < 0) {
> -		kfree(usage);
> -		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
> -	}
> +	if (ret < 0)
> +		section_deactivate(start_pfn, nr_pages, nid, altmap);
>  	return ret;
>  }

diff --git a/mm/sparse.c b/mm/sparse.c
index 34f322d14e62..daeb2d7d8dd0 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -900,13 +900,12 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
        int ret;
 
        ret = sparse_index_init(section_nr, nid);
-       if (ret < 0 && ret != -EEXIST)
+       if (ret < 0)
                return ret;
 
        memmap = section_activate(nid, start_pfn, nr_pages, altmap);
        if (IS_ERR(memmap))
                return PTR_ERR(memmap);
-       ret = 0;
 
        /*
         * Poison uninitialized struct pages in order to catch invalid flags
@@ -918,8 +917,6 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
        section_mark_present(ms);
        sparse_init_one_section(ms, section_nr, memmap, ms->usage);
 
-       if (ret < 0)
-               section_deactivate(start_pfn, nr_pages, nid, altmap);
        return ret;
 }

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
