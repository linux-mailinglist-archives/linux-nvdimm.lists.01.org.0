Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 963BA19BFEB
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 13:11:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8A35E10FC6F0A;
	Thu,  2 Apr 2020 04:11:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.165.44.50; helo=5.mo4.mail-out.ovh.net; envelope-from=groug@kaod.org; receiver=<UNKNOWN> 
Received: from 5.mo4.mail-out.ovh.net (5.mo4.mail-out.ovh.net [188.165.44.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C460E10FC6CDA
	for <linux-nvdimm@lists.01.org>; Thu,  2 Apr 2020 04:11:47 -0700 (PDT)
Received: from player697.ha.ovh.net (unknown [10.110.171.148])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2434B22B011
	for <linux-nvdimm@lists.01.org>; Thu,  2 Apr 2020 13:10:55 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
	(Authenticated sender: groug@kaod.org)
	by player697.ha.ovh.net (Postfix) with ESMTPSA id AEBE3110DE660;
	Thu,  2 Apr 2020 11:10:14 +0000 (UTC)
Date: Thu, 2 Apr 2020 13:10:12 +0200
From: Greg Kurz <groug@kaod.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 00/25] Add support for OpenCAPI Persistent Memory
 devices
Message-ID: <20200402131012.579c7bf7@bahia.lan>
In-Reply-To: <87bloatd6e.fsf@mpe.ellerman.id.au>
References: <20200327071202.2159885-1-alastair@d-silva.org>
	<CAPcyv4iJYZBVhV1NW7EB6-EwETiUAy6r1iiE+F+HvFXfGZt9Aw@mail.gmail.com>
	<2d6901d60877$16aa7a90$43ff6fb0$@d-silva.org>
	<87imiituxm.fsf@mpe.ellerman.id.au>
	<CAOSf1CHdpFyT_6zetKM6eHDK3AT8-UNTzjdd2y+QqYT2AO9VDw@mail.gmail.com>
	<87bloatd6e.fsf@mpe.ellerman.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Ovh-Tracer-Id: 14428970257110833585
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -51
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdeggdefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhthhhusgdrihhonecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvughimhhmsehlihhsthhsrddtuddrohhrgh
Message-ID-Hash: PH3KFVY6QWSLGZ3ZR7I4Y6CL6UZJDDHD
X-Message-ID-Hash: PH3KFVY6QWSLGZ3ZR7I4Y6CL6UZJDDHD
X-MailFrom: groug@kaod.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alastair D'Silva <alastair@d-silva.org>, "Aneesh Kumar K . V  <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt" <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Linux Kernel Mailing Lis
 t <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PH3KFVY6QWSLGZ3ZR7I4Y6CL6UZJDDHD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 02 Apr 2020 21:06:01 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> "Oliver O'Halloran" <oohall@gmail.com> writes:
> > On Thu, Apr 2, 2020 at 2:42 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> "Alastair D'Silva" <alastair@d-silva.org> writes:
> >> >> -----Original Message-----
> >> >> From: Dan Williams <dan.j.williams@intel.com>
> >> >>
> >> >> On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org>
> >> >> wrote:
> >> >> >
> >> >> > *snip*
> >> >> Are OPAL calls similar to ACPI DSMs? I.e. methods for the OS to invoke
> >> >> platform firmware services? What's Skiboot?
> >> >
> >> > Yes, OPAL is the interface to firmware for POWER. Skiboot is the open-source (and only) implementation of OPAL.
> >>
> >>   https://github.com/open-power/skiboot
> >>
> >> In particular the tokens for calls are defined here:
> >>
> >>   https://github.com/open-power/skiboot/blob/master/include/opal-api.h#L220
> >>
> >> And you can grep for the token to find the implementation:
> >>
> >>   https://github.com/open-power/skiboot/blob/master/hw/npu2-opencapi.c#L2328
> >
> > I'm not sure I'd encourage anyone to read npu2-opencapi.c. I find it
> > hard enough to follow even with access to the workbooks.
> 
> Compared to certain firmwares that run on certain other platforms it's
> actually pretty readable code ;)
> 

Forth rocks ! ;-)

> > There's an OPAL call API reference here:
> > http://open-power.github.io/skiboot/doc/opal-api/index.html
> 
> Even better.
> 
> cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
