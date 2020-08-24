Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA8E25003F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Aug 2020 16:56:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 826111359E207;
	Mon, 24 Aug 2020 07:55:27 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=90.155.50.34; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EBA7D13595DB4
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=f+4HK1pbdrI+GZMocakT3270ISsveIlHdCnmjXaoHx8=; b=PGbnOU90Bl3xSTJD7AiRQYkpN8
	D/RTsnFTpXSiSIQmr6weLiXNoUHj9q2XOWQqd5jlRXHDFLL+fk9fSkh4jTwP5buiqNRPfdNYTSMC1
	IsSYrK2QQBFsyc0AXHb0E0u+Q+v0LecFNLBbE2KfzK0Aq18vGM0O36LVyZb5upCapRVKB2PiLx3Ut
	XK+sfPwkuo+4rrofM2VMAKDdJD1kN9eFG2FPjjSTz3H3INT5iCv6QEd0rpDh2ASl9EDf1k9L1sPWW
	Gvi5TXKsAJlbHUyCatxNrTq0mb8BjsG2/43zAGn4BzeOaIOZjQ7+AtOG/4zxXbKpnvKYp2X/dvrbc
	DldLKpKA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kADsP-0002m3-Ez; Mon, 24 Aug 2020 14:55:13 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/9] iomap: Use kzalloc to allocate iomap_page
Date: Mon, 24 Aug 2020 15:55:04 +0100
Message-Id: <20200824145511.10500-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824145511.10500-1-willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: BGTHGB7DYCR5JGIYGJCJUYXUQKEVUPT5
X-Message-ID-Hash: BGTHGB7DYCR5JGIYGJCJUYXUQKEVUPT5
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BGTHGB7DYCR5JGIYGJCJUYXUQKEVUPT5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We can skip most of the initialisation, although spinlocks still
need explicit initialisation as architectures may use a non-zero
value to indicate unlocked.  The comment is no longer useful as
attach_page_private() handles the refcount now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 13d5cdab8dcd..639d54a4177e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -49,16 +49,8 @@ iomap_page_create(struct inode *inode, struct page *page)
 	if (iop || i_blocks_per_page(inode, page) <= 1)
 		return iop;
 
-	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
-	atomic_set(&iop->read_count, 0);
-	atomic_set(&iop->write_count, 0);
+	iop = kzalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
 	spin_lock_init(&iop->uptodate_lock);
-	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
-
-	/*
-	 * migrate_page_move_mapping() assumes that pages with private data have
-	 * their count elevated by 1.
-	 */
 	attach_page_private(page, iop);
 	return iop;
 }
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
