Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A792F4951C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Jun 2019 00:22:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E8292129EB86;
	Mon, 17 Jun 2019 15:22:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=richard.weiyang@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D25D821295CAA
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 15:21:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w13so18454521eds.4
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mqatRPhG4/yrICubl/YtsP1o46r2J2qqnG2uC01iPb4=;
 b=Sn59+fkuicsgo3YsVoW2qnw1bCXHgBCm2Otdf4Wce7TS4+FrikSNaMBZfYQNyrU729
 UIMmhjtdabVHowgnlZZW6wyZPaZpNTOvJnjFkMwPMWs0WpyGklGYHwe5Lv4F4lKwkO10
 HdjfYqURaByB1W1qfIy9U2J/5HoBKrePLbtsrhVFDxJ8cb46cSkWFEjDnOG+3w2md9TZ
 TNk8ByFIGCx6a3vMl+dRsBN08rY66zqmgyVrAT/iCyo3F0RD9seGbB8vhYUjKc9UbhPw
 XoRl22CkI3tf4rRvfDhmm80D5wjUGcKLq56Bo/oH1BZHmSrUFsqxgBWviu5hFG2iU1LT
 lEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=mqatRPhG4/yrICubl/YtsP1o46r2J2qqnG2uC01iPb4=;
 b=ltNm8o6UYUSvSKfXDGVOCOR5VBd9qtJ0rUruz39k3mSrpSsuNNUVMo4ZtNFvhMAxVJ
 Dw4UbCHo8tGIsnm6GYCmaBZM7bFoHq7DXt41XUK05QJdgC6RlB0YKhHdSkUmpDIimYvu
 CH+pZsdCdU2e/WhR9ZqZrE+VEfsrAhBL++N6DzadFxYqXFYuv6Dt3c2e4SCR/GnyX5HM
 npoZfcQitaIHfCiy9npaZ8cwm7m0fIm885Wr4r9fnfYx3lB58VBF0Lo/3Y64koKW209z
 gG11P0YZVYvmy+RIqNeHEfG2t5cejsNZorPvtyprOvdxP5bkZExcuWXA6ihOJcHepeiv
 1IKw==
X-Gm-Message-State: APjAAAWU5VK29LeNiByW9WKLaPLdhut9ki/PZVVWYI9/M6OwvVmKZGM8
 Fg1dHYuDVA7qvBgktuaI4fo=
X-Google-Smtp-Source: APXvYqxwqzx8eCrKbOf4X/zgCe8y6XlGgBmMbdJ0mUO9A9IZ3/LTjmxZolZoJnnaXFo8vDCJdwZNiw==
X-Received: by 2002:a50:8bfd:: with SMTP id n58mr87510972edn.272.1560810118130; 
 Mon, 17 Jun 2019 15:21:58 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id f3sm2407908ejo.90.2019.06.17.15.21.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Jun 2019 15:21:57 -0700 (PDT)
Date: Mon, 17 Jun 2019 22:21:56 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 02/12] mm/sparsemem: Add helpers track active portions
 of a section at boot
