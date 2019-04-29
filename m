Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E29E8CB
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Apr 2019 19:27:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2CF8321945DE5;
	Mon, 29 Apr 2019 10:27:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 402FE2121797B
 for <linux-nvdimm@lists.01.org>; Mon, 29 Apr 2019 10:27:11 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D9A26AD5D;
 Mon, 29 Apr 2019 17:27:09 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/18] btrfs: Carve out btrfs_get_extent_map_write() out of
 btrfs_get_blocks_write()
Date: Mon, 29 Apr 2019 12:26:33 -0500
Message-Id: <20190429172649.8288-3-rgoldwyn@suse.de>
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

This makes btrfs_get_extent_map_write() independent of Direct
I/O code.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/inode.c | 40 +++++++++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8ca1c0d120f4..9512f49262dd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3277,6 +3277,8 @@ struct inode *btrfs_iget_path(struct super_block *s, struct btrfs_key *location,
 			      struct btrfs_path *path);
 struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
 			 struct btrfs_root *root, int *was_new);
+int btrfs_get_extent_map_write(struct extent_map **map, struct buffer_head *bh,
+		struct inode *inode, u64 start, u64 len);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, size_t pg_offset,
 				    u64 start, u64 end, int create);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 82fdda8ff5ab..68b8a4935ba6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7496,11 +7496,10 @@ static int btrfs_get_blocks_direct_read(struct extent_map *em,
 	return 0;
 }
 
-static int btrfs_get_blocks_direct_write(struct extent_map **map,
-					 struct buffer_head *bh_result,
-					 struct inode *inode,
-					 struct btrfs_dio_data *dio_data,
-					 u64 start, u64 len)
+int btrfs_get_extent_map_write(struct extent_map **map,
+		struct buffer_head *bh,
+		struct inode *inode,
+		u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em = *map;
@@ -7554,22 +7553,38 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			 */
 			btrfs_free_reserved_data_space_noquota(inode, start,
 							       len);
-			goto skip_cow;
+			/* skip COW */
+			goto out;
 		}
 	}
 
 	/* this will cow the extent */
-	len = bh_result->b_size;
+	if (bh)
+		len = bh->b_size;
 	free_extent_map(em);
 	*map = em = btrfs_new_extent_direct(inode, start, len);
-	if (IS_ERR(em)) {
-		ret = PTR_ERR(em);
-		goto out;
-	}
+	if (IS_ERR(em))
+		return PTR_ERR(em);
+out:
+	return ret;
+}
 
+static int btrfs_get_blocks_direct_write(struct extent_map **map,
+					 struct buffer_head *bh_result,
+					 struct inode *inode,
+					 struct btrfs_dio_data *dio_data,
+					 u64 start, u64 len)
+{
+	int ret;
+	struct extent_map *em;
+
+	ret = btrfs_get_extent_map_write(map, bh_result, inode,
+			start, len);
+	if (ret < 0)
+		return ret;
+	em = *map;
 	len = min(len, em->len - (start - em->start));
 
-skip_cow:
 	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
 		inode->i_blkbits;
 	bh_result->b_size = len;
@@ -7590,7 +7605,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	dio_data->reserve -= len;
 	dio_data->unsubmitted_oe_range_end = start + len;
 	current->journal_info = dio_data;
-out:
 	return ret;
 }
 
-- 
2.16.4

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
