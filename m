Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC272655A9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 11 Sep 2020 01:47:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E00F513DCF685;
	Thu, 10 Sep 2020 16:47:29 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D942F13DCF66F
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=3NRZ9mRuxVTkFoTUITZkJOzyjhC6Qf6X2z+v5c8zFFY=; b=U6Eiw1+IKNIsYaYA2AEGILmHrz
	PPcx6lFKYWh+MzdSvdtztkRCnjxTRGpduRr6Lz9fTvzQuCPeekEoWn5dpT6Hx3tzH7SCWN/eGR2T7
	hJLOKSon0vdgI81lB0F47cOLLz5HyCU+ZqSaetOU7rpiBJF29UWS4huKWeYGmJLia30sxDEBKRv2P
	HEnCPWb705zyAUDNdNoOiS8YU6B4tDmlyobyUQP0e7XDIQLCWN4UQ/U1mEkCgJmo3g7/M+FJbLyEf
	LkRpbbEgaqEUeDJZlK4rJe5eFs1zfkSLLUE8JBdljlFbX+q4izqTZ3aoEmt4NIvJtpYF8spSK7fO5
	DaZfVUKw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGWHV-0001RZ-4x; Thu, 10 Sep 2020 23:47:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/9] iomap: Fix misplaced page flushing
Date: Fri, 11 Sep 2020 00:46:59 +0100
Message-Id: <20200910234707.5504-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200910234707.5504-1-willy@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: ZVYO7ZHWBF6STXAIVSUBPVAY6KI55BEA
X-Message-ID-Hash: ZVYO7ZHWBF6STXAIVSUBPVAY6KI55BEA
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZVYO7ZHWBF6STXAIVSUBPVAY6KI55BEA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If iomap_unshare_actor() unshares to an inline iomap, the page was
not being flushed.  block_write_end() and __iomap_write_end() already
contain flushes, so adding it to iomap_write_end_inline() seems like
the best place.  That means we can remove it from iomap_write_actor().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 897ab9a26a74..d81a9a86c5aa 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -717,6 +717,7 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
 	WARN_ON_ONCE(!PageUptodate(page));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
+	flush_dcache_page(page);
 	addr = kmap_atomic(page);
 	memcpy(iomap->inline_data + pos, addr + pos, copied);
 	kunmap_atomic(addr);
@@ -810,8 +811,6 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 
-		flush_dcache_page(page);
-
 		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
 				srcmap);
 		if (unlikely(status < 0))
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
