Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF9A1896DB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Mar 2020 09:24:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0547310FC3627;
	Wed, 18 Mar 2020 01:25:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.66; helo=mail-ot1-f66.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6DFDC10FC33E4
	for <linux-nvdimm@lists.01.org>; Wed, 18 Mar 2020 01:25:03 -0700 (PDT)
Received: by mail-ot1-f66.google.com with SMTP id a6so24530363otb.10
        for <linux-nvdimm@lists.01.org>; Wed, 18 Mar 2020 01:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQ0AIpy6289Hs4+0vUajVZqxzUHEdUAVpK8eg8j+VHE=;
        b=pTT6kCviiVfUbYFnnRpRVXWwKCGr4pksAraNy1aE0+KDXTWVqcAp4heJkXzLT4VuXn
         dv4H5jwi1U5WZddPcZ3zt7Kz31HZVmM2zmTuLpBiZYPgk2PSrFz1egieYboM3FMuHBtn
         o1FQJy3coW9Hmn9JvrQeVh5io8zuwsgX1bkFtrWbBbenobYLUOIdegoY4MpMEgkFuUFl
         jGnK8160plXuuAzACQMcpThPe32eJjsM2dX23WQhuausoPIXaaJLODJk/S/zYt6sI/L2
         0pEKZlhtPMDxbNyxERKS3ZOWmHqm8E7v2VwMPazh7AXx1ssYwwPmdp3KO7SpjcBqmXSq
         c4FQ==
X-Gm-Message-State: ANhLgQ2luiVYTsuPb3SVWXii0UcWkn1linRMHO0f4sUy7S1Xl1EOuQdC
	0SPge4iaCl92MdhfKMl9iyxhU+/HpDBqHjludzo=
X-Google-Smtp-Source: ADFU+vtDUu/ENup+aXfCBKJZoHwE4fbxddOCHcfz5Gp/eR5kvQBbgkz/udoMueN3CldSwYbzXoAKDhG5hexnUlr09kY=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr2678697otm.167.1584519851446;
 Wed, 18 Mar 2020 01:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318760361.2216124.13612198312947463590.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4hjgNruY84Kr9S5HZ6P03fNcPcmL7H2DN19Z+CbPZ7d+Q@mail.gmail.com>
In-Reply-To: <CAPcyv4hjgNruY84Kr9S5HZ6P03fNcPcmL7H2DN19Z+CbPZ7d+Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Mar 2020 09:24:00 +0100
Message-ID: <CAJZ5v0heWeS1iZqHEZ5RB2a=UJbUQF0zAjeFfTa9qBxvQ193=w@mail.gmail.com>
Subject: Re: [PATCH 1/5] ACPI: NUMA: Add 'nohmat' option
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 7OMRALFU4YA6CVCAT6UPHR3VMCEG2AZZ
X-Message-ID-Hash: 7OMRALFU4YA6CVCAT6UPHR3VMCEG2AZZ
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux ACPI <linux-acpi@vger.kernel.org>, X86 ML <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7OMRALFU4YA6CVCAT6UPHR3VMCEG2AZZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 18, 2020 at 1:09 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Mar 2, 2020 at 2:36 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Disable parsing of the HMAT for debug, to workaround broken platform
> > instances, or cases where it is otherwise not wanted.
>
> Rafael, any heartburn with this change to the numa= option?
>
> ...as I look at this I realize I failed to also update
> Documentation/x86/x86_64/boot-options.rst, will fix.

Thanks!

Apart from this just a minor nit below.

> >
> > Cc: x86@kernel.org
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/x86/mm/numa.c       |    4 ++++
> >  drivers/acpi/numa/hmat.c |    3 ++-
> >  include/acpi/acpi_numa.h |    1 +
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 59ba008504dc..22de2e2610c1 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -44,6 +44,10 @@ static __init int numa_setup(char *opt)
> >  #ifdef CONFIG_ACPI_NUMA
> >         if (!strncmp(opt, "noacpi", 6))
> >                 acpi_numa = -1;
> > +#ifdef CONFIG_ACPI_HMAT
> > +       if (!strncmp(opt, "nohmat", 6))
> > +               hmat_disable = 1;
> > +#endif

I wonder if IS_ENABLED() would work here?

> >  #endif
> >         return 0;
> >  }
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index 2c32cfb72370..d3db121e393a 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/sysfs.h>
> >
> >  static u8 hmat_revision;
> > +int hmat_disable __initdata;
> >
> >  static LIST_HEAD(targets);
> >  static LIST_HEAD(initiators);
> > @@ -814,7 +815,7 @@ static __init int hmat_init(void)
> >         enum acpi_hmat_type i;
> >         acpi_status status;
> >
> > -       if (srat_disabled())
> > +       if (srat_disabled() || hmat_disable)
> >                 return 0;
> >
> >         status = acpi_get_table(ACPI_SIG_SRAT, 0, &tbl);
> > diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> > index fdebcfc6c8df..48ca468e9b61 100644
> > --- a/include/acpi/acpi_numa.h
> > +++ b/include/acpi/acpi_numa.h
> > @@ -18,6 +18,7 @@ extern int node_to_pxm(int);
> >  extern int acpi_map_pxm_to_node(int);
> >  extern unsigned char acpi_srat_revision;
> >  extern int acpi_numa __initdata;
> > +extern int hmat_disable __initdata;
> >
> >  extern void bad_srat(void);
> >  extern int srat_disabled(void);
> >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
