Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 382AAEBB9C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 Nov 2019 02:14:22 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 784B1100DC40D;
	Thu, 31 Oct 2019 18:14:44 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=210.131.2.91; helo=conssluserg-06.nifty.com; envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN> 
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C024E100DC40B
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 18:14:41 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
	by conssluserg-06.nifty.com with ESMTP id xA11Dmb6029374
	for <linux-nvdimm@lists.01.org>; Fri, 1 Nov 2019 10:13:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xA11Dmb6029374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1572570829;
	bh=gq2ntcwWwPmJbX6KujZPFJEqb9x4csC/Cehv9Nngo0w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bzq9d8FJodYz9vCF76NW7o+SZ/rPK0s7Th0OZWmA6N+1dAxUQJNuK52yFbN90VdQI
	 uwVbIzRLJbdSy8oE9Hggm7lFTAxl8PEX7a+E1OGUjan7Sy7ROOzI1vDX3KVe3jSGMT
	 f+wAPPDA4utqcaXdKya1zM8aYI9OGyNgzU5V0WCRYHY8aAqZJhQ3PEPsHpjC47vWvz
	 niGHFm3AdBGfgvV0a3DmfQZa6Frnz7RzwLCf15jU9f8TipjC7jHmlEaTEt/rQbdmPb
	 jQDH8jWeRym1XSfBcEunMaj+4d0Maot3Ryespos1dGFoFgGaktyocly3JDDun6yaox
	 ymNSbd+pGr8Zg==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id f21so2491497uan.3
        for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 18:13:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWWYrES/Mo6nJVhHtZAG4qPDA1NP2V9zdAMsA+n6RcM5jhB4Ule
	1S9NGQAbZV+z3JJViFvdpCj/qXESrMwb4EDaoBE=
X-Google-Smtp-Source: APXvYqw/PajTAhDXPdOfLwuMzSOHJNtlGhOENV4a2oNhQQR/ci6cU5z+to6L/NH38vwTMbUIwFxp8YSFIT2xqMloz1E=
X-Received: by 2002:ab0:279a:: with SMTP id t26mr779257uap.40.1572570827659;
 Thu, 31 Oct 2019 18:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191003102915.28301-1-yamada.masahiro@socionext.com>
 <20191003102915.28301-4-yamada.masahiro@socionext.com> <x497e4kluxq.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x497e4kluxq.fsf@segfault.boston.devel.redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 1 Nov 2019 10:13:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmpO6Dn2M1DtoCDs=RM+jwW7_tRhq7nqDU1YZWdRafuw@mail.gmail.com>
Message-ID: <CAK7LNASmpO6Dn2M1DtoCDs=RM+jwW7_tRhq7nqDU1YZWdRafuw@mail.gmail.com>
Subject: Re: [PATCH 4/4] modpost: do not set ->preloaded for symbols from Module.symvers
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: AWZ4RZI4QXGT6OO3X6PD4Q3UBSFZDER5
X-Message-ID-Hash: AWZ4RZI4QXGT6OO3X6PD4Q3UBSFZDER5
X-MailFrom: yamada.masahiro@socionext.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AWZ4RZI4QXGT6OO3X6PD4Q3UBSFZDER5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 1, 2019 at 1:51 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>
> > Now that there is no overwrap between symbols from ELF files and
> > ones from Module.symvers.
> >
> > So, the 'exported twice' warning should be reported irrespective
> > of where the symbol in question came from. Only the exceptional case
> > is when __crc_<sym> symbol appears before __ksymtab_<sym>. This
> > typically occurs for EXPORT_SYMBOL in .S files.
>
> Hi, Masahiro,
>
> After apply this patch, I get the following modpost warnings when doing:
>
> $ make M=tools/tesing/nvdimm
> ...
>   Building modules, stage 2.
>   MODPOST 12 modules
> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_lock' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_unlock' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> WARNING: tools/testing/nvdimm/libnvdimm: 'is_nvdimm_bus_locked' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> WARNING: tools/testing/nvdimm/libnvdimm: 'devm_nvdimm_memremap' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> WARNING: tools/testing/nvdimm/libnvdimm: 'nd_fletcher64' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nd_desc' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nvdimm_bus_dev' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> ...
>
> There are a lot of these warnings.  :)

These warnings are correct since
drivers/nvdimm/Makefile and
tools/testing/nvdimm/Kbuild
compile the same files.




>  If I revert this patch, no
> complaints.
>
> Cheers,
> Jeff
>
>
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  scripts/mod/modpost.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 5234555cf550..6ca38d10efc5 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -2457,7 +2457,6 @@ static void read_dump(const char *fname, unsigned int kernel)
> >               s = sym_add_exported(symname, namespace, mod,
> >                                    export_no(export));
> >               s->kernel    = kernel;
> > -             s->preloaded = 1;
> >               s->is_static = 0;
> >               sym_update_crc(symname, mod, crc, export_no(export));
> >       }
>


-- 
Best Regards
Masahiro Yamada
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
