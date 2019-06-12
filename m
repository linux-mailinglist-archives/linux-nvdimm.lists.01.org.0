Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25D431E5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 01:32:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3C78B21295B0B;
	Wed, 12 Jun 2019 16:32:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3381921290DF2
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 16:32:06 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jun 2019 16:32:05 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2019 16:32:04 -0700
Date: Wed, 12 Jun 2019 16:33:25 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190612233324.GE14336@iweiny-DESK2.sc.intel.com>
References: <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
 <20190612114721.GB3876@ziepe.ca>
 <20190612120907.GC14578@quack2.suse.cz>
 <20190612191421.GM3876@ziepe.ca>
 <20190612221336.GA27080@iweiny-DESK2.sc.intel.com>
 <CAPcyv4gkksnceCV-p70hkxAyEPJWFvpMezJA1rEj6TEhKAJ7qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gkksnceCV-p70hkxAyEPJWFvpMezJA1rEj6TEhKAJ7qQ@mail.gmail.com>
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Dave Chinner <david@fromorbit.com>, Jeff Layton <jlayton@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-xfs <linux-xfs@vger.kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 12, 2019 at 03:54:19PM -0700, Dan Williams wrote:
> On Wed, Jun 12, 2019 at 3:12 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Wed, Jun 12, 2019 at 04:14:21PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jun 12, 2019 at 02:09:07PM +0200, Jan Kara wrote:
> > > > On Wed 12-06-19 08:47:21, Jason Gunthorpe wrote:
> > > > > On Wed, Jun 12, 2019 at 12:29:17PM +0200, Jan Kara wrote:
> > > > >
> > > > > > > > The main objection to the current ODP & DAX solution is that very
> > > > > > > > little HW can actually implement it, having the alternative still
> > > > > > > > require HW support doesn't seem like progress.
> > > > > > > >
> > > > > > > > I think we will eventually start seein some HW be able to do this
> > > > > > > > invalidation, but it won't be universal, and I'd rather leave it
> > > > > > > > optional, for recovery from truely catastrophic errors (ie my DAX is
> > > > > > > > on fire, I need to unplug it).
> > > > > > >
> > > > > > > Agreed.  I think software wise there is not much some of the devices can do
> > > > > > > with such an "invalidate".
> > > > > >
> > > > > > So out of curiosity: What does RDMA driver do when userspace just closes
> > > > > > the file pointing to RDMA object? It has to handle that somehow by aborting
> > > > > > everything that's going on... And I wanted similar behavior here.
> > > > >
> > > > > It aborts *everything* connected to that file descriptor. Destroying
> > > > > everything avoids creating inconsistencies that destroying a subset
> > > > > would create.
> > > > >
> > > > > What has been talked about for lease break is not destroying anything
> > > > > but very selectively saying that one memory region linked to the GUP
> > > > > is no longer functional.
> > > >
> > > > OK, so what I had in mind was that if RDMA app doesn't play by the rules
> > > > and closes the file with existing pins (and thus layout lease) we would
> > > > force it to abort everything. Yes, it is disruptive but then the app didn't
> > > > obey the rule that it has to maintain file lease while holding pins. Thus
> > > > such situation should never happen unless the app is malicious / buggy.
> > >
> > > We do have the infrastructure to completely revoke the entire
> > > *content* of a FD (this is called device disassociate). It is
> > > basically close without the app doing close. But again it only works
> > > with some drivers. However, this is more likely something a driver
> > > could support without a HW change though.
> > >
> > > It is quite destructive as it forcibly kills everything RDMA related
> > > the process(es) are doing, but it is less violent than SIGKILL, and
> > > there is perhaps a way for the app to recover from this, if it is
> > > coded for it.
> >
> > I don't think many are...  I think most would effectively be "killed" if this
> > happened to them.
> >
> > >
> > > My preference would be to avoid this scenario, but if it is really
> > > necessary, we could probably build it with some work.
> > >
> > > The only case we use it today is forced HW hot unplug, so it is rarely
> > > used and only for an 'emergency' like use case.
> >
> > I'd really like to avoid this as well.  I think it will be very confusing for
> > RDMA apps to have their context suddenly be invalid.  I think if we have a way
> > for admins to ID who is pinning a file the admin can take more appropriate
> > action on those processes.   Up to and including killing the process.
> 
> Can RDMA context invalidation, "device disassociate", be inflicted on
> a process from the outside? Identifying the pid of a pin holder only
> leaves SIGKILL of the entire process as the remediation for revoking a
> pin, and I assume admins would use the finer grained invalidation
> where it was available.

No not in the way you are describing it.  As Jason said you can hotplug the
device which is "from the outside" but this would affect all users of that
device.

Effectively, we would need a way for an admin to close a specific file
descriptor (or set of fds) which point to that file.  AFAIK there is no way to
do that at all, is there?

Ira

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
