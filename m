Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C8EA833B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 14:52:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 89FA021962301;
	Wed,  4 Sep 2019 05:53:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=jlayton@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 44F2020212CA8
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 05:53:56 -0700 (PDT)
Received: from tleilax.poochiereds.net
 (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8B30F21883;
 Wed,  4 Sep 2019 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567601569;
 bh=XG+z6BHhOmv9W2OyuDcqw63mHyObz78oeswsmfEdF1U=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=QOvybiJzp85IlBNCfwgLsBnLV9DR4UQ+d3iO+92iuV9rSa0S6OBqWysT1ufEq9jPg
 Uc8pw3mW3WhdRGHShvIhIShiLbWPqR1oIpH89892Mb1phi9Lqta58kkyAJU+pCa6lo
 XwT3v0mpqc9uUS8Hbn+5AeFK7k62BlqLx2/zGjmo=
Message-ID: <2227b44d9e36f9bd129c73ee77c03b35d023236a.camel@kernel.org>
Subject: Re: [RFC PATCH v2 02/19] fs/locks: Add Exclusive flag to user
 Layout lease
From: Jeff Layton <jlayton@kernel.org>
To: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 04 Sep 2019 08:52:47 -0400
In-Reply-To: <20190829233408.GD18249@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-3-ira.weiny@intel.com>
 <fde2959db776616008fc5d31df700f5d7d899433.camel@kernel.org>
 <20190814215630.GQ6129@dread.disaster.area>
 <e6f4f619967f4551adb5003d0364770fde2b8110.camel@kernel.org>
 <20190829233408.GD18249@iweiny-DESK2.sc.intel.com>
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
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
 John Hubbard <jhubbard@nvidia.com>, Dave Chinner <david@fromorbit.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 2019-08-29 at 16:34 -0700, Ira Weiny wrote:
> Missed this.  sorry.
> 
> On Mon, Aug 26, 2019 at 06:41:07AM -0400, Jeff Layton wrote:
> > On Thu, 2019-08-15 at 07:56 +1000, Dave Chinner wrote:
> > > On Wed, Aug 14, 2019 at 10:15:06AM -0400, Jeff Layton wrote:
> > > > On Fri, 2019-08-09 at 15:58 -0700, ira.weiny@intel.com wrote:
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > 
> > > > > Add an exclusive lease flag which indicates that the layout mechanism
> > > > > can not be broken.
> > > > > 
> > > > > Exclusive layout leases allow the file system to know that pages may be
> > > > > GUP pined and that attempts to change the layout, ie truncate, should be
> > > > > failed.
> > > > > 
> > > > > A process which attempts to break it's own exclusive lease gets an
> > > > > EDEADLOCK return to help determine that this is likely a programming bug
> > > > > vs someone else holding a resource.
> > > .....
> > > > > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> > > > > index baddd54f3031..88b175ceccbc 100644
> > > > > --- a/include/uapi/asm-generic/fcntl.h
> > > > > +++ b/include/uapi/asm-generic/fcntl.h
> > > > > @@ -176,6 +176,8 @@ struct f_owner_ex {
> > > > >  
> > > > >  #define F_LAYOUT	16      /* layout lease to allow longterm pins such as
> > > > >  				   RDMA */
> > > > > +#define F_EXCLUSIVE	32      /* layout lease is exclusive */
> > > > > +				/* FIXME or shoudl this be F_EXLCK??? */
> > > > >  
> > > > >  /* operations for bsd flock(), also used by the kernel implementation */
> > > > >  #define LOCK_SH		1	/* shared lock */
> > > > 
> > > > This interface just seems weird to me. The existing F_*LCK values aren't
> > > > really set up to be flags, but are enumerated values (even if there are
> > > > some gaps on some arches). For instance, on parisc and sparc:
> > > 
> > > I don't think we need to worry about this - the F_WRLCK version of
> > > the layout lease should have these exclusive access semantics (i.e
> > > other ops fail rather than block waiting for lease recall) and hence
> > > the API shouldn't need a new flag to specify them.
> > > 
> > > i.e. the primary difference between F_RDLCK and F_WRLCK layout
> > > leases is that the F_RDLCK is a shared, co-operative lease model
> > > where only delays in operations will be seen, while F_WRLCK is a
> > > "guarantee exclusive access and I don't care what it breaks"
> > > model... :)
> > > 
> > 
> > Not exactly...
> > 
> > F_WRLCK and F_RDLCK leases can both be broken, and will eventually time
> > out if there is conflicting access. The F_EXCLUSIVE flag on the other
> > hand is there to prevent any sort of lease break from 
> 
> Right EXCLUSIVE will not break for any reason.  It will fail truncate and hole
> punch as we discussed back in June.  This is for the use case where the user
> has handed this file/pages off to some hardware for which removing the lease
> would be impossible.  _And_ we don't anticipate any valid use case that someone
> will need to truncate short of killing the process to free up file system
> space.
> 
> > I'm guessing what Ira really wants with the F_EXCLUSIVE flag is
> > something akin to what happens when we set fl_break_time to 0 in the
> > nfsd code. nfsd never wants the locks code to time out a lease of any
> > sort, since it handles that timeout itself.
> > 
> > If you're going to add this functionality, it'd be good to also convert
> > knfsd to use it as well, so we don't end up with multiple ways to deal
> > with that situation.
> 
> Could you point me at the source for knfsd?  I looked in 
> 
> git://git.linux-nfs.org/projects/steved/nfs-utils.git
> 
> but I don't see anywhere leases are used in that source?
> 

Ahh sorry that wasn't clear. It's the fs/nfsd directory in the Linux
kernel sources. See nfsd4_layout_lm_break and nfsd_break_deleg_cb in
particular.

-- 
Jeff Layton <jlayton@kernel.org>

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
