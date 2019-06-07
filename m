Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E68AC39355
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 19:34:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D388E21290DE4;
	Fri,  7 Jun 2019 10:34:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 22F56211CED9A
 for <linux-nvdimm@lists.01.org>; Fri,  7 Jun 2019 10:34:48 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id e189so1971848oib.11
 for <linux-nvdimm@lists.01.org>; Fri, 07 Jun 2019 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PQDn4Bg8QjtLfMA6U30U1R3x+u2Sc8pJdpkvrhwxItg=;
 b=TiqYN4ZIeJIcZdyH76CPw/HVLGladFFX1TaVyA8d+bt91TPBoOj+Wl/qYIgyST2If0
 5Q53pA2tQdlIrIXAbCxchjf9ns3sci6CtmdDvUYrvO+YD3Ve5aaBvSMa9VMxmPhN4j3W
 Tn6nVuiG9Y78xQgJXKnl+5bg5ke1pBLB1GlQupAgv6HIX0F0U/aM7XPLV9VOXad4g4Lf
 LMgAgdHX6fzBlIhsSuKFqXCYO1qbZHMxYrPREEUVIDtZdlVAsMCCpwK3xKS/Lk71Awcd
 0pVr2y0nBr1ueHaxoR1TDFfUyDNALDL/sX3kpjnRhqFMhc9LDiPs7+I3miDoeZpWxW9D
 0NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PQDn4Bg8QjtLfMA6U30U1R3x+u2Sc8pJdpkvrhwxItg=;
 b=dp6aiJzfazX6IEgdhnsvHlXbmps29wWMQa4pIDNwiWrZ/WAg1w7aPr5YXLNcp7/SjF
 dY9SKL5wMFGH3IltFOaZzTdqurZafjEeuZ+S9i1wbxOlWKWkL1Oj+XAZ8vMrzS8Pfu9X
 /zqC8XUZWx4KGD0AdwiZL0aDYOcGtNdsmQXAZvGyj6JWnrHpgradsvoy8uwA1D94PizV
 BT7svQOapmTimfSKZUru1H+6uv+/qQtN29Chk/t/KsG5DQWwY+gqmuCGeWXbJkLHg5wq
 H5E+/hntBLg3GdSVr9rqVFiJ9uOuODX9XrxluiaxDeWw9mi9TNv3vEjJtmTgvGS73qTq
 W3rg==
X-Gm-Message-State: APjAAAUvdHvBqb+9gNcgJ+dOH5WgpTLXJCyEAcP3d3NOnlXefgJSe6n9
 K8FVaxtmUOwlwnj8JQYoUOQZcUKMVRu3lSlJMX6kLQ==
X-Google-Smtp-Source: APXvYqwxRH9b7zfmNokXa/MJtvxICynfiQZqc9XkLddgj7G1h1cazph56bWLcewkRjUHU4E05igOxqptPTcARwRwv5E=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr1785826oih.73.1559928887822; 
 Fri, 07 Jun 2019 10:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925718351.3775979.13546720620952434175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu-J3-66V7UhH3=AjN4sX7iydHNF7Fd+SMbezaVNrZQmGQ@mail.gmail.com>
 <CAPcyv4g-GNe2vSYTn0a6ivQYxJdS5khE4AJbcxysoGPsTZwswg@mail.gmail.com>
 <CAKv+Gu83QB6x8=LCaAcR0S65WELC-Y+Voxw6LzaVh4FSV3bxYA@mail.gmail.com>
 <CAPcyv4hXBJBMrqoUr4qG5A3CUVgWzWK6bfBX29JnLCKDC7CiGA@mail.gmail.com>
 <CAKv+Gu_ZYpey0dWYebFgCaziyJ-_x+KbCmOegWqFjwC0U-5QaA@mail.gmail.com>
 <CAPcyv4jO5WhRJ-=Nz70Jc0mCHYBJ6NsHjJNk6AerwQXH43oemw@mail.gmail.com>
In-Reply-To: <CAPcyv4jO5WhRJ-=Nz70Jc0mCHYBJ6NsHjJNk6AerwQXH43oemw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 7 Jun 2019 10:34:36 -0700
Message-ID: <CAPcyv4gzhr57xa2MbR1Jk8EDFw-WLdcw3mJnEX9PeAFwVEZbDA@mail.gmail.com>
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

On Fri, Jun 7, 2019 at 8:23 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 7, 2019 at 5:29 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
[..]
> > > #ifdef CONFIG_EFI_APPLICATION_RESERVED
> > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > {
> > >         return md->type == EFI_CONVENTIONAL_MEMORY
> > >                 && (md->attribute & EFI_MEMORY_SP);
> > > }
> > > #else
> > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > {
> > >         return false;
> > > }
> > > #endif
> >
> > I think this policy decision should not live inside the EFI subsystem.
> > EFI just gives you the memory map, and mangling that information
> > depending on whether you think a certain memory attribute should be
> > ignored is the job of the MM subsystem.
>
> The problem is that we don't have an mm subsystem at the time a
> decision needs to be made. The reservation policy needs to be deployed
> before even memblock has been initialized in order to keep kernel
> allocations out of the reservation. I agree with the sentiment I just
> don't see how to practically achieve an optional "System RAM" vs
> "Application Reserved" routing decision without an early (before
> e820__memblock_setup()) conditional branch.

I can at least move it out of include/linux/efi.h and move it to
arch/x86/include/asm/efi.h since it is an x86 specific policy decision
/ implementation for now.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
