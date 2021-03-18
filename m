Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B20A33FE59
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Mar 2021 05:57:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2902100EB330;
	Wed, 17 Mar 2021 21:57:53 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.42; helo=mail106.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail106.syd.optusnet.com.au (mail106.syd.optusnet.com.au [211.29.132.42])
	by ml01.01.org (Postfix) with ESMTP id 857B2100EB855
	for <linux-nvdimm@lists.01.org>; Wed, 17 Mar 2021 21:57:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
	by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 8F98878B349;
	Thu, 18 Mar 2021 15:57:46 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1lMkjB-003oZC-HC; Thu, 18 Mar 2021 15:57:45 +1100
Date: Thu, 18 Mar 2021 15:57:45 +1100
From: Dave Chinner <david@fromorbit.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/3] mm, dax, pmem: Introduce dev_pagemap_failure()
Message-ID: <20210318045745.GC349301@dread.disaster.area>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
	a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
	a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=7-415B0cAAAA:8
	a=WmxcBHIv_b8-_gLMp1kA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: AMVNHYNVSTUWND2TGQ32AXHGMJCHW7TJ
X-Message-ID-Hash: AMVNHYNVSTUWND2TGQ32AXHGMJCHW7TJ
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>, "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AMVNHYNVSTUWND2TGQ32AXHGMJCHW7TJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 17, 2021 at 09:08:23PM -0700, Dan Williams wrote:
> Jason wondered why the get_user_pages_fast() path takes references on a
> @pgmap object. The rationale was to protect against accessing a 'struct
> page' that might be in the process of being removed by the driver, but
> he rightly points out that should be solved the same way all gup-fast
> synchronization is solved which is invalidate the mapping and let the
> gup slow path do @pgmap synchronization [1].
> 
> To achieve that it means that new user mappings need to stop being
> created and all existing user mappings need to be invalidated.
> 
> For device-dax this is already the case as kill_dax() prevents future
> faults from installing a pte, and the single device-dax inode
> address_space can be trivially unmapped.
> 
> The situation is different for filesystem-dax where device pages could
> be mapped by any number of inode address_space instances. An initial
> thought was to treat the device removal event like a drop_pagecache_sb()
> event that walks superblocks and unmaps all inodes. However, Dave points
> out that it is not just the filesystem user-mappings that need to react
> to global DAX page-unmap events, it is also filesystem metadata
> (proposed DAX metadata access), and other drivers (upstream
> DM-writecache) that need to react to this event [2].
> 
> The only kernel facility that is meant to globally broadcast the loss of
> a page (via corruption or surprise remove) is memory_failure(). The
> downside of memory_failure() is that it is a pfn-at-a-time interface.
> However, the events that would trigger the need to call memory_failure()
> over a full PMEM device should be rare.

This is a highly suboptimal design. Filesystems only need a single
callout to trigger a shutdown that unmaps every active mapping in
the filesystem - we do not need a page-by-page error notification
which results in 250 million hwposion callouts per TB of pmem to do
this.

Indeed, the moment we get the first hwpoison from this patch, we'll
map it to the primary XFS superblock and we'd almost certainly
consider losing the storage behind that block to be a shut down
trigger. During the shutdown, the filesystem should unmap all the
active mappings (we already need to add this to shutdown on DAX
regardless of this device remove issue) and so we really don't need
a page-by-page notification of badness.

AFAICT, it's going to take minutes, maybe hours for do the page-by-page
iteration to hwposion every page. It's going to take a few seconds
for the filesystem shutdown to run a device wide invalidation.

SO, yeah, I think this should simply be a single ranged call to the
filesystem like:

	->memory_failure(dev, 0, -1ULL)

to tell the filesystem that the entire backing device has gone away,
and leave the filesystem to handle failure entirely at the
filesystem level.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
