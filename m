Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B7F322EFD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 17:45:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6003E100EBB9D;
	Tue, 23 Feb 2021 08:45:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2D3D5100EBB96
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 08:44:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c6so26729784ede.0
        for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEmd5FiXkbavQSYegFXdXskGmpLS7zI/goY7LNgK/B4=;
        b=TDan8xCuEJhqfL/iranz+HfwsGd5+A9H5+KzUnEpWGc21DPUnnovxxG/4uPTOEk4p4
         1cKvOnk3NQf9RcC4QFp3dPdVuYVZQnvizCqT31yD4oOJw5Ka57oJDQMbFGsHj1/Y3+Gm
         +B3lO+6QbBH/nchf5FCdcqhyTYws/r1D8ZE8LCwocmiYAgz+1OuSDE5jwTek5NvUcbij
         Un9zJvN408BZ+Qe0oZXoYnsQhXfiP+bk8xA6NWSpZgmNdj+ueS3t0r0NP6orwS5UL2r8
         xaO6KCJIryMThhOih50U3oTM8IamwtBftv99TF0XWygliGmmkM+t3a4R9RKrnEhjPPXf
         H36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEmd5FiXkbavQSYegFXdXskGmpLS7zI/goY7LNgK/B4=;
        b=ZV4XgWoAA8YROZS/4wWhHhQpUp9g4TOJ99cLINMd+xPfHcBGcpbgW1HxQfommufAuM
         SQciKVFRL8QJD6kNGNEt1J2UKjzvPykNn2Bpf/HmlRU9nLMBJy5R/B1KzaaNYqzAUtbL
         YS0HPnWsIRpH3FdM/sJb2QH6HZ7/sGHana6SwC19DMGB8MUkbTb8+ceivyW/SvRGtG+n
         QvD5YIi0CVMwG5O/g07pCb3xXKD3PXsUmSusTpFH+heb4g6GHvm3rbmEb1kyxig1CytK
         dM6XwI2yiYzn+eRAXF6rG939p70JjtOtBmTOhBEz1A3inbnZd+BUni3HnkAn9pAET/TQ
         B9gQ==
X-Gm-Message-State: AOAM533esGzOF4ftGbALV4/y/QPjbVaWAjVsANLTOtM0XZTTnUaLkl47
	/vP26jeb42o0NUWcR0htNFHxb6bind1c6YpIGBLaVQ==
X-Google-Smtp-Source: ABdhPJzyzYUbif39KlLojw9x5+U83YgJIk0AtFDBV59Oa1JNfH+4BvxaoJHD5j7FFRO4K5ND8Uo3oaxaARKH6pgeirc=
X-Received: by 2002:a05:6402:b1c:: with SMTP id bm28mr29364796edb.354.1614098696926;
 Tue, 23 Feb 2021 08:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com> <6a18179e-65f7-367d-89a9-d5162f10fef0@oracle.com>
In-Reply-To: <6a18179e-65f7-367d-89a9-d5162f10fef0@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Feb 2021 08:44:52 -0800
Message-ID: <CAPcyv4joomjhZYaCBNrYjvATSYgECfHYOZy=n_QVKqX7D_ReZQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: HUAWULAYNDGA3YA6JOL4EGU2INYZM7NS
X-Message-ID-Hash: HUAWULAYNDGA3YA6JOL4EGU2INYZM7NS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HUAWULAYNDGA3YA6JOL4EGU2INYZM7NS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 23, 2021 at 8:30 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 2/20/21 1:18 AM, Dan Williams wrote:
> > On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> >> Patch 6 - 8: Optimize grabbing/release a page refcount changes given that we
> >> are working with compound pages i.e. we do 1 increment/decrement to the head
> >> page for a given set of N subpages compared as opposed to N individual writes.
> >> {get,pin}_user_pages_fast() for zone_device with compound pagemap consequently
> >> improves considerably, and unpin_user_pages() improves as well when passed a
> >> set of consecutive pages:
> >>
> >>                                            before          after
> >>     (get_user_pages_fast 1G;2M page size) ~75k  us -> ~3.2k ; ~5.2k us
> >>     (pin_user_pages_fast 1G;2M page size) ~125k us -> ~3.4k ; ~5.5k us
> >
> > Compelling!
> >
>
> BTW is there any reason why we don't support pin_user_pages_fast() with FOLL_LONGTERM for
> device-dax?
>

