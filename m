Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807E112BEB
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 13:00:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A43EA21244A79;
	Fri,  3 May 2019 04:00:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=osalvador@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1105621244A74
 for <linux-nvdimm@lists.01.org>; Fri,  3 May 2019 04:00:24 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 973F9AEDB;
 Fri,  3 May 2019 11:00:22 +0000 (UTC)
Date: Fri, 3 May 2019 13:00:19 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 08/12] mm/sparsemem: Prepare for sub-section ranges
Message-ID: <20190503110019.GG15740@linux>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677656509.2336373.4432941742094481750.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155677656509.2336373.4432941742094481750.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 01, 2019 at 10:56:05PM -0700, Dan Williams wrote:
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
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/memory_hotplug.h |    7 +-
>  mm/memory_hotplug.c            |  118 +++++++++++++++++++++++++---------------
>  mm/sparse.c                    |    7 +-
>  3 files changed, 83 insertions(+), 49 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index ae892eef8b82..835a94650ee3 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -354,9 +354,10 @@ extern int add_memory_resource(int nid, struct resource *resource);
>  extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap);
>  extern bool is_memblock_offlined(struct memory_block *mem);
> -extern int sparse_add_one_section(int nid, unsigned long start_pfn,
> -				  struct vmem_altmap *altmap);
> -extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
> +extern int sparse_add_section(int nid, unsigned long pfn,
> +		unsigned long nr_pages, struct vmem_altmap *altmap);
> +extern void sparse_remove_section(struct zone *zone, struct mem_section *ms,
> +		unsigned long pfn, unsigned long nr_pages,
>  		unsigned long map_offset, struct vmem_altmap *altmap);
>  extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
>  					  unsigned long pnum);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 108380e20d8f..9f73332af910 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -251,22 +251,44 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
>  }
>  #endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
>  
> -static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
> -		struct vmem_altmap *altmap, bool want_memblock)
> +static int __meminit __add_section(int nid, unsigned long pfn,
> +		unsigned long nr_pages,	struct vmem_altmap *altmap,
> +		bool want_memblock)
>  {
>  	int ret;
>  
> -	if (pfn_valid(phys_start_pfn))
> +	if (pfn_valid(pfn))
>  		return -EEXIST;
>  
> -	ret = sparse_add_one_section(nid, phys_start_pfn, altmap);
> +	ret = sparse_add_section(nid, pfn, nr_pages, altmap);
>  	if (ret < 0)
>  		return ret;
>  
>  	if (!want_memblock)
>  		return 0;
>  
> -	return hotplug_memory_register(nid, __pfn_to_section(phys_start_pfn));
> +	return hotplug_memory_register(nid, __pfn_to_section(pfn));
> +}
> +
> +static int subsection_check(unsigned long pfn, unsigned long nr_pages,
> +		unsigned long flags, const char *reason)
> +{
> +	/*
> +	 * Only allow partial section hotplug for !memblock ranges,
> +	 * since register_new_memory() requires section alignment, and

What is register_new_memory?

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
