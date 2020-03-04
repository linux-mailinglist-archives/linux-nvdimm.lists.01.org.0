Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3216A1795DB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 17:59:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B50210FC36D6;
	Wed,  4 Mar 2020 09:00:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 541F710FC36CE
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583341154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KY9e43vCev2zE2Yxdg5nKlzLt1NU+Taon8m9QnnT7kk=;
	b=C0ULF7EZdedmzlyrWGNDRIaSXsufJv2hPpQyQygJndP04Ck3sH4llQPBE6b7xW5gz72CsL
	LyEZiqje0S/jCqwQAxDBMOHKwAg1tmsIkIuaadM/pohLPJ6OFs50JtXldJZsxxAksMB1VQ
	enmXqrVMfR3gqAuXlO1aWhZGKnpFJAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-pYshyl-CPJaPydGj93fLUg-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: pYshyl-CPJaPydGj93fLUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16E471005510;
	Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D8FC15C1D4;
	Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 61E7F225810; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH 10/20] fuse,virtiofs: Keep a list of free dax memory ranges
Date: Wed,  4 Mar 2020 11:58:35 -0500
Message-Id: <20200304165845.3081-11-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: WN4E4ZZOMZYJHGMEWFUNPZ35OEIW6QRP
X-Message-ID-Hash: WN4E4ZZOMZYJHGMEWFUNPZ35OEIW6QRP
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com, Peng Tao <tao.peng@linux.alibaba.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WN4E4ZZOMZYJHGMEWFUNPZ35OEIW6QRP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Divide the dax memory range into fixed size ranges (2MB for now) and put
them in a list. This will track free ranges. Once an inode requires a
free range, we will take one from here and put it in interval-tree
of ranges assigned to inode.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
---
 fs/fuse/fuse_i.h    | 22 ++++++++++++
 fs/fuse/inode.c     | 88 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/virtio_fs.c |  2 ++
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1fe5065a2902..edd3136c11f7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -47,6 +47,10 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/* Default memory range size, 2MB */
+#define FUSE_DAX_MEM_RANGE_SZ	(2*1024*1024)
+#define FUSE_DAX_MEM_RANGE_PAGES	(FUSE_DAX_MEM_RANGE_SZ/PAGE_SIZE)
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
@@ -63,6 +67,18 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+/** Translation information for file offsets to DAX window offsets */
+struct fuse_dax_mapping {
+	/* Will connect in fc->free_ranges to keep track of free memory */
+	struct list_head list;
+
+	/** Position in DAX window */
+	u64 window_offset;
+
+	/** Length of mapping, in bytes */
+	loff_t length;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -765,6 +781,12 @@ struct fuse_conn {
 
 	/** DAX device, non-NULL if DAX is supported */
 	struct dax_device *dax_dev;
+
+	/*
+	 * DAX Window Free Ranges
+	 */
+	long nr_free_ranges;
+	struct list_head free_ranges;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 84295fac4ff3..0ba092bf0b6d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -23,6 +23,8 @@
 #include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
+#include <linux/dax.h>
+#include <linux/pfn_t.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -600,6 +602,76 @@ static void fuse_pqueue_init(struct fuse_pqueue *fpq)
 	fpq->connected = 1;
 }
 
+static void fuse_free_dax_mem_ranges(struct list_head *mem_list)
+{
+	struct fuse_dax_mapping *range, *temp;
+
+	/* Free All allocated elements */
+	list_for_each_entry_safe(range, temp, mem_list, list) {
+		list_del(&range->list);
+		kfree(range);
+	}
+}
+
+#ifdef CONFIG_FS_DAX
+static int fuse_dax_mem_range_init(struct fuse_conn *fc,
+				   struct dax_device *dax_dev)
+{
+	long nr_pages, nr_ranges;
+	void *kaddr;
+	pfn_t pfn;
+	struct fuse_dax_mapping *range;
+	LIST_HEAD(mem_ranges);
+	phys_addr_t phys_addr;
+	int ret = 0, id;
+	size_t dax_size = -1;
+	unsigned long i;
+
+	id = dax_read_lock();
+	nr_pages = dax_direct_access(dax_dev, 0, PHYS_PFN(dax_size), &kaddr,
+					&pfn);
+	dax_read_unlock(id);
+	if (nr_pages < 0) {
+		pr_debug("dax_direct_access() returned %ld\n", nr_pages);
+		return nr_pages;
+	}
+
+	phys_addr = pfn_t_to_phys(pfn);
+	nr_ranges = nr_pages/FUSE_DAX_MEM_RANGE_PAGES;
+	printk("fuse_dax_mem_range_init(): dax mapped %ld pages. nr_ranges=%ld\n", nr_pages, nr_ranges);
+
+	for (i = 0; i < nr_ranges; i++) {
+		range = kzalloc(sizeof(struct fuse_dax_mapping), GFP_KERNEL);
+		if (!range) {
+			pr_debug("memory allocation for mem_range failed.\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
+		/* TODO: This offset only works if virtio-fs driver is not
+		 * having some memory hidden at the beginning. This needs
+		 * better handling
+		 */
+		range->window_offset = i * FUSE_DAX_MEM_RANGE_SZ;
+		range->length = FUSE_DAX_MEM_RANGE_SZ;
+		list_add_tail(&range->list, &mem_ranges);
+	}
+
+	list_replace_init(&mem_ranges, &fc->free_ranges);
+	fc->nr_free_ranges = nr_ranges;
+	return 0;
+out_err:
+	/* Free All allocated elements */
+	fuse_free_dax_mem_ranges(&mem_ranges);
+	return ret;
+}
+#else /* !CONFIG_FS_DAX */
+static inline int fuse_dax_mem_range_init(struct fuse_conn *fc,
+					  struct dax_device *dax_dev)
+{
+	return 0;
+}
+#endif /* CONFIG_FS_DAX */
+
 void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
 {
@@ -627,6 +699,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
+	INIT_LIST_HEAD(&fc->free_ranges);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
@@ -635,6 +708,8 @@ void fuse_conn_put(struct fuse_conn *fc)
 	if (refcount_dec_and_test(&fc->count)) {
 		struct fuse_iqueue *fiq = &fc->iq;
 
+		if (fc->dax_dev)
+			fuse_free_dax_mem_ranges(&fc->free_ranges);
 		if (fiq->ops->release)
 			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);
@@ -1160,9 +1235,17 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_xattr = fuse_no_acl_xattr_handlers;
 
+	if (ctx->dax_dev) {
+		err = fuse_dax_mem_range_init(fc, ctx->dax_dev);
+		if (err) {
+			pr_debug("fuse_dax_mem_range_init() returned %d\n", err);
+			goto err_free_ranges;
+		}
+	}
+
 	fud = fuse_dev_alloc_install(fc);
 	if (!fud)
-		goto err;
+		goto err_free_ranges;
 
 	fc->dev = sb->s_dev;
 	fc->sb = sb;
@@ -1218,6 +1301,9 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	dput(root_dentry);
  err_dev_free:
 	fuse_dev_free(fud);
+ err_free_ranges:
+	if (ctx->dax_dev)
+		fuse_free_dax_mem_ranges(&fc->free_ranges);
  err:
 	return err;
 }
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b0574b208cd5..8423b674c81e 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -710,6 +710,8 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	phys_addr_t offset = PFN_PHYS(pgoff);
 	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
 
+	pr_debug("virtio_fs_direct_access(): called. nr_pages=%ld max_nr_pages=%zu\n", nr_pages, max_nr_pages);
+
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
