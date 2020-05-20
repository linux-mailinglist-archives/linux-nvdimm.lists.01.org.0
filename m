Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 689F91DC1AD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 May 2020 23:57:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB78111F57BC1;
	Wed, 20 May 2020 14:53:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4055311F57BBD
	for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 14:53:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e2so6153793eje.13
        for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 14:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqzpEer//XK22yZ98UAKJ7MBv4zHdPVVNRSVLrhFals=;
        b=bVbiMveqZaJY6CN61D/3eT0a0iz5G1ujKdeEmUSKkRjV2bpnmoSyhakW3LkMb3d/wG
         rBCrI4FJVb+MTYbejV8E8DGHLXjuswp3fnUkO35cz048PT0R8KhQ31fVJttmcYjq1s6L
         yPm7e5J4AQRs/GM4B+6Ih4xAq3nQfXSp39/Rf2lYy7eHb4qMNOW0JGoHLrDoqiM50bUH
         TmPMK672nDpVm6Yv3ye3RC6w3VEn7Rxmktgoj5N6vyrMrQ0Ct4UJAumuf67tTJmQDLFi
         1+6yeAvIEVcSJMPt2aL/FYjwqElRcXBwYU/X5XwN/GwpFSLs05yEF7K2TA1ms4Kj+3xs
         Vj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqzpEer//XK22yZ98UAKJ7MBv4zHdPVVNRSVLrhFals=;
        b=El0QWat5wsRA7ci2UEOGORDfuwVvVOMP1qKz3s+xgK2HxTJ5K4YfTzax/utSHTRl2I
         Jx/J5pgGjg1Y1+nfjEIwZ8KyNMqop+H2yYYcVMG0o0Nrjk+S3Y8JwdFsB19ljA0kKkaX
         1OxdIax+abggogzXr6a8gqWL6lxKYmIhm7nXmunjPO2JEyrTufdV7P6DhGuP/WX1hHBA
         StV53LgtK+WgEhaDmJn98YHW8EbdW94b98+uZeaOkhsea/3XQYZ4I/3GPClElHWQMaoW
         5yWbycK6ImRHLGbvg7GEgCnKlEE3b21Ljlu8qft2KO4ytCY96ueHTrGYqRfltc+dsCva
         5Tzg==
X-Gm-Message-State: AOAM530an/WgE887TIO/6P/Epjb5SWKBRdbQGQyNLC9+JBxNmkGDrKfy
	9hDTEKQTswcjkuBLp15PecmE/KybtReBGEVhzljfQQ==
X-Google-Smtp-Source: ABdhPJyEtJIRy5zvU/Ue+wi49BTEkeLMMKxvFOmL5yCA0qbl0BCCkHFWunjp2ymm5wjf5KNjuojO1Gsyky3jk1f9Z3k=
X-Received: by 2002:a17:906:a8d:: with SMTP id y13mr963076ejf.455.1590011834056;
 Wed, 20 May 2020 14:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <158992635164.403910.2616621400995359522.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158992636214.403910.12184670538732959406.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200520191320.GA3255@redhat.com>
In-Reply-To: <20200520191320.GA3255@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 May 2020 14:57:02 -0700
Message-ID: <CAPcyv4jPZny8uraVtO8gMfs8W9EJWfgSAo1zOnwqe2VBSLgaDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/copy_mc: Introduce copy_mc_generic()
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: ZEZ76YN6PFC5P6BXTA3ZCW62KQXSXH7Q
X-Message-ID-Hash: ZEZ76YN6PFC5P6BXTA3ZCW62KQXSXH7Q
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZEZ76YN6PFC5P6BXTA3ZCW62KQXSXH7Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 20, 2020 at 12:13 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, May 19, 2020 at 03:12:42PM -0700, Dan Williams wrote:
> > The original copy_mc_fragile() implementation had negative performance
> > implications since it did not use the fast-string instruction sequence
> > to perform copies. For this reason copy_mc_to_kernel() fell back to
> > plain memcpy() to preserve performance on platform that did not indicate
> > the capability to recover from machine check exceptions. However, that
> > capability detection was not architectural and now that some platforms
> > can recover from fast-string consumption of memory errors the memcpy()
> > fallback now causes these more capable platforms to fail.
> >
> > Introduce copy_mc_generic() as the fast default implementation of
> > copy_mc_to_kernel() and finalize the transition of copy_mc_fragile() to
> > be a platform quirk to indicate 'fragility'. With this in place
> > copy_mc_to_kernel() is fast and recovery-ready by default regardless of
> > hardware capability.
> >
> > Thanks to Vivek for identifying that copy_user_generic() is not suitable
> > as the copy_mc_to_user() backend since the #MC handler explicitly checks
> > ex_has_fault_handler().
>
> /me is curious to know why #MC handler mandates use of _ASM_EXTABLE_FAULT().

Even though we could try to handle all faults / exceptions
generically, I think it makes sense to enforce type safety here if
only to support architectures that can only satisfy the minimum
contract of copy_mc_to_user(). For example, if there was some
destination exception other than #PF the contract implied by
copy_mc_to_user() is that exception is not intended to be permissible
in this path. See:

00c42373d397 x86-64: add warning for non-canonical user access address
dereferences
75045f77f7a7 x86/extable: Introduce _ASM_EXTABLE_UA for uaccess fixups

...for examples of other justification for being explicit in these paths.

>
> [..]
> > +/*
> > + * copy_mc_generic - memory copy with exception handling
> > + *
> > + * Fast string copy + fault / exception handling. If the CPU does
> > + * support machine check exception recovery, but does not support
> > + * recovering from fast-string exceptions then this CPU needs to be
> > + * added to the copy_mc_fragile_key set of quirks. Otherwise, absent any
> > + * machine check recovery support this version should be no slower than
> > + * standard memcpy.
> > + */
> > +SYM_FUNC_START(copy_mc_generic)
> > +     ALTERNATIVE "jmp copy_mc_fragile", "", X86_FEATURE_ERMS
> > +     movq %rdi, %rax
> > +     movq %rdx, %rcx
> > +.L_copy:
> > +     rep movsb
> > +     /* Copy successful. Return zero */
> > +     xorl %eax, %eax
> > +     ret
> > +SYM_FUNC_END(copy_mc_generic)
> > +EXPORT_SYMBOL_GPL(copy_mc_generic)
> > +
> > +     .section .fixup, "ax"
> > +.E_copy:
> > +     /*
> > +      * On fault %rcx is updated such that the copy instruction could
> > +      * optionally be restarted at the fault position, i.e. it
> > +      * contains 'bytes remaining'. A non-zero return indicates error
> > +      * to copy_safe() users, or indicate short transfers to
>
> copy_safe() is vestige of terminology of previous patches?

Thanks, yes, I missed this one.

>
> > +      * user-copy routines.
> > +      */
> > +     movq %rcx, %rax
> > +     ret
> > +
> > +     .previous
> > +
> > +     _ASM_EXTABLE_FAULT(.L_copy, .E_copy)
>
> A question for my education purposes.
>
> So copy_mc_generic() can handle MCE both on source and destination
> addresses? (Assuming some device can generate MCE on stores too).

There's no such thing as #MC on write. #MC is only signaled on consumed poison.

In this case what is specifically being handled is #MC with RIP
pointing at a movq instruction. The fault handler actually does not
know anything about source or destination, it just knows fault /
exception type and the register state.

> On the other hand copy_mc_fragile() handles MCE recovery only on
> source and non-MCE recovery on destination.

No, there's no difference in capability. #MC can only be raised on a
poison-read in both cases.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
