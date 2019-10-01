Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5EEC423E
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Oct 2019 23:02:02 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0810410FC7205;
	Tue,  1 Oct 2019 14:03:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A25A10FC7204
	for <linux-nvdimm@lists.01.org>; Tue,  1 Oct 2019 14:03:25 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 14:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,572,1559545200";
   d="scan'208";a="343108957"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 01 Oct 2019 14:01:57 -0700
Date: Tue, 1 Oct 2019 14:01:57 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: Lease semantic proposal
Message-ID: <20191001210156.GB5500@iweiny-DESK2.sc.intel.com>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <20190923222620.GC16973@dread.disaster.area>
 <20190925234602.GB12748@iweiny-DESK2.sc.intel.com>
 <20190930084233.GO16973@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190930084233.GO16973@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: C5SPOSKPFD77OE4DEGCP4B5ULZG4HVEX
X-Message-ID-Hash: C5SPOSKPFD77OE4DEGCP4B5ULZG4HVEX
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C5SPOSKPFD77OE4DEGCP4B5ULZG4HVEX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 30, 2019 at 06:42:33PM +1000, Dave Chinner wrote:
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

This was not my understanding.

> IOWs, your definition of F_RDLCK | F_LAYOUT not being allowed
> to change the is in direct contradition to existing users.
> 
> I've said this several times over the past few months now: shared
> layout leases must allow layout modifications to be made.

I don't understand what the point of having a layout lease is then?

>
> Only
> allowing an exclusive layout lease to modify the layout rules out
> many potential use cases for direct data placement and p2p DMA
> applications,

How?  I think that having a typical design pattern of multiple readers
and only a single writer would actually make all these use cases easier.

> not to mention conflicts with the existing pNFS usage.

I apologize for not understanding this.  My reading of the code is that layout
changes require the read layout to be broken prior to proceeding.

The break layout code does this by creating a F_WRLCK of type FL_LAYOUT which
conflicts with the F_RDLCK of type FL_LAYOUT...

int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
{
...
        struct file_lock *new_fl, *fl, *tmp;
...

        new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK, 0);
        if (IS_ERR(new_fl))
                return PTR_ERR(new_fl);
        new_fl->fl_flags = type;
...
        list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list) {
                if (!leases_conflict(fl, new_fl))
                        continue;
...
}

type == FL_LAYOUT from the call here.

static inline int break_layout(struct inode *inode, bool wait)
{
        smp_mb();
        if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
                return __break_lease(inode,
                                wait ? O_WRONLY : O_WRONLY | O_NONBLOCK,
                                FL_LAYOUT);
        return 0;
}       

Also, I don't see any code which limits the number of read layout holders which
can be present and all of them will be revoked by the above code.

What am I missing?

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
