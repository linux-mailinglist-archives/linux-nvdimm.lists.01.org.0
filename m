Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB761510AB
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Feb 2020 21:01:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 851FE10FC337A;
	Mon,  3 Feb 2020 12:04:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 31ABC10FC3374
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 12:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1580760054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxbWiCAn4qzNWGzInygE6oJMfXNXSLmxv5Z+XX2YjiM=;
	b=Gnow+liDE+uygCdRhfXiOwFreEarG0t8h3deJ8EaoeXwJPYQE1AIzOUp0vbAnDI+Krr8Tm
	vR0pVymgR1M0pVctesfNZhWjYENSKjJsLUBjODTF5mzYPVd508PQMNB+dQVlkvfUAwyKs8
	efMB82ods2IV6HdmUtPWQiMHXI7zIQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-1o3bk_lWMSKbfqaHjQvukw-1; Mon, 03 Feb 2020 15:00:51 -0500
X-MC-Unique: 1o3bk_lWMSKbfqaHjQvukw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A51121005502;
	Mon,  3 Feb 2020 20:00:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6CB865C1B5;
	Mon,  3 Feb 2020 20:00:49 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 22CDD224750; Mon,  3 Feb 2020 15:00:46 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com,
	hch@infradead.org
Subject: [PATCH 5/5] dax,iomap: Add helper dax_iomap_zero() to zero a range
Date: Mon,  3 Feb 2020 15:00:29 -0500
Message-Id: <20200203200029.4592-6-vgoyal@redhat.com>
In-Reply-To: <20200203200029.4592-1-vgoyal@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: CD5NJLKMAYTZ7WSBZHTBVQVHPTY55STK
X-Message-ID-Hash: CD5NJLKMAYTZ7WSBZHTBVQVHPTY55STK
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CD5NJLKMAYTZ7WSBZHTBVQVHPTY55STK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a helper dax_ioamp_zero() to zero a range. This patch basically
merges __dax_zero_page_range() and iomap_dax_zero().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c               | 12 ++++++------
 fs/iomap/buffered-io.c |  9 +--------
 include/linux/dax.h    | 11 +++++------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1b9ba6b59cdb..63303e274221 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1059,23 +1059,23 @@ int generic_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(generic_dax_zero_page_range);
 
-int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int size)
+int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
+			      struct iomap *iomap)
 {
 	pgoff_t pgoff;
 	long rc, id;
+	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 
-	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
+	rc = bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
 	if (rc)
 		return rc;
 
 	id = dax_read_lock();
-	rc = dax_zero_page_range(dax_dev, pgoff, offset, size);
+	rc = dax_zero_page_range(iomap->dax_dev, pgoff, offset, size);
 	dax_read_unlock(id);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(__dax_zero_page_range);
+EXPORT_SYMBOL_GPL(dax_iomap_zero);
 
 static loff_t
 dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 828444e14d09..5a5d784a110e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -974,13 +974,6 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
 }
 
-static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
-		struct iomap *iomap)
-{
-	return __dax_zero_page_range(iomap->bdev, iomap->dax_dev,
-			iomap_sector(iomap, pos & PAGE_MASK), offset, bytes);
-}
-
 static loff_t
 iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		void *data, struct iomap *iomap, struct iomap *srcmap)
@@ -1000,7 +993,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
 
 		if (IS_DAX(inode))
-			status = iomap_dax_zero(pos, offset, bytes, iomap);
+			status = dax_iomap_zero(pos, offset, bytes, iomap);
 		else
 			status = iomap_zero(inode, pos, offset, bytes, iomap,
 					srcmap);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 3356b874c55d..ffaaa12f8ca9 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -13,6 +13,7 @@
 typedef unsigned long dax_entry_t;
 
 struct iomap_ops;
+struct iomap;
 struct dax_device;
 struct dax_operations {
 	/*
@@ -228,13 +229,11 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 
 #ifdef CONFIG_FS_DAX
-int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int length);
+int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
+			      struct iomap *iomap);
 #else
-static inline int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int length)
+static inline int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
+				 struct iomap *iomap)
 {
 	return -ENXIO;
 }
-- 
2.18.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
