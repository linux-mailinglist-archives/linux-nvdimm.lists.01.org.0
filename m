Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCA6E8DB
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Apr 2019 19:27:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A3C42122C2E8;
	Mon, 29 Apr 2019 10:27:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9840F2194EB7E
 for <linux-nvdimm@lists.01.org>; Mon, 29 Apr 2019 10:27:25 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 41383ADDB;
 Mon, 29 Apr 2019 17:27:24 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/18] btrfs: Add dax specific address_space_operations
Date: Mon, 29 Apr 2019 12:26:40 -0500
Message-Id: <20190429172649.8288-10-rgoldwyn@suse.de>
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

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index af4b56cba104..05714ffc4894 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -28,6 +28,7 @@
 #include <linux/magic.h>
 #include <linux/iversion.h>
 #include <linux/swap.h>
+#include <linux/dax.h>
 #include <asm/unaligned.h>
 #include "ctree.h"
 #include "disk-io.h"
@@ -65,6 +66,7 @@ static const struct inode_operations btrfs_dir_ro_inode_operations;
 static const struct inode_operations btrfs_special_inode_operations;
 static const struct inode_operations btrfs_file_inode_operations;
 static const struct address_space_operations btrfs_aops;
+static const struct address_space_operations btrfs_dax_aops;
 static const struct file_operations btrfs_dir_file_operations;
 static const struct extent_io_ops btrfs_extent_io_ops;
 
@@ -3757,7 +3759,10 @@ static int btrfs_read_locked_inode(struct inode *inode,
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
-		inode->i_mapping->a_ops = &btrfs_aops;
+		if (btrfs_test_opt(fs_info, DAX))
+			inode->i_mapping->a_ops = &btrfs_dax_aops;
+		else
+			inode->i_mapping->a_ops = &btrfs_aops;
 		BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
 		inode->i_fop = &btrfs_file_operations;
 		inode->i_op = &btrfs_file_inode_operations;
@@ -3778,6 +3783,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	}
 
 	btrfs_sync_inode_flags_to_i_flags(inode);
+
 	return 0;
 }
 
@@ -6538,7 +6544,10 @@ static int btrfs_create(struct inode *dir, struct dentry *dentry,
 	*/
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
-	inode->i_mapping->a_ops = &btrfs_aops;
+	if (IS_DAX(inode) && S_ISREG(mode))
+		inode->i_mapping->a_ops = &btrfs_dax_aops;
+	else
+		inode->i_mapping->a_ops = &btrfs_aops;
 
 	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
@@ -8665,6 +8674,15 @@ static int btrfs_writepages(struct address_space *mapping,
 	return extent_writepages(mapping, wbc);
 }
 
+static int btrfs_dax_writepages(struct address_space *mapping,
+			    struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	return dax_writeback_mapping_range(mapping, fs_info->fs_devices->latest_bdev,
+			wbc);
+}
+
 static int
 btrfs_readpages(struct file *file, struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
@@ -10436,7 +10454,10 @@ static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
 
-	inode->i_mapping->a_ops = &btrfs_aops;
+	if (IS_DAX(inode))
+		inode->i_mapping->a_ops = &btrfs_dax_aops;
+	else
+		inode->i_mapping->a_ops = &btrfs_aops;
 	BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
 
 	ret = btrfs_init_inode_security(trans, inode, dir, NULL);
@@ -10892,6 +10913,13 @@ static const struct address_space_operations btrfs_aops = {
 	.swap_deactivate = btrfs_swap_deactivate,
 };
 
+static const struct address_space_operations btrfs_dax_aops = {
+	.writepages             = btrfs_dax_writepages,
+	.direct_IO              = noop_direct_IO,
+	.set_page_dirty         = noop_set_page_dirty,
+	.invalidatepage         = noop_invalidatepage,
+};
+
 static const struct inode_operations btrfs_file_inode_operations = {
 	.getattr	= btrfs_getattr,
 	.setattr	= btrfs_setattr,
-- 
2.16.4

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
