Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E88981E9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 19:57:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5FB0C2194D3B3;
	Wed, 21 Aug 2019 10:58:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D83A520212CA3
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 10:58:48 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8810898107;
 Wed, 21 Aug 2019 17:57:37 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F40A217CFD;
 Wed, 21 Aug 2019 17:57:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 80E67223CFE; Wed, 21 Aug 2019 13:57:32 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvdimm@lists.01.org
Subject: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
Date: Wed, 21 Aug 2019 13:57:03 -0400
Message-Id: <20190821175720.25901-3-vgoyal@redhat.com>
In-Reply-To: <20190821175720.25901-1-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 21 Aug 2019 17:57:37 +0000 (UTC)
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
Cc: miklos@szeredi.hu, dgilbert@redhat.com, virtio-fs@redhat.com,
 stefanha@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Right now dax_writeback_mapping_range() is passed a bdev and dax_dev
is searched from that bdev name.

virtio-fs does not have a bdev. So pass in dax_dev also to
dax_writeback_mapping_range(). If dax_dev is passed in, bdev is not
used otherwise dax_dev is searched using bdev.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c            | 16 ++++++++++------
 fs/ext2/inode.c     |  2 +-
 fs/ext4/inode.c     |  2 +-
 fs/xfs/xfs_aops.c   |  2 +-
 include/linux/dax.h |  6 ++++--
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index a11147bbaf9e..60620a37030c 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -936,12 +936,12 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
  * on persistent storage prior to completion of the operation.
  */
 int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc)
+		struct block_device *bdev, struct dax_device *dax_dev,
+		struct writeback_control *wbc)
 {
 	XA_STATE(xas, &mapping->i_pages, wbc->range_start >> PAGE_SHIFT);
 	struct inode *inode = mapping->host;
 	pgoff_t end_index = wbc->range_end >> PAGE_SHIFT;
-	struct dax_device *dax_dev;
 	void *entry;
 	int ret = 0;
 	unsigned int scanned = 0;
@@ -952,9 +952,12 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 	if (!mapping->nrexceptional || wbc->sync_mode != WB_SYNC_ALL)
 		return 0;
 
-	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
-	if (!dax_dev)
-		return -EIO;
+	if (bdev) {
+		WARN_ON(dax_dev);
+		dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
+		if (!dax_dev)
+			return -EIO;
+	}
 
 	trace_dax_writeback_range(inode, xas.xa_index, end_index);
 
@@ -976,7 +979,8 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 		xas_lock_irq(&xas);
 	}
 	xas_unlock_irq(&xas);
-	put_dax(dax_dev);
+	if (bdev)
+		put_dax(dax_dev);
 	trace_dax_writeback_range_done(inode, xas.xa_index, end_index);
 	return ret;
 }
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 7004ce581a32..4e3870c4e255 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -958,7 +958,7 @@ static int
 ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	return dax_writeback_mapping_range(mapping,
-			mapping->host->i_sb->s_bdev, wbc);
+			mapping->host->i_sb->s_bdev, NULL, wbc);
 }
 
 const struct address_space_operations ext2_aops = {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 420fe3deed39..75b85c56c732 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2992,7 +2992,7 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	percpu_down_read(&sbi->s_journal_flag_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
-	ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, wbc);
+	ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, NULL, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
 	percpu_up_read(&sbi->s_journal_flag_rwsem);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index f16d5f196c6b..71a7007509c4 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -1120,7 +1120,7 @@ xfs_dax_writepages(
 {
 	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
 	return dax_writeback_mapping_range(mapping,
-			xfs_find_bdev_for_inode(mapping->host), wbc);
+			xfs_find_bdev_for_inode(mapping->host), NULL, wbc);
 }
 
 STATIC int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9bd8528bd305..e7f40108f2c9 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -141,7 +141,8 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
 
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
 int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc);
+		struct block_device *bdev, struct dax_device *dax_dev,
+		struct writeback_control *wbc);
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
 dax_entry_t dax_lock_page(struct page *page);
@@ -180,7 +181,8 @@ static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 }
 
 static inline int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc)
+		struct block_device *bdev, struct dax_device *dax_dev,
+		struct writeback_control *wbc)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
