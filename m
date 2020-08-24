Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 669DB25003A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Aug 2020 16:55:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4ABFE1359E204;
	Mon, 24 Aug 2020 07:55:26 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=90.155.50.34; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9277013596B75
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Rhv5QEQPezgVV3tetynnY4/DOAHp31mkbEkGZ1QaUS4=; b=Nk7dZB8P6+HWX4yEqPImukdi8W
	adMlOJv0YwCXJ4INpqzmJ4MxIHPccVUIVxVWAIDqvHwMuFAsEzGxKZEtDbQQW/6hBDJk8Niesx2nt
	y2kYDHCDnrow1NxpMWcEQxStBAU1JVppPJ8RT0dQi8M/V5g8oFlCyE2f1WEFNHCH9vlWee5zcAVBr
	HfpefY0ohKCeTFpSjIGKoVW9+9VtRulF+HEco0vWjt7cP4bM3sxcSLQBsxf6rvbyucO71xmG0dz8b
	8Ne7rin749OibOzIMgN7qTrW6SltMEsxg8GZ0wrnZXCTLJRvuo8XzbROVJayJSvihIcZm9cgqx3Ai
	icv5amrg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kADsQ-0002mO-OI; Mon, 24 Aug 2020 14:55:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/9] iomap: Convert read_count to byte count
Date: Mon, 24 Aug 2020 15:55:07 +0100
Message-Id: <20200824145511.10500-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824145511.10500-1-willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: ZECMN57DRPLQEX66JYISI6ESOJV2X464
X-Message-ID-Hash: ZECMN57DRPLQEX66JYISI6ESOJV2X464
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZECMN57DRPLQEX66JYISI6ESOJV2X464/>
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
 fs/iomap/buffered-io.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 844e95cacea8..c9b44f86d166 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -161,13 +161,6 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
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
@@ -181,7 +174,8 @@ iomap_read_page_end_io(struct bio_vec *bvec, int error)
 		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
 	}
 
-	iomap_read_finish(iop, page);
+	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_count))
+		unlock_page(page);
 }
 
 static void
@@ -269,20 +263,17 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	if (ctx->bio && bio_end_sector(ctx->bio) == sector)
 		is_contig = true;
 
-	if (is_contig &&
-	    __bio_try_merge_page(ctx->bio, page, plen, poff, &same_page)) {
-		if (!same_page && iop)
-			atomic_inc(&iop->read_count);
-		goto done;
-	}
-
 	/*
-	 * If we start a new segment we need to increase the read count, and we
-	 * need to do so before submitting any previous full bio to make sure
-	 * that we don't prematurely unlock the page.
+	 * We need to increase the read count before submitting any
+	 * previous bio to make sure that we don't prematurely unlock
+	 * the page.
 	 */
 	if (iop)
-		atomic_inc(&iop->read_count);
+		atomic_add(plen, &iop->read_count);
+
+	if (is_contig &&
+	    __bio_try_merge_page(ctx->bio, page, plen, poff, &same_page))
+		goto done;
 
 	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
