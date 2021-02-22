Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9376F322240
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 23:40:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A9B79100EB32D;
	Mon, 22 Feb 2021 14:40:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB1A1100ED480
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 14:40:46 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id do6so31817678ejc.3
        for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 14:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFd7CaA0KapM5IfLJ/4SuO3kY+et82d+j9QUV8pBE7M=;
        b=cytQC7qIOvT4VxYyAySB7SJGnGqVd+VYzfZC9ZOEtiwnFx/10HEnK1kR5NAUQ4wYNM
         jhlK5Xgqc2Fq+qHKO2D1Ge9atll1LB18yk0VX9xDHrz4T0gFW81cy6I8qvWpElqn7MUV
         zSBQzXXUB1UIKlWm/JkC8TJ1cXMBJodgaxBuuu8RZu9yuhNglya4hwoQ7pgbLyUIAZe2
         O6eT7aSnI9lJmpjfH3r3BYCvrOsas4O1T6CVrPNqCeVuraliNEauLOvDi3ReiByUwigR
         SxuzBAPgHX/ZB5Azu79brQaZPP/vhbS+F32hPU88pCPdhn2KOrV38T90T1XDN3VTkbDl
         crBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFd7CaA0KapM5IfLJ/4SuO3kY+et82d+j9QUV8pBE7M=;
        b=Kwlfc1x0D+wPfKH3wHbfQzjhxosl5UtoshwAuTES9OjB/F3KOgFXC0jcphlAKXOKgF
         XsqlrkxSosnwpdgC0zmVapibvU8+HfKDr0jOqVkIJwOHRLE4HOJrLpyM1WVh89KHa+1x
         FFnyOV1yaCPjE6SJy16cKWEiuL4ue9Nu50lltWusqUPvDQVwV1X/sjt5GaY5Rpj2fnj+
         4XAIfyMFP0tV+/7H3XKqCxyCE/SnzVsaCnkWmwhnT/Gb9Z2JCTMaJCM4ZEe/Wh6KL889
         EPKOhj+HPt0Mfw5dMNw0NLlcBTsHsSRxrU3A2h09CuUS1r+8o8fp2+ACYCnfRJpnNMTd
         Dtzg==
X-Gm-Message-State: AOAM530N7ZEvXs3fRhwPrmfQUaHXKXcYuMxwdpYhDO5k2EJ27mDFkfqT
	/iAZVVPBSWP3np364WKRTB8z7Npzj0MO32RsbmonHQ==
X-Google-Smtp-Source: ABdhPJzo8EpgOmCHsJbINK822OVIGyq7hHdBwCsscuL5reVuk6qLLLiaP/zQzxPwDyXeb+GECf3J1bstpjgXTau4ihI=
X-Received: by 2002:a17:906:5655:: with SMTP id v21mr22247227ejr.264.1614033645156;
 Mon, 22 Feb 2021 14:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-5-joao.m.martins@oracle.com> <CAPcyv4ixD6_KEpuXkpeH6JNLvoahch8rm8J55o1B97ghrtcbjQ@mail.gmail.com>
 <621ff98b-cb75-e4d7-8f09-882cb2b984d2@oracle.com>
In-Reply-To: <621ff98b-cb75-e4d7-8f09-882cb2b984d2@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Feb 2021 14:40:40 -0800
Message-ID: <CAPcyv4i1YxFRFVz9itTkH7aLHR9GXdidTLDQHaqCG-n4EEzusQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/9] sparse-vmemmap: Reuse vmemmap areas for a given
 page size
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: OXRNQTKWR7GHP7S6ECBIIYMDJP7B5XVD
X-Message-ID-Hash: OXRNQTKWR7GHP7S6ECBIIYMDJP7B5XVD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OXRNQTKWR7GHP7S6ECBIIYMDJP7B5XVD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 22, 2021 at 3:42 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
>
>
> On 2/20/21 3:34 AM, Dan Williams wrote:
> > On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> >>
> >> Introduce a new flag, MEMHP_REUSE_VMEMMAP, which signals that
> >> struct pages are onlined with a given alignment, and should reuse the
> >> tail pages vmemmap areas. On that circunstamce we reuse the PFN backing
> >
> > s/On that circunstamce we reuse/Reuse/
> >
> > Kills a "we" and switches to imperative tense. I noticed a couple
> > other "we"s in the previous patches, but this crossed my threshold to
> > make a comment.
> >
> /me nods. Will fix.
>
> >> only the tail pages subsections, while letting the head page PFN remain
> >> different. This presumes that the backing page structs are compound
> >> pages, such as the case for compound pagemaps (i.e. ZONE_DEVICE with
> >> PGMAP_COMPOUND set)
> >>
> >> On 2M compound pagemaps, it lets us save 6 pages out of the 8 necessary
> >
> > s/lets us save/saves/
> >
> Will fix.
>
> >> PFNs necessary
> >
> > s/8 necessary PFNs necessary/8 PFNs necessary/
>
> Will fix.
>
> >
> >> to describe the subsection's 32K struct pages we are
> >> onlining.
> >
> > s/we are onlining/being mapped/
> >
> > ...because ZONE_DEVICE pages are never "onlined".
> >
> >> On a 1G compound pagemap it let us save 4096 pages.
> >
> > s/lets us save/saves/
> >
>
> Will fix both.
>
> >>
> >> Sections are 128M (or bigger/smaller),
> >
> > Huh?
> >
>
> Section size is arch-dependent if we are being hollistic.
> On x86 it's 64M, 128M or 512M right?
>
>  #ifdef CONFIG_X86_32
>  # ifdef CONFIG_X86_PAE
>  #  define SECTION_SIZE_BITS     29
>  #  define MAX_PHYSMEM_BITS      36
>  # else
>  #  define SECTION_SIZE_BITS     26
>  #  define MAX_PHYSMEM_BITS      32
>  # endif
>  #else /* CONFIG_X86_32 */
>  # define SECTION_SIZE_BITS      27 /* matt - 128 is convenient right now */
>  # define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)
>  #endif
>
> Also, me pointing about section sizes, is because a 1GB+ page vmemmap population will
> cross sections in how sparsemem populates the vmemmap. And on that case we gotta reuse the
> the PTE/PMD pages across multiple invocations of vmemmap_populate_basepages(). Either
> that, or looking at the previous page PTE, but that might be ineficient.

