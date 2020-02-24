Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E9169ED1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 07:51:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE55E10FC358D;
	Sun, 23 Feb 2020 22:52:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::144; helo=mail-il1-x144.google.com; envelope-from=oohall@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BAC1510FC358A
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 22:52:37 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id p8so6807080iln.12
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 22:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9K0w7u9UlRucKDFse4Bnnz0TkvNHleyC4BCsa1RzrM=;
        b=r+VFg7nlYKjyz4ZE6FQLUysVX5WdvVgRm6WOY41svQjomwf0VXKN3PmH633+9Q2lI7
         rsia25DTZrqeYZUzqIELM0ZPs9xk9RrR1zjvbYreOc8hFnT5pfTuk8+8G3Z3+v2ZKC0g
         3+Uda6+pEZA47fwhjkuOGRiku+Z0p1HVHFqY54Xx1Th+9vhrJ/qnxiXHBlAOCapn0INg
         RIE2UbkfnEyHpOODwAIrese+8kda1BNJDaAH9nXkUn/5vKE97Jm60mZbshpHsb7scDjj
         jyhU99uHJmzK+BJhulAarPgiDvpWVdszTMddDibKFZjPLLrV/FmHpUdCY0G0wQkUeVCh
         oz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9K0w7u9UlRucKDFse4Bnnz0TkvNHleyC4BCsa1RzrM=;
        b=tVszXLBPXf0XMwIqp7g17NdXtbMTcili5jPGv/A0j0ZWBwx8lfDHxq2/CF9iJiKWAs
         L5h+n7jWcWoHSd/kI/w6hem+WAGkPeJu+0K7IgBP+xreO913LpZPtXW9cnQLFqA4GwmY
         ZTg+JfAZkTo3QqbNFAIyK3W1twmRXsjWLu4hgAjOzMS4lXgj6P7WQPE+EuBNrQFNzS/K
         WFSawAm1X0qbLO7LTrJkMFHXy7bW7sbn9eZikqSqy9jf/hFGEZkgbtJMafQflBnWgba/
         A86JFeh+1VsvaOCNkJxDxrzDSgXc6Sy4EnoZhyRsTDH2gLF0SasuCnszLogkm/swOQ35
         OvnQ==
X-Gm-Message-State: APjAAAXxTr1D/oG2gm9tOt8RlcFeaz5CeC23iSC6nmDna+oWVR4GiiMT
	MIIGzkG1PfKxiGM2TS6a+SsOsPrHn/DbFTKZVcE=
X-Google-Smtp-Source: APXvYqx+mUK6hh9BaSPGa0Msc1oHfQvPgztYvcYPrv+S9n6RraKbcSZyrnA+OcHji1IbgLT+tKjr35qmWcvjk1TYbOw=
X-Received: by 2002:a92:d7c1:: with SMTP id g1mr59552764ilq.192.1582527104859;
 Sun, 23 Feb 2020 22:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
 <240fbefc6275ac0a6f2aa68715b3b73b0e7a8310.camel@au1.ibm.com>
 <20200224043750.GM24185@bombadil.infradead.org> <83034494d5c3da1fa63b172e844f85d0fec7910a.camel@au1.ibm.com>
In-Reply-To: <83034494d5c3da1fa63b172e844f85d0fec7910a.camel@au1.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Mon, 24 Feb 2020 17:51:33 +1100
Message-ID: <CAOSf1CHYEJf02EV0kYMk+D9s=4PiTXSM1eFcRGYe7XJrHvtAtA@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory devices
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Message-ID-Hash: B3UBUVNH6XEKQYDDCYBUVXCZ2A4MZHXC
X-Message-ID-Hash: B3UBUVNH6XEKQYDDCYBUVXCZ2A4MZHXC
X-MailFrom: oohall@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B3UBUVNH6XEKQYDDCYBUVXCZ2A4MZHXC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 24, 2020 at 3:43 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> On Sun, 2020-02-23 at 20:37 -0800, Matthew Wilcox wrote:
> > On Mon, Feb 24, 2020 at 03:34:07PM +1100, Alastair D'Silva wrote:
> > > V3:
> > >   - Rebase against next/next-20200220
> > >   - Move driver to arch/powerpc/platforms/powernv, we now expect
> > > this
> > >     driver to go upstream via the powerpc tree
> >
> > That's rather the opposite direction of normal; mostly drivers live
> > under
> > drivers/ and not in arch/.  It's easier for drivers to get overlooked
> > when doing tree-wide changes if they're hiding.
>
> This is true, however, given that it was not all that desirable to have
> it under drivers/nvdimm, it's sister driver (for the same hardware) is
> also under arch, and that we don't expect this driver to be used on any
> platform other than powernv, we think this was the most reasonable
> place to put it.

Historically powernv specific platform drivers go in their respective
subsystem trees rather than in arch/ and I'd prefer we kept it that
way. When I added the papr_scm driver I put it in the pseries platform
directory because most of the pseries paravirt code lives there for
some reason; I don't know why. Luckily for me that followed the same
model that Dan used when he put the NFIT driver in drivers/acpi/ and
the libnvdimm core in drivers/nvdimm/ so we didn't have anything to
argue about. However, as Matthew pointed out, it is at odds with how
most subsystems operate. Is there any particular reason we're doing
things this way or should we think about moving libnvdimm users to
drivers/nvdimm/?

Oliver
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
