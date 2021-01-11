Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD302F11F6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 11 Jan 2021 12:57:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60705100EC1E9;
	Mon, 11 Jan 2021 03:57:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.58.86.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=<UNKNOWN> 
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C3F4100EC1E8
	for <linux-nvdimm@lists.01.org>; Mon, 11 Jan 2021 03:57:16 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-37-qTe83McBMiCWIf7m7BZI6A-1; Mon, 11 Jan 2021 11:57:11 +0000
X-MC-Unique: qTe83McBMiCWIf7m7BZI6A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 Jan 2021 11:57:08 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 Jan 2021 11:57:08 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mikulas Patocka' <mpatocka@redhat.com>
Subject: RE: [RFC v2] nvfs: a filesystem for persistent memory
Thread-Topic: [RFC v2] nvfs: a filesystem for persistent memory
Thread-Index: AQHW52zcFLyucqAcQUmnqwhwPozPcaoiOfvQgAAVUICAAALF8A==
Date: Mon, 11 Jan 2021 11:57:08 +0000
Message-ID: <57dad96341d34822a7943242c9bcad71@AcuMS.aculab.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110162008.GV3579531@ZenIV.linux.org.uk>
 <c26db2b0ea1a4891a7cbd0363de856d3@AcuMS.aculab.com>
 <alpine.LRH.2.02.2101110641490.4356@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2101110641490.4356@file01.intranet.prod.int.rdu2.redhat.com>
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
Message-ID-Hash: Z3SRIJFTW4TWFUYHDMAQMWAZCE4JOQCE
X-Message-ID-Hash: Z3SRIJFTW4TWFUYHDMAQMWAZCE4JOQCE
X-MailFrom: david.laight@aculab.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: 'Al Viro' <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Verma  <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,  Ira Weiny  <ira.weiny@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara" <jack@suse.cz>,
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
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z3SRIJFTW4TWFUYHDMAQMWAZCE4JOQCE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Mikulas Patocka
> Sent: 11 January 2021 11:44
> On Mon, 11 Jan 2021, David Laight wrote:
> 
> > From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> > > Sent: 10 January 2021 16:20
...
...
> > > 	while (iov_iter_count(to)) {
...
> > > 		size = copy_to_iter(to, ptr, size);
> > > 		if (unlikely(!size)) {
> > > 			r = -EFAULT;
> > > 			goto ret_r;
> > > 		}
> > >
> > > 		pos += size;
> > > 		total += size;
> > > 	} while (iov_iter_count(to));
> >
> > That isn't the best formed loop!
> >
> > 	David
> 
> I removed the second "while" statement and fixed the arguments to
> copy_to_iter - other than that, Al's function works.

The extra while is easy to write and can be difficult to spot.
I've found them looking as the object code before now!

Oh - the error return for copy_to_iter() is wrong.
It should (probably) return 'total' if it is nonzero.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
