Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08583374CCC
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 03:18:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AD669100F227A;
	Wed,  5 May 2021 18:18:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D94C100F226E
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 18:18:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id zg3so5748461ejb.8
        for <linux-nvdimm@lists.01.org>; Wed, 05 May 2021 18:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QW+c4BRkdQzNKENivs/KCXluQgAqYAg5SWCpSOBOmhI=;
        b=EvAyRASA3n1wkJe91Y9dz0Kd0zDPS6SoMq7Nuce/JEj+tlh4NzsHzlCVAyCGe+acq1
         3KPurdyhKLPw9q7MPfN/+a2j2tzdtGq6w5KX7PEUmt/XwzQbgfrxb4YMe8k4mJQquBcR
         q7ZtltBcW0BwRB+yOroQPA4XGOyffbwz5LhJgwKPOetltITP9llLYNfhqAtDmhyGdiA0
         kJWS7qFBCXuS88i0qQJaf6+o8ETI54DYRqHxJPjAISAAVViIat7y4BxGo7k6pTVa9Pyg
         8fSv4aNfShzK303vq3L1H9BpFQ5BD6XzDRSmb3KxsZrIl+VLqz4UUXrDZl22xdwYirqE
         x6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QW+c4BRkdQzNKENivs/KCXluQgAqYAg5SWCpSOBOmhI=;
        b=EjRD+W1tqn5h/Iml9fEU4DFgcCalmKS5UqDGluJwQJFgi/rOJ/VxbgnGngZoYGkxVk
         LuiyoHKHrC7gN7XnzwLHFrGRT6YnMDoYob3D8IsKqQaH6moEA4HYbBYna4LtI+XfWKsP
         +LSuUeBJZpZbDSOqs1Y1aSqcX+9wKTDTjPgr3clhQKRPWi3tAMyB4kWmYpeSF54dnRFQ
         /Ea4vCNdXrZ8LHsrDP7ZTpEV4CFgJn0GnO06k/Gzu63d1WyqLrVtEzCz6hTriH11NKxV
         keFxAY9JwNSl1H1j8+4FeDz9kQOc7QO82fgmIYTbIuEi0evyzgVOwvqmzdx0YVK58emN
         dsog==
X-Gm-Message-State: AOAM531KTvBQjLHQ/OOBB9Ess7P1sLnqqXLZocnTaby+HRzrfP8pJUQr
	oLu1n/ou8SsRKZOKRLUIgObU5x8wK91wq12Z6PwRig==
X-Google-Smtp-Source: ABdhPJznH6f/EGPS7Zw3Xb0RyZ/qfSzi9FZ5+yW4s368AM60XGl0OR4QgU6nUrZaWo4rJLqklwv+LzhAwdzaXnqRorU=
X-Received: by 2002:a17:907:1183:: with SMTP id uz3mr1599006ejb.264.1620263894935;
 Wed, 05 May 2021 18:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210325230938.30752-1-joao.m.martins@oracle.com> <20210325230938.30752-8-joao.m.martins@oracle.com>
In-Reply-To: <20210325230938.30752-8-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 May 2021 18:18:18 -0700
Message-ID: <CAPcyv4hcMg6cJctnY6V=ngL9GoPVvd3sSYRbS-WZoTg=SnrhEw@mail.gmail.com>
Subject: Re: [PATCH v1 07/11] mm/sparse-vmemmap: populate compound pagemaps
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: YBKWJQJ5QQCIHCEKD2EBK4VJ5RDZZW5W
X-Message-ID-Hash: YBKWJQJ5QQCIHCEKD2EBK4VJ5RDZZW5W
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YBKWJQJ5QQCIHCEKD2EBK4VJ5RDZZW5W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> A compound pagemap is a dev_pagemap with @align > PAGE_SIZE and it
> means that pages are mapped at a given huge page alignment and utilize
> uses compound pages as opposed to order-0 pages.
>
> To minimize struct page overhead we take advantage of the fact that

I'm not sure if Andrew is a member of the "we" police, but I am on
team "imperative tense".

"Take advantage of the fact that most tail pages look the same (except
the first two) to minimize struct page overhead."

...I think all the other "we"s below can be dropped without losing any meaning.

