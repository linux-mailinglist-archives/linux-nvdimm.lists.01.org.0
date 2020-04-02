Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B9919BAC2
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 05:50:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 70B3D10FC5459;
	Wed,  1 Apr 2020 20:51:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::142; helo=mail-il1-x142.google.com; envelope-from=oohall@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6192910FC5457
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 20:51:05 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j9so2258903ilr.7
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 20:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=un3fCtdFL30YthKT96CUaub/mKOgXUtAMj2aFT/0PG4=;
        b=j1BLyfPilq3TJB3KimcIBBGzUr9NSBHL9CZX0ZLvnEhr10RUE+BzgwAVbkboZvzJbw
         p3BYhlMqx54KQgTKkG5lwMplSjQXdoNkXd6tEJKK3Ow86YPUz9oF50vYJT+DfEqEOxYC
         9orFV88QTGN5X23IO494ia9LQ6tqUZLtLTwAChrveledyaZs21kUVGzJaxM2U41am4FJ
         Yzm4Yffn1e/pPB99dk1RtDx+wheEOC6UxXljP5f2wz0KZBjj7tsaeqI0Zzkl2tGQPABp
         D6g9lryQGxQKow4hC6WDUEqU58ef+Z9XAu/Dw2FHqwgyQtnWJzmpiAtoYyW7fB3tXiP9
         JaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=un3fCtdFL30YthKT96CUaub/mKOgXUtAMj2aFT/0PG4=;
        b=GjHezJmUYAVGrW0t/1y0lcL/JzE5+xewkZ02iussjTgkfKmPV03AntfK5S8kdwGJ23
         p9G78fHQwIyxZUSKJXTaJhGSqLLxodxd1E1q/ZsFjX9H9ZWShDk33lPIlMRgZZ51rRqN
         No9ehe4GJvmnv2+2B9QNnHxus/rsZ7oYHw7jx+HUfzSgua6EJwbOpWsVp5NiJ1wTl7Sy
         1UJF7c3OnqGxzSOJdw1jAxVkR+WXY23en0d6Y7GJ8ou6mbqOr0F8h3ClcivuwFWbDFHo
         yQHmj0GyskvSTdUf34nsKx7LmtfS8YbxKfGwBpMOp5SA5/puhGNNctK1Fmol3kyeFqRZ
         0qrQ==
X-Gm-Message-State: AGi0PuZ+c0IHm0SXDYUQsz/BE2vMWjLvXm/ub9PW60h2nAJKaLPWLZ+H
	ffED+ZZCKmjXXie6qsXrb2YKlcG4iywBemY9Z0g=
X-Google-Smtp-Source: APiQypJyEN+5v6EGwS7GGD77C8TR5iHpI3+yZLJ2qJhUBFcMxf+gIEB07Pj3Y1zyNjFY+2mASs/kfz/PFBneqBUdOvU=
X-Received: by 2002:a92:39cc:: with SMTP id h73mr1225341ilf.298.1585799414632;
 Wed, 01 Apr 2020 20:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org>
 <CAPcyv4iJYZBVhV1NW7EB6-EwETiUAy6r1iiE+F+HvFXfGZt9Aw@mail.gmail.com>
 <2d6901d60877$16aa7a90$43ff6fb0$@d-silva.org> <87imiituxm.fsf@mpe.ellerman.id.au>
In-Reply-To: <87imiituxm.fsf@mpe.ellerman.id.au>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 2 Apr 2020 14:50:03 +1100
Message-ID: <CAOSf1CHdpFyT_6zetKM6eHDK3AT8-UNTzjdd2y+QqYT2AO9VDw@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] Add support for OpenCAPI Persistent Memory devices
To: Michael Ellerman <mpe@ellerman.id.au>
Message-ID-Hash: 7IYNJ2JXXVBFSLALAVMY2WQUBRXWO6SX
X-Message-ID-Hash: 7IYNJ2JXXVBFSLALAVMY2WQUBRXWO6SX
X-MailFrom: oohall@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Alastair D'Silva <alastair@d-silva.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
 , Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7IYNJ2JXXVBFSLALAVMY2WQUBRXWO6SX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 2, 2020 at 2:42 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> "Alastair D'Silva" <alastair@d-silva.org> writes:
> >> -----Original Message-----
> >> From: Dan Williams <dan.j.williams@intel.com>
> >>
> >> On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org>
> >> wrote:
> >> >
> >> > *snip*
> >> Are OPAL calls similar to ACPI DSMs? I.e. methods for the OS to invoke
> >> platform firmware services? What's Skiboot?
> >>
> >
> > Yes, OPAL is the interface to firmware for POWER. Skiboot is the open-source (and only) implementation of OPAL.
>
>   https://github.com/open-power/skiboot
>
> In particular the tokens for calls are defined here:
>
>   https://github.com/open-power/skiboot/blob/master/include/opal-api.h#L220
>
> And you can grep for the token to find the implementation:
>
>   https://github.com/open-power/skiboot/blob/master/hw/npu2-opencapi.c#L2328

I'm not sure I'd encourage anyone to read npu2-opencapi.c. I find it
hard enough to follow even with access to the workbooks.

There's an OPAL call API reference here:
http://open-power.github.io/skiboot/doc/opal-api/index.html

Oliver
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
