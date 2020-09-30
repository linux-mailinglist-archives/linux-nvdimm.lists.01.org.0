Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820FB27EEA7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 18:13:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D70015198642;
	Wed, 30 Sep 2020 09:13:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 493511519863E
	for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 09:13:21 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z23so3608595ejr.13
        for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B68i/03gO6ZR0stPp/XuIiWcgy0nxB559p48BCd6ARw=;
        b=PX1/Et52kin9Rxfq1UxAKtvLAZw8XEYjLfAunQK4XuD4V0feOzB3QEYw7v7ThbU3Mt
         mAiv2K0rHxn933lpLwwCB0wtsyk/Vkj9iawLQ63G7s/YSV5r1kqfzoqoJBOpyjemnwbR
         jPkFIZ+aCNen9BaOql/Q6UkMrcE1yeclcDXqo4pRtnReCRRV2KjdXlMJ2qcMYBn88j4a
         hn54Pujx2xVaIZJ/7UDT4TJHflGOZyAVNefQWpY1GlZxlpT9OsE4bf8lH2/2XnHpOhIz
         +oIvhB3mmC5yUm2M66+DuI52zIT9WH0bnVRAKm3+NziWfY9j9ACgASesmoLq29qnztc+
         DZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B68i/03gO6ZR0stPp/XuIiWcgy0nxB559p48BCd6ARw=;
        b=l2AotiS4BuPknzE52NrpWaoOmuqPLz0AciJLn4bUB01g51GnZgDT4jYukIuoHj1NR9
         zsSPvoP4YRH+4JQTD2RTZ5LHWnOMEpCxJoL+4q3USAh1qlPE0kO2rpKBLtEMkSoD4Xzd
         F2Iw92foJFdi0bfyLsqkzUewsMWydHa636o2QYXAYQtsedNGlNVQBvXZnyRp8Pcz3+8K
         XOhEoAOZFtWdEZau4CzSRxcxl6ikZcNwZr353ryRachHUwbO2MWL2s2ZI228F604IXqt
         YK6MYN0lcmr40a/jD/o8ep3igyStP+wAauvhlqo3EuM28Q28L+HleZ/FwNPz1bspMeS5
         eYpA==
X-Gm-Message-State: AOAM532AvV2q43KwXYz1I5giD0mJKLYqmtFJ34xJlOvkLvYm5SIaLGN7
	1vB4Th/oAnpRC5uiwTzDnv/7opWqHko8jEWFmNbkKA==
X-Google-Smtp-Source: ABdhPJxdHnKyHDYoMQeMMwxf000I8c4hJxQEZEzPq5LxM9cPBizoMqr58gmvU91MpkM9iwpTHzULwq9SHDscdiTmefI=
X-Received: by 2002:a17:906:8143:: with SMTP id z3mr3481181ejw.323.1601482399413;
 Wed, 30 Sep 2020 09:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <160087928642.3520.17063139768910633998.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160087929294.3520.12013578778066801369.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200929102512.GB21110@zn.tnic>
In-Reply-To: <20200929102512.GB21110@zn.tnic>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 30 Sep 2020 09:13:07 -0700
Message-ID: <CAPcyv4jUYP3sWUUfL53Z6M7SpzXrrTTuzY8_EeN4O4bDVeL1EQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] x86, powerpc: Rename memcpy_mcsafe() to
 copy_mc_to_{user, kernel}()
To: Borislav Petkov <bp@alien8.de>
Message-ID-Hash: 4XKYRJPZUNFLOSUX7DDY2JGZOSUENB7A
X-Message-ID-Hash: 4XKYRJPZUNFLOSUX7DDY2JGZOSUENB7A
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Mikulas Patocka <mpatocka@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnaldo Carvalho de Melo <acme@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4XKYRJPZUNFLOSUX7DDY2JGZOSUENB7A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 29, 2020 at 3:25 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 23, 2020 at 09:41:33AM -0700, Dan Williams wrote:
> > The rename replaces a single top-level memcpy_mcsafe() with either
> > copy_mc_to_user(), or copy_mc_to_kernel().
>
> What is "copy_mc" supposed to mean? Especially if it is called that on
> two arches...
>
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 7101ac64bb20..e876b3a087f9 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -75,7 +75,7 @@ config X86
> >       select ARCH_HAS_PTE_DEVMAP              if X86_64
> >       select ARCH_HAS_PTE_SPECIAL
> >       select ARCH_HAS_UACCESS_FLUSHCACHE      if X86_64
> > -     select ARCH_HAS_UACCESS_MCSAFE          if X86_64 && X86_MCE
> > +     select ARCH_HAS_COPY_MC                 if X86_64
>
> X86_MCE is dropped here. So if I have a build which has
>
> # CONFIG_X86_MCE is not set
>
> One of those quirks like:
>
>         /*
>          * CAPID0{7:6} indicate whether this is an advanced RAS SKU
>          * CAPID5{8:5} indicate that various NVDIMM usage modes are
>          * enabled, so memory machine check recovery is also enabled.
>          */
>         if ((capid0 & 0xc0) == 0xc0 || (capid5 & 0x1e0))
>                 enable_copy_mc_fragile();
>
> will still call enable_copy_mc_fragile() and none of those platforms
> need MCE functionality?
>
> But there's a hunk in here which sets it in the MCE code:
>
>         if (mca_cfg.recovery)
>                 enable_copy_mc_fragile();
>
> So which is it? They need it or they don't?
>
> The comment over copy_mc_to_kernel() says:
>
>  * Call into the 'fragile' version on systems that have trouble
>  * actually do machine check recovery
>
> If CONFIG_X86_MCE is not set, I'll say. :)

True, without CONFIG_X86_MCE there's no point in attempting the
fragile copy because the #MC will go unhandled. At the same time the
point of the new copy_mc_generic() is that it is suitable to use
without CONFIG_X86_MCE as it's just a typical fast string copy
instrumented for exception handling. So, I still think
CONFIG_ARCH_HAS_COPY_MC is independent of CONFIG_X86_MCE, but
enable_copy_mc_fragile() should be stubbed out by CONFIG_X86_MCE=n,
will re-spin.

>
> > +++ b/arch/x86/lib/copy_mc.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2016-2020 Intel Corporation. All rights reserved. */
> > +
> > +#include <linux/jump_label.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/export.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +
> > +static DEFINE_STATIC_KEY_FALSE(copy_mc_fragile_key);
> > +
> > +void enable_copy_mc_fragile(void)
> > +{
> > +     static_branch_inc(&copy_mc_fragile_key);
> > +}
> > +
> > +/**
> > + * copy_mc_to_kernel - memory copy that that handles source exceptions
>
> One "that" is enough.

Yup.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
