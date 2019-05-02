Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0383611FCE
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 18:12:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 46F4D21243BCE;
	Thu,  2 May 2019 09:12:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 830B621243BC6
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 09:12:27 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a8so2637357edx.3
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PmuDEks26u7TosMg6YO9rFojJhi017p7aPym+WIjY/s=;
 b=ZRcrCjA5yDrtzuhuaxGA218aPuy8sioowVXNbMz96fmtX1Q3YhAiRGlzgamPi0mAvB
 nixiSO3SdAXaNwXkkyRiwjWAOPYOnlW3ZaGc3IMwRN6X6T0kJBBIeKpYX6/gW3tvhj2v
 tvfJ/mI0Ws/aUUfRVyG59bggwQfeK8Xo8ncypTOvY/rJGjB4xOUAk10lU9CKRYTM6Nss
 qYhP5n+dg2IjGEpOo0V8UzIRXLskytJ1Quc1RDZAozElxiQIMW+tW/Jmc5ffpKQiTnp1
 eTJ5SHTsoZHRFQxKrcXR5/EFeOHgq/xPq8bvxS678Opw86soN2msVgRGObpkLlonfB/7
 eVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PmuDEks26u7TosMg6YO9rFojJhi017p7aPym+WIjY/s=;
 b=An/1UGWq2XpzKnqttvotnIcAnwr+ZEL4bKtJ8qJZRd1h+2VULqJ0cz+ElFGJauZtyt
 Lh8K72yIT6CkBGemkGeYf/qxAiShvmOTcxcd0rrgKQShDoCqIQlKv09O7tduMsz/IhhA
 voUiaOrjvosOC9Vly5q7M+V/PkbwtdFCXJS/MDpRdb4fXwR/bwLuoaGMIe+ILCSiPcoR
 EupJHja4MCnWBKh2GNjagfiobOZ/wcFsSOWrxQRNFItPymhwe/O9b3XbPrdbFjvFMZci
 uCSYJpAMK+YS1Wadmei1an3z99AVLlNoFajdf+BLqZY24Dr0D4uREmVIJTIaEIy7mi3J
 CaQg==
X-Gm-Message-State: APjAAAUskfxRiwXQBZbaljznyQfPN3nRXjSrkvnDfcUX2wjzpn9T/f6U
 GpfM0tsKf4JErrc1jc4laNJWVhCv33sBpNGtSvbLGQ==
X-Google-Smtp-Source: APXvYqwyYTUtFEmJ3Pk1Kxl+N/9cXpVtziHTpF16SYo8jOemVRi2MW8HQ4q0f3So4cyRee2cDlyFYKUmjwTvJxrP1fU=
X-Received: by 2002:a17:906:4988:: with SMTP id
 p8mr2289364eju.220.1556813545671; 
 Thu, 02 May 2019 09:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552635098.2015392.5460028594173939000.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552635098.2015392.5460028594173939000.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 May 2019 12:12:14 -0400
Message-ID: <CA+CK2bAfnCVYz956jPTNQ+AqHJs7uY1ZqWfL8fSUFWQOdKxHcg@mail.gmail.com>
Subject: Re: [PATCH v6 03/12] mm/sparsemem: Add helpers track active portions
 of a section at boot
To: Dan Williams <dan.j.williams@intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 David Hildenbrand <david@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Apr 17, 2019 at 2:53 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
> section active bitmask, each bit representing 2MB (SECTION_SIZE (128M) /
> map_active bitmask length (64)). If it turns out that 2MB is too large
> of an active tracking granularity it is trivial to increase the size of
> the map_active bitmap.

Please mention that 2M on Intel, and 16M on Arm64.

