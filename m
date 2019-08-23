Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C679B538
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Aug 2019 19:15:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DCF2D20215F51;
	Fri, 23 Aug 2019 10:17:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C29B220215F42
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 10:17:49 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 10:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,422,1559545200"; d="scan'208";a="180736561"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2019 10:15:07 -0700
Date: Fri, 23 Aug 2019 10:15:04 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
Message-ID: <20190823171504.GA1092@iweiny-DESK2.sc.intel.com>
References: <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190823005914.GF1119@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190823005914.GF1119@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Aug 23, 2019 at 10:59:14AM +1000, Dave Chinner wrote:
> On Wed, Aug 21, 2019 at 11:02:00AM -0700, Ira Weiny wrote:
> > On Tue, Aug 20, 2019 at 08:55:15AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 20, 2019 at 11:12:10AM +1000, Dave Chinner wrote:
> > > > On Mon, Aug 19, 2019 at 09:38:41AM -0300, Jason Gunthorpe wrote:
> > > > > On Mon, Aug 19, 2019 at 07:24:09PM +1000, Dave Chinner wrote:
> > > > > 
> > > > > > So that leaves just the normal close() syscall exit case, where the
> > > > > > application has full control of the order in which resources are
> > > > > > released. We've already established that we can block in this
> > > > > > context.  Blocking in an interruptible state will allow fatal signal
> > > > > > delivery to wake us, and then we fall into the
> > > > > > fatal_signal_pending() case if we get a SIGKILL while blocking.
> > > > > 
> > > > > The major problem with RDMA is that it doesn't always wait on close() for the
> > > > > MR holding the page pins to be destoyed. This is done to avoid a
> > > > > deadlock of the form:
> > > > > 
> > > > >    uverbs_destroy_ufile_hw()
> > > > >       mutex_lock()
> > > > >        [..]
> > > > >         mmput()
> > > > >          exit_mmap()
> > > > >           remove_vma()
> > > > >            fput();
> > > > >             file_operations->release()
> > > > 
> > > > I think this is wrong, and I'm pretty sure it's an example of why
> > > > the final __fput() call is moved out of line.
> > > 
> > > Yes, I think so too, all I can say is this *used* to happen, as we
> > > have special code avoiding it, which is the code that is messing up
> > > Ira's lifetime model.
> > > 
> > > Ira, you could try unraveling the special locking, that solves your
> > > lifetime issues?
> > 
> > Yes I will try to prove this out...  But I'm still not sure this fully solves
> > the problem.
> > 
> > This only ensures that the process which has the RDMA context (RDMA FD) is safe
> > with regard to hanging the close for the "data file FD" (the file which has
> > pinned pages) in that _same_ process.  But what about the scenario.
> > 
> > Process A has the RDMA context FD and data file FD (with lease) open.
> > 
> > Process A uses SCM_RIGHTS to pass the RDMA context FD to Process B.
> 
> Passing the RDMA context dependent on a file layout lease to another
> process that doesn't have a file layout lease or a reference to the
> original lease should be considered a violation of the layout lease.
> Process B does not have an active layout lease, and so by the rules
> of layout leases, it is not allowed to pin the layout of the file.
> 

I don't disagree with the semantics of this.  I just don't know how to enforce
it.

> > Process A attempts to exit (hangs because data file FD is pinned).
> > 
> > Admin kills process A.  kill works because we have allowed for it...
> > 
> > Process B _still_ has the RDMA context FD open _and_ therefore still holds the
> > file pins.
> > 
> > Truncation still fails.
> > 
> > Admin does not know which process is holding the pin.
> > 
> > What am I missing?
> 
> Application does not hold the correct file layout lease references.
> Passing the fd via SCM_RIGHTS to a process without a layout lease
> is equivalent to not using layout leases in the first place.

Ok, So If I understand you correctly you would support a failure of SCM_RIGHTS
in this case?  I'm ok with that but not sure how to implement it right now.

To that end, I would like to simplify this slightly because I'm not convinced
that SCM_RIGHTS is a problem we need to solve right now.  ie I don't know of a
user who wants to do this.

Right now duplication via SCM_RIGHTS could fail if _any_ file pins (and by
definition leases) exist underneath the "RDMA FD" (or other direct access FD,
like XDP etc) being duplicated.  Later, if this becomes a use case we will need
to code up the proper checks, potentially within each of the subsystems.  This
is because, with RDMA at least, there are potentially large numbers of MR's and
file leases which may have to be checked.

Ira

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
