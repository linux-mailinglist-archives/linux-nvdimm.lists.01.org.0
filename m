Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 409459534B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 03:21:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60BEC2020D336;
	Mon, 19 Aug 2019 18:22:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.249;
 helo=mail105.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au
 [211.29.132.249])
 by ml01.01.org (Postfix) with ESMTP id EE7972020D329
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 18:22:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au
 [49.195.190.67])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 484EE362204;
 Tue, 20 Aug 2019 11:21:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hzsov-0001Ym-Er; Tue, 20 Aug 2019 11:20:21 +1000
Date: Tue, 20 Aug 2019 11:20:21 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
Message-ID: <20190820012021.GQ7777@dread.disaster.area>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <ae64491b-85f8-eeca-14e8-2f09caf8abd2@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ae64491b-85f8-eeca-14e8-2f09caf8abd2@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
 a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
 a=7-415B0cAAAA:8 a=rV-TrcAmjTgZ-WCYr6sA:9 a=T_cMid2Q6N9PW1nF:21
 a=ZVtkOv0JeXpnhdDN:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
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

On Mon, Aug 19, 2019 at 05:05:53PM -0700, John Hubbard wrote:
> On 8/19/19 2:24 AM, Dave Chinner wrote:
> > On Mon, Aug 19, 2019 at 08:34:12AM +0200, Jan Kara wrote:
> > > On Sat 17-08-19 12:26:03, Dave Chinner wrote:
> > > > On Fri, Aug 16, 2019 at 12:05:28PM -0700, Ira Weiny wrote:
> > > > > On Thu, Aug 15, 2019 at 03:05:58PM +0200, Jan Kara wrote:
> > > > > > On Wed 14-08-19 11:08:49, Ira Weiny wrote:
> > > > > > > On Wed, Aug 14, 2019 at 12:17:14PM +0200, Jan Kara wrote:
> ...
> > The last close is an interesting case because the __fput() call
> > actually runs from task_work() context, not where the last reference
> > is actually dropped. So it already has certain specific interactions
> > with signals and task exit processing via task_add_work() and
> > task_work_run().
> > 
> > task_add_work() calls set_notify_resume(task), so if nothing else
> > triggers when returning to userspace we run this path:
> > 
> > exit_to_usermode_loop()
> >    tracehook_notify_resume()
> >      task_work_run()
> >        __fput()
> > 	locks_remove_file()
> > 	  locks_remove_lease()
> > 	    ....
> > 
> > It's worth noting that locks_remove_lease() does a
> > percpu_down_read() which means we can already block in this context
> > removing leases....
> > 
> > If there is a signal pending, the task work is run this way (before
> > the above notify path):
> > 
> > exit_to_usermode_loop()
> >    do_signal()
> >      get_signal()
> >        task_work_run()
> >          __fput()
> > 
> > We can detect this case via signal_pending() and even SIGKILL via
> > fatal_signal_pending(), and so we can decide not to block based on
> > the fact the process is about to be reaped and so the lease largely
> > doesn't matter anymore. I'd argue that it is close and we can't
> > easily back out, so we'd only break the block on a fatal signal....
> > 
> > And then, of course, is the call path through do_exit(), which has
> > the PF_EXITING task flag set:
> > 
> > do_exit()
> >    exit_task_work()
> >      task_work_run()
> >        __fput()
> > 
> > and so it's easy to avoid blocking in this case, too.
> 
> Any thoughts about sockets? I'm looking at net/xdp/xdp_umem.c which pins
> memory with FOLL_LONGTERM, and wondering how to make that work here.

I'm not sure how this interacts with file mappings? I mean, this
is just pinning anonymous pages for direct data placement into
userspace, right?

Are you asking "what if this pinned memory was a file mapping?",
or something else?

> These are close to files, in how they're handled, but just different
> enough that it's not clear to me how to make work with this system.

I'm guessing that if they are pinning a file backed mapping, they
are trying to dma direct to the file (zero copy into page cache?)
and so they'll need to either play by ODP rules or take layout
leases, too....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
