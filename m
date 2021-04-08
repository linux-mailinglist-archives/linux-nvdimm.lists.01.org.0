Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB953582CE
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Apr 2021 14:05:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18A4C100EAB5E;
	Thu,  8 Apr 2021 05:05:34 -0700 (PDT)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id F0414100EAB58
	for <linux-nvdimm@lists.01.org>; Thu,  8 Apr 2021 05:05:30 -0700 (PDT)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A77b/e68CuoxXbejE+Ehuk+A4I+orLtY04lQ7?=
 =?us-ascii?q?vn1ZYxpTb8CeioSSjO0WvCWE7Ao5dVMBvZS7OKeGSW7B7pId2+QsFJqrQQWOgg?=
 =?us-ascii?q?WVBa5v4YboyzfjXw3Sn9Q26Y5OaK57YeeQMXFfreLXpDa1CMwhxt7vytHMuc77?=
 =?us-ascii?q?w212RQ9nL4FMhj0JaTqzKUF9SAlYCZdRLvP1ifZvnSaqengcc62Adxs4dtXEzu?=
 =?us-ascii?q?eqqLvWJTYCBzMCrDKFlC6U7tfBeCSw71MzVCxuzN4ZnVT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,206,1613404800";
   d="scan'208";a="106797324"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Apr 2021 20:05:29 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id 87CFB4D0B8A6;
	Thu,  8 Apr 2021 20:05:24 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 8 Apr 2021 20:05:19 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 8 Apr 2021 20:05:19 +0800
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v4 7/7] fs/xfs: Add dedupe support for fsdax
Date: Thu, 8 Apr 2021 20:04:32 +0800
Message-ID: <20210408120432.1063608-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 87CFB4D0B8A6.A41E9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Message-ID-Hash: TWJN5TVN6F2ASOGJNZDDZ24OOAV4OZGF
X-Message-ID-Hash: TWJN5TVN6F2ASOGJNZDDZ24OOAV4OZGF
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TWJN5TVN6F2ASOGJNZDDZ24OOAV4OZGF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add xfs_break_two_dax_layouts() to break layout for tow dax files.  Then
call compare range function only when files are both DAX or not.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/xfs/xfs_file.c    | 20 ++++++++++++++++++++
 fs/xfs/xfs_inode.c   |  8 +++++++-
 fs/xfs/xfs_inode.h   |  1 +
 fs/xfs/xfs_reflink.c |  5 +++--
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5795d5d6f869..1fd457167c12 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -842,6 +842,26 @@ xfs_break_dax_layouts(
 			0, 0, xfs_wait_dax_page(inode));
 }
 
+int
+xfs_break_two_dax_layouts(
+	struct inode		*src,
+	struct inode		*dest)
+{
+	int			error;
+	bool			retry = false;
+
+retry:
+	error = xfs_break_dax_layouts(src, &retry);
+	if (error || retry)
+		goto retry;
+
+	error = xfs_break_dax_layouts(dest, &retry);
+	if (error || retry)
+		goto retry;
+
+	return error;
+}
+
 int
 xfs_break_layouts(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index f93370bd7b1e..c01786917eef 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3713,8 +3713,10 @@ xfs_ilock2_io_mmap(
 	struct xfs_inode	*ip2)
 {
 	int			ret;
+	struct inode		*inode1 = VFS_I(ip1);
+	struct inode		*inode2 = VFS_I(ip2);
 
-	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
+	ret = xfs_iolock_two_inodes_and_break_layout(inode1, inode2);
 	if (ret)
 		return ret;
 	if (ip1 == ip2)
@@ -3722,6 +3724,10 @@ xfs_ilock2_io_mmap(
 	else
 		xfs_lock_two_inodes(ip1, XFS_MMAPLOCK_EXCL,
 				    ip2, XFS_MMAPLOCK_EXCL);
+
+	if (IS_DAX(inode1) && IS_DAX(inode2))
+		ret = xfs_break_two_dax_layouts(inode1, inode2);
+
 	return 0;
 }
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 88ee4c3930ae..5ef21924dddc 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -435,6 +435,7 @@ enum xfs_prealloc_flags {
 
 int	xfs_update_prealloc_flags(struct xfs_inode *ip,
 				  enum xfs_prealloc_flags flags);
+int	xfs_break_two_dax_layouts(struct inode *inode1, struct inode *inode2);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index a4cd6e8a7aa0..4426bcc8a985 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -29,6 +29,7 @@
 #include "xfs_iomap.h"
 #include "xfs_sb.h"
 #include "xfs_ag_resv.h"
+#include <linux/dax.h>
 
 /*
  * Copy on Write of Shared Blocks
@@ -1324,8 +1325,8 @@ xfs_reflink_remap_prep(
 	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
 		goto out_unlock;
 
-	/* Don't share DAX file data for now. */
-	if (IS_DAX(inode_in) || IS_DAX(inode_out))
+	/* Don't share DAX file data with non-DAX file. */
+	if (IS_DAX(inode_in) != IS_DAX(inode_out))
 		goto out_unlock;
 
 	if (!IS_DAX(inode_in))
-- 
2.31.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
