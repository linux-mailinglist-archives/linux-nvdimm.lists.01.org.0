Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930961B12FE
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 19:28:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 788A510106329;
	Mon, 20 Apr 2020 10:28:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::244; helo=mail-lj1-x244.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 30AF31010631A
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 10:28:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so10882369ljp.9
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IpmTQOayCD1Il3q30iPH6dEUv0PiLxNc2sXawwla/vE=;
        b=cXn3mltz8qorrEfyE5y8hVv9238WfQDrBvoOtyFkveWMr/VgNd23+A0MesJO6OFCV6
         ekBgPWm67RrpmalcOyyI3Lfn/4D8gPsmxyLQQLtBSaECUBbJAREMKbBzRetnjAo+dwFd
         BWGwQIPm49gqAKYyUDjg0Eqhoie/KGQ8r/37o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpmTQOayCD1Il3q30iPH6dEUv0PiLxNc2sXawwla/vE=;
        b=Q1cOT3wMSAXsEkbJgsMlJPvg4NeDcTAjDZ6eomlvnfYsdzmmGD/KJhNYr4iDV8nxQK
         R6hFo084e6rQ8KMvtIU0RNL0EvGI662igOR/nN1SIz1dtfgSC4FVRLFztWd2nthpRMEN
         zrIZERV+1CryKoKjwyOfwdblVIHATsZblF2n06V1t7ePlU3p27slhhaz9YyVRS7Zu3az
         2XlbyxBCxanRwBdhARhdC4LL7Uxz3w5Kil9fNo1ZKO3aFHwe/Q+laM7JdwEfr5roVncX
         S2+aYtRG9DNLrxxgshTiXa6PACyLU/+C9A6/Thsbawt4ijA1Gxmko3W8+PyfFNt85eps
         psWw==
X-Gm-Message-State: AGi0Pub2OpRBsz5LEW6MNcJ9QbYbVKsynf284q4eyVGqLFR8j6rI35Du
	GHCp8C3r0+KHc/D+XrXa3vy0Qdy8mg4=
X-Google-Smtp-Source: APiQypI66BWQQZGysJH+bSso9CT4WDa9K02m1ZKmywkHabrRmayGW8T48gdZxWMc2bmaTuPbEQJiDQ==
X-Received: by 2002:a2e:700e:: with SMTP id l14mr2221319ljc.135.1587403722956;
        Mon, 20 Apr 2020 10:28:42 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id p8sm58170ljn.93.2020.04.20.10.28.41
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 10:28:41 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id x23so8678209lfq.1
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 10:28:41 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr10953490lfk.192.1587403720981;
 Mon, 20 Apr 2020 10:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com> <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
In-Reply-To: <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Apr 2020 10:28:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
Message-ID: <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: AE3SPTNZHTFS2LYTAEXDMLOUM6ZZSTRV
X-Message-ID-Hash: AE3SPTNZHTFS2LYTAEXDMLOUM6ZZSTRV
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AE3SPTNZHTFS2LYTAEXDMLOUM6ZZSTRV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Apr 19, 2020 at 10:08 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Do we have examples of doing exception handling from C? I thought all
> the exception handling copy routines were assembly routines?

You need assembler for the actual access, but that's a _single_
instruction - best done as inline asm.

The best example of something that does *exactly* what you want to do is likely

        unsafe_get_user();
        unsafe_put_user();

which basically turns into a single instruction with exception
handling, with the exception hander jumping directly to an error
label.

Ok, so right now gcc can't do that for inline asm with outputs, so it
generates fairly nasty code (a secondary register with the error state
that then causes a conditional branch on it), but that's a compiler
limitation that will eventually go away (where "eventially" means that
it already works in LLVM with experimental patches).

You could literally mis-use those helpers as-is (please don't - the
code generation is correct, but at the very least we'd have to
re-organize a bit to make it a better interface, ie have an
alternative name like "unsafe_get_kernel()" for kernel pointer
accesses).

You'd have to do the alignment guarantees yourself, but there are
examples of that in this area too (strnlen_user() does exactly that -
aligned word accesses).

So the point here is that the current interfaces are garbage, _if_ the
whole "access a single value" is actually performance-critical.

And if that is *not* the case, then the best thing to do is likely to
just use a static call. No inlining of single instructions at all,
just always use a function call, and then pick the function
appropriately.

Honestly, I can't imagine that the "single access" case is so
timing-critical that the static call isn't the right model. Your use
case is _not_ as important or common as doing user accesses.

Finally, the big question is whether the completely broken hardware
even matters. Are there actual customers that actually use the garbage
"we can crash the machine" stuff?

Because when it comes to things like nvdimms etc, the _primary_
performance target would be getting the kernel entirely out of the
way, and allowing databases etc to just access the damn thing
directly.

And if you allow user space to access it directly, then you just have
to admit that it's not a software issue any more - it's the hardware
that is terminally broken and unusable garbage. It's not even
interesting to work around things in the kernel, because user space
can just crash the machine directly.

This is why I absolutely detest that thing so much. The hardware is
_so_ fundamentally broken that I have always considered the kernel
workarounds to basically be "staging" level stuff - good enough for
some random testing of known-broken stuff, but not something that
anybody sane should ever use.

So my preference would actually be to just call the broken cases to be
largely ignored, at least from a performance angle. If you can only
access it through the kernel, the biggest performance limitation is
that you cannot do any DAX-like thing at all safely, so then the
performance of some kernel accessors is completely secondary and
meaningless. When a kernel entry/exit takes a few thousand cycles on
the broken hardware (due to _other_ bugs), what's the point about
worrying about trying to inline some single access to the nvdimm?

Did the broken hardware ever spread out into the general public?
Because if not, then the proper thing to do might be to just make it a
compile-time option for the (few) customers that signed up for testing
the initial broken stuff, and make the way _forward_ be a clean model
without the need to worry about any exceptions at all.

> The writes can mmu-fault now that memcpy_mcsafe() is also used by
> _copy_to_iter_mcsafe(). This allows a clean bypass of the block layer
> in fs/dax.c in addition to the pmem driver access of poisoned memory.
> Now that the fallback is a sane rep; movs; it can be considered for
> plain copy_to_iter() for other user copies so you get exception
> handling on kernel access of poison outside of persistent memory. To
> Andy's point I think a recoverable copy (for exceptions or faults) is
> generally useful.

I think that's completely independent.

If we have good reasons for having targets with exception handling,
then that has absolutely nothing to do with machine checks or buggy
hardware.

And it sure shouldn't be called "mcsafe", since it has nothing to do
with that situation any more.

> I understand the gripes about the mcsafe_slow() implementation, but
> how do I implement mcsafe_fast() any better than how it is currently
> organized given that, setting aside machine check handling,
> memcpy_mcsafe() is the core of a copy_to_iter*() front-end that can
> mmu-fault on either source or destination access?

So honestly, once it is NOT about the broken machine check garbage,
then it should be sold on its own independent reasons.

Do we want to have a "copy_to_iter_safe" that can handle page faults?
Because we have lots of those kinds of things, we have

 - load_unaligned_zeropad()

   This loads a single word knowing that the _first_ byte is valid,
but can take an exception and zero-pad if it crosses a page boundary

 - probe_kernel_read()/write()

   This is a kernel memcpy() with the source/destination perhaps being unmapped.

 - various perf and tracing helpers that have special semantics.

but once it's about some generic interface, then it also needs to take
other architectures into account.

               Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