Good catch.

Must have been an oversight of the conversion. FOLL_LONGTERM collides
with filesystem operations, but not device-dax. In fact that's the
motivation for device-dax in the first instance, no need to coordinate
runtime physical address layout changes because the device is
statically allocated.

> Looking at the history, I understand that fsdax can't support it atm, but I am not sure
> that the same holds for device-dax. I have this small chunk (see below the scissors mark)
> which relaxes this for a pgmap of type MEMORY_DEVICE_GENERIC, albeit not sure if there is
> a fundamental issue for the other types that makes this an unwelcoming change.
>
>         Joao
>
> --------------------->8---------------------
>
> Subject: [PATCH] mm/gup: allow FOLL_LONGTERM pin-fast for
>  MEMORY_DEVICE_GENERIC
>
> The downside would be one extra lookup in dev_pagemap tree
> for other pgmap->types (P2P, FSDAX, PRIVATE). But just one
> per gup-fast() call.

I'd guess a dev_pagemap lookup is faster than a get_user_pages slow
path. It should be measurable that this change is at least as fast or
faster than falling back to the slow path, but it would be good to
measure.

Code changes look good to me.

>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/linux/mm.h |  5 +++++
>  mm/gup.c           | 24 +++++++++++++-----------
>  2 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 32f0c3986d4f..c89a049bbd7a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1171,6 +1171,11 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
>                 page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
>  }
>
> +static inline bool devmap_longterm_available(const struct dev_pagemap *pgmap)
> +{

I'd call this devmap_can_longterm().

> +       return pgmap->type == MEMORY_DEVICE_GENERIC;
> +}
> +
>  /* 127: arbitrary random number, small enough to assemble well */
>  #define page_ref_zero_or_close_to_overflow(page) \
>         ((unsigned int) page_ref_count(page) + 127u <= 127u)
> diff --git a/mm/gup.c b/mm/gup.c
> index 222d1fdc5cfa..03e370d360e6 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2092,14 +2092,18 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned
> long end,
>                         goto pte_unmap;
>
>                 if (pte_devmap(pte)) {
> -                       if (unlikely(flags & FOLL_LONGTERM))
> -                               goto pte_unmap;
> -
>                         pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
>                         if (unlikely(!pgmap)) {
>                                 undo_dev_pagemap(nr, nr_start, flags, pages);
>                                 goto pte_unmap;
>                         }
> +
> +                       if (unlikely(flags & FOLL_LONGTERM) &&
> +                           !devmap_longterm_available(pgmap)) {
> +                               undo_dev_pagemap(nr, nr_start, flags, pages);
> +                               goto pte_unmap;
> +                       }
> +
>                 } else if (pte_special(pte))
>                         goto pte_unmap;
>
> @@ -2195,6 +2199,10 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>                         return 0;
>                 }
>
> +               if (unlikely(flags & FOLL_LONGTERM) &&
> +                   !devmap_longterm_available(pgmap))
> +                       return 0;
> +
> @@ -2356,12 +2364,9 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>         if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
>                 return 0;
>
> -       if (pmd_devmap(orig)) {
> -               if (unlikely(flags & FOLL_LONGTERM))
> -                       return 0;
> +       if (pmd_devmap(orig))
>                 return __gup_device_huge_pmd(orig, pmdp, addr, end, flags,
>                                              pages, nr);
> -       }
>
>         page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
>         refs = record_subpages(page, addr, end, pages + *nr);
> @@ -2390,12 +2395,9 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>         if (!pud_access_permitted(orig, flags & FOLL_WRITE))
>                 return 0;
>
> -       if (pud_devmap(orig)) {
> -               if (unlikely(flags & FOLL_LONGTERM))
> -                       return 0;
> +       if (pud_devmap(orig))
>                 return __gup_device_huge_pud(orig, pudp, addr, end, flags,
>                                              pages, nr);
> -       }
>
>         page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>         refs = record_subpages(page, addr, end, pages + *nr);
> --
> 2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
