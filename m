Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F552754F1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 23 Sep 2020 11:57:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6BBB315098337;
	Wed, 23 Sep 2020 02:57:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A334415093C17
	for <linux-nvdimm@lists.01.org>; Wed, 23 Sep 2020 02:57:41 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 4DCB9AFFB;
	Wed, 23 Sep 2020 09:58:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 968EF1E12E3; Wed, 23 Sep 2020 11:57:39 +0200 (CEST)
Date: Wed, 23 Sep 2020 11:57:39 +0200
From: Jan Kara <jack@suse.cz>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: NVFS XFS metadata (was: [PATCH] pmem: export the symbols
 __copy_user_flushcache and __copy_from_user_flushcache)
Message-ID: <20200923095739.GC6719@quack2.suse.cz>
References: <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
 <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com>
 <20200922050314.GB12096@dread.disaster.area>
 <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 27L4K7CS2XBWBCQ5UYCOEKQN3ROFY233
X-Message-ID-Hash: 27L4K7CS2XBWBCQ5UYCOEKQN3ROFY233
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Chinner <david@fromorbit.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/27L4K7CS2XBWBCQ5UYCOEKQN3ROFY233/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 22-09-20 12:46:05, Mikulas Patocka wrote:
> > mapping 2^21 blocks requires a 5 level indirect tree. Which one if going 
> > to be faster to truncate away - a single record or 2 million individual 
> > blocks?
> > 
> > IOWs, we can take afford to take an extra cacheline miss or two on a
> > tree block search, because we're accessing and managing orders of
> > magnitude fewer records in the mapping tree than an indirect block
> > tree.
> > 
> > PMEM doesn't change this: extents are more time and space efficient
> > at scale for mapping trees than indirect block trees regardless
> > of the storage medium in use.
> 
> PMEM doesn't have to be read linearly, so the attempts to allocate large 
> linear space are not needed. They won't harm but they won't help either.
> 
> That's why NVFS has very simple block allocation alrogithm - it uses a 
> per-cpu pointer and tries to allocate by a bit scan from this pointer. If 
> the group is full, it tries a random group with above-average number of 
> free blocks.

I agree with Dave here. People are interested in 2MB or 1GB contiguous
allocations for DAX so that files can be mapped at PMD or event PUD levels
thus saving a lot of CPU time on page faults and TLB.

> EXT4 uses bit scan for allocations and people haven't complained that it's 
> inefficient, so it is probably OK.

Yes, it is more or less OK but once you get to 1TB filesystem size and
larger, the number of block groups grows enough that it isn't that great
anymore. We are actually considering new allocation schemes for ext4 for
this large filesystems...

> If you think that the lack of journaling is show-stopper, I can implement 
> it. But then, I'll have something that has complexity of EXT4 and 
> performance of EXT4. So that there will no longer be any reason why to use 
> NVFS over EXT4. Without journaling, it will be faster than EXT4 and it may 
> attract some users who want good performance and who don't care about GID 
> and UID being updated atomically, etc.

I'd hope that your filesystem offers more performance benefits than just
what you can get from a lack of journalling :). ext4 can be configured to
run without a journal as well - mkfs.ext4 -O ^has_journal. And yes, it does
significantly improve performance for some workloads but you have to have
some way to recover from crashes so it's mostly used for scratch
filesystems (e.g. in build systems, Google uses this feature a lot for some
of their infrastructure as well).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
