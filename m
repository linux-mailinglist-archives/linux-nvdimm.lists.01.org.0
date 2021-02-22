Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D683220DD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 21:38:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A680100EB854;
	Mon, 22 Feb 2021 12:38:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A0C30100EB851
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 12:37:58 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k13so29550202ejs.10
        for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MBlIdLA0VSwx6W/hCIxTYoddhJum/Li+pj/dYGDa9U=;
        b=Dk0bS75VwFdEjYOe/Im88hNjREFzRT87CcEQ3LSz4o7nJNZ8p7+4FlAkLuY0M9fSSH
         XUanUHvuTMsSPGN0HFQ6eIstdodDVH+AKRSMTvDcAqtnAHdJ/7FxzDV3o/yItd3kmbm7
         9zlwrKAhNnRIQJWk+HxF9MJuzoYbt99vRBAa0d/5QdyWJHW5lJ6Ef7q4/YkWpLJEs1h5
         hrzVjO5dyDZQTBgrdovXzMXkvXzgRtm/vDaSnpgV7xonT7gwwYcPsp68qQjtwRVKK7T7
         D3im9XBcxUS7wyWi08Tj5/T7j1gXKHD/NwgzQJQ8SrNe1/VEgG3sJuN+GOWLMIlqCB1G
         +RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MBlIdLA0VSwx6W/hCIxTYoddhJum/Li+pj/dYGDa9U=;
        b=GOxGqsOhihBG5rLtLwLaBImRDwpdJq1/Jcxj+0CtjaHnDyGsz9tilyntuPEllcht8P
         3sSQ6oFluhMADVYBABmCvplZCfcmVCPZ2I15w4S6bRp7BpzVYrwgVMImv4bXEmAbcQNh
         MpEAasfXcw0YFAAP7EgAq9Vd4wRmyfa8YRRDx5uqvyIe+nuT5i9JPgScyelG9mmv13td
         4VuNRWLPifwEdkI0bLdXa3eTqiCFp2Un5nF+DMYmYiTL+ok9DpJfiVoBV1FGSpVJfzof
         N2mh6ZMlR9bPgWDpW53WGefORBUrMLGqgJ4is+RhXC+bUCrrsy7Fh8H++5SSc9F3mjvO
         lSXQ==
X-Gm-Message-State: AOAM531fIy/Akcchm+xxB1qJ5PE8G7FnowlyViNECQ3XTucb8ldORPt1
	pFflrCoDJed0r4SxlVzYC/o0a+Fjd20WI5ED51QPAg==
X-Google-Smtp-Source: ABdhPJyWv0++EFNUP8XqSJtcZ/NEalIt+8VkwBuYOzl967zzeCS74udD4eh9/d8xNTH6C07DJoJnGfAsWN5Yv7q50ME=
X-Received: by 2002:a17:906:5655:: with SMTP id v21mr21862369ejr.264.1614026276621;
 Mon, 22 Feb 2021 12:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com> <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
 <CAPcyv4iMzaAqKe6C1Q_feHL5SwppPdBem0i6XfYX4sL1U6sHgg@mail.gmail.com> <7e8908ca-4d0f-6549-0442-d4b15fbc90ab@oracle.com>
