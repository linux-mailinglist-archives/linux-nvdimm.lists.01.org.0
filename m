Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA2274234
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Sep 2020 14:39:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A7AA14EA713A;
	Tue, 22 Sep 2020 05:39:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6EDF714EA7138
	for <linux-nvdimm@lists.01.org>; Tue, 22 Sep 2020 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600778360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13v2utUwRQqeWPATCUhCzFKLpxpP9eoRFAS7+tLKUYQ=;
	b=AgDceEZ1PTwn/7/QRK5b/NIoEERFo4wqyRrrB73r362Qoqr9XbxN8oBaOyn9AhwL4+I/lz
	BKGkWx7pEi8KA48o+/HgrQMGhi7/+GGbWG3LcdUNiYXYoDQPqXNlt3cdMeBST3HUCTqcsn
	wIu7XC45H5LUVc1q/1pTdS4uTZ6uOTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-OH8YTdnSN-C8yKRcopmK_A-1; Tue, 22 Sep 2020 08:39:16 -0400
X-MC-Unique: OH8YTdnSN-C8yKRcopmK_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBCBD186DD28;
	Tue, 22 Sep 2020 12:39:13 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 687CE5C1A3;
	Tue, 22 Sep 2020 12:39:13 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08MCdCgb021345;
	Tue, 22 Sep 2020 08:39:12 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08MCdBHN021341;
	Tue, 22 Sep 2020 08:39:12 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Tue, 22 Sep 2020 08:39:11 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: NVFS XFS metadata (was: [PATCH] pmem: export the symbols
 __copy_user_flushcache and __copy_from_user_flushcache)
In-Reply-To: <20200922122819.GD32101@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2009220831170.20550@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com> <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com> <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com> <20200922122819.GD32101@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: 23XBCSJUKLGI3KP6WI2A5FL4EQ67SGZM
X-Message-ID-Hash: 23XBCSJUKLGI3KP6WI2A5FL4EQ67SGZM
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/23XBCSJUKLGI3KP6WI2A5FL4EQ67SGZM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 22 Sep 2020, Matthew Wilcox wrote:

> On Mon, Sep 21, 2020 at 12:20:42PM -0400, Mikulas Patocka wrote:
> > The same for directories - NVFS hashes the file name and uses radix-tree 
> > to locate a directory page where the directory entry is located. XFS 
> > b+trees would result in much more accesses than the radix-tree.
> 
> What?  Radix trees behave _horribly_ badly when indexed by a hash.
> If you have a 64-bit hash and use 8 bits per level of the tree, you have
> to traverse 8 pointers to get to your destination.  You might as well
> use a linked list!

In NVFS, radix trees are cut off - they have only as much internal levels, 
as is needed to disambiguate the directory entries.

Read this document: http://people.redhat.com/~mpatocka/nvfs/INTERNALS
the section "DIRECTORIES".

Perhaps, I should call it differently than "radix-trees", but I don't 
really know what is the official name for this data structure.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
