Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E725003C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Aug 2020 16:55:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD53C13596B75;
	Mon, 24 Aug 2020 07:55:23 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=90.155.50.34; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FD9B13596B72
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9sNccJdPyEbTq9E4xOD6JGVZQFar23C46DP4Q4DsSw4=; b=OSoW8XcxhdHrACKsK9qizhgDOp
	qHb9038W/jySLdqA3g+T3JeWvwBGRkGq4UMTBX25b+n2wm2I/BiD3NO9o7oax2xy9MXfeSEEOai1d
	JZ0r5uqgBjxb3Xv79/hba6DvK2bqqyAySxeo867550kp1oPXr/aP8xojdrjY8uF8n3Ol1DHOPvTJn
	ztFuggpN1k8lsGbJOe0nSGJxG2xS1MeCizwDb1cGwaxp2+Tm/v+geVJXqmdPrpkggUV9a5Y9gG/NH
	yXa0ixtnDvUjyldnKQFNRjgpY6DyqRgoTLXY2Qclg617/E0FF4WROxh9niSHFwE6aNH4fKZlOoJay
	/Dp5c3Aw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kADsQ-0002mD-GI; Mon, 24 Aug 2020 14:55:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] iomap: Support arbitrarily many blocks per page
Date: Mon, 24 Aug 2020 15:55:06 +0100
Message-Id: <20200824145511.10500-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824145511.10500-1-willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: 33P7V6GL4OWUKZ6GLHZOUSHJNVP6USET
X-Message-ID-Hash: 33P7V6GL4OWUKZ6GLHZOUSHJNVP6USET
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/33P7V6GL4OWUKZ6GLHZOUSHJNVP6USET/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Size the uptodate array dynamically to support larger pages in the
page cache.  With a 64kB page, we're only saving 8 bytes per page today,
but with a 2MB maximum page size, we'd have to allocate more than 4kB
per page.  Add a few debugging assertions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dbf9572dabe9..844e95cacea8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -22,18 +22,19 @@
 #include "../internal.h"
 
 /*
- * Structure allocated for each page when block size < PAGE_SIZE to track
+ * Structure allocated for each page when block size < page size to track
  * sub-page uptodate status and I/O completions.
  */
 struct iomap_page {
 	atomic_t		read_count;
 	atomic_t		write_count;
 	spinlock_t		uptodate_lock;
-	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
+	unsigned long		uptodate[];
 };
 
 static inline struct iomap_page *to_iomap_page(struct page *page)
 {
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
 	if (page_has_private(page))
 		return (struct iomap_page *)page_private(page);
 	return NULL;
@@ -45,11 +46,13 @@ static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
 	struct iomap_page *iop = to_iomap_page(page);
+	unsigned int nr_blocks = i_blocks_per_page(inode, page);
 
-	if (iop || i_blocks_per_page(inode, page) <= 1)
+	if (iop || nr_blocks <= 1)
 		return iop;
 
-	iop = kzalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
+	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
+			GFP_NOFS | __GFP_NOFAIL);
 	spin_lock_init(&iop->uptodate_lock);
 	attach_page_private(page, iop);
 	return iop;
@@ -59,11 +62,14 @@ static void
 iomap_page_release(struct page *page)
 {
 	struct iomap_page *iop = detach_page_private(page);
+	unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
 
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_count));
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
+	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+			PageUptodate(page));
 	kfree(iop);
 }
 
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
