Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE58E959E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Oct 2019 05:14:32 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C4FE100EA53F;
	Tue, 29 Oct 2019 21:15:10 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id AB4DD100EA543
	for <linux-nvdimm@lists.01.org>; Tue, 29 Oct 2019 21:15:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.68,245,1569254400";
   d="scan'208";a="77665123"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Oct 2019 12:14:26 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id BA7B84CE1513;
	Wed, 30 Oct 2019 12:06:28 +0800 (CST)
Received: from localhost.localdomain (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 30 Oct 2019 12:14:37 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
	<darrick.wong@oracle.com>, <rgoldwyn@suse.de>, <hch@infradead.org>,
	<david@fromorbit.com>
Subject: [RFC PATCH v2 6/7] xfs: handle copy-on-write in fsdax write() path.
Date: Wed, 30 Oct 2019 12:13:57 +0800
Message-ID: <20191030041358.14450-7-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191030041358.14450-1-ruansy.fnst@cn.fujitsu.com>
References: <20191030041358.14450-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: BA7B84CE1513.A6BD3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: PWLRYJTBB5JISWRYFKL3RZOMVQS7G4AP
X-Message-ID-Hash: PWLRYJTBB5JISWRYFKL3RZOMVQS7G4AP
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, gujx@cn.fujitsu.com, qi.fuli@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PWLRYJTBB5JISWRYFKL3RZOMVQS7G4AP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In fsdax mode, WRITE and ZERO on a shared extent need COW mechanism
performed.  After COW, new extents needs to be remapped to the file.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/xfs/xfs_bmap_util.c |  6 +++++-
 fs/xfs/xfs_file.c      | 10 +++++++---
 fs/xfs/xfs_iomap.c     |  3 ++-
 fs/xfs/xfs_iops.c      | 11 ++++++++---
 fs/xfs/xfs_reflink.c   |  2 ++
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 99bf372ed551..1b7d0665d889 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1114,10 +1114,14 @@ xfs_free_file_space(
 	if (offset + len > XFS_ISIZE(ip))
 		len = XFS_ISIZE(ip) - offset;
 	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
-			&xfs_buffered_write_iomap_ops);
+		  IS_DAX(VFS_I(ip)) ?
+		  &xfs_direct_write_iomap_ops : &xfs_buffered_write_iomap_ops);
 	if (error)
 		return error;
 
+	if (xfs_is_reflink_inode(ip))
+		xfs_reflink_end_cow(ip, offset, len);
+
 	/*
 	 * If we zeroed right up to EOF and EOF straddles a page boundary we
 	 * must make sure that the post-EOF area is also zeroed because the
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 24659667d5cb..48071f16a436 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -594,9 +594,13 @@ xfs_file_dax_write(
 
 	trace_xfs_file_dax_write(ip, count, pos);
 	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
-	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
-		i_size_write(inode, iocb->ki_pos);
-		error = xfs_setfilesize(ip, pos, ret);
+	if (ret > 0) {
+		if (iocb->ki_pos > i_size_read(inode)) {
+			i_size_write(inode, iocb->ki_pos);
+			error = xfs_setfilesize(ip, pos, ret);
+		}
+		if (xfs_is_cow_inode(ip))
+			xfs_reflink_end_cow(ip, pos, ret);
 	}
 out:
 	xfs_iunlock(ip, iolock);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index e8fb500e1880..db8ee371252f 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -772,13 +772,14 @@ xfs_direct_write_iomap_begin(
 		goto out_unlock;
 
 	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
+		bool need_convert = flags & IOMAP_DIRECT || IS_DAX(inode);
 		error = -EAGAIN;
 		if (flags & IOMAP_NOWAIT)
 			goto out_unlock;
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode, flags & IOMAP_DIRECT);
+				&lockmode, need_convert);
 		if (error)
 			goto out_unlock;
 		if (shared)
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 329a34af8e79..0052a97ccebf 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -834,6 +834,7 @@ xfs_setattr_size(
 	int			error;
 	uint			lock_flags = 0;
 	bool			did_zeroing = false;
+	const struct iomap_ops	*ops;
 
 	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
 	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
@@ -880,13 +881,17 @@ xfs_setattr_size(
 	 * extension, or zeroing out the rest of the block on a downward
 	 * truncate.
 	 */
+	if (IS_DAX(inode))
+		ops = &xfs_direct_write_iomap_ops;
+	else
+		ops = &xfs_buffered_write_iomap_ops;
+
 	if (newsize > oldsize) {
 		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
 		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
-				&did_zeroing, &xfs_buffered_write_iomap_ops);
+				&did_zeroing, ops);
 	} else {
-		error = iomap_truncate_page(inode, newsize, &did_zeroing,
-				&xfs_buffered_write_iomap_ops);
+		error = iomap_truncate_page(inode, newsize, &did_zeroing, ops);
 	}
 
 	if (error)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 2c8ad581d4db..e3620bc794a2 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1270,6 +1270,8 @@ xfs_reflink_zero_posteof(
 
 	trace_xfs_zero_eof(ip, isize, pos - isize);
 	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
+			IS_DAX(VFS_I(ip)) ?
+			&xfs_direct_write_iomap_ops :
 			&xfs_buffered_write_iomap_ops);
 }
 
-- 
2.23.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
