Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B5F2BFD9F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Nov 2020 01:41:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C178B100ED4A8;
	Sun, 22 Nov 2020 16:41:45 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 31DF7100ED487
	for <linux-nvdimm@lists.01.org>; Sun, 22 Nov 2020 16:41:43 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.78,361,1599494400";
   d="scan'208";a="101635236"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Nov 2020 08:41:41 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id E1F334CE5458;
	Mon, 23 Nov 2020 08:41:39 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 23 Nov 2020 08:41:41 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 23 Nov 2020 08:41:19 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
Subject: [RFC PATCH v2 1/6] fs: introduce ->storage_lost() for memory-failure
Date: Mon, 23 Nov 2020 08:41:11 +0800
Message-ID: <20201123004116.2453-2-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: E1F334CE5458.AB364
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: JEP3HW6VQQJVV3SBMTCQBYYYIXX72DTC
X-Message-ID-Hash: JEP3HW6VQQJVV3SBMTCQBYYYIXX72DTC
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JEP3HW6VQQJVV3SBMTCQBYYYIXX72DTC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This function is used to handle errors which may cause data lost in
filesystem.  Such as memory-failure in fsdax mode.

In XFS, it requires "rmapbt" feature in order to query for files or
metadata which associated to the broken block.  Then we could call fs
recover functions to try to repair the damaged data.(did not implemented
in this patch)

After that, the memory-failure also needs to kill processes who are
using those files.  The struct mf_recover_controller is created to store
necessary parameters.

Only support data device.  Realtime device is not supported for now.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/xfs/xfs_super.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 include/linux/mm.h |  6 ++++
 3 files changed, 95 insertions(+)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index e3e229e52512..f9a109217a80 100644
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
@@ -1103,6 +1108,87 @@ xfs_fs_free_cached_objects(
 	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
 }
 
+static int
+xfs_storage_lost_helper(
+	struct xfs_btree_cur		*cur,
+	struct xfs_rmap_irec		*rec,
+	void				*priv)
+{
+	struct xfs_inode		*ip;
+	struct mf_recover_controller	*mfrc = priv;
+	int rc = 0;
+
+	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner)) {
+		// TODO check and try to fix metadata
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
+		rc = mfrc->recover_fn(mfrc->pfn, mfrc->flags,
+				      VFS_I(ip)->i_mapping, rec->rm_offset);
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
+xfs_fs_storage_lost(
+	struct super_block	*sb,
+	struct block_device	*bdev,
+	loff_t			offset,
+	void			*priv)
+{
+	struct xfs_mount	*mp = XFS_M(sb);
+	struct xfs_trans	*tp = NULL;
+	struct xfs_btree_cur	*cur = NULL;
+	struct xfs_rmap_irec	rmap_low, rmap_high;
+	struct xfs_buf		*agf_bp = NULL;
+	xfs_fsblock_t		fsbno = XFS_B_TO_FSB(mp, offset);
+	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
+	xfs_agblock_t		agbno = XFS_FSB_TO_AGBNO(mp, fsbno);
+	int			error = 0;
+
+	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev == bdev) {
+		xfs_warn(mp, "storage lost support not available for realtime device!");
+		return 0;
+	}
+
+	error = xfs_trans_alloc_empty(mp, &tp);
+	if (error)
+		return error;
+
+	error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
+	if (error)
+		return error;
+
+	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agno);
+
+	/* Construct a range for rmap query */
+	memset(&rmap_low, 0, sizeof(rmap_low));
+	memset(&rmap_high, 0xFF, sizeof(rmap_high));
+	rmap_low.rm_startblock = rmap_high.rm_startblock = agbno;
+
+	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high,
+				     xfs_storage_lost_helper, priv);
+	if (error == -ECANCELED)
+		error = 0;
+
+	xfs_btree_del_cursor(cur, error);
+	xfs_trans_brelse(tp, agf_bp);
+	return error;
+}
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
@@ -1116,6 +1202,7 @@ static const struct super_operations xfs_super_operations = {
 	.show_options		= xfs_fs_show_options,
 	.nr_cached_objects	= xfs_fs_nr_cached_objects,
 	.free_cached_objects	= xfs_fs_free_cached_objects,
+	.storage_lost		= xfs_fs_storage_lost,
 };
 
 static int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0bd126418bb6..8c4f753e3ed9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1949,6 +1949,8 @@ struct super_operations {
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
+	int (*storage_lost)(struct super_block *sb, struct block_device *bdev,
+			    loff_t offset, void *priv);
 };
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aaf..872b51ebe57b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3031,6 +3031,12 @@ extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 
+struct mf_recover_controller {
+	int (*recover_fn)(unsigned long pfn, int flags,
+		struct address_space *mapping, pgoff_t index);
+	unsigned long pfn;
+	int flags;
+};
 
 /*
  * Error handlers for various types of pages.
-- 
2.29.2


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
