Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1024B8A547
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 20:05:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 01E1B21309DDB;
	Mon, 12 Aug 2019 11:08:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 628E521A07093
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 11:08:12 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Aug 2019 11:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; d="scan'208";a="177558391"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga007.fm.intel.com with ESMTP; 12 Aug 2019 11:05:51 -0700
Date: Mon, 12 Aug 2019 11:05:51 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH v2 07/19] fs/xfs: Teach xfs to use new
 dax_layout_busy_page()
Message-ID: <20190812180551.GC19746@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-8-ira.weiny@intel.com>
 <20190809233037.GB7777@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190809233037.GB7777@dread.disaster.area>
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

On Sat, Aug 10, 2019 at 09:30:37AM +1000, Dave Chinner wrote:
> On Fri, Aug 09, 2019 at 03:58:21PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > dax_layout_busy_page() can now operate on a sub-range of the
> > address_space provided.
> > 
> > Have xfs specify the sub range to dax_layout_busy_page()
> 
> Hmmm. I've got patches that change all these XFS interfaces to
> support range locks. I'm not sure the way the ranges are passed here
> is the best way to do it, and I suspect they aren't correct in some
> cases, either....
> 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index ff3c1fae5357..f0de5486f6c1 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -1042,10 +1042,16 @@ xfs_vn_setattr(
> >  		xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> >  		iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> >  
> > -		error = xfs_break_layouts(inode, &iolock, BREAK_UNMAP);
> > -		if (error) {
> > -			xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> > -			return error;
> > +		if (iattr->ia_size < inode->i_size) {
> > +			loff_t                  off = iattr->ia_size;
> > +			loff_t                  len = inode->i_size - iattr->ia_size;
> > +
> > +			error = xfs_break_layouts(inode, &iolock, off, len,
> > +						  BREAK_UNMAP);
> > +			if (error) {
> > +				xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> > +				return error;
> > +			}
> 
> This isn't right - truncate up still needs to break the layout on
> the last filesystem block of the file,

I'm not following this?  From a user perspective they can't have done anything
with the data beyond the EOF.  So isn't it safe to allow EOF to grow without
changing the layout of that last block?

> and truncate down needs to
> extend to "maximum file offset" because we remove all extents beyond
> EOF on a truncate down.

Ok, I was trying to allow a user to extend the file without conflicts if they
were to have a pin on the 'beginning' of the original file.  This sounds like
you are saying that a layout lease must be dropped to do that?  In some ways I
think I understand what you are driving at and I think I see how I may have
been playing "fast and loose" with the strictness of the layout lease.  But
from a user perspective if there is a part of the file which "does not exist"
(beyond EOF) does it matter that the layout there may change?

> 
> i.e. when we use preallocation, the extent map extends beyond EOF,
> and layout leases need to be able to extend beyond the current EOF
> to allow the lease owner to do extending writes, extending truncate,
> preallocation beyond EOF, etc safely without having to get a new
> lease to cover the new region in the extended file...

I'm not following this.  What determines when preallocation is done?

Forgive my ignorance on file systems but how can we have a layout for every
file which is "maximum file offset" for every file even if a file is only 1
page long?

Thanks,
Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
