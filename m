Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3529445240
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 04:59:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C0C2F21296B36;
	Thu, 13 Jun 2019 19:59:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.42;
 helo=mail106.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail106.syd.optusnet.com.au (mail106.syd.optusnet.com.au
 [211.29.132.42]) by ml01.01.org (Postfix) with ESMTP id BDDDA21296B2F
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 19:59:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au
 [49.195.189.25])
 by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id E4ACC3DD5BC;
 Fri, 14 Jun 2019 12:59:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hbcQW-0005bc-NF; Fri, 14 Jun 2019 12:58:52 +1000
Date: Fri, 14 Jun 2019 12:58:52 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190614025852.GN14363@dread.disaster.area>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
 <20190613203404.GA30404@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190613203404.GA30404@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
 a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
 a=7-415B0cAAAA:8 a=gnJ_ljic2OsQuunJrboA:9 a=CjuIK1q_8ugA:10
 a=biEYGPWJfzWAr4FL6Ov7:22
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Theodore Ts'o <tytso@mit.edu>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 13, 2019 at 01:34:05PM -0700, Ira Weiny wrote:
> On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> > On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> > > On Sat, Jun 08, 2019 at 10:10:36AM +1000, Dave Chinner wrote:
> > > > On Fri, Jun 07, 2019 at 11:25:35AM -0700, Ira Weiny wrote:
> > > > > Are you suggesting that we have something like this from user space?
> > > > > 
> > > > > 	fcntl(fd, F_SETLEASE, F_LAYOUT | F_UNBREAKABLE);
> > > > 
> > > > Rather than "unbreakable", perhaps a clearer description of the
> > > > policy it entails is "exclusive"?
> > > > 
> > > > i.e. what we are talking about here is an exclusive lease that
> > > > prevents other processes from changing the layout. i.e. the
> > > > mechanism used to guarantee a lease is exclusive is that the layout
> > > > becomes "unbreakable" at the filesystem level, but the policy we are
> > > > actually presenting to uses is "exclusive access"...
> > > 
> > > That's rather different from the normal meaning of 'exclusive' in the
> > > context of locks, which is "only one user can have access to this at
> > > a time".
> > 
> > 
> > Layout leases are not locks, they are a user access policy object.
> > It is the process/fd which holds the lease and it's the process/fd
> > that is granted exclusive access.  This is exactly the same semantic
> > as O_EXCL provides for granting exclusive access to a block device
> > via open(), yes?
> > 
> > > As I understand it, this is rather more like a 'shared' or
> > > 'read' lock.  The filesystem would be the one which wants an exclusive
> > > lock, so it can modify the mapping of logical to physical blocks.
> > 
> > ISTM that you're conflating internal filesystem implementation with
> > application visible semantics. Yes, the filesystem uses internal
> > locks to serialise the modification of the things the lease manages
> > access too, but that has nothing to do with the access policy the
> > lease provides to users.
> > 
> > e.g. Process A has an exclusive layout lease on file F. It does an
> > IO to file F. The filesystem IO path checks that Process A owns the
> > lease on the file and so skips straight through layout breaking
> > because it owns the lease and is allowed to modify the layout. It
> > then takes the inode metadata locks to allocate new space and write
> > new data.
> > 
> > Process B now tries to write to file F. The FS checks whether
> > Process B owns a layout lease on file F. It doesn't, so then it
> > tries to break the layout lease so the IO can proceed. The layout
> > breaking code sees that process A has an exclusive layout lease
> > granted, and so returns -ETXTBSY to process B - it is not allowed to
> > break the lease and so the IO fails with -ETXTBSY.
> > 
> > i.e. the exclusive layout lease prevents other processes from
> > performing operations that may need to modify the layout from
> > performing those operations. It does not "lock" the file/inode in
> > any way, it just changes how the layout lease breaking behaves.
> 
> Question: Do we expect Process A to get notified that Process B was attempting
> to change the layout?

In which case?

In the non-exclusive case, yes, the lease gets
recalled and the application needs to play nice and release it's
references and drop the lease.

In the exclusive case, no. The application has said "I don't play
nice with others" and so we basically tell process B to get stuffed
and process A can continue onwards oblivious to the wreckage it
leaves behind....

> This changes the exclusivity semantics.  While Process A has an exclusive lease
> it could release it if notified to allow process B temporary exclusivity.

And then it's not an exclusive lease - it's just a normal layout
lease. Process B -does not need a lease- to write to the file.

All the layout lease does is provide notification to applications
that rely on the layout of the file being under their control that
someone else is about to modify the layout. The lease holder that
"plays nice" then releases the layout and drops it's lease, allowing
process B to begin it's operation.

Process A then immediately takes a new layout lease, and remaps the
file layout via FIEMAP or by creating a new RDMA MR for the mmap
region. THose operations get serialised by the filesystem because
the operation being run by process B is run atomically w.r.t. the
original lease being broken. Hence the new mapping that process A
gets with it's new lease reflects whatever change was made by
process B.

IOWs, the "normal" layout lease recall behaviour provides "temporary
exclusivity" for third parties. If you are able to release leases
temporarily and regain them then there is no need for an exclusive
lease.

> Question 2: Do we expect other process' (say Process C) to also be able to map
> and pin the file?  I believe users will need this and for layout purposes it is
> ok to do so.  But this means that Process A does not have "exclusive" access to
> the lease.

This is an application architecture problem, not a layout lease or
filesystem problem. :)

i.e. if you have a single process controlling all the RDMA mappings,
then you can use exclusive leases. If you have multiple processes
that are uncoordinated and all require layout access to the same
file then you can't use exclusive layout leases in the application.
i.e. your application has to play nice with others.

Indeed, this is more than a application architecture problem - it's
actually a system wide architecture problem.  e.g. the pNFS server
cannot use exclusive layout leases because it has to play nice with
anything else on the local filesystem that might require a layout
lease. An example of this woudl be an app that provides coherent
RDMA access to the same storage that pNFS is sharing (e.g. a
userspace CIFS server).

Hence I see that exclusive layout leases will end up being the
exception rather than the norm, because most applications will need
to play nice with other applications on the system that also
directly access the storage under the filesystem....

> So given Process C has also placed a layout lease on the file.  Indicating
> that it does not want the layout to change.

That is *not what layout leases provide*.

Layout leases grant the owner the ability to map the layout and
directly access the underlying storage and to do it safely because
they will get a notification of 3rd party access that will
invalidate their mapping. Layout leases do not prevent anyone from
_changing_ the layout and, in fact, pNFS _requires_ the lease holder
to be able to modify the layout.

IOWs, the layout lease _as it stands now_ is a notification
mechanism that tells the lease owner when someone else is about to
modify the layout. It does not make the file layout immutable.

The "exclusive" aspect of layout we have been discussing is a
mechanism that prevents 3rd party modification of the layout by
denying the ability to break the layout. This "exclusive" aspect
does not make the layout immutable, either, it just means the
layout is only modifiable by the exclusive lease holder. 

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
