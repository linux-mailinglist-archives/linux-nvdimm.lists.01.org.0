Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E4D26559C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 11 Sep 2020 01:47:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B02913DCF66A;
	Thu, 10 Sep 2020 16:47:19 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C209213DCF66B
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WP2cPvRQ2Iyrw0S8nzMEBDANY5cJE6s8OG42laM1g3Q=; b=ucCJyhUZc4UdOxtdfOh3F4QKlR
	9wU+/1rqSAIT5Y2i+inbPju4AHXD4BaUjHQk7pQQV83FGlzTAv/3PGaan7Z2A8+4AVhqgunyin2kD
	r7G8gSO+kB+0uL4lrljEZv6dFpXfvnC2Ql2vJmiUf5WDjpRdm7VjvTZg3SnU9wHaBCgAVlJQZqiiA
	xWNp2Vsiyu5nauMCoAe0XGWRL8d4HvN5+TmeC3jqnFn7ViNZ7R16wvHCj2MyZ6q0HXU1pYwXB5BW7
	sbYiNNAXSkjypI9M2QjHzIgdlP/y4Y1a54lx4WMbjlxLzsS+jFV/M6vepPgNMVdKi81h1cLfqQ8Ne
	q/L6symw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGWHY-0001T3-K0; Thu, 10 Sep 2020 23:47:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 9/9] iomap: Change calling convention for zeroing
Date: Fri, 11 Sep 2020 00:47:07 +0100
Message-Id: <20200910234707.5504-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200910234707.5504-1-willy@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: RW5A2DOQVZ2RQIPS2RADYRHECDT24E4F
X-Message-ID-Hash: RW5A2DOQVZ2RQIPS2RADYRHECDT24E4F
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RW5A2DOQVZ2RQIPS2RADYRHECDT24E4F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Pass the full length to iomap_zero() and dax_iomap_zero(), and have
them return how many bytes they actually handled.  This is preparatory
work for handling THP, although it looks like DAX could actually take
advantage of it if there's a larger contiguous area.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/dax.c               | 13 ++++++-------
 fs/iomap/buffered-io.c | 33 +++++++++++++++------------------
 include/linux/dax.h    |  3 +--
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 994ab66a9907..6ad346352a8c 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1037,18 +1037,18 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 	return ret;
 }
 
-int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
-		   struct iomap *iomap)
+s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 {
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
 	long rc, id;
 	void *kaddr;
 	bool page_aligned = false;
-
+	unsigned offset = offset_in_page(pos);
+	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
 
 	if (IS_ALIGNED(sector << SECTOR_SHIFT, PAGE_SIZE) &&
-	    IS_ALIGNED(size, PAGE_SIZE))
+	    (size == PAGE_SIZE))
 		page_aligned = true;
 
 	rc = bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
@@ -1058,8 +1058,7 @@ int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
 	id = dax_read_lock();
 
 	if (page_aligned)
-		rc = dax_zero_page_range(iomap->dax_dev, pgoff,
-					 size >> PAGE_SHIFT);
+		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
 	else
 		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
 	if (rc < 0) {
@@ -1072,7 +1071,7 @@ int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
 		dax_flush(iomap->dax_dev, kaddr + offset, size);
 	}
 	dax_read_unlock(id);
-	return 0;
+	return size;
 }
 
 static loff_t
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cb25a7b70401..3e1eb40a73fd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -898,11 +898,13 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
-static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
-		unsigned bytes, struct iomap *iomap, struct iomap *srcmap)
+static s64 iomap_zero(struct inode *inode, loff_t pos, u64 length,
+		struct iomap *iomap, struct iomap *srcmap)
 {
 	struct page *page;
 	int status;
+	unsigned offset = offset_in_page(pos);
+	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
 
 	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap, srcmap);
 	if (status)
@@ -914,38 +916,33 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
 }
 
-static loff_t
-iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
+		loff_t length, void *data, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	bool *did_zero = data;
 	loff_t written = 0;
-	int status;
 
 	/* already zeroed?  we're done. */
 	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
-		return count;
+		return length;
 
 	do {
-		unsigned offset, bytes;
-
-		offset = offset_in_page(pos);
-		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
+		s64 bytes;
 
 		if (IS_DAX(inode))
-			status = dax_iomap_zero(pos, offset, bytes, iomap);
+			bytes = dax_iomap_zero(pos, length, iomap);
 		else
-			status = iomap_zero(inode, pos, offset, bytes, iomap,
-					srcmap);
-		if (status < 0)
-			return status;
+			bytes = iomap_zero(inode, pos, length, iomap, srcmap);
+		if (bytes < 0)
+			return bytes;
 
 		pos += bytes;
-		count -= bytes;
+		length -= bytes;
 		written += bytes;
 		if (did_zero)
 			*did_zero = true;
-	} while (count > 0);
+	} while (length > 0);
 
 	return written;
 }
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 6904d4e0b2e0..951a851a0481 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -214,8 +214,7 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
-int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
-			struct iomap *iomap);
+s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
