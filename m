Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC0F3A2CA
	for <lists+linux-nvdimm@lfdr.de>; Sun,  9 Jun 2019 03:28:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF82821295B2E;
	Sat,  8 Jun 2019 18:28:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 69CE421295B29
 for <linux-nvdimm@lists.01.org>; Sat,  8 Jun 2019 18:28:17 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jun 2019 18:28:17 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2019 18:28:16 -0700
Date: Sat, 8 Jun 2019 18:29:32 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190609012931.GA19825@iweiny-DESK2.sc.intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190608001036.GF14308@dread.disaster.area>
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
 John Hubbard <jhubbard@nvidia.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sat, Jun 08, 2019 at 10:10:36AM +1000, Dave Chinner wrote:
> On Fri, Jun 07, 2019 at 11:25:35AM -0700, Ira Weiny wrote:
> > On Fri, Jun 07, 2019 at 01:04:26PM +0200, Jan Kara wrote:
> > > On Thu 06-06-19 15:03:30, Ira Weiny wrote:
> > > > On Thu, Jun 06, 2019 at 12:42:03PM +0200, Jan Kara wrote:
> > > > > On Wed 05-06-19 18:45:33, ira.weiny@intel.com wrote:
> > > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > 
> > > > > So I'd like to actually mandate that you *must* hold the file lease until
> > > > > you unpin all pages in the given range (not just that you have an option to
> > > > > hold a lease). And I believe the kernel should actually enforce this. That
> > > > > way we maintain a sane state that if someone uses a physical location of
> > > > > logical file offset on disk, he has a layout lease. Also once this is done,
> > > > > sysadmin has a reasonably easy way to discover run-away RDMA application
> > > > > and kill it if he wishes so.
> > > > 
> > > > Fair enough.
> > > > 
> > > > I was kind of heading that direction but had not thought this far forward.  I
> > > > was exploring how to have a lease remain on the file even after a "lease
> > > > break".  But that is incompatible with the current semantics of a "layout"
> > > > lease (as currently defined in the kernel).  [In the end I wanted to get an RFC
> > > > out to see what people think of this idea so I did not look at keeping the
> > > > lease.]
> > > > 
> > > > Also hitch is that currently a lease is forcefully broken after
> > > > <sysfs>/lease-break-time.  To do what you suggest I think we would need a new
> > > > lease type with the semantics you describe.
> > > 
> > > I'd do what Dave suggested - add flag to mark lease as unbreakable by
> > > truncate and teach file locking core to handle that. There actually is
> > > support for locks that are not broken after given timeout so there
> > > shouldn't be too many changes need.
> > >  
> > > > Previously I had thought this would be a good idea (for other reasons).  But
> > > > what does everyone think about using a "longterm lease" similar to [1] which
> > > > has the semantics you proppose?  In [1] I was not sure "longterm" was a good
> > > > name but with your proposal I think it makes more sense.
> > > 
> > > As I wrote elsewhere in this thread I think FL_LAYOUT name still makes
> > > sense and I'd add there FL_UNBREAKABLE to mark unusal behavior with
> > > truncate.
> > 
> > Ok I want to make sure I understand what you and Dave are suggesting.
> > 
> > Are you suggesting that we have something like this from user space?
> > 
> > 	fcntl(fd, F_SETLEASE, F_LAYOUT | F_UNBREAKABLE);
> 
> Rather than "unbreakable", perhaps a clearer description of the
> policy it entails is "exclusive"?
> 
> i.e. what we are talking about here is an exclusive lease that
> prevents other processes from changing the layout. i.e. the
> mechanism used to guarantee a lease is exclusive is that the layout
> becomes "unbreakable" at the filesystem level, but the policy we are
> actually presenting to uses is "exclusive access"...

That sounds good.

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
