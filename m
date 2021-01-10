Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053EA2F05A5
	for <lists+linux-nvdimm@lfdr.de>; Sun, 10 Jan 2021 07:14:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 23079100EF26A;
	Sat,  9 Jan 2021 22:14:10 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B4BB3100EF260
	for <linux-nvdimm@lists.01.org>; Sat,  9 Jan 2021 22:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GNdziTbQbEJ9mo4mjqBaEUuZozMS1eNM8r/cJMJoprY=; b=SsfT8KjpTJHHhQ8OIYtxfv9/Ii
	TdZoUe768+SB0A2U8voTxFHiKC7KjTFx9AElQatAVXunYvC6bM4WdH9g1fq3IbWOmbO6SK/GDSBAk
	Beznn47owEO/xpUe5dBBTOY2zElJZrLyLh5THB9hoN+QcO0POI2/FeW4TCKpfnl2t/TIjyx8LjG2R
	pLCEf4RZMXyipHT+QZ8x3k8mma4VCk8BbYfYLAKvsb+9sMs1JWPyjA5/ZB8fl42iyEis5CWJ/tSnz
	5EtHLksnUq35W5uGAi0IhRNu2CulCK4X0XwCg8eGv3HZdIVBVVKyCTBkTcNHVIDaSWAr6FEAb8JSD
	/oCMRNhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1kyTyb-001Rl1-QK; Sun, 10 Jan 2021 06:13:24 +0000
Date: Sun, 10 Jan 2021 06:13:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Expense of read_iter
Message-ID: <20210110061321.GC35215@casper.infradead.org>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID-Hash: Y47Z2YZ2BS2A7IFPXHFK5AOXYMANC3WY
X-Message-ID-Hash: Y47Z2YZ2BS2A7IFPXHFK5AOXYMANC3WY
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Wang Jianchao <jianchao.wan9@gmail.com>, "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y47Z2YZ2BS2A7IFPXHFK5AOXYMANC3WY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 07, 2021 at 01:59:01PM -0500, Mikulas Patocka wrote:
> On Thu, 7 Jan 2021, Matthew Wilcox wrote:
> > On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
> > > I'd like to ask about this piece of code in __kernel_read:
> > > 	if (unlikely(!file->f_op->read_iter || file->f_op->read))
> > > 		return warn_unsupported...
> > > and __kernel_write:
> > > 	if (unlikely(!file->f_op->write_iter || file->f_op->write))
> > > 		return warn_unsupported...
> > > 
> > > - It exits with an error if both read_iter and read or write_iter and 
> > > write are present.
> > > 
> > > I found out that on NVFS, reading a file with the read method has 10% 
> > > better performance than the read_iter method. The benchmark just reads the 
> > > same 4k page over and over again - and the cost of creating and parsing 
> > > the kiocb and iov_iter structures is just that high.
> > 
> > Which part of it is so expensive?
> 
> The read_iter path is much bigger:
> vfs_read		- 0x160 bytes
> new_sync_read		- 0x160 bytes
> nvfs_rw_iter		- 0x100 bytes
> nvfs_rw_iter_locked	- 0x4a0 bytes
> iov_iter_advance	- 0x300 bytes

Number of bytes in a function isn't really correlated with how expensive
a particular function is.  That said, looking at new_sync_read() shows
one part that's particularly bad, init_sync_kiocb():

static inline int iocb_flags(struct file *file)
{
        int res = 0;
        if (file->f_flags & O_APPEND)
                res |= IOCB_APPEND;
     7ec:       8b 57 40                mov    0x40(%rdi),%edx
     7ef:       48 89 75 80             mov    %rsi,-0x80(%rbp)
        if (file->f_flags & O_DIRECT)
     7f3:       89 d0                   mov    %edx,%eax
     7f5:       c1 e8 06                shr    $0x6,%eax
     7f8:       83 e0 10                and    $0x10,%eax
                res |= IOCB_DIRECT;
        if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host))
     7fb:       89 c1                   mov    %eax,%ecx
     7fd:       81 c9 00 00 02 00       or     $0x20000,%ecx
     803:       f6 c6 40                test   $0x40,%dh
     806:       0f 45 c1                cmovne %ecx,%eax
                res |= IOCB_DSYNC;
     809:       f6 c6 10                test   $0x10,%dh
     80c:       75 18                   jne    826 <new_sync_read+0x66>
     80e:       48 8b 8f d8 00 00 00    mov    0xd8(%rdi),%rcx
     815:       48 8b 09                mov    (%rcx),%rcx
     818:       48 8b 71 28             mov    0x28(%rcx),%rsi
     81c:       f6 46 50 10             testb  $0x10,0x50(%rsi)
     820:       0f 84 e2 00 00 00       je     908 <new_sync_read+0x148>
        if (file->f_flags & __O_SYNC)
     826:       83 c8 02                or     $0x2,%eax
                res |= IOCB_SYNC;
        return res;
     829:       89 c1                   mov    %eax,%ecx
     82b:       83 c9 04                or     $0x4,%ecx
     82e:       81 e2 00 00 10 00       and    $0x100000,%edx

We could optimise this by, eg, checking for (__O_SYNC | O_DIRECT |
O_APPEND) and returning 0 if none of them are set, since they're all
pretty rare.  It might be better to maintain an f_iocb_flags in the
struct file and just copy that unconditionally.  We'd need to remember
to update it in fcntl(F_SETFL), but I think that's the only place.


> If we go with the "read" method, there's just:
> vfs_read		- 0x160 bytes
> nvfs_read		- 0x200 bytes
> 
> > Is it worth, eg adding an iov_iter
> > type that points to a single buffer instead of a single-member iov?

>      6.57%  pread    [nvfs]            [k] nvfs_rw_iter_locked
>      2.31%  pread    [kernel.vmlinux]  [k] new_sync_read
>      1.89%  pread    [kernel.vmlinux]  [k] iov_iter_advance
>      1.24%  pread    [nvfs]            [k] nvfs_rw_iter
>      0.29%  pread    [kernel.vmlinux]  [k] iov_iter_init

>      2.71%  pread    [nvfs]            [k] nvfs_read

> Note that if we sum the percentage of nvfs_iter_locked, new_sync_read, 
> iov_iter_advance, nvfs_rw_iter, we get 12.01%. On the other hand, in the 
> second trace, nvfs_read consumes just 2.71% - and it replaces 
> functionality of all these functions.
> 
> That is the reason for that 10% degradation with read_iter.

You seem to be focusing on your argument for "let's just permit
filesystems to implement both ->read and ->read_iter".  My suggestion
is that we need to optimise the ->read_iter path, but to do that we need
to know what's expensive.

nvfs_rw_iter_locked() looks very complicated.  I suspect it can
be simplified.  Of course new_sync_read() needs to be improved too,
as do the other functions here, but fully a third of the difference
between read() and read_iter() is the difference between nvfs_read()
and nvfs_rw_iter_locked().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
