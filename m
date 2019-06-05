Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E66363C4
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Jun 2019 21:07:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 13FD02128DD2A;
	Wed,  5 Jun 2019 12:07:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B9147212735DE
 for <linux-nvdimm@lists.01.org>; Wed,  5 Jun 2019 12:07:01 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d17so1768022oth.5
 for <linux-nvdimm@lists.01.org>; Wed, 05 Jun 2019 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FlGX/Q/ed4YLpiHihy7wKZjWbXQYUcrLzGq5do+X348=;
 b=OLrB/QI7SOZkBoOCJvJu/oZedSJQS+6e3vcQQioJRsL2HLS3UXE0MF5JJ48ujYCrRX
 bpQ26cFMyEZ7PkMmokOgMIfekwWGfuv95Lo22jjqwCYNgzLyN1QIk0rMRi5bGjt8Gp5R
 qRJzS9WVdVCONuYpJM6xmY/eXFoyS1RX02M4Bo+LBmAVGMQuGyN/NlLluu3prOipzIom
 dvlHWW1dhIOlidBLrhzBx5/WpnE4OSyFKbwkwnhxvE4PXqgDoRMTcwsmcS78BxKZ+ayM
 ZcQxNzhm81hrnTIiDhtByguCDXFJr7dt5iOqQJ4GKBUKG+jLpE8qsDxia/YxvotytVs1
 ch4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FlGX/Q/ed4YLpiHihy7wKZjWbXQYUcrLzGq5do+X348=;
 b=ZAUgrn17E0JDzhSiSxQtCtMkd4Np2csfeqqr5vFaKQkh/sQ1fgdIH95U+vsMbDtX/u
 XM/uzCfwp7n8UkCkqJWQh3mGeB2PUfGjNAqAmCyor9huCTFD+48iH4SM2r/XWuzMRMGV
 ZFmi4dkXw70ru1mK8TRcoU977bM3kSY4KJJtqsmh9fmepRP5mjcSAijufFAxhAkA3tvk
 p0B5QCtEZ0X0d5skSa8xj1onUJf2J8SxNkeND3z/4KA5SBKlj1J3KypOxPlwr5pwN0iK
 m8dss94jAXc8CSNup8qubOcYxABQ7FR9ryuyvYb77+dRbzJ+JDSAjGun9cP5VdImwamu
 e0Bg==
X-Gm-Message-State: APjAAAWhLZLgrjaKMeTUxSBDDJf+FXuZX2Iv/jC8QG54yFLrQT+kiwGD
 bHGANz1D5KCg9gDem0f2Zw6jgTxjkJjtGaWImmUA8KfCCck=
X-Google-Smtp-Source: APXvYqzgVMKh9g4W1mu1XQOvy1kR0wNgwQKf4iqlSH2P2xmTbIEaH9QIde+dosL04I1rFqIv0WxNp1FKT990IzXVl+0=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr10453669otk.363.1559761620354; 
 Wed, 05 Jun 2019 12:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925718351.3775979.13546720620952434175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190603054159.GA5747@rapoport-lnx>
In-Reply-To: <20190603054159.GA5747@rapoport-lnx>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 Jun 2019 12:06:49 -0700
Message-ID: <CAPcyv4gAWUPoRK2o-FkpqMbB4559q4O-Fx7niT1vppoRC1VyWA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] x86, efi: Reserve UEFI 2.8 Specific Purpose Memory
 for dax
To: Mike Rapoport <rppt@linux.ibm.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-efi <linux-efi@vger.kernel.org>, kbuild test robot <lkp@intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andy@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sun, Jun 2, 2019 at 10:42 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi Dan,
>
> On Thu, May 30, 2019 at 03:59:43PM -0700, Dan Williams wrote:
> > UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> > interpretation of the EFI Memory Types as "reserved for a special
> > purpose".
> >
> > The proposed Linux behavior for specific purpose memory is that it is
> > reserved for direct-access (device-dax) by default and not available for
> > any kernel usage, not even as an OOM fallback. Later, through udev
> > scripts or another init mechanism, these device-dax claimed ranges can
> > be reconfigured and hot-added to the available System-RAM with a unique
> > node identifier.
> >
> > This patch introduces 3 new concepts at once given the entanglement
> > between early boot enumeration relative to memory that can optionally be
> > reserved from the kernel page allocator by default. The new concepts
> > are:
> >
> > - E820_TYPE_SPECIFIC: Upon detecting the EFI_MEMORY_SP attribute on
> >   EFI_CONVENTIONAL memory, update the E820 map with this new type. Only
> >   perform this classification if the CONFIG_EFI_SPECIFIC_DAX=y policy is
> >   enabled, otherwise treat it as typical ram.
> >
> > - IORES_DESC_APPLICATION_RESERVED: Add a new I/O resource descriptor for
> >   a device driver to search iomem resources for application specific
> >   memory. Teach the iomem code to identify such ranges as "Application
> >   Reserved".
> >
> > - MEMBLOCK_APP_SPECIFIC: Given the memory ranges can fallback to the
> >   traditional System RAM pool the expectation is that they will have
> >   typical SRAT entries. In order to support a policy of device-dax by
> >   default with the option to hotplug later, the numa initialization code
> >   is taught to avoid marking online MEMBLOCK_APP_SPECIFIC regions.
>
> I'd appreciate a more elaborate description how this flag is going to be
> used.

