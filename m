Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5039023A84
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 May 2019 16:41:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5DD0521260A77;
	Mon, 20 May 2019 07:41:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=miklos@szeredi.hu; receiver=linux-nvdimm@lists.01.org 
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 23881212604ED
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 07:41:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w8so14932389wrl.6
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wIkoBjfIwezg37K8GyVLa4Ib4GG1DfXOe0xDWRIHC9c=;
 b=Ou8A0T5aNjnqbPlBgwGcea2Jt9WREkncm2pZ2tzBkRLRUyzdHu/788KR2EoEZb9mkK
 Uc0cJxu+0ZffxR3RKAwpxWA+Pa4RUhS5MdKIHC+QqTBZftrk7zJrl15NN6dttqr5OpMP
 8xroeKkE6/8JUdYcncxaCbltjgHZuJY1yQojg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wIkoBjfIwezg37K8GyVLa4Ib4GG1DfXOe0xDWRIHC9c=;
 b=MAXTglEnrgqqgFHN5EjHMKwcqUdlVVCn15js3LJbSZgb84LPSvpwlrzutWLNvt6t5J
 0cqt0caRGR3y9Pak2I5kGZTuNCYDCVkdUNMxV6mT/LvBarKArdApcSkW3klZFrxWJs+r
 L6Dbw15WNujO1xdPo7ZOlwrFzrW+GOyaDMwPl0mE4JDdYYr31j3MjPiwvt+4sLQeAGwb
 jKGrtEhxRydMJO++YVz1keGRNv1S71z0mfrhqY8kVepGuogIM3C9YfCGoYFlMAi94ZLa
 R7zWuH1FrNALkQMLJlYZ6JmEjXKseImvnOSEtA0lz26oLGAXsNdibtBw1Tm/jz+LgDtZ
 jc9w==
X-Gm-Message-State: APjAAAWZACZ+46EajKZ0RufBsVvEMr0fhI2fzrkzBdxl7L9VmL7vvaNk
 reIgY6+kqVHSNDgqQGvjyo//GA==
X-Google-Smtp-Source: APXvYqyUmEWgtNuNz/KLPkSE1Lwvd2WXTdR3OckfDP8fsKM/AbqeGou/Yo4wcQWm5VhE6j5qlpjEbQ==
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr10213096wrw.152.1558363305299; 
 Mon, 20 May 2019 07:41:45 -0700 (PDT)
Received: from localhost.localdomain (catv-212-96-48-140.catv.broadband.hu.
 [212.96.48.140])
 by smtp.gmail.com with ESMTPSA id n1sm12945556wmc.19.2019.05.20.07.41.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 20 May 2019 07:41:44 -0700 (PDT)
Date: Mon, 20 May 2019 16:41:37 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 02/30] fuse: Clear setuid bit even in cache=never path
Message-ID: <20190520144137.GA24093@localhost.localdomain>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190515192715.18000-3-vgoyal@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 15, 2019 at 03:26:47PM -0400, Vivek Goyal wrote:
> If fuse daemon is started with cache=never, fuse falls back to direct IO.
> In that write path we don't call file_remove_privs() and that means setuid
> bit is not cleared if unpriviliged user writes to a file with setuid bit set.
> 
> pjdfstest chmod test 12.t tests this and fails.

I think better sulution is to tell the server if the suid bit needs to be
removed, so it can do so in a race free way.

Here's the kernel patch, and I'll reply with the libfuse patch.

---
 fs/fuse2/file.c           |    2 ++
 include/uapi/linux/fuse.h |    3 +++
 2 files changed, 5 insertions(+)

--- a/fs/fuse2/file.c
+++ b/fs/fuse2/file.c
@@ -363,6 +363,8 @@ static ssize_t fuse_send_write(struct fu
 		inarg->flags |= O_DSYNC;
 	if (iocb->ki_flags & IOCB_SYNC)
 		inarg->flags |= O_SYNC;
+	if (!capable(CAP_FSETID))
+		inarg->write_flags |= FUSE_WRITE_KILL_PRIV;
 	req->inh.opcode = FUSE_WRITE;
 	req->inh.nodeid = ff->nodeid;
 	req->inh.len = req->inline_inlen + count;
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -125,6 +125,7 @@
  *
  *  7.29
  *  - add FUSE_NO_OPENDIR_SUPPORT flag
+ *  - add FUSE_WRITE_KILL_PRIV flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -318,9 +319,11 @@ struct fuse_file_lock {
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


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
