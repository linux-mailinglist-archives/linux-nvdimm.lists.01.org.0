Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E2F7C069
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Jul 2019 13:50:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 79153212FD3EB;
	Wed, 31 Jul 2019 04:52:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=183.91.158.132;
 helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by ml01.01.org (Postfix) with ESMTP id 5DF0C212E8459
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 04:52:30 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.64,330,1559491200"; d="scan'208";a="72591492"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 31 Jul 2019 19:49:57 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
 by cn.fujitsu.com (Postfix) with ESMTP id 6E36D4CDE88F;
 Wed, 31 Jul 2019 19:49:56 +0800 (CST)
Received: from iridescent.g08.fujitsu.local (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 31 Jul 2019 19:50:03 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
 <darrick.wong@oracle.com>
Subject: [RFC PATCH 7/7] xfs: Add dedupe support for fsdax.
Date: Wed, 31 Jul 2019 19:49:35 +0800
Message-ID: <20190731114935.11030-8-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
References: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: 6E36D4CDE88F.AA0FE
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
 david@fromorbit.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

In dax mode, use a new range compare function provided by dax framework.
Don't share dax file with non-dax file.  Use xfs lock and
xfs_break_layouts() to simplify the lock and break layout operation, and
rename to xfs_reflink_remap_lock_and_break_layout() in order to echo the
unlock function: xfs_reflink_remap_unlock().

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/xfs/xfs_reflink.c | 83 +++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 39 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index a1b000be3699..096751d7990a 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1209,39 +1209,37 @@ xfs_reflink_remap_blocks(
  * src iolock held, and therefore have to back out both locks.
  */
 static int
-xfs_iolock_two_inodes_and_break_layout(
-	struct inode		*src,
-	struct inode		*dest)
+xfs_reflink_remap_lock_and_break_layout(
+	struct file		*file_in,
+	struct file		*file_out)
 {
 	int			error;
+	struct inode		*inode_in = file_inode(file_in);
+	struct xfs_inode	*src = XFS_I(inode_in);
+	struct inode		*inode_out = file_inode(file_out);
+	struct xfs_inode	*dest = XFS_I(inode_out);
+
+	uint src_iolock = XFS_IOLOCK_SHARED | XFS_MMAPLOCK_SHARED;
+	uint dest_iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
 
-retry:
-	if (src < dest) {
-		inode_lock_shared(src);
-		inode_lock_nested(dest, I_MUTEX_NONDIR2);
+	if (src->i_ino < dest->i_ino) {
+		xfs_ilock(src, src_iolock);
+		xfs_ilock(dest, dest_iolock);
 	} else {
-		/* src >= dest */
-		inode_lock(dest);
+		/* inode_in >= inode_out */
+		xfs_ilock(dest, dest_iolock);
 	}
 
-	error = break_layout(dest, false);
-	if (error == -EWOULDBLOCK) {
-		inode_unlock(dest);
-		if (src < dest)
-			inode_unlock_shared(src);
-		error = break_layout(dest, true);
-		if (error)
-			return error;
-		goto retry;
-	}
+	error = xfs_break_layouts(inode_out, &dest_iolock, BREAK_UNMAP);
 	if (error) {
-		inode_unlock(dest);
-		if (src < dest)
-			inode_unlock_shared(src);
+		xfs_iunlock(dest, dest_iolock);
+		if (src->i_ino < dest->i_ino)
+			xfs_iunlock(src, src_iolock);
 		return error;
 	}
-	if (src > dest)
-		inode_lock_shared_nested(src, I_MUTEX_NONDIR2);
+
+	if (src->i_ino > dest->i_ino)
+		xfs_ilock(src, src_iolock);
 	return 0;
 }
 
@@ -1257,12 +1255,12 @@ xfs_reflink_remap_unlock(
 	struct xfs_inode	*dest = XFS_I(inode_out);
 	bool			same_inode = (inode_in == inode_out);
 
-	xfs_iunlock(dest, XFS_MMAPLOCK_EXCL);
-	if (!same_inode)
-		xfs_iunlock(src, XFS_MMAPLOCK_SHARED);
-	inode_unlock(inode_out);
+	uint src_iolock = XFS_IOLOCK_SHARED | XFS_MMAPLOCK_SHARED;
+	uint dest_iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
+
+	xfs_iunlock(dest, dest_iolock);
 	if (!same_inode)
-		inode_unlock_shared(inode_in);
+		xfs_iunlock(src, src_iolock);
 }
 
 /*
@@ -1285,6 +1283,14 @@ xfs_reflink_zero_posteof(
 			&xfs_iomap_ops);
 }
 
+int xfs_reflink_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+					  struct inode *dest, loff_t destoff,
+					  loff_t len, bool *is_same)
+{
+	return dax_file_range_compare(src, srcoff, dest, destoff, len, is_same,
+				      &xfs_iomap_ops);
+}
+
 /*
  * Prepare two files for range cloning.  Upon a successful return both inodes
  * will have the iolock and mmaplock held, the page cache of the out file will
@@ -1327,18 +1333,13 @@ xfs_reflink_remap_prep(
 	struct xfs_inode	*src = XFS_I(inode_in);
 	struct inode		*inode_out = file_inode(file_out);
 	struct xfs_inode	*dest = XFS_I(inode_out);
-	bool			same_inode = (inode_in == inode_out);
 	ssize_t			ret;
+	compare_range_t		cmp;
 
 	/* Lock both files against IO */
-	ret = xfs_iolock_two_inodes_and_break_layout(inode_in, inode_out);
+	ret = xfs_reflink_remap_lock_and_break_layout(file_in, file_out);
 	if (ret)
 		return ret;
-	if (same_inode)
-		xfs_ilock(src, XFS_MMAPLOCK_EXCL);
-	else
-		xfs_lock_two_inodes(src, XFS_MMAPLOCK_SHARED, dest,
-				XFS_MMAPLOCK_EXCL);
 
 	/* Check file eligibility and prepare for block sharing. */
 	ret = -EINVAL;
@@ -1346,12 +1347,16 @@ xfs_reflink_remap_prep(
 	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
 		goto out_unlock;
 
-	/* Don't share DAX file data for now. */
-	if (IS_DAX(inode_in) || IS_DAX(inode_out))
+	/* Don't share DAX file data with non-DAX file. */
+	if (IS_DAX(inode_in) != IS_DAX(inode_out))
 		goto out_unlock;
+	if (IS_DAX(inode_in))
+		cmp = xfs_reflink_dedupe_file_range_compare;
+	else
+		cmp = vfs_dedupe_file_range_compare;
 
 	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
-			len, remap_flags, vfs_dedupe_file_range_compare);
+			len, remap_flags, cmp);
 	if (ret < 0 || *len == 0)
 		goto out_unlock;
 
-- 
2.17.0



_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
