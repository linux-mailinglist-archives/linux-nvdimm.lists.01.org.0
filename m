Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB536968
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 03:45:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A42DE21290D2A;
	Wed,  5 Jun 2019 18:45:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6EC9D2128DD5C
 for <linux-nvdimm@lists.01.org>; Wed,  5 Jun 2019 18:45:16 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jun 2019 18:45:15 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:45:14 -0700
From: ira.weiny@intel.com
To: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
 "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
 Dave Chinner <david@fromorbit.com>
Subject: [PATCH RFC 04/10] mm/gup: Ensure F_LAYOUT lease is held prior to
 GUP'ing pages
Date: Wed,  5 Jun 2019 18:45:37 -0700
Message-Id: <20190606014544.8339-5-ira.weiny@intel.com>
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

On FS DAX files users must inform the file system they intend to take
long term GUP pins on the file pages.  Failure to do so should result in
an error.

Ensure that a F_LAYOUT lease exists at the time the GUP call is made.
If not return EPERM.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/locks.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h |  2 ++
 mm/gup.c           | 25 +++++++++++++++++++++++++
 mm/huge_memory.c   | 12 ++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index de9761c068de..43f5dc97652c 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2945,3 +2945,44 @@ static int __init filelock_init(void)
 	return 0;
 }
 core_initcall(filelock_init);
+
+/**
+ * mapping_inode_has_layout()
+ * @page page we are trying to GUP
+ *
+ * This should only be called on DAX pages.  DAX pages which are mapped through
+ * FS DAX do not use the page cache.  As a result they require the user to take
+ * a LAYOUT lease on them prior to be able to pin them for longterm use.
+ * This allows the user to opt-into the fact that truncation operations will
+ * fail for the duration of the pin.
+ *
+ * @Return true if the page has a LAYOUT lease associated with it's file.
+ */
+bool mapping_inode_has_layout(struct page *page)
+{
+	bool ret = false;
+	struct inode *inode;
+	struct file_lock *fl;
+	struct file_lock_context *ctx;
+
+	if (WARN_ON(PageAnon(page)) ||
+	    WARN_ON(!page) ||
+	    WARN_ON(!page->mapping) ||
+	    WARN_ON(!page->mapping->host))
+		return false;
+
+	inode = page->mapping->host;
+
+	ctx = locks_get_lock_context(inode, F_RDLCK);
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+		if (fl->fl_flags & FL_LAYOUT) {
+			ret = true;
+			break;
+		}
+	}
+	spin_unlock(&ctx->flc_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mapping_inode_has_layout);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc373a9b69fc..432b004b920c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1630,6 +1630,8 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 int get_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
 
+bool mapping_inode_has_layout(struct page *page);
+
 /* Container for pinned pfns / pages */
 struct frame_vector {
 	unsigned int nr_allocated;	/* Number of frames we have space for */
diff --git a/mm/gup.c b/mm/gup.c
index 26a7a3a3a657..d06cc5b14c0b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -361,6 +361,13 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
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
@@ -1905,6 +1912,16 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 
 		VM_BUG_ON_PAGE(compound_head(page) != head, page);
 
+		if (pte_devmap(pte) &&
+		    unlikely(flags & FOLL_LONGTERM) &&
+		    pgmap->type == MEMORY_DEVICE_FS_DAX &&
+		    !mapping_inode_has_layout(head)) {
+			mod_node_page_state(page_pgdat(head),
+					    NR_GUP_FAST_PAGE_BACKOFFS, 1);
+			put_user_page(head);
+			goto pte_unmap;
+		}
+
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		(*nr)++;
@@ -1955,6 +1972,14 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 		}
 		SetPageReferenced(page);
 		pages[*nr] = page;
+
+		if (unlikely(flags & FOLL_LONGTERM) &&
+		    pgmap->type == MEMORY_DEVICE_FS_DAX &&
+		    !mapping_inode_has_layout(page)) {
+			undo_dev_pagemap(nr, nr_start, pages);
+			return 0;
+		}
+
 		if (try_get_gup_pin_page(page, NR_GUP_FAST_PAGES_REQUESTED)) {
 			undo_dev_pagemap(nr, nr_start, pages);
 			return 0;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bb7fd7fa6f77..cdc213e50902 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -950,6 +950,12 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
+
+	if (unlikely(flags & FOLL_LONGTERM) &&
+	    (*pgmap)->type == MEMORY_DEVICE_FS_DAX &&
+	    !mapping_inode_has_layout(page))
+		return ERR_PTR(-EPERM);
+
 	if (unlikely(!try_get_gup_pin_page(page,
 					   NR_GUP_SLOW_PAGES_REQUESTED)))
 		page = ERR_PTR(-ENOMEM);
@@ -1092,6 +1098,12 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
+
+	if (unlikely(flags & FOLL_LONGTERM) &&
+	    (*pgmap)->type == MEMORY_DEVICE_FS_DAX &&
+	    !mapping_inode_has_layout(page))
+		return ERR_PTR(-EPERM);
+
 	if (unlikely(!try_get_gup_pin_page(page,
 					   NR_GUP_SLOW_PAGES_REQUESTED)))
 		page = ERR_PTR(-ENOMEM);
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
