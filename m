Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D619D23AB8
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 May 2019 16:44:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E27C82126579F;
	Mon, 20 May 2019 07:44:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=miklos@szeredi.hu; receiver=linux-nvdimm@lists.01.org 
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F14EB212604ED
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 07:44:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w13so4175630wru.11
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VceX0inl+xJT/Seg5xxtqBb9C3XXmdQzMS78vGAaEms=;
 b=FcuGOrg5reg1S0l1itKbd/lBbVqFPDu+TpXhYmKxOt4riBJtk788L6qVrB2kNxtIjT
 wChiwClJr+wp9uSjs+mxOmHyqFBahIdNrjOemwQVoibbcG1ucDEGvhyaULJH486swnpG
 M7azSxVKQItYeJojw0rwBFxFvde4EN/0byzg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VceX0inl+xJT/Seg5xxtqBb9C3XXmdQzMS78vGAaEms=;
 b=VGHCRHLjdjcB8Wb6zU2sVf1mym7vCHIfFhv6701uA2NDzOoNE9nRolZw0wGWlvCX2+
 yHqijVe/aYdKkc4I16ALX3gUrk0WB+coQySk5MM9inePcoUclA7e8LQveUu+iKefiY3H
 jqIQwNpSIrjEzmDjh4TEyXRq5N8/asaryHdWamT+rmoYuX/ETrBneJvsh8vS8bAe3+rG
 2FGEZEw7S5aAuZ+6aJAadrAoBRB6/4XX0Ktn0vUhSoRssHW5stxrRIEnJOMjYEvva0vh
 HOYf5nL+s+26LiOViCTWfiVwvPD0wYb38R3pMmx0fNjk5F9+vnWdZfSV9fHGia+BaHz5
 Zw9g==
X-Gm-Message-State: APjAAAWH49r5g8HheWW+MkO3Rb28CuJMaziS4E3DvTq6OwSsAfpvtdK2
 eXKj8WQca644Hs5u37N7/YqXhg==
X-Google-Smtp-Source: APXvYqwUDHLwWvqd8kuS304lx0z2yG9BSoE7TWQycdCiYRe7kl6qYXKvUo5n5KhEpN6Ls7rcR5k6/A==
X-Received: by 2002:adf:f487:: with SMTP id l7mr47404596wro.127.1558363480523; 
 Mon, 20 May 2019 07:44:40 -0700 (PDT)
Received: from localhost.localdomain (catv-212-96-48-140.catv.broadband.hu.
 [212.96.48.140])
 by smtp.gmail.com with ESMTPSA id y184sm18241241wmg.7.2019.05.20.07.44.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 20 May 2019 07:44:39 -0700 (PDT)
Date: Mon, 20 May 2019 16:44:37 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 02/30] fuse: Clear setuid bit even in cache=never path
Message-ID: <20190520144437.GB24093@localhost.localdomain>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-3-vgoyal@redhat.com>
 <20190520144137.GA24093@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20190520144137.GA24093@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: kvm@vger.kernel.org, linux-nvdimm@lists.01.org, dgilbert@redhat.com,
 linux-kernel@vger.kernel.org, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org, swhiteho@redhat.com
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2019 at 04:41:37PM +0200, Miklos Szeredi wrote:
> On Wed, May 15, 2019 at 03:26:47PM -0400, Vivek Goyal wrote:
> > If fuse daemon is started with cache=never, fuse falls back to direct IO.
> > In that write path we don't call file_remove_privs() and that means setuid
> > bit is not cleared if unpriviliged user writes to a file with setuid bit set.
> > 
> > pjdfstest chmod test 12.t tests this and fails.
> 
> I think better sulution is to tell the server if the suid bit needs to be
> removed, so it can do so in a race free way.
> 
> Here's the kernel patch, and I'll reply with the libfuse patch.

Here are the patches for libfuse and passthrough_ll.

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="libfuse-add-fuse_write_kill_priv.patch"

