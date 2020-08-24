Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B6B250037
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Aug 2020 16:55:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B45B13596B72;
	Mon, 24 Aug 2020 07:55:22 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=90.155.50.34; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DB9B13595DB2
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ubi2ubkSzmcUgKFA9Ty93Z77356b507gvbujH4zOh5I=; b=uxRmPdWXScdnVsVqrOytVE+3pX
	AfNakxy/jXMIeQk1mrNaeGszT7gwlzKTJW4zKApginebWwL+8a3GK4DkxG6e3qtrAe6OrV/rKKFoW
	WLNCWseG6+ZfPiG28STSAnIkkdgyq235kHqwtyi/vvSXY+y7bgCoAFnPzakWr6aGmDXahjy54ojPB
	iKqWCmjjJVSdMq9U0v1TgmYdal24DeOA1OsPiilA1dB1RlJ6PO11/ekIBoyS6VDi9neoy4W6nvdUh
	iLjbjh4KAsGEnlLZkShdZexS2paK0ywCcCD/CrO9rGrJhFXFnlTClKUaO0WHz77iQg6i2VilcP4LE
	lDXtmWtg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kADsP-0002m7-MX; Mon, 24 Aug 2020 14:55:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/9] iomap: Use bitmap ops to set uptodate bits
Date: Mon, 24 Aug 2020 15:55:05 +0100
Message-Id: <20200824145511.10500-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824145511.10500-1-willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: TILNVG4YIMNQVBXBYEPZ6N2PG4JLPLZC
X-Message-ID-Hash: TILNVG4YIMNQVBXBYEPZ6N2PG4JLPLZC
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TILNVG4YIMNQVBXBYEPZ6N2PG4JLPLZC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Now that the bitmap is protected by a spinlock, we can use the
more efficient bitmap ops instead of individual test/set bit ops.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 639d54a4177e..dbf9572dabe9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -134,19 +134,11 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	struct inode *inode = page->mapping->host;
 	unsigned first = off >> inode->i_blkbits;
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
-	bool uptodate = true;
 	unsigned long flags;
-	unsigned int i;
 
 	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	for (i = 0; i < i_blocks_per_page(inode, page); i++) {
-		if (i >= first && i <= last)
-			set_bit(i, iop->uptodate);
-		else if (!test_bit(i, iop->uptodate))
-			uptodate = false;
-	}
-
-	if (uptodate)
+	bitmap_set(iop->uptodate, first, last - first + 1);
+	if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
 		SetPageUptodate(page);
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
