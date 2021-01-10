Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849432F0A76
	for <lists+linux-nvdimm@lfdr.de>; Mon, 11 Jan 2021 00:41:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4CC8100ED4A3;
	Sun, 10 Jan 2021 15:41:22 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2002:c35c:fd02::1; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN> 
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A8A33100EF26A
	for <linux-nvdimm@lists.01.org>; Sun, 10 Jan 2021 15:41:19 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kykKA-0094e9-Rx; Sun, 10 Jan 2021 23:40:42 +0000
Date: Sun, 10 Jan 2021 23:40:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [RFC v2] nvfs: a filesystem for persistent memory
Message-ID: <20210110234042.GX3579531@ZenIV.linux.org.uk>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110162008.GV3579531@ZenIV.linux.org.uk>
 <alpine.LRH.2.02.2101101410230.7245@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2101101410230.7245@file01.intranet.prod.int.rdu2.redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Message-ID-Hash: 376NLMQOXWYXLZ6NSGXUJYEHVEX33AJK
X-Message-ID-Hash: 376NLMQOXWYXLZ6NSGXUJYEHVEX33AJK
X-MailFrom: viro@ftp.linux.org.uk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Wang Jianchao <jianchao.wan9@gmail.com>, "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/376NLMQOXWYXLZ6NSGXUJYEHVEX33AJK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Jan 10, 2021 at 04:14:55PM -0500, Mikulas Patocka wrote:

> That's a good point. I split nvfs_rw_iter to separate functions 
> nvfs_read_iter and nvfs_write_iter - and inlined nvfs_rw_iter_locked into 
> both of them. It improved performance by 1.3%.
> 
> > Not that it had been more useful on the write side, really,
> > but that's another story (nvfs_write_pages() handling of
> > copyin is... interesting).  Let's figure out what's going
> > on with the read overhead first...
> > 
> > lib/iov_iter.c primitives certainly could use massage for
> > better code generation, but let's find out how much of the
> > PITA is due to those and how much comes from you fighing
> > the damn thing instead of using it sanely...
> 
> The results are:
> 
> read:                                           6.744s
> read_iter:                                      7.417s
> read_iter - separate read and write path:       7.321s
> Al's read_iter:                                 7.182s
> Al's read_iter with _copy_to_iter:              7.181s

So
	* overhead of hardening stuff is noise here
	* switching to more straightforward ->read_iter() cuts
the overhead by about 1/3.

	Interesting...  I wonder how much of that is spent in
iterate_and_advance() glue inside copy_to_iter() here.  There's
certainly quite a bit of optimizations possible in those
primitives and your usecase makes a decent test for that...

	Could you profile that and see where is it spending
the time, on instruction level?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
