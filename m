Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F38B3202A7
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 02:43:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A2D1100EB84F;
	Fri, 19 Feb 2021 17:43:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42396100EB82F
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:43:28 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hs11so17388571ejc.1
        for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxmH3E7n0ca2tmyebWPpDCJEoEeBD/8l918JOWs2uUs=;
        b=mvc9KhFx5jeqxcFN4pt7D1BbQ7ow5TQaTzQah0WUpLmWB36NPnVj+mFTAj+EJFnfTf
         IDWk+eo516d3p6VOBZxFJVDqeL9XInhbflOCU8gajXj2pv2JIQvGnQXYSCs4z1jGJSD2
         0rGRlJUu2y3vGgkb3hSkOa2c4WagbuhZfGxowZHdrIHvTVS9Q+ET+aVrL9xREtbUa5lf
         RqfKLwv3av/Zs1eJSakKPxc2lhwoIRo1xCTjul8UlD2gfL6hc9UqRYGvnai3+ZkOs7cB
         tFuJw0ZfRurCA07f/fhDYJeeHGOGFTOyVyX8ThOimWwph9JIAbVuVYDIU0Di4jJQG+7i
         bkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxmH3E7n0ca2tmyebWPpDCJEoEeBD/8l918JOWs2uUs=;
        b=jSm2ecz5EZP7p4ZkRlVbY35a7+B+agE4cqwDfU0QHtxKS6JIc65jKkYCZr38OopP+m
         /ePUcTogGqnEwtV2ldpW4KtbXGHiaPVWUbpIZbu6fitSoGQAaO/f8QB73YurRkTZztXp
         VWm1RYBbUwQjVnWMr/ZB4jjmCmPYTHPecBtoi9fmQhNa4d56EGc5p5+62TUBPBiabm9o
         P2jeK02h46kjCaWT3kfATuPFhiuItMo6pAown7DJjQvztOC2pUl9cqdZQtg/89b+eipw
         dl1utzFNeXYD8UXZI0LqQDV4Va/uydCsfEz/V/WLIEhEX9lbHTQhX5f+6nDZkXsl2jxE
         cy4Q==
X-Gm-Message-State: AOAM531HAAGi5RRewmAi7sPvw194y5tfuFaO/RggpwPtLsOcg/R9ne3T
	IhZsz6Ny8MBif/+aLzOMzgj9nlYpN/9SRB25oP283g==
X-Google-Smtp-Source: ABdhPJytfGx1vdI1xGNl7smtbMdCCmCEZHDvSAmVrNdBbbDg3tk78+Tc2lCzAy0Pli+vguoQPziAqwfkiXfSaRjUo7g=
X-Received: by 2002:a17:906:e0b:: with SMTP id l11mr4008193eji.523.1613785406638;
 Fri, 19 Feb 2021 17:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com> <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
