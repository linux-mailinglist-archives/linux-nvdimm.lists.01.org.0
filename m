Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713642D4EAE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Dec 2020 00:21:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40D15100EBBD0;
	Wed,  9 Dec 2020 15:21:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C9833100ED487
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 15:21:46 -0800 (PST)
IronPort-SDR: pSRtXqrYQfa4ka3n7fcm2qakC/GyjKKkR3UltM2ZhHqe9jGiJOKm47x/b1RXHUjv47x1+bc2nV
 XH+dACO4nvRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="161214160"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400";
   d="scan'208";a="161214160"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 15:21:46 -0800
IronPort-SDR: z3TQJyE6SZCxUKC4AGV4MyZme/aDEDXV4j9ZilO23OZ77arAmGdLzFh8BmEtRseAW27qslJnY4
 hm/WD/WhNgBw==
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400";
   d="scan'208";a="364348073"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 15:21:45 -0800
Date: Wed, 9 Dec 2020 15:21:45 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] mm/up: combine put_compound_head() and unpin_user_page()
Message-ID: <20201209232145.GQ1563847@iweiny-DESK2.sc.intel.com>
References: <0-v1-6730d4ee0d32+40e6-gup_combine_put_jgg@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0-v1-6730d4ee0d32+40e6-gup_combine_put_jgg@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: T4GWT6TUGRBJOSGJ6RQGWRIQYNS2O7I5
X-Message-ID-Hash: T4GWT6TUGRBJOSGJ6RQGWRIQYNS2O7I5
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>, linux-mm <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-nvdimm@lists.01.org, Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, Shuah Khan <shuah@kernel.org>, Muchun Song <songmuchun@bytedance.com>, Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T4GWT6TUGRBJOSGJ6RQGWRIQYNS2O7I5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 09, 2020 at 03:13:57PM -0400, Jason Gunthorpe wrote:
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

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
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
