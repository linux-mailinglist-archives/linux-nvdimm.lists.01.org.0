Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63380374B1B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 00:20:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 50F30100EB85D;
	Wed,  5 May 2021 15:20:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7450A100EF27E
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 15:20:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so5257748ejc.4
        for <linux-nvdimm@lists.01.org>; Wed, 05 May 2021 15:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEDAh4DcJxI2Idka9X3zEdAWqtCJML9fMhYKOaD1tRM=;
        b=Sdy66CfF8FQ7BxRk+mOraAZl9/zzzQjNTK4fI66Obu4uT9zeR18bMW6JW//dZ/A9GC
         VxrBarmM4Fg092WwDHEi0E77lkSsxD5xE3Xhxal7jdy2ZxvVsq0Nd/PGZvwRNKOagKS5
         m9i0Z05TOy+mLZcL8b46Axmn+5YBSDVE104OoBwL6lM+Xu7MA9TV++Tbr7Bf0SwB2o2t
         rh4x3qMrbUBeg8CnRMxiz2PygUXVqJNh2ZhT4hbvPAu+rcLcORZr0+FLSr8oIafIYiFh
         l8l0m+CY6Jk124ZOtdKoI+G/6KhlAQOTE52Okg2qH5AEdvf9F6fc6se+l7lfmxM6f2qB
         HiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEDAh4DcJxI2Idka9X3zEdAWqtCJML9fMhYKOaD1tRM=;
        b=FAqwO76OPCroiEHFSgcoTh75k0yh542XIkxO8kuVB1zM0PRCM+lOVd7bKzoYy+XJAS
         W/fKfbrZAkdc2ih1okLZ8DQnNNSsixAxfDr3foS6QZN5pr5JAkpHIftnEj6ggGzM8HRU
         gia5ka9tGnnJXYJ7R3o25PgpjsQHITJlqxDwBsqWH9UWVK4AZ9cVx8c3E1odD+kf1QMW
         H3CXyyizS9JDkoV7Chkk6032PEWyyDwhqzAbx4WxSLNbMdxgBbPlu0tUHQkn2RDSrR6E
         b3k4SSSlHWcPyig1Sn+iKxcg77bozzhCLNQ/F9Fz0JogFH6AIoo+HI7uVZL49POBQUnf
         abQw==
X-Gm-Message-State: AOAM533SiFg5MMw4rrlWiQoHkjWoF5iStgjCzeJqaF0EhLSfLaP33OjA
	4PARMFlfC3KPzS94wwHD8f5pwXdI83pPgsPToaR2TA==
X-Google-Smtp-Source: ABdhPJwYu8VVgPRy7o945bGqK6y6C2nvmUL2m1BEqoZAxhbsOpqibbx5xBrJ+XyffZbiIDFPOlAR4iCfY0sp7JoCg9M=
X-Received: by 2002:a17:907:1183:: with SMTP id uz3mr982678ejb.264.1620253251070;
 Wed, 05 May 2021 15:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com> <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
 <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
