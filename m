Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55F7E959F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Oct 2019 05:14:34 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 44178100EA54C;
	Tue, 29 Oct 2019 21:15:10 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 60D8D100EA543
	for <linux-nvdimm@lists.01.org>; Tue, 29 Oct 2019 21:15:07 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.68,245,1569254400";
   d="scan'208";a="77665121"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Oct 2019 12:14:26 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id E68F04B6EC86;
	Wed, 30 Oct 2019 12:06:26 +0800 (CST)
Received: from localhost.localdomain (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 30 Oct 2019 12:14:34 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
	<darrick.wong@oracle.com>, <rgoldwyn@suse.de>, <hch@infradead.org>,
	<david@fromorbit.com>
Subject: [RFC PATCH v2 5/7] dax: memcpy before zeroing range
Date: Wed, 30 Oct 2019 12:13:56 +0800
Message-ID: <20191030041358.14450-6-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191030041358.14450-1-ruansy.fnst@cn.fujitsu.com>
References: <20191030041358.14450-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: E68F04B6EC86.A6A86
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: OLZN3ACXAEUYRFLEGQYIRIZ7FEAUMWTH
X-Message-ID-Hash: OLZN3ACXAEUYRFLEGQYIRIZ7FEAUMWTH
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, gujx@cn.fujitsu.com, qi.fuli@fujitsu.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OLZN3ACXAEUYRFLEGQYIRIZ7FEAUMWTH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
 fs/dax.c               | 21 ++++++++++++++++-----
 fs/iomap/buffered-io.c |  8 ++++----
 include/linux/dax.h    | 12 ++++++------
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index a4f90f3faddb..eab6bb256205 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1117,11 +1117,16 @@ static int dax_copy_edges(loff_t pos, loff_t length, struct iomap *srcmap,
 	return ret;
 }
 
-int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int size)
+int __dax_zero_page_range(struct iomap *iomap, struct iomap *srcmap, loff_t pos,
+			  unsigned int offset, unsigned int size)
 {
-	if (dax_range_is_aligned(bdev, offset, size)) {
+	sector_t sector = dax_iomap_sector(iomap, pos & PAGE_MASK);
+	struct block_device *bdev = iomap->bdev;
+	struct dax_device *dax_dev = iomap->dax_dev;
+	int ret = 0;
+
+	if (iomap == srcmap &&
+	    dax_range_is_aligned(bdev, offset, size)) {
 		sector_t start_sector = sector + (offset >> 9);
 
 		return blkdev_issue_zeroout(bdev, start_sector,
@@ -1141,11 +1146,17 @@ int __dax_zero_page_range(struct block_device *bdev,
 			dax_read_unlock(id);
 			return rc;
 		}
+		if (iomap != srcmap) {
+			ret = dax_copy_edges(pos, size, srcmap, kaddr, false);
+			if (ret)
+				goto out_unlock;
+		}
 		memset(kaddr + offset, 0, size);
 		dax_flush(dax_dev, kaddr + offset, size);
+out_unlock:
 		dax_read_unlock(id);
 	}
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__dax_zero_page_range);
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c62e807956b6..3fa79389e4d0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -960,10 +960,9 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 }
 
 static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
-		struct iomap *iomap)
+		struct iomap *iomap, struct iomap *srcmap)
 {
-	return __dax_zero_page_range(iomap->bdev, iomap->dax_dev,
-			iomap_sector(iomap, pos & PAGE_MASK), offset, bytes);
+	return __dax_zero_page_range(iomap, srcmap, pos, offset, bytes);
 }
 
 static loff_t
@@ -985,7 +984,8 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
 
 		if (IS_DAX(inode))
-			status = iomap_dax_zero(pos, offset, bytes, iomap);
+			status = iomap_dax_zero(pos, offset, bytes, iomap,
+						srcmap);
 		else
 			status = iomap_zero(inode, pos, offset, bytes, iomap,
 					srcmap);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 4533bfb99683..7adf3b9e1061 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -12,6 +12,7 @@
 
 typedef unsigned long dax_entry_t;
 
+struct iomap;
 struct iomap_ops;
 struct dax_device;
 struct dax_operations {
@@ -226,13 +227,12 @@ int dax_file_range_compare(struct inode *src, loff_t srcoff,
 			   const struct iomap_ops *ops);
 
 #ifdef CONFIG_FS_DAX
-int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int length);
+int __dax_zero_page_range(struct iomap *iomap, struct iomap *srcmap, loff_t pos,
+			  unsigned int offset, unsigned int size);
 #else
-static inline int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int length)
+static inline int __dax_zero_page_range(struct iomap *iomap,
+					struct iomap *srcmap, loff_t pos,
+					unsigned int offset, unsigned int size)
 {
 	return -ENXIO;
 }
-- 
2.23.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
