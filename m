Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 492B323BDF2
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Aug 2020 18:18:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 10D7B12A686DC;
	Tue,  4 Aug 2020 09:18:08 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0339C12976555
	for <linux-nvdimm@lists.01.org>; Tue,  4 Aug 2020 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+aj+hTcmyQ/ZxfRwwyhlTJL7pLaB+BkTSJfzBBgI/q8=; b=OHO238reNTCqUaIKEk+I2PVyf/
	8z9DmI82B4usqHm6Sy3qgsL1BcZnsELUqPX5VD6f8Alk7w07CcozvEfAWNalxZZ8CkY4NKVZVQ/Da
	CiufiKZyhaI2viUdnj08hu6WNWDmGz04xOh/lwGsbtGzT14Lc2QOud0vXTnJIw0Uy2PPFvPioXetF
	cEjX7iwUpdLCMPo/+2OHAZj7arwcfR/aQ2g7wkq7Xn5k6q2u4uj/2ucVzje1a7CqrEd1OnZIVLel/
	iWl9UMS/c71q2TlQnHwx/i8VjO9FoRh+ZBaHyZecTNSe/qMYq6nCUQ5XGe5+DGRGhGqRtm5BW/D+C
	pE9HMj8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2zdV-0002e1-IW; Tue, 04 Aug 2020 16:17:57 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] mm: Introduce and use page_cache_empty
Date: Tue,  4 Aug 2020 17:17:52 +0100
Message-Id: <20200804161755.10100-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804161755.10100-1-willy@infradead.org>
References: <20200804161755.10100-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: 3KTPDGLQVQ5V6SXZINFISJ7YBPDEDAKS
X-Message-ID-Hash: 3KTPDGLQVQ5V6SXZINFISJ7YBPDEDAKS
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3KTPDGLQVQ5V6SXZINFISJ7YBPDEDAKS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Instead of checking the two counters (nrpages and nrexceptional), we
can just check whether i_pages is empty.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/block_dev.c          |  2 +-
 fs/dax.c                |  2 +-
 include/linux/pagemap.h |  5 +++++
 mm/truncate.c           | 18 +++---------------
 4 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0ae656e022fd..2a77bd2c6144 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -79,7 +79,7 @@ static void kill_bdev(struct block_device *bdev)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
 
-	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
+	if (page_cache_empty(mapping))
 		return;
 
 	invalidate_bh_lrus();
diff --git a/fs/dax.c b/fs/dax.c
index 11b16729b86f..2f75ee2cd41f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -949,7 +949,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 	if (WARN_ON_ONCE(inode->i_blkbits != PAGE_SHIFT))
 		return -EIO;
 
-	if (!mapping->nrexceptional || wbc->sync_mode != WB_SYNC_ALL)
+	if (page_cache_empty(mapping) || wbc->sync_mode != WB_SYNC_ALL)
 		return 0;
 
 	trace_dax_writeback_range(inode, xas.xa_index, end_index);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 484a36185bb5..a474a92a2a72 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -18,6 +18,11 @@
 
 struct pagevec;
 
+static inline bool page_cache_empty(struct address_space *mapping)
+{
+	return xa_empty(&mapping->i_pages);
+}
+
 /*
  * Bits in mapping->flags.
  */
diff --git a/mm/truncate.c b/mm/truncate.c
index dd9ebc1da356..7c4c8ac140be 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -300,7 +300,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	pgoff_t		index;
 	int		i;
 
-	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
+	if (page_cache_empty(mapping))
 		goto out;
 
 	/* Offsets within partial pages */
@@ -488,9 +488,6 @@ EXPORT_SYMBOL(truncate_inode_pages);
  */
 void truncate_inode_pages_final(struct address_space *mapping)
 {
-	unsigned long nrexceptional;
-	unsigned long nrpages;
-
 	/*
 	 * Page reclaim can not participate in regular inode lifetime
 	 * management (can't call iput()) and thus can race with the
@@ -500,16 +497,7 @@ void truncate_inode_pages_final(struct address_space *mapping)
 	 */
 	mapping_set_exiting(mapping);
 
-	/*
-	 * When reclaim installs eviction entries, it increases
-	 * nrexceptional first, then decreases nrpages.  Make sure we see
-	 * this in the right order or we might miss an entry.
-	 */
-	nrpages = mapping->nrpages;
-	smp_rmb();
-	nrexceptional = mapping->nrexceptional;
-
-	if (nrpages || nrexceptional) {
+	if (!page_cache_empty(mapping)) {
 		/*
 		 * As truncation uses a lockless tree lookup, cycle
 		 * the tree lock to make sure any ongoing tree
@@ -692,7 +680,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	int ret2 = 0;
 	int did_range_unmap = 0;
 
-	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
+	if (page_cache_empty(mapping))
 		goto out;
 
 	pagevec_init(&pvec);
-- 
2.27.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
