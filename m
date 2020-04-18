Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 910091AF455
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 21:42:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 584C010FC62EB;
	Sat, 18 Apr 2020 12:42:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::142; helo=mail-lf1-x142.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 27CEA10FC62E9
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 12:42:31 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u10so4627510lfo.8
        for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 12:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4rEAS/O53Re2CpfxSr2/Dv5edNKCIi/n2DeEZZR7KY=;
        b=Zqa5Mu9fEAhtFeza5prrV1yWpCwrYY/kIL7e1PzuB0VaPYchsmGNPq2A2yJx0KdktA
         yKw2D4sAGZ7F2FEHUIRbuZqtw/gJTtLzShlshLMHwsW0bSUtv5dD1XzzxNPOvxuoXbhB
         B55HwDWCbOhs5ZBK+tO/PcjS/+L1qRJJ57Rxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4rEAS/O53Re2CpfxSr2/Dv5edNKCIi/n2DeEZZR7KY=;
        b=QWXl0SatDPmutG9ptKOcKB739due7iBBKiiwBOI8gLGdJWg/tQrY9TeYbG6IsAgcJk
         NGuG2QyLa4cFFrRKnjd+R70KMc9cIeCOjxuvY6VdE8P6TrY08UMQP3yzw2uoRKTYQ20i
         Dw5QdXUmtN4zxZbf0wPwX9GYhK74nK9SwWV5vAK8WX/axeNOq6bAKG8nQoeoewLSIjVN
         jkfyLlZoPeZPl0oYcBwsEJiaENd9MhnrRbjstwzSwW/LyBxIF157nImkUj5mnN2XXcwf
         EqDW0+eJ8lRXC5qQWDsBS3rlxYBt0qbkY44X7vs82AjbR+UFXjmG577mVdKhiyQveEyx
         eE7A==
X-Gm-Message-State: AGi0Pua+CGkuc9n44IbIP7eeiatIppk2P0cNuqT73Z9NZqHUkBPbYl+h
	+0Z8JBBtsw9ODDqdWAIaOfW/tNEVHEQ=
X-Google-Smtp-Source: APiQypLiQ9m1+KwQYla3PNCgXS0j8zQryWK7Ttc2USkPtHOK441K+ZCbxssWidj/0nYpTHU0UAU3eA==
X-Received: by 2002:ac2:5611:: with SMTP id v17mr5700678lfd.137.1587238940865;
        Sat, 18 Apr 2020 12:42:20 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id d24sm10429646lfi.21.2020.04.18.12.42.18
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 12:42:19 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id u6so5649267ljl.6
        for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 12:42:18 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr5121816ljc.209.1587238938281;
 Sat, 18 Apr 2020 12:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <158654083112.1572482.8944305411228188871.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4gOVN5QVPWduJupVgzq8Sbc_-B0qdYYcw2OcFhk-y2zBw@mail.gmail.com>
In-Reply-To: <CAPcyv4gOVN5QVPWduJupVgzq8Sbc_-B0qdYYcw2OcFhk-y2zBw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 Apr 2020 12:42:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiV1Xk6ShTeafyius+76OvXN=rfSh_VAjk7ZXFvzuFU4Q@mail.gmail.com>
Message-ID: <CAHk-=wiV1Xk6ShTeafyius+76OvXN=rfSh_VAjk7ZXFvzuFU4Q@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 7UD5URNZXQSFJCYMBZDSEJXOYRGDPEDM
X-Message-ID-Hash: 7UD5URNZXQSFJCYMBZDSEJXOYRGDPEDM
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7UD5URNZXQSFJCYMBZDSEJXOYRGDPEDM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 17, 2020 at 5:12 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> > @@ -106,12 +108,10 @@ static __always_inline __must_check unsigned long
> >  memcpy_mcsafe(void *dst, const void *src, size_t cnt)
> >  {
> >  #ifdef CONFIG_X86_MCE
> > -       if (static_branch_unlikely(&mcsafe_key))
> > -               return __memcpy_mcsafe(dst, src, cnt);
> > -       else
> > +       if (static_branch_unlikely(&mcsafe_slow_key))
> > +               return memcpy_mcsafe_slow(dst, src, cnt);
> >  #endif
> > -               memcpy(dst, src, cnt);
> > -       return 0;
> > +       return memcpy_mcsafe_fast(dst, src, cnt);
> >  }

It strikes me that I see no advantages to making this an inline function at all.

Even for the good case - where it turns into just a memcpy because MCE
is entirely disabled - it doesn't seem to matter.

The only case that really helps is when the memcpy can be turned into
a single access. Which - and I checked - does exist, with people doing

        r = memcpy_mcsafe(&sb_seq_count, &sb(wc)->seq_count, sizeof(uint64_t));

to read a single 64-bit field which looks aligned to me.

But that code is incredible garbage anyway, since even on a broken
machine, there's no actual reason to use the slow variant for that
whole access that I can tell. The macs-safe copy routines do not do
anything worthwhile for a single access.

So my reaction remains that a lot of this is just completely wrong and
incredibly mis-designed.

Yes, the hardware was buggy garbage. But why should we make things
worse with making the software be incomprehensibly bad too?

              Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
