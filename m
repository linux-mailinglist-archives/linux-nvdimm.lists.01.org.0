Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E64250040
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Aug 2020 16:56:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B30211359E212;
	Mon, 24 Aug 2020 07:55:28 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=90.155.50.34; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0BE2413596B76
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pESaBZIQUbmTuqEp0QvjJ/1J69UiEMBwpDyvyHVUJqY=; b=pmIh7UfdQ7/LQD7SvCjLKXe2jy
	0wpFTf2dGM/ZnEtdSJ6epnFIKDfGNnUmnku83ljK6wvI7+Ma5sKSCeqldh0oMYxGDqhJ0VVWgJnAr
	YyJzxIouvgs33CASyOTuDV1IE5IsaqfkXgAMt8zOMVnRq1GwpJJAtVyGRlN7LHscQu423L4+u7ngi
	MA6urfnXaOMrQazL/Dmzgda2GTnaRR8SXJps6PnsT9FvflPmKRR2F38sm8X58SfTK0U8yVcJLfH3s
	hWnpZYdxqcumvCJs15ueYg11+t2L6Uq8w4XegKtsGHsJjONe3hX8+cDbjotp3oYfinH4VlGveQ0t7
	JqWe1kyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kADsO-0002lv-VY; Mon, 24 Aug 2020 14:55:13 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] iomap: Fix misplaced page flushing
Date: Mon, 24 Aug 2020 15:55:02 +0100
Message-Id: <20200824145511.10500-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824145511.10500-1-willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: MWD3JJEBCRFIJPOWJSSQH3JDG3C7KBIK
X-Message-ID-Hash: MWD3JJEBCRFIJPOWJSSQH3JDG3C7KBIK
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MWD3JJEBCRFIJPOWJSSQH3JDG3C7KBIK/>
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
---
 fs/iomap/buffered-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..cffd575e57b6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -715,6 +715,7 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
 {
 	void *addr;
 
+	flush_dcache_page(page);
 	WARN_ON_ONCE(!PageUptodate(page));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
@@ -811,8 +812,6 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
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
