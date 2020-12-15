Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4402DACCF
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Dec 2020 13:15:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6996E100EBBD1;
	Tue, 15 Dec 2020 04:15:13 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id CCFA8100EBBCC
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 04:15:07 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400";
   d="scan'208";a="102420208"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Dec 2020 20:15:06 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id C54234CE5CCA;
	Tue, 15 Dec 2020 20:15:00 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 15 Dec 2020 20:15:00 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 15 Dec 2020 20:14:59 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
Subject: [RFC PATCH v3 9/9] xfs: Implement ->corrupted_range() for XFS
Date: Tue, 15 Dec 2020 20:14:14 +0800
Message-ID: <20201215121414.253660-10-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: C54234CE5CCA.AAF1D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: DPJLQM3BQ7VF3XUIUXWJZPZOIBQJZHYK
X-Message-ID-Hash: DPJLQM3BQ7VF3XUIUXWJZPZOIBQJZHYK
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DPJLQM3BQ7VF3XUIUXWJZPZOIBQJZHYK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This function is used to handle errors which may cause data lost in
filesystem.  Such as memory failure in fsdax mode.

In XFS, it requires "rmapbt" feature in order to query for files or
metadata which associated to the corrupted data.  Then we could call fs
recover functions to try to repair the corrupted data.(did not
implemented in this patchset)

After that, the memory failure also needs to notify the processes who
are using those files.

Only support data device.  Realtime device is not supported for now.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/xfs/xfs_fsops.c | 10 +++++
 fs/xfs/xfs_mount.h |  2 +
 fs/xfs/xfs_super.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index ef1d5bb88b93..0ec1b44bfe88 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -501,6 +501,16 @@ xfs_do_force_shutdown(
 "Corruption of in-memory data detected.  Shutting down filesystem");
 		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
 			xfs_stack_trace();
+	} else if (flags & SHUTDOWN_CORRUPT_META) {
+		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_CORRUPT,
+"Corruption of on-disk metadata detected.  Shutting down filesystem");
+		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
+			xfs_stack_trace();
+	} else if (flags & SHUTDOWN_CORRUPT_DATA) {
+		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_CORRUPT,
+"Corruption of on-disk file data detected.  Shutting down filesystem");
+		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
+			xfs_stack_trace();
 	} else if (logerror) {
 		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_LOGERROR,
 			"Log I/O Error Detected. Shutting down filesystem");
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index dfa429b77ee2..e36c07553486 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -274,6 +274,8 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
 #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
 #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
 #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
+#define SHUTDOWN_CORRUPT_META	0x0010  /* corrupt metadata on device */
+#define SHUTDOWN_CORRUPT_DATA	0x0020  /* corrupt file data on device */
 
 /*
  * Flags for xfs_mountfs
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index e3e229e52512..30202de7e89d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -35,6 +35,11 @@
 #include "xfs_refcount_item.h"
 #include "xfs_bmap_item.h"
 #include "xfs_reflink.h"
+#include "xfs_alloc.h"
+#include "xfs_rmap.h"
+#include "xfs_rmap_btree.h"
+#include "xfs_rtalloc.h"
+#include "xfs_bit.h"
 
 #include <linux/magic.h>
 #include <linux/fs_context.h>
@@ -1103,6 +1108,93 @@ xfs_fs_free_cached_objects(
 	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
 }
 
+static int
+xfs_corrupt_helper(
+	struct xfs_btree_cur		*cur,
+	struct xfs_rmap_irec		*rec,
+	void				*data)
+{
+	struct xfs_inode		*ip;
+	int				rc = 0;
+	int				*flags = data;
+
+	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner)) {
+		// TODO check and try to fix metadata
+		rc = -EFSCORRUPTED;
+	} else {
+		/*
+		 * Get files that incore, filter out others that are not in use.
+		 */
+		rc = xfs_iget(cur->bc_mp, cur->bc_tp, rec->rm_owner,
+			      XFS_IGET_INCORE, 0, &ip);
+		if (rc || !ip)
+			return rc;
+		if (!VFS_I(ip)->i_mapping)
+			goto out;
+
+		if (IS_DAX(VFS_I(ip)))
+			rc = mf_dax_mapping_kill_procs(VFS_I(ip)->i_mapping,
+						       rec->rm_offset, *flags);
+
+		// TODO try to fix data
+out:
+		xfs_irele(ip);
+	}
+
+	return rc;
+}
+
+static int
+xfs_fs_corrupted_range(
+	struct super_block	*sb,
+	struct block_device	*bdev,
+	loff_t			offset,
+	size_t			len,
+	void			*data)
+{
+	struct xfs_mount	*mp = XFS_M(sb);
+	struct xfs_trans	*tp = NULL;
+	struct xfs_btree_cur	*cur = NULL;
+	struct xfs_rmap_irec	rmap_low, rmap_high;
+	struct xfs_buf		*agf_bp = NULL;
+	xfs_fsblock_t		fsbno = XFS_B_TO_FSB(mp, offset);
+	xfs_filblks_t		bc = XFS_B_TO_FSB(mp, len);
+	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
+	xfs_agblock_t		agbno = XFS_FSB_TO_AGBNO(mp, fsbno);
+	int			rc = 0;
+
+	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev == bdev) {
+		xfs_warn(mp, "storage lost support not available for realtime device!");
+		return 0;
+	}
+
+	rc = xfs_trans_alloc_empty(mp, &tp);
+	if (rc)
+		return rc;
+
+	rc = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
+	if (rc)
+		return rc;
+
+	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agno);
+
+	/* Construct a range for rmap query */
+	memset(&rmap_low, 0, sizeof(rmap_low));
+	memset(&rmap_high, 0xFF, sizeof(rmap_high));
+	rmap_low.rm_startblock = rmap_high.rm_startblock = agbno;
+	rmap_low.rm_blockcount = rmap_high.rm_blockcount = bc;
+
+	rc = xfs_rmap_query_range(cur, &rmap_low, &rmap_high, xfs_corrupt_helper, data);
+	if (rc == -ECANCELED)
+		rc = 0;
+	if (rc == -EFSCORRUPTED)
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
+
+	xfs_btree_del_cursor(cur, rc);
+	xfs_trans_brelse(tp, agf_bp);
+	return rc;
+}
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
@@ -1116,6 +1208,7 @@ static const struct super_operations xfs_super_operations = {
 	.show_options		= xfs_fs_show_options,
 	.nr_cached_objects	= xfs_fs_nr_cached_objects,
 	.free_cached_objects	= xfs_fs_free_cached_objects,
+	.corrupted_range	= xfs_fs_corrupted_range,
 };
 
 static int
-- 
2.29.2


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
