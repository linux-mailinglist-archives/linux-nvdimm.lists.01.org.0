Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CDFC9A53
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Oct 2019 11:00:55 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A5BD010FC413D;
	Thu,  3 Oct 2019 02:02:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8D74010FC413B
	for <linux-nvdimm@lists.01.org>; Thu,  3 Oct 2019 02:02:05 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 60B8DB144;
	Thu,  3 Oct 2019 09:00:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 534081E4810; Thu,  3 Oct 2019 11:01:10 +0200 (CEST)
Date: Thu, 3 Oct 2019 11:01:10 +0200
From: Jan Kara <jack@suse.cz>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: Lease semantic proposal
Message-ID: <20191003090110.GC17911@quack2.suse.cz>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <5d5a93637934867e1b3352763da8e3d9f9e6d683.camel@kernel.org>
 <20191001181659.GA5500@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191001181659.GA5500@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: PXPB55LHZXX23RVEWPTC7WKWLDZNDFTO
X-Message-ID-Hash: PXPB55LHZXX23RVEWPTC7WKWLDZNDFTO
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PXPB55LHZXX23RVEWPTC7WKWLDZNDFTO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 01-10-19 11:17:00, Ira Weiny wrote:
> On Mon, Sep 23, 2019 at 04:17:59PM -0400, Jeff Layton wrote:
> > On Mon, 2019-09-23 at 12:08 -0700, Ira Weiny wrote:
> > 
> > Will userland require any special privileges in order to set an
> > F_UNBREAK lease? This seems like something that could be used for DoS. I
> > assume that these will never time out.
> 
> Dan and I discussed this some more and yes I think the uid of the process needs
> to be the owner of the file.  I think that is a reasonable mechanism.

Honestly, I'm not convinced anything more than open-for-write should be
required. Sure unbreakable lease may result in failing truncate and other
ops but as we discussed at LFS/MM, this is not hugely different from
executing a file resulting in ETXTBUSY for any truncate attempt (even from
root). So sufficiently priviledged user has to be able to easily find which
process(es) owns the lease so that he can kill it / take other
administrative action to release the lease. But that's about it.
 
> > How will we deal with the case where something is is squatting on an
> > F_UNBREAK lease and isn't letting it go?
> 
> That is a good question.  I had not considered someone taking the UNBREAK
> without pinning the file.

IMHO the same answer as above - sufficiently priviledged user should be
able to easily find the process holding the lease and kill it. Given the
lease owner has to have write access to the file, he better should be from
the same "security domain"...

> > Leases are technically "owned" by the file description -- we can't
> > necessarily trace it back to a single task in a threaded program. The
> > kernel task that set the lease may have exited by the time we go
> > looking.
> > 
> > Will we be content trying to determine this using /proc/locks+lsof, etc,
> > or will we need something better?
> 
> I think using /proc/locks is our best bet.  Similar to my intention to report
> files being pinned.[1]
> 
> In fact should we consider files with F_UNBREAK leases "pinned" and just report
> them there?

As Jeff wrote later, /proc/locks is not enough. You need PID(s) which have
access to the lease and hold it alive. Your /proc/<pid>/ files you had in your
patches should do that, shouldn't they? Maybe they were not tied to the
right structure... They really need to be tied to the existence of a lease.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
