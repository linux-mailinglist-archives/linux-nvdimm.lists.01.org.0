Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8852C3F8F
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Oct 2019 20:17:06 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D68A210FC71F6;
	Tue,  1 Oct 2019 11:18:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9771510FC71F3
	for <linux-nvdimm@lists.01.org>; Tue,  1 Oct 2019 11:18:29 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 11:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200";
   d="scan'208";a="181776328"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga007.jf.intel.com with ESMTP; 01 Oct 2019 11:17:00 -0700
Date: Tue, 1 Oct 2019 11:17:00 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: Lease semantic proposal
Message-ID: <20191001181659.GA5500@iweiny-DESK2.sc.intel.com>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <5d5a93637934867e1b3352763da8e3d9f9e6d683.camel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5d5a93637934867e1b3352763da8e3d9f9e6d683.camel@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: NXC6AMCCA4XOOH36CQFYSSBFF5T5NRVZ
X-Message-ID-Hash: NXC6AMCCA4XOOH36CQFYSSBFF5T5NRVZ
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NXC6AMCCA4XOOH36CQFYSSBFF5T5NRVZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 23, 2019 at 04:17:59PM -0400, Jeff Layton wrote:
> On Mon, 2019-09-23 at 12:08 -0700, Ira Weiny wrote:
> > Since the last RFC patch set[1] much of the discussion of supporting RDMA with
> > FS DAX has been around the semantics of the lease mechanism.[2]  Within that
> > thread it was suggested I try and write some documentation and/or tests for the
> > new mechanism being proposed.  I have created a foundation to test lease
> > functionality within xfstests.[3] This should be close to being accepted.
> > Before writing additional lease tests, or changing lots of kernel code, this
> > email presents documentation for the new proposed "layout lease" semantic.
> > 
> > At Linux Plumbers[4] just over a week ago, I presented the current state of the
> > patch set and the outstanding issues.  Based on the discussion there, well as
> > follow up emails, I propose the following addition to the fcntl() man page.
> > 
> > Thank you,
> > Ira
> > 
> > [1] https://lkml.org/lkml/2019/8/9/1043
> > [2] https://lkml.org/lkml/2019/8/9/1062
> > [3] https://www.spinics.net/lists/fstests/msg12620.html
> > [4] https://linuxplumbersconf.org/event/4/contributions/368/
> > 
> > 
> 
> Thank you so much for doing this, Ira. This allows us to debate the
> user-visible behavior semantics without getting bogged down in the
> implementation details. More comments below:

Thanks.  Sorry for the delay in response.  Turns out this email was in my
spam...  :-/  I'll need to work out why.

> 
> > <fcntl man page addition>
> > Layout Leases
> > -------------
> > 
> > Layout (F_LAYOUT) leases are special leases which can be used to control and/or
> > be informed about the manipulation of the underlying layout of a file.
> > 
> > A layout is defined as the logical file block -> physical file block mapping
> > including the file size and sharing of physical blocks among files.  Note that
> > the unwritten state of a block is not considered part of file layout.
> > 
> > **Read layout lease F_RDLCK | F_LAYOUT**
> > 
> > Read layout leases can be used to be informed of layout changes by the
> > system or other users.  This lease is similar to the standard read (F_RDLCK)
> > lease in that any attempt to change the _layout_ of the file will be reported to
> > the process through the lease break process.  But this lease is different
> > because the file can be opened for write and data can be read and/or written to
> > the file as long as the underlying layout of the file does not change.
> > Therefore, the lease is not broken if the file is simply open for write, but
> > _may_ be broken if an operation such as, truncate(), fallocate() or write()
> > results in changing the underlying layout.
> > 
> > **Write layout lease (F_WRLCK | F_LAYOUT)**
> > 
> > Write Layout leases can be used to break read layout leases to indicate that
> > the process intends to change the underlying layout lease of the file.
> > 
> > A process which has taken a write layout lease has exclusive ownership of the
> > file layout and can modify that layout as long as the lease is held.
> > Operations which change the layout are allowed by that process.  But operations
> > from other file descriptors which attempt to change the layout will break the
> > lease through the standard lease break process.  The F_LAYOUT flag is used to
> > indicate a difference between a regular F_WRLCK and F_WRLCK with F_LAYOUT.  In
> > the F_LAYOUT case opens for write do not break the lease.  But some operations,
> > if they change the underlying layout, may.
> > 
> > The distinction between read layout leases and write layout leases is that
> > write layout leases can change the layout without breaking the lease within the
> > owning process.  This is useful to guarantee a layout prior to specifying the
> > unbreakable flag described below.
> > 
> > 
> 
> The above sounds totally reasonable. You're essentially exposing the
> behavior of nfsd's layout leases to userland. To be clear, will F_LAYOUT
> leases work the same way as "normal" leases, wrt signals and timeouts?

