Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B0B2D3B58
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 07:17:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2829100EC1F3;
	Tue,  8 Dec 2020 22:16:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.65; helo=hqnvemgate26.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com [216.228.121.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 40AE5100EF274
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 22:16:54 -0800 (PST)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5fd06bd50003>; Tue, 08 Dec 2020 22:16:53 -0800
Received: from [10.2.60.96] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 06:16:49 +0000
Subject: Re: [PATCH RFC 2/9] sparse-vmemmap: Consolidate arguments in vmemmap
 section populate
To: Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-3-joao.m.martins@oracle.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <0faea767-7af0-6188-5a4e-3d5dd3c4bde9@nvidia.com>
Date: Tue, 8 Dec 2020 22:16:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201208172901.17384-3-joao.m.martins@oracle.com>
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1607494613; bh=goQmjYVpqVu0GZjn5786fzYDnfNC8HZ2JJvsaUGBExM=;
	h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
	 MIME-Version:In-Reply-To:Content-Type:Content-Language:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	b=gMu87jq0Wt6a0RAG1oYxt5P/njea+Jm4O7BvvVhM+hFNX+WkgAFnAyYdPz14tDJKY
	 AJD9450AFzNkPrFCpapSKyfNIfEpwLOdmCCX+dQSgDMI06Ro/OScRZKwNLZWx5+4dV
	 vBzIQtStef+GoE9/z7HqnevhmV/plp/PQFSIy8UM0+k38F9G9WKO2fLKpn9HcspgPI
	 0amZtCpHzLiHC32NUaM9GK4jYZt8WvMIoM3TTZhd0rr95glgkF18UUKdfocV4S71Ay
	 zIWqhi7JlDD33a2wl6sKzP33ZcTznYxvEwtOWvTLq0AUdrMSe00c0RC9JzAN4+/2f+
	 owR3xjer+Kq1w==
Message-ID-Hash: HN4W5X3OIJ3RYV5L7LHTITITFVRXEFFT
X-Message-ID-Hash: HN4W5X3OIJ3RYV5L7LHTITITFVRXEFFT
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>,
	"Jason Gunthorpe  <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song" <songmuchun@bytedance.com>,
	Mike Kravetz <mike.kravetz@oracle.com>, Andrew@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HN4W5X3OIJ3RYV5L7LHTITITFVRXEFFT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/8/20 9:28 AM, Joao Martins wrote:
> Replace vmem_altmap with an vmem_context argument. That let us
> express how the vmemmap is gonna be initialized e.g. passing
> flags and a page size for reusing pages upon initializing the
> vmemmap.

How about this instead:

Replace the vmem_altmap argument with a vmem_context argument that
contains vmem_altmap for now. Subsequent patches will add additional
member elements to vmem_context, such as flags and page size.

No behavior changes are intended.

?

> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/linux/memory_hotplug.h |  6 +++++-
>   include/linux/mm.h             |  2 +-
>   mm/memory_hotplug.c            |  3 ++-
>   mm/sparse-vmemmap.c            |  6 +++++-
>   mm/sparse.c                    | 16 ++++++++--------
>   5 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 551093b74596..73f8bcbb58a4 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -81,6 +81,10 @@ struct mhp_params {
>   	pgprot_t pgprot;
>   };
>   
> +struct vmem_context {
> +	struct vmem_altmap *altmap;
> +};
> +
>   /*
>    * Zone resizing functions
>    *
> @@ -353,7 +357,7 @@ extern void remove_pfn_range_from_zone(struct zone *zone,
>   				       unsigned long nr_pages);
>   extern bool is_memblock_offlined(struct memory_block *mem);
>   extern int sparse_add_section(int nid, unsigned long pfn,
> -		unsigned long nr_pages, struct vmem_altmap *altmap);
> +		unsigned long nr_pages, struct vmem_context *ctx);
>   extern void sparse_remove_section(struct mem_section *ms,
>   		unsigned long pfn, unsigned long nr_pages,
>   		unsigned long map_offset, struct vmem_altmap *altmap);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index db6ae4d3fb4e..2eb44318bb2d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3000,7 +3000,7 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
>   
>   void *sparse_buffer_alloc(unsigned long size);
>   struct page * __populate_section_memmap(unsigned long pfn,
> -		unsigned long nr_pages, int nid, struct vmem_altmap *altmap);
> +		unsigned long nr_pages, int nid, struct vmem_context *ctx);
>   pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
>   p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
>   pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 63b2e46b6555..f8870c53fe5e 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -313,6 +313,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>   	unsigned long cur_nr_pages;
>   	int err;
>   	struct vmem_altmap *altmap = params->altmap;
> +	struct vmem_context ctx = { .altmap = params->altmap };

OK, so this is the one place I can see where ctx is set up. And it's never null.
Let's remember that point...

>   
>   	if (WARN_ON_ONCE(!params->pgprot.pgprot))
>   		return -EINVAL;
> @@ -341,7 +342,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>   		/* Select all remaining pages up to the next section boundary */
>   		cur_nr_pages = min(end_pfn - pfn,
>   				   SECTION_ALIGN_UP(pfn + 1) - pfn);
> -		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap);
> +		err = sparse_add_section(nid, pfn, cur_nr_pages, &ctx);
>   		if (err)
>   			break;
>   		cond_resched();
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 16183d85a7d5..bcda68ba1381 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -249,15 +249,19 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>   }
>   
>   struct page * __meminit __populate_section_memmap(unsigned long pfn,
> -		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
> +		unsigned long nr_pages, int nid, struct vmem_context *ctx)
>   {
>   	unsigned long start = (unsigned long) pfn_to_page(pfn);
>   	unsigned long end = start + nr_pages * sizeof(struct page);
> +	struct vmem_altmap *altmap = NULL;
>   
>   	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
>   		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
>   		return NULL;
>   
> +	if (ctx)

But...ctx can never be null, right?

I didn't spot any other issues, though.

thanks,
-- 
John Hubbard
NVIDIA

> +		altmap = ctx->altmap;
> +
>   	if (vmemmap_populate(start, end, nid, altmap))
>   		return NULL;
>   
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7bd23f9d6cef..47ca494398a7 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -443,7 +443,7 @@ static unsigned long __init section_map_size(void)
>   }
>   
>   struct page __init *__populate_section_memmap(unsigned long pfn,
> -		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
> +		unsigned long nr_pages, int nid, struct vmem_context *ctx)
>   {
>   	unsigned long size = section_map_size();
>   	struct page *map = sparse_buffer_alloc(size);
> @@ -648,9 +648,9 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>   
>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
>   static struct page * __meminit populate_section_memmap(unsigned long pfn,
> -		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
> +		unsigned long nr_pages, int nid, struct vmem_context *ctx)
>   {
> -	return __populate_section_memmap(pfn, nr_pages, nid, altmap);
> +	return __populate_section_memmap(pfn, nr_pages, nid, ctx);
>   }
>   
>   static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
> @@ -842,7 +842,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>   }
>   
>   static struct page * __meminit section_activate(int nid, unsigned long pfn,
> -		unsigned long nr_pages, struct vmem_altmap *altmap)
> +		unsigned long nr_pages, struct vmem_context *ctx)
>   {
>   	struct mem_section *ms = __pfn_to_section(pfn);
>   	struct mem_section_usage *usage = NULL;
> @@ -874,9 +874,9 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>   	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
>   		return pfn_to_page(pfn);
>   
> -	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap);
> +	memmap = populate_section_memmap(pfn, nr_pages, nid, ctx);
>   	if (!memmap) {
> -		section_deactivate(pfn, nr_pages, altmap);
> +		section_deactivate(pfn, nr_pages, ctx->altmap);
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> @@ -902,7 +902,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>    * * -ENOMEM	- Out of memory.
>    */
>   int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> -		unsigned long nr_pages, struct vmem_altmap *altmap)
> +		unsigned long nr_pages, struct vmem_context *ctx)
>   {
>   	unsigned long section_nr = pfn_to_section_nr(start_pfn);
>   	struct mem_section *ms;
> @@ -913,7 +913,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>   	if (ret < 0)
>   		return ret;
>   
> -	memmap = section_activate(nid, start_pfn, nr_pages, altmap);
> +	memmap = section_activate(nid, start_pfn, nr_pages, ctx);
>   	if (IS_ERR(memmap))
>   		return PTR_ERR(memmap);
>   
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
