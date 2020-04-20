Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1EF1B144E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 20:20:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5F7A3100A026A;
	Mon, 20 Apr 2020 11:20:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A53C51010632A
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 11:20:10 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so8174953edq.7
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtO01bYahgOb7Z9oRmIlu41t03TJcXzE5gRBaNEAL7Q=;
        b=hfCwL9e+vf+caPGwbcjlSh2CVWoPvLRnIJcrj9mrBBg13LqXHm391fyBRHAGUhOojJ
         LFECsoHiwbzsCXzyE4yH5jK/CDgMbH7FByj4ye7bEj/Ofh9EY2YC2x6C7G6R7GjxFyvx
         2gRQywjHtfuTQV7PlTAPcwJydCPzueCu7uy7izUk1uyjenndaa6On7aS8aabj3t4uFE+
         p8oCadvi8p8EhSxf6uH8wrvny0KrtCMVNd4OS91UYmaa2RWisGlQjHRt7xajzGeHfkD+
         77kA25TlmNCq/KLfxDuchQz6UT/xj/9zjeQ2akTKJ8eiod7ODfifUo9nA88OMQiZpONE
         lY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtO01bYahgOb7Z9oRmIlu41t03TJcXzE5gRBaNEAL7Q=;
        b=V8nse+ReYWHEXClV3rb3ntyh7kMuZVwgys47ulXylL7na5RuWSS8dfO9pWIS+QEB2Z
         tPJI9Gdei003ugOMMa/Btm+wOl4h8bL+k3ln/ajGQ1Gllxv0pucAwAypYwEe6LfXJVnn
         5z0knA3KYB1CjtYi2ocbrfVkVqmJzpkwSCeMKQBih9o+45ZvCs8g16QfFYbIoU3i64cR
         q1Nwhrlr7dwtTn5bwY/XYosgOnnPboLG7A5aZQf3t/KneZ738991OND32XAxFyialWXn
         vIKhatKPhX49g9lyv7dXG399+4hgIpaSUxxioW1WjVSD/Ccnv3+6V6ZGA6xUdRxiRNiO
         Ppqw==
X-Gm-Message-State: AGi0PuZhvR+z0YWhb/OYr3VIQswfmLdY4hhvq+QRUSN74TMbinhZlfI9
	DZR8IaPytSgSKnQvBtgKkaPSVNgm38ygC6MU/Q2Cpg==
X-Google-Smtp-Source: APiQypIB2bw4dzyFz/giglaCjVx3tH8usOa1T6pRutdl0wU2qwmyfZCwpwPbaM4BrQQaPmzCgUG//qy8oe92xQNI5M4=
X-Received: by 2002:a50:ee86:: with SMTP id f6mr16488628edr.123.1587406812976;
 Mon, 20 Apr 2020 11:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com> <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
In-Reply-To: <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 20 Apr 2020 11:20:01 -0700
Message-ID: <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: 3S5A22JKK7BBFKQUGJC56YN4DB7IE5Y2
X-Message-ID-Hash: 3S5A22JKK7BBFKQUGJC56YN4DB7IE5Y2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3S5A22JKK7BBFKQUGJC56YN4DB7IE5Y2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 20, 2020 at 10:29 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Apr 19, 2020 at 10:08 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Do we have examples of doing exception handling from C? I thought all
> > the exception handling copy routines were assembly routines?
>
> You need assembler for the actual access, but that's a _single_
> instruction - best done as inline asm.
>
> The best example of something that does *exactly* what you want to do is likely
>
>         unsafe_get_user();
>         unsafe_put_user();
>
> which basically turns into a single instruction with exception
> handling, with the exception hander jumping directly to an error
> label.
>
> Ok, so right now gcc can't do that for inline asm with outputs, so it
> generates fairly nasty code (a secondary register with the error state
> that then causes a conditional branch on it), but that's a compiler
> limitation that will eventually go away (where "eventially" means that
> it already works in LLVM with experimental patches).
>
> You could literally mis-use those helpers as-is (please don't - the
> code generation is correct, but at the very least we'd have to
> re-organize a bit to make it a better interface, ie have an
> alternative name like "unsafe_get_kernel()" for kernel pointer
> accesses).
>
> You'd have to do the alignment guarantees yourself, but there are
> examples of that in this area too (strnlen_user() does exactly that -
> aligned word accesses).

Ok, I'll take a deeper look, but my initial reaction is that this
approach could be a way to replace memcpy_mcsafe_slow(), but would be
unfortunate for the fast case which can just use rep; movs;

