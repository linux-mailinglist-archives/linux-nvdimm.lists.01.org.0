Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C01FA80
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 21:27:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5B28321265797;
	Wed, 15 May 2019 12:27:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 34CC721D0DE62
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 12:27:34 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B3C34308ED53;
 Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B80B5D728;
 Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id D1897225485; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2 17/30] fuse, dax: add fuse_conn->dax_dev field
Date: Wed, 15 May 2019 15:27:02 -0400
Message-Id: <20190515192715.18000-18-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 15 May 2019 19:27:33 +0000 (UTC)
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
Cc: swhiteho@redhat.com, dgilbert@redhat.com, stefanha@redhat.com,
 miklos@szeredi.hu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

A struct dax_device instance is a prerequisite for the DAX filesystem
APIs.  Let virtio_fs associate a dax_device with a fuse_conn.  Classic
FUSE and CUSE set the pointer to NULL, disabling DAX.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/cuse.c      | 3 ++-
 fs/fuse/fuse_i.h    | 9 ++++++++-
 fs/fuse/inode.c     | 9 ++++++---
 fs/fuse/virtio_fs.c | 1 +
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index a509747153a7..417448f11f9f 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -504,7 +504,8 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	 * Limit the cuse channel to requests that can
 	 * be represented in file->f_cred->user_ns.
 	 */
-	fuse_conn_init(&cc->fc, file->f_cred->user_ns, &fuse_dev_fiq_ops, NULL);
+	fuse_conn_init(&cc->fc, file->f_cred->user_ns, NULL, &fuse_dev_fiq_ops,
+					NULL);
 
 	fud = fuse_dev_alloc_install(&cc->fc);
 	if (!fud) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f5cb4d40b83f..46fc1a454084 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -74,6 +74,9 @@ struct fuse_mount_data {
 	unsigned max_read;
 	unsigned blksize;
 
+	/* DAX device, may be NULL */
+	struct dax_device *dax_dev;
+
 	/* fuse input queue operations */
 	const struct fuse_iqueue_ops *fiq_ops;
 
@@ -822,6 +825,9 @@ struct fuse_conn {
 
 	/** List of device instances belonging to this connection */
 	struct list_head devices;
+
+	/** DAX device, non-NULL if DAX is supported */
+	struct dax_device *dax_dev;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
@@ -1049,7 +1055,8 @@ struct fuse_conn *fuse_conn_get(struct fuse_conn *fc);
  * Initialize fuse_conn
  */
 void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
-		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv);
+			struct dax_device *dax_dev,
+			const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv);
 
 /**
  * Release reference to fuse_conn
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 731a8a74d032..42f3ac5b7521 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -603,7 +603,8 @@ static void fuse_pqueue_init(struct fuse_pqueue *fpq)
 }
 
 void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
-		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
+			struct dax_device *dax_dev,
+			const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
 {
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
@@ -628,6 +629,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	atomic64_set(&fc->attr_version, 1);
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
+	fc->dax_dev = dax_dev;
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 }
@@ -1140,8 +1142,8 @@ int fuse_fill_super_common(struct super_block *sb,
 	if (!fc)
 		goto err;
 
-	fuse_conn_init(fc, sb->s_user_ns, mount_data->fiq_ops,
-		       mount_data->fiq_priv);
+	fuse_conn_init(fc, sb->s_user_ns, mount_data->dax_dev,
+		       mount_data->fiq_ops, mount_data->fiq_priv);
 	fc->release = fuse_free_conn;
 
 	fud = fuse_dev_alloc_install(fc);
@@ -1243,6 +1245,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 		goto err_fput;
 	__set_bit(FR_BACKGROUND, &init_req->flags);
 
+	d.dax_dev = NULL;
 	d.fiq_ops = &fuse_dev_fiq_ops;
 	d.fiq_priv = NULL;
 	d.fudptr = &file->private_data;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index e76e0f5dce40..a23a1fb67217 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -866,6 +866,7 @@ static int virtio_fs_fill_super(struct super_block *sb, void *data,
  		goto err_free_fuse_devs;
 	__set_bit(FR_BACKGROUND, &init_req->flags);
 
+	d.dax_dev = NULL;
 	d.fiq_ops = &virtio_fs_fiq_ops;
 	d.fiq_priv = fs;
 	d.fudptr = (void **)&fs->vqs[VQ_REQUEST].fud;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