---
 include/fuse_common.h |    5 ++++-
 include/fuse_kernel.h |    2 ++
 lib/fuse_lowlevel.c   |   12 ++++++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -64,8 +64,11 @@ struct fuse_file_info {
 	   May only be set in ->release(). */
 	unsigned int flock_release : 1;
 
+	/* Kill suid and sgid bits on write */
+	unsigned int write_kill_priv : 1;
+
 	/** Padding.  Do not use*/
-	unsigned int padding : 27;
+	unsigned int padding : 26;
 
 	/** File handle.  May be filled in by filesystem in open().
 	    Available in all other file operations */
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -304,9 +304,11 @@ struct fuse_file_lock {
  *
  * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
  * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
+ * FUSE_WRITE_KILL_PRIV: kill suid and sgid bits
  */
 #define FUSE_WRITE_CACHE	(1 << 0)
 #define FUSE_WRITE_LOCKOWNER	(1 << 1)
+#define FUSE_WRITE_KILL_PRIV	(1 << 2)
 
 /**
  * Read flags
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -1315,12 +1315,14 @@ static void do_write(fuse_req_t req, fus
 
 	memset(&fi, 0, sizeof(fi));
 	fi.fh = arg->fh;
-	fi.writepage = (arg->write_flags & 1) != 0;
+	fi.writepage = (arg->write_flags & FUSE_WRITE_CACHE) != 0;
+	fi.write_kill_priv = (arg->write_flags & FUSE_WRITE_KILL_PRIV) != 0;
 
 	if (req->se->conn.proto_minor < 9) {
 		param = ((char *) arg) + FUSE_COMPAT_WRITE_IN_SIZE;
 	} else {
-		fi.lock_owner = arg->lock_owner;
+		if (arg->write_flags & FUSE_WRITE_LOCKOWNER)
+			fi.lock_owner = arg->lock_owner;
 		fi.flags = arg->flags;
 		param = PARAM(arg);
 	}
@@ -1345,7 +1347,8 @@ static void do_write_buf(fuse_req_t req,
 
 	memset(&fi, 0, sizeof(fi));
 	fi.fh = arg->fh;
-	fi.writepage = arg->write_flags & 1;
+	fi.writepage = (arg->write_flags & FUSE_WRITE_CACHE) != 0;
+	fi.write_kill_priv = (arg->write_flags & FUSE_WRITE_KILL_PRIV) != 0;
 
 	if (se->conn.proto_minor < 9) {
 		bufv.buf[0].mem = ((char *) arg) + FUSE_COMPAT_WRITE_IN_SIZE;
@@ -1353,7 +1356,8 @@ static void do_write_buf(fuse_req_t req,
 			FUSE_COMPAT_WRITE_IN_SIZE;
 		assert(!(bufv.buf[0].flags & FUSE_BUF_IS_FD));
 	} else {
-		fi.lock_owner = arg->lock_owner;
+		if (arg->write_flags & FUSE_WRITE_LOCKOWNER)
+			fi.lock_owner = arg->lock_owner;
 		fi.flags = arg->flags;
 		if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD))
 			bufv.buf[0].mem = PARAM(arg);

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="passthrough_ll-kill-suid.patch"

---
 example/passthrough_ll.c |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

--- a/example/passthrough_ll.c
+++ b/example/passthrough_ll.c
@@ -56,6 +56,7 @@
 #include <sys/file.h>
 #include <sys/xattr.h>
 #include <sys/syscall.h>
+#include <sys/capability.h>
 
 /* We are re-using pointers to our `struct lo_inode` and `struct
    lo_dirp` elements as inodes. This means that we must be able to
@@ -965,6 +966,11 @@ static void lo_write_buf(fuse_req_t req,
 	(void) ino;
 	ssize_t res;
 	struct fuse_bufvec out_buf = FUSE_BUFVEC_INIT(fuse_buf_size(in_buf));
+	struct __user_cap_header_struct cap_hdr = {
+		.version = _LINUX_CAPABILITY_VERSION_1,
+	};
+	struct __user_cap_data_struct cap_orig;
+	struct __user_cap_data_struct cap_new;
 
 	out_buf.buf[0].flags = FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
 	out_buf.buf[0].fd = fi->fh;
@@ -974,7 +980,28 @@ static void lo_write_buf(fuse_req_t req,
 		fprintf(stderr, "lo_write(ino=%" PRIu64 ", size=%zd, off=%lu)\n",
 			ino, out_buf.buf[0].size, (unsigned long) off);
 
+	if (fi->write_kill_priv) {
+		res = capget(&cap_hdr, &cap_orig);
+		if (res == -1) {
+			fuse_reply_err(req, errno);
+			return;
+		}
+		cap_new = cap_orig;
+		cap_new.effective &= ~(1 << CAP_FSETID);
+		res = capset(&cap_hdr, &cap_new);
+		if (res == -1) {
+			fuse_reply_err(req, errno);
+			return;
+		}
+	}
+
 	res = fuse_buf_copy(&out_buf, in_buf, 0);
+
+	if (fi->write_kill_priv) {
+		if (capset(&cap_hdr, &cap_orig) != 0)
+			abort();
+	}
+
 	if(res < 0)
 		fuse_reply_err(req, -res);
 	else
@@ -1215,7 +1242,7 @@ static void lo_copy_file_range(fuse_req_
 	res = copy_file_range(fi_in->fh, &off_in, fi_out->fh, &off_out, len,
 			      flags);
 	if (res < 0)
-		fuse_reply_err(req, -errno);
+		fuse_reply_err(req, errno);
 	else
 		fuse_reply_write(req, res);
 }

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

--KsGdsel6WgEHnImy--
