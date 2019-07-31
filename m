Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDC87C067
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Jul 2019 13:50:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62D62212FD3E1;
	Wed, 31 Jul 2019 04:52:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=183.91.158.132;
 helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by ml01.01.org (Postfix) with ESMTP id B00EB212DD348
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 04:52:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.64,330,1559491200"; d="scan'208";a="72591491"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 31 Jul 2019 19:49:57 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
 by cn.fujitsu.com (Postfix) with ESMTP id D54354B4041E;
 Wed, 31 Jul 2019 19:49:52 +0800 (CST)
Received: from iridescent.g08.fujitsu.local (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 31 Jul 2019 19:49:59 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
 <darrick.wong@oracle.com>
Subject: [RFC PATCH 5/7] dax: memcpy before zeroing range
Date: Wed, 31 Jul 2019 19:49:33 +0800
Message-ID: <20190731114935.11030-6-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
References: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: D54354B4041E.A54D3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: qi.fuli@fujitsu.com, gujx@cn.fujitsu.com, rgoldwyn@suse.de,
 david@fromorbit.com, linux-kernel@vger.kernel.org,
 Goldwyn Rodrigues <rgoldwyn@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

However, this needed more iomap fields, so it was easier
to pass iomap and compute inside the function rather
than passing a log of arguments.

Note, there is subtle difference between iomap_sector and
dax_iomap_sector(). Can we replace dax_iomap_sector with
iomap_sector()? It would need pos & PAGE_MASK though or else
bdev_dax_pgoff() return -EINVAL.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/dax.c              | 17 ++++++++++++-----
 fs/iomap.c            |  9 +--------
 include/linux/dax.h   | 11 +++++------
 include/linux/iomap.h |  6 ++++++
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 8111ba93f4d3..c92111950612 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1071,11 +1071,16 @@ static bool dax_range_is_aligned(struct block_device *bdev,
 	return true;
 }
 
-int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int size)
+int __dax_zero_page_range(struct iomap *iomap, loff_t pos,
+			  unsigned int offset, unsigned int size)
 {
-	if (dax_range_is_aligned(bdev, offset, size)) {
+	sector_t sector = dax_iomap_sector(iomap, pos & PAGE_MASK);
+	struct block_device *bdev = iomap->bdev;
+	struct dax_device *dax_dev = iomap->dax_dev;
+	int ret = 0;
+
+	if (!(iomap->type == IOMAP_COW) &&
+	    dax_range_is_aligned(bdev, offset, size)) {
 		sector_t start_sector = sector + (offset >> 9);
 
 		return blkdev_issue_zeroout(bdev, start_sector,
@@ -1095,11 +1100,13 @@ int __dax_zero_page_range(struct block_device *bdev,
 			dax_read_unlock(id);
 			return rc;
 		}
+		if (iomap->type == IOMAP_COW)
+			ret = memcpy_mcsafe(kaddr, iomap->inline_data, offset);
 		memset(kaddr + offset, 0, size);
 		dax_flush(dax_dev, kaddr + offset, size);
 		dax_read_unlock(id);
 	}
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__dax_zero_page_range);
 
diff --git a/fs/iomap.c b/fs/iomap.c
index 3377a7ec5b7d..b5662b5bac26 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -99,12 +99,6 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	return written ? written : ret;
 }
 
-static sector_t
-iomap_sector(struct iomap *iomap, loff_t pos)
-{
-	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
-}
-
 static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
@@ -993,8 +987,7 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
 		struct iomap *iomap)
 {
-	return __dax_zero_page_range(iomap->bdev, iomap->dax_dev,
-			iomap_sector(iomap, pos & PAGE_MASK), offset, bytes);
+	return __dax_zero_page_range(iomap, pos, offset, bytes);
 }
 
 static loff_t
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 1370d39c91b6..c469d9ff54b4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -9,6 +9,7 @@
 
 typedef unsigned long dax_entry_t;
 
+struct iomap;
 struct iomap_ops;
 struct dax_device;
 struct dax_operations {
@@ -163,13 +164,11 @@ int dax_file_range_compare(struct inode *src, loff_t srcoff,
 			   const struct iomap_ops *ops);
 
 #ifdef CONFIG_FS_DAX
-int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int length);
+int __dax_zero_page_range(struct iomap *iomap, loff_t pos,
+		unsigned int offset, unsigned int size);
 #else
-static inline int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int length)
+static inline int __dax_zero_page_range(struct iomap *iomap, loff_t pos,
+		unsigned int offset, unsigned int size)
 {
 	return -ENXIO;
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 75b78dd91c3c..3628e57954c6 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <linux/mm_types.h>
+#include <linux/blkdev.h>
 
 struct address_space;
 struct fiemap_extent_info;
@@ -122,6 +123,11 @@ static inline struct iomap_page *to_iomap_page(struct page *page)
 	return NULL;
 }
 
+static inline sector_t iomap_sector(struct iomap *iomap, loff_t pos)
+{
+	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
+}
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
-- 
2.17.0



_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