In-Reply-To: <7e8908ca-4d0f-6549-0442-d4b15fbc90ab@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Feb 2021 12:37:52 -0800
Message-ID: <CAPcyv4jDk=ppsR2Pvgpb1DqWk5D8bkrNCAtyRU21ShnC3fzdSA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound pages
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: DYERNY7XT7V53KL22EULTTEBY6H2H5DQ
X-Message-ID-Hash: DYERNY7XT7V53KL22EULTTEBY6H2H5DQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DYERNY7XT7V53KL22EULTTEBY6H2H5DQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 22, 2021 at 3:24 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 2/20/21 1:43 AM, Dan Williams wrote:
> > On Tue, Dec 8, 2020 at 9:59 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >> On 12/8/20 9:28 AM, Joao Martins wrote:
> >>> diff --git a/mm/memremap.c b/mm/memremap.c
> >>> index 16b2fb482da1..287a24b7a65a 100644
> >>> --- a/mm/memremap.c
> >>> +++ b/mm/memremap.c
> >>> @@ -277,8 +277,12 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
> >>>       memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
> >>>                               PHYS_PFN(range->start),
> >>>                               PHYS_PFN(range_len(range)), pgmap);
> >>> -     percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
> >>> -                     - pfn_first(pgmap, range_id));
> >>> +     if (pgmap->flags & PGMAP_COMPOUND)
> >>> +             percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
> >>> +                     - pfn_first(pgmap, range_id)) / PHYS_PFN(pgmap->align));
> >>
> >> Is there some reason that we cannot use range_len(), instead of pfn_end() minus
> >> pfn_first()? (Yes, this more about the pre-existing code than about your change.)
> >>
> >> And if not, then why are the nearby range_len() uses OK? I realize that range_len()
> >> is simpler and skips a case, but it's not clear that it's required here. But I'm
> >> new to this area so be warned. :)
> >
> > There's a subtle distinction between the range that was passed in and
> > the pfns that are activated inside of it. See the offset trickery in
> > pfn_first().
> >
> >> Also, dividing by PHYS_PFN() feels quite misleading: that function does what you
> >> happen to want, but is not named accordingly. Can you use or create something
> >> more accurately named? Like "number of pages in this large page"?
> >
> > It's not the number of pages in a large page it's converting bytes to
> > pages. Other place in the kernel write it as (x >> PAGE_SHIFT), but my
> > though process was if I'm going to add () might as well use a macro
> > that already does this.
> >
> > That said I think this calculation is broken precisely because
> > pfn_first() makes the result unaligned.
> >
> > Rather than fix the unaligned pfn_first() problem I would use this
> > support as an opportunity to revisit the option of storing pages in
> > the vmem_altmap reserve soace. The altmap's whole reason for existence
> > was that 1.5% of large PMEM might completely swamp DRAM. However if
> > that overhead is reduced by an order (or orders) of magnitude the
> > primary need for vmem_altmap vanishes.
> >
> > Now, we'll still need to keep it around for the ->align == PAGE_SIZE
> > case, but for most part existing deployments that are specifying page
> > map on PMEM and an align > PAGE_SIZE can instead just transparently be
> > upgraded to page map on a smaller amount of DRAM.
> >
> I feel the altmap is still relevant. Even with the struct page reuse for
> tail pages, the overhead for 2M align is still non-negligeble i.e. 4G per
> 1Tb (strictly speaking about what's stored in the altmap). Muchun and
> Matthew were thinking (in another thread) on compound_head() adjustments
> that probably can make this overhead go to 2G (if we learn to differentiate
> the reused head page from the real head page).

I think that realization is more justification to make a new first
class vmemmap_populate_compound_pages() rather than try to reuse
vmemmap_populate_basepages() with new parameters.

> But even there it's still
> 2G per 1Tb. 1G pages, though, have a better story to remove altmap need.

The concern that led to altmap is that someone would build a system
with a 96:1 (PMEM:RAM) ratio where that correlates to maximum PMEM and
minimum RAM, and mapping all PMEM consumes all RAM. As far as I
understand real world populations are rarely going past 8:1, that
seems to make 'struct page' in RAM feasible even for the 2M compound
page case.

Let me ask you for a data point, since you're one of the people
actively deploying such systems, would you still use the 'struct page'
in PMEM capability after this set was merged?

> One thing to point out about altmap is that the degradation (in pinning and
> unpining) we observed with struct page's in device memory, is no longer observed
> once 1) we batch ref count updates as we move to compound pages 2) reusing
> tail pages seems to lead to these struct pages staying more likely in cache
> which perhaps contributes to dirtying a lot less cachelines.

True, it makes it more palatable to survive 'struct page' in PMEM, but
it's an ongoing maintenance burden that I'm not sure there are users
after putting 'struct page' on a diet. Don't get me wrong the
capability is still needed for filesystem-dax, but the distinction is
that vmemmap_populate_compound_pages() need never worry about an
altmap.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
