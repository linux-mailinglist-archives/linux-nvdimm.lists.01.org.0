Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75316340AD7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Mar 2021 18:03:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E8B8A100EB35B;
	Thu, 18 Mar 2021 10:03:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6F9EE100EB35A
	for <linux-nvdimm@lists.01.org>; Thu, 18 Mar 2021 10:03:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e7so7542411edu.10
        for <linux-nvdimm@lists.01.org>; Thu, 18 Mar 2021 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncWZPnyeBiWOdZ1rqhn/kolCjnyW0fSBUFhdCHieBDM=;
        b=t7GWySP7B7GjasZeOxZIv+aUzBxCH4W8Be/Cy5Zw06Sb0yLfg7nYnjvi+LMPGBm+iy
         XU1pC+kO/ONtX1X5jRrh3oWqaYzP8VrOMDMSdbE3sEb/K2OPCuj32WF8LUbnS7WUUkER
         f/4lOy6HJMClpiu6qjhKKZtFhrjrVQKGnwMR9WtL5EBd/KCh9of1N1ll67hR0YZeKLV3
         KK/KNTdOTBqCM8AiipskMe6qhvDgT+aMxNjpBn2xW5c+VJQ6/8OIeFu7onCvsXGWhx2J
         VnXJ1RI+QZOWD8OVrk9m6l/pxM2WFTO5fyo5bQSttDcPLA4PDtmJKUqI3QzfSqUqh75G
         Wkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncWZPnyeBiWOdZ1rqhn/kolCjnyW0fSBUFhdCHieBDM=;
        b=UCuKnVB0W6lYKBO9ir38O8ze2LtzhqXLLUt5aXxHGbKs+vupYzOGYWFnb4ylH/SKUV
         7ji0EDsqJbUx+IJzyKKBKenZwpO17fwUFvZVfPZFaA9jR/FLhbxxv0Oh40i9xUYtwQoc
         sOw7RCOMMGEtDTj69dJw05SWykPJWusJ3jiPHL872kd8XqnA5MLOfqa3f2Ui7UTXviji
         GUWRaVjQiZS0WyQ5WYqC00X7tb/RqMtj6m60TtDDXBt+4iShrEv78YzkroTZd+c4+4Hs
         yRL/TN2CCOVMgEQuNIDjATu73zULXyHsQQcUwHcKGnyYX8qgEozFx5YhQ6w3jJDf0PnW
         /uCw==
X-Gm-Message-State: AOAM531Ktiml5on6fPB4M8Ms7JxxpCYlmpPxaF6ptAKyntgEJsyrrDLe
	e6HzLaGuk45FLwHj0RX7PfOVwFGf2O1RPmjvcOTJjg==
X-Google-Smtp-Source: ABdhPJxuNsdRluFA0/M5LLOxZ8cJZSLdLyy24eAaZULCocflm5Th9Ab5OwvvWKq3EP121Lq2ytUniLx2mfNJE2c/9s0=
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr3827680edu.52.1616086991914;
 Thu, 18 Mar 2021 10:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
 <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
In-Reply-To: <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Mar 2021 10:03:06 -0700
Message-ID: <CAPcyv4g8=kGoQiY14CDEZryb-7T1_tePnC_-21w-wTfA7fQcDg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: 2G355OFILVBITKG7Z5SDUAX2HTUHO7AO
X-Message-ID-Hash: 2G355OFILVBITKG7Z5SDUAX2HTUHO7AO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, david <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2G355OFILVBITKG7Z5SDUAX2HTUHO7AO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 18, 2021 at 3:02 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/18/21 4:08 AM, Dan Williams wrote:
> > Now that device-dax and filesystem-dax are guaranteed to unmap all user
> > mappings of devmap / DAX pages before tearing down the 'struct page'
> > array, get_user_pages_fast() can rely on its traditional synchronization
> > method "validate_pte(); get_page(); revalidate_pte()" to catch races with
> > device shutdown. Specifically the unmap guarantee ensures that gup-fast
> > either succeeds in taking a page reference (lock-less), or it detects a
> > need to fall back to the slow path where the device presence can be
> > revalidated with locks held.
>
> [...]
>
> > @@ -2087,21 +2078,26 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> >  #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
> >
> >  #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> > +
> >  static int __gup_device_huge(unsigned long pfn, unsigned long addr,
> >                            unsigned long end, unsigned int flags,
> >                            struct page **pages, int *nr)
> >  {
> >       int nr_start = *nr;
> > -     struct dev_pagemap *pgmap = NULL;
> >
> >       do {
> > -             struct page *page = pfn_to_page(pfn);
> > +             struct page *page;
> > +
> > +             /*
> > +              * Typically pfn_to_page() on a devmap pfn is not safe
> > +              * without holding a live reference on the hosting
> > +              * pgmap. In the gup-fast path it is safe because any
> > +              * races will be resolved by either gup-fast taking a
> > +              * reference or the shutdown path unmapping the pte to
> > +              * trigger gup-fast to fall back to the slow path.
> > +              */
> > +             page = pfn_to_page(pfn);
> >
> > -             pgmap = get_dev_pagemap(pfn, pgmap);
> > -             if (unlikely(!pgmap)) {
> > -                     undo_dev_pagemap(nr, nr_start, flags, pages);
> > -                     return 0;
> > -             }
> >               SetPageReferenced(page);
> >               pages[*nr] = page;
> >               if (unlikely(!try_grab_page(page, flags))) {
>
> So for allowing FOLL_LONGTERM[0] would it be OK if we used page->pgmap after
> try_grab_page() for checking pgmap type to see if we are in a device-dax
> longterm pin?
>

Yes. I still need to answer the question of whether mapping
invalidation triggers longterm pin holders to relinquish their hold,
but that's a problem regardless of whether gup-fast is supported or
not.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
