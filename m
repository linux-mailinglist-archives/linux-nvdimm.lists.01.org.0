Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BF719967E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 31 Mar 2020 14:27:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07F9A10FC389F;
	Tue, 31 Mar 2020 05:28:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EBE8810FC389E
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1585657646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYI1H5xvbhp7r0w6nSEzGN4hQIZrI+OF27OaaOA7sQ0=;
	b=HbGDcvfytfuuzefwRzfnixbuS6CULdMGL/Ave9TuY1XDU3bDkMmeZc7jbmvxKcaehp4z3L
	4m7fP/YEjsWX46PmCnmhgFG8d8QumibpXWfflmBZJqzQ1uAfL6TQSGaUD3np8atvnxIlCb
	a7pPBhO5/PSvV2luTNQsy6TA/uQlW8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-srONtDzJN2KHeuZli9He2A-1; Tue, 31 Mar 2020 08:27:25 -0400
X-MC-Unique: srONtDzJN2KHeuZli9He2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A13FADB60;
	Tue, 31 Mar 2020 12:27:23 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 768A298A3C;
	Tue, 31 Mar 2020 12:27:23 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 02VCRMK4019806;
	Tue, 31 Mar 2020 08:27:22 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 02VBwYXk017547;
	Tue, 31 Mar 2020 07:58:58 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Tue, 31 Mar 2020 07:58:34 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: "Elliott, Robert (Servers)" <elliott@hpe.com>
Subject: RE: [PATCH v2] memcpy_flushcache: use cache flusing for larger
 lengths
In-Reply-To: <CS1PR8401MB12377197482867F688BF93F7ABC80@CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM>
Message-ID: <alpine.LRH.2.02.2003310709090.2117@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2003291625590.32108@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2003300729320.9938@file01.intranet.prod.int.rdu2.redhat.com> <CS1PR8401MB12377197482867F688BF93F7ABC80@CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: 6UZLKKB43BP4R27J7NJGOWBLVPP5J2PD
X-Message-ID-Hash: 6UZLKKB43BP4R27J7NJGOWBLVPP5J2PD
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Snitzer <msnitzer@redhat.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6UZLKKB43BP4R27J7NJGOWBLVPP5J2PD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 31 Mar 2020, Elliott, Robert (Servers) wrote:

> 
> 
> > -----Original Message-----
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > Sent: Monday, March 30, 2020 6:32 AM
> > To: Dan Williams <dan.j.williams@intel.com>; Vishal Verma
> > <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Ira
> > Weiny <ira.weiny@intel.com>; Mike Snitzer <msnitzer@redhat.com>
> > Cc: linux-nvdimm@lists.01.org; dm-devel@redhat.com
> > Subject: [PATCH v2] memcpy_flushcache: use cache flusing for larger
> > lengths
> > 
> > I tested dm-writecache performance on a machine with Optane nvdimm
> > and it turned out that for larger writes, cached stores + cache
> > flushing perform better than non-temporal stores. This is the
> > throughput of dm- writecache measured with this command:
> > dd if=/dev/zero of=/dev/mapper/wc bs=64 oflag=direct
> > 
> > block size	512		1024		2048		4096
> > movnti	496 MB/s	642 MB/s	725 MB/s	744 MB/s
> > clflushopt	373 MB/s	688 MB/s	1.1 GB/s	1.2 GB/s
> > 
> > We can see that for smaller block, movnti performs better, but for
> > larger blocks, clflushopt has better performance.
> 
> There are other interactions to consider... see threads from the last
> few years on the linux-nvdimm list.

dm-writecache is the only linux driver that uses memcpy_flushcache on 
persistent memory. There is also the btt driver, it uses the "do_io" 
method to write to persistent memory and I don't know where this method 
comes from.

Anyway, if patching memcpy_flushcache conflicts with something else, we 
should introduce memcpy_flushcache_to_pmem.

> For example, software generally expects that read()s take a long time and
> avoids re-reading from disk; the normal pattern is to hold the data in
> memory and read it from there. By using normal stores, CPU caches end up
> holding a bunch of persistent memory data that is probably not going to
> be read again any time soon, bumping out more useful data. In contrast,
> movnti avoids filling the CPU caches.

But if I write one cacheline and flush it immediatelly, it would consume 
just one associative entry in the cache.

> Another option is the AVX vmovntdq instruction (if available), the
> most recent of which does 64-byte (cache line) sized transfers to
> zmm registers. There's a hefty context switching overhead (e.g.,
> 304 clocks), and the CPU often runs AVX instructions at a slower
> clock frequency, so it's hard to judge when it's worthwhile.

The benchmark shows that 64-byte non-temporal avx512 vmovntdq is as good 
as 8, 16 or 32-bytes writes.
                                         ram            nvdimm
sequential write-nt 4 bytes              4.1 GB/s       1.3 GB/s
sequential write-nt 8 bytes              4.1 GB/s       1.3 GB/s
sequential write-nt 16 bytes (sse)       4.1 GB/s       1.3 GB/s
sequential write-nt 32 bytes (avx)       4.2 GB/s       1.3 GB/s
sequential write-nt 64 bytes (avx512)    4.1 GB/s       1.3 GB/s

With cached writes (where each cache line is immediatelly followed by clwb 
or clflushopt), 8, 16 or 32-byte write performs better than non-temporal 
stores and avx512 performs worse.

sequential write 8 + clwb                5.1 GB/s       1.6 GB/s
sequential write 16 (sse) + clwb         5.1 GB/s       1.6 GB/s
sequential write 32 (avx) + clwb         4.4 GB/s       1.5 GB/s
sequential write 64 (avx512) + clwb      1.7 GB/s       0.6 GB/s


> In user space, glibc faces similar choices for its memcpy() functions;
> glibc memcpy() uses non-temporal stores for transfers > 75% of the
> L3 cache size divided by the number of cores. For example, with
> glibc-2.216-16.fc27 (August 2017), on a Broadwell system with
> E5-2699 36 cores 45 MiB L3 cache, non-temporal stores are used
> for memcpy()s over 36 MiB.

BTW. what does glibc do with reads? Does it flush them from the cache 
after they are consumed?

AFAIK glibc doesn't support persistent memory - i.e. there is no function 
that flushes data and the user has to use inline assembly for that.

> It'd be nice if glibc, PMDK, and the kernel used the same algorithms.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
