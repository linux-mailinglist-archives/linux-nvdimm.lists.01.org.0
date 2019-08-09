Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE78188650
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Aug 2019 00:58:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 952AC2131BA53;
	Fri,  9 Aug 2019 16:01:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4756521309DCA
 for <linux-nvdimm@lists.01.org>; Fri,  9 Aug 2019 16:01:29 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:58:47 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; d="scan'208";a="193483400"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:58:47 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 05/19] fs/ext4: Teach ext4 to break layout leases
Date: Fri,  9 Aug 2019 15:58:19 -0700
Message-Id: <20190809225833.6657-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809225833.6657-1-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
MIME-Version: 1.0
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
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Dave Chinner <david@fromorbit.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Ira Weiny <ira.weiny@intel.com>

ext4 must attempt to break a layout lease if it is held to know if the
layout can be modified.

Split out the logic to determine if a mapping is DAX, export it, and then
break layout leases if a mapping is DAX.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC v1:

	Based on feedback from Dave Chinner, add support to fail all
	other layout breaks when a lease is held.

 fs/dax.c            | 23 ++++++++++++++++-------
 fs/ext4/inode.c     |  7 +++++++
 include/linux/dax.h |  6 ++++++
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index b64964ef44f6..a14ec32255d8 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -557,6 +557,21 @@ static void *grab_mapping_entry(struct xa_state *xas,
 	return xa_mk_internal(VM_FAULT_FALLBACK);
 }
 
+bool dax_mapping_is_dax(struct address_space *mapping)
+{
+	/*
+	 * In the 'limited' case get_user_pages() for dax is disabled.
+	 */
+	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
+		return false;
+
+	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(dax_mapping_is_dax);
+
 /**
  * dax_layout_busy_page - find first pinned page in @mapping
  * @mapping: address space to scan for a page with ref count > 1
@@ -579,13 +594,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	unsigned int scanned = 0;
 	struct page *page = NULL;
 
-	/*
-	 * In the 'limited' case get_user_pages() for dax is disabled.
-	 */
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return NULL;
-
-	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
+	if (!dax_mapping_is_dax(mapping))
 		return NULL;
 
 	/*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b2c8d09acf65..f08f48de52c5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4271,6 +4271,13 @@ int ext4_break_layouts(struct inode *inode)
 	if (WARN_ON_ONCE(!rwsem_is_locked(&ei->i_mmap_sem)))
 		return -EINVAL;
 
+	/* Break layout leases if active */
+	if (dax_mapping_is_dax(inode->i_mapping)) {
+		error = break_layout(inode, true);
+		if (error)
+			return error;
+	}
+
 	do {
 		page = dax_layout_busy_page(inode->i_mapping);
 		if (!page)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9bd8528bd305..da0768b34b48 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -143,6 +143,7 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
 int dax_writeback_mapping_range(struct address_space *mapping,
 		struct block_device *bdev, struct writeback_control *wbc);
 
+bool dax_mapping_is_dax(struct address_space *mapping);
 struct page *dax_layout_busy_page(struct address_space *mapping);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
@@ -174,6 +175,11 @@ static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 	return NULL;
 }
 
+static inline bool dax_mapping_is_dax(struct address_space *mapping)
+{
+	return false;
+}
+
 static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 {
 	return NULL;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
