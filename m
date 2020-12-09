Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AD02D3B1A
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 06:59:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18F9D100EB84A;
	Tue,  8 Dec 2020 21:59:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.65; helo=hqnvemgate26.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com [216.228.121.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E2F69100EC1C8
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 21:59:23 -0800 (PST)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5fd067bb0000>; Tue, 08 Dec 2020 21:59:23 -0800
Received: from [10.2.60.96] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 05:59:20 +0000
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound
 pages
To: Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
Date: Tue, 8 Dec 2020 21:59:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201208172901.17384-2-joao.m.martins@oracle.com>
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1607493563; bh=BGUcmY6kyIilWznI7C133qVvZB8Fl5opYtUzeCfHHcM=;
	h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
	 MIME-Version:In-Reply-To:Content-Type:Content-Language:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	b=XLdlKRqAJe1ZkLRV4tA12FSRFypJN27cnA2N2Cx3U7FGb5gSs8rMAAHsXKh3WpWh6
	 zYXmFECHMuIAkZBYNQBwaRAg33MZmhb/vT9kpxbsz89GzfOnFZCickBmxROM9fCGoR
	 EZqTqAgoQVOZ9QTaGLgc9kLL+Cs1mv+W6i7ixY3/d3+fSUmRV7HKWVpFFXshrvg4Nu
	 Z/HluOWwj8SYV64Dv6QhOOkfF1eAslbf51S+MR7rMLsyjYWFlGnAkHk/Zlwn7pHyIb
	 dYCF03PU4/x4E+u0NGN/zyqylpcZEBCR+Z5Dtpxif81waof24w69I/1q9mozMdye1n
	 iYz6X66kiKwCw==
Message-ID-Hash: SMEMDVN43RWTVIZ7OH242UUS3X5TGIQX
X-Message-ID-Hash: SMEMDVN43RWTVIZ7OH242UUS3X5TGIQX
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>,
	"Jason Gunthorpe  <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song" <songmuchun@bytedance.com>,
	Mike Kravetz <mike.kravetz@oracle.com>, Andrew@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SMEMDVN43RWTVIZ7OH242UUS3X5TGIQX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/8/20 9:28 AM, Joao Martins wrote:
> Add a new flag for struct dev_pagemap which designates that a a pagemap

a a

> is described as a set of compound pages or in other words, that how
> pages are grouped together in the page tables are reflected in how we
> describe struct pages. This means that rather than initializing
> individual struct pages, we also initialize these struct pages, as

Let's not say "rather than x, we also do y", because it's self-contradictory.
I think you want to just leave out the "also", like this:

"This means that rather than initializing> individual struct pages, we
initialize these struct pages ..."

Is that right?

> compound pages (on x86: 2M or 1G compound pages)
> 
> For certain ZONE_DEVICE users, like device-dax, which have a fixed page
> size, this creates an opportunity to optimize GUP and GUP-fast walkers,
> thus playing the same tricks as hugetlb pages.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/linux/memremap.h | 2 ++
>   mm/memremap.c            | 8 ++++++--
>   mm/page_alloc.c          | 7 +++++++
>   3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 79c49e7f5c30..f8f26b2cc3da 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -90,6 +90,7 @@ struct dev_pagemap_ops {
>   };
>   
>   #define PGMAP_ALTMAP_VALID	(1 << 0)
> +#define PGMAP_COMPOUND		(1 << 1)
>   
>   /**
>    * struct dev_pagemap - metadata for ZONE_DEVICE mappings
> @@ -114,6 +115,7 @@ struct dev_pagemap {
>   	struct completion done;
>   	enum memory_type type;
>   	unsigned int flags;
> +	unsigned int align;

This also needs an "@aline" entry in the comment block above.

>   	const struct dev_pagemap_ops *ops;
>   	void *owner;
>   	int nr_range;
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 16b2fb482da1..287a24b7a65a 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -277,8 +277,12 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>   	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
>   				PHYS_PFN(range->start),
>   				PHYS_PFN(range_len(range)), pgmap);
> -	percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
> -			- pfn_first(pgmap, range_id));
> +	if (pgmap->flags & PGMAP_COMPOUND)
> +		percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
> +			- pfn_first(pgmap, range_id)) / PHYS_PFN(pgmap->align));

Is there some reason that we cannot use range_len(), instead of pfn_end() minus
pfn_first()? (Yes, this more about the pre-existing code than about your change.)

And if not, then why are the nearby range_len() uses OK? I realize that range_len()
is simpler and skips a case, but it's not clear that it's required here. But I'm
new to this area so be warned. :)

Also, dividing by PHYS_PFN() feels quite misleading: that function does what you
happen to want, but is not named accordingly. Can you use or create something
more accurately named? Like "number of pages in this large page"?

> +	else
> +		percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
> +				- pfn_first(pgmap, range_id));
>   	return 0;
>   
>   err_add_memory:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eaa227a479e4..9716ecd58e29 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6116,6 +6116,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   	unsigned long pfn, end_pfn = start_pfn + nr_pages;
>   	struct pglist_data *pgdat = zone->zone_pgdat;
>   	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
> +	bool compound = pgmap->flags & PGMAP_COMPOUND;
> +	unsigned int align = PHYS_PFN(pgmap->align);

Maybe align_pfn or pfn_align? Don't want the same name for things that are actually
different types, in meaning anyway.


>   	unsigned long zone_idx = zone_idx(zone);
>   	unsigned long start = jiffies;
>   	int nid = pgdat->node_id;
> @@ -6171,6 +6173,11 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   		}
>   	}
>   
> +	if (compound) {
> +		for (pfn = start_pfn; pfn < end_pfn; pfn += align)
> +			prep_compound_page(pfn_to_page(pfn), order_base_2(align));
> +	}
> +
>   	pr_info("%s initialised %lu pages in %ums\n", __func__,
>   		nr_pages, jiffies_to_msecs(jiffies - start));
>   }
> 

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
