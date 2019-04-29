Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F96BE8E1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Apr 2019 19:27:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A9EB92122C305;
	Mon, 29 Apr 2019 10:27:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1098C2122C2E4
 for <linux-nvdimm@lists.01.org>; Mon, 29 Apr 2019 10:27:38 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A9A5BAE8A;
 Mon, 29 Apr 2019 17:27:36 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/18] btrfs: handle dax page zeroing
Date: Mon, 29 Apr 2019 12:26:46 -0500
Message-Id: <20190429172649.8288-16-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
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
Cc: kilobyte@angband.pl, jack@suse.cz, darrick.wong@oracle.com,
 nborisov@suse.com, linux-nvdimm@lists.01.org, david@fromorbit.com,
 dsterba@suse.cz, willy@infradead.org, linux-fsdevel@vger.kernel.org,
 hch@lst.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_dax_zero_block() zeros part of the page, either from the
front or the regular rest of the block.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  1 +
 fs/btrfs/dax.c   | 27 ++++++++++++++++++++++++++-
 fs/btrfs/inode.c |  4 ++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d3d044125619..ee1ed18f8b3c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3806,6 +3806,7 @@ vm_fault_t btrfs_dax_fault(struct vm_fault *vmf);
 int btrfs_dax_file_range_compare(struct inode *src, loff_t srcoff,
 		struct inode *dest, loff_t destoff, loff_t len,
 		bool *is_same);
+int btrfs_dax_zero_block(struct inode *inode, loff_t from, loff_t len, bool front);
 #else
 static inline ssize_t btrfs_file_dax_write(struct kiocb *iocb, struct iov_iter *from)
 {
diff --git a/fs/btrfs/dax.c b/fs/btrfs/dax.c
index af64696a5337..bf2ddac5b5a1 100644
--- a/fs/btrfs/dax.c
+++ b/fs/btrfs/dax.c
@@ -132,7 +132,8 @@ static int btrfs_iomap_begin(struct inode *inode, loff_t pos,
 	 * This will be true for reads only since we have already
 	 * allocated em
 	 */
-	if (em->block_start == EXTENT_MAP_HOLE) {
+	if (em->block_start == EXTENT_MAP_HOLE ||
+			em->flags == EXTENT_FLAG_FILLING) {
 		iomap->type = IOMAP_HOLE;
 		return 0;
 	}
@@ -235,4 +236,28 @@ int btrfs_dax_file_range_compare(struct inode *src, loff_t srcoff,
 	return dax_file_range_compare(src, srcoff, dest, destoff, len,
 				      is_same, &btrfs_iomap_ops);
 }
+
+/*
+ * zero a part of the page only. This should CoW (via iomap_begin) if required
+ */
+int btrfs_dax_zero_block(struct inode *inode, loff_t from, loff_t len, bool front)
+{
+	loff_t start = round_down(from, PAGE_SIZE);
+	loff_t end = round_up(from, PAGE_SIZE);
+	loff_t offset = from;
+	int ret = 0;
+
+	if (front) {
+		len = from - start;
+		offset = start;
+	} else	{
+		if (!len)
+			len = end - from;
+	}
+
+	if (len)
+		ret = iomap_zero_range(inode, offset, len, NULL, &btrfs_iomap_ops);
+
+	return (ret < 0) ? ret : 0;
+}
 #endif /* CONFIG_FS_DAX */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 05714ffc4894..7e88280a2c3b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4833,6 +4833,10 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	    (!len || IS_ALIGNED(len, blocksize)))
 		goto out;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return btrfs_dax_zero_block(inode, from, len, front);
+#endif
 	block_start = round_down(from, blocksize);
 	block_end = block_start + blocksize - 1;
 
-- 
2.16.4

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
