Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649DFBBE6B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Sep 2019 00:26:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43363202F5008;
	Mon, 23 Sep 2019 15:29:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=211.29.132.249; helo=mail105.syd.optusnet.com.au;
 envelope-from=david@fromorbit.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au
 [211.29.132.249])
 by ml01.01.org (Postfix) with ESMTP id EF9EE202EBECB
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 15:28:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au
 [49.181.226.196])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5E45736296B;
 Tue, 24 Sep 2019 08:26:21 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
 (envelope-from <david@fromorbit.com>)
 id 1iCWmi-0005IP-CL; Tue, 24 Sep 2019 08:26:20 +1000
Date: Tue, 24 Sep 2019 08:26:20 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: Lease semantic proposal
Message-ID: <20190923222620.GC16973@dread.disaster.area>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
 a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
 a=D19gQVrFAAAA:8 a=OLL_FvSJAAAA:8 a=gQGbs8_HAAAA:8 a=7-415B0cAAAA:8
 a=cV8XMCNRulwGmHMGVcAA:9 a=CjuIK1q_8ugA:10 a=Z1lksQSvXmgA:10
 a=oDE_HKQWQKsA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=oIrB72frpwYPwTMnlWqB:22
 a=1pMqk7AwgTXjlBDkgM7h:22 a=biEYGPWJfzWAr4FL6Ov7:22
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Sep 23, 2019 at 12:08:53PM -0700, Ira Weiny wrote:
> 
> Since the last RFC patch set[1] much of the discussion of supporting RDMA with
> FS DAX has been around the semantics of the lease mechanism.[2]  Within that
> thread it was suggested I try and write some documentation and/or tests for the
> new mechanism being proposed.  I have created a foundation to test lease
> functionality within xfstests.[3] This should be close to being accepted.
> Before writing additional lease tests, or changing lots of kernel code, this
> email presents documentation for the new proposed "layout lease" semantic.
> 
> At Linux Plumbers[4] just over a week ago, I presented the current state of the
> patch set and the outstanding issues.  Based on the discussion there, well as
> follow up emails, I propose the following addition to the fcntl() man page.
> 
> Thank you,
> Ira
> 
> [1] https://lkml.org/lkml/2019/8/9/1043
> [2] https://lkml.org/lkml/2019/8/9/1062
> [3] https://www.spinics.net/lists/fstests/msg12620.html
> [4] https://linuxplumbersconf.org/event/4/contributions/368/
> 
> 
> <fcntl man page addition>
> Layout Leases
> -------------
> 
> Layout (F_LAYOUT) leases are special leases which can be used to control and/or
> be informed about the manipulation of the underlying layout of a file.
> 
> A layout is defined as the logical file block -> physical file block mapping
> including the file size and sharing of physical blocks among files.  Note that
> the unwritten state of a block is not considered part of file layout.

Why even mention "unwritten" state if it's not considered something
that the layout lease treats differently?

i.e. Unwritten extents are a filesystem implementation detail that
is not exposed to userspace by anything other than FIEMAP. If they
have no impact on layout lease behaviour, then why raise it as
something the user needs to know about?

> **Read layout lease F_RDLCK | F_LAYOUT**
> 
> Read layout leases can be used to be informed of layout changes by the
> system or other users.  This lease is similar to the standard read (F_RDLCK)
> lease in that any attempt to change the _layout_ of the file will be reported to
> the process through the lease break process. 

Similar in what way? The standard F_RDLCK lease triggers on open or
truncate - a layout lease does nothing of the sort.

> But this lease is different
> because the file can be opened for write and data can be read and/or written to
> the file as long as the underlying layout of the file does not change.

So a F_RDLCK|F_LAYOUT can be taken on a O_WRONLY fd, unlike a
F_RDLCK which can only be taken on O_RDONLY fd.

I think these semantics are sufficiently different to F_RDLCK they
need to be explicitly documented, because I see problems here.

> Therefore, the lease is not broken if the file is simply open for write, but
> _may_ be broken if an operation such as, truncate(), fallocate() or write()
> results in changing the underlying layout.

As will mmap(), any number of XFS and ext4 ioctls, etc. 

So this really needs to say "_will_ be broken if *any* modification to
the file _might_ need to change the underlying physical layout".

Now, the big question: what happens to a process with a
F_RDLCK|F_LAYOUT lease held does a write that triggers a layout
change? What happens then?

Also, have you noticed that XFS will unconditionally break layouts on
write() because it /might/ need to change the layout? i.e. the
BREAK_WRITE case in xfs_file_aio_write_checks()? This is needed for
correctly supporting pNFS layout coherency against local IO. i.e.
local write() breaks layouts held by NFS server to get the
delegation recalled.

