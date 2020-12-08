Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB1F2D3117
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:30:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 64494100EB832;
	Tue,  8 Dec 2020 09:30:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BB965100EB82B
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:30:55 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HPIw8071095;
	Tue, 8 Dec 2020 17:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=OgxmGknp7SIfBNCz26KqSEuDI8RgB3Wqg5tc6ikM2Ro=;
 b=ADzxl0fZ05pr6/BLynk4EXG8TkYwAgHt7DSXfhPur9jg+O1o5ANUon5eX4eZpboaNaep
 xUdrpNXfmjB4iT+Zdm8Gk7Lo6LMQtUO2ObM0ksjKh8DosMFLXBbpkOeQe2hl78TBTp9w
 C+GWcrV9LXeybcYRU2N7v+zLMHPrCrZAvpXehwEivy+CDbWNCUaIQTwUCVSiSy/oCM4F
 dQRi8wy3fLqXPpwqV542KdRoRCm7FVLDLqLtEwUqdnhN/+Ktix3K8CTyB8YUyTnbNWP9
 upAgE25EkWkwL7AKdsFC7L31ma3UnVJXcsIpNPHYTdADfLRBesw/ARWXnuVZbonUgeFO rw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 35825m41mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 08 Dec 2020 17:30:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HOmpk060825;
	Tue, 8 Dec 2020 17:30:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 358ksnwgke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Dec 2020 17:30:47 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8HUl8x012509;
	Tue, 8 Dec 2020 17:30:47 GMT
Received: from paddy.uk.oracle.com (/10.175.194.215)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 09:30:46 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 9/9] mm: Add follow_devmap_page() for devdax vmas
Date: Tue,  8 Dec 2020 17:29:01 +0000
Message-Id: <20201208172901.17384-11-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201208172901.17384-1-joao.m.martins@oracle.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080107
Message-ID-Hash: KUKNSVAS7PAGSOED2BCWDGOAOQJUMBEL
X-Message-ID-Hash: KUKNSVAS7PAGSOED2BCWDGOAOQJUMBEL
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KUKNSVAS7PAGSOED2BCWDGOAOQJUMBEL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Similar to follow_hugetlb_page() add a follow_devmap_page which rather
than calling follow_page() per 4K page in a PMD/PUD it does so for the
entire PMD, where we lock the pmd/pud, get all pages , unlock.

While doing so, we only change the refcount once when PGMAP_COMPOUND is
passed in.

This let us improve {pin,get}_user_pages{,_longterm}() considerably:

$ gup_benchmark -f /dev/dax0.2 -m 16384 -r 10 -S [-U,-b,-L] -n 512 -w

(<test>) [before] -> [after]
(get_user_pages 2M pages) ~150k us -> ~8.9k us
(pin_user_pages 2M pages) ~192k us -> ~9k us
(pin_user_pages_longterm 2M pages) ~200k us -> ~19k us

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
I've special-cased this to device-dax vmas given its similar page size
guarantees as hugetlbfs, but I feel this is a bit wrong. I am
replicating follow_hugetlb_page() as RFC ought to seek feedback whether
this should be generalized if no fundamental issues exist. In such case,
should I be changing follow_page_mask() to take either an array of pages
or a function pointer and opaque arguments which would let caller pick
its structure?
---
 include/linux/huge_mm.h |   4 +
 include/linux/mm.h      |   2 +
 mm/gup.c                |  22 ++++-
 mm/huge_memory.c        | 202 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 227 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0365aa97f8e7..da87ecea19e6 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -293,6 +293,10 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		pud_t *pud, int flags, struct dev_pagemap **pgmap);
+long follow_devmap_page(struct mm_struct *mm, struct vm_area_struct *vma,
+			struct page **pages, struct vm_area_struct **vmas,
+			unsigned long *position, unsigned long *nr_pages,
+			long i, unsigned int flags, int *locked);
 
 extern vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8b0155441835..466c88679628 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1164,6 +1164,8 @@ static inline void get_page(struct page *page)
 	page_ref_inc(page);
 }
 
+__maybe_unused struct page *try_grab_compound_head(struct page *page, int refs,
+						   unsigned int flags);
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
 
 static inline __must_check bool try_get_page(struct page *page)
