Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0111B9AA3
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Apr 2020 10:48:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84E8A10FF7B7B;
	Mon, 27 Apr 2020 01:47:46 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id DDB991009F03D
	for <linux-nvdimm@lists.01.org>; Mon, 27 Apr 2020 01:47:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800";
   d="scan'208";a="90547650"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Apr 2020 16:48:31 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 7F8A84BCC89C;
	Mon, 27 Apr 2020 16:37:51 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Apr 2020 16:48:34 +0800
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Apr 2020 16:48:33 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 16:48:32 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>
Subject: [RFC PATCH 2/8] mm: add dax-rmap for memory-failure and rmap
Date: Mon, 27 Apr 2020 16:47:44 +0800
Message-ID: <20200427084750.136031-3-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 7F8A84BCC89C.A1BFC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: L3ANUNEMYLSBUCNYF3G7Y45KV6K7LNFL
X-Message-ID-Hash: L3ANUNEMYLSBUCNYF3G7Y45KV6K7LNFL
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L3ANUNEMYLSBUCNYF3G7Y45KV6K7LNFL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Memory-failure collects and kill processes who is accessing a posioned,
file mmapped page.  Add dax-rmap iteration to support reflink case.
Also add it for rmap iteration.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 mm/memory-failure.c | 63 +++++++++++++++++++++++++++++++++++----------
 mm/rmap.c           | 54 +++++++++++++++++++++++++++-----------
 2 files changed, 88 insertions(+), 29 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a96364be8ab4..6d7da1fd55fd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -463,36 +463,71 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 	page_unlock_anon_vma_read(av);
 }
 
+static void collect_each_procs_file(struct page *page,
+				    struct task_struct *task,
+				    struct list_head *to_kill)
+{
+	struct vm_area_struct *vma;
+	struct address_space *mapping = page->mapping;
+	struct rb_root_cached *root = (struct rb_root_cached *)page_private(page);
+	struct rb_node *node;
+	struct shared_file *shared;
+	pgoff_t pgoff;
+
+	if (dax_mapping(mapping) && root) {
+		struct shared_file save = {
+			.mapping = mapping,
+			.index = page->index,
+		};
+		for (node = rb_first_cached(root); node; node = rb_next(node)) {
+			shared = container_of(node, struct shared_file, node);
+			mapping = page->mapping = shared->mapping;
+			page->index = shared->index;
+			pgoff = page_to_pgoff(page);
+			vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff,
+						  pgoff) {
+				if (vma->vm_mm == task->mm) {
+					// each vma is unique, so is the vaddr.
+					add_to_kill(task, page, vma, to_kill);
+				}
+			}
+		}
+		// restore the mapping and index.
+		page->mapping = save.mapping;
+		page->index = save.index;
+	} else {
+		pgoff = page_to_pgoff(page);
+		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
+			/*
+			 * Send early kill signal to tasks where a vma covers
+			 * the page but the corrupted page is not necessarily
+			 * mapped it in its pte.
+			 * Assume applications who requested early kill want
+			 * to be informed of all such data corruptions.
+			 */
+			if (vma->vm_mm == task->mm)
+				add_to_kill(task, page, vma, to_kill);
+		}
+	}
+}
+
 /*
  * Collect processes when the error hit a file mapped page.
  */
 static void collect_procs_file(struct page *page, struct list_head *to_kill,
 				int force_early)
 {
-	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct address_space *mapping = page->mapping;
 
 	i_mmap_lock_read(mapping);
 	read_lock(&tasklist_lock);
 	for_each_process(tsk) {
-		pgoff_t pgoff = page_to_pgoff(page);
 		struct task_struct *t = task_early_kill(tsk, force_early);
 
 		if (!t)
 			continue;
-		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff,
-				      pgoff) {
-			/*
-			 * Send early kill signal to tasks where a vma covers
-			 * the page but the corrupted page is not necessarily
-			 * mapped it in its pte.
-			 * Assume applications who requested early kill want
-			 * to be informed of all such data corruptions.
-			 */
-			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
-		}
+		collect_each_procs_file(page, t, to_kill);
 	}
 	read_unlock(&tasklist_lock);
 	i_mmap_unlock_read(mapping);
diff --git a/mm/rmap.c b/mm/rmap.c
index f79a206b271a..69ea66f9e971 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1870,21 +1870,7 @@ static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
 		anon_vma_unlock_read(anon_vma);
 }
 
-/*
- * rmap_walk_file - do something to file page using the object-based rmap method
- * @page: the page to be handled
- * @rwc: control variable according to each walk type
- *
- * Find all the mappings of a page using the mapping pointer and the vma chains
- * contained in the address_space struct it points to.
- *
- * When called from try_to_munlock(), the mmap_sem of the mm containing the vma
- * where the page was found will be held for write.  So, we won't recheck
- * vm_flags for that VMA.  That should be OK, because that vma shouldn't be
- * LOCKED.
- */
-static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
-		bool locked)
+static void rmap_walk_file_one(struct page *page, struct rmap_walk_control *rwc, bool locked)
 {
 	struct address_space *mapping = page_mapping(page);
 	pgoff_t pgoff_start, pgoff_end;
@@ -1925,6 +1911,44 @@ static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
 		i_mmap_unlock_read(mapping);
 }
 
+/*
+ * rmap_walk_file - do something to file page using the object-based rmap method
+ * @page: the page to be handled
+ * @rwc: control variable according to each walk type
+ *
+ * Find all the mappings of a page using the mapping pointer and the vma chains
+ * contained in the address_space struct it points to.
+ *
+ * When called from try_to_munlock(), the mmap_sem of the mm containing the vma
+ * where the page was found will be held for write.  So, we won't recheck
+ * vm_flags for that VMA.  That should be OK, because that vma shouldn't be
+ * LOCKED.
+ */
+static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
+		bool locked)
+{
+	struct rb_root_cached *root = (struct rb_root_cached *)page_private(page);
+	struct rb_node *node;
+	struct shared_file *shared;
+
+	if (dax_mapping(page->mapping) && root) {
+		struct shared_file save = {
+			.mapping = page->mapping,
+			.index = page->index,
+		};
+		for (node = rb_first_cached(root); node; node = rb_next(node)) {
+			shared = container_of(node, struct shared_file, node);
+			page->mapping = shared->mapping;
+			page->index = shared->index;
+			rmap_walk_file_one(page, rwc, locked);
+		}
+		// restore the mapping and index.
+		page->mapping = save.mapping;
+		page->index = save.index;
+	} else
+		rmap_walk_file_one(page, rwc, locked);
+}
+
 void rmap_walk(struct page *page, struct rmap_walk_control *rwc)
 {
 	if (unlikely(PageKsm(page)))
-- 
2.26.2


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