>
> So the point here is that the current interfaces are garbage, _if_ the
> whole "access a single value" is actually performance-critical.
>
> And if that is *not* the case, then the best thing to do is likely to
> just use a static call. No inlining of single instructions at all,
> just always use a function call, and then pick the function
> appropriately.
>
> Honestly, I can't imagine that the "single access" case is so
> timing-critical that the static call isn't the right model. Your use
> case is _not_ as important or common as doing user accesses.
>
> Finally, the big question is whether the completely broken hardware
> even matters. Are there actual customers that actually use the garbage
> "we can crash the machine" stuff?
>
> Because when it comes to things like nvdimms etc, the _primary_
> performance target would be getting the kernel entirely out of the
> way, and allowing databases etc to just access the damn thing
> directly.
>
> And if you allow user space to access it directly, then you just have
> to admit that it's not a software issue any more - it's the hardware
> that is terminally broken and unusable garbage. It's not even
> interesting to work around things in the kernel, because user space
> can just crash the machine directly.
>
> This is why I absolutely detest that thing so much. The hardware is
> _so_ fundamentally broken that I have always considered the kernel
> workarounds to basically be "staging" level stuff - good enough for
> some random testing of known-broken stuff, but not something that
> anybody sane should ever use.
>
> So my preference would actually be to just call the broken cases to be
> largely ignored, at least from a performance angle. If you can only
> access it through the kernel, the biggest performance limitation is
> that you cannot do any DAX-like thing at all safely, so then the
> performance of some kernel accessors is completely secondary and
> meaningless. When a kernel entry/exit takes a few thousand cycles on
> the broken hardware (due to _other_ bugs), what's the point about
> worrying about trying to inline some single access to the nvdimm?
>
> Did the broken hardware ever spread out into the general public?
> Because if not, then the proper thing to do might be to just make it a
> compile-time option for the (few) customers that signed up for testing
> the initial broken stuff, and make the way _forward_ be a clean model
> without the need to worry about any exceptions at all.

There are 3 classes of hardware, all of them trigger exceptions* it's
just the recoverability of those exceptions that is different:

1/ Recovery not supported all exceptions report PCC=1 (processor
context corrupted) and the kernel decides to panic.

2/ Recovery supported, user processes killed on consumption, panic on
kernel consumption outside of an exception handler instrumented code
path. Unfortunately there is no architectural way to distinguish
class1 from class2 outside of a PCI quirk whitelist. The kernel prior
to memcpy_mcsafe() just unconditionally enabled recovery for user
consumption, panicked on kernel consumption, and hoped that exceptions
are sent with PCC=0. The introduction of memcpy_mcsafe() to handle
poison consumption from kernel-space without a panic introduced this
not pretty caveat that some platforms needed to do special snowflake
memcpy to avoid known scenarios** that trigger PCC=1 when they could
otherwise trigger PCC=0. So a PCI quirk whitelist was added for those.

3/ Recovery supported *and* special snowflake memcpy rules relaxed.
Still no architectural way to discover this state so let us just
enable memcpy_mcsafe_fast() always and let the former whitelist become
a blacklist of "this CPU requires you to do a dance to avoid some
PCC=1 cases, but that dance impacts performance".

* I'm at a loss of why you seem to be suggesting that hardware should
/ could avoid all exceptions. What else could hardware do besides
throw an exception on consumption of a naturally occuring multi-bit
ECC error? Data is gone, and only software might know how to recover.

** Unaligned access across a cacheline boundary, fast string consumption...

> > The writes can mmu-fault now that memcpy_mcsafe() is also used by
> > _copy_to_iter_mcsafe(). This allows a clean bypass of the block layer
> > in fs/dax.c in addition to the pmem driver access of poisoned memory.
> > Now that the fallback is a sane rep; movs; it can be considered for
> > plain copy_to_iter() for other user copies so you get exception
> > handling on kernel access of poison outside of persistent memory. To
> > Andy's point I think a recoverable copy (for exceptions or faults) is
> > generally useful.
>
> I think that's completely independent.
>
> If we have good reasons for having targets with exception handling,
> then that has absolutely nothing to do with machine checks or buggy
> hardware.
>
> And it sure shouldn't be called "mcsafe", since it has nothing to do
> with that situation any more.

Ok, true.

> > I understand the gripes about the mcsafe_slow() implementation, but
> > how do I implement mcsafe_fast() any better than how it is currently
> > organized given that, setting aside machine check handling,
> > memcpy_mcsafe() is the core of a copy_to_iter*() front-end that can
> > mmu-fault on either source or destination access?
>
> So honestly, once it is NOT about the broken machine check garbage,
> then it should be sold on its own independent reasons.
>
> Do we want to have a "copy_to_iter_safe" that can handle page faults?
> Because we have lots of those kinds of things, we have
>
>  - load_unaligned_zeropad()
>
>    This loads a single word knowing that the _first_ byte is valid,
> but can take an exception and zero-pad if it crosses a page boundary
>
>  - probe_kernel_read()/write()
>
>    This is a kernel memcpy() with the source/destination perhaps being unmapped.
>
>  - various perf and tracing helpers that have special semantics.
>
> but once it's about some generic interface, then it also needs to take
> other architectures into account.

For the fast case it's really just copy_user_enhanced_fast_string()
without forced stac/clac when the source and dest are both kernel
accesses.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
