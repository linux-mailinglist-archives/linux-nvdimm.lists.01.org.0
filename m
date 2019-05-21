Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560F25341
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 17:01:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 457FF21275459;
	Tue, 21 May 2019 08:01:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 792C021265793
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 08:01:34 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DB08430842A8;
 Tue, 21 May 2019 15:01:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B432704DF;
 Tue, 21 May 2019 15:01:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 34034220A60; Tue, 21 May 2019 11:01:31 -0400 (EDT)
Date: Tue, 21 May 2019 11:01:31 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 02/30] fuse: Clear setuid bit even in cache=never path
Message-ID: <20190521150131.GB29075@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-3-vgoyal@redhat.com>
 <20190520144137.GA24093@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190520144137.GA24093@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 21 May 2019 15:01:34 +0000 (UTC)
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

Hi Miklos,

I tested and it works for me.

Vivek

> 
> ---
>  fs/fuse2/file.c           |    2 ++
>  include/uapi/linux/fuse.h |    3 +++
>  2 files changed, 5 insertions(+)
> 
> --- a/fs/fuse2/file.c
> +++ b/fs/fuse2/file.c
> @@ -363,6 +363,8 @@ static ssize_t fuse_send_write(struct fu
>  		inarg->flags |= O_DSYNC;
>  	if (iocb->ki_flags & IOCB_SYNC)
>  		inarg->flags |= O_SYNC;
> +	if (!capable(CAP_FSETID))
> +		inarg->write_flags |= FUSE_WRITE_KILL_PRIV;
>  	req->inh.opcode = FUSE_WRITE;
>  	req->inh.nodeid = ff->nodeid;
>  	req->inh.len = req->inline_inlen + count;
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -125,6 +125,7 @@
>   *
>   *  7.29
>   *  - add FUSE_NO_OPENDIR_SUPPORT flag
> + *  - add FUSE_WRITE_KILL_PRIV flag
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -318,9 +319,11 @@ struct fuse_file_lock {
>   *
>   * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
>   * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
> + * FUSE_WRITE_KILL_PRIV: kill suid and sgid bits
>   */
>  #define FUSE_WRITE_CACHE	(1 << 0)
>  #define FUSE_WRITE_LOCKOWNER	(1 << 1)
> +#define FUSE_WRITE_KILL_PRIV	(1 << 2)
>  
>  /**
>   * Read flags
> 
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
