Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2E124A912
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 00:21:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB68A134BE048;
	Wed, 19 Aug 2020 15:21:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 660F91347A1B8
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1597875667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7BHCNrifyORFER8+gFdJ2TjH200N06hlZvPVhYaSWtA=;
	b=FFX+c0HRawYM4Ds4QBvhmXSCQvKD2NfyyJdkKThFZRGRmb3Q97QoX5RJF+YXN1I9CVu4cV
	zLAMs4Z8SKDWrxbU/mhpaPdLf2SYZBEXObmjXY3aGLjDq0DtoAasUUHuph+S86jPtuvDQV
	e6GW5MI3EsUnxeFDBS3/fsC/w5Ac20w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-ZBJUgEHHMnyxy6TiOXKC9g-1; Wed, 19 Aug 2020 18:21:05 -0400
X-MC-Unique: ZBJUgEHHMnyxy6TiOXKC9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D2BE1885D89;
	Wed, 19 Aug 2020 22:21:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7027D756CA;
	Wed, 19 Aug 2020 22:21:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id EC3262256E5; Wed, 19 Aug 2020 18:20:53 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com
Subject: [PATCH v3 07/18] fuse: Get rid of no_mount_options
Date: Wed, 19 Aug 2020 18:19:45 -0400
Message-Id: <20200819221956.845195-8-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: NWDFDBOGRB35NSO5GLQVSIXCUYIQOMJU
X-Message-ID-Hash: NWDFDBOGRB35NSO5GLQVSIXCUYIQOMJU
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NWDFDBOGRB35NSO5GLQVSIXCUYIQOMJU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This option was introduced so that for virtio_fs we don't show any mounts
options fuse_show_options(). Because we don't offer any of these options
to be controlled by mounter.

Very soon we are planning to introduce option "dax" which mounter should
be able to specify. And no_mount_options does not work anymore. What
we need is a per mount option specific flag so that filesystem can
specify which options to show.

Add few such flags to control the behavior in more fine grained manner
and get rid of no_mount_options.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h    | 14 ++++++++++----
 fs/fuse/inode.c     | 22 ++++++++++++++--------
 fs/fuse/virtio_fs.c |  1 -
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 740a8a7d7ae6..cf5e675100ec 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -471,18 +471,21 @@ struct fuse_fs_context {
 	int fd;
 	unsigned int rootmode;
 	kuid_t user_id;
+	bool user_id_show;
 	kgid_t group_id;
+	bool group_id_show;
 	bool is_bdev:1;
 	bool fd_present:1;
 	bool rootmode_present:1;
 	bool user_id_present:1;
 	bool group_id_present:1;
 	bool default_permissions:1;
+	bool default_permissions_show:1;
 	bool allow_other:1;
+	bool allow_other_show:1;
 	bool destroy:1;
 	bool no_control:1;
 	bool no_force_umount:1;
-	bool no_mount_options:1;
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
@@ -512,9 +515,11 @@ struct fuse_conn {
 
 	/** The user id for this mount */
 	kuid_t user_id;
+	bool user_id_show:1;
 
 	/** The group id for this mount */
 	kgid_t group_id;
+	bool group_id_show:1;
 
 	/** The pid namespace for this mount */
 	struct pid_namespace *pid_ns;
@@ -698,10 +703,14 @@ struct fuse_conn {
 
 	/** Check permissions based on the file mode or not? */
 	unsigned default_permissions:1;
+	bool default_permissions_show:1;
 
 	/** Allow other than the mounter user to access the filesystem ? */
 	unsigned allow_other:1;
 
+	/** Show allow_other in mount options */
+	bool allow_other_show:1;
+
 	/** Does the filesystem support copy_file_range? */
 	unsigned no_copy_file_range:1;
 
@@ -717,9 +726,6 @@ struct fuse_conn {
 	/** Do not allow MNT_FORCE umount */
 	unsigned int no_force_umount:1;
 
-	/* Do not show mount options */
-	unsigned int no_mount_options:1;
-
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bba747520e9b..2ac5713c4c32 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -535,10 +535,12 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	case OPT_DEFAULT_PERMISSIONS:
 		ctx->default_permissions = true;
+		ctx->default_permissions_show = true;
 		break;
 
 	case OPT_ALLOW_OTHER:
 		ctx->allow_other = true;
+		ctx->allow_other_show = true;
 		break;
 
 	case OPT_MAX_READ:
@@ -573,14 +575,15 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 	struct super_block *sb = root->d_sb;
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
-	if (fc->no_mount_options)
-		return 0;
-
-	seq_printf(m, ",user_id=%u", from_kuid_munged(fc->user_ns, fc->user_id));
-	seq_printf(m, ",group_id=%u", from_kgid_munged(fc->user_ns, fc->group_id));
-	if (fc->default_permissions)
+	if (fc->user_id_show)
+		seq_printf(m, ",user_id=%u",
+			   from_kuid_munged(fc->user_ns, fc->user_id));
+	if (fc->group_id_show)
+		seq_printf(m, ",group_id=%u",
+			   from_kgid_munged(fc->user_ns, fc->group_id));
+	if (fc->default_permissions && fc->default_permissions_show)
 		seq_puts(m, ",default_permissions");
-	if (fc->allow_other)
+	if (fc->allow_other && fc->allow_other_show)
 		seq_puts(m, ",allow_other");
 	if (fc->max_read != ~0)
 		seq_printf(m, ",max_read=%u", fc->max_read);
@@ -1193,14 +1196,17 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	sb->s_flags |= SB_POSIXACL;
 
 	fc->default_permissions = ctx->default_permissions;
+	fc->default_permissions_show = ctx->default_permissions_show;
 	fc->allow_other = ctx->allow_other;
+	fc->allow_other_show = ctx->allow_other_show;
 	fc->user_id = ctx->user_id;
+	fc->user_id_show = ctx->user_id_show;
 	fc->group_id = ctx->group_id;
+	fc->group_id_show = ctx->group_id_show;
 	fc->max_read = max_t(unsigned, 4096, ctx->max_read);
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
-	fc->no_mount_options = ctx->no_mount_options;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ed8da4825b70..47ecdc15f25d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1096,7 +1096,6 @@ static int virtio_fs_fill_super(struct super_block *sb)
 		.destroy = true,
 		.no_control = true,
 		.no_force_umount = true,
-		.no_mount_options = true,
 	};
 
 	mutex_lock(&virtio_fs_mutex);
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
