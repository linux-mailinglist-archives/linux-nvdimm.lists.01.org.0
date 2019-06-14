Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE1B451C9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 04:10:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B58BE21296B2E;
	Thu, 13 Jun 2019 19:10:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.42;
 helo=mail106.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail106.syd.optusnet.com.au (mail106.syd.optusnet.com.au
 [211.29.132.42]) by ml01.01.org (Postfix) with ESMTP id 0689821250CAE
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 19:10:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au
 [49.195.189.25])
 by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 6E77A3DCE8B;
 Fri, 14 Jun 2019 12:10:19 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hbbeb-0005G5-AA; Fri, 14 Jun 2019 12:09:21 +1000
Date: Fri, 14 Jun 2019 12:09:21 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190614020921.GM14363@dread.disaster.area>
References: <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
 <20190613152755.GI32656@bombadil.infradead.org>
 <20190613211321.GC32404@iweiny-DESK2.sc.intel.com>
 <20190613234530.GK22901@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190613234530.GK22901@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
 a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
 a=7-415B0cAAAA:8 a=MIoJepgKeDxvTzH8FPQA:9 a=CjuIK1q_8ugA:10
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm@lists.01.org,
 linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 13, 2019 at 08:45:30PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 02:13:21PM -0700, Ira Weiny wrote:
> > On Thu, Jun 13, 2019 at 08:27:55AM -0700, Matthew Wilcox wrote:
> > > On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> > > > e.g. Process A has an exclusive layout lease on file F. It does an
> > > > IO to file F. The filesystem IO path checks that Process A owns the
> > > > lease on the file and so skips straight through layout breaking
> > > > because it owns the lease and is allowed to modify the layout. It
> > > > then takes the inode metadata locks to allocate new space and write
> > > > new data.
> > > > 
> > > > Process B now tries to write to file F. The FS checks whether
> > > > Process B owns a layout lease on file F. It doesn't, so then it
> > > > tries to break the layout lease so the IO can proceed. The layout
> > > > breaking code sees that process A has an exclusive layout lease
> > > > granted, and so returns -ETXTBSY to process B - it is not allowed to
> > > > break the lease and so the IO fails with -ETXTBSY.
> > > 
> > > This description doesn't match the behaviour that RDMA wants either.
> > > Even if Process A has a lease on the file, an IO from Process A which
> > > results in blocks being freed from the file is going to result in the
> > > RDMA device being able to write to blocks which are now freed (and
> > > potentially reallocated to another file).
> > 
> > I don't understand why this would not work for RDMA?  As long as the layout
> > does not change the page pins can remain in place.
> 
> Because process A had a layout lease (and presumably a MR) and the
> layout was still modified in way that invalidates the RDMA MR.

The lease holder is allowed to modify the mapping it has a lease
over. That's necessary so lease holders can write data into
unallocated space in the file. The lease is there to prevent third
parties from modifying the layout without the lease holder being
informed and taking appropriate action to allow that 3rd party
modification to occur.

If the lease holder modifies the mapping in a way that causes it's
own internal state to screw up, then that's a bug in the lease
holder application.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
