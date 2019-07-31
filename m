Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 161FF7C065
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Jul 2019 13:50:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E7DD212E845C;
	Wed, 31 Jul 2019 04:52:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=183.91.158.132;
 helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by ml01.01.org (Postfix) with ESMTP id 05CCC212DD348
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 04:52:28 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.64,330,1559491200"; d="scan'208";a="72591490"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 31 Jul 2019 19:49:57 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
 by cn.fujitsu.com (Postfix) with ESMTP id 82DCA4CDE65E;
 Wed, 31 Jul 2019 19:49:54 +0800 (CST)
Received: from iridescent.g08.fujitsu.local (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 31 Jul 2019 19:50:01 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
 <darrick.wong@oracle.com>
Subject: [RFC PATCH 6/7] xfs: Add COW handle for fsdax.
Date: Wed, 31 Jul 2019 19:49:34 +0800
Message-ID: <20190731114935.11030-7-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
References: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: 82DCA4CDE65E.AAA93
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

WRITE and ZERO on a shared extent need to perform COW.  For direct io in
dax mode, it is handled like WRITE, but with block aligned.  So COW
seems a bit redundant for it.

Because of COW, new extent has been allocated.  The extent list needs to
be updated at the end.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/xfs/xfs_iomap.c   | 42 +++++++++++++++++++++++++-----------------
 fs/xfs/xfs_reflink.c |  1 +
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 6116a75f03da..ae3b9bf5d784 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -930,10 +930,10 @@ xfs_file_iomap_begin(
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_bmbt_irec	imap;
+	struct xfs_bmbt_irec	imap = { 0 }, cmap = { 0 };
 	xfs_fileoff_t		offset_fsb, end_fsb;
 	int			nimaps = 1, error = 0;
-	bool			shared = false;
+	bool			shared = false, need_cow = false;
 	unsigned		lockmode;
 
 	if (XFS_FORCED_SHUTDOWN(mp))
@@ -967,6 +967,8 @@ xfs_file_iomap_begin(
 	if (error)
 		goto out_unlock;
 
+	cmap = imap;
+
 	if (flags & IOMAP_REPORT) {
 		/* Trim the mapping to the nearest shared extent boundary. */
 		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
@@ -983,8 +985,7 @@ xfs_file_iomap_begin(
 	 * been done up front, so we don't need to do them here.
 	 */
 	if (xfs_is_cow_inode(ip)) {
-		struct xfs_bmbt_irec	cmap;
-		bool			directio = (flags & IOMAP_DIRECT);
+		bool directio = flags & IOMAP_DIRECT;
 
 		/* if zeroing doesn't need COW allocation, then we are done. */
 		if ((flags & IOMAP_ZERO) &&
@@ -992,23 +993,21 @@ xfs_file_iomap_begin(
 			goto out_found;
 
 		/* may drop and re-acquire the ilock */
-		cmap = imap;
 		error = xfs_reflink_allocate_cow(ip, &cmap, &shared, &lockmode,
-				directio);
+						 directio || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
 
 		/*
-		 * For buffered writes we need to report the address of the
-		 * previous block (if there was any) so that the higher level
-		 * write code can perform read-modify-write operations; we
-		 * won't need the CoW fork mapping until writeback.  For direct
-		 * I/O, which must be block aligned, we need to report the
-		 * newly allocated address.  If the data fork has a hole, copy
-		 * the COW fork mapping to avoid allocating to the data fork.
+		 * WRITE and ZERO on a shared extent under dax mode need to
+		 * perform COW, source address will be reported in srcmap.
 		 */
-		if (directio || imap.br_startblock == HOLESTARTBLOCK)
+		if (imap.br_startblock != HOLESTARTBLOCK && IS_DAX(inode) &&
+		    shared) {
+			need_cow = true;
+		} else {
 			imap = cmap;
+		}
 
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
@@ -1044,8 +1043,7 @@ xfs_file_iomap_begin(
 	 */
 	if (lockmode == XFS_ILOCK_EXCL)
 		xfs_ilock_demote(ip, lockmode);
-	error = xfs_iomap_write_direct(ip, offset, length, &imap,
-			nimaps);
+	error = xfs_iomap_write_direct(ip, offset, length, &imap, nimaps);
 	if (error)
 		return error;
 
@@ -1053,7 +1051,15 @@ xfs_file_iomap_begin(
 	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
 
 out_finish:
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
+	if (need_cow) {
+		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, shared);
+		if (error)
+			return error;
+		iomap->flags |= IOMAP_F_NEW;
+		iomap->type = IOMAP_COW;
+		return xfs_bmbt_to_iomap(ip, srcmap, &imap, shared);
+	} else
+		return xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
 
 out_found:
 	ASSERT(nimaps);
@@ -1135,6 +1141,8 @@ xfs_file_iomap_end(
 	if ((flags & IOMAP_WRITE) && iomap->type == IOMAP_DELALLOC)
 		return xfs_file_iomap_end_delalloc(XFS_I(inode), offset,
 				length, written, iomap);
+	else if (iomap->type == IOMAP_COW && written)
+		return xfs_reflink_end_cow(XFS_I(inode), offset, length);
 	return 0;
 }
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 68e4257cebb0..a1b000be3699 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -446,6 +446,7 @@ xfs_reflink_allocate_cow(
 	 */
 	if (!convert_now || imap->br_state == XFS_EXT_NORM)
 		return 0;
+	imap->br_state = XFS_EXT_NORM;
 	trace_xfs_reflink_convert_cow(ip, imap);
 	return xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
 
-- 
2.17.0



_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
