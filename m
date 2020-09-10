Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5226559D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 11 Sep 2020 01:47:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C757213DCF670;
	Thu, 10 Sep 2020 16:47:19 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BEA2713DCF667
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=yKigblpa2tyh1XESl254L9Rtb9cYGPhr3cjlXKAZqDM=; b=WHRNrx/UBTKK/QG4MTHPirwoJL
	djjona+4O24Bf8m/PosZtRAUBGTVYSGbBr74yGFLOkFVHzJzYlZ9ZYrQuTsHFGVIritUlTGIOOQwu
	oGJLAjacaGUyoOXr8P/XUi5JgOfl50pzh4ASFzj4uMl3p9+owYJS+zG+ctEnuvAAt4GeP65RcJBt5
	7UKNsZp0JrEGyTZkNrQ0CSuvIeY9JPrtF2ZCpiG9c4z/2nKaCnztxET6tuwFRNjb5Dg4tt+QBevgM
	+INj4d1+CyvEwR3kzPm2FAXIkQh7Z+QMSM6tsyjpClail2bGpAY6bOJwkuwh7Uf2GhXshOHZbKYYX
	3fR37KLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGWHX-0001SN-C1; Thu, 10 Sep 2020 23:47:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 6/9] iomap: Convert read_count to read_bytes_pending
Date: Fri, 11 Sep 2020 00:47:04 +0100
Message-Id: <20200910234707.5504-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200910234707.5504-1-willy@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: ZWBGKSZUXB3Z6NV6P5ZFLPC6UMRDEW64
X-Message-ID-Hash: ZWBGKSZUXB3Z6NV6P5ZFLPC6UMRDEW64
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZWBGKSZUXB3Z6NV6P5ZFLPC6UMRDEW64/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Instead of counting bio segments, count the number of bytes submitted.
This insulates us from the block layer's definition of what a 'same page'
is, which is not necessarily clear once THPs are involved.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9670c096b83e..1cf976a8e55c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -26,7 +26,7 @@
  * to track sub-page uptodate status and I/O completions.
  */
 struct iomap_page {
-	atomic_t		read_count;
+	atomic_t		read_bytes_pending;
 	atomic_t		write_count;
 	spinlock_t		uptodate_lock;
 	unsigned long		uptodate[];
@@ -72,7 +72,7 @@ iomap_page_release(struct page *page)
 
 	if (!iop)
 		return;
-	WARN_ON_ONCE(atomic_read(&iop->read_count));
+	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
 	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
 			PageUptodate(page));
@@ -167,13 +167,6 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 		SetPageUptodate(page);
 }
 
-static void
-iomap_read_finish(struct iomap_page *iop, struct page *page)
-{
-	if (!iop || atomic_dec_and_test(&iop->read_count))
-		unlock_page(page);
-}
-
 static void
 iomap_read_page_end_io(struct bio_vec *bvec, int error)
 {
@@ -187,7 +180,8 @@ iomap_read_page_end_io(struct bio_vec *bvec, int error)
 		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
 	}
 
-	iomap_read_finish(iop, page);
+	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
+		unlock_page(page);
 }
 
 static void
@@ -267,30 +261,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	}
 
 	ctx->cur_page_in_bio = true;
+	if (iop)
+		atomic_add(plen, &iop->read_bytes_pending);
 
-	/*
-	 * Try to merge into a previous segment if we can.
-	 */
+	/* Try to merge into a previous segment if we can */
 	sector = iomap_sector(iomap, pos);
-	if (ctx->bio && bio_end_sector(ctx->bio) == sector)
+	if (ctx->bio && bio_end_sector(ctx->bio) == sector) {
+		if (__bio_try_merge_page(ctx->bio, page, plen, poff,
+				&same_page))
+			goto done;
 		is_contig = true;
-
-	if (is_contig &&
-	    __bio_try_merge_page(ctx->bio, page, plen, poff, &same_page)) {
-		if (!same_page && iop)
-			atomic_inc(&iop->read_count);
-		goto done;
 	}
 
-	/*
-	 * If we start a new segment we need to increase the read count, and we
-	 * need to do so before submitting any previous full bio to make sure
-	 * that we don't prematurely unlock the page.
-	 */
-	if (iop)
-		atomic_inc(&iop->read_count);
-
-	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
+	if (!is_contig || bio_full(ctx->bio, plen)) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
