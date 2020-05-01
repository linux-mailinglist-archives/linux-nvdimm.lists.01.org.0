Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723D81C0F00
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 May 2020 09:47:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5197E10053E14;
	Fri,  1 May 2020 00:45:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.82.80.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=<UNKNOWN> 
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [207.82.80.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DDBE310053E02
	for <linux-nvdimm@lists.01.org>; Fri,  1 May 2020 00:45:38 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-236-crWB7YfiO5yLJYsQLeM4Tg-1; Fri, 01 May 2020 08:46:50 +0100
X-MC-Unique: crWB7YfiO5yLJYsQLeM4Tg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 1 May 2020 08:46:49 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 1 May 2020 08:46:49 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andy Lutomirski' <luto@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: RE: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Thread-Topic: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Thread-Index: AQHWHx8fSK33XHL44ESHjM2jwgOtw6iS1wyw
Date: Fri, 1 May 2020 07:46:48 +0000
Message-ID: <6c0ca300a3b54b86abac79d6549a0a40@AcuMS.aculab.com>
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
In-Reply-To: <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Message-ID-Hash: EMKNU2CUZ44HA5ZQ7ZRNWGTEOYYS67O7
X-Message-ID-Hash: EMKNU2CUZ44HA5ZQ7ZRNWGTEOYYS67O7
X-MailFrom: david.laight@aculab.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Erwin Tsaur  <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo" <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EMKNU2CUZ44HA5ZQ7ZRNWGTEOYYS67O7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andy Lutomirski
> Sent: 30 April 2020 19:42
...
> I suppose there could be a consistent naming like this:
> 
> copy_from_user()
> copy_to_user()
> 
> copy_from_unchecked_kernel_address() [what probe_kernel_read() is]
> copy_to_unchecked_kernel_address() [what probe_kernel_write() is]
> 
> copy_from_fallible() [from a kernel address that can fail to a kernel
> address that can't fail]
> copy_to_fallible() [the opposite, but hopefully identical to memcpy() on x86]
> 
> copy_from_fallible_to_user()
> copy_from_user_to_fallible()

You missed out:
copy_to/from_io()
copy_to_io_from_user()
copy_from_io_to_user()
All of which want aligned addresses on the 'io' side.

It might even be worth saying that the copy_to/from_io() can
fail due to bad IO accesses (rather than bad addresses).
This is not entirely unexpected since all PCIe accesses
can fail unexpectedly (usually without a trap and returning -1).
But a system could arrange to generate a synchronous fault.

If you are copying directly from io to user you need to
differentiate between a user page fault and an io access
error. The latter shouldn't generate SIGSEGV.
Possibly return -EFAULT on user page fault and 'transfer
length remaining' on io access error.
Although filling the rest of the buffer with 0xff might be
appropriate.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
