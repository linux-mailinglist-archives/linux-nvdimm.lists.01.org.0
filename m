Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BECA33E1A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Jun 2019 06:47:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3AB4521283A69;
	Mon,  3 Jun 2019 21:47:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BF98221A070B8
 for <linux-nvdimm@lists.01.org>; Mon,  3 Jun 2019 21:47:38 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id e189so7867682oib.11
 for <linux-nvdimm@lists.01.org>; Mon, 03 Jun 2019 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NIMPqRiIc7VO9Ecs79FZ0/smvxfEMHT4jVxiExc4CdA=;
 b=Cnt8/9rXTev0n4TZ8V6Pn7Ou3j2r19rDkWIsWPqnviE7o+nosWy84tHUvvUGqI7/Zv
 zX4AOW4iabUYCWul4Mhuv0n3GFJNU/nu66m0/fgV2tB6bOg3nYRwzw/WDlfDJvfQvcTd
 cH23g1Ji/7t+0CKCKnBMsHU4SAZlH+3c+5oAms191FPz/deXAVh7mai6hE8/g0z1t2AT
 wPQS1I/w2eqUWZ5vplV0wZzXYRHLEsFC/49hsYZXKRYRBm+G42b4u6jK/iBv1841EIws
 aUc8vzca6AXpHwuynnM2PtvWpwctdKzjek5rsg0E6FDnY7fSAZudzrIQCiX7fZmc80Hv
 ylqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NIMPqRiIc7VO9Ecs79FZ0/smvxfEMHT4jVxiExc4CdA=;
 b=WDvb86F1YXd99cFQ7MtxnzGZF5sy86nzIKuue391DUykENUPfBb8e/Dc9fldJ/i0Mi
 vLh8W8kCrWgMCv0GjXFt1Wrkj2iWXSC7BOgXXQnBGoSnCQeNJ0vpeEk7EOqLHrXU79vQ
 rMdHmVxFLdmV1Y5gkWbjTObwfonpmUE1I1t0IS3uURRI7hjHf8uHlyFrvb5Pi9kEsCaS
 Q+mV7Jug/ZEwRp3xG6OqShHr+/D4zk8eOVAHOdOy3Ag9+0FUTMGfT57lamFmr1aJs8Y5
 p+zPUC/xLikg6huh/r1YAS5segE6HOItueC69f4ArySRDBVxYkkVkVWc2I+arInOcQSs
 Z+Tw==
X-Gm-Message-State: APjAAAVBZ9VfXBVmYyKt1MLnZZgTHXL9fhyppXqCKmBISx1gX8Jbc/iu
 svHhMGHrXplKqGR0ksmzXyQ8jYR5HfnQQE8vc1XfNw==
X-Google-Smtp-Source: APXvYqy9sW2LEKuD1NjiRnAQYvaN7oPBcJ5189ofJPPWbpQKpR0eVVumrOlBe63/lRBgYjPKVWqQYbMsBUdNwgc6RDA=
X-Received: by 2002:aca:4208:: with SMTP id p8mr3327666oia.105.1559623657377; 
 Mon, 03 Jun 2019 21:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155718601407.130019.14248061058774128227.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190513135317.GA31168@linux>
