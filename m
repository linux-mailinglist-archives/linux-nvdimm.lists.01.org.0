Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C098A29BCB
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 May 2019 18:07:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5B2E3212777B6;
	Fri, 24 May 2019 09:07:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=larry.bassel@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 24BF12127779A
 for <linux-nvdimm@lists.01.org>; Fri, 24 May 2019 09:07:33 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OFrnEK057227;
 Fri, 24 May 2019 16:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ay/DwGiyThRnxFLIMwYoesNU6qWFJoBXMPmoYj218ks=;
 b=0K1kaoIJJD0WrsMOICPB1J5sB8EZJeaN3coOFPEdJ6hC+qlr7DG/iqEzKTH+vh7sCOxb
 QLpueclTMRcD+ABk404aDMP8A79vfLL1HcVkwOYjjS1SKj/7MUdONx6bWKXD702DWbLF
 pOO2LYRcaEK0uNCj84sSO56SMNcHoZbbyOzQq6zIgnv7IrdRwT+2fFKGnXeiSEAYtjwV
 0kfk3OfISidJn3RipCUWZhi4GSRhqA5a4Vc9OqwGQc5OLx/sukmdPZWM6ZECiVnzAFBT
 SYhO5dIztYOEDwsE89OIdoLw2hgNfxNxUdp09y3xPyZKROEwItmSrYuVuvuBelbm97F6 tA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2smsk5t2mx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2019 16:07:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OG5dHJ081046;
 Fri, 24 May 2019 16:07:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2smsgtydwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2019 16:07:16 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4OG7ERm010855;
 Fri, 24 May 2019 16:07:14 GMT
Received: from ubuette (/75.80.107.76) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 24 May 2019 16:07:13 +0000
Date: Fri, 24 May 2019 09:07:11 -0700
From: Larry Bassel <larry.bassel@oracle.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH, RFC 2/2] Implement sharing/unsharing of PMDs for FS/DAX
Message-ID: <20190524160711.GF19025@ubuette>
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-3-git-send-email-larry.bassel@oracle.com>
 <20190514130147.2pk2xx32aiomm57b@box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190514130147.2pk2xx32aiomm57b@box>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905240105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240105
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
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 14 May 19 16:01, Kirill A. Shutemov wrote:
> On Thu, May 09, 2019 at 09:05:33AM -0700, Larry Bassel wrote:
[trim]
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1747,6 +1747,33 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
> >  	mm_dec_nr_ptes(mm);
> >  }
> >  
> > +#ifdef CONFIG_MAY_SHARE_FSDAX_PMD
> > +static int unshare_huge_pmd(struct mm_struct *mm, unsigned long addr,
> > +			    pmd_t *pmdp)
> > +{
> > +	pgd_t *pgd = pgd_offset(mm, addr);
> > +	p4d_t *p4d = p4d_offset(pgd, addr);
> > +	pud_t *pud = pud_offset(p4d, addr);
> > +
> > +	WARN_ON(page_count(virt_to_page(pmdp)) == 0);
> > +	if (page_count(virt_to_page(pmdp)) == 1)
> > +		return 0;
> > +
> > +	pud_clear(pud);
> 
> You don't have proper locking in place to do this.

This code is based on and very similar to the code in
mm/hugetlb.c (huge_pmd_unshare()).

I asked Mike Kravetz why the locking in huge_pmd_share() and
huge_pmd_unshare() is correct. The issue (as you point out later
in your email) is whether in both of those cases it is OK to
take the PMD table lock and then modify the PUD table.

He responded with the following analysis:

---------------------------------------------------------------------------------
I went back and looked at the locking in the hugetlb code.  Here is
most of the code for huge_pmd_share().

	i_mmap_lock_write(mapping);
	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
		if (svma == vma)
			continue;

		saddr = page_table_shareable(svma, vma, addr, idx);
		if (saddr) {
			spte = huge_pte_offset(svma->vm_mm, saddr,
					       vma_mmu_pagesize(svma));
			if (spte) {
				get_page(virt_to_page(spte));
				break;
			}
		}
	}

	if (!spte)
		goto out;

	ptl = huge_pte_lock(hstate_vma(vma), mm, spte);
