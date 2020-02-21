Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8C816832D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 17:22:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07E0C10FC3606;
	Fri, 21 Feb 2020 08:22:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7CABD1007B1C2
	for <linux-nvdimm@lists.01.org>; Fri, 21 Feb 2020 08:22:55 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id b3so2496144otp.4
        for <linux-nvdimm@lists.01.org>; Fri, 21 Feb 2020 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UESijwJloetNY8FQMqP4NxBHBgGttqQPvE09CZ9ft1c=;
        b=macUat4OhBw9DARYl7llLCgFZklb66CEJoh9cIMr3g6yESO7cALxWGslA+R7qYKrGs
         fnmKfZrgf4oKCpJCyarWrJ4UiLB6zsowKF7ZaP0X5hmt/PWvNfkyVseLF0OX092PDlNh
         jqCgungkXvg9muNuvc5UtdxiEdiRd0oLyrZ/CRtK1Bzzz9Flyiem04hAk0SnwwqncSRj
         n0Fom0Ouu0dm1sw7gA89tp1HgNtirvu3zy3vksqHoGrMdeXGvWUKxjkOg4Wc2zD/XO1c
         7fzVCJned9Xt5eFtyLaspUTh2m87sc7K+o9d2P0JWiSzZMGN6vItAdbq1RvCK9sWLksv
         9zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UESijwJloetNY8FQMqP4NxBHBgGttqQPvE09CZ9ft1c=;
        b=JAntWNqVL2cQuCmT2MrMLCAVEO8YdKrgrz+4OZZTYTfPfuzK3i6Zm7t51PXlghFXmP
         AsZjLrorhQhqCLjB/ahVVZItv1fUDZA3mFFGjfqTjhsZJaMktGx6iBs+8KJwyrBkZEqT
         YiF3Oyj5CRBbokiUWhDnygDE2u1WYVRLGbjbRRJJFMd5TbFuzl82A1zmGjQJHDt7izq+
         7qWvbzOMqQTpBnw75DxxDGaDOdKZRG/3ADGOq/NxMt/RvOLI9AtLQSZWcPlh2P013a71
         5rShaG+SRpNjgLcPKF4qEpr55YGGD1fzGqbu+LPBv9qrBL1/lY43NIxHtyNLtqUrfKqw
         QxmQ==
X-Gm-Message-State: APjAAAUW437qeeKNAg+U2LtSNowYdqWebIcO2L0yxw54XrKnm0Q2EX9o
	ccGio3V4pxYNXjI54id8v+ULHQj1/4RsBDRhBpw3GQ==
X-Google-Smtp-Source: APXvYqxUQtP3b4zLuYjsw3PWW1Xh6/3l8dvciMnwM+axT86fN3Vik9tAcpduTQUxrlW/YBnslPiYEUOP0aEHD0RypMw=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr6522827otq.126.1582302121655;
 Fri, 21 Feb 2020 08:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com>
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 21 Feb 2020 08:21:50 -0800
Message-ID: <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory devices
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Message-ID-Hash: QIUEWIPTYK5YDHI4IASAMHQIJU3CYH23
X-Message-ID-Hash: QIUEWIPTYK5YDHI4IASAMHQIJU3CYH23
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: alastair@d-silva.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashev
 skiy <aik@ozlabs.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QIUEWIPTYK5YDHI4IASAMHQIJU3CYH23/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 20, 2020 at 7:28 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> This series adds support for OpenCAPI Persistent Memory devices, exposing
> them as nvdimms so that we can make use of the existing infrastructure.

A single sentence to introduce:

24 files changed, 3029 insertions(+), 97 deletions(-)

...is inadequate. What are OpenCAPI Persistent Memory devices? How do
they compare, in terms relevant to libnvdimm, to other persistent
memory devices? What challenges do they pose to the existing enabling?
What is the overall approach taken with this 27 patch break down? What
are the changes since v2, v1? If you incorporated someone's review
feedback note it in the cover letter changelog, if you didn't
incorporate someone's feedback note that too with an explanation.

In short, provide a bridge document for someone familiar with the
upstream infrastructure, but not necessarily steeped in powernv /
OpenCAPI platform details, to get started with this code.

For now, no need to resend the whole series, just reply to this
message with a fleshed out cover letter and then incorporate it going
forward for v4+.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
