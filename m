Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4EC431E2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 01:29:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E0EB121295B0A;
	Wed, 12 Jun 2019 16:29:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 18D2F21290DF2
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 16:29:04 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jun 2019 16:29:04 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2019 16:29:03 -0700
Date: Wed, 12 Jun 2019 16:30:24 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190612233024.GD14336@iweiny-DESK2.sc.intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190612123751.GD32656@bombadil.infradead.org>
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-fsdevel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> On Sat, Jun 08, 2019 at 10:10:36AM +1000, Dave Chinner wrote:
> > On Fri, Jun 07, 2019 at 11:25:35AM -0700, Ira Weiny wrote:
> > > Are you suggesting that we have something like this from user space?
> > > 
> > > 	fcntl(fd, F_SETLEASE, F_LAYOUT | F_UNBREAKABLE);
> > 
> > Rather than "unbreakable", perhaps a clearer description of the
> > policy it entails is "exclusive"?
> > 
> > i.e. what we are talking about here is an exclusive lease that
> > prevents other processes from changing the layout. i.e. the
> > mechanism used to guarantee a lease is exclusive is that the layout
> > becomes "unbreakable" at the filesystem level, but the policy we are
> > actually presenting to uses is "exclusive access"...
> 
> That's rather different from the normal meaning of 'exclusive' in the
> context of locks, which is "only one user can have access to this at
> a time".  As I understand it, this is rather more like a 'shared' or
> 'read' lock.  The filesystem would be the one which wants an exclusive
> lock, so it can modify the mapping of logical to physical blocks.
> 
> The complication being that by default the filesystem has an exclusive
> lock on the mapping, and what we're trying to add is the ability for
> readers to ask the filesystem to give up its exclusive lock.

This is an interesting view...

And after some more thought, exclusive does not seem like a good name for this
because technically F_WRLCK _is_ an exclusive lease...

In addition, the user does not need to take the "exclusive" write lease to be
notified of (broken by) an unexpected truncate.  A "read" lease is broken by
truncate.  (And "write" leases really don't do anything different WRT the
interaction of the FS and the user app.  Write leases control "exclusive"
access between other file descriptors.)

Another thing to consider is that this patch set _allows_ a truncate/hole punch
to proceed _if_ the pages being affected are not actually pinned.  So the
unbreakable/exclusive nature of the lease is not absolute.

Personally I like this functionality.  I'm not quite sure I can make it work
with what Jan is suggesting.  But I like it.

Given the muddied water of "exclusive" and "write" lease I'm now feeling like
Jeff has a point WRT the conflation of F_RDLCK/F_WRLCK/F_UNLCK and this new
functionality.

Should we use his suggested F_SETLAYOUT/F_GETLAYOUT cmd type?[1]

Ira

[1] https://lkml.org/lkml/2019/6/9/117

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
