Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1569250039
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Aug 2020 16:55:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D4B51359E200;
	Mon, 24 Aug 2020 07:55:25 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=90.155.50.34; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 90B1A13596B73
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=PHm5fMNB8ZZgdRcktW4dLlLzoT8t70NROW9gjEwt3r8=; b=Cd1si9Xppq69WitlxSU+3lK401
	x5ocJ20OiXVPCUyr47XVUJE05GvIRgSpXShDd7Dx3dhVbkLPYWb+vXiJnWuR9JFvipXP+tVskYrtx
	/AqUQwtxGaRbYBcS25tanxCTzqyBrvEl3SAm2qCEAiY/xohFdRgrHUESaKlTdy1jvoqQkEMb+hinH
	SfbsHzJzKFEVeIdhw1HgGEKAe5YC+zFWGwnsjs3Pymeb/HgdSMbY068p1bX+a/HRJGB8yS4tDksJ3
	OOOIaOnZPhoxc83JrfwKcoPVnkVI0pLbgwmjlecZTt4donrJQUj5hzr+ROleN6OWLObS/xuJqzoWG
	SFHtlkDA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kADsR-0002mX-4j; Mon, 24 Aug 2020 14:55:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/9] iomap: Convert write_count to byte count
Date: Mon, 24 Aug 2020 15:55:08 +0100
Message-Id: <20200824145511.10500-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824145511.10500-1-willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: KJ2TJ32B2NRLMLF43W4XDMCEVYZZ255U
X-Message-ID-Hash: KJ2TJ32B2NRLMLF43W4XDMCEVYZZ255U
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KJ2TJ32B2NRLMLF43W4XDMCEVYZZ255U/>
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
 fs/iomap/buffered-io.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c9b44f86d166..8c6187a6f34e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1050,7 +1050,7 @@ EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
 static void
 iomap_finish_page_writeback(struct inode *inode, struct page *page,
-		int error)
+		int error, unsigned int len)
 {
 	struct iomap_page *iop = to_iomap_page(page);
 
@@ -1062,7 +1062,7 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
 	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
 
-	if (!iop || atomic_dec_and_test(&iop->write_count))
+	if (!iop || atomic_sub_and_test(len, &iop->write_count))
 		end_page_writeback(page);
 }
 
@@ -1096,7 +1096,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
 		/* walk each page on bio, ending page IO on them */
 		bio_for_each_segment_all(bv, bio, iter_all)
-			iomap_finish_page_writeback(inode, bv->bv_page, error);
+			iomap_finish_page_writeback(inode, bv->bv_page, error,
+					bv->bv_len);
 		bio_put(bio);
 	}
 	/* The ioend has been freed by bio_put() */
@@ -1312,8 +1313,8 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 
 	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
 			&same_page);
-	if (iop && !same_page)
-		atomic_inc(&iop->write_count);
+	if (iop)
+		atomic_add(len, &iop->write_count);
 
 	if (!merged) {
 		if (bio_full(wpc->ioend->io_bio, len)) {
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
