Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8664518B040
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Mar 2020 10:30:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5928510FC3363;
	Thu, 19 Mar 2020 02:31:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.68; helo=mail-ot1-f68.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D06AA10FC3363
	for <linux-nvdimm@lists.01.org>; Thu, 19 Mar 2020 02:31:20 -0700 (PDT)
Received: by mail-ot1-f68.google.com with SMTP id k26so1677970otr.2
        for <linux-nvdimm@lists.01.org>; Thu, 19 Mar 2020 02:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjLAxS30AF1MgyZCOHu5quIXHYjW+sHIRF2hWQ/EoKY=;
        b=NEZe64HUsVnVv6O6uxIfLbwgogWXKuVAuAAACiVmEDzFmSqty1aDbPFWNhbFmWhC/0
         OTf2OCsu03MZn2otGDZ+Iy62e4GWPbxie7v1uU0HHjbRogYG2HjM6uFUvUfdmvTBXO8T
         95FniCNymL7XkJ427eEz2zXwscZKPRzg+zgax95KPxqRRzBA9F5nf7JiAN74P46C3s2W
         e7qSAMaxOGFxFClc0fHVTBEaBz++LiM1/hu/qxx/bl+lC5xwc/aNem24gukgnSQV+1R1
         XVx78y9xnVLDdP7nDRm0VNntT/9Aj9rvebTyup3ziB5eLwwvn4Gz1pdFWaeKCsGBY8k9
         wBVg==
X-Gm-Message-State: ANhLgQ0lVbpgjk7wWaGBWCgkiOehOsIF5PLNkfooWQ4lydDtTRnDAy3U
	YNvq+QzSVWuC/hF5OLs3+bPdBsXh95ZUjVSRRn8=
X-Google-Smtp-Source: ADFU+vseHcHbrSk7AUUSo3PUXOKqIYKv1JO1U1cQl24IGfaKOG7YOlKaQmPuIeQBQpYXHZhcR4/LlltnnhLNZHLlPN0=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr1419195otm.167.1584610228890;
 Thu, 19 Mar 2020 02:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318760361.2216124.13612198312947463590.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4hjgNruY84Kr9S5HZ6P03fNcPcmL7H2DN19Z+CbPZ7d+Q@mail.gmail.com>
 <CAJZ5v0heWeS1iZqHEZ5RB2a=UJbUQF0zAjeFfTa9qBxvQ193=w@mail.gmail.com> <CAPcyv4hH55e-tm7erJGm_jVn4gWigQfVPSAUu-DBC4XkF+WZHg@mail.gmail.com>
In-Reply-To: <CAPcyv4hH55e-tm7erJGm_jVn4gWigQfVPSAUu-DBC4XkF+WZHg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Mar 2020 10:30:17 +0100
Message-ID: <CAJZ5v0hM7d+B9WgxiFKJS3_C1D_wrvnU8kT+85yFLSc_X+ToNA@mail.gmail.com>
Subject: Re: [PATCH 1/5] ACPI: NUMA: Add 'nohmat' option
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: DCYR2QUEAT56EX3UYIMP5LHHOWRSHATJ
X-Message-ID-Hash: DCYR2QUEAT56EX3UYIMP5LHHOWRSHATJ
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, X86 ML <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DCYR2QUEAT56EX3UYIMP5LHHOWRSHATJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 18, 2020 at 6:39 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Mar 18, 2020 at 1:24 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Mar 18, 2020 at 1:09 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Mon, Mar 2, 2020 at 2:36 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > Disable parsing of the HMAT for debug, to workaround broken platform
> > > > instances, or cases where it is otherwise not wanted.
> > >
> > > Rafael, any heartburn with this change to the numa= option?
> > >
> > > ...as I look at this I realize I failed to also update
> > > Documentation/x86/x86_64/boot-options.rst, will fix.
> >
> > Thanks!
> >
> > Apart from this just a minor nit below.
> >
> > > >
> > > > Cc: x86@kernel.org
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  arch/x86/mm/numa.c       |    4 ++++
> > > >  drivers/acpi/numa/hmat.c |    3 ++-
> > > >  include/acpi/acpi_numa.h |    1 +
> > > >  3 files changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > > index 59ba008504dc..22de2e2610c1 100644
> > > > --- a/arch/x86/mm/numa.c
> > > > +++ b/arch/x86/mm/numa.c
> > > > @@ -44,6 +44,10 @@ static __init int numa_setup(char *opt)
> > > >  #ifdef CONFIG_ACPI_NUMA
> > > >         if (!strncmp(opt, "noacpi", 6))
> > > >                 acpi_numa = -1;
> > > > +#ifdef CONFIG_ACPI_HMAT
> > > > +       if (!strncmp(opt, "nohmat", 6))
> > > > +               hmat_disable = 1;
> > > > +#endif
> >
> > I wonder if IS_ENABLED() would work here?
>
> I took a look. hmat_disable, acpi_numa, and numa_emu_cmdline() are in
> other compilation units. I could wrap writing those variables with
> helper functions, and change numa_emu_cmdline(), to compile away when
> their respective configuration options are not present.
>
> Should we do that in general to have a touch point to report "you
> specified an option that is invalid for your current kernel
> configuration"? I'm happy to do that as a follow-on if you think it's
> worthwhile.

Yes, please.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
