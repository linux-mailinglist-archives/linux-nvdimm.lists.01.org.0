Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AD119CF49
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 06:27:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 268D4100F2247;
	Thu,  2 Apr 2020 21:28:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 23FC1100F2246
	for <linux-nvdimm@lists.01.org>; Thu,  2 Apr 2020 21:28:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 48tn3F11cNz9sRR;
	Fri,  3 Apr 2020 15:27:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
	s=201909; t=1585888059;
	bh=P6pDV2mWC3/QGwHFGntoCWhQeeo1qFFM1tqWOPVJ5GQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Vsp7iefSuq2qUc2BqgDgoqQSz9nPDU/JrItc+oEyG61KFugv7uQPx8toJGFzcyDE9
	 fbHOnTwHuQ5nU9Y2XDcNSY0Z2d2hDCzlqQhElxnt0lWMHCdM5Xj8YLhG/Gvt02ZsjQ
	 H2QG7o77rzF7weuVSVcwCohP50hpM4jeI0X/jbE8sTucOI8vacLjjbZb6LfDQZrQvF
	 s44uAO8q4NgYv5YD8W76eyM++ks7SvH51Mshmbfai8akqeelai+Lq2HG+OMgjeqjzs
	 QWv7sKW0TVJeK8e+qAjnA0G4PeqL7511jU+g7m3hAZHA3+DqAaMDtXDp7bogX/2lG5
	 13TfLzlBAQuTQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dan Williams <dan.j.williams@intel.com>, Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH v4 03/25] powerpc/powernv: Map & release OpenCAPI LPC memory
In-Reply-To: <f763d9d8487e77006b233bc16e0883f956850b6c.camel@kernel.crashing.org>
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-4-alastair@d-silva.org> <CAPcyv4iGEHJpZctEm+Do1-kOZBUDeKKcREr=BqcK4kCvLWhAQQ@mail.gmail.com> <f763d9d8487e77006b233bc16e0883f956850b6c.camel@kernel.crashing.org>
Date: Fri, 03 Apr 2020 15:27:46 +1100
Message-ID: <87v9mhry65.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-ID-Hash: DBG2AAK7TIER62XT6TJBCNEENTS4UOT4
X-Message-ID-Hash: DBG2AAK7TIER62XT6TJBCNEENTS4UOT4
X-MailFrom: mpe@ellerman.id.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Paul Mackerras <paulus@samba.org>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists
 .ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DBG2AAK7TIER62XT6TJBCNEENTS4UOT4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Wed, 2020-04-01 at 01:48 -0700, Dan Williams wrote:
>> > 
>> > +u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size)
>> > +{
>> > +       struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>> > +       struct pnv_phb *phb = hose->private_data;
>> 
>> Is calling the local variable 'hose' instead of 'host' on purpose?
>
> Haha that's funny :-)
>
> It's an oooooooold usage that comes iirc from sparc ? or maybe alpha ?

Yeah it was alpha, I found it in the history tree:

  https://github.com/mpe/linux-fullhistory/blob/1928de59ba4209dc5e9f2cef63560c09ba0df73b/arch/alpha/kernel/mcpcia.c

And airlied found an old manual which confirms it:

  The TIOP module interfaces the AlphaServer 8000 system bus to four I/O channels, called "hoses."

  https://www.hpl.hp.com/hpjournal/dtj/vol7num1/vol7num1art4.pdf


So at least now we know where it comes from.

It's also used widely in mips, microblaze, sh and a little bit in drm.

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
