Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D81ED7FF
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Nov 2019 04:12:07 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 66BA6100EA520;
	Sun,  3 Nov 2019 19:14:59 -0800 (PST)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=210.131.2.82; helo=conssluserg-03.nifty.com; envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN> 
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3CFF9100EA63E
	for <linux-nvdimm@lists.01.org>; Sun,  3 Nov 2019 19:14:56 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
	by conssluserg-03.nifty.com with ESMTP id xA43BhGB010058
	for <linux-nvdimm@lists.01.org>; Mon, 4 Nov 2019 12:11:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xA43BhGB010058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1572837103;
	bh=vMxuYwRHws4tNFRGpfPUy5dZwjFqOGxlu03uplhO42I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bllT6wAYcQvHAnXftO20d2k8LR0rwzuLOFlRzWlzn3UwX2BQxfWA7TlHRRbdsJz/T
	 u3gz0HN+navs80R3Wt64OHlN6KWtKB8XO7/sxf0RP9iIYgGA3gUKtbwyjDKlqOXoMf
	 APr/o3Zr3Y6PVGf+lXrTKwqrslL7XrBKazrs4+3KKi5TFOfCj/0FtHHlItiu2n7Kqf
	 W7e/KUBZm0r5zAj1UHGP8vqt4dGaZJ6/AyogYUXuSiq3sm+Hq8oxrn4sqpBQXnEKbZ
	 JknZGSdRdjzxsS55MbX6H6CoWTgZE6Y1xf/jVpYfLdG7TJt6x8beF3+cvSc1jOUDza
	 s0AXehi9h8y4g==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id k11so1852945ual.10
        for <linux-nvdimm@lists.01.org>; Sun, 03 Nov 2019 19:11:43 -0800 (PST)
X-Gm-Message-State: APjAAAU4drX0aquUJA1heTl2kxiOOXbu8+JMld+w0wwA6Na9q/pGzKD5
	V8s/bqdUMPI5seW/1AAbgAsWN4uGYNbYy5OOEYE=
X-Google-Smtp-Source: APXvYqyE0nGV98neToXAe5hLXzbDObfhFlg/QKkxKcBsziWl3jP01hIXqHPwXSYx8xzJ5vABi98f/kqIE5zvSf0Ea7U=
X-Received: by 2002:ab0:3395:: with SMTP id y21mr3558264uap.25.1572837102044;
 Sun, 03 Nov 2019 19:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20191003102915.28301-1-yamada.masahiro@socionext.com>
 <20191003102915.28301-4-yamada.masahiro@socionext.com> <x497e4kluxq.fsf@segfault.boston.devel.redhat.com>
 <CAK7LNASmpO6Dn2M1DtoCDs=RM+jwW7_tRhq7nqDU1YZWdRafuw@mail.gmail.com> <x494kznctuc.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x494kznctuc.fsf@segfault.boston.devel.redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 4 Nov 2019 12:11:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQnaBCkRCsRPjK9m6wLaDvTsgkiFgMEiObnfuncxOHZOg@mail.gmail.com>
Message-ID: <CAK7LNAQnaBCkRCsRPjK9m6wLaDvTsgkiFgMEiObnfuncxOHZOg@mail.gmail.com>
Subject: Re: [PATCH 4/4] modpost: do not set ->preloaded for symbols from Module.symvers
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: RSG3ESESGHDCUHL4XNLX2QTJ4PBEKLOM
X-Message-ID-Hash: RSG3ESESGHDCUHL4XNLX2QTJ4PBEKLOM
X-MailFrom: yamada.masahiro@socionext.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RSG3ESESGHDCUHL4XNLX2QTJ4PBEKLOM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Nov 2, 2019 at 3:52 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>
> > On Fri, Nov 1, 2019 at 1:51 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >>
> >> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> >>
> >> > Now that there is no overwrap between symbols from ELF files and
> >> > ones from Module.symvers.
> >> >
> >> > So, the 'exported twice' warning should be reported irrespective
> >> > of where the symbol in question came from. Only the exceptional case
> >> > is when __crc_<sym> symbol appears before __ksymtab_<sym>. This
> >> > typically occurs for EXPORT_SYMBOL in .S files.
> >>
> >> Hi, Masahiro,
> >>
> >> After apply this patch, I get the following modpost warnings when doing:
> >>
> >> $ make M=tools/tesing/nvdimm
> >> ...
> >>   Building modules, stage 2.
> >>   MODPOST 12 modules
> >> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_lock' exported
> >> twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> >> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_unlock'
> >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> >> WARNING: tools/testing/nvdimm/libnvdimm: 'is_nvdimm_bus_locked'
> >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> >> WARNING: tools/testing/nvdimm/libnvdimm: 'devm_nvdimm_memremap'
> >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> >> WARNING: tools/testing/nvdimm/libnvdimm: 'nd_fletcher64' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> >> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nd_desc' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> >> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nvdimm_bus_dev'
> >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> >> ...
> >>
> >> There are a lot of these warnings.  :)
> >
> > These warnings are correct since
> > drivers/nvdimm/Makefile and
> > tools/testing/nvdimm/Kbuild
> > compile the same files.
>
> Yeah, but that's by design.  Is there a way to silence these warnings?
>
> -Jeff
>

"rm -f Module.symvers; make M=tools/testing/nvdimm" ?

I'd like the _design_ fixed though.


-- 
Best Regards
Masahiro Yamada
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
