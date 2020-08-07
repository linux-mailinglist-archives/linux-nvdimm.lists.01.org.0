Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E823EDD8
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Aug 2020 15:14:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BEE5512C2F614;
	Fri,  7 Aug 2020 06:13:59 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 3C58712C2F600
	for <linux-nvdimm@lists.01.org>; Fri,  7 Aug 2020 06:13:57 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.75,445,1589212800";
   d="scan'208";a="97774935"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Aug 2020 21:13:54 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
	by cn.fujitsu.com (Postfix) with ESMTP id C0FA64CE34EF;
	Fri,  7 Aug 2020 21:13:51 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 7 Aug 2020 21:13:42 +0800
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 7 Aug 2020 21:13:43 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 7 Aug 2020 21:13:41 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>
Subject: [RFC PATCH 6/8] fsdax: dedup file range to use a compare function
Date: Fri, 7 Aug 2020 21:13:34 +0800
Message-ID: <20200807131336.318774-7-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: C0FA64CE34EF.AE9E3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: P5ZOWOX2WG4NXA4EFYH3RTSVAOCDP5GJ
X-Message-ID-Hash: P5ZOWOX2WG4NXA4EFYH3RTSVAOCDP5GJ
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P5ZOWOX2WG4NXA4EFYH3RTSVAOCDP5GJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With dax we cannot deal with readpage() etc. So, we create a
funciton callback to perform the file data comparison and pass
it to generic_remap_file_range_prep() so it can use iomap-based
functions.

This may not be the best way to solve this. Suggestions welcome.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/btrfs/reflink.c   |  3 +-
 fs/dax.c             | 67 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ocfs2/file.c      |  2 +-
 fs/read_write.c      | 11 ++++----
 fs/xfs/xfs_reflink.c |  2 +-
 include/linux/dax.h  |  5 ++++
 include/linux/fs.h   |  9 +++++-
 7 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 040009d1cc31..d0412bc338da 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -765,7 +765,8 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 		return ret;
 
 	return generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
-					    len, remap_flags);
+					    len, remap_flags,
+					    vfs_dedupe_file_range_compare);
 }
 
 loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
diff --git a/fs/dax.c b/fs/dax.c
index 28b8e23b11ac..80a9946fd25a 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -30,6 +30,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/fs_dax.h>
 
+#define MIN(a, b) (((a) < (b)) ? (a) : (b))
+
 static inline unsigned int pe_order(enum page_entry_size pe_size)
 {
 	if (pe_size == PE_SIZE_PTE)
@@ -1874,3 +1876,68 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 	return dax_insert_pfn_mkwrite(vmf, pfn, order);
 }
 EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
