Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0C02D39AE
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 05:40:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFD96100EC1F3;
	Tue,  8 Dec 2020 20:40:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.65; helo=hqnvemgate26.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com [216.228.121.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9A5F6100EC1DE
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 20:40:23 -0800 (PST)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5fd055360000>; Tue, 08 Dec 2020 20:40:22 -0800
Received: from [10.2.60.96] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 04:40:20 +0000
Subject: Re: [PATCH RFC 6/9] mm/gup: Grab head page refcount once for group of
 subpages
To: Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-8-joao.m.martins@oracle.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <6f729802-1e93-3036-3dba-be35e06af579@nvidia.com>
Date: Tue, 8 Dec 2020 20:40:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201208172901.17384-8-joao.m.martins@oracle.com>
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1607488822; bh=AvI+l2qvOZX8UUwCkWE7d1jqYBiHrEPru3IISbGvrx0=;
	h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
	 MIME-Version:In-Reply-To:Content-Type:Content-Language:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	b=sLa5D3M0K1cQo3Jy4y8NsmrgyMQ/P6n54SKhU58y2saRyuO2iv+kPeabHixg8LEF5
	 9LUJXfxXKFS/a0GTxyqUjkgstIqZe5SekplQd4DUPs5P+sfmSML2Vp2QktY3I2flZj
	 4M9CxcDqRwzjWXpqVgs2faSYzAl3sy2hZGooHgLW67nxbp1tOjhp1uii9rh7xBBOIx
	 5Fdj/uYq73Cgii1GRpGAcll8mkNFsi2WKBkih02h64/vL6c59EXSVlV3kHvLq+6BBE
	 qpwv8CWSlTcLFvYXUSSvukhaysMCX852NumjqKVmFNWGDujRf5yl8Mxapn+h5Pl1YP
	 1AcKv2c6oplPQ==
Message-ID-Hash: LL6WDTPGEZN4NSMJIZCKWQRIPTMUPU5B
X-Message-ID-Hash: LL6WDTPGEZN4NSMJIZCKWQRIPTMUPU5B
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>,
	"Jason Gunthorpe  <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song" <songmuchun@bytedance.com>,
	Mike Kravetz <mike.kravetz@oracle.com>, Andrew@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LL6WDTPGEZN4NSMJIZCKWQRIPTMUPU5B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/8/20 9:28 AM, Joao Martins wrote:
> Much like hugetlbfs or THPs, we treat device pagemaps with
> compound pages like the rest of GUP handling of compound pages.
> 
> Rather than incrementing the refcount every 4K, we record
> all sub pages and increment by @refs amount *once*.
> 
> Performance measured by gup_benchmark improves considerably
> get_user_pages_fast() and pin_user_pages_fast():
> 
>   $ gup_benchmark -f /dev/dax0.2 -m 16384 -r 10 -S [-u,-a] -n 512 -w

"gup_test", now that you're in linux-next, actually.

(Maybe I'll retrofit that test with getopt_long(), those options are
getting more elaborate.)

> 
> (get_user_pages_fast 2M pages) ~75k us -> ~3.6k us
> (pin_user_pages_fast 2M pages) ~125k us -> ~3.8k us

That is a beautiful result! I'm very motivated to see if this patchset
can make it in, in some form.

> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   mm/gup.c | 67 ++++++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 51 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 98eb8e6d2609..194e6981eb03 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2250,22 +2250,68 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>   }
>   #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
>   
> +
> +static int record_subpages(struct page *page, unsigned long addr,
> +			   unsigned long end, struct page **pages)
> +{
> +	int nr;
> +
> +	for (nr = 0; addr != end; addr += PAGE_SIZE)
> +		pages[nr++] = page++;
> +
> +	return nr;
> +}
> +
>   #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> -static int __gup_device_huge(unsigned long pfn, unsigned long addr,
> -			     unsigned long end, unsigned int flags,
> -			     struct page **pages, int *nr)
> +static int __gup_device_compound_huge(struct dev_pagemap *pgmap,
> +				      struct page *head, unsigned long sz,

If this variable survives (I see Jason requested a reorg of this math stuff,
and I also like that idea), then I'd like a slightly better name for "sz".

I was going to suggest one, but then realized that I can't understand how this
works. See below...

> +				      unsigned long addr, unsigned long end,
> +				      unsigned int flags, struct page **pages)
> +{
> +	struct page *page;
> +	int refs;
> +
> +	if (!(pgmap->flags & PGMAP_COMPOUND))
> +		return -1;

btw, I'm unhappy with returning -1 here and assigning it later to a refs variable.
(And that will show up even more clearly as an issue if you attempt to make
refs unsigned everywhere!)

I'm not going to suggest anything because there are a lot of ways to structure
these routines, and I don't want to overly constrain you. Just please don't assign
negative values to any refs variables.

> +
> +	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);

If you pass in PMD_SHIFT or PUD_SHIFT for, that's a number-of-bits, isn't it?
Not a size. And if it's not a size, then sz - 1 doesn't work, does it? If it
does work, then better naming might help. I'm probably missing a really
obvious math trick here.


thanks,
-- 
John Hubbard
NVIDIA

> +	refs = record_subpages(page, addr, end, pages);
> +
> +	SetPageReferenced(page);
> +	head = try_grab_compound_head(head, refs, flags);
> +	if (!head) {
> +		ClearPageReferenced(page);
> +		return 0;
> +	}
> +
> +	return refs;
> +}
> +
> +static int __gup_device_huge(unsigned long pfn, unsigned long sz,
> +			     unsigned long addr, unsigned long end,
> +			     unsigned int flags, struct page **pages, int *nr)
>   {
>   	int nr_start = *nr;
>   	struct dev_pagemap *pgmap = NULL;
>   
>   	do {
>   		struct page *page = pfn_to_page(pfn);
> +		int refs;
>   
>   		pgmap = get_dev_pagemap(pfn, pgmap);
>   		if (unlikely(!pgmap)) {
>   			undo_dev_pagemap(nr, nr_start, flags, pages);
>   			return 0;
>   		}
> +
> +		refs = __gup_device_compound_huge(pgmap, page, sz, addr, end,
> +						  flags, pages + *nr);
> +		if (refs >= 0) {
> +			*nr += refs;
> +			put_dev_pagemap(pgmap);
> +			return refs ? 1 : 0;
> +		}
> +
>   		SetPageReferenced(page);
>   		pages[*nr] = page;
>   		if (unlikely(!try_grab_page(page, flags))) {
> @@ -2289,7 +2335,7 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>   	int nr_start = *nr;
>   
>   	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> -	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
> +	if (!__gup_device_huge(fault_pfn, PMD_SHIFT, addr, end, flags, pages, nr))
>   		return 0;
>   
>   	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
> @@ -2307,7 +2353,7 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>   	int nr_start = *nr;
>   
>   	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> -	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
> +	if (!__gup_device_huge(fault_pfn, PUD_SHIFT, addr, end, flags, pages, nr))
>   		return 0;
>   
>   	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
> @@ -2334,17 +2380,6 @@ static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
>   }
>   #endif
>   
> -static int record_subpages(struct page *page, unsigned long addr,
> -			   unsigned long end, struct page **pages)
> -{
> -	int nr;
> -
> -	for (nr = 0; addr != end; addr += PAGE_SIZE)
> -		pages[nr++] = page++;
> -
> -	return nr;
> -}
> -
>   #ifdef CONFIG_ARCH_HAS_HUGEPD
>   static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
>   				      unsigned long sz)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
