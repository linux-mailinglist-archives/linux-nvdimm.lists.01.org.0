Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 326C88865F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Aug 2019 00:59:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DAEFC2131EC85;
	Fri,  9 Aug 2019 16:01:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 510B921309D28
 for <linux-nvdimm@lists.01.org>; Fri,  9 Aug 2019 16:01:51 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:59:09 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; d="scan'208";a="183030881"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:59:09 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 19/19] mm/gup: Remove FOLL_LONGTERM DAX exclusion
Date: Fri,  9 Aug 2019 15:58:33 -0700
Message-Id: <20190809225833.6657-20-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809225833.6657-1-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
MIME-Version: 1.0
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
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Dave Chinner <david@fromorbit.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Ira Weiny <ira.weiny@intel.com>

Now that there is a mechanism for users to safely take LONGTERM pins on
FS DAX pages, remove the FS DAX exclusion from the GUP implementation.

Special processing remains in effect for CONFIG_CMA

NOTE: Some callers still fail because the vaddr_pin information has not
been passed into the new interface.  As new users appear they can start
to use the new interface to support FS DAX.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/gup.c | 78 ++++++--------------------------------------------------
 1 file changed, 8 insertions(+), 70 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 6d23f70d7847..58f008a3c153 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1415,26 +1415,6 @@ static long __get_user_pages_locked(struct task_struct *tsk,
 }
 #endif /* !CONFIG_MMU */
 
-#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
-static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
-{
-	long i;
-	struct vm_area_struct *vma_prev = NULL;
-
-	for (i = 0; i < nr_pages; i++) {
-		struct vm_area_struct *vma = vmas[i];
-
-		if (vma == vma_prev)
-			continue;
-
-		vma_prev = vma;
-
-		if (vma_is_fsdax(vma))
-			return true;
-	}
-	return false;
-}
-
 #ifdef CONFIG_CMA
 static struct page *new_non_cma_page(struct page *page, unsigned long private)
 {
@@ -1568,18 +1548,6 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 
 	return nr_pages;
 }
-#else
-static long check_and_migrate_cma_pages(struct task_struct *tsk,
-					struct mm_struct *mm,
-					unsigned long start,
-					unsigned long nr_pages,
-					struct page **pages,
-					struct vm_area_struct **vmas,
-					unsigned int gup_flags)
-{
-	return nr_pages;
-}
-#endif /* CONFIG_CMA */
 
 /*
  * __gup_longterm_locked() is a wrapper for __get_user_pages_locked which
@@ -1594,49 +1562,28 @@ static long __gup_longterm_locked(struct task_struct *tsk,
 				  unsigned int gup_flags,
 				  struct vaddr_pin *vaddr_pin)
 {
-	struct vm_area_struct **vmas_tmp = vmas;
 	unsigned long flags = 0;
-	long rc, i;
+	long rc;
 
-	if (gup_flags & FOLL_LONGTERM) {
-		if (!pages)
-			return -EINVAL;
-
-		if (!vmas_tmp) {
-			vmas_tmp = kcalloc(nr_pages,
-					   sizeof(struct vm_area_struct *),
-					   GFP_KERNEL);
-			if (!vmas_tmp)
-				return -ENOMEM;
-		}
+	if (flags & FOLL_LONGTERM)
 		flags = memalloc_nocma_save();
-	}
 
 	rc = __get_user_pages_locked(tsk, mm, start, nr_pages, pages,
-				     vmas_tmp, NULL, gup_flags, vaddr_pin);
+				     vmas, NULL, gup_flags, vaddr_pin);
 
 	if (gup_flags & FOLL_LONGTERM) {
 		memalloc_nocma_restore(flags);
 		if (rc < 0)
 			goto out;
 
-		if (check_dax_vmas(vmas_tmp, rc)) {
-			for (i = 0; i < rc; i++)
-				put_page(pages[i]);
-			rc = -EOPNOTSUPP;
-			goto out;
-		}
-
 		rc = check_and_migrate_cma_pages(tsk, mm, start, rc, pages,
-						 vmas_tmp, gup_flags);
+						 vmas, gup_flags);
 	}
 
 out:
-	if (vmas_tmp != vmas)
-		kfree(vmas_tmp);
 	return rc;
 }
-#else /* !CONFIG_FS_DAX && !CONFIG_CMA */
+#else /* !CONFIG_CMA */
 static __always_inline long __gup_longterm_locked(struct task_struct *tsk,
 						  struct mm_struct *mm,
 						  unsigned long start,
@@ -1649,7 +1596,7 @@ static __always_inline long __gup_longterm_locked(struct task_struct *tsk,
 	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
 				       NULL, flags, vaddr_pin);
 }
-#endif /* CONFIG_FS_DAX || CONFIG_CMA */
+#endif /* CONFIG_CMA */
 
 /*
  * This is the same as get_user_pages_remote(), just with a
@@ -1887,9 +1834,6 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			goto pte_unmap;
 
 		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
-				goto pte_unmap;
-
 			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
 			if (unlikely(!pgmap)) {
 				undo_dev_pagemap(nr, nr_start, pages);
@@ -2139,12 +2083,9 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	if (pmd_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
+	if (pmd_devmap(orig))
 		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr,
 					     flags, vaddr_pin);
-	}
 
 	refs = 0;
 	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
@@ -2182,12 +2123,9 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	if (pud_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
+	if (pud_devmap(orig))
 		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr,
 					     flags, vaddr_pin);
-	}
 
 	refs = 0;
 	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
