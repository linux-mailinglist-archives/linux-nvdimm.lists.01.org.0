Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83F320386
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 04:35:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8CB07100F226A;
	Fri, 19 Feb 2021 19:35:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.208.43; helo=mail-ed1-f43.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D065E100EBBA2
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 19:35:16 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id l12so13404025edt.3
        for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 19:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6PvIqnhZ9tRiT0MCJFVIfarrGAfbfLpZZ7FO4CBjvM=;
        b=eT0S0SF3JAbyuWa0GOJOrjNAcWtBToOxT2HhNnXsmm+eGvKzMfGhvIpYynnhWmzh1u
         Hqq5BILqZwHg6wNt07nnv0jAa5wPjIbclrferoXCq6YQy4T31EqpsTtxkS87PsG/0/b5
         3JqU7JfCWRewOSu7MgvjbMB3DXCqvSdwFwezBMVcvSoXxhJVEHkDFcoYWlgyhlQ5o38r
         W7dh5jAy/BFIZSbKzMS3f2XbzhhieoU7Sbo0/GawErPLC0zczffzxa2uZ6xuK34CkK87
         q9IOOIISFBIxa0TpZQj87QYne6pGuSSuOik0i4sGnCxBrhxZPyTxgS8hSrzwXCeQKQtq
         J04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6PvIqnhZ9tRiT0MCJFVIfarrGAfbfLpZZ7FO4CBjvM=;
        b=o8MnMcwgCp/hAEN6mkHstRB6NVgpd+/AgSo0hlZgdgpXnZLDddMdx+P/4vtzIjb5Da
         03q7K/83uLBhp6XNxEIHqXvLAvkh10xhSfcWYIPtazoE7wv+UykM2/eyGPuC8U812Kp8
         HlAZ2J25uDK6vo6uZ2PxE/3pL0YPua+QwEJtiSY/9nVz/VaTDpg+uxOOKH/6bC7MQJfW
         9piM+IY7W2pJCbsDKqMeFVOkY6I+nzNQeRbgoDVbSTdUDA+g6AsR0d5er42dJpJF3ljJ
         mhLajbvXG1+4UbzxDu7k5553nXPXhBwpoS05/yjF6cF9/HjpxFgnRYgJenBE9yGNQs0m
         eAjA==
X-Gm-Message-State: AOAM533gW46tn20qfjgUKBtJz1XSd2/RAX7YeyxKUwVs1dgkH/HZen1y
	+FMBO5u5xasl+r8CelsbO6+CPHu+HBm13YDh+p1upg==
X-Google-Smtp-Source: ABdhPJyHH6oKSes3GWdn+9ZzUOKOvYZ4dVsKC6Bay0ho2xyX1M0+lpYngsVCt5vOgqcwLv1UXTaFkIbR96XX9r2cWuk=
X-Received: by 2002:a05:6402:b1c:: with SMTP id bm28mr12443783edb.354.1613792053612;
 Fri, 19 Feb 2021 19:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com> <20201208172901.17384-5-joao.m.martins@oracle.com>
In-Reply-To: <20201208172901.17384-5-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Feb 2021 19:34:05 -0800
Message-ID: <CAPcyv4ixD6_KEpuXkpeH6JNLvoahch8rm8J55o1B97ghrtcbjQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/9] sparse-vmemmap: Reuse vmemmap areas for a given
 page size
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: O2D2WMOKTDC6RTQA3OXJFJOBOKRXP7EW
X-Message-ID-Hash: O2D2WMOKTDC6RTQA3OXJFJOBOKRXP7EW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O2D2WMOKTDC6RTQA3OXJFJOBOKRXP7EW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Introduce a new flag, MEMHP_REUSE_VMEMMAP, which signals that
> struct pages are onlined with a given alignment, and should reuse the
> tail pages vmemmap areas. On that circunstamce we reuse the PFN backing

s/On that circunstamce we reuse/Reuse/

Kills a "we" and switches to imperative tense. I noticed a couple
other "we"s in the previous patches, but this crossed my threshold to
make a comment.

