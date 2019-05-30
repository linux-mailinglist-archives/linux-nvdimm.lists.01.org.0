Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57830517
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 May 2019 00:59:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3CB3621962301;
	Thu, 30 May 2019 15:59:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.42;
 helo=mail106.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail106.syd.optusnet.com.au (mail106.syd.optusnet.com.au
 [211.29.132.42]) by ml01.01.org (Postfix) with ESMTP id 9B7EA21281EE5
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 15:59:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-144-61.pa.nsw.optusnet.com.au
 [49.180.144.61])
 by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 236DD3DC5A0;
 Fri, 31 May 2019 08:59:28 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hWU17-0000OZ-Vz; Fri, 31 May 2019 08:59:25 +1000
Date: Fri, 31 May 2019 08:59:25 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
Message-ID: <20190530225925.GG16786@dread.disaster.area>
References: <1620c513-4ce2-84b0-33dc-2675246183ea@cn.fujitsu.com>
 <20190528091729.GD9607@quack2.suse.cz>
 <a3a919e6-ecad-bdf6-423c-fc01f9cfa661@cn.fujitsu.com>
 <20190529024749.GC16786@dread.disaster.area>
 <376256fd-dee4-5561-eb4e-546e227303cd@cn.fujitsu.com>
 <20190529040719.GL5221@magnolia>
 <20190529044658.GD16786@dread.disaster.area>
 <20190529134629.GA32147@quack2.suse.cz>
 <20190529221445.GE16786@dread.disaster.area>
 <20190530111605.GC29237@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190530111605.GC29237@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
 a=8RU0RCro9O0HS2ezTvitPg==:117 a=8RU0RCro9O0HS2ezTvitPg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
 a=7-415B0cAAAA:8 a=b_IONgiTaRX6Mws2oq4A:9 a=CjuIK1q_8ugA:10
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
Cc: kilobyte@angband.pl, "Darrick J. Wong" <darrick.wong@oracle.com>,
 nborisov@suse.com, Goldwyn Rodrigues <rgoldwyn@suse.de>,
 linux-nvdimm@lists.01.org, dsterba@suse.cz, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 30, 2019 at 01:16:05PM +0200, Jan Kara wrote:
> On Thu 30-05-19 08:14:45, Dave Chinner wrote:
> > On Wed, May 29, 2019 at 03:46:29PM +0200, Jan Kara wrote:
> > > On Wed 29-05-19 14:46:58, Dave Chinner wrote:
> > > >  iomap_apply()
> > > > 
> > > >  	->iomap_begin()
> > > > 		map old data extent that we copy from
> > > > 
> > > > 		allocate new data extent we copy to in data fork,
> > > > 		immediately replacing old data extent
> > > > 
> > > > 		return transaction handle as private data
> > 
> > This holds the inode block map locked exclusively across the IO,
> > so....
> 
> Does it? We do hold XFS_IOLOCK_EXCL during the whole dax write.

I forgot about that, I keep thinking that we use shared locking for
DAX like we do for direct IO. There's another reason for range
locks - allowing concurrent DAX read/write IO - but that's
orthogonal to the issue here.

> But
> xfs_file_iomap_begin() does release XFS_ILOCK_* on exit AFAICS. So I don't
> see anything that would prevent page fault from mapping blocks into page
> tables just after xfs_file_iomap_begin() returns.

Right, holding the IOLOCK doesn't stop concurrent page faults from
mapping the page we are trying to write, and that leaves a window
where stale data can be exposed if we don't initialise the newly
allocated range whilst in the allocation transaction holding the
ILOCK. That's what the XFS_BMAPI_ZERO flag does in the DAX block
allocation path.

So the idea of holding the allocation transaction across the data
copy means that ILOCK is then held until the data blocks are fully
initialised with valid data, meaning we can greatly reduce the scope
of the XFS_BMAPI_ZERO flag and possible get rid of it altogether.

> > > This race was actually the strongest
> > > motivation for pre-zeroing of blocks. OTOH copy_from_iter() in
> > > dax_iomap_actor() needs to be able to fault pages to copy from (and these
> > > pages may be from the same file you're writing to) so you cannot just block
> > > faulting for the file through I_MMAP_LOCK.
> > 
> > Right, it doesn't take the I_MMAP_LOCK, but it would block further
> > in. And, really, I'm not caring all this much about this corner
> > case. i.e.  anyone using a "mmap()+write() zero copy" pattern on DAX
> > within a file is unbeleivably naive - the data still gets copied by
> > the CPU in the write() call. It's far simpler and more effcient to
> > just mmap() both ranges of the file(s) and memcpy() in userspace....
> > 
> > FWIW, it's to avoid problems with stupid userspace stuff that nobody
> > really should be doing that I want range locks for the XFS inode
> > locks.  If userspace overlaps the ranges and deadlocks in that case,
> > they they get to keep all the broken bits because, IMO, they are
> > doing something monumentally stupid. I'd probably be making it
> > return EDEADLOCK back out to userspace in the case rather than
> > deadlocking but, fundamentally, I think it's broken behaviour that
> > we should be rejecting with an error rather than adding complexity
> > trying to handle it.
> 
> I agree with this. We must just prevent user from taking the kernel down
> with maliciously created IOs...

Noted. :)

I'm still working to scale the range locks effectively for direct
IO; I've got to work out why sometimes they give identical
performance to rwsems out to 16 threads, and other times they run
20% slower or worse at 8+ threads. I'm way ahead of the original
mutex protected tree implementation that I have, but still got work
to do to get consistently close to rwsem performance for pure shared
locking workloads like direct IO.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
