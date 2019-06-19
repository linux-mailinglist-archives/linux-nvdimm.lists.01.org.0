Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C56384AFE7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Jun 2019 04:14:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A9E321962301;
	Tue, 18 Jun 2019 19:14:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=192.55.52.120;
 helo=mga04.intel.com; envelope-from=richardw.yang@linux.intel.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AA2EC21962301
 for <linux-nvdimm@lists.01.org>; Tue, 18 Jun 2019 19:14:16 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jun 2019 19:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,391,1557212400"; d="scan'208";a="168110531"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by FMSMGA003.fm.intel.com with ESMTP; 18 Jun 2019 19:14:13 -0700
Date: Wed, 19 Jun 2019 10:13:50 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 01/12] mm/sparsemem: Introduce struct mem_section_usage
Message-ID: <20190619021350.GA11514@richard>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977187407.2443951.16503493275720588454.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190616131123.fkjs4kyg32aryjq6@master>
 <CAPcyv4hw2W3=CkrUmWtvu3cAdo3GLRhG0=G_RO7xQBugNB2htA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4hw2W3=CkrUmWtvu3cAdo3GLRhG0=G_RO7xQBugNB2htA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, Linux MM <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jun 18, 2019 at 02:56:09PM -0700, Dan Williams wrote:
>On Sun, Jun 16, 2019 at 6:11 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>> On Wed, Jun 05, 2019 at 02:57:54PM -0700, Dan Williams wrote:
>> >Towards enabling memory hotplug to track partial population of a
>> >section, introduce 'struct mem_section_usage'.
>> >
>> >A pointer to a 'struct mem_section_usage' instance replaces the existing
>> >pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
>> >'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
>> >house a new 'subsection_map' bitmap.  The new bitmap enables the memory
>> >hot{plug,remove} implementation to act on incremental sub-divisions of a
>> >section.
>> >
>> >The default SUBSECTION_SHIFT is chosen to keep the 'subsection_map' no
>> >larger than a single 'unsigned long' on the major architectures.
>> >Alternatively an architecture can define ARCH_SUBSECTION_SHIFT to
>> >override the default PMD_SHIFT. Note that PowerPC needs to use
>> >ARCH_SUBSECTION_SHIFT to workaround PMD_SHIFT being a non-constant
>> >expression on PowerPC.
>> >
>> >The primary motivation for this functionality is to support platforms
>> >that mix "System RAM" and "Persistent Memory" within a single section,
>> >or multiple PMEM ranges with different mapping lifetimes within a single
>> >section. The section restriction for hotplug has caused an ongoing saga
>> >of hacks and bugs for devm_memremap_pages() users.
>> >
>> >Beyond the fixups to teach existing paths how to retrieve the 'usemap'
>> >from a section, and updates to usemap allocation path, there are no
>> >expected behavior changes.
>> >
>> >Cc: Michal Hocko <mhocko@suse.com>
>> >Cc: Vlastimil Babka <vbabka@suse.cz>
>> >Cc: Logan Gunthorpe <logang@deltatee.com>
>> >Cc: Oscar Salvador <osalvador@suse.de>
>> >Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> >Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> >Cc: Paul Mackerras <paulus@samba.org>
>> >Cc: Michael Ellerman <mpe@ellerman.id.au>
>> >Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> >---
>> > arch/powerpc/include/asm/sparsemem.h |    3 +
>> > include/linux/mmzone.h               |   48 +++++++++++++++++++-
>> > mm/memory_hotplug.c                  |   18 ++++----
>> > mm/page_alloc.c                      |    2 -
>> > mm/sparse.c                          |   81 +++++++++++++++++-----------------
>> > 5 files changed, 99 insertions(+), 53 deletions(-)
>> >
>> >diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
>> >index 3192d454a733..1aa3c9303bf8 100644
>> >--- a/arch/powerpc/include/asm/sparsemem.h
>> >+++ b/arch/powerpc/include/asm/sparsemem.h
>> >@@ -10,6 +10,9 @@
>> >  */
>> > #define SECTION_SIZE_BITS       24
>> >
>> >+/* Reflect the largest possible PMD-size as the subsection-size constant */
>> >+#define ARCH_SUBSECTION_SHIFT 24
>> >+
>> > #endif /* CONFIG_SPARSEMEM */
>> >
>> > #ifdef CONFIG_MEMORY_HOTPLUG
>> >diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> >index 427b79c39b3c..ac163f2f274f 100644
>> >--- a/include/linux/mmzone.h
>> >+++ b/include/linux/mmzone.h
>> >@@ -1161,6 +1161,44 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
>> > #define SECTION_ALIGN_UP(pfn) (((pfn) + PAGES_PER_SECTION - 1) & PAGE_SECTION_MASK)
>> > #define SECTION_ALIGN_DOWN(pfn)       ((pfn) & PAGE_SECTION_MASK)
>> >
>> >+/*
>> >+ * SUBSECTION_SHIFT must be constant since it is used to declare
>> >+ * subsection_map and related bitmaps without triggering the generation
>> >+ * of variable-length arrays. The most natural size for a subsection is
>> >+ * a PMD-page. For architectures that do not have a constant PMD-size
>> >+ * ARCH_SUBSECTION_SHIFT can be set to a constant max size, or otherwise
>> >+ * fallback to 2MB.
>> >+ */
>> >+#if defined(ARCH_SUBSECTION_SHIFT)
>> >+#define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
>> >+#elif defined(PMD_SHIFT)
>> >+#define SUBSECTION_SHIFT (PMD_SHIFT)
>> >+#else
>> >+/*
>> >+ * Memory hotplug enabled platforms avoid this default because they
>> >+ * either define ARCH_SUBSECTION_SHIFT, or PMD_SHIFT is a constant, but
>> >+ * this is kept as a backstop to allow compilation on
>> >+ * !ARCH_ENABLE_MEMORY_HOTPLUG archs.
>> >+ */
>> >+#define SUBSECTION_SHIFT 21
>> >+#endif
>> >+
>> >+#define PFN_SUBSECTION_SHIFT (SUBSECTION_SHIFT - PAGE_SHIFT)
>> >+#define PAGES_PER_SUBSECTION (1UL << PFN_SUBSECTION_SHIFT)
>> >+#define PAGE_SUBSECTION_MASK ((~(PAGES_PER_SUBSECTION-1)))
>>
>> One pair of brackets could be removed, IMHO.
>
>Sure.
>
>>
>> >+
>> >+#if SUBSECTION_SHIFT > SECTION_SIZE_BITS
>> >+#error Subsection size exceeds section size
>> >+#else
>> >+#define SUBSECTIONS_PER_SECTION (1UL << (SECTION_SIZE_BITS - SUBSECTION_SHIFT))
>> >+#endif
>> >+
>> >+struct mem_section_usage {
>> >+      DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
>> >+      /* See declaration of similar field in struct zone */
>> >+      unsigned long pageblock_flags[0];
>> >+};
>> >+
>> > struct page;
>> > struct page_ext;
>> > struct mem_section {
>> >@@ -1178,8 +1216,7 @@ struct mem_section {
>> >        */
>> >       unsigned long section_mem_map;
>> >
>> >-      /* See declaration of similar field in struct zone */
>> >-      unsigned long *pageblock_flags;
>> >+      struct mem_section_usage *usage;
>> > #ifdef CONFIG_PAGE_EXTENSION
>> >       /*
>> >        * If SPARSEMEM, pgdat doesn't have page_ext pointer. We use
>> >@@ -1210,6 +1247,11 @@ extern struct mem_section **mem_section;
>> > extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
>> > #endif
>> >
>> >+static inline unsigned long *section_to_usemap(struct mem_section *ms)
>> >+{
>> >+      return ms->usage->pageblock_flags;
>>
>> Do we need to consider the case when ms->usage is NULL?
>
>No, this routine safely assumes it is always set.

Then everything looks good to me.

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>_______________________________________________
>Linux-nvdimm mailing list
>Linux-nvdimm@lists.01.org
>https://lists.01.org/mailman/listinfo/linux-nvdimm

-- 
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
