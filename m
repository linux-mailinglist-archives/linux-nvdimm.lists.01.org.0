Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7AF8A56F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 20:12:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 91FEC21309DD8;
	Mon, 12 Aug 2019 11:14:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 35A8C21309D21
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 11:14:39 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Aug 2019 11:08:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; d="scan'208";a="175965853"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2019 11:08:42 -0700
Date: Mon, 12 Aug 2019 11:08:42 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH v2 08/19] fs/xfs: Fail truncate if page lease can't
 be broken
Message-ID: <20190812180841.GD19746@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-9-ira.weiny@intel.com>
 <20190809232209.GA7777@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190809232209.GA7777@dread.disaster.area>
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

On Sat, Aug 10, 2019 at 09:22:09AM +1000, Dave Chinner wrote:
> On Fri, Aug 09, 2019 at 03:58:22PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > If pages are under a lease fail the truncate operation.  We change the order of
> > lease breaks to directly fail the operation if the lease exists.
> > 
> > Select EXPORT_BLOCK_OPS for FS_DAX to ensure that xfs_break_lease_layouts() is
> > defined for FS_DAX as well as pNFS.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/Kconfig        | 1 +
> >  fs/xfs/xfs_file.c | 5 +++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 14cd4abdc143..c10b91f92528 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -48,6 +48,7 @@ config FS_DAX
> >  	select DEV_PAGEMAP_OPS if (ZONE_DEVICE && !FS_DAX_LIMITED)
> >  	select FS_IOMAP
> >  	select DAX
> > +	select EXPORTFS_BLOCK_OPS
> >  	help
> >  	  Direct Access (DAX) can be used on memory-backed block devices.
> >  	  If the block device supports DAX and the filesystem supports DAX,
> 
> That looks wrong.

It may be...

>
> If you require xfs_break_lease_layouts() outside
> of pnfs context, then move the function in the XFS code base to a
> file that is built in. It's only external dependency is on the
> break_layout() function, and XFS already has other unconditional
> direct calls to break_layout()...

I'll check.  This patch was part of the original series and I must admit I
don't remember why I did it this way...

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
