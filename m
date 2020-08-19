Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663AB24A90A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 00:21:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 34261134BE04F;
	Wed, 19 Aug 2020 15:21:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AA740134BE04A
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1597875665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2zRPiRf1LuVvr4XUg9MR8uGhP29GZ3Nl8VTq3KJoB8=;
	b=jSxurZSmXD0xmCR47m7bj2DQQu/J2fw3YtbilpOYbyY3KLl+Ooj1ZLjtEKDR37j496txlX
	NJ45QQuSMIkPdJ9biyg2dfSNA+qa6vgEAUuI+8HF4Mlbnc9amh88zPZDbR3ckXTD/T9VE4
	D/of74vuY7W8pJW+T5p5TgY4+z3r6qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-qM5crSEtOOKMfT2xiQSndw-1; Wed, 19 Aug 2020 18:21:02 -0400
X-MC-Unique: qM5crSEtOOKMfT2xiQSndw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD321425D0;
	Wed, 19 Aug 2020 22:21:01 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 74E567E307;
	Wed, 19 Aug 2020 22:21:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 028AF2256E7; Wed, 19 Aug 2020 18:20:54 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com
Subject: [PATCH v3 09/18] fuse,virtiofs: Add a mount option to enable dax
Date: Wed, 19 Aug 2020 18:19:47 -0400
Message-Id: <20200819221956.845195-10-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: VWMMVYMM45ZASLVIOHUUY37CSQDPY22A
X-Message-ID-Hash: VWMMVYMM45ZASLVIOHUUY37CSQDPY22A
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VWMMVYMM45ZASLVIOHUUY37CSQDPY22A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a mount option to allow using dax with virtio_fs.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h    |  7 ++++
 fs/fuse/inode.c     |  3 ++
 fs/fuse/virtio_fs.c | 82 +++++++++++++++++++++++++++++++++++++--------
 3 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index cf5e675100ec..04fdd7c41bd1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -486,10 +486,14 @@ struct fuse_fs_context {
 	bool destroy:1;
 	bool no_control:1;
 	bool no_force_umount:1;
+	bool dax:1;
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
 
+	/* DAX device, may be NULL */
+	struct dax_device *dax_dev;
+
 	/* fuse_dev pointer to fill in, should contain NULL on entry */
 	void **fudptr;
 };
@@ -761,6 +765,9 @@ struct fuse_conn {
 
 	/** List of device instances belonging to this connection */
 	struct list_head devices;
+
+	/** DAX device, non-NULL if DAX is supported */
+	struct dax_device *dax_dev;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2ac5713c4c32..beac337ccc10 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -589,6 +589,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",max_read=%u", fc->max_read);
 	if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
 		seq_printf(m, ",blksize=%lu", sb->s_blocksize);
+	if (fc->dax_dev)
+		seq_printf(m, ",dax");
 	return 0;
 }
 
@@ -1207,6 +1209,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fc->dax_dev = ctx->dax_dev;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 0fd3b5cecc5f..741cad4abad8 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -13,6 +13,7 @@
 #include <linux/virtio_fs.h>
 #include <linux/delay.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/highmem.h>
 #include <linux/uio.h>
 #include "fuse_i.h"
@@ -81,6 +82,45 @@ struct virtio_fs_req_work {
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight);
 
+enum {
+	OPT_DAX,
+};
+
+static const struct fs_parameter_spec virtio_fs_parameters[] = {
+	fsparam_flag	("dax",		OPT_DAX),
+	{}
+};
+
+static int virtio_fs_parse_param(struct fs_context *fc,
+				 struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	struct fuse_fs_context *ctx = fc->fs_private;
+	int opt;
+
+	opt = fs_parse(fc, virtio_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case OPT_DAX:
+		ctx->dax = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void virtio_fs_free_fc(struct fs_context *fc)
+{
+	struct fuse_fs_context *ctx = fc->fs_private;
+
+	if (ctx)
+		kfree(ctx);
+}
+
 static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
 {
 	struct virtio_fs *fs = vq->vdev->priv;
@@ -1220,23 +1260,27 @@ static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 	.release			= virtio_fs_fiq_release,
 };
 
-static int virtio_fs_fill_super(struct super_block *sb)
+static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
+{
+	ctx->rootmode = S_IFDIR;
+	ctx->default_permissions = 1;
+	ctx->allow_other = 1;
+	ctx->max_read = UINT_MAX;
+	ctx->blksize = 512;
+	ctx->destroy = true;
+	ctx->no_control = true;
+	ctx->no_force_umount = true;
+}
+
+static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 	struct virtio_fs *fs = fc->iq.priv;
+	struct fuse_fs_context *ctx = fsc->fs_private;
 	unsigned int i;
 	int err;
-	struct fuse_fs_context ctx = {
-		.rootmode = S_IFDIR,
-		.default_permissions = 1,
-		.allow_other = 1,
-		.max_read = UINT_MAX,
-		.blksize = 512,
-		.destroy = true,
-		.no_control = true,
-		.no_force_umount = true,
-	};
 
+	virtio_fs_ctx_set_defaults(ctx);
 	mutex_lock(&virtio_fs_mutex);
 
 	/* After holding mutex, make sure virtiofs device is still there.
@@ -1260,8 +1304,10 @@ static int virtio_fs_fill_super(struct super_block *sb)
 	}
 
 	/* virtiofs allocates and installs its own fuse devices */
-	ctx.fudptr = NULL;
-	err = fuse_fill_super_common(sb, &ctx);
+	ctx->fudptr = NULL;
+	if (ctx->dax)
+		ctx->dax_dev = fs->dax_dev;
+	err = fuse_fill_super_common(sb, ctx);
 	if (err < 0)
 		goto err_free_fuse_devs;
 
@@ -1372,7 +1418,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 		return PTR_ERR(sb);
 
 	if (!sb->s_root) {
-		err = virtio_fs_fill_super(sb);
+		err = virtio_fs_fill_super(sb, fsc);
 		if (err) {
 			deactivate_locked_super(sb);
 			return err;
@@ -1387,11 +1433,19 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 }
 
 static const struct fs_context_operations virtio_fs_context_ops = {
+	.free		= virtio_fs_free_fc,
+	.parse_param	= virtio_fs_parse_param,
 	.get_tree	= virtio_fs_get_tree,
 };
 
 static int virtio_fs_init_fs_context(struct fs_context *fsc)
 {
+	struct fuse_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct fuse_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	fsc->fs_private = ctx;
 	fsc->ops = &virtio_fs_context_ops;
 	return 0;
 }
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