> most tail pages look the same (except the first two). We allocate a
> separate page for the vmemmap area which contains the head page and
> separate for the next 64 pages. The rest of the subsections then reuse
> this tail vmemmap page to initialize the rest of the tail pages.
>
> Sections are arch-dependent (e.g. on x86 it's 64M, 128M or 512M) and
> when initializing compound pagemap with big enough @align (e.g. 1G
> PUD) it  will cross various sections. To be able to reuse tail pages
> across sections belonging to the same gigantic page we fetch the
> @range being mapped (nr_ranges + 1).  If the section being mapped is
> not offset 0 of the @align, then lookup the PFN of the struct page
> address that preceeds it and use that to populate the entire

s/preceeds/precedes/

> section.
>
> On compound pagemaps with 2M align, this lets mechanism saves 6 pages

s/lets mechanism saves 6 pages/this mechanism lets 6 pages be saved/

> out of the 8 necessary PFNs necessary to set the subsection's 512
> struct pages being mapped. On a 1G compound pagemap it saves
> 4094 pages.
>
> Altmap isn't supported yet, given various restrictions in altmap pfn
> allocator, thus fallback to the already in use vmemmap_populate().

Perhaps also note that altmap for devmap mappings was there to relieve
the pressure of inordinate amounts of memmap space to map terabytes of
PMEM. With compound pages the motivation for altmaps for PMEM is
reduced.

>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/linux/mm.h  |   2 +-
>  mm/memremap.c       |   1 +
>  mm/sparse-vmemmap.c | 139 ++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 131 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 61474602c2b1..49d717ae40ae 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3040,7 +3040,7 @@ p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
>  pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
>  pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
>  pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
> -                           struct vmem_altmap *altmap);
> +                           struct vmem_altmap *altmap, void *block);
>  void *vmemmap_alloc_block(unsigned long size, int node);
>  struct vmem_altmap;
>  void *vmemmap_alloc_block_buf(unsigned long size, int node,
> diff --git a/mm/memremap.c b/mm/memremap.c
> index d160853670c4..2e6bc0b1ff00 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -345,6 +345,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>  {
>         struct mhp_params params = {
>                 .altmap = pgmap_altmap(pgmap),
> +               .pgmap = pgmap,
>                 .pgprot = PAGE_KERNEL,
>         };
>         const int nr_range = pgmap->nr_range;
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 8814876edcfa..f57c5eada099 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -141,16 +141,20 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
>  }
>
>  pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
> -                                      struct vmem_altmap *altmap)
> +                                      struct vmem_altmap *altmap, void *block)

For type-safety I would make this argument a 'struct page *' and drop
the virt_to_page().

