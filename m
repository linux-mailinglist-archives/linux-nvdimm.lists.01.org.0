Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2467E19BF0F
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 12:06:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C7C4E10FC6A91;
	Thu,  2 Apr 2020 03:06:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 953D910FC6A8F
	for <linux-nvdimm@lists.01.org>; Thu,  2 Apr 2020 03:06:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 48tJc24ckyz9sR4;
	Thu,  2 Apr 2020 21:05:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
	s=201909; t=1585821957;
	bh=VWV5VVYaAJNLZ0qhNZ2vXZ3ZVuH1QjojCUmH4J7cvRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BIAYcmrKq1LF5D5nT2gJkPD5FXCcgc658kciTx3sX+axQbjk3V2h07eqg6P3sQFtw
	 WZH2du4hEAjbq6MucoA118QF1GDycOJONVlClQKdeEOwTgpwMgzHQgHoLHHY/99h8q
	 NZF0h2aW+zXmsTl1aZpEs8j7uHhm8YSAZfyiNiNehPYenQ7tc3BaEQkDi/60Fu+agl
	 yFbkROHRPHEafu2+ycumDNj9Sn85R4SRDp0JrhXlvEzFZRjbsIjGWgCOkWGnS8Dgxv
	 KCEXJZ95U3du4XOtVJMWjWbxkddWIX/CG9xoI/0/E4gWVMxEhV/VNg7slBH7PHXuHY
	 fzkz6rZ7j6Jgw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v4 00/25] Add support for OpenCAPI Persistent Memory devices
In-Reply-To: <CAOSf1CHdpFyT_6zetKM6eHDK3AT8-UNTzjdd2y+QqYT2AO9VDw@mail.gmail.com>
References: <20200327071202.2159885-1-alastair@d-silva.org> <CAPcyv4iJYZBVhV1NW7EB6-EwETiUAy6r1iiE+F+HvFXfGZt9Aw@mail.gmail.com> <2d6901d60877$16aa7a90$43ff6fb0$@d-silva.org> <87imiituxm.fsf@mpe.ellerman.id.au> <CAOSf1CHdpFyT_6zetKM6eHDK3AT8-UNTzjdd2y+QqYT2AO9VDw@mail.gmail.com>
Date: Thu, 02 Apr 2020 21:06:01 +1100
Message-ID: <87bloatd6e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-ID-Hash: WFOC6EWPSYARSWY3X7LI2IOLDAHJMQFY
X-Message-ID-Hash: WFOC6EWPSYARSWY3X7LI2IOLDAHJMQFY
X-MailFrom: mpe@ellerman.id.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alastair D'Silva <alastair@d-silva.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
 , Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WFOC6EWPSYARSWY3X7LI2IOLDAHJMQFY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Oliver O'Halloran" <oohall@gmail.com> writes:
> On Thu, Apr 2, 2020 at 2:42 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> "Alastair D'Silva" <alastair@d-silva.org> writes:
>> >> -----Original Message-----
>> >> From: Dan Williams <dan.j.williams@intel.com>
>> >>
>> >> On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org>
>> >> wrote:
>> >> >
>> >> > *snip*
>> >> Are OPAL calls similar to ACPI DSMs? I.e. methods for the OS to invoke
>> >> platform firmware services? What's Skiboot?
>> >
>> > Yes, OPAL is the interface to firmware for POWER. Skiboot is the open-source (and only) implementation of OPAL.
>>
>>   https://github.com/open-power/skiboot
>>
>> In particular the tokens for calls are defined here:
>>
>>   https://github.com/open-power/skiboot/blob/master/include/opal-api.h#L220
>>
>> And you can grep for the token to find the implementation:
>>
>>   https://github.com/open-power/skiboot/blob/master/hw/npu2-opencapi.c#L2328
>
> I'm not sure I'd encourage anyone to read npu2-opencapi.c. I find it
> hard enough to follow even with access to the workbooks.

Compared to certain firmwares that run on certain other platforms it's
actually pretty readable code ;)

> There's an OPAL call API reference here:
> http://open-power.github.io/skiboot/doc/opal-api/index.html

Even better.

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