diff --git a/mm/gup.c b/mm/gup.c
index 3a9a7229f418..50effb9cc349 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -78,7 +78,7 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
  * considered failure, and furthermore, a likely bug in the caller, so a warning
  * is also emitted.
  */
-static __maybe_unused struct page *try_grab_compound_head(struct page *page,
+__maybe_unused struct page *try_grab_compound_head(struct page *page,
 							  int refs,
 							  unsigned int flags)
 {
@@ -880,8 +880,8 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
  * does not include FOLL_NOWAIT, the mmap_lock may be released.  If it
  * is, *@locked will be set to 0 and -EBUSY returned.
  */
-static int faultin_page(struct vm_area_struct *vma,
-		unsigned long address, unsigned int *flags, int *locked)
+int faultin_page(struct vm_area_struct *vma,
+		 unsigned long address, unsigned int *flags, int *locked)
 {
 	unsigned int fault_flags = 0;
 	vm_fault_t ret;
@@ -1103,6 +1103,22 @@ static long __get_user_pages(struct mm_struct *mm,
 				}
 				continue;
 			}
+			if (vma_is_dax(vma)) {
+				i = follow_devmap_page(mm, vma, pages, vmas,
+						       &start, &nr_pages, i,
+						       gup_flags, locked);
+				if (locked && *locked == 0) {
+					/*
+					 * We've got a VM_FAULT_RETRY
+					 * and we've lost mmap_lock.
+					 * We must stop here.
+					 */
+					BUG_ON(gup_flags & FOLL_NOWAIT);
+					BUG_ON(ret != 0);
+					goto out;
+				}
+				continue;
+			}
 		}
 retry:
 		/*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ec2bb93f7431..20bfbf211dc3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1168,6 +1168,208 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 	return page;
 }
 
+long follow_devmap_page(struct mm_struct *mm, struct vm_area_struct *vma,
+			struct page **pages, struct vm_area_struct **vmas,
+			unsigned long *position, unsigned long *nr_pages,
+			long i, unsigned int flags, int *locked)
+{
+	unsigned long pfn_offset;
+	unsigned long vaddr = *position;
+	unsigned long remainder = *nr_pages;
+	unsigned long align = vma_kernel_pagesize(vma);
+	unsigned long align_nr_pages = align >> PAGE_SHIFT;
+	unsigned long mask = ~(align-1);
+	unsigned long nr_pages_hpage = 0;
+	struct dev_pagemap *pgmap = NULL;
+	int err = -EFAULT;
+
+	if (align == PAGE_SIZE)
+		return i;
+
+	while (vaddr < vma->vm_end && remainder) {
+		pte_t *pte;
+		spinlock_t *ptl = NULL;
+		int absent;
+		struct page *page;
+
+		/*
+		 * If we have a pending SIGKILL, don't keep faulting pages and
+		 * potentially allocating memory.
+		 */
+		if (fatal_signal_pending(current)) {
+			remainder = 0;
+			break;
+		}
+
+		/*
+		 * Some archs (sparc64, sh*) have multiple pte_ts to
+		 * each hugepage.  We have to make sure we get the
+		 * first, for the page indexing below to work.
+		 *
+		 * Note that page table lock is not held when pte is null.
+		 */
+		pte = huge_pte_offset(mm, vaddr & mask, align);
+		if (pte) {
+			if (align == PMD_SIZE)
+				ptl = pmd_lockptr(mm, (pmd_t *) pte);
+			else if (align == PUD_SIZE)
+				ptl = pud_lockptr(mm, (pud_t *) pte);
+			spin_lock(ptl);
+		}
+		absent = !pte || pte_none(ptep_get(pte));
+
+		if (absent && (flags & FOLL_DUMP)) {
+			if (pte)
+				spin_unlock(ptl);
+			remainder = 0;
+			break;
+		}
+
+		if (absent ||
+		    ((flags & FOLL_WRITE) &&
+		      !pte_write(ptep_get(pte)))) {
+			vm_fault_t ret;
+			unsigned int fault_flags = 0;
+
+			if (pte)
+				spin_unlock(ptl);
+			if (flags & FOLL_WRITE)
+				fault_flags |= FAULT_FLAG_WRITE;
+			if (locked)
+				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
+					FAULT_FLAG_KILLABLE;
+			if (flags & FOLL_NOWAIT)
+				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
+					FAULT_FLAG_RETRY_NOWAIT;
+			if (flags & FOLL_TRIED) {
+				/*
+				 * Note: FAULT_FLAG_ALLOW_RETRY and
+				 * FAULT_FLAG_TRIED can co-exist
+				 */
+				fault_flags |= FAULT_FLAG_TRIED;
+			}
+			ret = handle_mm_fault(vma, vaddr, flags, NULL);
+			if (ret & VM_FAULT_ERROR) {
+				err = vm_fault_to_errno(ret, flags);
+				remainder = 0;
+				break;
+			}
+			if (ret & VM_FAULT_RETRY) {
+				if (locked &&
+				    !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
+					*locked = 0;
+				*nr_pages = 0;
+				/*
+				 * VM_FAULT_RETRY must not return an
+				 * error, it will return zero
+				 * instead.
+				 *
+				 * No need to update "position" as the
+				 * caller will not check it after
+				 * *nr_pages is set to 0.
+				 */
+				return i;
+			}
+			continue;
+		}
+
+		pfn_offset = (vaddr & ~mask) >> PAGE_SHIFT;
+		page = pte_page(ptep_get(pte));
+
+		pgmap = get_dev_pagemap(page_to_pfn(page), pgmap);
+		if (!pgmap) {
+			spin_unlock(ptl);
+			remainder = 0;
+			err = -EFAULT;
+			break;
+		}
+
+		/*
+		 * If subpage information not requested, update counters
+		 * and skip the same_page loop below.
+		 */
+		if (!pages && !vmas && !pfn_offset &&
+		    (vaddr + align < vma->vm_end) &&
+		    (remainder >= (align_nr_pages))) {
+			vaddr += align;
+			remainder -= align_nr_pages;
+			i += align_nr_pages;
+			spin_unlock(ptl);
+			continue;
+		}
+
+		nr_pages_hpage = 0;
+
+same_page:
+		if (pages) {
+			pages[i] = mem_map_offset(page, pfn_offset);
+
+			/*
+			 * try_grab_page() should always succeed here, because:
+			 * a) we hold the ptl lock, and b) we've just checked
+			 * that the huge page is present in the page tables.
+			 */
+			if (!(pgmap->flags & PGMAP_COMPOUND) &&
+			    WARN_ON_ONCE(!try_grab_page(pages[i], flags))) {
+				spin_unlock(ptl);
+				remainder = 0;
+				err = -ENOMEM;
+				break;
+			}
+
+		}
+
+		if (vmas)
+			vmas[i] = vma;
+
+		vaddr += PAGE_SIZE;
+		++pfn_offset;
+		--remainder;
+		++i;
+		nr_pages_hpage++;
+		if (vaddr < vma->vm_end && remainder &&
+				pfn_offset < align_nr_pages) {
+			/*
+			 * We use pfn_offset to avoid touching the pageframes
+			 * of this compound page.
+			 */
+			goto same_page;
+		} else {
+			/*
+			 * try_grab_compound_head() should always succeed here,
+			 * because: a) we hold the ptl lock, and b) we've just
+			 * checked that the huge page is present in the page
+			 * tables. If the huge page is present, then the tail
+			 * pages must also be present. The ptl prevents the
+			 * head page and tail pages from being rearranged in
+			 * any way. So this page must be available at this
+			 * point, unless the page refcount overflowed:
+			 */
+			if ((pgmap->flags & PGMAP_COMPOUND) &&
+			    WARN_ON_ONCE(!try_grab_compound_head(pages[i-1],
+								 nr_pages_hpage,
+								 flags))) {
+				put_dev_pagemap(pgmap);
+				spin_unlock(ptl);
+				remainder = 0;
+				err = -ENOMEM;
+				break;
+			}
+			put_dev_pagemap(pgmap);
+		}
+		spin_unlock(ptl);
+	}
+	*nr_pages = remainder;
+	/*
+	 * setting position is actually required only if remainder is
+	 * not zero but it's faster not to add a "if (remainder)"
+	 * branch.
+	 */
+	*position = vaddr;
+
+	return i ? i : err;
+}
+
 int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
 		  struct vm_area_struct *vma)
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
