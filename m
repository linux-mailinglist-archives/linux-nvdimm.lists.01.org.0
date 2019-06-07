Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4524839631
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 21:52:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A902021959CB2;
	Fri,  7 Jun 2019 12:52:47 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=larry.bassel@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E490721290DE8
 for <linux-nvdimm@lists.01.org>; Fri,  7 Jun 2019 12:52:45 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57Ji74w098344;
 Fri, 7 Jun 2019 19:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=azHW+cQaxRO87i10SYgPO4FUpLCfSWASegXloVuy3VQ=;
 b=w3CaDR2O4INbPMzrHAC8aguIcoYcO5oSuWcxoIEYHztSXXbVVYZJg5+WE+14EIzCE0C1
 TVMTE2n4O7EDEytsuoc1n2hm/zTNBIcaUeDeFuoprpMxzxgNn7gn76RyTjO8IWmUlRVZ
 ZUjUWxxde/bBSNq/xwUhJJb1vpb3w3mfVrRWLbt0ybhL4KtoTPpBWfeXukHVNQ+G4VlT
 WS3KA2XBp3fi0dLpDJL4iARVbhFdld/fvWVI6fDmF4ad38jxcL3MdsC8VbsknLBn6PKe
 wt23+RHL4aBmnFtEZLSzTmWknxdbTaYmUeWlteDmG2JZxIBskT7SF31VlhAwBrxSemdF 5Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2suj0r05yw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jun 2019 19:52:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57Jq2W2024665;
 Fri, 7 Jun 2019 19:52:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2swngk6psb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jun 2019 19:52:32 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57JqThx012151;
 Fri, 7 Jun 2019 19:52:29 GMT
Received: from oracle.com (/75.80.107.76)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Jun 2019 12:52:29 -0700
From: Larry Bassel <larry.bassel@oracle.com>
To: mike.kravetz@oracle.com, willy@infradead.org, dan.j.williams@intel.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [RFC PATCH v2 2/2] Implement sharing/unsharing of PMDs for FS/DAX
Date: Fri,  7 Jun 2019 12:51:03 -0700
Message-Id: <1559937063-8323-3-git-send-email-larry.bassel@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559937063-8323-1-git-send-email-larry.bassel@oracle.com>
References: <1559937063-8323-1-git-send-email-larry.bassel@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070132
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

This is based on (but somewhat different from) what hugetlbfs
does to share/unshare page tables.

Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 include/linux/hugetlb.h |   4 ++
 mm/huge_memory.c        |  37 +++++++++++++++++
 mm/hugetlb.c            |   8 ++--
 mm/memory.c             | 108 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 152 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index edf476c..debff55 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -140,6 +140,10 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
+unsigned long page_table_shareable(struct vm_area_struct *svma,
+				   struct vm_area_struct *vma,
+				   unsigned long addr, pgoff_t idx);
+bool vma_shareable(struct vm_area_struct *vma, unsigned long addr);
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
 			      int write);
 struct page *follow_huge_pd(struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9f8bce9..935874c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1751,6 +1751,33 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 	mm_dec_nr_ptes(mm);
 }
 
+#ifdef CONFIG_ARCH_HAS_HUGE_PMD_SHARE
+static int unshare_huge_pmd(struct mm_struct *mm, unsigned long addr,
+			    pmd_t *pmdp)
+{
+	pgd_t *pgd = pgd_offset(mm, addr);
+	p4d_t *p4d = p4d_offset(pgd, addr);
+	pud_t *pud = pud_offset(p4d, addr);
+
+	WARN_ON(page_count(virt_to_page(pmdp)) == 0);
+	if (page_count(virt_to_page(pmdp)) == 1)
+		return 0;
+
+	pud_clear(pud);
+	put_page(virt_to_page(pmdp));
+	mm_dec_nr_pmds(mm);
+	return 1;
+}
+
+#else
+static int unshare_huge_pmd(struct mm_struct *mm, unsigned long addr,
+			    pmd_t *pmdp)
+{
+	return 0;
+}
+
+#endif
+
 int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pmd_t *pmd, unsigned long addr)
 {
@@ -1768,6 +1795,11 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * pgtable_trans_huge_withdraw after finishing pmdp related
 	 * operations.
 	 */
+	if (unshare_huge_pmd(vma->vm_mm, addr, pmd)) {
+		spin_unlock(ptl);
+		return 1;
+	}
+
 	orig_pmd = pmdp_huge_get_and_clear_full(tlb->mm, addr, pmd,
 			tlb->fullmm);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
@@ -1915,6 +1947,11 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	if (!ptl)
 		return 0;
 
+	if (unshare_huge_pmd(mm, addr, pmd)) {
+		spin_unlock(ptl);
+		return HPAGE_PMD_NR;
+	}
+
 	preserve_write = prot_numa && pmd_write(*pmd);
 	ret = 1;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3a54c9d..1c1ed4e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4653,9 +4653,9 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 }
 
 #ifdef CONFIG_ARCH_HAS_HUGE_PMD_SHARE
