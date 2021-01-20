Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C909D2FD449
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 16:44:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57597100EB840;
	Wed, 20 Jan 2021 07:44:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.58.86.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=<UNKNOWN> 
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8562F100EB83F
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 07:44:44 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-29-eILD036iMCOERidD8eAmqg-1; Wed, 20 Jan 2021 15:44:40 +0000
X-MC-Unique: eILD036iMCOERidD8eAmqg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 20 Jan 2021 15:44:38 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 20 Jan 2021 15:44:38 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mikulas Patocka' <mpatocka@redhat.com>, Jan Kara <jack@suse.cz>
Subject: RE: Expense of read_iter
Thread-Topic: Expense of read_iter
Thread-Index: AQHW7z6gIbHKRyPAmU2nz0K77h3r46owpQfA
Date: Wed, 20 Jan 2021 15:44:38 +0000
Message-ID: <08ea15c321bb42c2b2c941c8c741b268@AcuMS.aculab.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com>
 <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
 <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com>
 <1224425872.715547.1610703643424.JavaMail.zimbra@sjtu.edu.cn>
 <20210120044700.GA4626@dread.disaster.area>
 <20210120141834.GA24063@quack2.suse.cz>
 <alpine.LRH.2.02.2101200951070.24430@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2101200951070.24430@file01.intranet.prod.int.rdu2.redhat.com>
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
Message-ID-Hash: ISPF54P3LNELLJB5IYZTBVXTET26AMYG
X-Message-ID-Hash: ISPF54P3LNELLJB5IYZTBVXTET26AMYG
X-MailFrom: david.laight@aculab.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Chinner <david@fromorbit.com>, Zhongwei Cai <sunrise_l@sjtu.edu.cn>, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, "Mingkai Dong  <mingkaidong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Whitehouse" <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Wang Jianchao <jianchao.wan9@gmail.com>, Rajesh Tadakamadla <rajesh.tadakamadla@hpe.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ISPF54P3LNELLJB5IYZTBVXTET26AMYG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Mikulas Patocka
> Sent: 20 January 2021 15:12
> 
> On Wed, 20 Jan 2021, Jan Kara wrote:
> 
> > Yeah, I agree. I'm against ext4 private solution for this read problem. And
> > I'm also against duplicating ->read_iter functionatily in ->read handler.
> > The maintenance burden of this code duplication is IMHO just too big. We
> > rather need to improve the generic code so that the fast path is faster.
> > And every filesystem will benefit because this is not ext4 specific
> > problem.
> >
> > 								Honza
> 
> Do you have some idea how to optimize the generic code that calls
> ->read_iter?
> 
> vfs_read calls ->read if it is present. If not, it calls new_sync_read.
> new_sync_read's frame size is 128 bytes - it holds the structures iovec,
> kiocb and iov_iter. new_sync_read calls ->read_iter.
> 
> I have found out that the cost of calling new_sync_read is 3.3%, Zhongwei
> found out 3.9%. (the benchmark repeatedy reads the same 4k page)
> 
> I don't see any way how to optimize new_sync_read or how to reduce its
> frame size. Do you?

Why is the 'read_iter' path not just the same as the 'read' one
but calling copy_to_iter() instead of copy_to_user().

For a single fragment iov[] the difference might just be
measurable for a single byte read.
But by the time you are transferring 4k it ought to be miniscule.

It isn't as though you have the cost of reading the iov[] from userspace.
(That hits sendmsg() v send().)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
