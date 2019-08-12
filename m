Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8695C8A4C4
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 19:36:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EA1EB21309DC7;
	Mon, 12 Aug 2019 10:38:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0871021309D0C
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 10:38:46 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Aug 2019 10:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; d="scan'208";a="194012289"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2019 10:36:26 -0700
Date: Mon, 12 Aug 2019 10:36:26 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH v2 01/19] fs/locks: Export F_LAYOUT lease to user space
Message-ID: <20190812173626.GB19746@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-2-ira.weiny@intel.com>
 <20190809235231.GC7777@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190809235231.GC7777@dread.disaster.area>
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

On Sat, Aug 10, 2019 at 09:52:31AM +1000, Dave Chinner wrote:
> On Fri, Aug 09, 2019 at 03:58:15PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > In order to support an opt-in policy for users to allow long term pins
> > of FS DAX pages we need to export the LAYOUT lease to user space.
> > 
> > This is the first of 2 new lease flags which must be used to allow a
> > long term pin to be made on a file.
> > 
> > After the complete series:
> > 
> > 0) Registrations to Device DAX char devs are not affected
> > 
> > 1) The user has to opt in to allowing page pins on a file with an exclusive
> >    layout lease.  Both exclusive and layout lease flags are user visible now.
> > 
> > 2) page pins will fail if the lease is not active when the file back page is
> >    encountered.
> > 
> > 3) Any truncate or hole punch operation on a pinned DAX page will fail.
> > 
> > 4) The user has the option of holding the lease or releasing it.  If they
> >    release it no other pin calls will work on the file.
> > 
> > 5) Closing the file is ok.
> > 
> > 6) Unmapping the file is ok
> > 
> > 7) Pins against the files are tracked back to an owning file or an owning mm
> >    depending on the internal subsystem needs.  With RDMA there is an owning
> >    file which is related to the pined file.
> > 
> > 8) Only RDMA is currently supported
> > 
> > 9) Truncation of pages which are not actively pinned nor covered by a lease
> >    will succeed.
> 
> This has nothing to do with layout leases or what they provide
> access arbitration over. Layout leases have _nothing_ to do with
> page pinning or RDMA - they arbitrate behaviour the file offset ->
> physical block device mapping within the filesystem and the
> behaviour that will occur when a specific lease is held.
> 
> The commit descripting needs to describe what F_LAYOUT actually
> protects, when they'll get broken, etc, not how RDMA is going to use
> it.

Ok yes I've been lax in mixing the cover letter for the series and this first
commit message.  My apologies.

> 
> > @@ -2022,8 +2030,26 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, long arg)
> >  	struct file_lock *fl;
> >  	struct fasync_struct *new;
> >  	int error;
> > +	unsigned int flags = 0;
> > +
> > +	/*
> > +	 * NOTE on F_LAYOUT lease
> > +	 *
> > +	 * LAYOUT lease types are taken on files which the user knows that
> > +	 * they will be pinning in memory for some indeterminate amount of
> > +	 * time.
> 
> Indeed, layout leases have nothing to do with pinning of memory.

Yep, Fair enough.  I'll rework the comment.

> That's something an application taht uses layout leases might do,
> but it largely irrelevant to the functionality layout leases
> provide. What needs to be done here is explain what the layout lease
> API actually guarantees w.r.t. the physical file layout, not what
> some application is going to do with a lease. e.g.
> 
> 	The layout lease F_RDLCK guarantees that the holder will be
> 	notified that the physical file layout is about to be
> 	changed, and that it needs to release any resources it has
> 	over the range of this lease, drop the lease and then
> 	request it again to wait for the kernel to finish whatever
> 	it is doing on that range.
> 
> 	The layout lease F_RDLCK also allows the holder to modify
> 	the physical layout of the file. If an operation from the
> 	lease holder occurs that would modify the layout, that lease
> 	holder does not get notification that a change will occur,
> 	but it will block until all other F_RDLCK leases have been
> 	released by their holders before going ahead.
> 
> 	If there is a F_WRLCK lease held on the file, then a F_RDLCK
> 	holder will fail any operation that may modify the physical
> 	layout of the file. F_WRLCK provides exclusive physical
> 	modification access to the holder, guaranteeing nothing else
> 	will change the layout of the file while it holds the lease.
> 
> 	The F_WRLCK holder can change the physical layout of the
> 	file if it so desires, this will block while F_RDLCK holders
> 	are notified and release their leases before the
> 	modification will take place.
> 
> We need to define the semantics we expose to userspace first.....

Agreed.  I believe I have implemented the semantics you describe above.  Do I
have your permission to use your verbiage as part of reworking the comment and
commit message?

Thanks,
Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
