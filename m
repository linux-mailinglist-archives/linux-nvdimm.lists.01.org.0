Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BF6E44F8
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Oct 2019 09:57:50 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 51EA8100EEBAC;
	Fri, 25 Oct 2019 00:59:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.194; helo=mail-oi1-f194.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 69BFE100EEBA9
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 00:59:02 -0700 (PDT)
Received: by mail-oi1-f194.google.com with SMTP id v138so952799oif.6
        for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 00:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4Obnzy7VbllcsBWAG1yWv4o6m8aHs6PeND33uMddFQ=;
        b=E96J+nYlrzMLsBqjR3odKLTkZ7GVJRtl66zLYJwfVuD2qYB0QCgxEX93K+Sc+AOilX
         l4qFvY2ySyekYG87153LyfATe9U6K+5Ke5w7zE/XCHsI2MxRKl/AR1mletzL/aqmEf2t
         Ujgo94JMexiHulf1lABW3+U0od9LcGJvHXrgOj3ACpK9vHTlVcoleWmWg645+jqg2upi
         ZsrhNQt+dZHkiPUDjhHQHEi94M2nFcqR7+A2VPYW8aQ1TVpGTK4tmdQNUG2OSZDLbwlH
         KTI1iLxlkDpPJdTPjAN0O/sp/KRjaRYRyp0nvUD/A49qQXJ2dvlOFdtwMQ4HMCEJQNmH
         U/Fg==
X-Gm-Message-State: APjAAAWwLoMwjsnqugS9Z1gy+iLeIUezantRwfzEYpoFpjNroSXJw+/5
	xgbrCX2CiJCVqdzx91CrRnhB/xf5E6YgkEmuUr8=
X-Google-Smtp-Source: APXvYqyfnJ+dy4wBkvd4/tg8hxR0xQoQa82GCOzKvlEF+4HiTRrSEXgg68lJoNd3q+IHUF3QAJjVi6QqyPRctI5LUaA=
X-Received: by 2002:a05:6808:3b4:: with SMTP id n20mr1723311oie.131.1571990265293;
 Fri, 25 Oct 2019 00:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com>
In-Reply-To: <20191025044721.16617-1-alastair@au1.ibm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 Oct 2019 09:57:34 +0200
Message-ID: <CAMuHMdUXVy1AYcqquJ2UHdG=2Own=HA3sAGzL_4M+nYd-xh+Dg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add support for OpenCAPI SCM devices
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Message-ID-Hash: IMXQQ6B7BEU2A6R7RBMTZSX2PVO7AXBW
X-Message-ID-Hash: IMXQQ6B7BEU2A6R7RBMTZSX2PVO7AXBW
X-MailFrom: geert.uytterhoeven@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.c
 om>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IMXQQ6B7BEU2A6R7RBMTZSX2PVO7AXBW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Alastair,

On Fri, Oct 25, 2019 at 6:48 AM Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> This series adds support for OpenCAPI SCM devices, exposing
> them as nvdimms so that we can make use of the existing
> infrastructure.

Thanks for your series!

The long CC list is a sign of get_maintainter.pl-considered-harmful.
Please trim it (by removing me, a.o. ;-) for next submission.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
