Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFFD4EFCE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Jun 2019 22:06:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E8CD2129F117;
	Fri, 21 Jun 2019 13:06:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CABF82128A64D
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 13:06:51 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 43so2664185otf.8
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wuEmwyEDkLTTGNEaPaNn66uye06m7pMKJtU3WQzLuW4=;
 b=yfbm0c70FRxPQvT9ttNxjjuYHrLEhwZtbnY9goMK/0Gx78N5J7QrZtLuREOupTptR5
 Q6lMBj1OahoCaUeB5vb1WpR4k3yMCiTX9SiElfshDMd+oBYiR1iPaQpsP3rMRLV+fSfm
 oj5j9y4v4Mg8Pe4WYVpkvn6QZ9nFF4tNNmw85cboZbNy52Hu9yzqSZDa8Jvf30gP6dUz
 JQ0KfefwxJcxn6gxZ7nWCvnoUnPVLI04pktSbH5XZ1iNtk6tTUJzw9EBK2RHX7rELfXD
 jI5SVdxRvya4HhOWrk1C1ZpVxSQVBFjWZ3gh2npuCk2Bn4G3E8FRKUDJN6SxlHpBOMm6
 FRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wuEmwyEDkLTTGNEaPaNn66uye06m7pMKJtU3WQzLuW4=;
 b=B66TmWT/xPymx2u+UE6owTDVXl6BfitjnRZ6Sy8o/mD5y3Wexu58TOq7ZmXuYLLn6k
 ZVqSD9XBQyDq4q79V4OCJk7PxLbmk2jTkS/hFtNahOn/YqBtPPURFYMQ8J6oAJoXn0pQ
 d9x1F3S/WpADicxEHQtRJLjqoJdzCuISJtostbQbFWI/njuS60PT1njLhc/Rt5b4kH8g
 bi1H1OTpbg4IGIitTGuA4f1VBZ30nzia7fKBtRmfKDaaFN9NUyybOl48l7165JLUSEKv
 IxWTY5nC5i1VchRjfp8PZ46vEEhKIiEv4CN9R+RX5ITcdj2ygRays5ksVSYMJjulFtvc
 Qncg==
X-Gm-Message-State: APjAAAWuiSTELRKvUIxtGwkGyV8ENPkrTovH3GbDOh5wCSGnbffb99hC
 CTeCvNxooroeo760Mk3/vZ1JPV34+K+ileTvpt4z6Q==
X-Google-Smtp-Source: APXvYqyQOOqbJLjW2BcOmlG77qXX9/WsYin5lYao1Mf2DKSbEZ6q1C3Ab3BvZSOCGLndw9OyPK8hja1kJE7joCwf+Qo=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr1671387otk.363.1561147610028; 
 Fri, 21 Jun 2019 13:06:50 -0700 (PDT)
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
Date: Fri, 21 Jun 2019 13:06:38 -0700
Message-ID: <CAPcyv4hB7EbxkcDGc1j2vXwFcX5rHOYtRZcRa7Q36CVrAk1w+g@mail.gmail.com>
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

The decision on whether / if to take any action on this hint is
implementation specific, so I argue it does not belong in the EFI
core. The spec does not mandate any action as it's just a hint.
Instead x86 is making a policy decision in how it translates it to the
x86-specific E820 representation. So, I as I go to release v3 of this
patch set I do not see an argument to move the
is_efi_application_reserved() definition out of
arch/x86/include/asm/efi.h it's 100% tied to the e820 translation.

Now, if some other EFI supporting architecture wanted to follow the
x86 policy we could move it it to a shared location, but that's
something for a follow-on patch set.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
