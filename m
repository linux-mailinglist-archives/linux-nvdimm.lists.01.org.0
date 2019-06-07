Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF7E38660
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 10:34:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8D1A21290DC1;
	Fri,  7 Jun 2019 01:34:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=osalvador@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 454D521290D4F
 for <linux-nvdimm@lists.01.org>; Fri,  7 Jun 2019 01:34:04 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 123A7ABD5;
 Fri,  7 Jun 2019 08:34:03 +0000 (UTC)
Date: Fri, 7 Jun 2019 10:33:58 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 08/12] mm/sparsemem: Support sub-section hotplug
Message-ID: <20190607083351.GA5342@linux>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977192280.2443951.13941265207662462739.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155977192280.2443951.13941265207662462739.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Wed, Jun 05, 2019 at 02:58:42PM -0700, Dan Williams wrote:
> The libnvdimm sub-system has suffered a series of hacks and broken
> workarounds for the memory-hotplug implementation's awkward
> section-aligned (128MB) granularity. For example the following backtrace
> is emitted when attempting arch_add_memory() with physical address
> ranges that intersect 'System RAM' (RAM) with 'Persistent Memory' (PMEM)
> within a given section:
> 
>  WARNING: CPU: 0 PID: 558 at kernel/memremap.c:300 devm_memremap_pages+0x3b5/0x4c0
>  devm_memremap_pages attempted on mixed region [mem 0x200000000-0x2fbffffff flags 0x200]
>  [..]
>  Call Trace:
>    dump_stack+0x86/0xc3
>    __warn+0xcb/0xf0
>    warn_slowpath_fmt+0x5f/0x80
>    devm_memremap_pages+0x3b5/0x4c0
>    __wrap_devm_memremap_pages+0x58/0x70 [nfit_test_iomap]
>    pmem_attach_disk+0x19a/0x440 [nd_pmem]
> 
> Recently it was discovered that the problem goes beyond RAM vs PMEM
> collisions as some platform produce PMEM vs PMEM collisions within a
> given section. The libnvdimm workaround for that case revealed that the
> libnvdimm section-alignment-padding implementation has been broken for a
> long while. A fix for that long-standing breakage introduces as many
> problems as it solves as it would require a backward-incompatible change
> to the namespace metadata interpretation. Instead of that dubious route
> [1], address the root problem in the memory-hotplug implementation.
> 
> [1]: https://lore.kernel.org/r/155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/memory_hotplug.h |    2 
>  mm/memory_hotplug.c            |    7 -
>  mm/page_alloc.c                |    2 
>  mm/sparse.c                    |  225 +++++++++++++++++++++++++++-------------
>  4 files changed, 155 insertions(+), 81 deletions(-)
> 
[...]
> @@ -325,6 +332,15 @@ static void __meminit sparse_init_one_section(struct mem_section *ms,
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

Will this be a problem when reading mem_map with the crash-tool?
I do not expect it to be, but I am not sure if crash internally tries
to read ms->section_mem_map and do some sort of translation.
And since ms->section_mem_map SECTION_HAS_MEM_MAP, it might be that it expects
a valid mem_map?

> +static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> +		struct vmem_altmap *altmap)
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

We should not be really looking at subsection_map stuff when running on
!CONFIG_SPARSE_VMEMMAP, right?
Would it make sense to hide the bitmap dance behind

if(IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP)) ?

Sorry for nagging here

>  /**
> - * sparse_add_one_section - add a memory section
> + * sparse_add_section - add a memory section, or populate an existing one
>   * @nid: The node to add section on
>   * @start_pfn: start pfn of the memory range
> + * @nr_pages: number of pfns to add in the section
>   * @altmap: device page map
>   *
>   * This is only intended for hotplug.

Below this, the return codes are specified:

---
 * Return:
 * * 0          - On success.
 * * -EEXIST    - Section has been present.
 * * -ENOMEM    - Out of memory.
 */
---

We can get rid of -EEXIST since we do not return that anymore.

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