>>>
The primary reason the page table lock is taken here is for the purpose of
checking and possibly updating the PUD (pointer to PMD page).  Note that by
the time we get here we already have found a PMD page to share.  Also note
that the lock taken is the one associated with the PMD page.

The synchronization question to ask is:  Can anyone else modify the PUD value
while I am holding the PMD lock?  In general, the answer is Yes.  However,
we can infer something subtle about the shared PMD case.  Suppose someone
else wanted to set the PUD value.  The only value they could set it to is the
PMD page we found in this routine.  They also would need to go through this
routine to set the value.  They also would need to get the lock on the same
shared PMD.  Actually, they would hit the mapping->i_mmap_rwsem first.  But,
the bottom line is that nobody else can set it.  What about clearing?  In the
hugetlb case, the only places where PUD gets cleared are final page table
tear down and huge_pmd_unshare().  The final page table tear down case is not
interesting as the process is exiting.  All callers if huge_pmd_unshare must
hold the (PMD) page table lock.  This is a requirement.  Therefore, within
a single process this synchronizes two threads:  one calling huge_pmd_share
and another huge_pmd_unshare.
---------------------------------------------------------------------------------

I assert that the same analysis applies to pmd_share() and unshare_huge_pmd()
which are added in this patch.

> 
> > +	put_page(virt_to_page(pmdp));
> > +	mm_dec_nr_pmds(mm);
> > +	return 1;
> > +}
> > +
> > +#else
> > +static int unshare_huge_pmd(struct mm_struct *mm, unsigned long addr,
> > +			    pmd_t *pmdp)
> > +{
> > +	return 0;
> > +}
> > +
> > +#endif
> > +
> >  int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >  		 pmd_t *pmd, unsigned long addr)
> >  {
> > @@ -1764,6 +1791,11 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >  	 * pgtable_trans_huge_withdraw after finishing pmdp related
> >  	 * operations.
> >  	 */
> > +	if (unshare_huge_pmd(vma->vm_mm, addr, pmd)) {
> > +		spin_unlock(ptl);
> > +		return 1;
> > +	}
> > +
> >  	orig_pmd = pmdp_huge_get_and_clear_full(tlb->mm, addr, pmd,
> >  			tlb->fullmm);
> >  	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 641cedf..919a290 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4594,9 +4594,9 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
> >  }
> >  
> >  #ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> > -static unsigned long page_table_shareable(struct vm_area_struct *svma,
> > -				struct vm_area_struct *vma,
> > -				unsigned long addr, pgoff_t idx)
> > +unsigned long page_table_shareable(struct vm_area_struct *svma,
> > +				   struct vm_area_struct *vma,
> > +				   unsigned long addr, pgoff_t idx)
> >  {
> >  	unsigned long saddr = ((idx - svma->vm_pgoff) << PAGE_SHIFT) +
> >  				svma->vm_start;
> > @@ -4619,7 +4619,7 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
> >  	return saddr;
> >  }
> >  
> > -static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> > +bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> >  {
> >  	unsigned long base = addr & PUD_MASK;
> >  	unsigned long end = base + PUD_SIZE;
> > @@ -4763,6 +4763,19 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> >  				unsigned long *start, unsigned long *end)
> >  {
> >  }
> > +
> > +unsigned long page_table_shareable(struct vm_area_struct *svma,
> > +				   struct vm_area_struct *vma,
> > +				   unsigned long addr, pgoff_t idx)
> > +{
> > +	return 0;
> > +}
> > +
> > +bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	return false;
> > +}
> > +
> >  #define want_pmd_share()	(0)
> >  #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> >  
> > diff --git a/mm/memory.c b/mm/memory.c
> > index f7d962d..4c1814c 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3845,6 +3845,109 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_MAY_SHARE_FSDAX_PMD
> > +static pmd_t *huge_pmd_offset(struct mm_struct *mm,
> > +			      unsigned long addr, unsigned long sz)
> 
> Could you explain what this function suppose to do?
> 
> As far as I can see vma_mmu_pagesize() is always PAGE_SIZE of DAX
> filesystem. So we have 'sz' == PAGE_SIZE here.

I thought so too, but in my testing I found that vma_mmu_pagesize() returns
4KiB, which differs from the DAX filesystem's 2MiB pagesize.

