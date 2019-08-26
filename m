Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A05BF9CD6D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Aug 2019 12:41:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6753C20212C9F;
	Mon, 26 Aug 2019 03:43:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=jlayton@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 252262020D33A
 for <linux-nvdimm@lists.01.org>; Mon, 26 Aug 2019 03:43:29 -0700 (PDT)
Received: from tleilax.poochiereds.net
 (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1E32920828;
 Mon, 26 Aug 2019 10:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566816070;
 bh=8ziD+meEXqXL5pLNd7FdOcpozYaNgK5kwHaeo4uhx28=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=It43Y4jhI4WRMT7EOX/lr7UQrAHGcp7abrKi/dW/O0Kd9egEDPpQrb9qKy1oWb9pe
 lnOftVy2OCBwYNxuaPQUMNRvYTlPGOmE5p+KJsXKHIySHdTnGKve5YDOmGidGBo/29
 cnTh0m+X3A/MuYbOjoz90Mp0uG6r73lbyIxhL/QI=
Message-ID: <e6f4f619967f4551adb5003d0364770fde2b8110.camel@kernel.org>
Subject: Re: [RFC PATCH v2 02/19] fs/locks: Add Exclusive flag to user
 Layout lease
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Date: Mon, 26 Aug 2019 06:41:07 -0400
In-Reply-To: <20190814215630.GQ6129@dread.disaster.area>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-3-ira.weiny@intel.com>
 <fde2959db776616008fc5d31df700f5d7d899433.camel@kernel.org>
 <20190814215630.GQ6129@dread.disaster.area>
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
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 2019-08-15 at 07:56 +1000, Dave Chinner wrote:
> On Wed, Aug 14, 2019 at 10:15:06AM -0400, Jeff Layton wrote:
> > On Fri, 2019-08-09 at 15:58 -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Add an exclusive lease flag which indicates that the layout mechanism
> > > can not be broken.
> > > 
> > > Exclusive layout leases allow the file system to know that pages may be
> > > GUP pined and that attempts to change the layout, ie truncate, should be
> > > failed.
> > > 
> > > A process which attempts to break it's own exclusive lease gets an
> > > EDEADLOCK return to help determine that this is likely a programming bug
> > > vs someone else holding a resource.
> .....
> > > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> > > index baddd54f3031..88b175ceccbc 100644
> > > --- a/include/uapi/asm-generic/fcntl.h
> > > +++ b/include/uapi/asm-generic/fcntl.h
> > > @@ -176,6 +176,8 @@ struct f_owner_ex {
> > >  
> > >  #define F_LAYOUT	16      /* layout lease to allow longterm pins such as
> > >  				   RDMA */
> > > +#define F_EXCLUSIVE	32      /* layout lease is exclusive */
> > > +				/* FIXME or shoudl this be F_EXLCK??? */
> > >  
> > >  /* operations for bsd flock(), also used by the kernel implementation */
> > >  #define LOCK_SH		1	/* shared lock */
> > 
> > This interface just seems weird to me. The existing F_*LCK values aren't
> > really set up to be flags, but are enumerated values (even if there are
> > some gaps on some arches). For instance, on parisc and sparc:
> 
> I don't think we need to worry about this - the F_WRLCK version of
> the layout lease should have these exclusive access semantics (i.e
> other ops fail rather than block waiting for lease recall) and hence
> the API shouldn't need a new flag to specify them.
> 
> i.e. the primary difference between F_RDLCK and F_WRLCK layout
> leases is that the F_RDLCK is a shared, co-operative lease model
> where only delays in operations will be seen, while F_WRLCK is a
> "guarantee exclusive access and I don't care what it breaks"
> model... :)
> 

Not exactly...

F_WRLCK and F_RDLCK leases can both be broken, and will eventually time
out if there is conflicting access. The F_EXCLUSIVE flag on the other
hand is there to prevent any sort of lease break from 

I'm guessing what Ira really wants with the F_EXCLUSIVE flag is
something akin to what happens when we set fl_break_time to 0 in the
nfsd code. nfsd never wants the locks code to time out a lease of any
sort, since it handles that timeout itself.

If you're going to add this functionality, it'd be good to also convert
knfsd to use it as well, so we don't end up with multiple ways to deal
with that situation.
-- 
Jeff Layton <jlayton@kernel.org>

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
