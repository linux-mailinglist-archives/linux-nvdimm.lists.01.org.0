Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 752492F0A90
	for <lists+linux-nvdimm@lfdr.de>; Mon, 11 Jan 2021 01:18:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 92524100EC1DA;
	Sun, 10 Jan 2021 16:18:52 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 08700100EC1D6
	for <linux-nvdimm@lists.01.org>; Sun, 10 Jan 2021 16:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rRfpg+NyeZkkosMsL/GGMa7wDSV2EgRrAhugKvP5dDc=; b=Cmobwypg8XD0xhRhTMPT42v6yB
	JpO7FS8VhJnwoM1xHAgY4CdiW7p8pAr5BU04gfn0jxSV+ZUs4lM7dpuWyqdfToqwtXYOka2xbcp6o
	ekdFuKVrTVJppbf2qKHuvmaAdWpcpnMPcnmD8daVivpg/EKIEhLbAFBD8+dQ5P7Kduf29K4q4KBpB
	O3jZNpHmE2JNSoNCbJGIW0efQA2rFOi4bSHwRcVmLgq3bVf9RVXZqHbMZtvbAZmYor53RRtYjeAU8
	TVjFldcEI1vdSFednSXxNpES+myoShOyo4NL8vjm4Emj2g4c39xFX6e7mzuSzv/jO7f6tBC1EZ92l
	Wpzw+lBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1kykuL-002VOv-NN; Mon, 11 Jan 2021 00:18:06 +0000
Date: Mon, 11 Jan 2021 00:18:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Expense of read_iter
Message-ID: <20210111001805.GD35215@casper.infradead.org>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110061321.GC35215@casper.infradead.org>
 <alpine.LRH.2.02.2101101458420.7366@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2101101458420.7366@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID-Hash: GTVYKAH7VCQUI7L6HCXYHTPVZ5MQU63P
X-Message-ID-Hash: GTVYKAH7VCQUI7L6HCXYHTPVZ5MQU63P
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Wang Jianchao <jianchao.wan9@gmail.com>, "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GTVYKAH7VCQUI7L6HCXYHTPVZ5MQU63P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Jan 10, 2021 at 04:19:15PM -0500, Mikulas Patocka wrote:
> I put counters into vfs_read and vfs_readv.
> 
> After a fresh boot of the virtual machine, the counters show "13385 4". 
> After a kernel compilation they show "4475220 8".
> 
> So, the readv path is almost unused.
> 
> My reasoning was that we should optimize for the "read" path and glue the 
> "readv" path on the top of that. Currently, the kernel is doing the 
> opposite - optimizing for "readv" and glueing "read" on the top of it.

But it's not about optimising for read vs readv.  read_iter handles
a host of other cases, such as pread(), preadv(), AIO reads, splice,
and reads to in-kernel buffers.

Some device drivers abused read() vs readv() to actually return different
information, depending which you called.  That's why there's now a
prohibition against both.

So let's figure out how to make iter_read() perform well for sys_read().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
