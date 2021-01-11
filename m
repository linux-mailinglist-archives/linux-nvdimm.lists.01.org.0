Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D642F0FB7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 11 Jan 2021 11:11:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 978CC100EBBB1;
	Mon, 11 Jan 2021 02:11:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.58.85.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=<UNKNOWN> 
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7905A100EBBAF
	for <linux-nvdimm@lists.01.org>; Mon, 11 Jan 2021 02:11:23 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-68-LSP2TgUWPoW5OYymkm_RvQ-1; Mon, 11 Jan 2021 10:11:18 +0000
X-MC-Unique: LSP2TgUWPoW5OYymkm_RvQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 Jan 2021 10:11:17 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 Jan 2021 10:11:17 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Matthew Wilcox' <willy@infradead.org>, Mikulas Patocka
	<mpatocka@redhat.com>
Subject: RE: Expense of read_iter
Thread-Topic: Expense of read_iter
Thread-Index: AQHW5xgPc3YVJbtxFkyYJqwIgIdF7KoiMj8g
Date: Mon, 11 Jan 2021 10:11:17 +0000
Message-ID: <647fe440ab4640038a6ccaf59ab99685@AcuMS.aculab.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110061321.GC35215@casper.infradead.org>
In-Reply-To: <20210110061321.GC35215@casper.infradead.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Message-ID-Hash: E5YIUSKFQGLKZRNVVZN7OW5CI4SVU2HG
X-Message-ID-Hash: E5YIUSKFQGLKZRNVVZN7OW5CI4SVU2HG
X-MailFrom: david.laight@aculab.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>,
	"Dave Jiang  <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Jan Kara" <jack@suse.cz>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Eric Sandeen <esandeen@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	Wang Jianchao <jianchao.wan9@gmail.com>, "Tadakamadla,"@ml01.01.org,
	Rajesh@ml01.01.org, " <rajesh.tadakamadla@hpe.com>, "@ml01.01.org,
	linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E5YIUSKFQGLKZRNVVZN7OW5CI4SVU2HG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Matthew Wilcox
> Sent: 10 January 2021 06:13
...
> nvfs_rw_iter_locked() looks very complicated.  I suspect it can
> be simplified.  Of course new_sync_read() needs to be improved too,
> as do the other functions here, but fully a third of the difference
> between read() and read_iter() is the difference between nvfs_read()
> and nvfs_rw_iter_locked().

There is also the non-zero cost of import_iovec().
I've got some slight speedups, but haven't measured an
old kernel yet to see how much slower 5.11-rc1 made it.

Basic test is:
	fd = open("/dev/null", O_RDWR);
	for (1 = 0; 1 < 10000; i++) {
		start = rdtsc();
		writev(fd, iovec, count);
		histogram[rdtsc() - start]++;
	}

This doesn't actually copy any data - the iovec
isn't iterated.

I'm seeing pretty stable counts for most of the 10000 iterations.
But different program runs can give massively different timings.
I'm quessing that depends on cache collisions due to the addresses
(virtual of physical?) selected for some items.

For 5.11-rc2 -mx32 is slightly faster than 64bit.
Whereas -m32 has a much slower syscall entry/exit path,
but the difference between gettid() and writev() is lower.
The compat code for import_iovec() is actually faster.
This isn't really surprising since copy_from_user() is
absolutely horrid these days - especially with userspace hardening.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
