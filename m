Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EC925003D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Aug 2020 16:56:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0826713596B7E;
	Mon, 24 Aug 2020 07:55:25 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=90.155.50.34; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 919F013596B74
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=FXPJTv0MWwG4T6+R292QY/E4XjNo/AbyMqIgbF0Fx5Y=; b=G/FnnbfBAYTOXmj8IjpHvip7oE
	EQl/50yDDCGaMj3hSxsH3q0WG8uXdqnGYifYpKkL6d3NQYIfOUtVlom2u5foggdr9XjpKziN1nOG+
	cik8oORwSvtL8QJ5uyyQUJF9q9AKX8O7t8nrSBqd2TY/r/TymYxyYrtljlz+swixEMnRVjH04S5ZM
	LxwyBLRZK8tjNawqDXQQ884rWbTiKqKZuPUqrhSqGc1Md+Y4YFssAMlkJLNgoykXmTQ3z7z59ekLf
	/9mLGPmtjhwL9GWxsQ5WT7lpZYCe0zAM8WGg+lW9+G+fNXS/BGSyQ5xOo9Sre6KMmgOaWWv3Ph1Cj
	lDbC3VAg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kADsR-0002mg-CF; Mon, 24 Aug 2020 14:55:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/9] iomap: Convert iomap_write_end types
Date: Mon, 24 Aug 2020 15:55:09 +0100
Message-Id: <20200824145511.10500-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824145511.10500-1-willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: LA63RHFRZTRXLIWBEJADJFKSRVOUVKFU
X-Message-ID-Hash: LA63RHFRZTRXLIWBEJADJFKSRVOUVKFU
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LA63RHFRZTRXLIWBEJADJFKSRVOUVKFU/>
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
---
 fs/iomap/buffered-io.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8c6187a6f34e..7f618ab4b11e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -666,9 +666,8 @@ iomap_set_page_dirty(struct page *page)
 }
 EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
 
-static int
-__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
-		unsigned copied, struct page *page)
+static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
+		size_t copied, struct page *page)
 {
 	flush_dcache_page(page);
 
@@ -690,9 +689,8 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	return copied;
 }
 
-static int
-iomap_write_end_inline(struct inode *inode, struct page *page,
-		struct iomap *iomap, loff_t pos, unsigned copied)
+static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
+		struct iomap *iomap, loff_t pos, size_t copied)
 {
 	void *addr;
 
@@ -708,13 +706,14 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
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
@@ -793,11 +792,8 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 
-		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
+		copied = iomap_write_end(inode, pos, bytes, copied, page, iomap,
 				srcmap);
-		if (unlikely(status < 0))
-			break;
-		copied = status;
 
 		cond_resched();
 
@@ -871,11 +867,8 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
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