>
> The implications of a partially populated section is that pfn_valid()
> needs to go beyond a valid_section() check and read the sub-section
> active ranges from the bitmask.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mmzone.h |   29 ++++++++++++++++++++++++++++-
>  mm/page_alloc.c        |    4 +++-
>  mm/sparse.c            |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 6726fc175b51..cffde898e345 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1175,6 +1175,8 @@ struct mem_section_usage {
>         unsigned long pageblock_flags[0];
>  };
>
> +void section_active_init(unsigned long pfn, unsigned long nr_pages);
> +
>  struct page;
>  struct page_ext;
>  struct mem_section {
> @@ -1312,12 +1314,36 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
>
>  extern int __highest_present_section_nr;
>
> +static inline int section_active_index(phys_addr_t phys)
> +{
> +       return (phys & ~(PA_SECTION_MASK)) / SECTION_ACTIVE_SIZE;

How about also defining SECTION_ACTIVE_SHIFT like this:

/* BITS_PER_LONG = 2^6 */
#define BITS_PER_LONG_SHIFT 6
#define SECTION_ACTIVE_SHIFT (SECTION_SIZE_BITS - BITS_PER_LONG_SHIFT)
#define SECTION_ACTIVE_SIZE (1 << SECTION_ACTIVE_SHIFT)

The return above would become:
return (phys & ~(PA_SECTION_MASK)) >> SECTION_ACTIVE_SHIFT;

> +}
> +
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
> +{
> +       int idx = section_active_index(PFN_PHYS(pfn));
> +
> +       return !!(ms->usage->map_active & (1UL << idx));
> +}
> +#else
> +static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
> +{
> +       return 1;
> +}
> +#endif
> +
>  #ifndef CONFIG_HAVE_ARCH_PFN_VALID
>  static inline int pfn_valid(unsigned long pfn)
>  {
> +       struct mem_section *ms;
> +
>         if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>                 return 0;
> -       return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
> +       ms = __nr_to_section(pfn_to_section_nr(pfn));
> +       if (!valid_section(ms))
> +               return 0;
> +       return pfn_section_valid(ms, pfn);
>  }
>  #endif
>
> @@ -1349,6 +1375,7 @@ void sparse_init(void);
>  #define sparse_init()  do {} while (0)
>  #define sparse_index_init(_sec, _nid)  do {} while (0)
>  #define pfn_present pfn_valid
> +#define section_active_init(_pfn, _nr_pages) do {} while (0)
>  #endif /* CONFIG_SPARSEMEM */
>
>  /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f671401a7c0b..c9ad28a78018 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7273,10 +7273,12 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
>
>         /* Print out the early node map */
>         pr_info("Early memory node ranges\n");
> -       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid)
> +       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
>                 pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
>                         (u64)start_pfn << PAGE_SHIFT,
>                         ((u64)end_pfn << PAGE_SHIFT) - 1);
> +               section_active_init(start_pfn, end_pfn - start_pfn);
> +       }
>
>         /* Initialise every node */
>         mminit_verify_pageflags_layout();
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f87de7ad32c8..5ef2f884c4e1 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -210,6 +210,54 @@ static inline unsigned long first_present_section_nr(void)
>         return next_present_section_nr(-1);
>  }
>
> +static unsigned long section_active_mask(unsigned long pfn,
> +               unsigned long nr_pages)
> +{
> +       int idx_start, idx_size;
> +       phys_addr_t start, size;
> +
> +       if (!nr_pages)
> +               return 0;
> +
> +       start = PFN_PHYS(pfn);
> +       size = PFN_PHYS(min(nr_pages, PAGES_PER_SECTION
> +                               - (pfn & ~PAGE_SECTION_MASK)));
> +       size = ALIGN(size, SECTION_ACTIVE_SIZE);
> +
> +       idx_start = section_active_index(start);
> +       idx_size = section_active_index(size);
> +
> +       if (idx_size == 0)
> +               return -1;
> +       return ((1UL << idx_size) - 1) << idx_start;
> +}
> +
> +void section_active_init(unsigned long pfn, unsigned long nr_pages)
> +{
> +       int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> +       int i, start_sec = pfn_to_section_nr(pfn);
> +
> +       if (!nr_pages)
> +               return;
> +
> +       for (i = start_sec; i <= end_sec; i++) {
> +               struct mem_section *ms;
> +               unsigned long mask;
> +               unsigned long pfns;
> +
> +               pfns = min(nr_pages, PAGES_PER_SECTION
> +                               - (pfn & ~PAGE_SECTION_MASK));
> +               mask = section_active_mask(pfn, pfns);
> +
> +               ms = __nr_to_section(i);
> +               pr_debug("%s: sec: %d mask: %#018lx\n", __func__, i, mask);
> +               ms->usage->map_active = mask;
> +
> +               pfn += pfns;
> +               nr_pages -= pfns;
> +       }
> +}

For some reasons the above code is confusing to me. It seems all the
code supposed to do is set all map_active to -1, and trim the first
and last sections (can be the same section of course). So, I would
replace the above two functions with one function like this:

void section_active_init(unsigned long pfn, unsigned long nr_pages)
{
        int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
        int i, idx, start_sec = pfn_to_section_nr(pfn);
        struct mem_section *ms;

        if (!nr_pages)
                return;

        for (i = start_sec; i <= end_sec; i++) {
                ms = __nr_to_section(i);
                ms->usage->map_active = ~0ul;
        }

        /* Might need to trim active pfns from the beginning and end */
        idx = section_active_index(PFN_PHYS(pfn));
        ms = __nr_to_section(start_sec);
        ms->usage->map_active &= (~0ul << idx);

        idx = section_active_index(PFN_PHYS(pfn + nr_pages -1));
        ms = __nr_to_section(end_sec);
        ms->usage->map_active &= (~0ul >> (BITS_PER_LONG - idx - 1));
}
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
