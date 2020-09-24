Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C6B2774AE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Sep 2020 17:00:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 45089149D9093;
	Thu, 24 Sep 2020 08:00:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4A4C149D9093
	for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600959630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZooZd+2Abb0NioOnlAqnGdn71WL8pkXeAG+ycQqMKg=;
	b=T6OTWQhHoTLWPLIqDyyoJpMVBlK1cfPbFvGdzSoW1mzB/Bsr9PyFStcVLqztYuo80CDI0j
	cfSNARpB3TOmOagvvQ8G6KMCr2CsRMSVU0xe7KF/86rzP1J5WALHW+7k86Fl+pZrlfGBjr
	pEhyZiGK2kBVCUZFcdXcmJWQH1ChE6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-lTQRB-_VPU2rFBtOwp75YA-1; Thu, 24 Sep 2020 11:00:25 -0400
X-MC-Unique: lTQRB-_VPU2rFBtOwp75YA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A61C1017DD1;
	Thu, 24 Sep 2020 15:00:22 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 37D877368C;
	Thu, 24 Sep 2020 15:00:22 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08OF0LbJ018758;
	Thu, 24 Sep 2020 11:00:21 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08OF0KDN018754;
	Thu, 24 Sep 2020 11:00:21 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Thu, 24 Sep 2020 11:00:20 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: NVFS XFS metadata (was: [PATCH] pmem: export the symbols
 __copy_user_flushcache and __copy_from_user_flushcache)
In-Reply-To: <20200922172553.GL32101@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2009240853200.3485@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com> <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com> <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com> <20200922050314.GB12096@dread.disaster.area> <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com> <20200922172553.GL32101@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: QULKWWZVVSUXMLHAW3WJQUX6YTFYCNBH
X-Message-ID-Hash: QULKWWZVVSUXMLHAW3WJQUX6YTFYCNBH
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Chinner <david@fromorbit.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QULKWWZVVSUXMLHAW3WJQUX6YTFYCNBH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 22 Sep 2020, Matthew Wilcox wrote:

> > > The NVFS indirect block tree has a fan-out of 16,
> > 
> > No. The top level in the inode contains 16 blocks (11 direct and 5 
> > indirect). And each indirect block can have 512 pointers (4096/8). You can 
> > format the device with larger block size and this increases the fanout 
> > (the NVFS block size must be greater or equal than the system page size).
> > 
> > 2 levels can map 1GiB (4096*512^2), 3 levels can map 512 GiB, 4 levels can 
> > map 256 TiB and 5 levels can map 128 PiB.
> 
> But compare to an unfragmented file ... you can map the entire thing with
> a single entry.  Even if you have to use a leaf node, you can get four
> extents in a single cacheline (and that's a fairly naive leaf node layout;
> I don't know exactly what XFS uses)

But the benchmarks show that it is comparable to extent-based filesystems.

> > > Rename is another operation that has specific "operation has atomic
> > > behaviour" expectations. I haven't looked at how you've
> > > implementated that yet, but I suspect it also is extremely difficult
> > > to implement in an atomic manner using direct pmem updates to the
> > > directory structures.
> > 
> > There is a small window when renamed inode is neither in source nor in 
> > target directory. Fsck will reclaim such inode and add it to lost+found - 
> > just like on EXT2.
> 
> ... ouch.  If you have to choose, it'd be better to link it to the second
> directory then unlink it from the first one.  Then your fsck can detect
> it has the wrong count and fix up the count (ie link it into both
> directories rather than neither).

I admit that this is lame and I'll fix it. Rename is not so 
performance-critical, so I can add a small journal for this.

> > If you think that the lack of journaling is show-stopper, I can implement 
> > it. But then, I'll have something that has complexity of EXT4 and 
> > performance of EXT4. So that there will no longer be any reason why to use 
> > NVFS over EXT4. Without journaling, it will be faster than EXT4 and it may 
> > attract some users who want good performance and who don't care about GID 
> > and UID being updated atomically, etc.
> 
> Well, what's your intent with nvfs?  Do you already have customers in mind
> who want to use this in production, or is this somewhere to play with and
> develop concepts that might make it into one of the longer-established
> filesystems?

I develop it just because I thought it may be interesting. So far, it 
doesn't have any serious users (the physical format is still changing). I 
hope that it could be useable as a general purpose root filesystem when 
Optane DIMMs become common.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
