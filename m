Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0671C04FF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 20:42:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B6DA10053E20;
	Thu, 30 Apr 2020 11:41:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7FBAF10053E01
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 11:41:22 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 173BD24954
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 18:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588272154;
	bh=R81KA1exG6QyWEvvM1/QecUU8WMGFHG/k/cxKcdkfnc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SKIj3ofhpyqALEnbxq/Qwt9I+q8xqgFA+l6wnFR3a2eTeE5nVt5QfYHFAwjC/y+Ja
	 s8uytIm5fXDttDTtpNCgxSD0+3yT34ulwtIpiC/VwDctbm4BV5uOySFOyHPHNganWE
	 ftAE+TPkYBb4X9BD4lyjCgOpqW23VPFKogllHC+c=
Received: by mail-wr1-f54.google.com with SMTP id d15so8344818wrx.3
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 11:42:34 -0700 (PDT)
X-Gm-Message-State: AGi0Pua5zfTfC08IfLjfIsowZiiAVaEiLv0dLhnKpVuPdzusb+05+fWM
	ds7y3ckkvZ5o6m8HrqP8DuuslKn9/hJLTdtafFXbLw==
X-Google-Smtp-Source: APiQypJgn2E33Ju/7FojR2A+zMnprCF7LbVkAmb0PlfhPmDEYEV5k/ga1+sfxFBZugZk5p4MRnQtkD5+A+c7WwtOQ+E=
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr3902056wrr.70.1588272152368;
 Thu, 30 Apr 2020 11:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com> <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
In-Reply-To: <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 30 Apr 2020 11:42:20 -0700
X-Gmail-Original-Message-ID: <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
Message-ID: <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: ADZEANTRAQ7BOKC2U4ZVKP2RPOIHY3EM
X-Message-ID-Hash: ADZEANTRAQ7BOKC2U4ZVKP2RPOIHY3EM
X-MailFrom: luto@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ADZEANTRAQ7BOKC2U4ZVKP2RPOIHY3EM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 10:17 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Apr 30, 2020 at 9:52 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > If I'm going to copy from memory that might be bad but is at least a
> > valid pointer, I want a function to do this.  If I'm going to copy
> > from memory that might be entirely bogus, that's a different
> > operation.  In other words, if I'm writing e.g. filesystem that is
> > touching get_user_pages()'d persistent memory, I don't want to panic
> > if the memory fails, but I do want at least a very loud warning if I
> > follow a wild pointer.
> >
> > So I think that probe_kernel_copy() is not a valid replacement for
> > memcpy_mcsafe().
>
> Fair enough.
>
> That said, the part I do like about probe_kernel_read/write() is that
> it does indicate which part we think is possibly the one that needs
> more care.
>
> Sure, it _might_ be both sides, but honestly, that's likely the much
> less common case. Kind of like "copy_{to,from}_user()" vs
> "copy_in_user()".
>
> Yes, the "copy_in_user()" case exists, but it's the odd and unusual case.

I suppose there could be a consistent naming like this:

copy_from_user()
copy_to_user()

copy_from_unchecked_kernel_address() [what probe_kernel_read() is]
copy_to_unchecked_kernel_address() [what probe_kernel_write() is]

copy_from_fallible() [from a kernel address that can fail to a kernel
address that can't fail]
copy_to_fallible() [the opposite, but hopefully identical to memcpy() on x86]

copy_from_fallible_to_user()
copy_from_user_to_fallible()

These names are fairly verbose and could probably be improved.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