Ok, makes sense I think saying this description of needing to handle
section crossing is clearer than mentioning one of the section sizes.

>
> >> @@ -229,38 +235,95 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
> >>         for (; addr < end; addr += PAGE_SIZE) {
> >>                 pgd = vmemmap_pgd_populate(addr, node);
> >>                 if (!pgd)
> >> -                       return -ENOMEM;
> >> +                       return NULL;
> >>                 p4d = vmemmap_p4d_populate(pgd, addr, node);
> >>                 if (!p4d)
> >> -                       return -ENOMEM;
> >> +                       return NULL;
> >>                 pud = vmemmap_pud_populate(p4d, addr, node);
> >>                 if (!pud)
> >> -                       return -ENOMEM;
> >> +                       return NULL;
> >>                 pmd = vmemmap_pmd_populate(pud, addr, node);
> >>                 if (!pmd)
> >> -                       return -ENOMEM;
> >> -               pte = vmemmap_pte_populate(pmd, addr, node, altmap);
> >> +                       return NULL;
> >> +               pte = vmemmap_pte_populate(pmd, addr, node, altmap, block);
> >>                 if (!pte)
> >> -                       return -ENOMEM;
> >> +                       return NULL;
> >>                 vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
> >>         }
> >>
> >> +       return __va(__pfn_to_phys(pte_pfn(*pte)));
> >> +}
> >> +
> >> +int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
> >> +                                        int node, struct vmem_altmap *altmap)
> >> +{
> >> +       if (!__vmemmap_populate_basepages(start, end, node, altmap, NULL))
> >> +               return -ENOMEM;
> >>         return 0;
> >>  }
> >>
> >> +static struct page * __meminit vmemmap_populate_reuse(unsigned long start,
> >> +                                       unsigned long end, int node,
> >> +                                       struct vmem_context *ctx)
> >> +{
> >> +       unsigned long size, addr = start;
> >> +       unsigned long psize = PHYS_PFN(ctx->align) * sizeof(struct page);
> >> +
> >> +       size = min(psize, end - start);
> >> +
> >> +       for (; addr < end; addr += size) {
> >> +               unsigned long head = addr + PAGE_SIZE;
> >> +               unsigned long tail = addr;
> >> +               unsigned long last = addr + size;
> >> +               void *area;
> >> +
> >> +               if (ctx->block_page &&
> >> +                   IS_ALIGNED((addr - ctx->block_page), psize))
> >> +                       ctx->block = NULL;
> >> +
> >> +               area  = ctx->block;
> >> +               if (!area) {
> >> +                       if (!__vmemmap_populate_basepages(addr, head, node,
> >> +                                                         ctx->altmap, NULL))
> >> +                               return NULL;
> >> +
> >> +                       tail = head + PAGE_SIZE;
> >> +                       area = __vmemmap_populate_basepages(head, tail, node,
> >> +                                                           ctx->altmap, NULL);
> >> +                       if (!area)
> >> +                               return NULL;
> >> +
> >> +                       ctx->block = area;
> >> +                       ctx->block_page = addr;
> >> +               }
> >> +
> >> +               if (!__vmemmap_populate_basepages(tail, last, node,
> >> +                                                 ctx->altmap, area))
> >> +                       return NULL;
> >> +       }
> >
> > I think that compound page accounting and combined altmap accounting
> > makes this difficult to read, and I think the compound page case
> > deserves it's own first class loop rather than reusing
> > vmemmap_populate_basepages(). With the suggestion to drop altmap
> > support I'd expect a vmmemap_populate_compound that takes a compound
> > page size and goes the right think with respect to mapping all the
> > tail pages to the same pfn.
> >
> I can move this to a separate loop as suggested.
>
> But to be able to map all tail pages in one call of vmemmap_populate_compound()
> this might requires changes in sparsemem generic code that I am not so sure
> they are warranted the added complexity. Otherwise I'll have to probably keep
> this logic of @ctx to be able to pass the page to be reused (i.e. @block and
> @block_page). That's actually the main reason that made me introduce
> a struct vmem_context.

Do you need to pass in a vmem_context, isn't that context local to
vmemmap_populate_compound_pages()?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
