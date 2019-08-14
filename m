Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C807C8E037
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Aug 2019 23:57:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F03FB20216B77;
	Wed, 14 Aug 2019 14:59:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.246;
 helo=mail104.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au
 [211.29.132.246])
 by ml01.01.org (Postfix) with ESMTP id C516A20215F7A
 for <linux-nvdimm@lists.01.org>; Wed, 14 Aug 2019 14:59:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au
 [49.195.190.67])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 800D843DB39;
 Thu, 15 Aug 2019 07:57:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hy1Fu-0006Ca-2B; Thu, 15 Aug 2019 07:56:30 +1000
Date: Thu, 15 Aug 2019 07:56:30 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH v2 02/19] fs/locks: Add Exclusive flag to user Layout
 lease
Message-ID: <20190814215630.GQ6129@dread.disaster.area>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-3-ira.weiny@intel.com>
 <fde2959db776616008fc5d31df700f5d7d899433.camel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fde2959db776616008fc5d31df700f5d7d899433.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
 a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
 a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=qa3ElbQomqnm_qv8Y-cA:9
 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
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
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 14, 2019 at 10:15:06AM -0400, Jeff Layton wrote:
> On Fri, 2019-08-09 at 15:58 -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Add an exclusive lease flag which indicates that the layout mechanism
> > can not be broken.
> > 
> > Exclusive layout leases allow the file system to know that pages may be
> > GUP pined and that attempts to change the layout, ie truncate, should be
> > failed.
> > 
> > A process which attempts to break it's own exclusive lease gets an
> > EDEADLOCK return to help determine that this is likely a programming bug
> > vs someone else holding a resource.
.....
> > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> > index baddd54f3031..88b175ceccbc 100644
> > --- a/include/uapi/asm-generic/fcntl.h
> > +++ b/include/uapi/asm-generic/fcntl.h
> > @@ -176,6 +176,8 @@ struct f_owner_ex {
> >  
> >  #define F_LAYOUT	16      /* layout lease to allow longterm pins such as
> >  				   RDMA */
> > +#define F_EXCLUSIVE	32      /* layout lease is exclusive */
> > +				/* FIXME or shoudl this be F_EXLCK??? */
> >  
> >  /* operations for bsd flock(), also used by the kernel implementation */
> >  #define LOCK_SH		1	/* shared lock */
> 
> This interface just seems weird to me. The existing F_*LCK values aren't
> really set up to be flags, but are enumerated values (even if there are
> some gaps on some arches). For instance, on parisc and sparc:

I don't think we need to worry about this - the F_WRLCK version of
the layout lease should have these exclusive access semantics (i.e
other ops fail rather than block waiting for lease recall) and hence
the API shouldn't need a new flag to specify them.

i.e. the primary difference between F_RDLCK and F_WRLCK layout
leases is that the F_RDLCK is a shared, co-operative lease model
where only delays in operations will be seen, while F_WRLCK is a
"guarantee exclusive access and I don't care what it breaks"
model... :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
