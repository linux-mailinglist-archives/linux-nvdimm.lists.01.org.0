Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B8F1C2C97
	for <lists+linux-nvdimm@lfdr.de>; Sun,  3 May 2020 14:57:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EFE86110D4E25;
	Sun,  3 May 2020 05:56:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=146.101.78.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=<UNKNOWN> 
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [146.101.78.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9470F110D4E23
	for <linux-nvdimm@lists.01.org>; Sun,  3 May 2020 05:56:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-181-BT3qH9VsMz-dk4PkoNseiQ-1; Sun, 03 May 2020 13:57:31 +0100
X-MC-Unique: BT3qH9VsMz-dk4PkoNseiQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 3 May 2020 13:57:30 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 3 May 2020 13:57:30 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Dan Williams
	<dan.j.williams@intel.com>
Subject: RE: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Thread-Topic: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Thread-Index: AQHWH+ZTSK33XHL44ESHjM2jwgOtw6iWT55g
Date: Sun, 3 May 2020 12:57:30 +0000
Message-ID: <a4aabe6f2ca649779a772a5f0365af6f@AcuMS.aculab.com>
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
 <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
 <CAPcyv4g0a406X9-=NATJZ9QqObim9Phdkb_WmmhsT9zvXsGSpw@mail.gmail.com>
 <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <CAPcyv4jvgCGU700x_U6EKyGsHwQBoPkJUF+6gP4YDPupjdViyQ@mail.gmail.com>
 <CAHk-=wiPkwF2+y6wZd=VD9BooKxHRWhSVW8dr+WSeeSPkJk7kQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiPkwF2+y6wZd=VD9BooKxHRWhSVW8dr+WSeeSPkJk7kQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Message-ID-Hash: A5YS3CKKYKUXWSY2QKX6BBWD25UY7TM5
X-Message-ID-Hash: A5YS3CKKYKUXWSY2QKX6BBWD25UY7TM5
X-MailFrom: david.laight@aculab.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Peter Zijlstra  <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable" <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin  <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>,  Benjamin Herrenschmidt  <benh@kernel.crashing.org>, Erwin Tsaur" <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, "Arnaldo Carvalho de Melo  <acme@kernel.org>, linux-nvdimm" <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A5YS3CKKYKUXWSY2QKX6BBWD25UY7TM5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Linus Torvalds
> Sent: 01 May 2020 19:29
...
> And as DavidL pointed out - if you ever have "iomem" as a source or
> destination, you need yet another case. Not because they can take
> another kind of fault (although on some platforms you have the machine
> checks for that too), but because they have *very* different
> performance profiles (and the ERMS "rep movsb" sucks baby donkeys
> through a straw).


I was actually thinking that the nvdimm accesses need to be treated
much more like (cached) memory mapped io space than normal system
memory.
So treating them the same as "iomem" and then having access functions
that report access failures (which the current readq() doesn't)
might make sense.

If you are using memory that 'might fail' for kernel code or data
you really get what you deserve.

OTOH system response to PCIe errors is currently rather problematic.
Mostly reads time out and return ~0u.
This can be checked for and, if possibly valid, a second location read.

However we have a x86 server box (I've forgotten whether it is HP or
Dell) that generates an NMI whenever a PCIe link goes down.
(The 'platform' takes the AER interrupt and uses an NMI to pass
it to the kernel - whose bright idea was it to use an NMI???)
This happens even after we've done an 'echo 1 >remove'.
The system is supposed to be NEBS (I think that is the term) compliant
which is supposed to be suitable for telephony work (including
emergency calls), but any PCIe failure crashes the box!

I've another system here that sometimes fails to bring the PCIe
link back up.
I guess these code paths don't get regular testing.
In my case the PCIe slave is an fpga, reloading the fpga image
(either over JTAG or after rewriting eeprom) doesn't always work.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
