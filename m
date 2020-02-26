Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDBE16F45A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Feb 2020 01:32:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D896A10FC36D3;
	Tue, 25 Feb 2020 16:33:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83AE810FC36D2
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 16:33:35 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id h9so1310373otj.11
        for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 16:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f70455Z6ta/EJCB61dHVpdnNh4osTmAbssLK2ZDouI8=;
        b=1rFC1q7eiqEoo/Ct8CLTc8uB6k3LoZ19oRJxA++l0zQgLc/UuThtXzQMgIWfj0sABp
         Tu/rBPamdN1eVJvSLzs32HeQA4BVe2YUCQ1Tn2metD9qEWM0OzwmfiMBaESZbeWmVueY
         31XvzUzGzkYQ+M5LGVFUZzc+9QGaHPlVPsaxO62G1PTIwMacG1h2AXJ7RsfUhr9pAPYS
         pAFjp6krJgYzuaxPTz+vUaSvelbdMaNAu5U4sM+5GFJ8T583/KnVxZ7l59pGq8Zx1N55
         /0KS/3htbv5/xl4ByvCEOahacZfCCi1uloIgUD+0kK2IgnIpjShkvcodpT/EheCpFi3J
         eEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f70455Z6ta/EJCB61dHVpdnNh4osTmAbssLK2ZDouI8=;
        b=IPJNAQOKtqIfaCR8jAFyvfzEuChs6VhKUeDL48zKQCEvP8ct31m+rmNEo1Tx1zTwkD
         AoOusIcUeXbEe5UCUOobwMWt580h0NK9bpcu+YY2kgsLV5UU8bF5hAYQwjOjMYrNZ312
         rGKR/+2ngkZIOSkVrJakkLHMr0k9t+nLDj2br9Ii2ndOnY14cb1kBSFt5teoAjX22Qx0
         9nrmHaYA/vTREZgFDvBKPDHvg7hYoOJvfUiYPEnkHGKXyYZv1bNFCJg9/mkB9yDpjVjY
         0/pEJnCQEIrxWSVXNzChQ5Fyw4AQVlS+zQab2L4+sYrVL0WVrtFMKDfYOCQHwv+OPooV
         z5Lw==
X-Gm-Message-State: APjAAAXVh0tUOdZAhZ7Zmevd+0V7qTfKNDsTq0NZcM5mMozY7EEEwaQY
	A1iyZOuwOAIhYwpKe8zJeu2RgmNAVC3+RI/iTDbkcA==
X-Google-Smtp-Source: APXvYqyAsJnZlWJOpclJB6h8LyKxIkm6H51Qk8MIk/UhPC9KtK1RQif8usKO+skdYm0o9lQhxq1Hc5Wd2TvdmbQAZxU=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr886741otl.71.1582677162325;
 Tue, 25 Feb 2020 16:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
 <240fbefc6275ac0a6f2aa68715b3b73b0e7a8310.camel@au1.ibm.com>
 <20200224043750.GM24185@bombadil.infradead.org> <83034494d5c3da1fa63b172e844f85d0fec7910a.camel@au1.ibm.com>
 <CAOSf1CHYEJf02EV0kYMk+D9s=4PiTXSM1eFcRGYe7XJrHvtAtA@mail.gmail.com> <b981f4e6cc308a617e7944e3ce23009e804cfdbf.camel@au1.ibm.com>
In-Reply-To: <b981f4e6cc308a617e7944e3ce23009e804cfdbf.camel@au1.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 25 Feb 2020 16:32:31 -0800
Message-ID: <CAPcyv4g_762vho=L21BuO=97zr9Cq14np88bnFieiYN25BvJtA@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory devices
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Message-ID-Hash: TCEF47D57JSMNT7NNS4Z7ZAVAHHGY2PA
X-Message-ID-Hash: TCEF47D57JSMNT7NNS4Z7ZAVAHHGY2PA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TCEF47D57JSMNT7NNS4Z7ZAVAHHGY2PA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 25, 2020 at 4:14 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> On Mon, 2020-02-24 at 17:51 +1100, Oliver O'Halloran wrote:
> > On Mon, Feb 24, 2020 at 3:43 PM Alastair D'Silva <
> > alastair@au1.ibm.com> wrote:
> > > On Sun, 2020-02-23 at 20:37 -0800, Matthew Wilcox wrote:
> > > > On Mon, Feb 24, 2020 at 03:34:07PM +1100, Alastair D'Silva wrote:
> > > > > V3:
> > > > >   - Rebase against next/next-20200220
> > > > >   - Move driver to arch/powerpc/platforms/powernv, we now
> > > > > expect
> > > > > this
> > > > >     driver to go upstream via the powerpc tree
> > > >
> > > > That's rather the opposite direction of normal; mostly drivers
> > > > live
> > > > under
> > > > drivers/ and not in arch/.  It's easier for drivers to get
> > > > overlooked
> > > > when doing tree-wide changes if they're hiding.
> > >
> > > This is true, however, given that it was not all that desirable to
> > > have
> > > it under drivers/nvdimm, it's sister driver (for the same hardware)
> > > is
> > > also under arch, and that we don't expect this driver to be used on
> > > any
> > > platform other than powernv, we think this was the most reasonable
> > > place to put it.
> >
> > Historically powernv specific platform drivers go in their respective
> > subsystem trees rather than in arch/ and I'd prefer we kept it that
> > way. When I added the papr_scm driver I put it in the pseries
> > platform
> > directory because most of the pseries paravirt code lives there for
> > some reason; I don't know why. Luckily for me that followed the same
> > model that Dan used when he put the NFIT driver in drivers/acpi/ and
> > the libnvdimm core in drivers/nvdimm/ so we didn't have anything to
> > argue about. However, as Matthew pointed out, it is at odds with how
> > most subsystems operate. Is there any particular reason we're doing
> > things this way or should we think about moving libnvdimm users to
> > drivers/nvdimm/?
> >
> > Oliver
>
>
> I'm not too fussed where it ends up, as long as it ends up somewhere :)
>
> From what I can tell, the issue is that we have both "infrastructure"
> drivers, and end-device drivers. To me, it feels like drivers/nvdimm
> should contain both, and I think this feels like the right approach.
>
> I could move it back to drivers/nvdimm/ocxl, but I felt that it was
> only tolerated there, not desired. This could be cleared up with a
> response from Dan Williams, and if it is indeed dersired, this is my
> preferred location.

Apologies if I gave the impression it was only tolerated. I'm ok with
drivers/nvdimm/ocxl/, and to the larger point I'd also be ok with a
drivers/{acpi => nvdimm}/nfit and {arch/powerpc/platforms/pseries =>
drivers/nvdimm}/papr_scm.c move as well to keep all the consumers of
the nvdimm related code together with the core.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
