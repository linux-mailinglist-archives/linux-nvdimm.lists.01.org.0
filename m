Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A5F1DB85C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 May 2020 17:34:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94C6611D77B9D;
	Wed, 20 May 2020 08:31:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.82.80.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=<UNKNOWN> 
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [207.82.80.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BBD9111D77B9A
	for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 08:31:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-228-m9nY-k74MOCgdXhj5Ly8FA-1; Wed, 20 May 2020 16:34:51 +0100
X-MC-Unique: m9nY-k74MOCgdXhj5Ly8FA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 20 May 2020 16:34:50 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 20 May 2020 16:34:50 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: David Laight <David.Laight@ACULAB.COM>, 'Dan Williams'
	<dan.j.williams@intel.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: RE: [PATCH v3 1/2] x86, powerpc: Rename memcpy_mcsafe() to
 copy_mc_to_{user, kernel}()
Thread-Topic: [PATCH v3 1/2] x86, powerpc: Rename memcpy_mcsafe() to
 copy_mc_to_{user, kernel}()
Thread-Index: AQHWLrr3OGthQXUtsU6REk+fDuiGdKixGiVwgAAAsmA=
Date: Wed, 20 May 2020 15:34:50 +0000
Message-ID: <6a7200e6c57843eb8c6c08db9f991064@AcuMS.aculab.com>
References: <158992635164.403910.2616621400995359522.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158992635697.403910.6957168747147028694.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87d06z7x1a.fsf@mpe.ellerman.id.au>
 <CAPcyv4igM-jK6OkPzd91ur_fNCaUxwbWTHhwWsWe-PJNjZdWGw@mail.gmail.com>
 <380699aca2424f5ab1fb55c220350908@AcuMS.aculab.com>
In-Reply-To: <380699aca2424f5ab1fb55c220350908@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Message-ID-Hash: 3S2YEC2F7AAOKRO3LQQT2QKZN7AWIEMQ
X-Message-ID-Hash: 3S2YEC2F7AAOKRO3LQQT2QKZN7AWIEMQ
X-MailFrom: david.laight@aculab.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "X86 ML  <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Mikulas Patocka <mpatocka@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnaldo Carvalho de Melo <acme@kernel.org>, "Linus Torvalds  <torvalds@linux-foundation.org>, Benjamin Herrenschmidt" <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3S2YEC2F7AAOKRO3LQQT2QKZN7AWIEMQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Dan Williams
> > Sent: 20 May 2020 16:26
> ...
> > > > +#ifdef CONFIG_ARCH_HAS_COPY_MC
> > > > +extern unsigned long __must_check
> > >
> > > We try not to add extern in headers anymore.
> >
> > Ok, I was doing the copy-pasta dance, but I'll remove this.
> 
> It is data not code, it needs the extern to not be 'common'.
> OTOH what is a global variable being used for?

Aaarg not enough context...

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
