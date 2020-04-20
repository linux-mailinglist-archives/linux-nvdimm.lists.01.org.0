Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501FE1B1712
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 22:28:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A7360100A0288;
	Mon, 20 Apr 2020 13:27:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::142; helo=mail-lf1-x142.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7104100A0287
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 13:27:51 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 198so9179086lfo.7
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lXVFlCuhZRlNIKPWno7jyPJtjBUewfnSNmf8ZBkjkU=;
        b=cn88vqLJ3iqpfoPaMzWrtCIV4M8jcHhWWu71rGqbgTe5Q/UQn2kwB72nwO+wt0ZsxV
         Fe0cMAvboICZetRhUSad49xM+2KRg2LEkiMxaySpZdfmgaSTauF8lNCz7NT6nkAP+jvT
         GCDKi7YV6yK0o0sTidFCFjCHDaGmRz+vbXKJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lXVFlCuhZRlNIKPWno7jyPJtjBUewfnSNmf8ZBkjkU=;
        b=uBCaDKC/XbwGBEOitM5ioiZSFadAm6dePiwAVZACD1s+lrh0aJGbeIRgrX9Bh1W7/0
         vM3Hh2dtny6L8o+ZV5XwdEyrXPfdLBgNPvpRWWpLWwzrCpFou/RS6dTm3irx6q040mGN
         dOg1uN4+8LAXQb5Toc5pbpL65HqG2bP4iticHJJxQo9SgD/pZUin9D4zMol4+h2eRJcI
         fFhX/QquRtPM1dVkaFljJdcfyN+N3Z8CvQ+zpkNTfwIXRbQ+0g5p2QYR+B3OuNg5PVci
         J9Zen2vG6d/xSTPqqjdG5bJCsDl5cDhEdYLN4tsBtcgpOgIikyKnqE3o/Xoe4/+XsRM0
         8XTg==
X-Gm-Message-State: AGi0Pub+VlaxVfcMsjiyW+vF/xupHVcqBKz5T/rQN+vPLKcv5Y8wM6ni
	bu+okCtWv/qK7sDcdaNhabVg6nx/jms=
X-Google-Smtp-Source: APiQypItSwckKJozVMpcoWaE3gdIdM8uk8irkxg0sA3Xjckz9DkbOP9OnphPubpgmCWwdrD1Sx6nsw==
X-Received: by 2002:a19:ca13:: with SMTP id a19mr11522047lfg.68.1587414475088;
        Mon, 20 Apr 2020 13:27:55 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id z23sm343159ljm.46.2020.04.20.13.27.52
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 13:27:53 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id w145so9170880lff.3
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 13:27:52 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr11369327lfk.192.1587414472376;
 Mon, 20 Apr 2020 13:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
 <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
 <CAPcyv4iTaBNPMwqUwas+J4rxd867QL7JnQBYB8NKnYaTA-R_Tw@mail.gmail.com>
 <CAHk-=wgOUOveRe8=iFWw0S1LSDEjSfQ-4bM64eiXdGj4n7Omng@mail.gmail.com> <20200420202332.GA30160@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200420202332.GA30160@agluck-desk2.amr.corp.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Apr 2020 13:27:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNL-P71xQRsahpYrzKquvz3WwqPCUVPT+1TUmWZ+67TQ@mail.gmail.com>
Message-ID: <CAHk-=whNL-P71xQRsahpYrzKquvz3WwqPCUVPT+1TUmWZ+67TQ@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To: "Luck, Tony" <tony.luck@intel.com>
Message-ID-Hash: KDOR6TAAJXGVK4MXTV2BXTBLOMO3WRLS
X-Message-ID-Hash: KDOR6TAAJXGVK4MXTV2BXTBLOMO3WRLS
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KDOR6TAAJXGVK4MXTV2BXTBLOMO3WRLS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 20, 2020 at 1:23 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> I think they do. If the result of the wrong data has already
> been sent out the network before you process the signal, then you
> will need far smarter application software than has ever been written
> to hunt it down and stop the spread of the bogus result.

Bah. That's a completely red herring argument.

By "asynchronous" I don't mean "hours later".

Make it be "interrupts are enabled, before serializing instruction".

Yes, we want bounded error handling latency. But that doesn't mean "synchronous"

           Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