-static unsigned long page_table_shareable(struct vm_area_struct *svma,
-				struct vm_area_struct *vma,
-				unsigned long addr, pgoff_t idx)
+unsigned long page_table_shareable(struct vm_area_struct *svma,
+				   struct vm_area_struct *vma,
+				   unsigned long addr, pgoff_t idx)
 {
 	unsigned long saddr = ((idx - svma->vm_pgoff) << PAGE_SHIFT) +
 				svma->vm_start;
@@ -4678,7 +4678,7 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
-static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
 {
 	unsigned long base = addr & PUD_MASK;
 	unsigned long end = base + PUD_SIZE;
diff --git a/mm/memory.c b/mm/memory.c
index ddf20bd..1ca8f75 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3932,6 +3932,109 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	return 0;
 }
 
+#ifdef CONFIG_ARCH_HAS_HUGE_PMD_SHARE
+static pmd_t *huge_pmd_offset(struct mm_struct *mm,
+			      unsigned long addr, unsigned long sz)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = pgd_offset(mm, addr);
+	if (!pgd_present(*pgd))
+		return NULL;
+	p4d = p4d_offset(pgd, addr);
+	if (!p4d_present(*p4d))
+		return NULL;
+
+	pud = pud_offset(p4d, addr);
+	if (sz != PUD_SIZE && pud_none(*pud))
+		return NULL;
+	/* hugepage or swap? */
+	if (pud_huge(*pud) || !pud_present(*pud))
+		return (pmd_t *)pud;
+
+	pmd = pmd_offset(pud, addr);
+	if (sz != PMD_SIZE && pmd_none(*pmd))
+		return NULL;
+	/* hugepage or swap? */
+	if (pmd_huge(*pmd) || !pmd_present(*pmd))
+		return pmd;
+
+	return NULL;
+}
+
+static pmd_t *pmd_share(struct mm_struct *mm, pud_t *pud, unsigned long addr)
+{
+	struct vm_area_struct *vma = find_vma(mm, addr);
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	pgoff_t idx = ((addr - vma->vm_start) >> PAGE_SHIFT) +
+			vma->vm_pgoff;
+	struct vm_area_struct *svma;
+	unsigned long saddr;
+	pmd_t *spmd = NULL;
+	pmd_t *pmd;
+	spinlock_t *ptl;
+
+	if (!vma_shareable(vma, addr))
+		return pmd_alloc(mm, pud, addr);
+
+	i_mmap_lock_write(mapping);
+
+	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
+		if (svma == vma)
+			continue;
+
+		saddr = page_table_shareable(svma, vma, addr, idx);
+		if (saddr) {
+			spmd = huge_pmd_offset(svma->vm_mm, saddr,
+					       vma_mmu_pagesize(svma));
+			if (spmd) {
+				get_page(virt_to_page(spmd));
+				break;
+			}
+		}
+	}
+
+	if (!spmd)
+		goto out;
+
+	ptl = pmd_lockptr(mm, spmd);
+	spin_lock(ptl);
+
+	if (pud_none(*pud)) {
+		pud_populate(mm, pud,
+			     (pmd_t *)((unsigned long)spmd & PAGE_MASK));
+		mm_inc_nr_pmds(mm);
+	} else {
+		put_page(virt_to_page(spmd));
+	}
+	spin_unlock(ptl);
+out:
+	pmd = pmd_alloc(mm, pud, addr);
+	i_mmap_unlock_write(mapping);
+	return pmd;
+}
+
+static bool may_share_pmd(struct vm_area_struct *vma)
+{
+	if (vma_is_fsdax(vma))
+		return true;
+	return false;
+}
+#else
+static pmd_t *pmd_share(struct mm_struct *mm, pud_t *pud, unsigned long addr)
+{
+	return pmd_alloc(mm, pud, addr);
+}
+
+static bool may_share_pmd(struct vm_area_struct *vma)
+{
+	return false;
+}
+#endif
+
 /*
  * By the time we get here, we already hold the mm semaphore
  *
@@ -3985,7 +4088,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		}
 	}
 
-	vmf.pmd = pmd_alloc(mm, vmf.pud, address);
+	if (unlikely(may_share_pmd(vma)))
+		vmf.pmd = pmd_share(mm, vmf.pud, address);
+	else
+		vmf.pmd = pmd_alloc(mm, vmf.pud, address);
 	if (!vmf.pmd)
 		return VM_FAULT_OOM;
 	if (pmd_none(*vmf.pmd) && __transparent_hugepage_enabled(vma)) {
-- 
1.8.3.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
