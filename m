Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC44D1B9AAA
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Apr 2020 10:48:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F22E210FF7B7D;
	Mon, 27 Apr 2020 01:47:50 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id CE78E10FF7B86
	for <linux-nvdimm@lists.01.org>; Mon, 27 Apr 2020 01:47:49 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800";
   d="scan'208";a="90547660"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Apr 2020 16:48:37 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id C716A4BCC89B;
	Mon, 27 Apr 2020 16:37:57 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Apr 2020 16:48:40 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 16:48:39 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>
Subject: [RFC PATCH 8/8] fs/xfs: support dedupe for fsdax
Date: Mon, 27 Apr 2020 16:47:50 +0800
Message-ID: <20200427084750.136031-9-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: C716A4BCC89B.A09FE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: EJ5NRPM7B4XTGKFWF6P6ZTGASMBPBJ6D
X-Message-ID-Hash: EJ5NRPM7B4XTGKFWF6P6ZTGASMBPBJ6D
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EJ5NRPM7B4XTGKFWF6P6ZTGASMBPBJ6D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use xfs_break_layouts() to break files' layouts when locking them.  And
call dax_file_range_compare() function to compare range for files both
DAX.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/xfs/xfs_reflink.c | 77 ++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f87ab78dd421..efbe3464ae85 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1185,47 +1185,41 @@ xfs_reflink_remap_blocks(
  * back out both locks.
  */
 static int
-xfs_iolock_two_inodes_and_break_layout(
-	struct inode		*src,
-	struct inode		*dest)
+xfs_reflink_remap_lock_and_break_layouts(
+	struct file		*file_in,
+	struct file		*file_out)
 {
 	int			error;
+	struct inode		*inode_in = file_inode(file_in);
+	struct xfs_inode	*src = XFS_I(inode_in);
+	struct inode		*inode_out = file_inode(file_out);
+	struct xfs_inode	*dest = XFS_I(inode_out);
+	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
 
-	if (src > dest)
+	if (inode_in > inode_out) {
+		swap(inode_in, inode_out);
 		swap(src, dest);
-
-retry:
-	/* Wait to break both inodes' layouts before we start locking. */
-	error = break_layout(src, true);
-	if (error)
-		return error;
-	if (src != dest) {
-		error = break_layout(dest, true);
-		if (error)
-			return error;
 	}
 
-	/* Lock one inode and make sure nobody got in and leased it. */
-	inode_lock(src);
-	error = break_layout(src, false);
+	inode_lock(inode_in);
+	xfs_ilock(src, XFS_MMAPLOCK_EXCL);
+	error = xfs_break_layouts(inode_in, &iolock, BREAK_UNMAP);
+	xfs_iunlock(src, XFS_MMAPLOCK_EXCL);
 	if (error) {
-		inode_unlock(src);
-		if (error == -EWOULDBLOCK)
-			goto retry;
+		inode_unlock(inode_in);
 		return error;
 	}
 
-	if (src == dest)
+	if (inode_in == inode_out)
 		return 0;
 
-	/* Lock the other inode and make sure nobody got in and leased it. */
-	inode_lock_nested(dest, I_MUTEX_NONDIR2);
-	error = break_layout(dest, false);
+	inode_lock_nested(inode_out, I_MUTEX_NONDIR2);
+	xfs_ilock(dest, XFS_MMAPLOCK_EXCL);
+	error = xfs_break_layouts(inode_out, &iolock, BREAK_UNMAP);
+	xfs_iunlock(dest, XFS_MMAPLOCK_EXCL);
 	if (error) {
-		inode_unlock(src);
-		inode_unlock(dest);
-		if (error == -EWOULDBLOCK)
-			goto retry;
+		inode_unlock(inode_in);
+		inode_unlock(inode_out);
 		return error;
 	}
 
@@ -1244,6 +1238,11 @@ xfs_reflink_remap_unlock(
 	struct xfs_inode	*dest = XFS_I(inode_out);
 	bool			same_inode = (inode_in == inode_out);
 
+	if (inode_in > inode_out) {
+		swap(inode_in, inode_out);
+		swap(src, dest);
+	}
+
 	xfs_iunlock(dest, XFS_MMAPLOCK_EXCL);
 	if (!same_inode)
 		xfs_iunlock(src, XFS_MMAPLOCK_EXCL);
@@ -1274,6 +1273,14 @@ xfs_reflink_zero_posteof(
 			&xfs_buffered_write_iomap_ops);
 }
 
+int xfs_reflink_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+					  struct inode *dest, loff_t destoff,
+					  loff_t len, bool *is_same)
+{
+	return dax_file_range_compare(src, srcoff, dest, destoff, len, is_same,
+				      &xfs_read_iomap_ops);
+}
+
 /*
  * Prepare two files for range cloning.  Upon a successful return both inodes
  * will have the iolock and mmaplock held, the page cache of the out file will
@@ -1318,9 +1325,10 @@ xfs_reflink_remap_prep(
 	struct xfs_inode	*dest = XFS_I(inode_out);
 	bool			same_inode = (inode_in == inode_out);
 	ssize_t			ret;
+	compare_range_t		cmp;
 
 	/* Lock both files against IO */
-	ret = xfs_iolock_two_inodes_and_break_layout(inode_in, inode_out);
+	ret = xfs_reflink_remap_lock_and_break_layouts(file_in, file_out);
 	if (ret)
 		return ret;
 	if (same_inode)
@@ -1335,12 +1343,17 @@ xfs_reflink_remap_prep(
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
+
 	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
-			len, remap_flags, vfs_dedupe_file_range_compare);
+			len, remap_flags, cmp);
 	if (ret < 0 || *len == 0)
 		goto out_unlock;
 
-- 
2.26.2


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