In-Reply-To: <20190513135317.GA31168@linux>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 3 Jun 2019 21:47:25 -0700
Message-ID: <CAPcyv4hq2yp0d3Tx8HUWJwLhXw2y=0sTRpd8EQhZ+8ffjQgnDg@mail.gmail.com>
Subject: Re: [PATCH v8 09/12] mm/sparsemem: Support sub-section hotplug
To: Oscar Salvador <osalvador@suse.de>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, May 13, 2019 at 6:55 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, May 06, 2019 at 04:40:14PM -0700, Dan Williams wrote:
> >
> > +void subsection_mask_set(unsigned long *map, unsigned long pfn,
> > +             unsigned long nr_pages)
> > +{
> > +     int idx = subsection_map_index(pfn);
> > +     int end = subsection_map_index(pfn + nr_pages - 1);
> > +
> > +     bitmap_set(map, idx, end - idx + 1);
> > +}
> > +
> >  void subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> >  {
> >       int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> > @@ -219,20 +235,17 @@ void subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> >               return;
> >
> >       for (i = start_sec; i <= end_sec; i++) {
> > -             int idx, end;
> > -             unsigned long pfns;
> >               struct mem_section *ms;
> > +             unsigned long pfns;
> >
> > -             idx = subsection_map_index(pfn);
> >               pfns = min(nr_pages, PAGES_PER_SECTION
> >                               - (pfn & ~PAGE_SECTION_MASK));
> > -             end = subsection_map_index(pfn + pfns - 1);
> > -
> >               ms = __nr_to_section(i);
> > -             bitmap_set(ms->usage->subsection_map, idx, end - idx + 1);
> > +             subsection_mask_set(ms->usage->subsection_map, pfn, pfns);
> >
> >               pr_debug("%s: sec: %d pfns: %ld set(%d, %d)\n", __func__, i,
> > -                             pfns, idx, end - idx + 1);
> > +                             pfns, subsection_map_index(pfn),
> > +                             subsection_map_index(pfn + pfns - 1));
>
> I would definetely add subsection_mask_set() and above change to Patch#3.
> I think it suits there better than here.

Yes, done.

>
> >
> >               pfn += pfns;
> >               nr_pages -= pfns;
> > @@ -319,6 +332,15 @@ static void __meminit sparse_init_one_section(struct mem_section *ms,
> >               unsigned long pnum, struct page *mem_map,
> >               struct mem_section_usage *usage)
> >  {
> > +     /*
> > +      * Given that SPARSEMEM_VMEMMAP=y supports sub-section hotplug,
> > +      * ->section_mem_map can not be guaranteed to point to a full
> > +      *  section's worth of memory.  The field is only valid / used
> > +      *  in the SPARSEMEM_VMEMMAP=n case.
> > +      */
> > +     if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> > +             mem_map = NULL;
> > +
> >       ms->section_mem_map &= ~SECTION_MAP_MASK;
> >       ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum) |
> >                                                       SECTION_HAS_MEM_MAP;
> > @@ -724,10 +746,142 @@ static void free_map_bootmem(struct page *memmap)
> >  #endif /* CONFIG_MEMORY_HOTREMOVE */
> >  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> >
> > +#ifndef CONFIG_MEMORY_HOTREMOVE
> > +static void free_map_bootmem(struct page *memmap)
> > +{
> > +}
> > +#endif
> > +
> > +static bool is_early_section(struct mem_section *ms)
> > +{
> > +     struct page *usage_page;
> > +
> > +     usage_page = virt_to_page(ms->usage);
> > +     if (PageSlab(usage_page) || PageCompound(usage_page))
> > +             return false;
> > +     else
> > +             return true;
> > +}
> > +
> > +static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> > +             int nid, struct vmem_altmap *altmap)
> > +{
> > +     DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> > +     DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> > +     struct mem_section *ms = __pfn_to_section(pfn);
> > +     bool early_section = is_early_section(ms);
> > +     struct page *memmap = NULL;
> > +     unsigned long *subsection_map = ms->usage
> > +             ? &ms->usage->subsection_map[0] : NULL;
> > +
> > +     subsection_mask_set(map, pfn, nr_pages);
> > +     if (subsection_map)
> > +             bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
> > +
> > +     if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> > +                             "section already deactivated (%#lx + %ld)\n",
> > +                             pfn, nr_pages))
> > +             return;
> > +
> > +     if (WARN(!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP)
> > +                             && nr_pages < PAGES_PER_SECTION,
> > +                             "partial memory section removal not supported\n"))
> > +             return;
> > +
> > +     /*
> > +      * There are 3 cases to handle across two configurations
> > +      * (SPARSEMEM_VMEMMAP={y,n}):
> > +      *
> > +      * 1/ deactivation of a partial hot-added section (only possible
> > +      * in the SPARSEMEM_VMEMMAP=y case).
> > +      *    a/ section was present at memory init
> > +      *    b/ section was hot-added post memory init
> > +      * 2/ deactivation of a complete hot-added section
> > +      * 3/ deactivation of a complete section from memory init
> > +      *
> > +      * For 1/, when subsection_map does not empty we will not be
> > +      * freeing the usage map, but still need to free the vmemmap
> > +      * range.
> > +      *
> > +      * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
> > +      */
> > +     bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> > +     if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
> > +             unsigned long section_nr = pfn_to_section_nr(pfn);
> > +
> > +             if (!early_section) {
> > +                     kfree(ms->usage);
> > +                     ms->usage = NULL;
> > +             }
> > +             memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> > +             ms->section_mem_map = sparse_encode_mem_map(NULL, section_nr);
> > +     }
> > +
> > +     if (early_section && memmap)
> > +             free_map_bootmem(memmap);
> > +     else
> > +             depopulate_section_memmap(pfn, nr_pages, altmap);
> > +}
> > +
> > +static struct page * __meminit section_activate(int nid, unsigned long pfn,
> > +             unsigned long nr_pages, struct vmem_altmap *altmap)
> > +{
> > +     DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> > +     struct mem_section *ms = __pfn_to_section(pfn);
> > +     struct mem_section_usage *usage = NULL;
> > +     unsigned long *subsection_map;
> > +     struct page *memmap;
> > +     int rc = 0;
> > +
> > +     subsection_mask_set(map, pfn, nr_pages);
> > +
> > +     if (!ms->usage) {
> > +             usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> > +             if (!usage)
> > +                     return ERR_PTR(-ENOMEM);
> > +             ms->usage = usage;
> > +     }
> > +     subsection_map = &ms->usage->subsection_map[0];
> > +
> > +     if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> > +             rc = -EINVAL;
> > +     else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
> > +             rc = -EEXIST;
> > +     else
> > +             bitmap_or(subsection_map, map, subsection_map,
> > +                             SUBSECTIONS_PER_SECTION);
> > +
> > +     if (rc) {
> > +             if (usage)
> > +                     ms->usage = NULL;
> > +             kfree(usage);
> > +             return ERR_PTR(rc);
> > +     }
> > +
> > +     /*
> > +      * The early init code does not consider partially populated
> > +      * initial sections, it simply assumes that memory will never be
> > +      * referenced.  If we hot-add memory into such a section then we
> > +      * do not need to populate the memmap and can simply reuse what
> > +      * is already there.
> > +      */
> > +     if (nr_pages < PAGES_PER_SECTION && is_early_section(ms))
> > +             return pfn_to_page(pfn);
> > +
> > +     memmap = populate_section_memmap(pfn, nr_pages, nid, altmap);
> > +     if (!memmap) {
> > +             section_deactivate(pfn, nr_pages, nid, altmap);
> > +             return ERR_PTR(-ENOMEM);
> > +     }
> > +
> > +     return memmap;
> > +}
>
> I do not really like this.
> Sub-section scheme is only available on CONFIG_SPARSE_VMEMMAP, so I would rather
> have two internal __section_{activate,deactivate} functions for sparse-vmemmap and
> sparse-non-vmemmap.
> That way, we can hide all detail implementation and sub-section dance behind
> the __section_{activate,deactivate} functions.

