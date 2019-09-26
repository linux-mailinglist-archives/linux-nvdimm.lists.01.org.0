Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EBEBF14C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Sep 2019 13:29:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80C7221967BC5;
	Thu, 26 Sep 2019 04:31:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=jlayton@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C12882010B846
 for <linux-nvdimm@lists.01.org>; Thu, 26 Sep 2019 04:31:26 -0700 (PDT)
Received: from tleilax.poochiereds.net
 (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5FB2A222BE;
 Thu, 26 Sep 2019 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569497359;
 bh=9/Rqb68Hd5zokVs62d+8Q8CmAfS8pQMwz3knVtN56fo=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=omM//YC5oUdyi9kAcm0qaiytjebiyZl37YKEzcR4YPYTBuy82kW1IkvB94GjDmPSY
 V96+Zq2YtdLUWwO0+d8kob5UDH+RWLk1PlcKJ9TfMGaZDvCFeBeYTYp4Qv43tVYA7K
 t4URTuhp06aJYd4fmgoeCitJCLjMB/VuLmUtP3z8=
Message-ID: <aaee1675b737469187d14286d604b7990f2d5cbc.camel@kernel.org>
Subject: Re: Lease semantic proposal
From: Jeff Layton <jlayton@kernel.org>
To: Ira Weiny <ira.weiny@intel.com>, Dave Chinner <david@fromorbit.com>
Date: Thu, 26 Sep 2019 07:29:16 -0400
In-Reply-To: <20190925234602.GB12748@iweiny-DESK2.sc.intel.com>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <20190923222620.GC16973@dread.disaster.area>
 <20190925234602.GB12748@iweiny-DESK2.sc.intel.com>
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
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
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 2019-09-25 at 16:46 -0700, Ira Weiny wrote:
> On Tue, Sep 24, 2019 at 08:26:20AM +1000, Dave Chinner wrote:
> > On Mon, Sep 23, 2019 at 12:08:53PM -0700, Ira Weiny wrote:
> > > Since the last RFC patch set[1] much of the discussion of supporting RDMA with
> > > FS DAX has been around the semantics of the lease mechanism.[2]  Within that
> > > thread it was suggested I try and write some documentation and/or tests for the
> > > new mechanism being proposed.  I have created a foundation to test lease
> > > functionality within xfstests.[3] This should be close to being accepted.
> > > Before writing additional lease tests, or changing lots of kernel code, this
> > > email presents documentation for the new proposed "layout lease" semantic.
> > > 
> > > At Linux Plumbers[4] just over a week ago, I presented the current state of the
> > > patch set and the outstanding issues.  Based on the discussion there, well as
> > > follow up emails, I propose the following addition to the fcntl() man page.
> > > 
> > > Thank you,
> > > Ira
> > > 
> > > [1] https://lkml.org/lkml/2019/8/9/1043
> > > [2] https://lkml.org/lkml/2019/8/9/1062
> > > [3] https://www.spinics.net/lists/fstests/msg12620.html
> > > [4] https://linuxplumbersconf.org/event/4/contributions/368/
> > > 
> > > 
> > > <fcntl man page addition>
> > > Layout Leases
> > > -------------
> > > 
> > > Layout (F_LAYOUT) leases are special leases which can be used to control and/or
> > > be informed about the manipulation of the underlying layout of a file.
> > > 
> > > A layout is defined as the logical file block -> physical file block mapping
> > > including the file size and sharing of physical blocks among files.  Note that
> > > the unwritten state of a block is not considered part of file layout.
> > 
> > Why even mention "unwritten" state if it's not considered something
> > that the layout lease treats differently?
> > 
> > i.e. Unwritten extents are a filesystem implementation detail that
> > is not exposed to userspace by anything other than FIEMAP. If they
> > have no impact on layout lease behaviour, then why raise it as
> > something the user needs to know about?
> 
> This paragraph was intended to define a layout.  So I guess one could say our
> internal discussion on what defines a "layout" has leaked into the external
> documentation.  Do you think we should just remove the second sentence or the
> whole paragraph?
> 
> > > **Read layout lease F_RDLCK | F_LAYOUT**
> > > 
> > > Read layout leases can be used to be informed of layout changes by the
> > > system or other users.  This lease is similar to the standard read (F_RDLCK)
> > > lease in that any attempt to change the _layout_ of the file will be reported to
> > > the process through the lease break process. 
> > 
> > Similar in what way? The standard F_RDLCK lease triggers on open or
> > truncate - a layout lease does nothing of the sort.
> 
> Similar in that attempts to "write" the layout will result in breaking the
> lease just like attempts to write the file would break the standard F_RDLCK
> lease.  I'm not stuck on the verbiage though; similar may be the wrong word.
> 
> > > But this lease is different
> > > because the file can be opened for write and data can be read and/or written to
> > > the file as long as the underlying layout of the file does not change.
> > 
> > So a F_RDLCK|F_LAYOUT can be taken on a O_WRONLY fd, unlike a
> > F_RDLCK which can only be taken on O_RDONLY fd.
> 
> That was the idea, yes.
> 
> > I think these semantics are sufficiently different to F_RDLCK they
> > need to be explicitly documented, because I see problems here.
> 
> I agree, and I intended this document to indicate how they are different.
> 
> Anther option may be to define F_RDLAYOUT and not have F_LAYOUT such that it is
> clear that this lease is not associated with F_RDLCK at all.  It is different.
> 
> > > Therefore, the lease is not broken if the file is simply open for write, but
> > > _may_ be broken if an operation such as, truncate(), fallocate() or write()
> > > results in changing the underlying layout.
> > 
> > As will mmap(), any number of XFS and ext4 ioctls, etc. 
> > 
> > So this really needs to say "_will_ be broken if *any* modification to
> > the file _might_ need to change the underlying physical layout".
> 
> Agreed.  I used the word "may" because a simple write() does not necessarily
> change the layout of the file.  But I like your verbiage better.  I did wonder
> if listing operations was a bad idea.  So I'm ok simply leaving that detail
> out.
> 
> > Now, the big question: what happens to a process with a
> > F_RDLCK|F_LAYOUT lease held does a write that triggers a layout
> > change? What happens then?
> 
> Because F_UNBREAK is not specified, the write() operation is held for lease
> break time and then the lease is broken if not voluntarily released.  This
> would be the same pattern as a process holding a F_RDLCK and opening the file
> O_RDWR.
> 
> > Also, have you noticed that XFS will unconditionally break layouts on
> > write() because it /might/ need to change the layout? i.e. the
> > BREAK_WRITE case in xfs_file_aio_write_checks()? This is needed for
> > correctly supporting pNFS layout coherency against local IO. i.e.
> > local write() breaks layouts held by NFS server to get the
> > delegation recalled.
> > 
> > So by the above definition of F_RDLCK|F_LAYOUT behaviour, a holder
> > of such a lease doing a write() to that file would trigger a lease
> > break of their own lease as the filesystem has notified the lease
> > layer that there is a layout change about to happen. What's expected
> > to happen here?
> 
> That is not ideal but the proposed semantics say a write() may fail in this
> situation.  So depending on the implementation requirements of the underlying
> FS the semantics still hold for our current use case.  It would be nice to be
> able to enhance the implementation in the future such that a write() could work
> but maybe they can't.  For RDMA the application is probably going to have the
> region mmap'ed anyway and will not need, nor in fact want to use a write()
> call.
> 
> Also, I think I missed a need to specify that a F_RDLCK|F_LAYOUT needs to have
> write permission on (or be the owner of) the file for the user to be able to
> specify F_UNBREAK on it.
> 
> > Hence, AFIACT, the above definition of a F_RDLCK|F_LAYOUT lease
> > doesn't appear to be compatible with the semantics required by
> > existing users of layout leases.
> 
> I disagree.  Other than the addition of F_UNBREAK, I think this is consistent
> with what is currently implemented.  Also, by exporting all this to user space
> we can now write tests for it independent of the RDMA pinning.
> 
> > > **Write layout lease (F_WRLCK | F_LAYOUT)**
> > > 
> > > Write Layout leases can be used to break read layout leases to indicate that
> > > the process intends to change the underlying layout lease of the file.
> > 
> > Any write() can change the layout of the file, and userspace cannot
> > tell in advance whether that will occur (neither can the
> > filesystem), so it seems to me that any application that needs to
> > write data is going to have to use F_WRLCK|F_LAYOUT.
> 
> Sure, but the use case of F_WRLCK|F_LAYOUT is that the user is creating the
> layout.  So using write() to create the file would be ok.
> 
> On the surface it seems like using a standard F_WRLCK lease could be used
> instead of F_WRLCK|F_LAYOUT.  But it actually can't because that does not
> protect against the internals of the file system changing the lease.  This is
> where the semantics are exactly exported to user space.
> 
> > > A process which has taken a write layout lease has exclusive ownership of the
> > > file layout and can modify that layout as long as the lease is held.
> > 
> > Which further implies single writer semantics and leases are
> > associated with a single open fd. Single writers are something we
> > are always trying to avoid in XFS.
> 
> The discussion at LPC revealed that we need a way for the user to ensure the
> file layout is realized prior to any unbreakable lease being taken.  So yes, for
> some period we will need a single writer.
> 
> > > Operations which change the layout are allowed by that process.  But operations
> > > from other file descriptors which attempt to change the layout will break the
> > > lease through the standard lease break process.
> > 
> > If the F_WRLCK|F_LAYOUT lease is exclusive, who is actually able to
> > modify the layout?  Are you talking about processes that don't
> > actually hold leases modifying the layout?
> 
> That was the idea, yes.
> 
> > i.e. what are the
> > constraints on "exclusive access" here - is F_WRLCK|F_LAYOUT is
> > only exclusive when every modification is co-operating and taking
> > the appropriate layout lease for every access to the file that is
> > made?
> 
> I'm not following but IIUC...  no...  The idea is that if you hold the
> F_WRLCK|F_LAYOUT lease then any attempt by _other_ processes to change the
> layout (intentional or otherwise) would result in you getting a SIGIO signal
> which indicates someone _else_ changed the file.
> 
> Then you can atomically downgrade the lock to F_RDLCK|F_LAYOUT|F_UNBREAK or
> atomically upgrade to F_WRLCK|F_LAYOUT|F_UNBREAK.  Either way you know you have
> the layout you want and can rely on the pin working.
> 
> > If that's the case, what happens when someone fails to get a read
> > lock and decides "I can break write locks just by using ftruncate()
> > to the same size without a layout lease". Or fallocate() to
> > preallocate space that is already allocated. Or many other things I
> > can think of.
> 
> The intended use case for F_WRLCK|F_LAYOUT is that a single process is
> attempting to set the layout prior to setting F_UNBREAK.  While
> F_WRLCK|F_LAYOUT can be broken, breaking the lease will not happen without that
> process knowing about it.
> 
> I don't see this being different from the current lease semantics which
> requires some external coordination amongst process/file users to resolve any
> races or coordination.
> 
> > IOWs, this seems to me like a very fragile sort of construct that is
> > open to abuse and that will lead to everyone using F_UNBREAK, which
> > is highly unfriendly to everyone else...
> 
> FWIW, my use case does require F_UNBREAK.  All of the semantics presented have
> a real use case except for F_RDLCK|F_LAYOUT.  However, I think F_RDLCK|F_LAYOUT
> does have a use case in testing.
> 
> Also, I do think that we need to have some check on file ownership for
> F_UNBREAK.  That needs to be added.
> 
> > > The F_LAYOUT flag is used to
> > > indicate a difference between a regular F_WRLCK and F_WRLCK with F_LAYOUT.  In
> > > the F_LAYOUT case opens for write do not break the lease.  But some operations,
> > > if they change the underlying layout, may.
> > > 
> > > The distinction between read layout leases and write layout leases is that
> > > write layout leases can change the layout without breaking the lease within the
> > > owning process.  This is useful to guarantee a layout prior to specifying the
> > > unbreakable flag described below.
> > 
> > Ok, so now you really are saying that F_RDLCK leases can only be
> > used on O_RDONLY file descriptors because any modification under a
> > F_RDLCK|LAYOUT will trigger a layout break.
> 
> I don't necessarily agree.  We also have the mmap() case.  What I was really
> trying to do is define a relaxed lease semantic which allows some shared
> reading/writing of the file as long as the underlying layout does not change.
> I am _not_ a file system expert but it seems like that should be possible.
> 
> Perhaps we need something more fine grained between BREAK_UNMAP and
> BREAK_WRITE?
> 
> > > **Unbreakable Layout Leases (F_UNBREAK)**
> > > 
> > > In order to support pinning of file pages by direct user space users an
> > > unbreakable flag (F_UNBREAK) can be used to modify the read and write layout
> > > lease.  When specified, F_UNBREAK indicates that any user attempting to break
> > > the lease will fail with ETXTBUSY rather than follow the normal breaking
> > > procedure.
> > > 
> > > Both read and write layout leases can have the unbreakable flag (F_UNBREAK)
> > > specified.  The difference between an unbreakable read layout lease and an
> > > unbreakable write layout lease are that an unbreakable read layout lease is
> > > _not_ exclusive. 
> > 
> > Oh, this doesn't work at all. Now we get write()s to F_RDLCK leases
> > that can't break the leases and so all writes, even to processes
> > that own RDLCK|UNBREAK, will fail with ETXTBSY.
> 
> Yes I agree writes()'s to F_RDLCK|F_LAYOUT|F_UNBREAK _may_ fail.  I don't see
> how this is broken if the file owner is opting into it.  RDMA's can still occur
> to that file.  mmap'ed areas of the file can still be used (especially in the
> no-page cache case of FS DAX).
> 
> > > This means that once a layout is established on a file,
> > > multiple unbreakable read layout leases can be taken by multiple processes and
> > > used to pin the underlying pages of that file.
> > 
> > Ok, so what happens when someone now takes a
> > F_WRLOCK|F_LAYOUT|F_UNBREAK? Is that supposed to break
> > F_RDLCK|F_LAYOUT|F_UNBREAK, as the wording about F_WRLCK behaviour
> > implies it should?
> 
> Ah no.  F_RDLCK|F_LAYOUT|F_UNBREAK could not be broken.  I'll have to update
> the text for this.  The idea here is that no one can be changing the layout but
> multiple readers could be using that layout.  So I'll update the text that a
> F_WRLCK|F_LAYOUT|F_UNBREAK would fail in this case.
> 
> > > Care must therefore be taken to ensure that the layout of the file is as the
> > > user wants prior to using the unbreakable read layout lease.  A safe mechanism
> > > to do this would be to take a write layout lease and use fallocate() to set the
> > > layout of the file.  The layout lease can then be "downgraded" to unbreakable
> > > read layout as long as no other user broke the write layout lease.
> > 
> > What are the semantics of this "downgrade" behaviour you speak of? :)
> 
> As I said above it may be a downgrade or an upgrade but the idea is to
> atomically convert the lease to F_UNBREAK.
> 
> > My thoughts are:
> > 	- RDLCK can only be used for O_RDONLY because write()
> > 	  requires breaking of leases
> 
> Does the file system require write() break the layout lease?  Or is that just
> the way the file system is currently implemented?  What about mmap()?  I need
> to have the file open WR to mmap() the file for RDMA.
> 
> To be clear I'm intending F_RDLCK|F_LAYOUT to be something new.  As I said
> above we could use something like F_RDLAYOUT instead?
> 
> > 	- WRLCK is open to abuse simply by not using a layout lease
> > 	  to do a "no change" layout modification
> 
> I'm sorry, I don't understand this comment.
> 
> > 	- RDLCK|F_UNBREAK is entirely unusable
> 
> Well even if write() fails with ETXTBSY this should give us the ability to do
> RDMA and XDP to these areas from multiple processes.  Furthermore, for FS DAX
> which bypasses the page cache mmap'ed areas can be written without write() with
> CPU stores.  Which is how many RDMA applications are likely to write this data.
> 
> > 	- WRLCK|F_UNBREAK will be what every application uses
> > 	  because everything else either doesn't work or is too easy
> > 	  to abuse.
> 
> Maybe.  IMO that is still a step in the right direction as at least 1 process
> can use this now.  And these semantics allow for a shared unbreakable lease
> (F_RDLCK|F_LAYOUT|F_UNBREAK) which can be used with some configurations (FS DAX
> in particular).
> 
> Also, I do think we will need something to ensure file ownership for F_UNBREAK.
> 
> It sounds like the difficulty here is in potential implementation of allowing
> write() to not break layouts.  And dealing with writes to mmap'ed page cache
> pages.  The file system is free to do better later.
> 

Whatever the semantics, from an API standpoint, I think we should not
try to multiplex layout behavior on top of F_SETLEASE. Layouts should
get new fcntl cmd values (maybe F_SETLAYOUT/F_GETLAYOUT) and then you
wouldn't need to expose the F_LAYOUT flag to userland.

The behavior of layouts is different enough from "traditional" leases
that trying to mash them together like this is only going to cause
confusion.

Note that I'm mainly concerned with the user-facing API with this. The
kernel internals can still use F_LAYOUT flag, and you can do the
F_SETLAYOUT -> F_LAYOUT translation at a high level.
-- 
Jeff Layton <jlayton@kernel.org>

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
