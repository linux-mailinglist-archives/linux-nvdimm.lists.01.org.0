Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6FC433DD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 09:50:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D99A121959CB2;
	Thu, 13 Jun 2019 00:50:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4296821296059
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 00:44:02 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 920EBAB91;
 Thu, 13 Jun 2019 07:44:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id B5C631E4328; Thu, 13 Jun 2019 09:43:59 +0200 (CEST)
Date: Thu, 13 Jun 2019 09:43:59 +0200
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613074359.GB26505@quack2.suse.cz>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
 <CAPcyv4jSyTjC98UsWb3-FnZekV0oyboiSe9n1NYDC2TSKAqiqw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jSyTjC98UsWb3-FnZekV0oyboiSe9n1NYDC2TSKAqiqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Dave Chinner <david@fromorbit.com>, Jeff Layton <jlayton@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-xfs <linux-xfs@vger.kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed 12-06-19 11:49:52, Dan Williams wrote:
> On Wed, Jun 12, 2019 at 3:29 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 07-06-19 07:52:13, Ira Weiny wrote:
> > > On Fri, Jun 07, 2019 at 09:17:29AM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Jun 07, 2019 at 12:36:36PM +0200, Jan Kara wrote:
> > > >
> > > > > Because the pins would be invisible to sysadmin from that point on.
> > > >
> > > > It is not invisible, it just shows up in a rdma specific kernel
> > > > interface. You have to use rdma netlink to see the kernel object
> > > > holding this pin.
> > > >
> > > > If this visibility is the main sticking point I suggest just enhancing
> > > > the existing MR reporting to include the file info for current GUP
> > > > pins and teaching lsof to collect information from there as well so it
> > > > is easy to use.
> > > >
> > > > If the ownership of the lease transfers to the MR, and we report that
> > > > ownership to userspace in a way lsof can find, then I think all the
> > > > concerns that have been raised are met, right?
> > >
> > > I was contemplating some new lsof feature yesterday.  But what I don't
> > > think we want is sysadmins to have multiple tools for multiple
> > > subsystems.  Or even have to teach lsof something new for every potential
> > > new subsystem user of GUP pins.
> >
> > Agreed.
> >
> > > I was thinking more along the lines of reporting files which have GUP
> > > pins on them directly somewhere (dare I say procfs?) and teaching lsof to
> > > report that information.  That would cover any subsystem which does a
> > > longterm pin.
> >
> > So lsof already parses /proc/<pid>/maps to learn about files held open by
> > memory mappings. It could parse some other file as well I guess. The good
> > thing about that would be that then "longterm pin" structure would just hold
> > struct file reference. That would avoid any needs of special behavior on
> > file close (the file reference in the "longterm pin" structure would make
> > sure struct file and thus the lease stays around, we'd just need to make
> > explicit lease unlock block until the "longterm pin" structure is freed).
> > The bad thing is that it requires us to come up with a sane new proc
> > interface for reporting "longterm pins" and associated struct file. Also we
> > need to define what this interface shows if the pinned pages are in DRAM
> > (either page cache or anon) and not on NVDIMM.
> 
> The anon vs shared detection case is important because a longterm pin
> might be blocking a memory-hot-unplug operation if it is pinning
> ZONE_MOVABLE memory, but I don't think we want DRAM vs NVDIMM to be an
> explicit concern of the interface. For the anon / cached case I expect
> it might be useful to put that communication under the memory-blocks
> sysfs interface. I.e. a list of pids that are pinning that
> memory-block from being hot-unplugged.

Yes, I was thinking of memory hotplug as well. But I don't think the
distinction is really shared vs anon - a pinned page cache page can be
blocking your memory unplug / migration the same way as a pinned anon page.
So the information for a pin we need to convey is the "location of
resources" being pinned - that is pfn (both for DRAM and NVDIMM) - but then
also additional mapping information (which is filename for DAX page, not
sure about DRAM). Also a separate question is how to expose this
information so that it is efficiently usable by userspace. For lsof, a file
in /proc/<pid>/xxx with information would be probably the easiest to use
plus all the issues with file access permissions and visibility among
different user namespaces is solved out of the box. And I believe it would
be reasonably usable for memory hotplug usecase as well. A file in sysfs
would be OK for memory hotplug I guess, but not really usable for lsof and
so I'm not sure we really need it when we are going to have one in procfs.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
