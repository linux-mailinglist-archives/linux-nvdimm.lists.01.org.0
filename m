Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC3437A9B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 19:10:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 76E5A2128DD4F;
	Thu,  6 Jun 2019 10:10:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D35472127675B
 for <linux-nvdimm@lists.01.org>; Thu,  6 Jun 2019 10:10:47 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jun 2019 10:10:47 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga001.jf.intel.com with ESMTP; 06 Jun 2019 10:10:46 -0700
Date: Thu, 6 Jun 2019 10:11:58 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190606171158.GB11374@iweiny-DESK2.sc.intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <c559c2ce-50dc-d143-5741-fe3d21d0305c@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c559c2ce-50dc-d143-5741-fe3d21d0305c@nvidia.com>
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Theodore Ts'o <tytso@mit.edu>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 05, 2019 at 10:52:12PM -0700, John Hubbard wrote:
> On 6/5/19 6:45 PM, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > ... V1,000,000   ;-)
> > 
> > Pre-requisites:
> > 	John Hubbard's put_user_pages() patch series.[1]
> > 	Jan Kara's ext4_break_layouts() fixes[2]
> > 
> > Based on the feedback from LSFmm and the LWN article which resulted.  I've
> > decided to take a slightly different tack on this problem.
> > 
> > The real issue is that there is no use case for a user to have RDMA pinn'ed
> > memory which is then truncated.  So really any solution we present which:
> > 
> > A) Prevents file system corruption or data leaks
> > ...and...
> > B) Informs the user that they did something wrong
> > 
> > Should be an acceptable solution.
> > 
> > Because this is slightly new behavior.  And because this is gonig to be
> > specific to DAX (because of the lack of a page cache) we have made the user
> > "opt in" to this behavior.
> > 
> > The following patches implement the following solution.
> > 
> > 1) The user has to opt in to allowing GUP pins on a file with a layout lease
> >    (now made visible).
> > 2) GUP will fail (EPERM) if a layout lease is not taken
> > 3) Any truncate or hole punch operation on a GUP'ed DAX page will fail.
> > 4) The user has the option of holding the layout lease to receive a SIGIO for
> >    notification to the original thread that another thread has tried to delete
> >    their data.  Furthermore this indicates that if the user needs to GUP the
> >    file again they will need to retake the Layout lease before doing so.
> > 
> > 
> > NOTE: If the user releases the layout lease or if it has been broken by another
> > operation further GUP operations on the file will fail without re-taking the
> > lease.  This means that if a user would like to register pieces of a file and
> > continue to register other pieces later they would be advised to keep the
> > layout lease, get a SIGIO notification, and retake the lease.
> > 
> > NOTE2: Truncation of pages which are not actively pinned will succeed.  Similar
> > to accessing an mmap to this area GUP pins of that memory may fail.
> > 
> 
> Hi Ira,
> 
> Wow, great to see this. This looks like basically the right behavior, IMHO.
> 
> 1. We'll need man page additions, to explain it. In fact, even after a quick first
> pass through, I'm vague on two points:

Of course.  But I was not going to go through and attempt to write man pages
and other docs without some agreement on the final mechanisms.  This works
which was the basic requirement I had to send an RFC.  :-D  But yes man pages
and updates to headers etc all have to be done.

> 
> a) I'm not sure how this actually provides "opt-in to new behavior", because I 
> don't see any CONFIG_* or boot time choices, and it looks like the new behavior 
> just is there. That is, if user space doesn't set F_LAYOUT on a range, 
> GUP FOLL_LONGTERM will now fail, which is new behavior. (Did I get that right?)

The opt in is at run time.  Currently GUP FOLL_LONGTERM is _not_ _allowed_ on
the FS DAX pages at all.  So the default behavior is the same, GUP fails.  (Or
specifically ibv_reg_mr() fails.  This fails as before, not change there.

The Opt in is that if a user knows what is involved they can take the lease and
the GUP will not fail.  This comes with the price of knowing that other
processes can't truncate those pages in use.

> 
> b) Truncate and hole punch behavior, with and without user space having a SIGIO
> handler. (I'm sure this is obvious after another look through, but it might go
> nicely in a man page.)

Sorry this was not clear.  There are 2 points for this patch set which requires
the use of catching SIGIO.

1) If an application _actually_ does (somehow, somewhere, in some unforseen use
   case) want to allow a truncate to happen.  They can catch the SIGIO, finish
   their use of the pages, and release them.  As long as they can do this within
   the <sysfs>/lease-time-break time they are ok and the truncate can proceed.

2) This is a bit more subtle and something I almost delayed sending these out
   for.  Currently the implementation of a lease break actually removes the
   lease from the file.  I did not want this to happen and I was thinking of
   delaying this patch set to implement something which keeps the lease around
   but I figured I should get something out for comments.  Jan has proposed
   something along these lines and I agree with him so I'm going to ask you to
   read my response to him about the details.

   Anyway so the key here is that currently an app needs the SIGIO to retake
   the lease if they want to map the file again or in parts based on usage.
   For example, they may only want to map some of the file for when they are
   using it and then map another part later.  Without the SIGIO they would lose
   their lease or would have to just take the lease for each GUP pin (which
   adds overhead).  Like I said I did not like this but I left it to get
   something which works out.

> 
> 2. It *seems* like ext4, xfs are taken care of here, not just for the DAX case,
> but for general RDMA on them? Or is there more that must be done?

This is limited to DAX.  All the functionality is limited to *_devmap or "is
DAX" cases.  I'm still thinking that page cache backed files can have a better
solution for the user.

> 
> 3. Christophe Hellwig's unified gup patchset wreaks havoc in gup.c, and will
> conflict violently, as I'm sure you noticed. :)

Yep...  But I needed to get the conversation started on this idea.

Thanks for the feedback!
Ira

> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
