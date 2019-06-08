Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1343D39B81
	for <lists+linux-nvdimm@lfdr.de>; Sat,  8 Jun 2019 09:20:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DD3D821295B11;
	Sat,  8 Jun 2019 00:20:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 40D58212777BF
 for <linux-nvdimm@lists.01.org>; Sat,  8 Jun 2019 00:20:26 -0700 (PDT)
Received: by mail-it1-x142.google.com with SMTP id m3so6137337itl.1
 for <linux-nvdimm@lists.01.org>; Sat, 08 Jun 2019 00:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NRFU6E8aoY/NG8zu/5ScI8y9YPKuPdWK6EZGoPFt9Ck=;
 b=NDyg19KRBwWKCsuIiFvg9iRfAOK0BFmH02/xvBLHZXW8TjkcbUXa07UNeCGFNRcVSQ
 8RbFmVpFH1UV2N+/j05HX8NIJQJMtjsgEKFE86KKcUhlfShKCx8Iz8dbQ9Vsx6tckJ5T
 rS+m/g1NYezNDmc1RO4A3Sgo+UodJa8hGFvDUEImNfqv0n+QszCBKoGTKvUhISzRtwkA
 Xb1wAh6WTP39KnlTRX4OirLbaYKQbvdRLkSl+jZyYeOtzDdqjdwK37E0w6E6cb4CmU/O
 DCw//CheJdpE6T4DkIGFn5i6qQUWUaZYBqkDJxVbCvsO0AZmxviK0yDSf2JLaX3ABS1p
 82Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NRFU6E8aoY/NG8zu/5ScI8y9YPKuPdWK6EZGoPFt9Ck=;
 b=cJ5qGsKPVCtD+yAQMH8fYC5+g4Bj6Ag2AlREc/ySB8QYso5/Jznu3vMUXYH1E3NE48
 djkDCVWjeCYC8oPbF65MRUeC2dlGj918AHFfr+ihLzAyou2QFuMy0QxwzeWAXZPOLYsM
 fcskkpoTzOY/UegsKU5FzepchLkTdW9VOmxJ/10hACZ659pxDk4NN8sSc0fsrCERBX3v
 8DzUe3LYZXFMK+A2nDszb3QBLTd+Fa38zEENI75Mx7+ZEXvtAMabG45FO5mwu9TLdlGz
 xYocWQlteMcvbBCBIzPyqQr+Cz0P6yAPe79hGx3wV/cLwmIlgsbuTT4MUljeKYwvoG0Q
 2bBw==
X-Gm-Message-State: APjAAAXzt0q6B9OnHrizKBQgZiPMTnYxNrX/5uqlpHTatnb4SU9P74DA
 poP9lcpXF6bTynAGX42ySYsPweU9UYztsCqWuHYfqA==
X-Google-Smtp-Source: APXvYqwnMZ8z1ON6onK6aLjM8baTZPCff6UnkQu1+3vja3H65nm9+6f6XC126h9UoGCw6NSPIu5HIfQvokO9SnkaUhk=
X-Received: by 2002:a24:4f88:: with SMTP id c130mr6512194itb.104.1559978425951; 
 Sat, 08 Jun 2019 00:20:25 -0700 (PDT)
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
In-Reply-To: <CAPcyv4gzhr57xa2MbR1Jk8EDFw-WLdcw3mJnEX9PeAFwVEZbDA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 8 Jun 2019 09:20:13 +0200
Message-ID: <CAKv+Gu_OcsWi5DqxOk-j6ovc0CMAZV37Od7zA5Bs4Ng5ATQxAA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] x86, efi: Reserve UEFI 2.8 Specific Purpose Memory
 for dax
To: Dan Williams <dan.j.williams@intel.com>
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

On Fri, 7 Jun 2019 at 19:34, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 7, 2019 at 8:23 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jun 7, 2019 at 5:29 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> [..]
> > > > #ifdef CONFIG_EFI_APPLICATION_RESERVED
> > > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > > {
> > > >         return md->type == EFI_CONVENTIONAL_MEMORY
> > > >                 && (md->attribute & EFI_MEMORY_SP);
> > > > }
> > > > #else
> > > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > > {
> > > >         return false;
> > > > }
> > > > #endif
> > >
> > > I think this policy decision should not live inside the EFI subsystem.
> > > EFI just gives you the memory map, and mangling that information
> > > depending on whether you think a certain memory attribute should be
> > > ignored is the job of the MM subsystem.
> >
> > The problem is that we don't have an mm subsystem at the time a
> > decision needs to be made. The reservation policy needs to be deployed
> > before even memblock has been initialized in order to keep kernel
> > allocations out of the reservation. I agree with the sentiment I just
> > don't see how to practically achieve an optional "System RAM" vs
> > "Application Reserved" routing decision without an early (before
> > e820__memblock_setup()) conditional branch.
>
> I can at least move it out of include/linux/efi.h and move it to
> arch/x86/include/asm/efi.h since it is an x86 specific policy decision
> / implementation for now.

No, that doesn't make sense to me. If it must live in the EFI
subsystem, I'd prefer it to be in the core code, not in x86 specific
code, since there is nothing x86 specific about it.

Perhaps a efi=xxx command line option would be in order to influence
the builtin default, but it can be a followup patch independent of
this series.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
