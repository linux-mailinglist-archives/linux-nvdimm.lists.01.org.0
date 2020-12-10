Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B2C2D5879
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Dec 2020 11:45:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E9B3100EBBA1;
	Thu, 10 Dec 2020 02:45:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BB6AC100ED48C
	for <linux-nvdimm@lists.01.org>; Thu, 10 Dec 2020 02:45:32 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 0E3FEAF31;
	Thu, 10 Dec 2020 10:39:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 302351E0F6A; Thu, 10 Dec 2020 10:22:40 +0100 (CET)
Date: Thu, 10 Dec 2020 10:22:40 +0100
From: Jan Kara <jack@suse.cz>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] mm/up: combine put_compound_head() and unpin_user_page()
Message-ID: <20201210092240.GA24151@quack2.suse.cz>
References: <0-v1-6730d4ee0d32+40e6-gup_combine_put_jgg@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0-v1-6730d4ee0d32+40e6-gup_combine_put_jgg@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: C7LANAIE4FBXXCVFOS7MJ3XAKNZ7LXVI
X-Message-ID-Hash: C7LANAIE4FBXXCVFOS7MJ3XAKNZ7LXVI
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>, linux-mm <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-nvdimm@lists.01.org, Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, Shuah Khan <shuah@kernel.org>, Muchun Song <songmuchun@bytedance.com>, Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C7LANAIE4FBXXCVFOS7MJ3XAKNZ7LXVI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed 09-12-20 15:13:57, Jason Gunthorpe wrote:
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

Nice cleanup. The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/gup.c | 103 +++++++++++++------------------------------------------
>  1 file changed, 23 insertions(+), 80 deletions(-)
> 
> With Matt's folio idea I'd next to go to make a
>   put_folio(folio, refs)
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
>  	return NULL;
>  }
>  
> +static void put_compound_head(struct page *page, int refs, unsigned int flags)
> +{
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
>  /**
>   * try_grab_page() - elevate a page's refcount by a flag-dependent amount
>   *
> @@ -177,41 +199,6 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
>  	return true;
>  }
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
>  /**
>   * unpin_user_page() - release a dma-pinned page
>   * @page:            pointer to page to be released
> @@ -223,28 +210,7 @@ static bool __unpin_devmap_managed_user_page(struct page *page)
>   */
>  void unpin_user_page(struct page *page)
>  {
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
>  }
>  EXPORT_SYMBOL(unpin_user_page);
>  
> @@ -2062,29 +2028,6 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>   * This code is based heavily on the PowerPC implementation by Nick Piggin.
>   */
>  #ifdef CONFIG_HAVE_FAST_GUP
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
>  #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
>  
>  /*
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
