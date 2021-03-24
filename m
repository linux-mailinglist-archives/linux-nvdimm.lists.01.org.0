Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEF4347FBA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Mar 2021 18:45:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E9452100EB34C;
	Wed, 24 Mar 2021 10:45:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0AAFA100EB333
	for <linux-nvdimm@lists.01.org>; Wed, 24 Mar 2021 10:45:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l18so20440313edc.9
        for <linux-nvdimm@lists.01.org>; Wed, 24 Mar 2021 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGg9bkmQmUrJEoYO//o+38WT2vp4tDvJ1YauvHLK3w0=;
        b=FvQlkmFH+tOQEZcfLr3Wsp0O5iLofV5GNtUxR5JyPoM5RLG5vHO0fVqWiayt+ShEiq
         6fOcX+/MeA/YjC57p8CPqmLsGiGYJLmRra8KGCVinVIoroyCsik+dyIWDBQTzm+1KveI
         3phrbMjz/WSkCRSI41RGGf+W0S888ZEPvbBpYLoK3GfRyXt5qIb2rnZx9IzUiipPH6jt
         zozhTgF1kG6BbfK756qY10AQSO1h33cgsHI0KI8CSfl3kX3LQVP7SGifZKvRhMAeV4d9
         n+fPrenlEA+w78JYAcQjAowrJAfquHk2wnR7aqBvBIpXV+h1NRlYakr+HiETBpvDrqwm
         drfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGg9bkmQmUrJEoYO//o+38WT2vp4tDvJ1YauvHLK3w0=;
        b=nK/223KJ14u5mQR2ZbuD/Z8OBeuAMPKvppULdxqHt2MCebIbCCGAs4VGMP97LYABvT
         nCTuAdlH/VmoiGszdlFL0BvlMNTFgXbi9sSoCQehVdOyjGm1sr1pUxL4iQHsJuaxR7rj
         s8+HnNTW+mLqOrXuYLSsaHj+7vSYKalAlXqvZbZlz2J9AsiuMZ5DcNsR+XkP9Yefvnl8
         a5OW5zF171VwCg1FKpYnXVVs/d2M5PewmJVYny6O3WpiZpz/dzOHsmTWCOLHm0xbQw3S
         wK9ORVLW84+9gBbr8dghvh0gjPzISJ8vXptpMmRRgJQNSmZPUuj2blr84iTDA6pQwMnd
         JVSg==
X-Gm-Message-State: AOAM532c98tT3YX3+Nv7O1P8hU6bE4vvBYycZg9C5jzOjo/D58A1xGSH
	OS9+8UimmLOvXDXANeQ9ujxYXsqdBag5gLRHcC+6Ng==
X-Google-Smtp-Source: ABdhPJzYwYdMUsSiaziQc4bOwaRP/eIf8tsvN1+MbwfleMPszchzvYZawTUvBNwx7NAPJcu1DDlQkg6IjQ7Aaw/eheI=
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr4696265edv.300.1616607953325;
 Wed, 24 Mar 2021 10:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
 <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
In-Reply-To: <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 24 Mar 2021 10:45:42 -0700
Message-ID: <CAPcyv4jidaz=33oWFMB_aBPtYDLe-AA_NP-k_pfGADVt=w5Vng@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: RTZO5NGBJXHVXFGZTKVTFKUY3JCIZHJU
X-Message-ID-Hash: RTZO5NGBJXHVXFGZTKVTFKUY3JCIZHJU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, david <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RTZO5NGBJXHVXFGZTKVTFKUY3JCIZHJU/>
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

So, there is an effort to add a new pte bit p{m,u}d_special to disable
gup-fast for huge pages [1]. I'd like to investigate whether we could
use devmap + special as an encoding for "no longterm" and never
consult the pgmap in the gup-fast path.

[1]: https://lore.kernel.org/linux-mm/a1fa7fa2-914b-366d-9902-e5b784e8428c@shipmail.org/
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
