Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CE29556D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 05:37:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E1CF32007D23D;
	Mon, 19 Aug 2019 20:38:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.246;
 helo=mail104.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au
 [211.29.132.246])
 by ml01.01.org (Postfix) with ESMTP id B7F5B21A07A82
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 20:38:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au
 [49.195.190.67])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 79FD543C142;
 Tue, 20 Aug 2019 13:37:15 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hzuwK-0002SY-6I; Tue, 20 Aug 2019 13:36:08 +1000
Date: Tue, 20 Aug 2019 13:36:08 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
Message-ID: <20190820033608.GB1119@dread.disaster.area>
References: <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <ae64491b-85f8-eeca-14e8-2f09caf8abd2@nvidia.com>
 <20190820012021.GQ7777@dread.disaster.area>
 <84318b51-bd07-1d9b-d842-e65cac2ff484@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <84318b51-bd07-1d9b-d842-e65cac2ff484@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
 a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
 a=7-415B0cAAAA:8 a=PhlOC_QpxKtFCDIvIqEA:9 a=CjuIK1q_8ugA:10
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
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 19, 2019 at 08:09:33PM -0700, John Hubbard wrote:
> On 8/19/19 6:20 PM, Dave Chinner wrote:
> > On Mon, Aug 19, 2019 at 05:05:53PM -0700, John Hubbard wrote:
> > > On 8/19/19 2:24 AM, Dave Chinner wrote:
> > > > On Mon, Aug 19, 2019 at 08:34:12AM +0200, Jan Kara wrote:
> > > > > On Sat 17-08-19 12:26:03, Dave Chinner wrote:
> > > > > > On Fri, Aug 16, 2019 at 12:05:28PM -0700, Ira Weiny wrote:
> > > > > > > On Thu, Aug 15, 2019 at 03:05:58PM +0200, Jan Kara wrote:
> > > > > > > > On Wed 14-08-19 11:08:49, Ira Weiny wrote:
> > > > > > > > > On Wed, Aug 14, 2019 at 12:17:14PM +0200, Jan Kara wrote:
> > > ...
> > > 
> > > Any thoughts about sockets? I'm looking at net/xdp/xdp_umem.c which pins
> > > memory with FOLL_LONGTERM, and wondering how to make that work here.
> > 
> > I'm not sure how this interacts with file mappings? I mean, this
> > is just pinning anonymous pages for direct data placement into
> > userspace, right?
> > 
> > Are you asking "what if this pinned memory was a file mapping?",
> > or something else?
> 
> Yes, mainly that one. Especially since the FOLL_LONGTERM flag is
> already there in xdp_umem_pin_pages(), unconditionally. So the
> simple rules about struct *vaddr_pin usage (set it to NULL if FOLL_LONGTERM is
> not set) are not going to work here.
> 
> 
> > 
> > > These are close to files, in how they're handled, but just different
> > > enough that it's not clear to me how to make work with this system.
> > 
> > I'm guessing that if they are pinning a file backed mapping, they
> > are trying to dma direct to the file (zero copy into page cache?)
> > and so they'll need to either play by ODP rules or take layout
> > leases, too....
> > 
> 
> OK. I was just wondering if there was some simple way to dig up a
> struct file associated with a socket (I don't think so), but it sounds
> like this is an exercise that's potentially different for each subsystem.

AFAIA, there is no struct file here - the memory that has been pinned
is just something mapped into the application's address space.

It seems to me that the socket here is equivalent of the RDMA handle
that that owns the hardware that pins the pages. Again, that RDMA
handle is not aware of waht the mapping represents, hence need to
hold a layout lease if it's a file mapping.

SO from the filesystem persepctive, there's no difference between
XDP or RDMA - if it's a FSDAX mapping then it is DMAing directly
into the filesystem's backing store and that will require use of
layout leases to perform safely.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
