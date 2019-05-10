Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CBA1A36B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 21:39:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9371C21268F8C;
	Fri, 10 May 2019 12:38:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A0B88212657BB
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 12:38:55 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l203so5385522oia.3
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3zZWqRpm0G05NjcSiIIAbzIcEiDmVjoOHWcOK0h9db0=;
 b=Zt8jGCiU6tsVp+EvLvEH/lbyUyD0S8Rz6P6AcA7tfrddxC67ogCCxcpPcWKqgoNncU
 u26bqCA1xFFK3nyrZN3NSXUnii3hhRz1OnCgLU3OXi6fDoMD5goKG2VunEj/pVe4FDNR
 QWnGG1KfiHfJLEKn0I9/4BJxx+uOFgBoX9aBBimHHlyeYvWdcOJyEhcMttB9M8QYkZLH
 MS3cw9AXYX4vA5p5vI7ijwbkyNNbhf0SFF8kFb3hQfgh5pyEgogzeKxd+k4VgtyD3l1c
 7WAqnGYDb0k77o8owtjnxY+4cVmWwK1z8YK89qYEpPpQWF45MSURi+S4GYD5g23Yj2rm
 ZtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3zZWqRpm0G05NjcSiIIAbzIcEiDmVjoOHWcOK0h9db0=;
 b=dYxskCVSp0PjlyFGsQ5UsomLy3nF5XfY7xa9ja1MzPQAhW3S+CQCd8GfyTi/5z8T3v
 b1VSxglP/Y65dCi4MB7lf74vgxeGQ5J2hBOMJx3XfI3ceobWqQZCMLN8bUTTc4jmkiDn
 gDg7Ol6Ks9tO0yWCxuI11bczpXO/HnsdWcktdMpxLo8gAaD5fwNdsm8kPcJ1yBBzRKA+
 jTpaAgNQ/vwi7u7bN7nIiMUa8qaW1WOwF5yneehszTH2noWJEHUUhbG/1uLkErxHdbge
 KKWmxZAjkrJU94dlevsbwefDQS3ztQ3sXGzZ6DFIID9Fvnn/F1G9VoR3wztqqP708ofF
 z5IQ==
X-Gm-Message-State: APjAAAVyXbJGEZeCms6Wnzotqt1SHVp5dn0KcfdUcrrwxu/MhaLAxZn2
 sJ9jZ4NGTM0btcgj5BGD9H8Is/HVI42ymBW0QyGdMQ==
X-Google-Smtp-Source: APXvYqyXAc2U9OVVTkJlhijyyyFcw3I1yzqRpW/J5S9roDJzRnWHqxvYbqh6OC5OXma3KlWvNDW/uVv/L6RXEOBtXtU=
X-Received: by 2002:aca:de57:: with SMTP id v84mr6606243oig.149.1557517135140; 
 Fri, 10 May 2019 12:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155718597192.130019.7128788290111464258.stgit@dwillia2-desk3.amr.corp.intel.com>
 <dd7b53bd986d79a94ac0b08e32336e44@suse.de>
In-Reply-To: <dd7b53bd986d79a94ac0b08e32336e44@suse.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 May 2019 12:38:43 -0700
Message-ID: <CAPcyv4i1zQb-D-8iB3hr8ipMHH2yV8ssxh+Zeh2aeMw0ZJASfg@mail.gmail.com>
Subject: Re: [PATCH v8 01/12] mm/sparsemem: Introduce struct mem_section_usage
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
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 owner-linux-mm@kvack.org, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 10, 2019 at 6:30 AM <osalvador@suse.de> wrote:
>
> On 2019-05-07 01:39, Dan Williams wrote:
> > Towards enabling memory hotplug to track partial population of a
> > section, introduce 'struct mem_section_usage'.
> >
> > A pointer to a 'struct mem_section_usage' instance replaces the
> > existing
> > pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
> > 'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
> > house a new 'subsection_map' bitmap.  The new bitmap enables the memory
> > hot{plug,remove} implementation to act on incremental sub-divisions of
> > a
> > section.
> >
> > The default SUBSECTION_SHIFT is chosen to keep the 'subsection_map' no
> > larger than a single 'unsigned long' on the major architectures.
> > Alternatively an architecture can define ARCH_SUBSECTION_SHIFT to
> > override the default PMD_SHIFT. Note that PowerPC needs to use
> > ARCH_SUBSECTION_SHIFT to workaround PMD_SHIFT being a non-constant
> > expression on PowerPC.
> >
> > The primary motivation for this functionality is to support platforms
> > that mix "System RAM" and "Persistent Memory" within a single section,
> > or multiple PMEM ranges with different mapping lifetimes within a
> > single
> > section. The section restriction for hotplug has caused an ongoing saga
> > of hacks and bugs for devm_memremap_pages() users.
> >
> > Beyond the fixups to teach existing paths how to retrieve the 'usemap'
> > from a section, and updates to usemap allocation path, there are no
> > expected behavior changes.
> >
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/powerpc/include/asm/sparsemem.h |    3 +
> >  include/linux/mmzone.h               |   48 +++++++++++++++++++-
> >  mm/memory_hotplug.c                  |   18 ++++----
> >  mm/page_alloc.c                      |    2 -
> >  mm/sparse.c                          |   81
> > +++++++++++++++++-----------------
> >  5 files changed, 99 insertions(+), 53 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/sparsemem.h
> > b/arch/powerpc/include/asm/sparsemem.h
> > index 3192d454a733..1aa3c9303bf8 100644
> > --- a/arch/powerpc/include/asm/sparsemem.h
> > +++ b/arch/powerpc/include/asm/sparsemem.h
> > @@ -10,6 +10,9 @@
> >   */
> >  #define SECTION_SIZE_BITS       24
> >
> > +/* Reflect the largest possible PMD-size as the subsection-size
> > constant */
> > +#define ARCH_SUBSECTION_SHIFT 24
> > +
>
> I guess this is done because PMD_SHIFT is defined at runtime rather at
> compile time,
> right?

