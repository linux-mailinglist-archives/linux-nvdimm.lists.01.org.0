Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A221C4952C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Jun 2019 00:33:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 175A12129EB86;
	Mon, 17 Jun 2019 15:32:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 17F8321290DE3
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 15:32:57 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id p4so1674165oti.0
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 15:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7qbPiWISZ/3YLAH4qk20thx5mPsENn7iQ0jZWGyMcis=;
 b=a91I+xSDVHvK1ZEOenRvvjE4vhGbnMM5IGQHmISQyRGCfz3lejo/r5ImOKIR368oej
 og0AcK5XFYS27XW+i5wQU/6RiEwpPUjImiPaOtWcOb4m8k9WnyQ3oOtutHO8Ue2cfUUe
 J0zRHWGOGVEFk7FiSUmXM7W2dI9bYseIgHTZXjQ04eE2lFmfvM0lLFnS4bIcUVi26/I4
 wF/BDJYOiaJYlZLvZSKIR4rt0ihW1MNP5fI5G8+xBCuY16R60CgJsByQAXLL4+0yBgrd
 suSnDakVYOMj+yqj5I159f1jj8m1ODIYx74Dh4Jo8kqLO6mwqXJntHs16+YD0/dMeu7E
 Yw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7qbPiWISZ/3YLAH4qk20thx5mPsENn7iQ0jZWGyMcis=;
 b=rDYE5HRAPqtzkAZoy2OEDVt1m/xzGXtksmYpR62opqQtiv2GZNX5J8+oA9VBPOatG8
 DLq2652KLg6PZoYq6yxusDu7xe3IAo+VlNsJUw5NlDkr15FrVl17VkO9X4d1NZ7aM0rI
 1JL4DoM8udcd0xOdSh1TaqWGZLhQBaOHoNHKaAw2ju6bTvQrbfXU80HBL/B58yQqP53G
 uBL9joWsHGMjz2Pnwskj3TlHxj0/NGDX4v8jEUQVkEg/VHpu+Ufky5pO+nsVS6jRpByR
 LETmZ8P41DXd5Sb226w52Q6DIMp800J54q0/l3ECxKcvtUwTqu1JRR9/i2PnUbwNIweh
 7d/Q==
X-Gm-Message-State: APjAAAV4cmub24AOP3FtXkE2VGnD1Xif2SxNtgu/GAnyAk4Zzvsk28fQ
 NsC9qQH3O07Q7mrVOX3oGkan6V/l1GjMjWOWWRALcA==
X-Google-Smtp-Source: APXvYqyZduYLHmzANdLJ0kTwAX72WJK5Ko0NIP/u/YQenpWDUe/hI/lIxpeqTuIX+3U32POBJeb5hXTJ8kaoay7kw2o=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr18184303otk.363.1560810776909; 
 Mon, 17 Jun 2019 15:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977187919.2443951.8925592545929008845.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190617222156.v6eaujbdrmkz35wr@master>
In-Reply-To: <20190617222156.v6eaujbdrmkz35wr@master>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 17 Jun 2019 15:32:45 -0700
Message-ID: <CAPcyv4hdsvNL0QfA2ACHAaGZE+21RmAnfKYfrZsKGKUxu3eKRQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/12] mm/sparsemem: Add helpers track active portions
 of a section at boot
To: Wei Yang <richard.weiyang@gmail.com>
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
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 17, 2019 at 3:22 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> On Wed, Jun 05, 2019 at 02:57:59PM -0700, Dan Williams wrote:
> >Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
> >sub-section active bitmask, each bit representing a PMD_SIZE span of the
> >architecture's memory hotplug section size.
> >
> >The implications of a partially populated section is that pfn_valid()
> >needs to go beyond a valid_section() check and read the sub-section
> >active ranges from the bitmask. The expectation is that the bitmask
> >(subsection_map) fits in the same cacheline as the valid_section() data,
> >so the incremental performance overhead to pfn_valid() should be
> >negligible.
> >
> >Cc: Michal Hocko <mhocko@suse.com>
> >Cc: Vlastimil Babka <vbabka@suse.cz>
> >Cc: Logan Gunthorpe <logang@deltatee.com>
> >Cc: Oscar Salvador <osalvador@suse.de>
> >Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> >Tested-by: Jane Chu <jane.chu@oracle.com>
> >Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >---
> > include/linux/mmzone.h |   29 ++++++++++++++++++++++++++++-
> > mm/page_alloc.c        |    4 +++-
> > mm/sparse.c            |   35 +++++++++++++++++++++++++++++++++++
> > 3 files changed, 66 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >index ac163f2f274f..6dd52d544857 100644
> >--- a/include/linux/mmzone.h
> >+++ b/include/linux/mmzone.h
> >@@ -1199,6 +1199,8 @@ struct mem_section_usage {
> >       unsigned long pageblock_flags[0];
> > };
> >
> >+void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
> >+
> > struct page;
> > struct page_ext;
> > struct mem_section {
> >@@ -1336,12 +1338,36 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
> >
> > extern int __highest_present_section_nr;
> >
> >+static inline int subsection_map_index(unsigned long pfn)
> >+{
> >+      return (pfn & ~(PAGE_SECTION_MASK)) / PAGES_PER_SUBSECTION;
> >+}
> >+
> >+#ifdef CONFIG_SPARSEMEM_VMEMMAP
> >+static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
> >+{
> >+      int idx = subsection_map_index(pfn);
> >+
> >+      return test_bit(idx, ms->usage->subsection_map);
> >+}
> >+#else
> >+static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
> >+{
> >+      return 1;
> >+}
> >+#endif
> >+
> > #ifndef CONFIG_HAVE_ARCH_PFN_VALID
> > static inline int pfn_valid(unsigned long pfn)
> > {
> >+      struct mem_section *ms;
> >+
> >       if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> >               return 0;
> >-      return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
> >+      ms = __nr_to_section(pfn_to_section_nr(pfn));
> >+      if (!valid_section(ms))
> >+              return 0;
> >+      return pfn_section_valid(ms, pfn);
> > }
> > #endif
> >
> >@@ -1373,6 +1399,7 @@ void sparse_init(void);
> > #define sparse_init() do {} while (0)
> > #define sparse_index_init(_sec, _nid)  do {} while (0)
> > #define pfn_present pfn_valid
> >+#define subsection_map_init(_pfn, _nr_pages) do {} while (0)
> > #endif /* CONFIG_SPARSEMEM */
> >
> > /*
> >diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >index c6d8224d792e..bd773efe5b82 100644
> >--- a/mm/page_alloc.c
> >+++ b/mm/page_alloc.c
> >@@ -7292,10 +7292,12 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
> >
> >       /* Print out the early node map */
> >       pr_info("Early memory node ranges\n");
> >-      for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid)
> >+      for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
> >               pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
> >                       (u64)start_pfn << PAGE_SHIFT,
> >                       ((u64)end_pfn << PAGE_SHIFT) - 1);
> >+              subsection_map_init(start_pfn, end_pfn - start_pfn);
> >+      }
>
> Just curious about why we set subsection here?
>
> Function free_area_init_nodes() mostly handles pgdat, if I am correct. Setup
> subsection here looks like touching some lower level system data structure.

Correct, I'm not sure how it ended up there, but it was the source of
a bug that was fixed with this change:

https://lore.kernel.org/lkml/CAPcyv4hjvBPDYKpp2Gns3-cc2AQ0AVS1nLk-K3fwXeRUvvzQLg@mail.gmail.com/
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