I don't see the win for doing that. The code would have 2 places to
check when making a change that might apply to both cases. If one
function can handle both configurations then it makes sense to keep
them unified. However, this did prompt me to go kill the unnecessary
WARN(!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP...) in section_deactivate()
since that is already covered by check_pfn_span() (formerly
subsection_check()).

>
> > +
> > @@ -741,49 +895,31 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> >               unsigned long nr_pages, struct vmem_altmap *altmap)
> >  {
> >       unsigned long section_nr = pfn_to_section_nr(start_pfn);
> > -     struct mem_section_usage *usage;
> >       struct mem_section *ms;
> >       struct page *memmap;
> >       int ret;
> >
> > -     /*
> > -      * no locking for this, because it does its own
> > -      * plus, it does a kmalloc
> > -      */
> >       ret = sparse_index_init(section_nr, nid);
> >       if (ret < 0 && ret != -EEXIST)
> >               return ret;
> > -     ret = 0;
> > -     memmap = populate_section_memmap(start_pfn, PAGES_PER_SECTION, nid,
> > -                     altmap);
> > -     if (!memmap)
> > -             return -ENOMEM;
> > -     usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> > -     if (!usage) {
> > -             depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
> > -             return -ENOMEM;
> > -     }
> >
> > -     ms = __pfn_to_section(start_pfn);
> > -     if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
> > -             ret = -EEXIST;
> > -             goto out;
> > -     }
> > +     memmap = section_activate(nid, start_pfn, nr_pages, altmap);
> > +     if (IS_ERR(memmap))
> > +             return PTR_ERR(memmap);
> > +     ret = 0;
> >
> >       /*
> >        * Poison uninitialized struct pages in order to catch invalid flags
> >        * combinations.
> >        */
> > -     page_init_poison(memmap, sizeof(struct page) * PAGES_PER_SECTION);
> > +     page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
> >
> > +     ms = __pfn_to_section(start_pfn);
> >       section_mark_present(ms);
> > -     sparse_init_one_section(ms, section_nr, memmap, usage);
> > +     sparse_init_one_section(ms, section_nr, memmap, ms->usage);
> >
> > -out:
> > -     if (ret < 0) {
> > -             kfree(usage);
> > -             depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
> > -     }
> > +     if (ret < 0)
> > +             section_deactivate(start_pfn, nr_pages, nid, altmap);
> >       return ret;
> >  }
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 34f322d14e62..daeb2d7d8dd0 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -900,13 +900,12 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>         int ret;
>
>         ret = sparse_index_init(section_nr, nid);
> -       if (ret < 0 && ret != -EEXIST)
> +       if (ret < 0)
>                 return ret;
>
>         memmap = section_activate(nid, start_pfn, nr_pages, altmap);
>         if (IS_ERR(memmap))
>                 return PTR_ERR(memmap);
> -       ret = 0;
>
>         /*
>          * Poison uninitialized struct pages in order to catch invalid flags
> @@ -918,8 +917,6 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>         section_mark_present(ms);
>         sparse_init_one_section(ms, section_nr, memmap, ms->usage);
>
> -       if (ret < 0)
> -               section_deactivate(start_pfn, nr_pages, nid, altmap);
>         return ret;
>  }

Done.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
