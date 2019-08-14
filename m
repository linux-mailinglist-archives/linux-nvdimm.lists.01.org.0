Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884728DC92
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Aug 2019 20:01:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D74D2031120D;
	Wed, 14 Aug 2019 11:03:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F0513202EA3FB
 for <linux-nvdimm@lists.01.org>; Wed, 14 Aug 2019 11:03:03 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Aug 2019 11:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; d="scan'208";a="181636379"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga006.jf.intel.com with ESMTP; 14 Aug 2019 10:50:45 -0700
Date: Wed, 14 Aug 2019 10:50:45 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH v2 16/19] RDMA/uverbs: Add back pointer to system
 file object
Message-ID: <20190814175045.GA31490@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-17-ira.weiny@intel.com>
 <20190812130039.GD24457@ziepe.ca>
 <20190812172826.GA19746@iweiny-DESK2.sc.intel.com>
 <20190812175615.GI24457@ziepe.ca>
 <20190812211537.GE20634@iweiny-DESK2.sc.intel.com>
 <20190813114842.GB29508@ziepe.ca>
 <20190813174142.GB11882@iweiny-DESK2.sc.intel.com>
 <20190813180022.GF29508@ziepe.ca>
 <20190813203858.GA12695@iweiny-DESK2.sc.intel.com>
 <20190814122308.GB13770@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190814122308.GB13770@ziepe.ca>
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

On Wed, Aug 14, 2019 at 09:23:08AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 13, 2019 at 01:38:59PM -0700, Ira Weiny wrote:
> > On Tue, Aug 13, 2019 at 03:00:22PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 13, 2019 at 10:41:42AM -0700, Ira Weiny wrote:
> > > 
> > > > And I was pretty sure uverbs_destroy_ufile_hw() would take care of (or ensure
> > > > that some other thread is) destroying all the MR's we have associated with this
> > > > FD.
> > > 
> > > fd's can't be revoked, so destroy_ufile_hw() can't touch them. It
> > > deletes any underlying HW resources, but the FD persists.
> > 
> > I misspoke.  I should have said associated with this "context".  And of course
> > uverbs_destroy_ufile_hw() does not touch the FD.  What I mean is that the
> > struct file which had file_pins hanging off of it would be getting its file
> > pins destroyed by uverbs_destroy_ufile_hw().  Therefore we don't need the FD
> > after uverbs_destroy_ufile_hw() is done.
> > 
> > But since it does not block it may be that the struct file is gone before the
> > MR is actually destroyed.  Which means I think the GUP code would blow up in
> > that case...  :-(
> 
> Oh, yes, that is true, you also can't rely on the struct file living
> longer than the HW objects either, that isn't how the lifetime model
> works.
> 
> If GUP consumes the struct file it must allow the struct file to be
> deleted before the GUP pin is released.

I may have to think about this a bit.  But I'm starting to lean toward my
callback method as a solution...

> 
> > The drivers could provide some generic object (in RDMA this could be the
> > uverbs_attr_bundle) which represents their "context".
> 
> For RDMA the obvious context is the struct ib_mr *

Not really, but maybe.  See below regarding tracking this across processes.

> 
> > But for the procfs interface, that context then needs to be associated with any
> > file which points to it...  For RDMA, or any other "FD based pin mechanism", it
> > would be up to the driver to "install" a procfs handler into any struct file
> > which _may_ point to this context.  (before _or_ after memory pins).
> 
> Is this all just for debugging? Seems like a lot of complication just
> to print a string

No, this is a requirement to allow an admin to determine why their truncates
may be failing.  As per our discussion here:

https://lkml.org/lkml/2019/6/7/982

Looking back at the thread apparently no one confirmed my question (assertion).
But no one objected to it either!  :-D  From that post:

	"... if we can keep track of who has the pins in lsof can we agree no
	process needs to be SIGKILL'ed?  Admins can do this on their own
	"killing" if they really need to stop the use of these files, right?"

This is what I am trying to do here is ensure that no matter what the user
does.  Fork, munmap, SCM_RIGHTS, close (on any FD), the underlying pin is
associated to any process which has access to those pins and is holding
references to those pages.  Then any user of the system who gets a failing
truncate can figure out which processes are holding this up.

> 
> Generally, I think you'd be better to associate things with the
> mm_struct not some struct file... The whole design is simpler as GUP
> already has the mm_struct.

I wish I _could_ do that...  And for some simple users I do that.  This is why
rdma_pin has the option to track against mm_struct _OR_ struct file.

At first it seemed like carrying over the mm_struct info during fork would
work...  but then there is SCM_RIGHTS where one can share the RDMA context with
any "random" process...  AFAICS struct file has no concept of mm_struct (nor
should it) so the dup for SCM_RIGHTS processing would not be able to do this.
A further complication was that when the RDMA FD is dup'ed the RDMA subsystem
does not know about it...  So it was not straight forward to have the RDMA
subsystem do this either.  Not to mention that would be yet another
complication the drivers would have to deal with...  I think you had similar
issues which lead to the use of an "owning_mm" in the umem object.  So while
_some_ mm_struct is held it may not be visible to the user since that mm_struct
may belong to a process which is gone... Or even if not gone, killing it would not
fully remove the pin...

So keeping this tracked against struct file works (and seemed straight forward)
no matter where/how the RDMA FD is shared...  Even with the complication above
I still think it is easier to do this way.

If I am missing something WRT the mm_struct "I'm all ears".

Ira

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
