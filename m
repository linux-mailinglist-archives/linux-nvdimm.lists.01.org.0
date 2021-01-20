Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4502E2FCDBD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 11:11:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC8E4100EB82B;
	Wed, 20 Jan 2021 02:11:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D2A88100EB827
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 02:11:14 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1611137473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f85nyV30dGUYyT4OSwZQuD/tNzi1TVhqdVBME5I7U34=;
	b=Tqtkk73BVvR1GyvLqKN8ezpgmILoSEhpUbnhuP+3EYhk+CP5v9bOCWEbAYqu7lzOemwRDX
	Y4lmzrHaj6x3fJ6JJrwa92jIVJWUqquupWpWBxfWJ4kEZcUuWCL+wHAKVU0cMlyQwdVDRJ
	FQANm4sJYUPgLnNrgjrxdQNSlQcFIao=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 1D056AC8F;
	Wed, 20 Jan 2021 10:11:13 +0000 (UTC)
Date: Wed, 20 Jan 2021 11:11:12 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 1/5] mm: Move pfn_to_online_page() out of line
Message-ID: <20210120101112.GF9371@dhcp22.suse.cz>
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161058499608.1840162.10165648147615238793.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161058499608.1840162.10165648147615238793.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID-Hash: DH3QUD3OT6J6TPXYKSV7D2ZZJDGXB6B3
X-Message-ID-Hash: DH3QUD3OT6J6TPXYKSV7D2ZZJDGXB6B3
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DH3QUD3OT6J6TPXYKSV7D2ZZJDGXB6B3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed 13-01-21 16:43:16, Dan Williams wrote:
> pfn_to_online_page() is already too large to be a macro or an inline
> function. In anticipation of further logic changes / growth, move it out
> of line.
> 
> No functional change, just code movement.
> 
> Reported-by: Michal Hocko <mhocko@kernel.org>

I am not sure what r-b refers to. I suspect it is the overal problem
rather than this particular patch. Not that I care much but it might get
confusing because I do not remember ever complaining about
pfn_to_online_page to be too large.

> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I do not remember any hot path which depends on pfn walk and a function
call would be clearly visible. If this ever turn out  to be a problem we
can make it inline and push the heavy lifting out of line.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  include/linux/memory_hotplug.h |   17 +----------------
>  mm/memory_hotplug.c            |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 15acce5ab106..3d99de0db2dd 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -16,22 +16,7 @@ struct resource;
>  struct vmem_altmap;
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -/*
> - * Return page for the valid pfn only if the page is online. All pfn
> - * walkers which rely on the fully initialized page->flags and others
> - * should use this rather than pfn_valid && pfn_to_page
> - */
> -#define pfn_to_online_page(pfn)					   \
> -({								   \
> -	struct page *___page = NULL;				   \
> -	unsigned long ___pfn = pfn;				   \
> -	unsigned long ___nr = pfn_to_section_nr(___pfn);	   \
> -								   \
> -	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> -	    pfn_valid_within(___pfn))				   \
> -		___page = pfn_to_page(___pfn);			   \
> -	___page;						   \
> -})
> +struct page *pfn_to_online_page(unsigned long pfn);
>  
>  /*
>   * Types for free bootmem stored in page->lru.next. These have to be in
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f9d57b9be8c7..55a69d4396e7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -300,6 +300,22 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
>  	return 0;
>  }
>  
> +/*
> + * Return page for the valid pfn only if the page is online. All pfn
> + * walkers which rely on the fully initialized page->flags and others
> + * should use this rather than pfn_valid && pfn_to_page
> + */
> +struct page *pfn_to_online_page(unsigned long pfn)
> +{
> +	unsigned long nr = pfn_to_section_nr(pfn);
> +
> +	if (nr < NR_MEM_SECTIONS && online_section_nr(nr) &&
> +	    pfn_valid_within(pfn))
> +		return pfn_to_page(pfn);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pfn_to_online_page);
> +
>  /*
>   * Reasonably generic function for adding memory.  It is
>   * expected that archs that support memory hotplug will

-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
