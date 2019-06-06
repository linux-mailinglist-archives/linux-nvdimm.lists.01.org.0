Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E437ADF
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 19:21:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F1992128DD50;
	Thu,  6 Jun 2019 10:21:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=osalvador@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 749F82127675B
 for <linux-nvdimm@lists.01.org>; Thu,  6 Jun 2019 10:21:14 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id ADFCEABD0;
 Thu,  6 Jun 2019 17:21:12 +0000 (UTC)
Date: Thu, 6 Jun 2019 19:21:10 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 07/12] mm/sparsemem: Prepare for sub-section ranges
Message-ID: <20190606172110.GC31194@linux>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977191770.2443951.1506588644989416699.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155977191770.2443951.1506588644989416699.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Wed, Jun 05, 2019 at 02:58:37PM -0700, Dan Williams wrote:
> Prepare the memory hot-{add,remove} paths for handling sub-section
> ranges by plumbing the starting page frame and number of pages being
> handled through arch_{add,remove}_memory() to
> sparse_{add,remove}_one_section().
> 
> This is simply plumbing, small cleanups, and some identifier renames. No
> intended functional changes.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/memory_hotplug.h |    5 +-
>  mm/memory_hotplug.c            |  114 +++++++++++++++++++++++++---------------
>  mm/sparse.c                    |   15 ++---
>  3 files changed, 81 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 79e0add6a597..3ab0282b4fe5 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -348,9 +348,10 @@ extern int add_memory_resource(int nid, struct resource *resource);
>  extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap);
>  extern bool is_memblock_offlined(struct memory_block *mem);
> -extern int sparse_add_one_section(int nid, unsigned long start_pfn,
> -				  struct vmem_altmap *altmap);
> +extern int sparse_add_section(int nid, unsigned long pfn,
> +		unsigned long nr_pages, struct vmem_altmap *altmap);
>  extern void sparse_remove_one_section(struct mem_section *ms,
> +		unsigned long pfn, unsigned long nr_pages,
>  		unsigned long map_offset, struct vmem_altmap *altmap);
>  extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
>  					  unsigned long pnum);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4b882c57781a..399bf78bccc5 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -252,51 +252,84 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
>  }
>  #endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
>  
> -static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
> -				   struct vmem_altmap *altmap)
> +static int __meminit __add_section(int nid, unsigned long pfn,
> +		unsigned long nr_pages,	struct vmem_altmap *altmap)
>  {
>  	int ret;
>  
> -	if (pfn_valid(phys_start_pfn))
> +	if (pfn_valid(pfn))
>  		return -EEXIST;
>  
> -	ret = sparse_add_one_section(nid, phys_start_pfn, altmap);
> +	ret = sparse_add_section(nid, pfn, nr_pages, altmap);
>  	return ret < 0 ? ret : 0;
>  }
>  
> +static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
> +		const char *reason)
> +{
> +	/*
> +	 * Disallow all operations smaller than a sub-section and only
> +	 * allow operations smaller than a section for
> +	 * SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
> +	 * enforces a larger memory_block_size_bytes() granularity for
> +	 * memory that will be marked online, so this check should only
> +	 * fire for direct arch_{add,remove}_memory() users outside of
> +	 * add_memory_resource().
> +	 */
> +	unsigned long min_align;
> +
> +	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> +		min_align = PAGES_PER_SUBSECTION;
> +	else
> +		min_align = PAGES_PER_SECTION;
> +	if (!IS_ALIGNED(pfn, min_align)
> +			|| !IS_ALIGNED(nr_pages, min_align)) {
> +		WARN(1, "Misaligned __%s_pages start: %#lx end: #%lx\n",
> +				reason, pfn, pfn + nr_pages - 1);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}


This caught my eye.
Back in patch#4 "Convert kmalloc_section_memmap() to populate_section_memmap()",
you placed a mis-usage check for !CONFIG_SPARSEMEM_VMEMMAP in
populate_section_memmap().

populate_section_memmap() gets called from sparse_add_one_section(), which means
that we should have passed this check, otherwise we cannot go further and call
__add_section().

So, unless I am missing something it seems to me that the check from patch#4 could go?
And I think the same applies to depopulate_section_memmap()?

Besides that, it looks good to me:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
