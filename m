Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F6A1B182D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 23:16:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A1DAC100A028B;
	Mon, 20 Apr 2020 14:16:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6E11C10106333
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 14:16:39 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j3so11630947ljg.8
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jN6r5vrIi0padwgEOntdkWRPVKTeqU1oUMQLiCc9u8=;
        b=RVMGvgq4dRxVUT5c5yRM7AhK9ONOictyu7KmC/oVUe3820d9C3IZ+Cl66v1+icCDF2
         QgktcgmK+enRUmEsD4pcjlFOgbs2CCGzmQZ3a/E9nbtEQg0f5RbB2c6ns7l8HoIvYshY
         AzHkoLW3JYQL1BBA+DEehjxgRjaVjJWqfueOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jN6r5vrIi0padwgEOntdkWRPVKTeqU1oUMQLiCc9u8=;
        b=PI7YsaKKks/aGGoch89EdFSDOq1Oswv5Zcm6APi645muaBRv0aJwrrRp65P00rm8Me
         +mhRCSOH4YNz9FMguIYZjqsxwFV76ZKE7r/5VyiM+TwMJRFlR21HbXUubj62fDMiebz8
         FuEf/Yog2pbpU9NVLyKY0KKBEK0YbjR34twKD/kOje9toa2JTwn1ANt+uQrJb5vC431M
         YNHbK4Wp1uGoP9QYHNFTHwbt/aJcUuJUkdeiIeZb3fpvL4CO4OT6mMBiiD0XsCbyfDmD
         sEFy+PTfiTsA45zxnVs/S8gt/QsNv4hcgSprJ7MxmiTkInHTbAJKkqDlcJ7D+Y81aC1P
         ksIA==
X-Gm-Message-State: AGi0PuYVulPxYpWncwj+p5LkJSVeoxKZnJve6oEV5XoTbmZJZmeRPNbA
	6o75Peu9Prms3tR0+3f2Og808AHn9qU=
X-Google-Smtp-Source: APiQypIQbASo85r/r99wM4IBjVJdEqBawyb/DgYoCzqC3v127R5PFebSxDFyFK1fPtpzjQf22O6Ovg==
X-Received: by 2002:a2e:5847:: with SMTP id x7mr3350600ljd.61.1587417402963;
        Mon, 20 Apr 2020 14:16:42 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id a28sm430776lfr.4.2020.04.20.14.16.41
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 14:16:41 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id g4so3551215ljl.2
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 14:16:41 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr10530724ljc.209.1587417401085;
 Mon, 20 Apr 2020 14:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
 <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
 <CAPcyv4iTaBNPMwqUwas+J4rxd867QL7JnQBYB8NKnYaTA-R_Tw@mail.gmail.com>
 <CAHk-=wgOUOveRe8=iFWw0S1LSDEjSfQ-4bM64eiXdGj4n7Omng@mail.gmail.com>
 <CAPcyv4hKcAvQEo+peg3MRT3j+u8UdOHVNUWCZhi0aHaiLbe8gw@mail.gmail.com>
 <CAHk-=wj0yVRjD9KgsnOD39k7FzPqhG794reYT4J7HsL0P89oQg@mail.gmail.com> <3908561D78D1C84285E8C5FCA982C28F7F5FB29E@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5FB29E@ORSMSX115.amr.corp.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Apr 2020 14:16:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcwJd6+HVQNYdssNONWUx1=orzRKkVyr7+t2x9Ydcwsw@mail.gmail.com>
Message-ID: <CAHk-=wjcwJd6+HVQNYdssNONWUx1=orzRKkVyr7+t2x9Ydcwsw@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To: "Luck, Tony" <tony.luck@intel.com>
Message-ID-Hash: VCD4JVAGZ2RWQSSUINQZSDVXKF4B7I7Z
X-Message-ID-Hash: VCD4JVAGZ2RWQSSUINQZSDVXKF4B7I7Z
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Tsaur, Erwin" <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VCD4JVAGZ2RWQSSUINQZSDVXKF4B7I7Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 20, 2020 at 1:57 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> >  (a) is a trap, not an exception - so the instruction has been done,
> > and you don't need to try to emulate it or anything to continue.
>
> Maybe for errors on the data side of the pipeline. On the instruction
> side we can usually recover from user space instruction fetches by
> just throwing away the page with the corrupted instructions and reading
> from disk into a new page. Then just point the page table to the new
> page, and hey presto, its all transparently fixed (modulo time lost fixing
> things).

That's true for things like ECC on real RAM, with traditional executables.

It's not so true of something like nvram that you execute out of
directly. There is not necessarily a disk to re-read things from.

But it's also not true of things like JIT's. They are kind of a big
thing. Asking the JIT to do "hey, I faulted at a random point, you
need to re-JIT" is no different from all the other "that's a _really_
painful recovery point, please delay it".

Sure, the JIT environment will probably just have to kill that thread
anyway, but I do think this falls under the same "you're better off
giving the _option_ to just continue and hope for the best" than force
a non-recoverable state.

For regular ECC, I literally would like the machine to just always
continue. I'd like to be informed that there's something bad going on
(because it might be RAM going bad, but it might also be a rowhammer
attack), but the decision to kill things or not should ultimately be
the *users*, not the JIT's, not the kernel.

So the basic rule should be that you should always have the _option_
to just continue. The corrupted state might not be critical - or it
might be the ECC bits themselves, not the data.

There are situations where stopping everything is worse than "let's
continue as best we can, and inform the user with a big red blinking
light".

ECC should not make things less reliable, even if it's another 10+% of
bits that can go wrong.

It should also be noted that even a good ECC pattern _can_ miss
corruption if you're unlucky with the corruption. So the whole
black-and-white model of "ECC means you need to stop everything" is
questionable to begin with, because the signal isn't that absolute in
the first place.

So when somebody brings up a "what if I use corrupted data and make
things worse", they are making an intellectually dishonest argument.
What if you saw corrupted data and simply never caught it, because it
was a unlucky multi-bit failure"?

There is no "absolute" thing about ECC. The only thing that is _never_
wrong is to report it and try to continue, and let some higher-level
entity decide what to do.

And that final decision might literally be "I ran this simulation for
2 days, I see that there's an error report, I will buy a new machine.
For now I'll use the data it generated, but I'll re-run to validate it
later".

                 Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
