Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A44011E96B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Dec 2019 18:47:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1DFB310113699;
	Fri, 13 Dec 2019 09:50:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4578310113697
	for <linux-nvdimm@lists.01.org>; Fri, 13 Dec 2019 09:50:51 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 09:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600";
   d="scan'208";a="296989821"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga001.jf.intel.com with ESMTP; 13 Dec 2019 09:47:02 -0800
Date: Fri, 13 Dec 2019 09:47:02 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Barret Rhoden <brho@google.com>
Subject: Re: [PATCH v5 1/2] mm: make dev_pagemap_mapping_shift() externally
 visible
Message-ID: <20191213174702.GB31552@linux.intel.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-2-brho@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191212182238.46535-2-brho@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Message-ID-Hash: A6SUUB2EWN6Y7UW5ZIARIIFZBE7TB3YL
X-Message-ID-Hash: A6SUUB2EWN6Y7UW5ZIARIIFZBE7TB3YL
X-MailFrom: sean.j.christopherson@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A6SUUB2EWN6Y7UW5ZIARIIFZBE7TB3YL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 12, 2019 at 01:22:37PM -0500, Barret Rhoden wrote:
> KVM has a use case for determining the size of a dax mapping.
> 
> The KVM code has easy access to the address and the mm, and
> dev_pagemap_mapping_shift() needs only those parameters.  It was
> deriving them from page and vma.  This commit changes those parameters
> from (page, vma) to (address, mm).
> 
> Signed-off-by: Barret Rhoden <brho@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mm.h  |  3 +++
>  mm/memory-failure.c | 38 +++-----------------------------------
>  mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a2adf95b3f9c..bfd1882dd5c6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1013,6 +1013,9 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
>  #define page_ref_zero_or_close_to_overflow(page) \
>  	((unsigned int) page_ref_count(page) + 127u <= 127u)
>  
> +unsigned long dev_pagemap_mapping_shift(unsigned long address,
> +					struct mm_struct *mm);
> +
>  static inline void get_page(struct page *page)
>  {
>  	page = compound_head(page);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3151c87dff73..bafa464c8290 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -261,40 +261,6 @@ void shake_page(struct page *p, int access)
>  }
>  EXPORT_SYMBOL_GPL(shake_page);
>  
> -static unsigned long dev_pagemap_mapping_shift(struct page *page,
> -		struct vm_area_struct *vma)
> -{
> -	unsigned long address = vma_address(page, vma);
> -	pgd_t *pgd;
> -	p4d_t *p4d;
> -	pud_t *pud;
> -	pmd_t *pmd;
> -	pte_t *pte;
> -
> -	pgd = pgd_offset(vma->vm_mm, address);
> -	if (!pgd_present(*pgd))
> -		return 0;
> -	p4d = p4d_offset(pgd, address);
> -	if (!p4d_present(*p4d))
> -		return 0;
> -	pud = pud_offset(p4d, address);
> -	if (!pud_present(*pud))
> -		return 0;
> -	if (pud_devmap(*pud))
> -		return PUD_SHIFT;
> -	pmd = pmd_offset(pud, address);
> -	if (!pmd_present(*pmd))
> -		return 0;
> -	if (pmd_devmap(*pmd))
> -		return PMD_SHIFT;
> -	pte = pte_offset_map(pmd, address);
> -	if (!pte_present(*pte))
> -		return 0;
> -	if (pte_devmap(*pte))
> -		return PAGE_SHIFT;
> -	return 0;
> -}
> -
>  /*
>   * Failure handling: if we can't find or can't kill a process there's
>   * not much we can do.	We just print a message and ignore otherwise.
> @@ -324,7 +290,9 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>  	}
>  	tk->addr = page_address_in_vma(p, vma);
>  	if (is_zone_device_page(p))
> -		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
> +		tk->size_shift =
> +			dev_pagemap_mapping_shift(vma_address(page, vma),
> +						  vma->vm_mm);
>  	else
>  		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
>  
> diff --git a/mm/util.c b/mm/util.c
> index 3ad6db9a722e..59984e6b40ab 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -901,3 +901,37 @@ int memcmp_pages(struct page *page1, struct page *page2)
>  	kunmap_atomic(addr1);
>  	return ret;
>  }
> +
> +unsigned long dev_pagemap_mapping_shift(unsigned long address,
> +					struct mm_struct *mm)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	pgd = pgd_offset(mm, address);
> +	if (!pgd_present(*pgd))
> +		return 0;
> +	p4d = p4d_offset(pgd, address);
> +	if (!p4d_present(*p4d))
> +		return 0;
> +	pud = pud_offset(p4d, address);
> +	if (!pud_present(*pud))
> +		return 0;
> +	if (pud_devmap(*pud))
> +		return PUD_SHIFT;
> +	pmd = pmd_offset(pud, address);
> +	if (!pmd_present(*pmd))
> +		return 0;
> +	if (pmd_devmap(*pmd))
> +		return PMD_SHIFT;
> +	pte = pte_offset_map(pmd, address);
> +	if (!pte_present(*pte))
> +		return 0;
> +	if (pte_devmap(*pte))
> +		return PAGE_SHIFT;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_pagemap_mapping_shift);

This is basically a rehash of lookup_address_in_pgd(), and doesn't provide
exactly what KVM needs.  E.g. KVM works with levels instead of shifts, and
it would be nice to provide the pte so that KVM can sanity check that the
pfn from this walk matches the pfn it plans on mapping.

Instead of exporting dev_pagemap_mapping_shift(), what about relacing it
with a patch to introduce lookup_address_mm() and export that?

dev_pagemap_mapping_shift() could then wrap the new helper (if you want),
and KVM could do lookup_address_mm() for querying the size of ZONE_DEVICE
pages.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
