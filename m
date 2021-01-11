Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1EB2F2189
	for <lists+linux-nvdimm@lfdr.de>; Mon, 11 Jan 2021 22:10:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8057D100EBB95;
	Mon, 11 Jan 2021 13:10:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9E5C5100EBB91
	for <linux-nvdimm@lists.01.org>; Mon, 11 Jan 2021 13:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1610399425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvIgB4nrBqYWTewh1VPtMYxcnrmKC+gvynDYScYKR+g=;
	b=DhazSDSwSesyXygRABQGcW08MQ3NuHETZMgwKH/j1c3tLBvVFin2CDfDxvove8Gi5e+yxN
	Vezlyv5kUydWDIyIbH96PHSmLcQk2Nsa1Nb6gaEHLzh88dbPhwf8dzeStYNwa62nVqt/2K
	w+IR2ws/ikFDhvCqTwy48i8c30lxdjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-U2w2WC-kMpaizlOjw3acGA-1; Mon, 11 Jan 2021 16:10:18 -0500
X-MC-Unique: U2w2WC-kMpaizlOjw3acGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 799BFB8118;
	Mon, 11 Jan 2021 21:10:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 086155D9DB;
	Mon, 11 Jan 2021 21:10:13 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 10BLADAJ028070;
	Mon, 11 Jan 2021 16:10:13 -0500
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 10BLABk6028066;
	Mon, 11 Jan 2021 16:10:12 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Mon, 11 Jan 2021 16:10:11 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: Expense of read_iter
In-Reply-To: <20210111001805.GD35215@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2101111126150.31017@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org> <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com> <20210110061321.GC35215@casper.infradead.org>
 <alpine.LRH.2.02.2101101458420.7366@file01.intranet.prod.int.rdu2.redhat.com> <20210111001805.GD35215@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: MCX2DHEDAIRK7DSX2YAETOED2LOGZY67
X-Message-ID-Hash: MCX2DHEDAIRK7DSX2YAETOED2LOGZY67
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Al Viro <viro@zeniv.linux.org.uk>, Mingkai Dong <mingkaidong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Wang Jianchao <jianchao.wan9@gmail.com>, "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MCX2DHEDAIRK7DSX2YAETOED2LOGZY67/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 11 Jan 2021, Matthew Wilcox wrote:

> On Sun, Jan 10, 2021 at 04:19:15PM -0500, Mikulas Patocka wrote:
> > I put counters into vfs_read and vfs_readv.
> > 
> > After a fresh boot of the virtual machine, the counters show "13385 4". 
> > After a kernel compilation they show "4475220 8".
> > 
> > So, the readv path is almost unused.
> > 
> > My reasoning was that we should optimize for the "read" path and glue the 
> > "readv" path on the top of that. Currently, the kernel is doing the 
> > opposite - optimizing for "readv" and glueing "read" on the top of it.
> 
> But it's not about optimising for read vs readv.  read_iter handles
> a host of other cases, such as pread(), preadv(), AIO reads, splice,
> and reads to in-kernel buffers.

These things are used rarely compared to "read" and "pread". (BTW. "pread" 
could be handled by the read method too).

What's the reason why do you think that the "read" syscall should use the 
"read_iter" code path? Is it because duplicating the logic is discouraged? 
Or because of code size? Or something else?

> Some device drivers abused read() vs readv() to actually return different 
> information, depending which you called.  That's why there's now a
> prohibition against both.
> 
> So let's figure out how to make iter_read() perform well for sys_read().

I've got another idea - in nvfs_read_iter, test if the iovec contains just 
one entry and call nvfs_read_locked if it does.

diff --git a/file.c b/file.c
index f4b8a1a..e4d87b2 100644
--- a/file.c
+++ b/file.c
@@ -460,6 +460,10 @@ static ssize_t nvfs_read_iter(struct kiocb *iocb, struct iov_iter *iov)
 	if (!IS_DAX(&nmi->vfs_inode)) {
 		r = generic_file_read_iter(iocb, iov);
 	} else {
+		if (likely(iter_is_iovec(iov)) && likely(!iov->iov_offset) && likely(iov->nr_segs == 1)) {
+			r = nvfs_read_locked(nmi, iocb->ki_filp, iov->iov->iov_base, iov->count, true, &iocb->ki_pos);
+			goto unlock_ret;
+		}
 #if 1
 		r = nvfs_rw_iter_locked(iocb, iov, false);
 #else
@@ -467,6 +471,7 @@ static ssize_t nvfs_read_iter(struct kiocb *iocb, struct iov_iter *iov)
 #endif
 	}
 
+unlock_ret:
 	inode_unlock_shared(&nmi->vfs_inode);
 
 	return r;



The result is:

nvfs_read_iter			- 7.307s
Al Viro's read_iter_locked	- 7.147s
test for just one entry		- 7.010s
the read method			- 6.782s

So far, this is the best way how to do it, but it's still 3.3% worse than 
the read method. There's not anything more that could be optimized on the 
filesystem level - the rest of optimizations must be done in the VFS.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
