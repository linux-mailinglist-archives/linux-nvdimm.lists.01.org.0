Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B93A056
	for <lists+linux-nvdimm@lfdr.de>; Sat,  8 Jun 2019 16:54:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6EC6321295B18;
	Sat,  8 Jun 2019 07:54:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7EA1121295B11
 for <linux-nvdimm@lists.01.org>; Sat,  8 Jun 2019 07:54:00 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id p4so1332181oti.0
 for <linux-nvdimm@lists.01.org>; Sat, 08 Jun 2019 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dk+u3XgaNOqXLaO68gyf05VnI7PTjpPeX2V5LZFBkJU=;
 b=c7Pg+1Vu+CFzwWjTCMqA/7ILEjKHUJlK9K7TIBu56QFBG34LHWLdVkM7tbREx2Ey9p
 TjCdQdfntrBDULEZ7N1HSxQg0s3DwVikz29ifn2VjQqccdLcAJ1KkySuifbxWyME5a7W
 x4fOaxhygkWdkKYvJVh0JgypnwprJM5FHpdLFWTbR4b8W25GIpRqLlOkF/ugyfihZC+8
 c7LrVjq4p2Hw1E72Dp2p511CMIYJdbrwSfhhEtnq2nr9rqDPBQg5MRZOyX6pvij6xYTr
 nGmNhnS25l7cTno9P3Fo7izT+xPDuhI3LIcqoKUC7iNIdx3UljQ5OPalTto1Tp8OepSr
 0zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dk+u3XgaNOqXLaO68gyf05VnI7PTjpPeX2V5LZFBkJU=;
 b=joVdFMlU/hs+jEf8ROGlMjmPKZFgXRLFdhrxJ7weQYdGhYJ1u3Gymd23Ibcxc3oqgF
 cEauwAGnaXQxYo0DRPWwB6p/sz7yKuGt5b4lf9CoGXliy8sC/uMMI9jE0DaHrmoislTy
 NStANUOjzAc7BAkeplj32h6HqRSQB2p7Jo83CGPN0+1BkAQp66bgmnx1V7BE7geosWfU
 ASipXtDJ3VEkt67bHowbm/SNM7DT0ffn3GnUFfUqcCyhRGkHokUkoXzki2aznfAYDdMV
 7sBQiJY/0slXE6148/aILfrNgNeMkwOt88m2LfFMbnmfKTmaAqY5w6hE4G+TYK/1AzbU
 VTHw==
X-Gm-Message-State: APjAAAWuVHjpgEjQSikA7E2arXSkIQDgyD4qj6uPYARFBoh+J7S2mXnJ
 KtE8Kehn2Le/kdAPmsV0lW4wHQuL3SndMJkXRWK9Sw==
X-Google-Smtp-Source: APXvYqypLm2j/J6SB8ZKAlfeHzcCYKwyThpmhhnmxpvXXR1jOg6wN0waBPRAcYcxiyvBbMj8vJDm0b8GB8DJsrFdTLI=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr8130580otf.126.1560005639908; 
 Sat, 08 Jun 2019 07:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925718351.3775979.13546720620952434175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu-J3-66V7UhH3=AjN4sX7iydHNF7Fd+SMbezaVNrZQmGQ@mail.gmail.com>
 <CAPcyv4g-GNe2vSYTn0a6ivQYxJdS5khE4AJbcxysoGPsTZwswg@mail.gmail.com>
 <CAKv+Gu83QB6x8=LCaAcR0S65WELC-Y+Voxw6LzaVh4FSV3bxYA@mail.gmail.com>
 <CAPcyv4hXBJBMrqoUr4qG5A3CUVgWzWK6bfBX29JnLCKDC7CiGA@mail.gmail.com>
 <CAKv+Gu_ZYpey0dWYebFgCaziyJ-_x+KbCmOegWqFjwC0U-5QaA@mail.gmail.com>
 <CAPcyv4jO5WhRJ-=Nz70Jc0mCHYBJ6NsHjJNk6AerwQXH43oemw@mail.gmail.com>
 <CAPcyv4gzhr57xa2MbR1Jk8EDFw-WLdcw3mJnEX9PeAFwVEZbDA@mail.gmail.com>
 <CAKv+Gu_OcsWi5DqxOk-j6ovc0CMAZV37Od7zA5Bs4Ng5ATQxAA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_OcsWi5DqxOk-j6ovc0CMAZV37Od7zA5Bs4Ng5ATQxAA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 8 Jun 2019 07:53:49 -0700
Message-ID: <CAPcyv4i_ZaKKT2dHQTuHCWT9HhqCOm4kpy2YdK952GubwqbJDQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] x86, efi: Reserve UEFI 2.8 Specific Purpose Memory
 for dax
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mike Rapoport <rppt@linux.ibm.com>, Linux-MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sat, Jun 8, 2019 at 12:20 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 7 Jun 2019 at 19:34, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jun 7, 2019 at 8:23 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, Jun 7, 2019 at 5:29 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > [..]
> > > > > #ifdef CONFIG_EFI_APPLICATION_RESERVED
> > > > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > > > {
> > > > >         return md->type == EFI_CONVENTIONAL_MEMORY
> > > > >                 && (md->attribute & EFI_MEMORY_SP);
> > > > > }
> > > > > #else
> > > > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > > > {
> > > > >         return false;
> > > > > }
> > > > > #endif
> > > >
> > > > I think this policy decision should not live inside the EFI subsystem.
> > > > EFI just gives you the memory map, and mangling that information
> > > > depending on whether you think a certain memory attribute should be
> > > > ignored is the job of the MM subsystem.
> > >
> > > The problem is that we don't have an mm subsystem at the time a
> > > decision needs to be made. The reservation policy needs to be deployed
> > > before even memblock has been initialized in order to keep kernel
> > > allocations out of the reservation. I agree with the sentiment I just
> > > don't see how to practically achieve an optional "System RAM" vs
> > > "Application Reserved" routing decision without an early (before
> > > e820__memblock_setup()) conditional branch.
> >
> > I can at least move it out of include/linux/efi.h and move it to
> > arch/x86/include/asm/efi.h since it is an x86 specific policy decision
> > / implementation for now.
>
> No, that doesn't make sense to me. If it must live in the EFI
> subsystem, I'd prefer it to be in the core code, not in x86 specific
> code, since there is nothing x86 specific about it.

Ok, but it's still not clear to me where you would accept an early
detection of EFI_CONVENTIONAL_MEMORY + EFI_MEMORY_SP and route it away
from the "System RAM" default. Please just recommend a place to land a
conditional branch that translates between the base EFI type +
attribute and E820_RAM and E820_APPLICATION_RESERVED.

> Perhaps a efi=xxx command line option would be in order to influence
> the builtin default, but it can be a followup patch independent of
> this series.

Sure, but I expect the default polarity of the branch is a compile
time option with an efi= override.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