>  {
>         pte_t *pte = pte_offset_kernel(pmd, addr);
>         if (pte_none(*pte)) {
>                 pte_t entry;
> -               void *p;
> -
> -               p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
> -               if (!p)
> -                       return NULL;
> +               void *p = block;
> +
> +               if (!block) {
> +                       p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
> +                       if (!p)
> +                               return NULL;
> +               } else if (!altmap) {
> +                       get_page(virt_to_page(block));

This is either super subtle, or there is a missing put_page(). I'm
assuming that in the shutdown path the same page will be freed
multiple times because the same page is mapped multiple times.

Have you validated that the accounting is correct and all allocated
pages get freed? I feel this needs more than a comment, it needs a
test to validate that the accounting continues to happen correctly as
future vmemmap changes land.

> +               }
>                 entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
>                 set_pte_at(&init_mm, addr, pte, entry);
>         }
> @@ -217,7 +221,8 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
>  }
>
>  static int __meminit vmemmap_populate_address(unsigned long addr, int node,
> -                                             struct vmem_altmap *altmap)
> +                                             struct vmem_altmap *altmap,
> +                                             void *page, void **ptr)
>  {
>         pgd_t *pgd;
>         p4d_t *p4d;
> @@ -237,10 +242,14 @@ static int __meminit vmemmap_populate_address(unsigned long addr, int node,
>         pmd = vmemmap_pmd_populate(pud, addr, node);
>         if (!pmd)
>                 return -ENOMEM;
> -       pte = vmemmap_pte_populate(pmd, addr, node, altmap);
> +       pte = vmemmap_pte_populate(pmd, addr, node, altmap, page);
>         if (!pte)
>                 return -ENOMEM;
>         vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
> +
> +       if (ptr)
> +               *ptr = __va(__pfn_to_phys(pte_pfn(*pte)));
> +       return 0;
>  }
>
>  int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
> @@ -249,7 +258,110 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>         unsigned long addr = start;
>
>         for (; addr < end; addr += PAGE_SIZE) {
> -               if (vmemmap_populate_address(addr, node, altmap))
> +               if (vmemmap_populate_address(addr, node, altmap, NULL, NULL))
> +                       return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static int __meminit vmemmap_populate_range(unsigned long start,
> +                                           unsigned long end,
> +                                           int node, void *page)
> +{
> +       unsigned long addr = start;
> +
> +       for (; addr < end; addr += PAGE_SIZE) {
> +               if (vmemmap_populate_address(addr, node, NULL, page, NULL))
> +                       return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static inline int __meminit vmemmap_populate_page(unsigned long addr, int node,
> +                                                 void **ptr)
> +{
> +       return vmemmap_populate_address(addr, node, NULL, NULL, ptr);
> +}
> +
> +static pte_t * __meminit vmemmap_lookup_address(unsigned long addr)

I think this can be replaced with a call to follow_pte(&init_mm...).

> +{
> +       pgd_t *pgd;
> +       p4d_t *p4d;
> +       pud_t *pud;
> +       pmd_t *pmd;
> +       pte_t *pte;
> +
> +       pgd = pgd_offset_k(addr);
> +       if (pgd_none(*pgd))
> +               return NULL;
> +
> +       p4d = p4d_offset(pgd, addr);
> +       if (p4d_none(*p4d))
> +               return NULL;
> +
> +       pud = pud_offset(p4d, addr);
> +       if (pud_none(*pud))
> +               return NULL;
> +
> +       pmd = pmd_offset(pud, addr);
> +       if (pmd_none(*pmd))
> +               return NULL;
> +
> +       pte = pte_offset_kernel(pmd, addr);
> +       if (pte_none(*pte))
> +               return NULL;
> +
> +       return pte;
> +}
> +
> +static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
> +                                                    unsigned long start,
> +                                                    unsigned long end, int node,
> +                                                    struct dev_pagemap *pgmap)
> +{
> +       unsigned long offset, size, addr;
> +
> +       /*
> +        * For compound pages bigger than section size (e.g. 1G) fill the rest

Oh, I had to read this a couple times because I thought the "e.g." was
referring to section size. How about:

s/(e.g. 1G)/(e.g. x86 1G compound pages with 2M subsection size)/

> +        * of sections as tail pages.
> +        *
> +        * Note that memremap_pages() resets @nr_range value and will increment
> +        * it after each range successful onlining. Thus the value or @nr_range
> +        * at section memmap populate corresponds to the in-progress range
> +        * being onlined that we care about.
> +        */
> +       offset = PFN_PHYS(start_pfn) - pgmap->ranges[pgmap->nr_range].start;
> +       if (!IS_ALIGNED(offset, pgmap_align(pgmap)) &&
> +           pgmap_align(pgmap) > SUBSECTION_SIZE) {
> +               pte_t *ptep = vmemmap_lookup_address(start - PAGE_SIZE);
> +
> +               if (!ptep)
> +                       return -ENOMEM;

Side note: I had been resistant to adding 'struct page' for altmap
pages, but that would be a requirement to enable compound pages +
altmap.

> +

Perhaps a comment here to the effect "recall the page that was
allocated in a prior iteration and fill it in with tail pages".

> +               return vmemmap_populate_range(start, end, node,
> +                                             page_to_virt(pte_page(*ptep)));

If the @block parameter changes to a 'struct page *' it also saves
some typing here.

> +       }
> +
> +       size = min(end - start, pgmap_pfn_align(pgmap) * sizeof(struct page));
> +       for (addr = start; addr < end; addr += size) {
> +               unsigned long next = addr, last = addr + size;
> +               void *block;
> +
> +               /* Populate the head page vmemmap page */
> +               if (vmemmap_populate_page(addr, node, NULL))
> +                       return -ENOMEM;
> +
> +               /* Populate the tail pages vmemmap page */
> +               block = NULL;
> +               next = addr + PAGE_SIZE;
> +               if (vmemmap_populate_page(next, node, &block))
> +                       return -ENOMEM;
> +
> +               /* Reuse the previous page for the rest of tail pages */
> +               next += PAGE_SIZE;
> +               if (vmemmap_populate_range(next, last, node, block))
>                         return -ENOMEM;
>         }
>
> @@ -262,12 +374,19 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
>  {
>         unsigned long start = (unsigned long) pfn_to_page(pfn);
>         unsigned long end = start + nr_pages * sizeof(struct page);
> +       unsigned int align = pgmap_align(pgmap);
> +       int r;
>
>         if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
>                 !IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
>                 return NULL;
>
> -       if (vmemmap_populate(start, end, nid, altmap))
> +       if (align > PAGE_SIZE && !altmap)

I also think this code will read better the devmap_geometry enum.

> +               r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
> +       else
> +               r = vmemmap_populate(start, end, nid, altmap);
> +
> +       if (r < 0)
>                 return NULL;
>
>         return pfn_to_page(pfn);
> --
> 2.17.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
