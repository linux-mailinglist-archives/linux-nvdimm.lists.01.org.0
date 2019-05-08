Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C30618299
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 May 2019 01:15:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4F18821256BDF;
	Wed,  8 May 2019 16:15:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=osalvador@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 21CB421250442
 for <linux-nvdimm@lists.01.org>; Wed,  8 May 2019 16:15:53 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7B7EAAF0C;
 Wed,  8 May 2019 23:15:51 +0000 (UTC)
Message-ID: <1557357332.3028.42.camel@suse.de>
Subject: Re: [PATCH v8 09/12] mm/sparsemem: Support sub-section hotplug
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Date: Thu, 09 May 2019 01:15:32 +0200
In-Reply-To: <155718601407.130019.14248061058774128227.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155718601407.130019.14248061058774128227.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
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
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, 2019-05-06 at 16:40 -0700, Dan Williams wrote:
> @@ -741,49 +895,31 @@ int __meminit sparse_add_section(int nid,
> unsigned long start_pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap)
>  {
>  	unsigned long section_nr = pfn_to_section_nr(start_pfn);
> -	struct mem_section_usage *usage;
>  	struct mem_section *ms;
>  	struct page *memmap;
>  	int ret;

I already pointed this out in v7, but:

>  
> -	/*
> -	 * no locking for this, because it does its own
> -	 * plus, it does a kmalloc
> -	 */
>  	ret = sparse_index_init(section_nr, nid);
>  	if (ret < 0 && ret != -EEXIST)
>  		return ret;

sparse_index_init() only returns either -ENOMEM or 0, so the above can
be:

	if (ret < 0) or if (ret)

> -	ret = 0;
> -	memmap = populate_section_memmap(start_pfn,
> PAGES_PER_SECTION, nid,
> -			altmap);
> -	if (!memmap)
> -		return -ENOMEM;
> -	usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> -	if (!usage) {
> -		depopulate_section_memmap(start_pfn,
> PAGES_PER_SECTION, altmap);
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

If we got here, sparse_index_init must have returned 0, so ret already
contains 0.
We can remove the assignment.

>  
>  	/*
>  	 * Poison uninitialized struct pages in order to catch
> invalid flags
>  	 * combinations.
>  	 */
> -	page_init_poison(memmap, sizeof(struct page) *
> PAGES_PER_SECTION);
> +	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page)
> * nr_pages);
>  
> +	ms = __pfn_to_section(start_pfn);
>  	section_mark_present(ms);
> -	sparse_init_one_section(ms, section_nr, memmap, usage);
> +	sparse_init_one_section(ms, section_nr, memmap, ms->usage);
>  
> -out:
> -	if (ret < 0) {
> -		kfree(usage);
> -		depopulate_section_memmap(start_pfn,
> PAGES_PER_SECTION, altmap);
> -	}
> +	if (ret < 0)
> +		section_deactivate(start_pfn, nr_pages, nid,
> altmap);

AFAICS, ret is only set by the return code from sparse_index_init, so
we cannot really get to this code being ret different than 0.
So we can remove the above two lines.

I will start reviewing the patches that lack review from this version
soon.

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