Correct, PowerPC has:

    #define PMD_SHIFT (PAGE_SHIFT + PTE_INDEX_SIZE)
    #define PTE_INDEX_SIZE  __pte_index_size

...where __pte_index_size is variable established at kernel init time.

> >  #endif /* CONFIG_SPARSEMEM */
> >
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 70394cabaf4e..ef8d878079f9 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1160,6 +1160,44 @@ static inline unsigned long
> > section_nr_to_pfn(unsigned long sec)
> >  #define SECTION_ALIGN_UP(pfn)        (((pfn) + PAGES_PER_SECTION - 1) &
> > PAGE_SECTION_MASK)
> >  #define SECTION_ALIGN_DOWN(pfn)      ((pfn) & PAGE_SECTION_MASK)
> >
> > +/*
> > + * SUBSECTION_SHIFT must be constant since it is used to declare
> > + * subsection_map and related bitmaps without triggering the
> > generation
> > + * of variable-length arrays. The most natural size for a subsection
> > is
> > + * a PMD-page. For architectures that do not have a constant PMD-size
> > + * ARCH_SUBSECTION_SHIFT can be set to a constant max size, or
> > otherwise
> > + * fallback to 2MB.
> > + */
> > +#if defined(ARCH_SUBSECTION_SHIFT)
> > +#define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
> > +#elif defined(PMD_SHIFT)
> > +#define SUBSECTION_SHIFT (PMD_SHIFT)
> > +#else
> > +/*
> > + * Memory hotplug enabled platforms avoid this default because they
> > + * either define ARCH_SUBSECTION_SHIFT, or PMD_SHIFT is a constant,
> > but
> > + * this is kept as a backstop to allow compilation on
> > + * !ARCH_ENABLE_MEMORY_HOTPLUG archs.
> > + */
> > +#define SUBSECTION_SHIFT 21
> > +#endif
> > +
> > +#define PFN_SUBSECTION_SHIFT (SUBSECTION_SHIFT - PAGE_SHIFT)
> > +#define PAGES_PER_SUBSECTION (1UL << PFN_SUBSECTION_SHIFT)
> > +#define PAGE_SUBSECTION_MASK ((~(PAGES_PER_SUBSECTION-1)))
> > +
> > +#if SUBSECTION_SHIFT > SECTION_SIZE_BITS
> > +#error Subsection size exceeds section size
> > +#else
> > +#define SUBSECTIONS_PER_SECTION (1UL << (SECTION_SIZE_BITS -
> > SUBSECTION_SHIFT))
> > +#endif
>
> On powerpc, SUBSECTIONS_PER_SECTION will equal 1 (so one big section),
> is that to be expected?

Yes, it turns out that PowerPC has no real need for subsection support
since they were already using small 16MB sections from day one.

> Will subsection_map_init handle this right?

Yes, should work as subsection_map_index() will always return 0. Which
means that 'end' will always be 0:

    pfns = min(nr_pages, PAGES_PER_SECTION
        - (pfn & ~PAGE_SECTION_MASK));
    end = subsection_map_index(pfn + pfns - 1);

...and then the bitmap manipulation:

    bitmap_set(ms->usage->subsection_map, idx, end - idx + 1);

...will only ever set bit0.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
