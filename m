Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A312E8CE
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Apr 2019 19:27:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E0552122C2E0;
	Mon, 29 Apr 2019 10:27:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4CDB321945DF1
 for <linux-nvdimm@lists.01.org>; Mon, 29 Apr 2019 10:27:13 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E5F2DAD78;
 Mon, 29 Apr 2019 17:27:11 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/18] btrfs: basic dax read
Date: Mon, 29 Apr 2019 12:26:34 -0500
Message-Id: <20190429172649.8288-4-rgoldwyn@suse.de>
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

Perform a basic read using iomap support. The btrfs_iomap_begin()
finds the extent at the position and fills the iomap data
structure with the values.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/Makefile |  1 +
 fs/btrfs/ctree.h  |  5 +++++
 fs/btrfs/dax.c    | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/file.c   | 11 ++++++++++-
 4 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/dax.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index ca693dd554e9..1fa77b875ae9 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -12,6 +12,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o
 
+btrfs-$(CONFIG_FS_DAX) += dax.o
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9512f49262dd..b7bbe5130a3b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3795,6 +3795,11 @@ int btrfs_reada_wait(void *handle);
 void btrfs_reada_detach(void *handle);
 int btree_readahead_hook(struct extent_buffer *eb, int err);
 
+#ifdef CONFIG_FS_DAX
+/* dax.c */
+ssize_t btrfs_file_dax_read(struct kiocb *iocb, struct iov_iter *to);
+#endif /* CONFIG_FS_DAX */
+
 static inline int is_fstree(u64 rootid)
 {
 	if (rootid == BTRFS_FS_TREE_OBJECTID ||
diff --git a/fs/btrfs/dax.c b/fs/btrfs/dax.c
new file mode 100644
index 000000000000..bf3d46b0acb6
--- /dev/null
+++ b/fs/btrfs/dax.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAX support for BTRFS
+ *
+ * Copyright (c) 2019  SUSE Linux
+ * Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
+ */
+
+#ifdef CONFIG_FS_DAX
+#include <linux/dax.h>
+#include <linux/iomap.h>
+#include "ctree.h"
+#include "btrfs_inode.h"
+
+static int btrfs_iomap_begin(struct inode *inode, loff_t pos,
+		loff_t length, unsigned flags, struct iomap *iomap)
+{
+	struct extent_map *em;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, pos, length, 0);
+	if (em->block_start == EXTENT_MAP_HOLE) {
+		iomap->type = IOMAP_HOLE;
+		return 0;
+	}
+	iomap->type = IOMAP_MAPPED;
+	iomap->bdev = em->bdev;
+	iomap->dax_dev = fs_info->dax_dev;
+	iomap->offset = em->start;
+	iomap->length = em->len;
+	iomap->addr = em->block_start;
+	return 0;
+}
+
+static const struct iomap_ops btrfs_iomap_ops = {
+	.iomap_begin		= btrfs_iomap_begin,
+};
+
+ssize_t btrfs_file_dax_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	ssize_t ret;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	inode_lock_shared(inode);
+	ret = dax_iomap_rw(iocb, to, &btrfs_iomap_ops);
+	inode_unlock_shared(inode);
+
+	return ret;
+}
+#endif /* CONFIG_FS_DAX */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 34fe8a58b0e9..9194591f9eea 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3288,9 +3288,18 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
+static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(file_inode(iocb->ki_filp)))
+		return btrfs_file_dax_read(iocb, to);
+#endif
+	return generic_file_read_iter(iocb, to);
+}
+
 const struct file_operations btrfs_file_operations = {
 	.llseek		= btrfs_file_llseek,
-	.read_iter      = generic_file_read_iter,
+	.read_iter      = btrfs_file_read_iter,
 	.splice_read	= generic_file_splice_read,
 	.write_iter	= btrfs_file_write_iter,
 	.mmap		= btrfs_file_mmap,
-- 
2.16.4

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