> 
> So this function can pointer to PMD of PUD page table entry casted to
> pmd_t*.
> 
> Why?

I don't understand your question here.

> 
> > +{
> > +	pgd_t *pgd;
> > +	p4d_t *p4d;
> > +	pud_t *pud;
> > +	pmd_t *pmd;
> > +
> > +	pgd = pgd_offset(mm, addr);
> > +	if (!pgd_present(*pgd))
> > +		return NULL;
> > +	p4d = p4d_offset(pgd, addr);
> > +	if (!p4d_present(*p4d))
> > +		return NULL;
> > +
> > +	pud = pud_offset(p4d, addr);
> > +	if (sz != PUD_SIZE && pud_none(*pud))
> > +		return NULL;
> > +	/* hugepage or swap? */
> > +	if (pud_huge(*pud) || !pud_present(*pud))
> > +		return (pmd_t *)pud;
> > +
> > +	pmd = pmd_offset(pud, addr);
> > +	if (sz != PMD_SIZE && pmd_none(*pmd))
> > +		return NULL;
> > +	/* hugepage or swap? */
> > +	if (pmd_huge(*pmd) || !pmd_present(*pmd))
> > +		return pmd;
> > +
> > +	return NULL;
> > +}
> > +
> > +static pmd_t *pmd_share(struct mm_struct *mm, pud_t *pud, unsigned long addr)
> > +{
> > +	struct vm_area_struct *vma = find_vma(mm, addr);
> 
> Why? Caller has vma on hands.

This was taken from huge_pmd_share() in mm/hugetlb.c which does
things that way. Are you suggesting that I just pass vma as
an argument to pmd_share()?

> 
> > +	struct address_space *mapping = vma->vm_file->f_mapping;
> > +	pgoff_t idx = ((addr - vma->vm_start) >> PAGE_SHIFT) +
> > +			vma->vm_pgoff;
> 
> linear_page_index()?

Again this came from huge_pmd_share(). I was trying to keep
the differences between both functions as small as possible.

> 
> > +	struct vm_area_struct *svma;
> > +	unsigned long saddr;
> > +	pmd_t *spmd = NULL;
> > +	pmd_t *pmd;
> > +	spinlock_t *ptl;
> > +
> > +	if (!vma_shareable(vma, addr))
> > +		return pmd_alloc(mm, pud, addr);
> > +
> > +	i_mmap_lock_write(mapping);
> > +
> > +	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
> > +		if (svma == vma)
> > +			continue;
> > +
> > +		saddr = page_table_shareable(svma, vma, addr, idx);
> > +		if (saddr) {
> > +			spmd = huge_pmd_offset(svma->vm_mm, saddr,
> > +					       vma_mmu_pagesize(svma));
> > +			if (spmd) {
> > +				get_page(virt_to_page(spmd));
> 
> So, here we get a pin on a page table page. And we don't know if it's PMD
> or PUD page table.

DAX only does 4 KiB and 2 MiB pagesizes, not 1 GiB. The checks for sharing
prevent any 4 KiB DAX from entering this code.

> 
> And we only checked one entry in the page table.
> 
> What if the page table mixes huge-PMD/PUD entries with pointers to page
> table.

Again, I don't think this can happen in DAX. The only sharing allowed
is for FS/DAX/2MiB pagesize.

> 
> > +				break;
> > +			}
> > +		}
> > +	}
> > +
> > +	if (!spmd)
> > +		goto out;
> > +
> > +	ptl = pmd_lockptr(mm, spmd);
> > +	spin_lock(ptl);
> 
> You take lock on PMD page table...
> 
> > +
> > +	if (pud_none(*pud)) {
> > +		pud_populate(mm, pud,
> > +			    (pmd_t *)((unsigned long)spmd & PAGE_MASK));
> 
> ... and modify PUD page table.

Please see my comments about this issue above.

> 
> > +		mm_inc_nr_pmds(mm);
> > +	} else {
> > +		put_page(virt_to_page(spmd));
> > +	}
> > +	spin_unlock(ptl);
> > +out:
> > +	pmd = pmd_alloc(mm, pud, addr);
> > +	i_mmap_unlock_write(mapping);
> > +	return pmd;
> > +}

[trim]

Thanks for the review. My apologies for not getting
back to you sooner.

Larry
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
