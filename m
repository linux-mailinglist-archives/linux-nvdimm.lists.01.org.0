Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA2369DB3
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Apr 2021 02:18:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CCBA4100EAB09;
	Fri, 23 Apr 2021 17:18:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7EC4B100EAB03
	for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 17:18:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s15so59264457edd.4
        for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 17:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/iSqBVg1YOHEHtFtoKF8EBfJrdT6u7/8yJl358aav0=;
        b=0Oz4zOQpLT79MkhCiWeWYGeDTVfiQHHn800C7spi38MntkbkKGCKKc10O/abfvYL04
         0qVaac4ERAfye2S9MOirSIHygbmK/Om2XIwsPneOhn/xXYQx2nbh//HuJCjIok5t0eTb
         +nL2GtrP1VNv8t77DfswJeR47fq8IBWZULzOlTQIBgTDExyBTA4xw/FZuO39BpItMWC4
         jrk3qwWlABYehyaSIok7gWSrF0yB/NlUVLDJic0WLn0SgPycBGESMNAIcr+xn+G7ZVYA
         ym5VpliTw/3ZFi5b0+l13Y5ZjHUMD1omSAJf36oQQNbuOVOtEtgsoGABkDN0UJ3567u4
         NorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/iSqBVg1YOHEHtFtoKF8EBfJrdT6u7/8yJl358aav0=;
        b=S0Qtyvo7ThHYBRNp/F9YTMQp1d+hWpm6OiQDFGWvKsS6G3Kf6rVPZJBDBAtlFwWsg2
         OHc0LZJpbx1ztczELCC+JUd7S6Wj0jh8BdFQg8Exf2q0h6ijwEYB1dlQ5/oTFWfOfxbb
         40EDy4lczLUbrDm8MHnszAlIjZ895onRxac/OG3LsEtSOH/5p8jxJnNDgj22327k/7Yp
         MSdPfXF80PE4cqJuDs/Ob4bDMGqxrSxlGaG8+31SjHpBXpCy9u/Zy0RNPezgL5fKLsiC
         UC1Knu1+KofNJu5DxcbLU5bK3Mn9j82TV+U0C0CS2ruexDTOK+4nRYBwn2/V9LsHSKXA
         lSEQ==
X-Gm-Message-State: AOAM532TI23bUjjvfDhpCUyf933JTuImlftsWjQWsbQj2vl2C0xsrHzq
	WS5Ks6atBDfeBrompYx/6l1lBvZ5vfSxxW2spSyD/w==
X-Google-Smtp-Source: ABdhPJxsskPSzKaSZPJYohnrTDZszdo2yqGxotaVocKrNWJqixlR+zaqhPGBgD3L0ftbDs+aRcC6a246W/M1xptXxwQ=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr7356306edw.97.1619223493083;
 Fri, 23 Apr 2021 17:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210325230938.30752-1-joao.m.martins@oracle.com> <20210325230938.30752-4-joao.m.martins@oracle.com>
In-Reply-To: <20210325230938.30752-4-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 23 Apr 2021 17:18:07 -0700
Message-ID: <CAPcyv4h4TrHWzrpQQHsO4FnTJcZvhw25LJSe5GZ-7ojTu=kL_A@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] mm/page_alloc: refactor memmap_init_zone_device()
 page init
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: DO7FCIOQCMZ726KCIUXL2SJOG5RJP4DQ
X-Message-ID-Hash: DO7FCIOQCMZ726KCIUXL2SJOG5RJP4DQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DO7FCIOQCMZ726KCIUXL2SJOG5RJP4DQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Move struct page init to an helper function __init_zone_device_page().

Same sentence addition suggestion from the last patch to make this
patch have some rationale for existing.

>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  mm/page_alloc.c | 74 +++++++++++++++++++++++++++----------------------
>  1 file changed, 41 insertions(+), 33 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 43dd98446b0b..58974067bbd4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6237,6 +6237,46 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
>  }
>
>  #ifdef CONFIG_ZONE_DEVICE
> +static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> +                                         unsigned long zone_idx, int nid,
> +                                         struct dev_pagemap *pgmap)
> +{
> +
> +       __init_single_page(page, pfn, zone_idx, nid);
> +
> +       /*
> +        * Mark page reserved as it will need to wait for onlining
> +        * phase for it to be fully associated with a zone.
> +        *
> +        * We can use the non-atomic __set_bit operation for setting
> +        * the flag as we are still initializing the pages.
> +        */
> +       __SetPageReserved(page);
> +
> +       /*
> +        * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
> +        * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
> +        * ever freed or placed on a driver-private list.
> +        */
> +       page->pgmap = pgmap;
> +       page->zone_device_data = NULL;
> +
> +       /*
> +        * Mark the block movable so that blocks are reserved for
> +        * movable at startup. This will force kernel allocations
> +        * to reserve their blocks rather than leaking throughout
> +        * the address space during boot when many long-lived
> +        * kernel allocations are made.
> +        *
> +        * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
> +        * because this is done early in section_activate()
> +        */
> +       if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
> +               set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> +               cond_resched();
> +       }
> +}
> +
>  void __ref memmap_init_zone_device(struct zone *zone,
>                                    unsigned long start_pfn,
>                                    unsigned long nr_pages,
> @@ -6265,39 +6305,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>                 struct page *page = pfn_to_page(pfn);
>
> -               __init_single_page(page, pfn, zone_idx, nid);
> -
> -               /*
> -                * Mark page reserved as it will need to wait for onlining
> -                * phase for it to be fully associated with a zone.
> -                *
> -                * We can use the non-atomic __set_bit operation for setting
> -                * the flag as we are still initializing the pages.
> -                */
> -               __SetPageReserved(page);
> -
> -               /*
> -                * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
> -                * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
> -                * ever freed or placed on a driver-private list.
> -                */
> -               page->pgmap = pgmap;
> -               page->zone_device_data = NULL;
> -
> -               /*
> -                * Mark the block movable so that blocks are reserved for
> -                * movable at startup. This will force kernel allocations
> -                * to reserve their blocks rather than leaking throughout
> -                * the address space during boot when many long-lived
> -                * kernel allocations are made.
> -                *
> -                * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
> -                * because this is done early in section_activate()
> -                */
> -               if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
> -                       set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> -                       cond_resched();
> -               }
> +               __init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>         }
>
>         pr_info("%s initialised %lu pages in %ums\n", __func__,
> --
> 2.17.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
