Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BEC2D4C4F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 21:57:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 238FE100EBBAA;
	Wed,  9 Dec 2020 12:57:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.65; helo=hqnvemgate26.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com [216.228.121.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6058E100EC1DA
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 12:57:41 -0800 (PST)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5fd13a440000>; Wed, 09 Dec 2020 12:57:40 -0800
Received: from [10.2.60.96] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 20:57:38 +0000
Subject: Re: [PATCH] mm/up: combine put_compound_head() and unpin_user_page()
To: Jason Gunthorpe <jgg@nvidia.com>, Andrew Morton
	<akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>,
	linux-mm <linux-mm@kvack.org>
References: <0-v1-6730d4ee0d32+40e6-gup_combine_put_jgg@nvidia.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <16128311-9874-dcd4-c641-c68b34c9d634@nvidia.com>
Date: Wed, 9 Dec 2020 12:57:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <0-v1-6730d4ee0d32+40e6-gup_combine_put_jgg@nvidia.com>
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1607547460; bh=kAU3uFvSz/nEO0cxIKc87yDDQtmd0SQyKa8HfojZbg0=;
	h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
	 MIME-Version:In-Reply-To:Content-Type:Content-Language:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	b=X7Nrap8Mp/7CdaFw/Aw3PzAwAwXk5388RfTOo8JHkZcHbs4G56iafaLRBITb1BLsz
	 IsBOXBS9nAA4MYPztcgcO/reON7W57vwwAic+A6ytUXmjq8ueysqymnvQUHrjg9pCW
	 6L21ZmSokfzeJSRnwDswMwA+L4P6Qag1QGydkb9sdzxPCV57D5RcuwZYJ/ipCtM4Ws
	 i7X+y0QFtPsDkgPCz1LXDaY2Dfhku3Kprsx9zepL9/+BKxXWqhD0W5AS4T3y26RoCP
	 K/LGCuReegzbrxY4i1IuLTz96KalVUzOM6g3I47F3NxS6Js1RINU1EQXDzLT9wag4F
	 p6YEk8CkrwFaw==
Message-ID-Hash: D5XHFWWCMIPG7GMPFDZTB54MJURTRJ23
X-Message-ID-Hash: D5XHFWWCMIPG7GMPFDZTB54MJURTRJ23
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jonathan Corbet <corbet@lwn.net>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-nvdimm@lists.01.org, Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, Shuah Khan <shuah@kernel.org>, Muchun Song <songmuchun@bytedance.com>, Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D5XHFWWCMIPG7GMPFDZTB54MJURTRJ23/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/9/20 11:13 AM, Jason Gunthorpe wrote:
> These functions accomplish the same thing but have different
> implementations.
> 
> unpin_user_page() has a bug where it calls mod_node_page_state() after
> calling put_page() which creates a risk that the page could have been
> hot-uplugged from the system.
> 
> Fix this by using put_compound_head() as the only implementation.
> 
> __unpin_devmap_managed_user_page() and related can be deleted as well in
> favour of the simpler, but slower, version in put_compound_head() that has
> an extra atomic page_ref_sub, but always calls put_page() which internally
> contains the special devmap code.
> 
> Move put_compound_head() to be directly after try_grab_compound_head() so
> people can find it in future.
> 
> Fixes: 1970dc6f5226 ("mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN) reporting")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   mm/gup.c | 103 +++++++++++++------------------------------------------
>   1 file changed, 23 insertions(+), 80 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

With a couple of minor notes below:

> With Matt's folio idea I'd next to go to make a
>    put_folio(folio, refs)
> 
> Which would cleanly eliminate that extra atomic here without duplicating the
> devmap special case.
> 
> This should also be called 'ungrab_compound_head' as we seem to be using the
> word 'grab' to mean 'pin or get' depending on GUP flags.
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 98eb8e6d2609c3..7b33b7d4b324d7 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -123,6 +123,28 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
>   	return NULL;
>   }
>   
> +static void put_compound_head(struct page *page, int refs, unsigned int flags)
> +{

It might be nice to rename "page" to "head", here.

While reading this I toyed with the idea of having this at the top:

	VM_BUG_ON_PAGE(compound_head(page) != page, page);

...but it's overkill in a static function with pretty clear call sites. So I
think it's just right as-is.


> +	if (flags & FOLL_PIN) {
> +		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
> +				    refs);
> +
> +		if (hpage_pincount_available(page))
> +			hpage_pincount_sub(page, refs);
> +		else
> +			refs *= GUP_PIN_COUNTING_BIAS;
> +	}
> +
> +	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
> +	/*
> +	 * Calling put_page() for each ref is unnecessarily slow. Only the last
> +	 * ref needs a put_page().
> +	 */
> +	if (refs > 1)
> +		page_ref_sub(page, refs - 1);
> +	put_page(page);
> +}
> +
>   /**
>    * try_grab_page() - elevate a page's refcount by a flag-dependent amount
>    *
> @@ -177,41 +199,6 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
>   	return true;
>   }
>   
> -#ifdef CONFIG_DEV_PAGEMAP_OPS
> -static bool __unpin_devmap_managed_user_page(struct page *page)
> -{
> -	int count, refs = 1;
> -
> -	if (!page_is_devmap_managed(page))
> -		return false;
> -
> -	if (hpage_pincount_available(page))
> -		hpage_pincount_sub(page, 1);
> -	else
> -		refs = GUP_PIN_COUNTING_BIAS;
> -
> -	count = page_ref_sub_return(page, refs);
> -
> -	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, 1);
> -	/*
> -	 * devmap page refcounts are 1-based, rather than 0-based: if
> -	 * refcount is 1, then the page is free and the refcount is
> -	 * stable because nobody holds a reference on the page.
> -	 */
> -	if (count == 1)
> -		free_devmap_managed_page(page);
> -	else if (!count)
> -		__put_page(page);
> -
> -	return true;
> -}
> -#else
> -static bool __unpin_devmap_managed_user_page(struct page *page)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_DEV_PAGEMAP_OPS */
> -

