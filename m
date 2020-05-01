Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95AC1C0B46
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 May 2020 02:31:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 38D62111FC1C0;
	Thu, 30 Apr 2020 17:30:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BBC44111FC1C0
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 17:30:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so6088933edv.8
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 17:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDf2N8mBL2qJb74S4ITCK9fAPPmUAgvoerWrh8dXt4o=;
        b=MreruorxVqBBm3pLqSig9B5BAdyGIXSOxD6BJt2oKVTHUb1/8Whm8gIpcX16l58lSv
         QPNB29r7LEHIVU4GCCsv3CKa2gCOu0ExTOuE3vO1blHXWjouvTt8wvZBkUIdShaFwHPi
         GYDLjgWlY3m6y8KprJDmZNXjTI5GXeXGOTUNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDf2N8mBL2qJb74S4ITCK9fAPPmUAgvoerWrh8dXt4o=;
        b=B5FWZSGNFuso7Rcf6uVAqsv3CQPmelnT89ZDOEGvXLAecMG4Sm8ZIOaeiCP0PfSUaG
         Dyjuyi2TVwwQTxtgTBXUdJzROpugSdiTXRlhmj5Q0OHpx0pqAUsxsEITrn/x0Ej5XH+f
         uc+AZk9GyQXvp5DgOxJ69fGasX3MaZU0em6yhnmjy7YQMY7M/9H0OmJlNxtIhHRpmvJj
         NCgW4fiyaKzLMaMiJJsgqgb0R1CJems0CbdJFODM4/71+ZtMj7YxyROMxtIbBqa5q7Tk
         j1p0ra2/u54PBiqSRrWjI8arpcqjEEA9oQCT+gf4mSGiMnY29rfLwwN5EyFi/NRGCHuq
         j1kg==
X-Gm-Message-State: AGi0PuZMwy880dLxQeRop2klATj65rSC1kvuUY6TEShLwBhgMQKvOyWt
	lfopoV0GQy6AeWqyd/AWMgbMBGOC5ZA=
X-Google-Smtp-Source: APiQypK9/yrUvEFCuiJyQhAIwOXGzc7RWNOU0XGxsCzIpgK00SSWux4Q5ZNoTb4NtAX7kZ4QoOYzXQ==
X-Received: by 2002:a05:6402:1a2f:: with SMTP id be15mr1465346edb.385.1588293100497;
        Thu, 30 Apr 2020 17:31:40 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id f4sm106049ejk.26.2020.04.30.17.31.40
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 17:31:40 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id x17so9703283wrt.5
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 17:31:40 -0700 (PDT)
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr783565lfe.152.1588292705876;
 Thu, 30 Apr 2020 17:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
 <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com> <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
 <CAPcyv4g0a406X9-=NATJZ9QqObim9Phdkb_WmmhsT9zvXsGSpw@mail.gmail.com> <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
In-Reply-To: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Apr 2020 17:24:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1SPyuGkTkQESsacwKTpjWd=_-KwoCK5o=SuC3yMdf7A@mail.gmail.com>
Message-ID: <CAHk-=wh1SPyuGkTkQESsacwKTpjWd=_-KwoCK5o=SuC3yMdf7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 3BX6KFH6QRPG5ZUMCA2ELT2GMBKXYPVT
X-Message-ID-Hash: 3BX6KFH6QRPG5ZUMCA2ELT2GMBKXYPVT
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3BX6KFH6QRPG5ZUMCA2ELT2GMBKXYPVT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 5:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's a horrible word, btw. The word doesn't actually mean what Andy
> means it to mean. "fallible" means "can make mistakes", not "can
> fault".

Btw, on naming: the name should be about _why_ it can fault, not about
whether it faults.

Which hasn't been explained to me.

I know why user accesses can fault. I still don't know why these new
accesses can fault. I know of the old name (mcs), but the newly
suggested name (safe) is the _opposite_ of an explanation of why it
faults.

Naming - like comments - shouldn't be about what some implementation
is, but about the concept.

Again, let me use that "copy_to_user()" as an example of this. Yes, it
can fault. Notice how the name doesn't say "copy_to_faulting()". That
would be WRONG. It can fault _because_ it is user memory, so
"copy_to_user()" not only describes what it does, but it also
implicitly describes that it can fault.

THAT is the kind of explanation I'm looking for. The "memcpy_mcsafe()"
at least had _some_ of that in it. It was wrong for all the _other_
reasons (not having a direction, and the hardware just being complete
and utter garbage), but at least there was a reason in the name.

I am not interested in adding new infrastructure that cannot even be
explained. Why would writes ever fault, considering they are posted
(and again, "user space" is not a valid reason, we have that case
already and have had it since day #1 even if the original naming was
the same kind of bad implementation-specific name that "mcsafe" was).

If the ONLY reason for the fault is a machine check, then the name
should say so, and "copy_mc_to_user()" would be a perfectly fine name
(along with copy_to_mc(), copy_from_mc(), and copy_in_mc()).

It wasn't clear how "copy_to_mc()" could ever fault. Poisoning
after-the-fact? Why would that be preferable to just mapping a dummy
page? But even if it cannot fault, I can see that you might want to do
it as a special kind of copy to avoid any read-mask-write artifacts
(which can definitely happen on other architectures, and I could see a
manual memcpy() implementation doing even on x86)

                  Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