In-Reply-To: <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 May 2021 15:20:55 -0700
Message-ID: <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: BOTRI25QABVVHBYQELPMNM55H3UACZ42
X-Message-ID-Hash: BOTRI25QABVVHBYQELPMNM55H3UACZ42
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BOTRI25QABVVHBYQELPMNM55H3UACZ42/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 5, 2021 at 12:50 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
>
>
> On 5/5/21 7:44 PM, Dan Williams wrote:
> > On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
> >>
> >> Add a new align property for struct dev_pagemap which specifies that a
> >> pagemap is composed of a set of compound pages of size @align, instead
> >> of base pages. When these pages are initialised, most are initialised as
> >> tail pages instead of order-0 pages.
> >>
> >> For certain ZONE_DEVICE users like device-dax which have a fixed page
> >> size, this creates an opportunity to optimize GUP and GUP-fast walkers,
> >> treating it the same way as THP or hugetlb pages.
> >>
> >> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> >> ---
> >>  include/linux/memremap.h | 13 +++++++++++++
> >>  mm/memremap.c            |  8 ++++++--
> >>  mm/page_alloc.c          | 24 +++++++++++++++++++++++-
> >>  3 files changed, 42 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> >> index b46f63dcaed3..bb28d82dda5e 100644
> >> --- a/include/linux/memremap.h
> >> +++ b/include/linux/memremap.h
> >> @@ -114,6 +114,7 @@ struct dev_pagemap {
> >>         struct completion done;
> >>         enum memory_type type;
> >>         unsigned int flags;
> >> +       unsigned long align;
> >
> > I think this wants some kernel-doc above to indicate that non-zero
> > means "use compound pages with tail-page dedup" and zero / PAGE_SIZE
> > means "use non-compound base pages".
>
> Got it. Are you thinking a kernel_doc on top of the variable above, or preferably on top
> of pgmap_align()?

I was thinking in dev_pagemap because this value is more than just a
plain alignment its restructuring the layout and construction of the
memmap(), but when I say it that way it seems much less like a vanilla
align value compared to a construction / geometry mode setting.

>
> > The non-zero value must be
> > PAGE_SIZE, PMD_PAGE_SIZE or PUD_PAGE_SIZE.
> > Hmm, maybe it should be an
> > enum:
> >
> > enum devmap_geometry {
> >     DEVMAP_PTE,
> >     DEVMAP_PMD,
> >     DEVMAP_PUD,
> > }
> >
> I suppose a converter between devmap_geometry and page_size would be needed too? And maybe
> the whole dax/nvdimm align values change meanwhile (as a followup improvement)?

I think it is ok for dax/nvdimm to continue to maintain their align
value because it should be ok to have 4MB align if the device really
wanted. However, when it goes to map that alignment with
memremap_pages() it can pick a mode. For example, it's already the
case that dax->align == 1GB is mapped with DEVMAP_PTE today, so
they're already separate concepts that can stay separate.

>
> Although to be fair we only ever care about compound page size in this series (and
> similarly dax/nvdimm @align properties).
>
> > ...because it's more than just an alignment it's a structural
> > definition of how the memmap is laid out.
> >
> >>         const struct dev_pagemap_ops *ops;
> >>         void *owner;
> >>         int nr_range;
> >> @@ -130,6 +131,18 @@ static inline struct vmem_altmap *pgmap_altmap(struct dev_pagemap *pgmap)
> >>         return NULL;
> >>  }
> >>
> >> +static inline unsigned long pgmap_align(struct dev_pagemap *pgmap)
> >> +{
> >> +       if (!pgmap || !pgmap->align)
> >> +               return PAGE_SIZE;
> >> +       return pgmap->align;
> >> +}
> >> +
> >> +static inline unsigned long pgmap_pfn_align(struct dev_pagemap *pgmap)
> >> +{
> >> +       return PHYS_PFN(pgmap_align(pgmap));
> >> +}
> >> +
> >>  #ifdef CONFIG_ZONE_DEVICE
> >>  bool pfn_zone_device_reserved(unsigned long pfn);
> >>  void *memremap_pages(struct dev_pagemap *pgmap, int nid);
> >> diff --git a/mm/memremap.c b/mm/memremap.c
> >> index 805d761740c4..d160853670c4 100644
> >> --- a/mm/memremap.c
> >> +++ b/mm/memremap.c
> >> @@ -318,8 +318,12 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
> >>         memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
> >>                                 PHYS_PFN(range->start),
> >>                                 PHYS_PFN(range_len(range)), pgmap);
> >> -       percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
> >> -                       - pfn_first(pgmap, range_id));
> >> +       if (pgmap_align(pgmap) > PAGE_SIZE)
> >> +               percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
> >> +                       - pfn_first(pgmap, range_id)) / pgmap_pfn_align(pgmap));
> >> +       else
> >> +               percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
> >> +                               - pfn_first(pgmap, range_id));
> >>         return 0;
> >>
> >>  err_add_memory:
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index 58974067bbd4..3a77f9e43f3a 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -6285,6 +6285,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
> >>         unsigned long pfn, end_pfn = start_pfn + nr_pages;
> >>         struct pglist_data *pgdat = zone->zone_pgdat;
> >>         struct vmem_altmap *altmap = pgmap_altmap(pgmap);
> >> +       unsigned int pfn_align = pgmap_pfn_align(pgmap);
> >> +       unsigned int order_align = order_base_2(pfn_align);
> >>         unsigned long zone_idx = zone_idx(zone);
> >>         unsigned long start = jiffies;
> >>         int nid = pgdat->node_id;
> >> @@ -6302,10 +6304,30 @@ void __ref memmap_init_zone_device(struct zone *zone,
> >>                 nr_pages = end_pfn - start_pfn;
> >>         }
> >>
> >> -       for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> >> +       for (pfn = start_pfn; pfn < end_pfn; pfn += pfn_align) {
> >
> > pfn_align is in bytes and pfn is in pages... is there a "pfn_align >>=
> > PAGE_SHIFT" I missed somewhere?
> >
> @pfn_align is in pages too. It's pgmap_align() which is in bytes:
>
> +static inline unsigned long pgmap_pfn_align(struct dev_pagemap *pgmap)
> +{
> +       return PHYS_PFN(pgmap_align(pgmap));
> +}

Ah yup, my eyes glazed over that. I think this is another place that
benefits from a more specific name than "align". "pfns_per_compound"
"compound_pfns"?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