This flag is only there to communicate to the numa code what ranges of
"conventional memory" should be skipped for onlining and reserved for
device-dax to consume. However, now that I say that out loud I realize
I might be able to get away with just using a plain entry
memblock.reserved. I'll take a look.

>
> > A follow-on change integrates parsing of the ACPI HMAT to identify the
> > node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> > now, just identify and reserve memory of this type.
> >
> > Cc: <x86@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Andy Shevchenko <andy@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/x86/Kconfig                  |   20 ++++++++++++++++++++
> >  arch/x86/boot/compressed/eboot.c  |    5 ++++-
> >  arch/x86/boot/compressed/kaslr.c  |    2 +-
> >  arch/x86/include/asm/e820/types.h |    9 +++++++++
> >  arch/x86/kernel/e820.c            |    9 +++++++--
> >  arch/x86/kernel/setup.c           |    1 +
> >  arch/x86/platform/efi/efi.c       |   37 +++++++++++++++++++++++++++++++++----
> >  drivers/acpi/numa.c               |   15 ++++++++++++++-
> >  include/linux/efi.h               |   14 ++++++++++++++
> >  include/linux/ioport.h            |    1 +
> >  include/linux/memblock.h          |    7 +++++++
> >  mm/memblock.c                     |    4 ++++
> >  12 files changed, 115 insertions(+), 9 deletions(-)
>
> ...
>
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 08a5f4a131f5..ddde1c7b1f9a 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -1109,6 +1109,7 @@ void __init setup_arch(char **cmdline_p)
> >
> >       if (efi_enabled(EFI_MEMMAP)) {
> >               efi_fake_memmap();
> > +             efi_find_app_specific();
> >               efi_find_mirror();
> >               efi_esrt_init();
> >
> > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> > index e1cb01a22fa8..899f1305c77a 100644
> > --- a/arch/x86/platform/efi/efi.c
> > +++ b/arch/x86/platform/efi/efi.c
> > @@ -123,10 +123,15 @@ void __init efi_find_mirror(void)
> >   * more than the max 128 entries that can fit in the e820 legacy
> >   * (zeropage) memory map.
> >   */
> > +enum add_efi_mode {
> > +     ADD_EFI_ALL,
> > +     ADD_EFI_APP_SPECIFIC,
> > +};
> >
> > -static void __init do_add_efi_memmap(void)
> > +static void __init do_add_efi_memmap(enum add_efi_mode mode)
> >  {
> >       efi_memory_desc_t *md;
> > +     int add = 0;
> >
> >       for_each_efi_memory_desc(md) {
> >               unsigned long long start = md->phys_addr;
> > @@ -139,7 +144,9 @@ static void __init do_add_efi_memmap(void)
> >               case EFI_BOOT_SERVICES_CODE:
> >               case EFI_BOOT_SERVICES_DATA:
> >               case EFI_CONVENTIONAL_MEMORY:
> > -                     if (md->attribute & EFI_MEMORY_WB)
> > +                     if (is_efi_dax(md))
> > +                             e820_type = E820_TYPE_SPECIFIC;
> > +                     else if (md->attribute & EFI_MEMORY_WB)
> >                               e820_type = E820_TYPE_RAM;
> >                       else
> >                               e820_type = E820_TYPE_RESERVED;
> > @@ -165,9 +172,24 @@ static void __init do_add_efi_memmap(void)
> >                       e820_type = E820_TYPE_RESERVED;
> >                       break;
> >               }
> > +
> > +             if (e820_type == E820_TYPE_SPECIFIC) {
> > +                     memblock_remove(start, size);
> > +                     memblock_add_range(&memblock.reserved, start, size,
> > +                                     MAX_NUMNODES, MEMBLOCK_APP_SPECIFIC);
>
> Why cannot this happen at e820__memblock_setup()?
> Then memblock_remove() call should not be required as nothing will
> memblock_add() the region.

It's only required given the relative call order of efi_fake_memmap()
and the desire to be able to specify EFI_MEMORY_SP on the kernel
command line if the platform BIOS neglects to do it. efi_fake_memmap()
currently occurs after e820__memblock_setup() and my initial attempts
to flip the order resulted in boot failures so there is a subtle
dependency on that order I have not identified.

[..]
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 6bbad46f4d2c..654fecb52ba5 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -982,6 +982,10 @@ static bool should_skip_region(struct memblock_region *m, int nid, int flags)
> >       if ((flags & MEMBLOCK_MIRROR) && !memblock_is_mirror(m))
> >               return true;
> >
> > +     /* if we want specific memory skip non-specific memory regions */
> > +     if ((flags & MEMBLOCK_APP_SPECIFIC) && !memblock_is_app_specific(m))
> > +             return true;
> > +
>
> With this the MEMBLOCK_APP_SPECIFIC won't be skipped for traversals that
> don't set memblock_flags explicitly. Is this the intention?

Yeah as per above it turns out the only real need is to identify it as
reserved, so the flag can likely go away altogether.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