> only the tail pages subsections, while letting the head page PFN remain
> different. This presumes that the backing page structs are compound
> pages, such as the case for compound pagemaps (i.e. ZONE_DEVICE with
> PGMAP_COMPOUND set)
>
> On 2M compound pagemaps, it lets us save 6 pages out of the 8 necessary

s/lets us save/saves/

> PFNs necessary

s/8 necessary PFNs necessary/8 PFNs necessary/

> to describe the subsection's 32K struct pages we are
> onlining.

s/we are onlining/being mapped/

...because ZONE_DEVICE pages are never "onlined".

> On a 1G compound pagemap it let us save 4096 pages.

s/lets us save/saves/

>
> Sections are 128M (or bigger/smaller),

Huh?

> and such when initializing a
> compound memory map where we are initializing compound struct pages, we
> need to preserve the tail page to be reused across the rest of the areas
> for pagesizes which bigger than a section.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
> I wonder, rather than separating vmem_context and mhp_params, that
> one would just pick the latter. Albeit  semantically the ctx aren't
> necessarily paramters, context passed from multiple sections onlining
> (i.e. multiple calls to populate_section_memmap). Also provided that
> this is internal state, which isn't passed to external modules, except
>  @align and @flags for page size and requesting whether to reuse tail
> page areas.
> ---
>  include/linux/memory_hotplug.h | 10 ++++
>  include/linux/mm.h             |  2 +-
>  mm/memory_hotplug.c            | 12 ++++-
>  mm/memremap.c                  |  3 ++
>  mm/sparse-vmemmap.c            | 93 ++++++++++++++++++++++++++++------
>  5 files changed, 103 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 73f8bcbb58a4..e15bb82805a3 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -70,6 +70,10 @@ typedef int __bitwise mhp_t;
>   */
>  #define MEMHP_MERGE_RESOURCE   ((__force mhp_t)BIT(0))
>
> +/*
> + */
> +#define MEMHP_REUSE_VMEMMAP    ((__force mhp_t)BIT(1))
> +
>  /*
>   * Extended parameters for memory hotplug:
>   * altmap: alternative allocator for memmap array (optional)
> @@ -79,10 +83,16 @@ typedef int __bitwise mhp_t;
>  struct mhp_params {
>         struct vmem_altmap *altmap;
>         pgprot_t pgprot;
> +       unsigned int align;
> +       mhp_t flags;
>  };
>
>  struct vmem_context {
>         struct vmem_altmap *altmap;
> +       mhp_t flags;
> +       unsigned int align;
> +       void *block;
> +       unsigned long block_page;
>  };
>
>  /*
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2eb44318bb2d..8b0155441835 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3006,7 +3006,7 @@ p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
>  pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
>  pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
>  pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
> -                           struct vmem_altmap *altmap);
> +                           struct vmem_altmap *altmap, void *block);
>  void *vmemmap_alloc_block(unsigned long size, int node);
>  struct vmem_altmap;
>  void *vmemmap_alloc_block_buf(unsigned long size, int node,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f8870c53fe5e..56121dfcc44b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -300,6 +300,14 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
>         return 0;
>  }
>
> +static void vmem_context_init(struct vmem_context *ctx, struct mhp_params *params)
> +{
> +       memset(ctx, 0, sizeof(*ctx));
> +       ctx->align = params->align;
> +       ctx->altmap = params->altmap;
> +       ctx->flags = params->flags;
> +}
> +
>  /*
>   * Reasonably generic function for adding memory.  It is
>   * expected that archs that support memory hotplug will
> @@ -313,7 +321,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>         unsigned long cur_nr_pages;
>         int err;
>         struct vmem_altmap *altmap = params->altmap;
> -       struct vmem_context ctx = { .altmap = params->altmap };
> +       struct vmem_context ctx;
>
>         if (WARN_ON_ONCE(!params->pgprot.pgprot))
>                 return -EINVAL;
> @@ -338,6 +346,8 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>         if (err)
>                 return err;
>
> +       vmem_context_init(&ctx, params);
> +
>         for (; pfn < end_pfn; pfn += cur_nr_pages) {
>                 /* Select all remaining pages up to the next section boundary */
>                 cur_nr_pages = min(end_pfn - pfn,
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 287a24b7a65a..ecfa74848ac6 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -253,6 +253,9 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>                         goto err_kasan;
>                 }
>
> +               if (pgmap->flags & PGMAP_COMPOUND)
> +                       params->align = pgmap->align;
> +
>                 error = arch_add_memory(nid, range->start, range_len(range),
>                                         params);
>         }
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index bcda68ba1381..364c071350e8 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -141,16 +141,20 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
>  }
>
>  pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
> -                                      struct vmem_altmap *altmap)
> +                                      struct vmem_altmap *altmap, void *block)
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
> +               } else {
> +                       get_page(virt_to_page(block));
> +               }
>                 entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
>                 set_pte_at(&init_mm, addr, pte, entry);
>         }
> @@ -216,8 +220,10 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
>         return pgd;
>  }
>
> -int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
> -                                        int node, struct vmem_altmap *altmap)
> +static void *__meminit __vmemmap_populate_basepages(unsigned long start,
> +                                          unsigned long end, int node,
> +                                          struct vmem_altmap *altmap,
> +                                          void *block)
>  {
>         unsigned long addr = start;
>         pgd_t *pgd;
> @@ -229,38 +235,95 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>         for (; addr < end; addr += PAGE_SIZE) {
>                 pgd = vmemmap_pgd_populate(addr, node);
>                 if (!pgd)
> -                       return -ENOMEM;
> +                       return NULL;
>                 p4d = vmemmap_p4d_populate(pgd, addr, node);
>                 if (!p4d)
> -                       return -ENOMEM;
> +                       return NULL;
>                 pud = vmemmap_pud_populate(p4d, addr, node);
>                 if (!pud)
> -                       return -ENOMEM;
> +                       return NULL;
>                 pmd = vmemmap_pmd_populate(pud, addr, node);
>                 if (!pmd)
> -                       return -ENOMEM;
> -               pte = vmemmap_pte_populate(pmd, addr, node, altmap);
> +                       return NULL;
> +               pte = vmemmap_pte_populate(pmd, addr, node, altmap, block);
>                 if (!pte)
> -                       return -ENOMEM;
> +                       return NULL;
>                 vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
>         }
>
> +       return __va(__pfn_to_phys(pte_pfn(*pte)));
> +}
> +
> +int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
> +                                        int node, struct vmem_altmap *altmap)
> +{
> +       if (!__vmemmap_populate_basepages(start, end, node, altmap, NULL))
> +               return -ENOMEM;
>         return 0;
>  }
>
> +static struct page * __meminit vmemmap_populate_reuse(unsigned long start,
> +                                       unsigned long end, int node,
> +                                       struct vmem_context *ctx)
> +{
> +       unsigned long size, addr = start;
> +       unsigned long psize = PHYS_PFN(ctx->align) * sizeof(struct page);
> +
> +       size = min(psize, end - start);
> +
> +       for (; addr < end; addr += size) {
> +               unsigned long head = addr + PAGE_SIZE;
> +               unsigned long tail = addr;
> +               unsigned long last = addr + size;
> +               void *area;
> +
> +               if (ctx->block_page &&
> +                   IS_ALIGNED((addr - ctx->block_page), psize))
> +                       ctx->block = NULL;
> +
> +               area  = ctx->block;
> +               if (!area) {
> +                       if (!__vmemmap_populate_basepages(addr, head, node,
> +                                                         ctx->altmap, NULL))
> +                               return NULL;
> +
> +                       tail = head + PAGE_SIZE;
> +                       area = __vmemmap_populate_basepages(head, tail, node,
> +                                                           ctx->altmap, NULL);
> +                       if (!area)
> +                               return NULL;
> +
> +                       ctx->block = area;
> +                       ctx->block_page = addr;
> +               }
> +
> +               if (!__vmemmap_populate_basepages(tail, last, node,
> +                                                 ctx->altmap, area))
> +                       return NULL;
> +       }

I think that compound page accounting and combined altmap accounting
makes this difficult to read, and I think the compound page case
deserves it's own first class loop rather than reusing
vmemmap_populate_basepages(). With the suggestion to drop altmap
support I'd expect a vmmemap_populate_compound that takes a compound
page size and goes the right think with respect to mapping all the
tail pages to the same pfn.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