So by the above definition of F_RDLCK|F_LAYOUT behaviour, a holder
of such a lease doing a write() to that file would trigger a lease
break of their own lease as the filesystem has notified the lease
layer that there is a layout change about to happen. What's expected
to happen here?

Hence, AFIACT, the above definition of a F_RDLCK|F_LAYOUT lease
doesn't appear to be compatible with the semantics required by
existing users of layout leases.

> **Write layout lease (F_WRLCK | F_LAYOUT)**
> 
> Write Layout leases can be used to break read layout leases to indicate that
> the process intends to change the underlying layout lease of the file.

Any write() can change the layout of the file, and userspace cannot
tell in advance whether that will occur (neither can the
filesystem), so it seems to me that any application that needs to
write data is going to have to use F_WRLCK|F_LAYOUT.

> A process which has taken a write layout lease has exclusive ownership of the
> file layout and can modify that layout as long as the lease is held.

Which further implies single writer semantics and leases are
associated with a single open fd. Single writers are something we
are always trying to avoid in XFS.

> Operations which change the layout are allowed by that process.  But operations
> from other file descriptors which attempt to change the layout will break the
> lease through the standard lease break process.

If the F_WRLCK|F_LAYOUT lease is exclusive, who is actually able to
modify the layout?  Are you talking about processes that don't
actually hold leases modifying the layout? i.e. what are the
constraints on "exclusive access" here - is F_WRLCK|F_LAYOUT is
only exclusive when every modification is co-operating and taking
the appropriate layout lease for every access to the file that is
made?

If that's the case, what happens when someone fails to get a read
lock and decides "I can break write locks just by using ftruncate()
to the same size without a layout lease". Or fallocate() to
preallocate space that is already allocated. Or many other things I
can think of.

IOWs, this seems to me like a very fragile sort of construct that is
open to abuse and that will lead to everyone using F_UNBREAK, which
is highly unfriendly to everyone else...

> The F_LAYOUT flag is used to
> indicate a difference between a regular F_WRLCK and F_WRLCK with F_LAYOUT.  In
> the F_LAYOUT case opens for write do not break the lease.  But some operations,
> if they change the underlying layout, may.
> 
> The distinction between read layout leases and write layout leases is that
> write layout leases can change the layout without breaking the lease within the
> owning process.  This is useful to guarantee a layout prior to specifying the
> unbreakable flag described below.

Ok, so now you really are saying that F_RDLCK leases can only be
used on O_RDONLY file descriptors because any modification under a
F_RDLCK|LAYOUT will trigger a layout break.

> **Unbreakable Layout Leases (F_UNBREAK)**
> 
> In order to support pinning of file pages by direct user space users an
> unbreakable flag (F_UNBREAK) can be used to modify the read and write layout
> lease.  When specified, F_UNBREAK indicates that any user attempting to break
> the lease will fail with ETXTBUSY rather than follow the normal breaking
> procedure.
> 
> Both read and write layout leases can have the unbreakable flag (F_UNBREAK)
> specified.  The difference between an unbreakable read layout lease and an
> unbreakable write layout lease are that an unbreakable read layout lease is
> _not_ exclusive. 

Oh, this doesn't work at all. Now we get write()s to F_RDLCK leases
that can't break the leases and so all writes, even to processes
that own RDLCK|UNBREAK, will fail with ETXTBSY.

> This means that once a layout is established on a file,
> multiple unbreakable read layout leases can be taken by multiple processes and
> used to pin the underlying pages of that file.

Ok, so what happens when someone now takes a
F_WRLOCK|F_LAYOUT|F_UNBREAK? Is that supposed to break
F_RDLCK|F_LAYOUT|F_UNBREAK, as the wording about F_WRLCK behaviour
implies it should?

> Care must therefore be taken to ensure that the layout of the file is as the
> user wants prior to using the unbreakable read layout lease.  A safe mechanism
> to do this would be to take a write layout lease and use fallocate() to set the
> layout of the file.  The layout lease can then be "downgraded" to unbreakable
> read layout as long as no other user broke the write layout lease.

What are the semantics of this "downgrade" behaviour you speak of? :)

My thoughts are:
	- RDLCK can only be used for O_RDONLY because write()
	  requires breaking of leases
	- WRLCK is open to abuse simply by not using a layout lease
	  to do a "no change" layout modification
	- RDLCK|F_UNBREAK is entirely unusable
	- WRLCK|F_UNBREAK will be what every application uses
	  because everything else either doesn't work or is too easy
	  to abuse.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