That was my intention, yes.

> 
> I do wonder if we're better off not trying to "or" in flags for this,
> and instead have a separate set of commands (maybe F_RDLAYOUT,
> F_WRLAYOUT, F_UNLAYOUT). Maybe I'm just bikeshedding though -- I don't
> feel terribly strongly about it.

I'm leaning that was as well.  To make these even more distinct from
F_SETLEASE.

> 
> Also, at least in NFSv4, layouts are handed out for a particular byte
> range in a file. Should we consider doing this with an API that allows
> for that in the future? Is this something that would be desirable for
> your RDMA+DAX use-cases?

I don't see this.  I've thought it would be a nice thing to have but I don't
know of any hard use case.  But first I'd like to understand how this works for
NFS.

> 
> We could add a new F_SETLEASE variant that takes a struct with a byte
> range (something like struct flock).

I think this would be another reason to introduce F_[RD|WR|UN]LAYOUT as a
command.  Perhaps supporting smaller byte ranges could be added later?

> 
> > **Unbreakable Layout Leases (F_UNBREAK)**
> > 
> > In order to support pinning of file pages by direct user space users an
> > unbreakable flag (F_UNBREAK) can be used to modify the read and write layout
> > lease.  When specified, F_UNBREAK indicates that any user attempting to break
> > the lease will fail with ETXTBUSY rather than follow the normal breaking
> > procedure.
> > 
> > Both read and write layout leases can have the unbreakable flag (F_UNBREAK)
> > specified.  The difference between an unbreakable read layout lease and an
> > unbreakable write layout lease are that an unbreakable read layout lease is
> > _not_ exclusive.  This means that once a layout is established on a file,
> > multiple unbreakable read layout leases can be taken by multiple processes and
> > used to pin the underlying pages of that file.
> > 
> > Care must therefore be taken to ensure that the layout of the file is as the
> > user wants prior to using the unbreakable read layout lease.  A safe mechanism
> > to do this would be to take a write layout lease and use fallocate() to set the
> > layout of the file.  The layout lease can then be "downgraded" to unbreakable
> > read layout as long as no other user broke the write layout lease.
> > 
> 
> Will userland require any special privileges in order to set an
> F_UNBREAK lease? This seems like something that could be used for DoS. I
> assume that these will never time out.

Dan and I discussed this some more and yes I think the uid of the process needs
to be the owner of the file.  I think that is a reasonable mechanism.

> 
> How will we deal with the case where something is is squatting on an
> F_UNBREAK lease and isn't letting it go?

That is a good question.  I had not considered someone taking the UNBREAK
without pinning the file.

> 
> Leases are technically "owned" by the file description -- we can't
> necessarily trace it back to a single task in a threaded program. The
> kernel task that set the lease may have exited by the time we go
> looking.
> 
> Will we be content trying to determine this using /proc/locks+lsof, etc,
> or will we need something better?

I think using /proc/locks is our best bet.  Similar to my intention to report
files being pinned.[1]

In fact should we consider files with F_UNBREAK leases "pinned" and just report
them there?

Ira

[1] https://lkml.org/lkml/2019/8/9/1043

> 
> > </fcntl man page addition>
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
