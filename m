Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272EC320424
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 07:17:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 02753100EC1EB;
	Fri, 19 Feb 2021 22:17:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0F40100EC1CE
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 22:17:34 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gg8so7359159ejb.13
        for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 22:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3GUJ8AJ+D9/QZUOveSIImTcQ3VTzMGJ8kOmAXaY/1Q=;
        b=ZVl2AYyA1YI1iu7OEc6NU2FnpnuDkfnc0P6lEQcVMJOjuZl12xj6dc+Qpw03rFfrMI
         hEXWN0lxyzzjz67euwvlOzBgDokU+KYEd2+qnHSl2lRl7FS6ajbIo+sLBFy1lDheesBu
         eVLDxdJ9Tagula5miCCk90HnecsZKWazQKj0cXhZo+ltLFdCLYR8kcQ9l1q/llXzcfw/
         UM8g3kinQHURCCFH50OeviHoWDBsK/mCYhggRLPueGFGvWMA8uN0TbcjIGZp+43jt5sD
         IH6Ky2f6jpNPxa12Qy/Llrua5RZRlMJAo8vgHteJW/D5zX60v9lQ9NcJjblw8loyiZdo
         6OFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3GUJ8AJ+D9/QZUOveSIImTcQ3VTzMGJ8kOmAXaY/1Q=;
        b=SAa6bsHNDre+VpB4XqJ20jhw3k7qcgtp7+yxxx09QSU46fC7PbssM1m1B1d4V5rvAS
         ev0/CETl9NK1n/0/3t+f7aEzg8aMuG54IiQaXXWQGGxIApW+g/uWf5jGBY+nC+3JoM9u
         JNrOmIFkKD1cMqA8H10kIJMB9uKpbimVh5HxPiDeDx+2nX99FjClV77I3fWfJTQiSjXl
         DhFFtNNrH/NVnI8boYtVp/A8249ml9JESJ/tSdp5Y4DZBgA84/fT3dxtSUZC7Ccew/OH
         fOz/eplguhlm+Fli2EKpP2XrHE2rIrcyYz93dnNslyODrxiN2Hpe+CeGAOzHCjQOkMaZ
         2frA==
X-Gm-Message-State: AOAM532MPvpiG1Pu8kzCkBBVDyREySRXtMwKyV0koi394RLXvxTH8C6v
	g4teztT84iheqg9h3Gmz9sNsJbcnu403KKsUetIZFQ==
X-Google-Smtp-Source: ABdhPJzXnuIFQPZDszy5V6szEjKYAKem1l0L1r+O3UQShTT40ZGgd4VWp4tqpTkv/iCVCyRy0pzEMF0fnR97xdtBze8=
X-Received: by 2002:a17:906:e0b:: with SMTP id l11mr4756295eji.523.1613801852007;
 Fri, 19 Feb 2021 22:17:32 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com> <20201208172901.17384-6-joao.m.martins@oracle.com>
In-Reply-To: <20201208172901.17384-6-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Feb 2021 22:17:24 -0800
Message-ID: <CAPcyv4hw574wYUa0qzz+pQrB4K11R618Moh30mvLz8GLNDw=5w@mail.gmail.com>
Subject: Re: [PATCH RFC 4/9] mm/page_alloc: Reuse tail struct pages for
 compound pagemaps
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: LVX7UYNYMBGGHLH2CIEI3QZJ5KZ3KUSW
X-Message-ID-Hash: LVX7UYNYMBGGHLH2CIEI3QZJ5KZ3KUSW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LVX7UYNYMBGGHLH2CIEI3QZJ5KZ3KUSW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 8, 2020 at 9:31 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> When PGMAP_COMPOUND is set, all pages are onlined at a given huge page
> alignment and using compound pages to describe them as opposed to a
> struct per 4K.
>

Same s/online/mapped/ comment as other changelogs.

