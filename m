Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA5CDF00
	for <lists+linux-nvdimm@lfdr.de>; Mon,  7 Oct 2019 12:16:25 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C7C2110FC587A;
	Mon,  7 Oct 2019 03:19:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3B8B310FC5879
	for <linux-nvdimm@lists.01.org>; Mon,  7 Oct 2019 03:19:00 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 688B2B206;
	Mon,  7 Oct 2019 10:16:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id E6A461E4813; Fri,  4 Oct 2019 09:51:00 +0200 (CEST)
Date: Fri, 4 Oct 2019 09:51:00 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: Lease semantic proposal
Message-ID: <20191004075100.GA12412@quack2.suse.cz>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <20190923222620.GC16973@dread.disaster.area>
 <20190925234602.GB12748@iweiny-DESK2.sc.intel.com>
 <20190930084233.GO16973@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190930084233.GO16973@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: XN43SQOURE3WF2XUQQATEWUMPYEWVEDG
X-Message-ID-Hash: XN43SQOURE3WF2XUQQATEWUMPYEWVEDG
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XN43SQOURE3WF2XUQQATEWUMPYEWVEDG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon 30-09-19 18:42:33, Dave Chinner wrote:
> On Wed, Sep 25, 2019 at 04:46:03PM -0700, Ira Weiny wrote:
> > On Tue, Sep 24, 2019 at 08:26:20AM +1000, Dave Chinner wrote:
> > > Hence, AFIACT, the above definition of a F_RDLCK|F_LAYOUT lease
> > > doesn't appear to be compatible with the semantics required by
> > > existing users of layout leases.
> > 
> > I disagree.  Other than the addition of F_UNBREAK, I think this is consistent
> > with what is currently implemented.  Also, by exporting all this to user space
> > we can now write tests for it independent of the RDMA pinning.
> 
> The current usage of F_RDLCK | F_LAYOUT by the pNFS code allows
> layout changes to occur to the file while the layout lease is held.

I remember you saying that in the past conversations. But I agree with Ira
that I don't see where in the code this would be implemented. AFAICS
break_layout() called from xfs_break_leased_layouts() simply breaks all the
leases with F_LAYOUT set attached to the inode... Now I'm not any expert on
file leases but what am I missing?

> IOWs, your definition of F_RDLCK | F_LAYOUT not being allowed
> to change the is in direct contradition to existing users.
> 
> I've said this several times over the past few months now: shared
> layout leases must allow layout modifications to be made. Only
> allowing an exclusive layout lease to modify the layout rules out
> many potential use cases for direct data placement and p2p DMA
> applications, not to mention conflicts with the existing pNFS usage.
> Layout leases need to support more than just RDMA, and tailoring the
> API to exactly the immediate needs of RDMA is just going to make it
> useless for anything else.

I agree we should not tailor the layout lease definition to just RDMA
usecase. But let's talk about the semantics once our confusion about how
pNFS currently uses layout leases is clear out.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