Message-ID: <20190617222156.v6eaujbdrmkz35wr@master>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977187919.2443951.8925592545929008845.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155977187919.2443951.8925592545929008845.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 05, 2019 at 02:57:59PM -0700, Dan Williams wrote:
>Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
>sub-section active bitmask, each bit representing a PMD_SIZE span of the
>architecture's memory hotplug section size.
>
>The implications of a partially populated section is that pfn_valid()
>needs to go beyond a valid_section() check and read the sub-section
>active ranges from the bitmask. The expectation is that the bitmask
>(subsection_map) fits in the same cacheline as the valid_section() data,
>so the incremental performance overhead to pfn_valid() should be
>negligible.
>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Vlastimil Babka <vbabka@suse.cz>
>Cc: Logan Gunthorpe <logang@deltatee.com>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>Tested-by: Jane Chu <jane.chu@oracle.com>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>---
> include/linux/mmzone.h |   29 ++++++++++++++++++++++++++++-
> mm/page_alloc.c        |    4 +++-
> mm/sparse.c            |   35 +++++++++++++++++++++++++++++++++++
> 3 files changed, 66 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>index ac163f2f274f..6dd52d544857 100644
>--- a/include/linux/mmzone.h
>+++ b/include/linux/mmzone.h
>@@ -1199,6 +1199,8 @@ struct mem_section_usage {
> 	unsigned long pageblock_flags[0];
> };
> 
>+void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
>+
> struct page;
> struct page_ext;
> struct mem_section {
>@@ -1336,12 +1338,36 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
> 
> extern int __highest_present_section_nr;
> 
>+static inline int subsection_map_index(unsigned long pfn)
>+{
>+	return (pfn & ~(PAGE_SECTION_MASK)) / PAGES_PER_SUBSECTION;
>+}
>+
>+#ifdef CONFIG_SPARSEMEM_VMEMMAP
>+static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>+{
>+	int idx = subsection_map_index(pfn);
>+
>+	return test_bit(idx, ms->usage->subsection_map);
>+}
>+#else
>+static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>+{
>+	return 1;
>+}
>+#endif
>+
> #ifndef CONFIG_HAVE_ARCH_PFN_VALID
> static inline int pfn_valid(unsigned long pfn)
> {
>+	struct mem_section *ms;
>+
> 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> 		return 0;
>-	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
>+	ms = __nr_to_section(pfn_to_section_nr(pfn));
>+	if (!valid_section(ms))
>+		return 0;
>+	return pfn_section_valid(ms, pfn);
> }
> #endif
> 
>@@ -1373,6 +1399,7 @@ void sparse_init(void);
> #define sparse_init()	do {} while (0)
> #define sparse_index_init(_sec, _nid)  do {} while (0)
> #define pfn_present pfn_valid
>+#define subsection_map_init(_pfn, _nr_pages) do {} while (0)
> #endif /* CONFIG_SPARSEMEM */
> 
> /*
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index c6d8224d792e..bd773efe5b82 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -7292,10 +7292,12 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
> 
> 	/* Print out the early node map */
> 	pr_info("Early memory node ranges\n");
>-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid)
>+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
> 		pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
> 			(u64)start_pfn << PAGE_SHIFT,
> 			((u64)end_pfn << PAGE_SHIFT) - 1);
>+		subsection_map_init(start_pfn, end_pfn - start_pfn);
>+	}

Just curious about why we set subsection here?

Function free_area_init_nodes() mostly handles pgdat, if I am correct. Setup
subsection here looks like touching some lower level system data structure.

> 
> 	/* Initialise every node */
> 	mminit_verify_pageflags_layout();
>diff --git a/mm/sparse.c b/mm/sparse.c
>index 71da15cc7432..0baa2e55cfdd 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -210,6 +210,41 @@ static inline unsigned long first_present_section_nr(void)
> 	return next_present_section_nr(-1);
> }
> 
>+void subsection_mask_set(unsigned long *map, unsigned long pfn,
>+		unsigned long nr_pages)
>+{
>+	int idx = subsection_map_index(pfn);
>+	int end = subsection_map_index(pfn + nr_pages - 1);
>+
>+	bitmap_set(map, idx, end - idx + 1);
>+}
>+
>+void subsection_map_init(unsigned long pfn, unsigned long nr_pages)
>+{
>+	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
>+	int i, start_sec = pfn_to_section_nr(pfn);
>+
>+	if (!nr_pages)
>+		return;
>+
>+	for (i = start_sec; i <= end_sec; i++) {
>+		struct mem_section *ms;
>+		unsigned long pfns;
>+
>+		pfns = min(nr_pages, PAGES_PER_SECTION
>+				- (pfn & ~PAGE_SECTION_MASK));
>+		ms = __nr_to_section(i);
>+		subsection_mask_set(ms->usage->subsection_map, pfn, pfns);
>+
>+		pr_debug("%s: sec: %d pfns: %ld set(%d, %d)\n", __func__, i,
>+				pfns, subsection_map_index(pfn),
>+				subsection_map_index(pfn + pfns - 1));
>+
>+		pfn += pfns;
>+		nr_pages -= pfns;
>+	}
>+}
>+
> /* Record a memory area against a node. */
> void __init memory_present(int nid, unsigned long start, unsigned long end)
> {

-- 
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
