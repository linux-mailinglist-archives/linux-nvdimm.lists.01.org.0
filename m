Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DFB274768
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Sep 2020 19:26:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97B3D14DF65C4;
	Tue, 22 Sep 2020 10:26:11 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E721D13C0B47F
	for <linux-nvdimm@lists.01.org>; Tue, 22 Sep 2020 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lklvbxT/+lmiuZzM9UhRSud1j9Tp1BSwOkSXZ0Mlr6g=; b=ZH2mCww+yHNuw6uGcZBhRRn+BG
	u0b+/jHQ3vtwlEZSlDKWPZMX6ke8M+Bel+7KAIhyAyV0zLuAHiJd9ymZqzI1EZMmFB1s3PazG8m1N
	68REu1pL5urV8P2rb8BIVClek7sl4Mm3EA0KJtQyIJlpODUmy/71d384NlTu1fRtW0s0q6wj1ke8n
	yqPngSNxlq4qkbizNRbxg/oY+sChBT70qzmhOL58BXMhSo5VuW/qU1qR+xPhJ5qcQXTD7IMhL6YH2
	g2QlEfazHCl4ZgSBJsrGEiql7u2YQ30QpTYlbONHPkKUQ6clgmDf7EeC/LOQtOW0LGSRwyxAQemEL
	xqBT3RvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKm37-0003m3-FO; Tue, 22 Sep 2020 17:25:53 +0000
Date: Tue, 22 Sep 2020 18:25:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: NVFS XFS metadata (was: [PATCH] pmem: export the symbols
 __copy_user_flushcache and __copy_from_user_flushcache)
Message-ID: <20200922172553.GL32101@casper.infradead.org>
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
Message-ID-Hash: ADDK4QB2NKBN4FWQVYFJ37IOVHPIOSQC
X-Message-ID-Hash: ADDK4QB2NKBN4FWQVYFJ37IOVHPIOSQC
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Chinner <david@fromorbit.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ADDK4QB2NKBN4FWQVYFJ37IOVHPIOSQC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 22, 2020 at 12:46:05PM -0400, Mikulas Patocka wrote:
> I agree that the b+tree were a good choice for XFS.
> 
> In RAM-based maps, red-black trees or avl trees are used often. In 
> disk-based maps, btrees or b+trees are used. That's because in RAM, you 
> are optimizing for the number of cache lines accessed, and on the disk, 
> you are optimizing for the number of blocks accessed.

That's because software hasn't yet caught up to modern hardware.  An
in-memory btree outperforms an rbtree for several reasons:

 - rbtrees are taller; the average height of a b-tree with even just
   8 pointers per level is about half of an rbtree.
 - Not all cachelines are created equal.  The subsequent cacheline
   of this cacheline is probably already in cache.  If not, it's on its
   way and will be here shortly.  So a forward scan of this node will be
   quicker than finding another level of tree.  Our experiments have found
   a performance improvement with 256-byte B-tree nodes over an rbtree.
 - btrees are (or can be) RCU-safe.  It's very hard to make an rbtree
   RCU safe.  You can do a seqlock to get most of the benefit, but btrees
   let you allocate a new node and copy into it, while rbtrees embed the
   node in the object.

The downside, of course, is that b-trees require external allocations
while rbtrees embed the node in the object.  So you may need to do
more allocations.  But filesystems love doing additional allocations;
they make journalling so much easier.

> BTW. How does XFS "predict" the file size? - so that it allocates extent 
> of proper size without knowing how big the file will be?

XFS does delayed allocation.  The page cache absorbs the writes and then
at writeback time, XFS chooses where on storage to put it.  Some things
break this like O_SYNC and, er, DAX, but it's very effective.

> > The NVFS indirect block tree has a fan-out of 16,
> 
> No. The top level in the inode contains 16 blocks (11 direct and 5 
> indirect). And each indirect block can have 512 pointers (4096/8). You can 
> format the device with larger block size and this increases the fanout 
> (the NVFS block size must be greater or equal than the system page size).
> 
> 2 levels can map 1GiB (4096*512^2), 3 levels can map 512 GiB, 4 levels can 
> map 256 TiB and 5 levels can map 128 PiB.

But compare to an unfragmented file ... you can map the entire thing with
a single entry.  Even if you have to use a leaf node, you can get four
extents in a single cacheline (and that's a fairly naive leaf node layout;
I don't know exactly what XFS uses)

> > Rename is another operation that has specific "operation has atomic
> > behaviour" expectations. I haven't looked at how you've
> > implementated that yet, but I suspect it also is extremely difficult
> > to implement in an atomic manner using direct pmem updates to the
> > directory structures.
> 
> There is a small window when renamed inode is neither in source nor in 
> target directory. Fsck will reclaim such inode and add it to lost+found - 
> just like on EXT2.

... ouch.  If you have to choose, it'd be better to link it to the second
directory then unlink it from the first one.  Then your fsck can detect
it has the wrong count and fix up the count (ie link it into both
directories rather than neither).

> If you think that the lack of journaling is show-stopper, I can implement 
> it. But then, I'll have something that has complexity of EXT4 and 
> performance of EXT4. So that there will no longer be any reason why to use 
> NVFS over EXT4. Without journaling, it will be faster than EXT4 and it may 
> attract some users who want good performance and who don't care about GID 
> and UID being updated atomically, etc.

Well, what's your intent with nvfs?  Do you already have customers in mind
who want to use this in production, or is this somewhere to play with and
develop concepts that might make it into one of the longer-established
filesystems?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
