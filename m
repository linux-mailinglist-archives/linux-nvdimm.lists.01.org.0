Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACD6250038
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Aug 2020 16:55:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E595613596B7A;
	Mon, 24 Aug 2020 07:55:23 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=90.155.50.34; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8EB1F13595DB4
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9t5Nd6itfXneJoCG+4+nlOQPHaX5dotOdJBb6HG6NCQ=; b=CisPEMtyv9tHJ8UXhEjITSj6ro
	e55s5UhIYB9KqOc0tY7ShmdbSSODyCcIGIv56v/qFmbGtSzJpV8lU+uTTyzThFKH8onX15DBFgokQ
	6Pr334cFBhSX34CWshalSFv2drBRGB2bRqemwBS/UGUz2S8kAHPRFda8gauJIjZOsm1//3GVVeC+w
	6uJ53dj4fYOjll48a6T1b3hjthIGtWdsXQO05I6X8bXrgCYqMXblLL+N0fpyvXt2bdVTERlSTP/9w
	kn4ziZ+OVhYtBgG7xC4azdO4De+orNL9OCGXJgeZ1ZHdF9TXTMucj+w1r7T4N4SUqMGAkff4YBaIw
	U99ubkdg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kADsP-0002lz-8X; Mon, 24 Aug 2020 14:55:13 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] fs: Introduce i_blocks_per_page
Date: Mon, 24 Aug 2020 15:55:03 +0100
Message-Id: <20200824145511.10500-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824145511.10500-1-willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: 5AIAVLJHJC4WALZU6CPUIMM6S6FIZ63L
X-Message-ID-Hash: 5AIAVLJHJC4WALZU6CPUIMM6S6FIZ63L
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5AIAVLJHJC4WALZU6CPUIMM6S6FIZ63L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This helper is useful for both THPs and for supporting block size larger
than page size.  Convert all users that I could find (we have a few
different ways of writing this idiom, and I may have missed some).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c  |  8 ++++----
 fs/jfs/jfs_metapage.c   |  2 +-
 fs/xfs/xfs_aops.c       |  2 +-
 include/linux/pagemap.h | 16 ++++++++++++++++
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cffd575e57b6..13d5cdab8dcd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -46,7 +46,7 @@ iomap_page_create(struct inode *inode, struct page *page)
 {
 	struct iomap_page *iop = to_iomap_page(page);
 
-	if (iop || i_blocksize(inode) == PAGE_SIZE)
+	if (iop || i_blocks_per_page(inode, page) <= 1)
 		return iop;
 
 	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
@@ -147,7 +147,7 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	unsigned int i;
 
 	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
+	for (i = 0; i < i_blocks_per_page(inode, page); i++) {
 		if (i >= first && i <= last)
 			set_bit(i, iop->uptodate);
 		else if (!test_bit(i, iop->uptodate))
@@ -1078,7 +1078,7 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
 		mapping_set_error(inode->i_mapping, -EIO);
 	}
 
-	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
+	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
 
 	if (!iop || atomic_dec_and_test(&iop->write_count))
@@ -1374,7 +1374,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
-	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
+	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
 
 	/*
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index a2f5338a5ea1..176580f54af9 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -473,7 +473,7 @@ static int metapage_readpage(struct file *fp, struct page *page)
 	struct inode *inode = page->mapping->host;
 	struct bio *bio = NULL;
 	int block_offset;
-	int blocks_per_page = PAGE_SIZE >> inode->i_blkbits;
+	int blocks_per_page = i_blocks_per_page(inode, page);
 	sector_t page_start;	/* address of page in fs blocks */
 	sector_t pblock;
 	int xlen;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b35611882ff9..55d126d4e096 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -544,7 +544,7 @@ xfs_discard_page(
 			page, ip->i_ino, offset);
 
 	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
-			PAGE_SIZE / i_blocksize(inode));
+			i_blocks_per_page(inode, page));
 	if (error && !XFS_FORCED_SHUTDOWN(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7de11dcd534d..853733286138 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -899,4 +899,20 @@ static inline int page_mkwrite_check_truncate(struct page *page,
 	return offset;
 }
 
+/**
+ * i_blocks_per_page - How many blocks fit in this page.
+ * @inode: The inode which contains the blocks.
+ * @page: The page (head page if the page is a THP).
+ *
+ * If the block size is larger than the size of this page, return zero.
+ *
+ * Context: The caller should hold a refcount on the page to prevent it
+ * from being split.
+ * Return: The number of filesystem blocks covered by this page.
+ */
+static inline
+unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
+{
+	return thp_size(page) >> inode->i_blkbits;
+}
 #endif /* _LINUX_PAGEMAP_H */
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
