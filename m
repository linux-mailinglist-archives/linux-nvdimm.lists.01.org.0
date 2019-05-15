Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A601FA73
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 21:27:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FA4921DF8060;
	Wed, 15 May 2019 12:27:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8474221265797
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 12:27:33 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B04FF3004405;
 Wed, 15 May 2019 19:27:32 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8ACF31001DE1;
 Wed, 15 May 2019 19:27:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 769C3225479; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2 05/30] fuse: export fuse_len_args()
Date: Wed, 15 May 2019 15:26:50 -0400
Message-Id: <20190515192715.18000-6-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 15 May 2019 19:27:32 +0000 (UTC)
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

virtio-fs will need to query the length of fuse_arg lists.  Make the
symbol visible.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/dev.c    | 7 ++++---
 fs/fuse/fuse_i.h | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 46d1aecd7506..d8054b1a45f5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -350,7 +350,7 @@ void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
 }
 EXPORT_SYMBOL_GPL(fuse_put_request);
 
-static unsigned len_args(unsigned numargs, struct fuse_arg *args)
+unsigned fuse_len_args(unsigned numargs, struct fuse_arg *args)
 {
 	unsigned nbytes = 0;
 	unsigned i;
@@ -360,6 +360,7 @@ static unsigned len_args(unsigned numargs, struct fuse_arg *args)
 
 	return nbytes;
 }
+EXPORT_SYMBOL_GPL(fuse_len_args);
 
 static u64 fuse_get_unique(struct fuse_iqueue *fiq)
 {
@@ -375,7 +376,7 @@ static unsigned int fuse_req_hash(u64 unique)
 static void queue_request(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	req->in.h.len = sizeof(struct fuse_in_header) +
-		len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
+		fuse_len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
 	list_add_tail(&req->list, &fiq->pending);
 	wake_up_locked(&fiq->waitq);
 	kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
@@ -1894,7 +1895,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_out *out,
 	if (out->h.error)
 		return nbytes != reqsize ? -EINVAL : 0;
 
-	reqsize += len_args(out->numargs, out->args);
+	reqsize += fuse_len_args(out->numargs, out->args);
 
 	if (reqsize < nbytes || (reqsize > nbytes && !out->argvar))
 		return -EINVAL;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c4584c873b87..3a235386d667 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1091,4 +1091,9 @@ int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 /* readdir.c */
 int fuse_readdir(struct file *file, struct dir_context *ctx);
 
+/**
+ * Return the number of bytes in an arguments list
+ */
+unsigned fuse_len_args(unsigned numargs, struct fuse_arg *args);
+
 #endif /* _FS_FUSE_I_H */
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
