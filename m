Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C881B1771
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 22:46:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3757C100A0288;
	Mon, 20 Apr 2020 13:46:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8D131100A0288
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 13:46:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m2so9188142lfo.6
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlaaVbm8PuebFJl/q63Tt+vA9aaeM21+f84Se7YPrVk=;
        b=IeyZiD2b5ww4LcmgBhjJAIyDJH/nL1yFN68MXiPJ5Rxcul6oFhjIyBWGxbK06/bW34
         3s7lJfT9DTUdt4FDYgflOIqw5NeAOwgt0vX4JgYIi4os7Dw7D9EOJbsrdiluBqX2dEfL
         KnnfIX9RrBlu8lC5HNlW/lH1/EQZTSFFinSss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlaaVbm8PuebFJl/q63Tt+vA9aaeM21+f84Se7YPrVk=;
        b=g9VSziEz0DJG+2YGl/F/+KkWkaWY53fJhaeHTmEnA/DRCWkqJ6IeV5F+Pnl3vEKC8M
         4XfqMvjNqJrfDhCxRTAaFra0paYH8dpylRan8JThfgsTLK3517GqNNG0M97S7G8pb0hP
         qSymNbHjSl16DYz0sn2W9WNaTJYH8b/TNW/YqfhGzFSxTLyIIIO+7AXjQalhg/lY0Qo8
         jcvt/cVH7HSXyBN7RGhxKxfxJBvouAUMMDw/arnZW9h7/PqCX8CkU0OWuSH9SnQdDt6V
         syLVYbXo/YjC6KPzMUtmwfdTmk+d0wbQjzNU0LkPo7dofHiNw5xigL/Cm8vSIahJbsz4
         KYQA==
X-Gm-Message-State: AGi0PubfK3HIAUfLFhI8QE5Pjow32b+BtIZH86hyWRf5rXsXUee3BMBA
	RkVmifW92IElXavXwxTwXqF1O5j2grA=
X-Google-Smtp-Source: APiQypILJe7uc3dDUGst8lp7WkOzMzXy5JPPQcmGP2Wq0Y+8crC39xb8ozZV/WqrVDhbHUvbDWRGTQ==
X-Received: by 2002:a05:6512:490:: with SMTP id v16mr11733299lfq.71.1587415595849;
        Mon, 20 Apr 2020 13:46:35 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id x24sm382142lfc.6.2020.04.20.13.46.34
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 13:46:35 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id z26so11573946ljz.11
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 13:46:34 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr878197ljg.204.1587415594444;
 Mon, 20 Apr 2020 13:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
 <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
 <CAPcyv4iTaBNPMwqUwas+J4rxd867QL7JnQBYB8NKnYaTA-R_Tw@mail.gmail.com>
 <CAHk-=wgOUOveRe8=iFWw0S1LSDEjSfQ-4bM64eiXdGj4n7Omng@mail.gmail.com> <CAPcyv4hKcAvQEo+peg3MRT3j+u8UdOHVNUWCZhi0aHaiLbe8gw@mail.gmail.com>
In-Reply-To: <CAPcyv4hKcAvQEo+peg3MRT3j+u8UdOHVNUWCZhi0aHaiLbe8gw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Apr 2020 13:46:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0yVRjD9KgsnOD39k7FzPqhG794reYT4J7HsL0P89oQg@mail.gmail.com>
Message-ID: <CAHk-=wj0yVRjD9KgsnOD39k7FzPqhG794reYT4J7HsL0P89oQg@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 4LJAL5OHOLY5BENPWN5NWIPWAFTDBXO3
X-Message-ID-Hash: 4LJAL5OHOLY5BENPWN5NWIPWAFTDBXO3
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4LJAL5OHOLY5BENPWN5NWIPWAFTDBXO3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 20, 2020 at 1:25 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> ...but also some kind of barrier semantic, right? Because there are
> systems that want some guarantees when they can commit or otherwise
> shoot the machine if they can not.

The optimal model would likely be a new instruction that could be done
in user space and test for it, possibly without any exception at all
(because the thing that checks for errors is also presumably the only
thing that can decide how to recover - so raising an exception doesn't
necessarily help).

Together with a way for the kernel to save/restore the exception state
on task switch (presumably in the xsave area) so that the error state
of one process doesn't affect another one. Bonus points if it's all
per-security level, so that a pure user-level error report doesn't
poison the kernel state and vice versa.

That is _very_ similar to how FPU exceptions work right now. User
space can literally do an operation that creates an error on one CPU,
get re-scheduled to another one, and take the actual signal and read
the exception state on that other CPU.

(Of course, the "not even take an exception" part is different).

An alternate very simple model that doesn't require any new
instructions and no new architecturally visible state (except of
course the actual error data) would be to just be raising a *maskable*
trap (with the Intel definition of trap vs exception: a trap happens
_after_ the instruction).

The trap could be on the next instruction if people really want to be
that precise, but I don't think it even matters. If it's delayed until
the next serializing instruction, that would probably be just fine
too.

But the important thing is that it

 (a) is a trap, not an exception - so the instruction has been done,
and you don't need to try to emulate it or anything to continue.

 (b) is maskable, so that the trap handler can decide to just mask it
and return (and set a separate flag to then handle it later)

With domain transfers either being barriers, or masking it (so NMI and
external interrupts would presumably mask it for latency reasons)?

I dunno. Wild handwaving. But much better than that crazy
unrecoverable machine check model.

                   Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
