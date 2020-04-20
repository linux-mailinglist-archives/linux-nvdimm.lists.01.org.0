Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D69C91B17A7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 22:56:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0D7C9100A028C;
	Mon, 20 Apr 2020 13:56:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DD4B2100A0288
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 13:56:45 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w145so9238767lff.3
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YMKp9wPvX7FbDR3+6WEIzSglLbYUecdGkyUsv5KulQ=;
        b=FcXT9x/jUah+X0xgwFiqlUqBQvX1G3RiMhY/gwPoHmmY/XQlinet+aCVntYoTSXix0
         nYnC67xrDgLTWaT5S4DrH+GUnhJL1ZtDCuTvhpZ7ZxXg/ozncV3EsUCU+SCShBpzLktB
         /uVd+li/PDjb4APhJ2J6DiaYwIXndtCUke1hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YMKp9wPvX7FbDR3+6WEIzSglLbYUecdGkyUsv5KulQ=;
        b=ffFewKZJBo3sr4dG/LBAZ4E9vIbO5dHDJRX1xVLHVPROSTabDHbs0cmLR8vqVgANA2
         tH4IBiLjnwhZJGkP00HB4q2M0fToLM+0OrMDT2quDSWtWG0M8Co7Bc5U0QLlSjpzU1Hz
         81oipQ4Jax4lT3mvLd96SQLe/fdmCIPuagfMb+lGvVBBtB73uYAHLn5XzTTtElZ7Vv3v
         1i1qQc6aDLetseoRyrzJQsljKCQV8DS3c9piqyeGBDKRGoAEEw/PQi03hCkVaBS7iMSd
         fDmKRArXcK5mWYkzRmSloVvpugyDFtDck+PjE7sAZetk1oElpPZRaZQl85yXwcmgc9ns
         +wmg==
X-Gm-Message-State: AGi0PubxVXx/3t+fz3FFu3MCiEQpGcxzBK+n4Ar23wgmKpqAIVPG9Fg0
	PNN2k+oCOn4gGsGS4si3KU9dWlVgcUA=
X-Google-Smtp-Source: APiQypIVT9DJA27nNCi3ovEh/U10m2X/0N6vTvwt1m+mADKofvoP1Xgq7xKH+CQq7sn2VAN//cLr9g==
X-Received: by 2002:a05:6512:1046:: with SMTP id c6mr11686108lfb.115.1587416209882;
        Mon, 20 Apr 2020 13:56:49 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id j14sm385137lfm.73.2020.04.20.13.56.48
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 13:56:49 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id f8so9228725lfe.12
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 13:56:48 -0700 (PDT)
X-Received: by 2002:a19:946:: with SMTP id 67mr9797282lfj.142.1587416208523;
 Mon, 20 Apr 2020 13:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
 <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
 <CAPcyv4iTaBNPMwqUwas+J4rxd867QL7JnQBYB8NKnYaTA-R_Tw@mail.gmail.com>
 <CAHk-=wgOUOveRe8=iFWw0S1LSDEjSfQ-4bM64eiXdGj4n7Omng@mail.gmail.com>
 <20200420202332.GA30160@agluck-desk2.amr.corp.intel.com> <CAHk-=whNL-P71xQRsahpYrzKquvz3WwqPCUVPT+1TUmWZ+67TQ@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7F5FB1C0@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5FB1C0@ORSMSX115.amr.corp.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Apr 2020 13:56:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9Qk=b5h0y=s9vUoLxAD0Nz5BrsU7g0=-ZiUFO9q3EmQ@mail.gmail.com>
Message-ID: <CAHk-=wg9Qk=b5h0y=s9vUoLxAD0Nz5BrsU7g0=-ZiUFO9q3EmQ@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To: "Luck, Tony" <tony.luck@intel.com>
Message-ID-Hash: YNU3C7IRXJ4WK4KMY5QJ3PBA46K7YODB
X-Message-ID-Hash: YNU3C7IRXJ4WK4KMY5QJ3PBA46K7YODB
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Tsaur, Erwin" <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YNU3C7IRXJ4WK4KMY5QJ3PBA46K7YODB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 20, 2020 at 1:45 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> Another X86 vendor seems to be adding something like that. See MCOMMIT
> in https://www.amd.com/system/files/TechDocs/24594.pdf

That sounds potentially very expensive.

Particularly, as you say, something like the kernel (or
virtualization) may want to at least test for it cheaply on entry or
switch or whatever.

I do think you want the mcommit kind of thing for writing, but I think
the intel model of (no longer pcommit) using a writeback instruction
with a range, and then just sfence is better than a "commit
everything" thing.

But that's just for writing things, and that's fundamentally very
different from the read side errors.

So for the read-side you'd want some kind of "lfence and report"
instruction for the "did I see load errors". Very cheap like lfence,
so that there wouldn't really be a cost for the people if somebody
_really_ want to get notified immediately.

And again, it might just be part of any serializing instruction. I
don't care that much, although overloading "serializing instruction"
even more sounds like a bad idea.

               Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
