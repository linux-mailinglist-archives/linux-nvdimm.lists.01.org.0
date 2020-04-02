Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E919BAB6
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 05:42:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D008510FC543D;
	Wed,  1 Apr 2020 20:43:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5A15210FC543C
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 20:43:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 48t85R5LZbz9sPF;
	Thu,  2 Apr 2020 14:42:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
	s=201909; t=1585798942;
	bh=J3cX5scs0a8g6OhMKwJulJbG7ejb15W4ZcfLVsBx/m4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TtOa2gQOaXw3df/rATH9hqPyASxAF5M6IEXV5ikhEID4zRWSOxNy0Bem3Nyyq6rAW
	 gKFGQNRAXr9Sp/hEbaMSLxRe6GKJ6YW+fCzNuCyS6ldSnSRjznCMGkgk/cKUA/REaz
	 f6A9n3rOFAqiJnNpCz3J+89UKikVasGo7KLAe50LEc6P7FvJTtMwfcGHcL/dlCAvEn
	 5o2JxK2hRPE/CrHfOjGBIrQPojy/GR/qkak8Qy5YrP5J4Sn0a935tcDav3RexqGdD/
	 lNvr9YtqDdKo+BFzEGOMoR+VSQ9GAGWJvEPFyUqYbgRIjBkwo0LGe5SRuSX51T9WkG
	 ZVfFuMcr2zksw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alastair D'Silva <alastair@d-silva.org>, 'Dan Williams' <dan.j.williams@intel.com>
Subject: RE: [PATCH v4 00/25] Add support for OpenCAPI Persistent Memory devices
In-Reply-To: <2d6901d60877$16aa7a90$43ff6fb0$@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org> <CAPcyv4iJYZBVhV1NW7EB6-EwETiUAy6r1iiE+F+HvFXfGZt9Aw@mail.gmail.com> <2d6901d60877$16aa7a90$43ff6fb0$@d-silva.org>
Date: Thu, 02 Apr 2020 14:42:29 +1100
Message-ID: <87imiituxm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-ID-Hash: 33GOG2P2D7CBMDMTFEAIIUIGKLO4RPIT
X-Message-ID-Hash: 33GOG2P2D7CBMDMTFEAIIUIGKLO4RPIT
X-MailFrom: mpe@ellerman.id.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "'Aneesh Kumar K . V'" <aneesh.kumar@linux.ibm.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Paul Mackerras' <paulus@samba.org>, 'Frederic Barrat' <fbarrat@linux.ibm.com>, 'Andrew Donnellan' <ajd@linux.ibm.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "'David S. Miller'" <davem@davemloft.net>, 'Rob Herring' <robh@kernel.org>, 'Anton Blanchard' <anton@ozlabs.org>, 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Mahesh Salgaonkar' <mahesh@linux.vnet.ibm.com>, 'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>, =?utf-8?Q?'C=C3=A9dric?= Le Goater' <clg@kaod.org>, 'Anju T Sudhakar' <anju@linux.vnet.ibm.com>, 'Hari Bathini' <hbathini@linux.ibm.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Greg Kurz' <groug@kaod.org>, 'Nicholas Piggin' <npiggin@gmail.com>, 'Masahiro Yamada' <yamada.masahiro@socionext.com>, 'Alexey Kardashevskiy' <aik@ozlab
 s.ru>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'linuxppc-dev' <linuxppc-dev@lists.ozlabs.org>, 'linux-nvdimm' <linux-nvdimm@lists.01.org>, 'Linux MM' <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/33GOG2P2D7CBMDMTFEAIIUIGKLO4RPIT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Alastair D'Silva" <alastair@d-silva.org> writes:
>> -----Original Message-----
>> From: Dan Williams <dan.j.williams@intel.com>
>> 
>> On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org>
>> wrote:
>> >
>> > This series adds support for OpenCAPI Persistent Memory devices on
>> > bare metal (arch/powernv), exposing them as nvdimms so that we can
>> > make use of the existing infrastructure. There already exists a driver
>> > for the same devices abstracted through PowerVM (arch/pseries):
>> > arch/powerpc/platforms/pseries/papr_scm.c
>> >
>> > These devices are connected via OpenCAPI, and present as LPC (lowest
>> coherence point) memory to the system, practically, that means that
>> memory on these cards could be treated as conventional, cache-coherent
>> memory.
>> >
>> > Since the devices are connected via OpenCAPI, they are not enumerated
>> via ACPI. Instead, OpenCAPI links present as pseudo-PCI bridges, with
>> devices below them.
>> >
>> > This series introduces a driver that exposes the memory on these cards as
>> nvdimms, with each card getting it's own bus. This is somewhat complicated
>> by the fact that the cards do not have out of band persistent storage for
>> metadata, so 1 SECTION_SIZE's (see SPARSEMEM) worth of storage is carved
>> out of the top of the card storage to implement the ndctl_config_* calls.
>> 
>> Is it really tied to section-size? Can't that change based on the configured
>> page-size? It's not clear to me why that would be the choice, but I'll dig into
>> the implementation.
>> 
>
> I had tried using PAGE_SIZE, but ran into problems carving off just 1 page and handing it to the kernel, while leaving the rest as pmem. That was a while ago though, so maybe I should retry it.
>
>> > The driver is not responsible for configuring the NPU (NVLink Processing
>> Unit) BARs to map the LPC memory from the card into the system's physical
>> address space, instead, it requests this to be done via OPAL calls (typically
>> implemented by Skiboot).
>> 
>> Are OPAL calls similar to ACPI DSMs? I.e. methods for the OS to invoke
>> platform firmware services? What's Skiboot?
>> 
>
> Yes, OPAL is the interface to firmware for POWER. Skiboot is the open-source (and only) implementation of OPAL.

  https://github.com/open-power/skiboot

In particular the tokens for calls are defined here:

  https://github.com/open-power/skiboot/blob/master/include/opal-api.h#L220

And you can grep for the token to find the implementation:

  https://github.com/open-power/skiboot/blob/master/hw/npu2-opencapi.c#L2328


cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
