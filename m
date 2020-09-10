Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653392655A0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 11 Sep 2020 01:47:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 187EE13DCF66C;
	Thu, 10 Sep 2020 16:47:21 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C05B813DCF669
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=toDCz/l3SOhSBoupdSkLKgKXvEF68cxVtDee4X76Z9c=; b=OlH9lbNA4yiWeUzny9lsfQuH1l
	ssaWKtnwNnGZ0V/EMvtGg3WkefT4zUtny7F3ViujFeMnZ6LR+GIIZngAQ8g22Ke7kCGScphc8tvKd
	WlobhHS4Pt8C5P0EIrzmVbII8Jw61GFSF634qo6Uli3BaX3gCyWV3v+ojhTxCWqkIqwj4/cDkVnfy
	VjErnsBNRmbm7u57Es7NEM0nZfjTKysQ1MOIFBsGym6rBgd6i/xGoW1oFmUYMGmPtBxfzkcqEy+e+
	/VlDhSefMf/8RkHoBPRh/BKUG9gpvpeGiaX4Qj5rdfK+giA8/sKzyJwX5ZGTKv0yZSRETCJxpZ9EJ
	I7LN8tUw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGWHY-0001Sl-6l; Thu, 10 Sep 2020 23:47:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 8/9] iomap: Convert iomap_write_end types
Date: Fri, 11 Sep 2020 00:47:06 +0100
Message-Id: <20200910234707.5504-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200910234707.5504-1-willy@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: MQW7WJ4ZNF7C3XUIH4QMAG7E5LHHQ4IU
X-Message-ID-Hash: MQW7WJ4ZNF7C3XUIH4QMAG7E5LHHQ4IU
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MQW7WJ4ZNF7C3XUIH4QMAG7E5LHHQ4IU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

iomap_write_end cannot return an error, so switch it to return
size_t instead of int and remove the error checking from the callers.
Also convert the arguments to size_t from unsigned int, in case anyone
ever wants to support a page size larger than 2GB.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 64a5cb383f30..cb25a7b70401 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -663,9 +663,8 @@ iomap_set_page_dirty(struct page *page)
 }
 EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
 
-static int
-__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
-		unsigned copied, struct page *page)
+static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
+		size_t copied, struct page *page)
 {
 	flush_dcache_page(page);
 
@@ -687,9 +686,8 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	return copied;
 }
 
-static int
-iomap_write_end_inline(struct inode *inode, struct page *page,
-		struct iomap *iomap, loff_t pos, unsigned copied)
+static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
+		struct iomap *iomap, loff_t pos, size_t copied)
 {
 	void *addr;
 
@@ -705,13 +703,14 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
 	return copied;
 }
 
-static int
-iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
-		struct page *page, struct iomap *iomap, struct iomap *srcmap)
+/* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
+static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
+		size_t copied, struct page *page, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
 	loff_t old_size = inode->i_size;
-	int ret;
+	size_t ret;
 
 	if (srcmap->type == IOMAP_INLINE) {
 		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
@@ -790,11 +789,8 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 
-		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
+		copied = iomap_write_end(inode, pos, bytes, copied, page, iomap,
 				srcmap);
-		if (unlikely(status < 0))
-			break;
-		copied = status;
 
 		cond_resched();
 
@@ -868,11 +864,8 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
 				srcmap);
-		if (unlikely(status <= 0)) {
-			if (WARN_ON_ONCE(status == 0))
-				return -EIO;
-			return status;
-		}
+		if (WARN_ON_ONCE(status == 0))
+			return -EIO;
 
 		cond_resched();
 
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
