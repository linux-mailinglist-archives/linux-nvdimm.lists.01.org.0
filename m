Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD3C1D48
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Sep 2019 10:42:48 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D773810113623;
	Mon, 30 Sep 2019 01:44:23 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.249; helo=mail105.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
	by ml01.01.org (Postfix) with ESMTP id 333C010113622
	for <linux-nvdimm@lists.01.org>; Mon, 30 Sep 2019 01:44:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
	by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 1ED87362787;
	Mon, 30 Sep 2019 18:42:34 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
	(envelope-from <david@fromorbit.com>)
	id 1iErGL-0007Hh-Iu; Mon, 30 Sep 2019 18:42:33 +1000
Date: Mon, 30 Sep 2019 18:42:33 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: Lease semantic proposal
Message-ID: <20190930084233.GO16973@dread.disaster.area>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <20190923222620.GC16973@dread.disaster.area>
 <20190925234602.GB12748@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190925234602.GB12748@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
	a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
	a=7-415B0cAAAA:8 a=UEOKGneJplBUkCUAY6MA:9 a=CjuIK1q_8ugA:10
	a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: ZMZFJZNLL7GAFHKDQ3LZS2LKVO7GTYHH
X-Message-ID-Hash: ZMZFJZNLL7GAFHKDQ3LZS2LKVO7GTYHH
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 25, 2019 at 04:46:03PM -0700, Ira Weiny wrote:
> On Tue, Sep 24, 2019 at 08:26:20AM +1000, Dave Chinner wrote:
> > Hence, AFIACT, the above definition of a F_RDLCK|F_LAYOUT lease
> > doesn't appear to be compatible with the semantics required by
> > existing users of layout leases.
> 
> I disagree.  Other than the addition of F_UNBREAK, I think this is consistent
> with what is currently implemented.  Also, by exporting all this to user space
> we can now write tests for it independent of the RDMA pinning.

The current usage of F_RDLCK | F_LAYOUT by the pNFS code allows
layout changes to occur to the file while the layout lease is held.
IOWs, your definition of F_RDLCK | F_LAYOUT not being allowed
to change the is in direct contradition to existing users.

I've said this several times over the past few months now: shared
layout leases must allow layout modifications to be made. Only
allowing an exclusive layout lease to modify the layout rules out
many potential use cases for direct data placement and p2p DMA
applications, not to mention conflicts with the existing pNFS usage.
Layout leases need to support more than just RDMA, and tailoring the
API to exactly the immediate needs of RDMA is just going to make it
useless for anything else.

I'm getting frustrated now because we still seem to be going around
in circles and getting nowhere.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
