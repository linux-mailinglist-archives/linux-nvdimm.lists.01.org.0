Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B05272BA6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 18:20:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A60EC145940E7;
	Mon, 21 Sep 2020 09:20:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5BF46145940E6
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600705250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jQWTc66kqIVZ12N6Cbr6RkCq5AT8IRw3RQfZVWbTbrI=;
	b=XGcgXnxEjLG2twMNuMLbR23HEyJGYVMPfpCp+7sgv7/EViAfHiXfVN9vbJwIueWxpZdFJy
	DNA3XCeByF0o8lODIdF92J4qcRiYvmieiQWjPPaAwCTVyQ9w3j4pSCtZntoHD6Y/eyyaPY
	84E2c3vqHbOL5XIROi/rs6w/yaInxXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-cblGsGTfOVqBQ7_yEP5lXA-1; Mon, 21 Sep 2020 12:20:46 -0400
X-MC-Unique: cblGsGTfOVqBQ7_yEP5lXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D80471005E5B;
	Mon, 21 Sep 2020 16:20:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A19A010013D0;
	Mon, 21 Sep 2020 16:20:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08LGKhfl006434;
	Mon, 21 Sep 2020 12:20:43 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08LGKgrb006430;
	Mon, 21 Sep 2020 12:20:42 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Mon, 21 Sep 2020 12:20:42 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Dan Williams <dan.j.williams@intel.com>
Subject: NVFS XFS metadata (was: [PATCH] pmem: export the symbols
 __copy_user_flushcache and __copy_from_user_flushcache)
In-Reply-To: <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com> <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com> <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: WCT2XZSJQWLJCBJEPSB6GLNTUEHWP5WE
X-Message-ID-Hash: WCT2XZSJQWLJCBJEPSB6GLNTUEHWP5WE
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WCT2XZSJQWLJCBJEPSB6GLNTUEHWP5WE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 16 Sep 2020, Mikulas Patocka wrote:

> 
> 
> On Wed, 16 Sep 2020, Dan Williams wrote:
> 
> > On Wed, Sep 16, 2020 at 10:24 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > >
> > > > My first question about nvfs is how it compares to a daxfs with
> > > > executables and other binaries configured to use page cache with the
> > > > new per-file dax facility?
> > >
> > > nvfs is faster than dax-based filesystems on metadata-heavy operations
> > > because it doesn't have the overhead of the buffer cache and bios. See
> > > this: http://people.redhat.com/~mpatocka/nvfs/BENCHMARKS
> > 
> > ...and that metadata problem is intractable upstream? Christoph poked
> > at bypassing the block layer for xfs metadata operations [1], I just
> > have not had time to carry that further.
> > 
> > [1]: "xfs: use dax_direct_access for log writes", although it seems
> > he's dropped that branch from his xfs.git
> 
> XFS is very big. I wanted to create something small.

And the another difference is that XFS metadata are optimized for disks 
and SSDs.

On disks and SSDs, reading one byte is as costly as reading a full block. 
So we must put as much information to a block as possible. XFS uses 
b+trees for file block mapping and for directories - it is reasonable 
decision because b+trees minimize the number of disk accesses.

On persistent memory, each access has its own cost, so NVFS uses metadata 
structures that minimize the number of cache lines accessed (rather than 
the number of blocks accessed). For block mapping, NVFS uses the classic 
unix dierct/indirect blocks - if a file block is mapped by a 3-rd level 
indirect block, we do just three memory accesses and we are done. If we 
used b+trees, the number of accesses would be much larger than 3 (we would 
have to do binary search in the b+tree nodes).

The same for directories - NVFS hashes the file name and uses radix-tree 
to locate a directory page where the directory entry is located. XFS 
b+trees would result in much more accesses than the radix-tree.

Regarding journaling - NVFS doesn't do it because persistent memory is so 
fast that we can just check it in the case of crash. NVFS has a 
multithreaded fsck that can do 3 million inodes per second. XFS does 
journaling (it was reasonable decision for disks where fsck took hours) 
and it will cause overhead for all the filesystem operations.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
