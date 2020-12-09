Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0818C2D3A3D
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 06:23:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65E1C100EB84A;
	Tue,  8 Dec 2020 21:23:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.143; helo=hqnvemgate24.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com [216.228.121.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5AB82100EB849
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 21:23:53 -0800 (PST)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5fd05f690000>; Tue, 08 Dec 2020 21:23:53 -0800
Received: from [10.2.60.96] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 05:23:49 +0000
Subject: Re: [PATCH RFC 9/9] mm: Add follow_devmap_page() for devdax vmas
To: Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-11-joao.m.martins@oracle.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <aa624a3d-f760-ddf6-6298-1938e24be842@nvidia.com>
Date: Tue, 8 Dec 2020 21:23:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201208172901.17384-11-joao.m.martins@oracle.com>
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1607491433; bh=vWH+Q4RYpVuMca8TyP5EHXsI9aX/JDhI9H7EtFAeX44=;
	h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
	 MIME-Version:In-Reply-To:Content-Type:Content-Language:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	b=lmFbCwOtssUKc392tH+cqZXiiPTDY3SLXr3utbvbTpyL72nEbX33lqc+QWrTq2R5g
	 PGF1xwwmXm1z5Il0Rcmd2kE4p2fOMvZB4D4deXmFthg1bd3HX/GrxzjcGkX6hoizO2
	 phk9Q/WJxtyeWzeTJfB4quxWyjhbHm5KzLYJCa7B0hjX2cs52ItTkW6I23533Gvz9S
	 6SCiiwBv0URVDhBGeuTyh3Rv71OTyI5ewcI3MqIVnMJ1XA2a3xHJ8y6edvufz/DXiu
	 XNE4E+DWS8DTc1UCD6ITdOPlLLn6/FV1ldlYK+6+DmfKV2l8QmUsFrr/QqvTbm0wo1
	 yWnlbRf3B9/4w==
Message-ID-Hash: VHUNXUCZA6NBRSKHNOYYDT4NUXXWPDAW
X-Message-ID-Hash: VHUNXUCZA6NBRSKHNOYYDT4NUXXWPDAW
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>,
	"Jason Gunthorpe  <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song" <songmuchun@bytedance.com>,
	Mike Kravetz <mike.kravetz@oracle.com>, Andrew@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VHUNXUCZA6NBRSKHNOYYDT4NUXXWPDAW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/8/20 9:29 AM, Joao Martins wrote:
> Similar to follow_hugetlb_page() add a follow_devmap_page which rather
> than calling follow_page() per 4K page in a PMD/PUD it does so for the
> entire PMD, where we lock the pmd/pud, get all pages , unlock.
> 
> While doing so, we only change the refcount once when PGMAP_COMPOUND is
> passed in.
> 
> This let us improve {pin,get}_user_pages{,_longterm}() considerably:
> 
> $ gup_benchmark -f /dev/dax0.2 -m 16384 -r 10 -S [-U,-b,-L] -n 512 -w
> 
d> (<test>) [before] -> [after]
> (get_user_pages 2M pages) ~150k us -> ~8.9k us
> (pin_user_pages 2M pages) ~192k us -> ~9k us
> (pin_user_pages_longterm 2M pages) ~200k us -> ~19k us
>

Yes, this is a massive improvement.


> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
> I've special-cased this to device-dax vmas given its similar page size
> guarantees as hugetlbfs, but I feel this is a bit wrong. I am
> replicating follow_hugetlb_page() as RFC ought to seek feedback whether
> this should be generalized if no fundamental issues exist. In such case,
> should I be changing follow_page_mask() to take either an array of pages
> or a function pointer and opaque arguments which would let caller pick
> its structure?

I don't know which approach is better because I haven't yet attempted to
find the common elements in these routines. But if there is *any way* to
avoid this copy-paste creation of yet more following of pages, then it's
*very* good to do.

thanks,
-- 
John Hubbard
NVIDIA

> ---
>   include/linux/huge_mm.h |   4 +
>   include/linux/mm.h      |   2 +
>   mm/gup.c                |  22 ++++-
>   mm/huge_memory.c        | 202 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 227 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 0365aa97f8e7..da87ecea19e6 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -293,6 +293,10 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>   		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
>   struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
>   		pud_t *pud, int flags, struct dev_pagemap **pgmap);
> +long follow_devmap_page(struct mm_struct *mm, struct vm_area_struct *vma,
> +			struct page **pages, struct vm_area_struct **vmas,
> +			unsigned long *position, unsigned long *nr_pages,
> +			long i, unsigned int flags, int *locked);
>   
>   extern vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
>   
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8b0155441835..466c88679628 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1164,6 +1164,8 @@ static inline void get_page(struct page *page)
>   	page_ref_inc(page);
>   }
>   
> +__maybe_unused struct page *try_grab_compound_head(struct page *page, int refs,
> +						   unsigned int flags);
>   bool __must_check try_grab_page(struct page *page, unsigned int flags);
>   
>   static inline __must_check bool try_get_page(struct page *page)
> diff --git a/mm/gup.c b/mm/gup.c
> index 3a9a7229f418..50effb9cc349 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -78,7 +78,7 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
>    * considered failure, and furthermore, a likely bug in the caller, so a warning
>    * is also emitted.
>    */
> -static __maybe_unused struct page *try_grab_compound_head(struct page *page,
> +__maybe_unused struct page *try_grab_compound_head(struct page *page,
>   							  int refs,
>   							  unsigned int flags)
>   {
> @@ -880,8 +880,8 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
>    * does not include FOLL_NOWAIT, the mmap_lock may be released.  If it
>    * is, *@locked will be set to 0 and -EBUSY returned.
>    */
> -static int faultin_page(struct vm_area_struct *vma,
> -		unsigned long address, unsigned int *flags, int *locked)
> +int faultin_page(struct vm_area_struct *vma,
> +		 unsigned long address, unsigned int *flags, int *locked)
>   {
>   	unsigned int fault_flags = 0;
>   	vm_fault_t ret;
> @@ -1103,6 +1103,22 @@ static long __get_user_pages(struct mm_struct *mm,
>   				}
>   				continue;
>   			}
> +			if (vma_is_dax(vma)) {
> +				i = follow_devmap_page(mm, vma, pages, vmas,
> +						       &start, &nr_pages, i,
> +						       gup_flags, locked);
> +				if (locked && *locked == 0) {
> +					/*
> +					 * We've got a VM_FAULT_RETRY
> +					 * and we've lost mmap_lock.
> +					 * We must stop here.
> +					 */
> +					BUG_ON(gup_flags & FOLL_NOWAIT);
> +					BUG_ON(ret != 0);
> +					goto out;
> +				}
> +				continue;
> +			}
>   		}
>   retry:
>   		/*
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ec2bb93f7431..20bfbf211dc3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1168,6 +1168,208 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
>   	return page;
>   }
>   
> +long follow_devmap_page(struct mm_struct *mm, struct vm_area_struct *vma,
> +			struct page **pages, struct vm_area_struct **vmas,
> +			unsigned long *position, unsigned long *nr_pages,
> +			long i, unsigned int flags, int *locked)
> +{
> +	unsigned long pfn_offset;
> +	unsigned long vaddr = *position;
> +	unsigned long remainder = *nr_pages;
> +	unsigned long align = vma_kernel_pagesize(vma);
> +	unsigned long align_nr_pages = align >> PAGE_SHIFT;
> +	unsigned long mask = ~(align-1);
> +	unsigned long nr_pages_hpage = 0;
> +	struct dev_pagemap *pgmap = NULL;
> +	int err = -EFAULT;
> +
> +	if (align == PAGE_SIZE)
> +		return i;
> +
> +	while (vaddr < vma->vm_end && remainder) {
> +		pte_t *pte;
> +		spinlock_t *ptl = NULL;
> +		int absent;
> +		struct page *page;
> +
> +		/*
> +		 * If we have a pending SIGKILL, don't keep faulting pages and
> +		 * potentially allocating memory.
> +		 */
> +		if (fatal_signal_pending(current)) {
> +			remainder = 0;
> +			break;
> +		}
> +
> +		/*
> +		 * Some archs (sparc64, sh*) have multiple pte_ts to
> +		 * each hugepage.  We have to make sure we get the
> +		 * first, for the page indexing below to work.
> +		 *
> +		 * Note that page table lock is not held when pte is null.
> +		 */
> +		pte = huge_pte_offset(mm, vaddr & mask, align);
> +		if (pte) {
> +			if (align == PMD_SIZE)
> +				ptl = pmd_lockptr(mm, (pmd_t *) pte);
> +			else if (align == PUD_SIZE)
> +				ptl = pud_lockptr(mm, (pud_t *) pte);
> +			spin_lock(ptl);
> +		}
> +		absent = !pte || pte_none(ptep_get(pte));
> +
> +		if (absent && (flags & FOLL_DUMP)) {
> +			if (pte)
> +				spin_unlock(ptl);
> +			remainder = 0;
> +			break;
> +		}
> +
> +		if (absent ||
> +		    ((flags & FOLL_WRITE) &&
> +		      !pte_write(ptep_get(pte)))) {
> +			vm_fault_t ret;
> +			unsigned int fault_flags = 0;
> +
> +			if (pte)
> +				spin_unlock(ptl);
> +			if (flags & FOLL_WRITE)
> +				fault_flags |= FAULT_FLAG_WRITE;
> +			if (locked)
> +				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
> +					FAULT_FLAG_KILLABLE;
> +			if (flags & FOLL_NOWAIT)
> +				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
> +					FAULT_FLAG_RETRY_NOWAIT;
> +			if (flags & FOLL_TRIED) {
> +				/*
> +				 * Note: FAULT_FLAG_ALLOW_RETRY and
> +				 * FAULT_FLAG_TRIED can co-exist
> +				 */
> +				fault_flags |= FAULT_FLAG_TRIED;
> +			}
> +			ret = handle_mm_fault(vma, vaddr, flags, NULL);
> +			if (ret & VM_FAULT_ERROR) {
> +				err = vm_fault_to_errno(ret, flags);
> +				remainder = 0;
> +				break;
> +			}
> +			if (ret & VM_FAULT_RETRY) {
> +				if (locked &&
> +				    !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
> +					*locked = 0;
> +				*nr_pages = 0;
> +				/*
> +				 * VM_FAULT_RETRY must not return an
> +				 * error, it will return zero
> +				 * instead.
> +				 *
> +				 * No need to update "position" as the
> +				 * caller will not check it after
> +				 * *nr_pages is set to 0.
> +				 */
> +				return i;
> +			}
> +			continue;
> +		}
> +
> +		pfn_offset = (vaddr & ~mask) >> PAGE_SHIFT;
> +		page = pte_page(ptep_get(pte));
> +
> +		pgmap = get_dev_pagemap(page_to_pfn(page), pgmap);
> +		if (!pgmap) {
> +			spin_unlock(ptl);
> +			remainder = 0;
> +			err = -EFAULT;
> +			break;
> +		}
> +
> +		/*
> +		 * If subpage information not requested, update counters
> +		 * and skip the same_page loop below.
> +		 */
> +		if (!pages && !vmas && !pfn_offset &&
> +		    (vaddr + align < vma->vm_end) &&
> +		    (remainder >= (align_nr_pages))) {
> +			vaddr += align;
> +			remainder -= align_nr_pages;
> +			i += align_nr_pages;
> +			spin_unlock(ptl);
> +			continue;
> +		}
> +
> +		nr_pages_hpage = 0;
> +
> +same_page:
> +		if (pages) {
> +			pages[i] = mem_map_offset(page, pfn_offset);
> +
> +			/*
> +			 * try_grab_page() should always succeed here, because:
> +			 * a) we hold the ptl lock, and b) we've just checked
> +			 * that the huge page is present in the page tables.
> +			 */
> +			if (!(pgmap->flags & PGMAP_COMPOUND) &&
> +			    WARN_ON_ONCE(!try_grab_page(pages[i], flags))) {
> +				spin_unlock(ptl);
> +				remainder = 0;
> +				err = -ENOMEM;
> +				break;
> +			}
> +
> +		}
> +
> +		if (vmas)
> +			vmas[i] = vma;
> +
> +		vaddr += PAGE_SIZE;
> +		++pfn_offset;
> +		--remainder;
> +		++i;
> +		nr_pages_hpage++;
> +		if (vaddr < vma->vm_end && remainder &&
> +				pfn_offset < align_nr_pages) {
> +			/*
> +			 * We use pfn_offset to avoid touching the pageframes
> +			 * of this compound page.
> +			 */
> +			goto same_page;
> +		} else {
> +			/*
> +			 * try_grab_compound_head() should always succeed here,
> +			 * because: a) we hold the ptl lock, and b) we've just
> +			 * checked that the huge page is present in the page
> +			 * tables. If the huge page is present, then the tail
> +			 * pages must also be present. The ptl prevents the
> +			 * head page and tail pages from being rearranged in
> +			 * any way. So this page must be available at this
> +			 * point, unless the page refcount overflowed:
> +			 */
> +			if ((pgmap->flags & PGMAP_COMPOUND) &&
> +			    WARN_ON_ONCE(!try_grab_compound_head(pages[i-1],
> +								 nr_pages_hpage,
> +								 flags))) {
> +				put_dev_pagemap(pgmap);
> +				spin_unlock(ptl);
> +				remainder = 0;
> +				err = -ENOMEM;
> +				break;
> +			}
> +			put_dev_pagemap(pgmap);
> +		}
> +		spin_unlock(ptl);
> +	}
> +	*nr_pages = remainder;
> +	/*
> +	 * setting position is actually required only if remainder is
> +	 * not zero but it's faster not to add a "if (remainder)"
> +	 * branch.
> +	 */
> +	*position = vaddr;
> +
> +	return i ? i : err;
> +}
> +
>   int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>   		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
>   		  struct vm_area_struct *vma)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
