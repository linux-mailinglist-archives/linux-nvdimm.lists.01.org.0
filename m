Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047298231
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 20:02:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1B18520213F05;
	Wed, 21 Aug 2019 11:03:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4307020212C93
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 11:03:11 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Aug 2019 11:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; d="scan'208";a="178574892"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2019 11:02:01 -0700
Date: Wed, 21 Aug 2019 11:02:00 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
Message-ID: <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
References: <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190820115515.GA29246@ziepe.ca>
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
 John Hubbard <jhubbard@nvidia.com>, Dave Chinner <david@fromorbit.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 20, 2019 at 08:55:15AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 20, 2019 at 11:12:10AM +1000, Dave Chinner wrote:
> > On Mon, Aug 19, 2019 at 09:38:41AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Aug 19, 2019 at 07:24:09PM +1000, Dave Chinner wrote:
> > > 
> > > > So that leaves just the normal close() syscall exit case, where the
> > > > application has full control of the order in which resources are
> > > > released. We've already established that we can block in this
> > > > context.  Blocking in an interruptible state will allow fatal signal
> > > > delivery to wake us, and then we fall into the
> > > > fatal_signal_pending() case if we get a SIGKILL while blocking.
> > > 
> > > The major problem with RDMA is that it doesn't always wait on close() for the
> > > MR holding the page pins to be destoyed. This is done to avoid a
> > > deadlock of the form:
> > > 
> > >    uverbs_destroy_ufile_hw()
> > >       mutex_lock()
> > >        [..]
> > >         mmput()
> > >          exit_mmap()
> > >           remove_vma()
> > >            fput();
> > >             file_operations->release()
> > 
> > I think this is wrong, and I'm pretty sure it's an example of why
> > the final __fput() call is moved out of line.
> 
> Yes, I think so too, all I can say is this *used* to happen, as we
> have special code avoiding it, which is the code that is messing up
> Ira's lifetime model.
> 
> Ira, you could try unraveling the special locking, that solves your
> lifetime issues?

Yes I will try to prove this out...  But I'm still not sure this fully solves
the problem.

This only ensures that the process which has the RDMA context (RDMA FD) is safe
with regard to hanging the close for the "data file FD" (the file which has
pinned pages) in that _same_ process.  But what about the scenario.

Process A has the RDMA context FD and data file FD (with lease) open.

Process A uses SCM_RIGHTS to pass the RDMA context FD to Process B.

Process A attempts to exit (hangs because data file FD is pinned).

Admin kills process A.  kill works because we have allowed for it...

Process B _still_ has the RDMA context FD open _and_ therefore still holds the
file pins.

Truncation still fails.

Admin does not know which process is holding the pin.

What am I missing?

Ira

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