In-Reply-To: <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Feb 2021 17:43:18 -0800
Message-ID: <CAPcyv4iMzaAqKe6C1Q_feHL5SwppPdBem0i6XfYX4sL1U6sHgg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound pages
To: John Hubbard <jhubbard@nvidia.com>
Message-ID-Hash: T4ZQVJ6GVV3VLXBFBAQEIT2HBIBP77F5
X-Message-ID-Hash: T4ZQVJ6GVV3VLXBFBAQEIT2HBIBP77F5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T4ZQVJ6GVV3VLXBFBAQEIT2HBIBP77F5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 8, 2020 at 9:59 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 12/8/20 9:28 AM, Joao Martins wrote:
> > Add a new flag for struct dev_pagemap which designates that a a pagemap
>
> a a
>
> > is described as a set of compound pages or in other words, that how
> > pages are grouped together in the page tables are reflected in how we
> > describe struct pages. This means that rather than initializing
> > individual struct pages, we also initialize these struct pages, as
>
> Let's not say "rather than x, we also do y", because it's self-contradictory.
> I think you want to just leave out the "also", like this:
>
> "This means that rather than initializing> individual struct pages, we
> initialize these struct pages ..."
>
> Is that right?
>
> > compound pages (on x86: 2M or 1G compound pages)
> >
> > For certain ZONE_DEVICE users, like device-dax, which have a fixed page
> > size, this creates an opportunity to optimize GUP and GUP-fast walkers,
> > thus playing the same tricks as hugetlb pages.
> >
> > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > ---
> >   include/linux/memremap.h | 2 ++
> >   mm/memremap.c            | 8 ++++++--
> >   mm/page_alloc.c          | 7 +++++++
> >   3 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > index 79c49e7f5c30..f8f26b2cc3da 100644
> > --- a/include/linux/memremap.h
> > +++ b/include/linux/memremap.h
> > @@ -90,6 +90,7 @@ struct dev_pagemap_ops {
> >   };
> >
> >   #define PGMAP_ALTMAP_VALID  (1 << 0)
> > +#define PGMAP_COMPOUND               (1 << 1)
> >
> >   /**
> >    * struct dev_pagemap - metadata for ZONE_DEVICE mappings
> > @@ -114,6 +115,7 @@ struct dev_pagemap {
> >       struct completion done;
> >       enum memory_type type;
> >       unsigned int flags;
> > +     unsigned int align;
>
> This also needs an "@aline" entry in the comment block above.
>
> >       const struct dev_pagemap_ops *ops;
> >       void *owner;
> >       int nr_range;
> > diff --git a/mm/memremap.c b/mm/memremap.c
> > index 16b2fb482da1..287a24b7a65a 100644
> > --- a/mm/memremap.c
> > +++ b/mm/memremap.c
> > @@ -277,8 +277,12 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
> >       memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
> >                               PHYS_PFN(range->start),
> >                               PHYS_PFN(range_len(range)), pgmap);
> > -     percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
> > -                     - pfn_first(pgmap, range_id));
> > +     if (pgmap->flags & PGMAP_COMPOUND)
> > +             percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
> > +                     - pfn_first(pgmap, range_id)) / PHYS_PFN(pgmap->align));
>
> Is there some reason that we cannot use range_len(), instead of pfn_end() minus
> pfn_first()? (Yes, this more about the pre-existing code than about your change.)
>
> And if not, then why are the nearby range_len() uses OK? I realize that range_len()
> is simpler and skips a case, but it's not clear that it's required here. But I'm
> new to this area so be warned. :)

There's a subtle distinction between the range that was passed in and
the pfns that are activated inside of it. See the offset trickery in
pfn_first().

> Also, dividing by PHYS_PFN() feels quite misleading: that function does what you
> happen to want, but is not named accordingly. Can you use or create something
> more accurately named? Like "number of pages in this large page"?

It's not the number of pages in a large page it's converting bytes to
pages. Other place in the kernel write it as (x >> PAGE_SHIFT), but my
though process was if I'm going to add () might as well use a macro
that already does this.

That said I think this calculation is broken precisely because
pfn_first() makes the result unaligned.

Rather than fix the unaligned pfn_first() problem I would use this
support as an opportunity to revisit the option of storing pages in
the vmem_altmap reserve soace. The altmap's whole reason for existence
was that 1.5% of large PMEM might completely swamp DRAM. However if
that overhead is reduced by an order (or orders) of magnitude the
primary need for vmem_altmap vanishes.

Now, we'll still need to keep it around for the ->align == PAGE_SIZE
case, but for most part existing deployments that are specifying page
map on PMEM and an align > PAGE_SIZE can instead just transparently be
upgraded to page map on a smaller amount of DRAM.

>
> > +     else
> > +             percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
> > +                             - pfn_first(pgmap, range_id));
> >       return 0;
> >
> >   err_add_memory:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index eaa227a479e4..9716ecd58e29 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6116,6 +6116,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
> >       unsigned long pfn, end_pfn = start_pfn + nr_pages;
> >       struct pglist_data *pgdat = zone->zone_pgdat;
> >       struct vmem_altmap *altmap = pgmap_altmap(pgmap);
> > +     bool compound = pgmap->flags & PGMAP_COMPOUND;
> > +     unsigned int align = PHYS_PFN(pgmap->align);
>
> Maybe align_pfn or pfn_align? Don't want the same name for things that are actually
> different types, in meaning anyway.

Good catch.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
