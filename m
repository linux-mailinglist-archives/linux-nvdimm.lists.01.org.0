Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2276E235371
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Aug 2020 18:37:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 81A281292B902;
	Sat,  1 Aug 2020 09:37:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 857131292B8F5
	for <linux-nvdimm@lists.01.org>; Sat,  1 Aug 2020 09:37:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so19642758ejb.4
        for <linux-nvdimm@lists.01.org>; Sat, 01 Aug 2020 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7nWoFZS16KHN7ELInZM3NkAqbsw8HmgfQtV5PkaAdOs=;
        b=sLJ2YymDgCE2aYqkgcFgGI6naddEomHT1AI/LblO1I2CIpKzR/X4HC0D8kFfsN6b+L
         XCYiypkgq9U/ws9p617+waX57F8r3r9xw2IEJINKnzTBI1kuSBY9ijEvHwlcNtuSjqeZ
         Hc2tgLSldiumX+1XnZPsDgJMdf1x61SK6XNyMc3TiFxkjVUQDHk06pK8LV6TXULby89E
         Q+sc+6B4I8vfJLc3o9x4Nzoa4qysw9eANsa9JKWVrWyM3DFMjubaz5YpI0uzS2O4ob16
         LSXsaZKRopTp92npa1jce/IFsU1kV5YolRnKSOBrqMK/vKjOiSQ1Nztp40qAyj1R/fd9
         WV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nWoFZS16KHN7ELInZM3NkAqbsw8HmgfQtV5PkaAdOs=;
        b=Qrj2ddSTzSbWktbeSkewY/dYADhLCx6w4AY3oi33LwJZDyAXR+B25mpzFAmUgxr/yi
         cM7WEqR48hpVVag5DhuMXCa4Z4+fXKWbQ1cBwsrOwJsQnGhuG+eFA9mivfxm94+mDRtm
         9aOFiT4xH5DzTBQi+/reKDj8eJ2W+gV6mD9p4893IT8ElKmdjRY43PsYeXvBO9Kp7PvL
         pKaITohocpJjuwOiollfVqw7IyuAPqVqWBAMMx3UbsQOwk9ERhZ4MqFlOdHGRIyEdx9c
         pVepU6PcIC61JF/zd29X+H0mua8rzOtWYp1cerYSG0OsivJQKm4pnLiT1Zcm1F/TxRyX
         3ecw==
X-Gm-Message-State: AOAM531lNtEdSvQJ00PRL1s2LNFxoHav3d3KfY8RXGyVhFavcfMB37b8
	tqGLOlsssGyBkj/IzqNYgyXkaFr1IEA6tx8kA7i+1A==
X-Google-Smtp-Source: ABdhPJxOFGsY8qnjWmioIMQMzSoQMpAmcXHTZevYKI2hHLGadP9/WqNGAW9biPUhi7/KRXBONqPTrbpeIRc4H0g10M8=
X-Received: by 2002:a17:907:72c8:: with SMTP id du8mr9038155ejc.237.1596299819131;
 Sat, 01 Aug 2020 09:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159625231266.3040297.2759117253481288037.stgit@dwillia2-desk3.amr.corp.intel.com>
 <545078f8-d6d3-5db7-02f6-648218513752@infradead.org>
In-Reply-To: <545078f8-d6d3-5db7-02f6-648218513752@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 1 Aug 2020 09:36:48 -0700
Message-ID: <CAPcyv4iUtQ1Edau5e7GQumu1MxcAvorSNwnw9HGhzFDNuBS7=Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/23] x86/numa: Add 'nohmat' option
To: Randy Dunlap <rdunlap@infradead.org>
Message-ID-Hash: 2XZF3L33GWACN5ILYMQJYNU4JAUFEACS
X-Message-ID-Hash: 2XZF3L33GWACN5ILYMQJYNU4JAUFEACS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Joao Martins <joao.m.martins@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2XZF3L33GWACN5ILYMQJYNU4JAUFEACS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 31, 2020 at 8:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 7/31/20 8:25 PM, Dan Williams wrote:
> > Disable parsing of the HMAT for debug, to workaround broken platform
> > instances, or cases where it is otherwise not wanted.
> >
> > ---
> >  arch/x86/mm/numa.c       |    2 ++
> >  drivers/acpi/numa/hmat.c |    8 +++++++-
> >  include/acpi/acpi_numa.h |    8 ++++++++
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 87c52822cc44..f3805bbaa784 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -41,6 +41,8 @@ static __init int numa_setup(char *opt)
> >               return numa_emu_cmdline(opt + 5);
> >       if (!strncmp(opt, "noacpi", 6))
> >               disable_srat();
> > +     if (!strncmp(opt, "nohmat", 6))
> > +             disable_hmat();
>
> Hopefully that will be documented in
> Documentation/x86/x86_64/boot-options.rst.

Sorry, yes, you gave that feedback before. I can do a quick respin
with this and the kbuild-robot compile fixups.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