Wow, getting rid of that duplication is beautiful!

thanks,
-- 
John Hubbard
NVIDIA

>   /**
>    * unpin_user_page() - release a dma-pinned page
>    * @page:            pointer to page to be released
> @@ -223,28 +210,7 @@ static bool __unpin_devmap_managed_user_page(struct page *page)
>    */
>   void unpin_user_page(struct page *page)
>   {
> -	int refs = 1;
> -
> -	page = compound_head(page);
> -
> -	/*
> -	 * For devmap managed pages we need to catch refcount transition from
> -	 * GUP_PIN_COUNTING_BIAS to 1, when refcount reach one it means the
> -	 * page is free and we need to inform the device driver through
> -	 * callback. See include/linux/memremap.h and HMM for details.
> -	 */
> -	if (__unpin_devmap_managed_user_page(page))
> -		return;
> -
> -	if (hpage_pincount_available(page))
> -		hpage_pincount_sub(page, 1);
> -	else
> -		refs = GUP_PIN_COUNTING_BIAS;
> -
> -	if (page_ref_sub_and_test(page, refs))
> -		__put_page(page);
> -
> -	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, 1);
> +	put_compound_head(compound_head(page), 1, FOLL_PIN);
>   }
>   EXPORT_SYMBOL(unpin_user_page);
>   
> @@ -2062,29 +2028,6 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>    * This code is based heavily on the PowerPC implementation by Nick Piggin.
>    */
>   #ifdef CONFIG_HAVE_FAST_GUP
> -
> -static void put_compound_head(struct page *page, int refs, unsigned int flags)
> -{
> -	if (flags & FOLL_PIN) {
> -		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
> -				    refs);
> -
> -		if (hpage_pincount_available(page))
> -			hpage_pincount_sub(page, refs);
> -		else
> -			refs *= GUP_PIN_COUNTING_BIAS;
> -	}
> -
> -	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
> -	/*
> -	 * Calling put_page() for each ref is unnecessarily slow. Only the last
> -	 * ref needs a put_page().
> -	 */
> -	if (refs > 1)
> -		page_ref_sub(page, refs - 1);
> -	put_page(page);
> -}
> -
>   #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
>   
>   /*
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
