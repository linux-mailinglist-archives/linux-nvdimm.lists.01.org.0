Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A7DA208C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 18:16:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 48EF72021DD3C;
	Thu, 29 Aug 2019 09:18:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E55AC2021DD36
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 09:18:22 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Aug 2019 09:16:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; d="scan'208";a="183523268"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga003.jf.intel.com with ESMTP; 29 Aug 2019 09:16:28 -0700
Date: Thu, 29 Aug 2019 09:16:28 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
Message-ID: <20190829161627.GB18249@iweiny-DESK2.sc.intel.com>
References: <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
 <20190823032345.GG1119@dread.disaster.area>
 <20190823120428.GA12968@ziepe.ca>
 <20190824001124.GI1119@dread.disaster.area>
 <20190824050836.GC1092@iweiny-DESK2.sc.intel.com>
 <20190826055510.GL1119@dread.disaster.area>
 <20190829020230.GA18249@iweiny-DESK2.sc.intel.com>
 <3e5c5053-a74a-509c-660c-a6075ed87f11@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3e5c5053-a74a-509c-660c-a6075ed87f11@nvidia.com>
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
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 28, 2019 at 08:27:23PM -0700, John Hubbard wrote:
> On 8/28/19 7:02 PM, Ira Weiny wrote:
> > On Mon, Aug 26, 2019 at 03:55:10PM +1000, Dave Chinner wrote:
> > > On Fri, Aug 23, 2019 at 10:08:36PM -0700, Ira Weiny wrote:
> > > > On Sat, Aug 24, 2019 at 10:11:24AM +1000, Dave Chinner wrote:
> > > > > On Fri, Aug 23, 2019 at 09:04:29AM -0300, Jason Gunthorpe wrote:
> ...
> > > 
> > > Sure, that part works because the struct file is passed. It doesn't
> > > end up with the same fd number in the other process, though.
> > > 
> > > The issue is that layout leases need to notify userspace when they
> > > are broken by the kernel, so a lease stores the owner pid/tid in the
> > > file->f_owner field via __f_setown(). It also keeps a struct fasync
> > > attached to the file_lock that records the fd that the lease was
> > > created on.  When a signal needs to be sent to userspace for that
> > > lease, we call kill_fasync() and that walks the list of fasync
> > > structures on the lease and calls:
> > > 
> > > 	send_sigio(fown, fa->fa_fd, band);
> > > 
> > > And it does for every fasync struct attached to a lease. Yes, a
> > > lease can track multiple fds, but it can only track them in a single
> > > process context. The moment the struct file is shared with another
> > > process, the lease is no longer capable of sending notifications to
> > > all the lease holders.
> > > 
> > > Yes, you can change the owning process via F_SETOWNER, but that's
> > > still only a single process context, and you can't change the fd in
> > > the fasync list. You can add new fd to an existing lease by calling
> > > F_SETLEASE on the new fd, but you still only have a single process
> > > owner context for signal delivery.
> > > 
> > > As such, leases that require callbacks to userspace are currently
> > > only valid within the process context the lease was taken in.
> > 
> > But for long term pins we are not requiring callbacks.
> > 
> 
> Hi Ira,
> 
> If "require callbacks to userspace" means sending SIGIO, then actually
> FOLL_LONGTERM *does* require those callbacks. Because we've been, so
> far, equating FOLL_LONGTERM with the vaddr_pin struct and with a lease.
> 
> What am I missing here?

We agreed back in June that the layout lease would have 2 "levels".  The
"normal" layout lease would cause SIGIO and could be broken and another
"exclusive" level which could _not_ be broken.

Because we _can't_ _trust_ user space to react to the SIGIO properly the
"exclusive" lease is required to take the longterm pins.  Also this is the
lease which causes the truncate to fail (return ETXTBSY) because the kernel
can't break the lease.

The vaddr_pin struct in the current RFC is there for a couple of reasons.

1) To ensure that we have a way to correlate the long term pin user with the
   file if the data file FD's are closed.  (ie the application has zombie'd the
   lease).

2) And more importantly as a token the vaddr_pin*() callers use to be able to
   properly ref count the file itself while in use.

Ira

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