+
+int dax_file_range_compare(struct inode *src, loff_t srcoff, struct inode *dest,
+		loff_t destoff, loff_t len, bool *is_same,
+		const struct iomap_ops *ops)
+{
+	void *saddr, *daddr;
+	struct iomap smap = { 0 };
+	struct iomap dmap = { 0 };
+	bool same = false;
+	loff_t cmp_len;
+	int id, ret = 0;
+
+	id = dax_read_lock();
+	while (len) {
+		ret = ops->iomap_begin(src, srcoff, len, 0, &smap, NULL);
+		if (ret < 0)
+			goto out_src;
+		cmp_len = MIN(len, smap.offset + smap.length - srcoff);
+
+		ret = ops->iomap_begin(dest, destoff, cmp_len, 0, &dmap, NULL);
+		if (ret < 0)
+			goto out_dest;
+		cmp_len = MIN(cmp_len, dmap.offset + dmap.length - destoff);
+
+		if (smap.type == IOMAP_HOLE && dmap.type == IOMAP_HOLE)
+			goto next;
+
+		if (smap.type == IOMAP_HOLE || dmap.type == IOMAP_HOLE) {
+			same = false;
+			goto next;
+		}
+
+		ret = dax_iomap_direct_access(&smap, srcoff,
+			  ALIGN(srcoff + cmp_len, PAGE_SIZE), NULL, &saddr);
+		if (ret < 0)
+			goto out_dest;
+
+		ret = dax_iomap_direct_access(&dmap, destoff,
+			  ALIGN(destoff + cmp_len, PAGE_SIZE), NULL, &daddr);
+		if (ret < 0)
+			goto out_dest;
+
+		same = !memcmp(saddr, daddr, cmp_len);
+		if (!same)
+			break;
+next:
+		len -= cmp_len;
+		srcoff += cmp_len;
+		destoff += cmp_len;
+out_dest:
+		if (ops->iomap_end)
+			ops->iomap_end(dest, destoff, cmp_len, 0, 0, &dmap);
+out_src:
+		if (ops->iomap_end)
+			ops->iomap_end(src, srcoff, len, 0, 0, &smap);
+
+		if (ret < 0)
+			goto out;
+	}
+	*is_same = same;
+out:
+	dax_read_unlock(id);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dax_file_range_compare);
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 85979e2214b3..9d101f129d16 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2591,7 +2591,7 @@ static loff_t ocfs2_remap_file_range(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 
 	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
-			&len, remap_flags);
+			&len, remap_flags, vfs_dedupe_file_range_compare);
 	if (ret < 0 || len == 0)
 		goto out_unlock;
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 4fb797822567..2974a624f232 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1927,7 +1927,7 @@ static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
  * Compare extents of two files to see if they are the same.
  * Caller must have locked both inodes to prevent write races.
  */
-static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 					 struct inode *dest, loff_t destoff,
 					 loff_t len, bool *is_same)
 {
@@ -2008,6 +2008,7 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 out_error:
 	return error;
 }
+EXPORT_SYMBOL_GPL(vfs_dedupe_file_range_compare);
 
 /*
  * Check that the two inodes are eligible for cloning, the ranges make
@@ -2019,7 +2020,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
  */
 int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
-				  loff_t *len, unsigned int remap_flags)
+				  loff_t *len, unsigned int remap_flags,
+				  compare_range_t compare)
 {
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
@@ -2078,9 +2080,8 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	 */
 	if (remap_flags & REMAP_FILE_DEDUP) {
 		bool		is_same = false;
-
-		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
-				inode_out, pos_out, *len, &is_same);
+		ret = (*compare)(inode_in, pos_in,
+			inode_out, pos_out, *len, &is_same);
 		if (ret)
 			return ret;
 		if (!is_same)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 107bf2a2f344..792217cd1e64 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1338,7 +1338,7 @@ xfs_reflink_remap_prep(
 		goto out_unlock;
 
 	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
-			len, remap_flags);
+			len, remap_flags, vfs_dedupe_file_range_compare);
 	if (ret < 0 || *len == 0)
 		goto out_unlock;
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index d6d9f4b721bc..607e21933928 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -223,6 +223,11 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
 			struct iomap *iomap);
+int dax_file_range_compare(struct inode *src, loff_t srcoff,
+			   struct inode *dest, loff_t destoff,
+			   loff_t len, bool *is_same,
+			   const struct iomap_ops *ops);
+
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 81de3d2739b9..c2d985295db5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1924,13 +1924,20 @@ extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
 		unsigned long, loff_t *, rwf_t);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
+extern int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+					 struct inode *dest, loff_t destoff,
+					 loff_t len, bool *is_same);
+typedef int (*compare_range_t)(struct inode *src, loff_t srcpos,
+			       struct inode *dest, loff_t destpos,
+			       loff_t len, bool *is_same);
 extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				       struct file *file_out, loff_t pos_out,
 				       size_t len, unsigned int flags);
 extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 					 struct file *file_out, loff_t pos_out,
 					 loff_t *count,
-					 unsigned int remap_flags);
+					 unsigned int remap_flags,
+					 compare_range_t cmp);
 extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  loff_t len, unsigned int remap_flags);
-- 
2.27.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