> To minimize struct page overhead and given the usage of compound pages we
> utilize the fact that most tail pages look the same, we online the
> subsection while pointing to the same pages. Thus request VMEMMAP_REUSE
> in add_pages.
>
> With VMEMMAP_REUSE, provided we reuse most tail pages the amount of
> struct pages we need to initialize is a lot smaller that the total
> amount of structs we would normnally online. Thus allow an @init_order
> to be passed to specify how much pages we want to prep upon creating a
> compound page.
>
> Finally when onlining all struct pages in memmap_init_zone_device, make
> sure that we only initialize the unique struct pages i.e. the first 2
> 4K pages from @align which means 128 struct pages out of 32768 for 2M
> @align or 262144 for a 1G @align.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  mm/memremap.c   |  4 +++-
>  mm/page_alloc.c | 23 ++++++++++++++++++++---
>  2 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memremap.c b/mm/memremap.c
> index ecfa74848ac6..3eca07916b9d 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -253,8 +253,10 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>                         goto err_kasan;
>                 }
>
> -               if (pgmap->flags & PGMAP_COMPOUND)
> +               if (pgmap->flags & PGMAP_COMPOUND) {
>                         params->align = pgmap->align;
> +                       params->flags = MEMHP_REUSE_VMEMMAP;

The "reuse" naming is not my favorite. Yes, page reuse is happening,
but what is more relevant is that the vmemmap is in a given minimum
page size mode. So it's less of a flag and more of enum that selects
between PAGE_SIZE, HPAGE_SIZE, and PUD_PAGE_SIZE (GPAGE_SIZE?).

> +               }
>
>                 error = arch_add_memory(nid, range->start, range_len(range),
>                                         params);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9716ecd58e29..180a7d4e9285 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -691,10 +691,11 @@ void free_compound_page(struct page *page)
>         __free_pages_ok(page, compound_order(page), FPI_NONE);
>  }
>
> -void prep_compound_page(struct page *page, unsigned int order)
> +static void __prep_compound_page(struct page *page, unsigned int order,
> +                                unsigned int init_order)
>  {
>         int i;
> -       int nr_pages = 1 << order;
> +       int nr_pages = 1 << init_order;
>
>         __SetPageHead(page);
>         for (i = 1; i < nr_pages; i++) {
> @@ -711,6 +712,11 @@ void prep_compound_page(struct page *page, unsigned int order)
>                 atomic_set(compound_pincount_ptr(page), 0);
>  }
>
> +void prep_compound_page(struct page *page, unsigned int order)
> +{
> +       __prep_compound_page(page, order, order);
> +}
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  unsigned int _debug_guardpage_minorder;
>
> @@ -6108,6 +6114,9 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  }
>
>  #ifdef CONFIG_ZONE_DEVICE
> +
> +#define MEMMAP_COMPOUND_SIZE (2 * (PAGE_SIZE/sizeof(struct page)))
> +
>  void __ref memmap_init_zone_device(struct zone *zone,
>                                    unsigned long start_pfn,
>                                    unsigned long nr_pages,
> @@ -6138,6 +6147,12 @@ void __ref memmap_init_zone_device(struct zone *zone,
>         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>                 struct page *page = pfn_to_page(pfn);
>
> +               /* Skip already initialized pages. */
> +               if (compound && (pfn % align >= MEMMAP_COMPOUND_SIZE)) {
> +                       pfn = ALIGN(pfn, align) - 1;
> +                       continue;
> +               }
> +
>                 __init_single_page(page, pfn, zone_idx, nid);
>
>                 /*
> @@ -6175,7 +6190,9 @@ void __ref memmap_init_zone_device(struct zone *zone,
>
>         if (compound) {
>                 for (pfn = start_pfn; pfn < end_pfn; pfn += align)
> -                       prep_compound_page(pfn_to_page(pfn), order_base_2(align));
> +                       __prep_compound_page(pfn_to_page(pfn),
> +                                          order_base_2(align),
> +                                          order_base_2(MEMMAP_COMPOUND_SIZE));
>         }

Alex did quite a bit of work to optimize this path, and this
organization appears to undo it. I'd prefer to keep it all in one loop
so a 'struct page' is only initialized once. Otherwise by the time the
above loop finishes and this one starts the 'struct page's are
probably cache cold again.

So I'd break prep_compoud_page into separate head and tail  init and
call them at the right time in one loop.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
