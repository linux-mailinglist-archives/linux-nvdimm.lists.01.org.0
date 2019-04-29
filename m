Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DA7E8D8
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Apr 2019 19:27:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 774A32122C2F3;
	Mon, 29 Apr 2019 10:27:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6A0522122C2EC
 for <linux-nvdimm@lists.01.org>; Mon, 29 Apr 2019 10:27:19 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 11C81ACFB;
 Mon, 29 Apr 2019 17:27:18 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/18] btrfs: Rename __endio_write_update_ordered() to
 btrfs_update_ordered_extent()
Date: Mon, 29 Apr 2019 12:26:37 -0500
Message-Id: <20190429172649.8288-7-rgoldwyn@suse.de>
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

Since we will be using it in another part of the code, use a
better name to declare it non-static

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  7 +++++--
 fs/btrfs/inode.c | 14 +++++---------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 050f30165531..1e3e758b83c2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3280,8 +3280,11 @@ struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
 int btrfs_get_extent_map_write(struct extent_map **map, struct buffer_head *bh,
 		struct inode *inode, u64 start, u64 len, bool *nocow);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
-				    struct page *page, size_t pg_offset,
-				    u64 start, u64 end, int create);
+		struct page *page, size_t pg_offset,
+		u64 start, u64 end, int create);
+void btrfs_update_ordered_extent(struct inode *inode,
+		const u64 offset, const u64 bytes,
+		const bool uptodate);
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct inode *inode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8e33c38511bb..af4b56cba104 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -98,10 +98,6 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 				       u64 ram_bytes, int compress_type,
 				       int type);
 
-static void __endio_write_update_ordered(struct inode *inode,
-					 const u64 offset, const u64 bytes,
-					 const bool uptodate);
-
 /*
  * Cleanup all submitted ordered extents in specified range to handle errors
  * from the btrfs_run_delalloc_range() callback.
@@ -142,7 +138,7 @@ static inline void btrfs_cleanup_ordered_extents(struct inode *inode,
 		bytes -= PAGE_SIZE;
 	}
 
-	return __endio_write_update_ordered(inode, offset, bytes, false);
+	return btrfs_update_ordered_extent(inode, offset, bytes, false);
 }
 
 static int btrfs_dirty_inode(struct inode *inode);
@@ -8085,7 +8081,7 @@ static void btrfs_endio_direct_read(struct bio *bio)
 	bio_put(bio);
 }
 
-static void __endio_write_update_ordered(struct inode *inode,
+void btrfs_update_ordered_extent(struct inode *inode,
 					 const u64 offset, const u64 bytes,
 					 const bool uptodate)
 {
@@ -8138,7 +8134,7 @@ static void btrfs_endio_direct_write(struct bio *bio)
 	struct btrfs_dio_private *dip = bio->bi_private;
 	struct bio *dio_bio = dip->dio_bio;
 
-	__endio_write_update_ordered(dip->inode, dip->logical_offset,
+	btrfs_update_ordered_extent(dip->inode, dip->logical_offset,
 				     dip->bytes, !bio->bi_status);
 
 	kfree(dip);
@@ -8457,7 +8453,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		bio = NULL;
 	} else {
 		if (write)
-			__endio_write_update_ordered(inode,
+			btrfs_update_ordered_extent(inode,
 						file_offset,
 						dio_bio->bi_iter.bi_size,
 						false);
@@ -8597,7 +8593,7 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			 */
 			if (dio_data.unsubmitted_oe_range_start <
 			    dio_data.unsubmitted_oe_range_end)
-				__endio_write_update_ordered(inode,
+				btrfs_update_ordered_extent(inode,
 					dio_data.unsubmitted_oe_range_start,
 					dio_data.unsubmitted_oe_range_end -
 					dio_data.unsubmitted_oe_range_start,
-- 
2.16.4

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
