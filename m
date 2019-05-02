Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFFC11481
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 09:48:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BD00B21B02822;
	Thu,  2 May 2019 00:48:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=osalvador@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B4254212377E0
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 00:48:14 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5EA80AD6D;
 Thu,  2 May 2019 07:48:12 +0000 (UTC)
Date: Thu, 2 May 2019 09:48:08 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 03/12] mm/sparsemem: Add helpers track active portions
 of a section at boot
Message-ID: <20190502074803.GA3495@linux>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677653785.2336373.11131100812252340469.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155677653785.2336373.11131100812252340469.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 01, 2019 at 10:55:37PM -0700, Dan Williams wrote:
> Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
> section active bitmask, each bit representing 2MB (SECTION_SIZE (128M) /
> map_active bitmask length (64)). If it turns out that 2MB is too large
> of an active tracking granularity it is trivial to increase the size of
> the map_active bitmap.
> 
> The implications of a partially populated section is that pfn_valid()
> needs to go beyond a valid_section() check and read the sub-section
> active ranges from the bitmask.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Unfortunately I did not hear back about the comments/questions I made for this
in the previous version.

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
>  	unsigned long pageblock_flags[0];
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
> +	return (phys & ~(PA_SECTION_MASK)) / SECTION_ACTIVE_SIZE;
> +}
> +
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
> +{
> +	int idx = section_active_index(PFN_PHYS(pfn));
> +
> +	return !!(ms->usage->map_active & (1UL << idx));

section_active_mask() also converts the value to address/size.
Why do we need to convert the values and we cannot work with pfn/pages instead?
It should be perfectly possible unless I am missing something.

The only thing required would be to export earlier your:

+#define PAGES_PER_SUB_SECTION (SECTION_ACTIVE_SIZE / PAGE_SIZE)
+#define PAGE_SUB_SECTION_MASK (~(PAGES_PER_SUB_SECTION-1))

and change section_active_index to:

static inline int section_active_index(unsigned long pfn)
{
	return (pfn & ~(PAGE_SECTION_MASK)) / SUB_SECTION_ACTIVE_PAGES;
}

In this way we do need to shift the values every time and we can work with them
directly.
Maybe you made it work this way because a reason I am missing.

> +static unsigned long section_active_mask(unsigned long pfn,
> +		unsigned long nr_pages)
> +{
> +	int idx_start, idx_size;
> +	phys_addr_t start, size;
> +
> +	if (!nr_pages)
> +		return 0;
> +
> +	start = PFN_PHYS(pfn);
> +	size = PFN_PHYS(min(nr_pages, PAGES_PER_SECTION
> +				- (pfn & ~PAGE_SECTION_MASK)));

It seems to me that we already picked the lowest value back in
section_active_init, so we should be fine if we drop the min() here?

Another thing is why do we need to convert the values to address/size, and we
cannot work with pfns/pages.
Unless I am missing something it should be possible.

> +	size = ALIGN(size, SECTION_ACTIVE_SIZE);
> +
> +	idx_start = section_active_index(start);
> +	idx_size = section_active_index(size);
> +
> +	if (idx_size == 0)
> +		return -1;

Maybe we would be better off converting that -1 into something like "FULL_SECTION",
or at least dropping a comment there that "-1" means that the section is fully
populated.

> +	return ((1UL << idx_size) - 1) << idx_start;
> +}
> +
> +void section_active_init(unsigned long pfn, unsigned long nr_pages)
> +{
> +	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> +	int i, start_sec = pfn_to_section_nr(pfn);
> +
> +	if (!nr_pages)
> +		return;
> +
> +	for (i = start_sec; i <= end_sec; i++) {
> +		struct mem_section *ms;
> +		unsigned long mask;
> +		unsigned long pfns;
> +
> +		pfns = min(nr_pages, PAGES_PER_SECTION
> +				- (pfn & ~PAGE_SECTION_MASK));
> +		mask = section_active_mask(pfn, pfns);
> +
> +		ms = __nr_to_section(i);
> +		ms->usage->map_active |= mask;
> +		pr_debug("%s: sec: %d mask: %#018lx\n", __func__, i, ms->usage->map_active);
> +
> +		pfn += pfns;
> +		nr_pages -= pfns;
> +	}
> +}
> +
>  /* Record a memory area against a node. */
>  void __init memory_present(int nid, unsigned long start, unsigned long end)
>  {
> 

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
