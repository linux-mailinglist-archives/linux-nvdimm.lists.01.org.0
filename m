Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1A688657
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Aug 2019 00:59:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 46C302131474B;
	Fri,  9 Aug 2019 16:01:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DE3D621309DCA
 for <linux-nvdimm@lists.01.org>; Fri,  9 Aug 2019 16:01:42 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:59:01 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; d="scan'208";a="186799457"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:59:00 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 12/19] mm/gup: Prep put_user_pages() to take an
 vaddr_pin struct
Date: Fri,  9 Aug 2019 15:58:26 -0700
Message-Id: <20190809225833.6657-13-ira.weiny@intel.com>
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

Once callers start to use vaddr_pin the put_user_pages calls will need
to have access to this data coming in.  Prep put_user_pages() for this
data.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/mm.h |  20 +-------
 mm/gup.c           | 122 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 88 insertions(+), 54 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index befe150d17be..9d37cafbef9a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1064,25 +1064,7 @@ static inline void put_page(struct page *page)
 		__put_page(page);
 }
 
-/**
- * put_user_page() - release a gup-pinned page
- * @page:            pointer to page to be released
- *
- * Pages that were pinned via get_user_pages*() must be released via
- * either put_user_page(), or one of the put_user_pages*() routines
- * below. This is so that eventually, pages that are pinned via
- * get_user_pages*() can be separately tracked and uniquely handled. In
- * particular, interactions with RDMA and filesystems need special
- * handling.
- *
- * put_user_page() and put_page() are not interchangeable, despite this early
- * implementation that makes them look the same. put_user_page() calls must
- * be perfectly matched up with get_user_page() calls.
- */
-static inline void put_user_page(struct page *page)
-{
-	put_page(page);
-}
+void put_user_page(struct page *page);
 
 void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 			       bool make_dirty);
diff --git a/mm/gup.c b/mm/gup.c
index a7a9d2f5278c..10cfd30ff668 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -24,30 +24,41 @@
 
 #include "internal.h"
 
-/**
- * put_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
- * @pages:  array of pages to be maybe marked dirty, and definitely released.
- * @npages: number of pages in the @pages array.
- * @make_dirty: whether to mark the pages dirty
- *
- * "gup-pinned page" refers to a page that has had one of the get_user_pages()
- * variants called on that page.
- *
- * For each page in the @pages array, make that page (or its head page, if a
- * compound page) dirty, if @make_dirty is true, and if the page was previously
- * listed as clean. In any case, releases all pages using put_user_page(),
- * possibly via put_user_pages(), for the non-dirty case.
- *
- * Please see the put_user_page() documentation for details.
- *
- * set_page_dirty_lock() is used internally. If instead, set_page_dirty() is
- * required, then the caller should a) verify that this is really correct,
- * because _lock() is usually required, and b) hand code it:
- * set_page_dirty_lock(), put_user_page().
- *
- */
-void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
-			       bool make_dirty)
+static void __put_user_page(struct vaddr_pin *vaddr_pin, struct page *page)
+{
+	page = compound_head(page);
+
+	/*
+	 * For devmap managed pages we need to catch refcount transition from
+	 * GUP_PIN_COUNTING_BIAS to 1, when refcount reach one it means the
+	 * page is free and we need to inform the device driver through
+	 * callback. See include/linux/memremap.h and HMM for details.
+	 */
+	if (put_devmap_managed_page(page))
+		return;
+
+	if (put_page_testzero(page))
+		__put_page(page);
+}
+
+static void __put_user_pages(struct vaddr_pin *vaddr_pin, struct page **pages,
+			     unsigned long npages)
+{
+	unsigned long index;
+
+	/*
+	 * TODO: this can be optimized for huge pages: if a series of pages is
+	 * physically contiguous and part of the same compound page, then a
+	 * single operation to the head page should suffice.
+	 */
+	for (index = 0; index < npages; index++)
+		__put_user_page(vaddr_pin, pages[index]);
+}
+
+static void __put_user_pages_dirty_lock(struct vaddr_pin *vaddr_pin,
+					struct page **pages,
+					unsigned long npages,
+					bool make_dirty)
 {
 	unsigned long index;
 
@@ -58,7 +69,7 @@ void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 	 */
 
 	if (!make_dirty) {
-		put_user_pages(pages, npages);
+		__put_user_pages(vaddr_pin, pages, npages);
 		return;
 	}
 
@@ -86,9 +97,58 @@ void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 		 */
 		if (!PageDirty(page))
 			set_page_dirty_lock(page);
-		put_user_page(page);
+		__put_user_page(vaddr_pin, page);
 	}
 }
+
+/**
+ * put_user_page() - release a gup-pinned page
+ * @page:            pointer to page to be released
+ *
+ * Pages that were pinned via get_user_pages*() must be released via
+ * either put_user_page(), or one of the put_user_pages*() routines
+ * below. This is so that eventually, pages that are pinned via
+ * get_user_pages*() can be separately tracked and uniquely handled. In
+ * particular, interactions with RDMA and filesystems need special
+ * handling.
+ *
+ * put_user_page() and put_page() are not interchangeable, despite this early
+ * implementation that makes them look the same. put_user_page() calls must
+ * be perfectly matched up with get_user_page() calls.
+ */
+void put_user_page(struct page *page)
+{
+	__put_user_page(NULL, page);
+}
+EXPORT_SYMBOL(put_user_page);
+
+/**
+ * put_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
+ * @pages:  array of pages to be maybe marked dirty, and definitely released.
+ * @npages: number of pages in the @pages array.
+ * @make_dirty: whether to mark the pages dirty
+ *
+ * "gup-pinned page" refers to a page that has had one of the get_user_pages()
+ * variants called on that page.
+ *
+ * For each page in the @pages array, make that page (or its head page, if a
+ * compound page) dirty, if @make_dirty is true, and if the page was previously
+ * listed as clean. In any case, releases all pages using put_user_page(),
+ * possibly via put_user_pages(), for the non-dirty case.
+ *
+ * Please see the put_user_page() documentation for details.
+ *
+ * set_page_dirty_lock() is used internally. If instead, set_page_dirty() is
+ * required, then the caller should a) verify that this is really correct,
+ * because _lock() is usually required, and b) hand code it:
+ * set_page_dirty_lock(), put_user_page().
+ *
+ */
+void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
+			       bool make_dirty)
+{
+	__put_user_pages_dirty_lock(NULL, pages, npages, make_dirty);
+}
 EXPORT_SYMBOL(put_user_pages_dirty_lock);
 
 /**
@@ -102,15 +162,7 @@ EXPORT_SYMBOL(put_user_pages_dirty_lock);
  */
 void put_user_pages(struct page **pages, unsigned long npages)
 {
-	unsigned long index;
-
-	/*
-	 * TODO: this can be optimized for huge pages: if a series of pages is
-	 * physically contiguous and part of the same compound page, then a
-	 * single operation to the head page should suffice.
-	 */
-	for (index = 0; index < npages; index++)
-		put_user_page(pages[index]);
+	__put_user_pages(NULL, pages, npages);
 }
 EXPORT_SYMBOL(put_user_pages);
 
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
