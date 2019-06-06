Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 320CE3696E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 03:45:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4B1D21290D4C;
	Wed,  5 Jun 2019 18:45:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CF4F421290D2B
 for <linux-nvdimm@lists.01.org>; Wed,  5 Jun 2019 18:45:27 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jun 2019 18:45:27 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:45:26 -0700
From: ira.weiny@intel.com
To: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
 "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
 Dave Chinner <david@fromorbit.com>
Subject: [PATCH RFC 10/10] mm/gup: Remove FOLL_LONGTERM DAX exclusion
Date: Wed,  5 Jun 2019 18:45:43 -0700
Message-Id: <20190606014544.8339-11-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606014544.8339-1-ira.weiny@intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
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
Cc: linux-nvdimm@lists.01.org, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Ira Weiny <ira.weiny@intel.com>

Now that there is a mechanism for users to safely take LONGTERM pins on
FS DAX pages, remove the FS DAX exclusion from GUP with FOLL_LONGTERM.

Special processing remains in effect for CONFIG_CMA

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/gup.c | 78 ++++++--------------------------------------------------
 1 file changed, 8 insertions(+), 70 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index d06cc5b14c0b..4f6e5606b81e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1392,26 +1392,6 @@ long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 }
 EXPORT_SYMBOL(get_user_pages_remote);
 
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
@@ -1542,18 +1522,6 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 
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
-#endif
 
 /*
  * __gup_longterm_locked() is a wrapper for __get_user_pages_locked which
@@ -1567,49 +1535,28 @@ static long __gup_longterm_locked(struct task_struct *tsk,
 				  struct vm_area_struct **vmas,
 				  unsigned int gup_flags)
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
-				     vmas_tmp, NULL, gup_flags);
+				     vmas, NULL, gup_flags);
 
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
@@ -1621,7 +1568,7 @@ static __always_inline long __gup_longterm_locked(struct task_struct *tsk,
 	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
 				       NULL, flags);
 }
-#endif /* CONFIG_FS_DAX || CONFIG_CMA */
+#endif /* CONFIG_CMA */
 
 /*
  * This is the same as get_user_pages_remote(), just with a
@@ -1882,9 +1829,6 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			goto pte_unmap;
 
 		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
-				goto pte_unmap;
-
 			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
 			if (unlikely(!pgmap)) {
 				undo_dev_pagemap(nr, nr_start, pages);
@@ -2057,12 +2001,9 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	if (pmd_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
+	if (pmd_devmap(orig))
 		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr,
 					     flags);
-	}
 
 	refs = 0;
 	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
@@ -2101,12 +2042,9 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	if (pud_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
+	if (pud_devmap(orig))
 		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr,
 					     flags);
-	}
 
 	refs = 0;
 	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
