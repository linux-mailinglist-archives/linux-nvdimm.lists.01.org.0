Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABAA8864D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Aug 2019 00:58:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8184421314759;
	Fri,  9 Aug 2019 16:01:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 585482131BA53
 for <linux-nvdimm@lists.01.org>; Fri,  9 Aug 2019 16:01:28 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:58:46 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; d="scan'208";a="204067068"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:58:46 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 04/19] mm/gup: Ensure F_LAYOUT lease is held prior to
 GUP'ing pages
Date: Fri,  9 Aug 2019 15:58:18 -0700
Message-Id: <20190809225833.6657-5-ira.weiny@intel.com>
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

On FS DAX files users must inform the file system they intend to take
long term GUP pins on the file pages.  Failure to do so should result in
an error.

Ensure that a F_LAYOUT lease exists at the time the GUP call is made.
If not return EPERM.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC v1:

    The old version had remnants of when GUP was going to take the lease
    for the user.  Remove this prototype code.
    Fix issue in gup_device_huge which was setting page reference prior
    to checking for Layout Lease
    Re-base to 5.3+
    Clean up htmldoc comments

 fs/locks.c         | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h |  2 ++
 mm/gup.c           | 23 +++++++++++++++++++++++
 mm/huge_memory.c   | 12 ++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 0c7359cdab92..14892c84844b 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2971,3 +2971,50 @@ static int __init filelock_init(void)
 	return 0;
 }
 core_initcall(filelock_init);
+
+/**
+ * mapping_inode_has_layout - ensure a file mapped page has a layout lease
+ * taken
+ * @page: page we are trying to GUP
+ *
+ * This should only be called on DAX pages.  DAX pages which are mapped through
+ * FS DAX do not use the page cache.  As a result they require the user to take
+ * a LAYOUT lease on them prior to be able to pin them for longterm use.
+ * This allows the user to opt-into the fact that truncation operations will
+ * fail for the duration of the pin.
+ *
+ * Return true if the page has a LAYOUT lease associated with it's file.
+ */
+bool mapping_inode_has_layout(struct page *page)
+{
+	bool ret = false;
+	struct inode *inode;
+	struct file_lock *fl;
+
+	if (WARN_ON(PageAnon(page)) ||
+	    WARN_ON(!page) ||
+	    WARN_ON(!page->mapping) ||
+	    WARN_ON(!page->mapping->host))
+		return false;
+
+	inode = page->mapping->host;
+
+	smp_mb();
+	if (inode->i_flctx &&
+	    !list_empty_careful(&inode->i_flctx->flc_lease)) {
+		spin_lock(&inode->i_flctx->flc_lock);
+		ret = false;
+		list_for_each_entry(fl, &inode->i_flctx->flc_lease, fl_list) {
+			if (fl->fl_pid == current->tgid &&
+			    (fl->fl_flags & FL_LAYOUT) &&
+			    (fl->fl_flags & FL_EXCLUSIVE)) {
+				ret = true;
+				break;
+			}
+		}
+		spin_unlock(&inode->i_flctx->flc_lock);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mapping_inode_has_layout);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad6766a08f9b..04f22722b374 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1583,6 +1583,8 @@ int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 			struct task_struct *task, bool bypass_rlim);
 
+bool mapping_inode_has_layout(struct page *page);
+
 /* Container for pinned pfns / pages */
 struct frame_vector {
 	unsigned int nr_allocated;	/* Number of frames we have space for */
diff --git a/mm/gup.c b/mm/gup.c
index 80423779a50a..0b05e22ac05f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -221,6 +221,13 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			page = pte_page(pte);
 		else
 			goto no_page;
+
+		if (unlikely(flags & FOLL_LONGTERM) &&
+		    (*pgmap)->type == MEMORY_DEVICE_FS_DAX &&
+		    !mapping_inode_has_layout(page)) {
+			page = ERR_PTR(-EPERM);
+			goto out;
+		}
 	} else if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
 			/* Avoid special (like zero) pages in core dumps */
@@ -1847,6 +1854,14 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 
 		VM_BUG_ON_PAGE(compound_head(page) != head, page);
 
+		if (pte_devmap(pte) &&
+		    unlikely(flags & FOLL_LONGTERM) &&
+		    pgmap->type == MEMORY_DEVICE_FS_DAX &&
+		    !mapping_inode_has_layout(head)) {
+			put_user_page(head);
+			goto pte_unmap;
+		}
+
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		(*nr)++;
@@ -1895,6 +1910,14 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 			undo_dev_pagemap(nr, nr_start, pages);
 			return 0;
 		}
+
+		if (unlikely(flags & FOLL_LONGTERM) &&
+		    pgmap->type == MEMORY_DEVICE_FS_DAX &&
+		    !mapping_inode_has_layout(page)) {
+			undo_dev_pagemap(nr, nr_start, pages);
+			return 0;
+		}
+
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		get_page(page);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1334ede667a8..bc1a07a55be1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -953,6 +953,12 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
+
+	if (unlikely(flags & FOLL_LONGTERM) &&
+	    (*pgmap)->type == MEMORY_DEVICE_FS_DAX &&
+	    !mapping_inode_has_layout(page))
+		return ERR_PTR(-EPERM);
+
 	get_page(page);
 
 	return page;
@@ -1093,6 +1099,12 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
+
+	if (unlikely(flags & FOLL_LONGTERM) &&
+	    (*pgmap)->type == MEMORY_DEVICE_FS_DAX &&
+	    !mapping_inode_has_layout(page))
+		return ERR_PTR(-EPERM);
+
 	get_page(page);
 
 	return page;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
