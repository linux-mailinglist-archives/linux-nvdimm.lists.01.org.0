Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A550A1C03B0
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 19:17:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08BBF110EE2DD;
	Thu, 30 Apr 2020 10:16:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0E525110EC72F
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 10:16:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b2so163495ljp.4
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbtaQ1Pr8o8wY3oZ0XUT+6r9NQjFUKQ2iX6lszWerYA=;
        b=hvyYWSqj2/fPEY1WvRlxpzG6+BEmdG53Q6FGr0rmFjqrtn6k+h40SEBcbuDXCqxUgu
         oQj9pLhUMMsLzXOxx5yIsXnoxM5edRADMw3Nok9hHdGYJi9aZqee4YhpZbofCd09La3i
         YD/BYT0Ja4/85/lTKRMWx/UXUjWBdf/VeXqqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbtaQ1Pr8o8wY3oZ0XUT+6r9NQjFUKQ2iX6lszWerYA=;
        b=kRL5cVh2fQxO2cF1L3V7nuNOf769gEYBtCc7S9huvOtE5EEDpvepwgcK1cC+1HGhqL
         rRLACLrvvQ7uDkF+4RtkcRDq97HLuvBocZ1qFNkOQ/l1RbpKf0gcMi2kIP/oHGKoy28m
         X7U0epEqRdmit7jaeK04wIvouNJa1ctjSV7mvwmOSLc9d/8ks3xy0Tv+X7iXFhZ1BDiv
         /5IAWWUOPIVNJE5BdbPsyugdM4ftFVtp61Q5KSkeDCnloRPeBfGEXsrzP2Ifa13J5ngf
         PcZ1BmxmYyzlLpestPPfNPZxz5vl+KGw3pgTq3kUnnX4ICwwGO5o04y1oIoJhAWGo8To
         Y9tw==
X-Gm-Message-State: AGi0Pua90p2wf18MQX/waXzYN68Su5g86lLY/PAT21QhzeJJRrNQSQRC
	tmNKyNVcuz2Y6XRIjgsEMJ+a5yLKS8Y=
X-Google-Smtp-Source: APiQypKZYQqL4ykMW1cbceLsoPj7rNBdXVbAqIRfARYS5XThhtHm2xxxSvk+1I/PQiDLDn9Avi767w==
X-Received: by 2002:a2e:7610:: with SMTP id r16mr225966ljc.156.1588267057284;
        Thu, 30 Apr 2020 10:17:37 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f26sm167128lfc.84.2020.04.30.10.17.35
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 10:17:36 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h4so110254ljg.12
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 10:17:35 -0700 (PDT)
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr167004ljp.209.1588267055471;
 Thu, 30 Apr 2020 10:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com> <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
In-Reply-To: <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Apr 2020 10:17:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
Message-ID: <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: Andy Lutomirski <luto@kernel.org>
Message-ID-Hash: IOHUAI3BSIPRLGAKXB4SL75RRLB2XRWD
X-Message-ID-Hash: IOHUAI3BSIPRLGAKXB4SL75RRLB2XRWD
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IOHUAI3BSIPRLGAKXB4SL75RRLB2XRWD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 9:52 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> If I'm going to copy from memory that might be bad but is at least a
> valid pointer, I want a function to do this.  If I'm going to copy
> from memory that might be entirely bogus, that's a different
> operation.  In other words, if I'm writing e.g. filesystem that is
> touching get_user_pages()'d persistent memory, I don't want to panic
> if the memory fails, but I do want at least a very loud warning if I
> follow a wild pointer.
>
> So I think that probe_kernel_copy() is not a valid replacement for
> memcpy_mcsafe().

Fair enough.

That said, the part I do like about probe_kernel_read/write() is that
it does indicate which part we think is possibly the one that needs
more care.

Sure, it _might_ be both sides, but honestly, that's likely the much
less common case. Kind of like "copy_{to,from}_user()" vs
"copy_in_user()".

Yes, the "copy_in_user()" case exists, but it's the odd and unusual case.

Looking at the existing cases of "memcpy_mcsafe()", they do seem to
generally have a very clearly defined direction, not "both sides can
break".

I also find myself suspecting that one case people _do_ want to
possibly do is to copy from nvdimm memory into user space. So then
that needs yet another function.

And we have that copy_to_user_mcsafe() for that, and used in the
disgustingly named "copyout_mcsafe()". Ugly incomprehensible BSD'ism.

But oddly we don't have the "from_user" case.

So this thing seems messy, the naming is odd and inconsistent, and I'd
really like the whole "access with exception handling" to have some
clear rules and clear names.

The whole "there are fifty different special cases" really drives me
wild. It's why I think the hardware was so broken.

And now the special "writes can fault" rule still confuses me.
_copy_to_iter_mcsafe() was mentioned, which makes me think that it's
literally about that "copy from nvram to user space" issue.

But that can't just trap on the destination, that fundamentally needs
special user space accesses anyway. Even on x86 you have the whole
STAC/CLAC issue, on other architectures the stores may not be normal
stores at all.

So a "copy_safe()" model doesn't actually work for that at all.

So I'm a bit (maybe a _lot_) confused about what the semantics should
actually be. And I want the naming to reflect whatever those semantics
are. And I don't think "copy_safe()" reflects any semantics at all.

                     Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
