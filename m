Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F211C0BA3
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 May 2020 03:22:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3336C111B21A9;
	Thu, 30 Apr 2020 18:20:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2953C10053E15
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 18:20:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s9so6373386eju.1
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 18:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WHCfo12YFpkzc0szZ4Nv4Cwf1R5n0LiGAEBC0vARlw=;
        b=yLLLX3viV91kRFnykTAmBX8/5/pV6R27FltG65l2TDagTsPDSGz0hnqsuiTtmmlAZC
         T7eMYnabMcjoM9b9+sOZm4k7ymz3ikjxcOWCmcmT7j9T9PzO4ab6W+GOE95LDhp0kEsA
         77kE+oEsT6+LW2x1Qf01SZ20BZPRymB9BXeLm3tFR5wJ7NIpO57OcczL5SBSTIV8zoKK
         NWWAgQbcI/cfAp5YcMwQUyTUyEWsWWUvv+Ob/7DBrsvfJtYEF+x/GuS4o7f1F8r0kAWR
         BfhXeDBLH2kZL4oCWmAndG4IAUZZLIMyU6zgrPtL2CaIeC4bwKh5ja1WIRC7CDl7k0wK
         YGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WHCfo12YFpkzc0szZ4Nv4Cwf1R5n0LiGAEBC0vARlw=;
        b=kEm7b6rZxImbRGYRoFypH3Fq4VjctfGz1c4ppaxttVjGrioU+Qs8nTsh8TW7EXNY4Y
         xQdJorLlcs0kXaIyRwJuwja78RiETSHZ5VSy/I3cMDrUXzgrvUhf1YL4mnm5FHhqwPH8
         T6ElFEzUCf21afB5VNAM82nKceO1Q9D37W6sC5016eFZtv2GCM/3L3CEo8Q4alZun+2m
         YwWV27lPY6qATDC0fA+8NEnodik+7o5rJxAIUrv2QIPmOftzipqp/Mbg5FhFN1XvQsgZ
         oqg6VpxKOg4vytclnhmqzpxD9FsObAAlEHOac8IRB5+Q6ZMiQv/fooBM3cFbU5zNNVT9
         R4xw==
X-Gm-Message-State: AGi0Puaiv3Mkip8C864WmN+x6MULzgFARMIhjHyNxydg/ms3CNr+axe8
	I/jWzFCkKLm5ILS5UIQV/I5wx2C3aOQtJbYYN/lY4g==
X-Google-Smtp-Source: APiQypLgIGV3KJNUB6kjEzDIy/JL7FfpU+mSWrRsGSBvx0nOD2CIZhVhWdGJEosw343TeMYtWuG1EJ2evwMQ7pvhb6k=
X-Received: by 2002:a17:906:7750:: with SMTP id o16mr1196548ejn.12.1588296116582;
 Thu, 30 Apr 2020 18:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
 <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com> <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
 <CAPcyv4g0a406X9-=NATJZ9QqObim9Phdkb_WmmhsT9zvXsGSpw@mail.gmail.com> <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
In-Reply-To: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Apr 2020 18:21:45 -0700
Message-ID: <CAPcyv4jvgCGU700x_U6EKyGsHwQBoPkJUF+6gP4YDPupjdViyQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: FUPQEJXHPG6VPXH65ZOGWSBXJXVAMAGH
X-Message-ID-Hash: FUPQEJXHPG6VPXH65ZOGWSBXJXVAMAGH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FUPQEJXHPG6VPXH65ZOGWSBXJXVAMAGH/>
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
> On Thu, Apr 30, 2020 at 4:52 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > You had me until here. Up to this point I was grokking that Andy's
> > "_fallible" suggestion does help explain better than "_safe", because
> > the copy is doing extra safety checks. copy_to_user() and
> > copy_to_user_fallible() mean *something* where copy_to_user_safe()
> > does not.
>
> It's a horrible word, btw. The word doesn't actually mean what Andy
> means it to mean. "fallible" means "can make mistakes", not "can
> fault".
>
> So "fallible" is a horrible name.
>
> But anyway, I don't hate something like "copy_to_user_fallible()"
> conceptually. The naming needs to be fixed, in that "user" can always
> take a fault, so it's the _source_ that can fault, not the "user"
> part.
>
> It was the "copy_safe()" model that I find unacceptable, that uses
> _one_ name for what is at the very least *four* different operations:
>
>  - copy from faulting memory to user
>
>  - copy from faulting memory to kernel
>
>  - copy from kernel to faulting memory
>
>  - copy within faulting memory
>
> No way can you do that with one single function. A kernel address and
> a user address may literally have the exact same bit representation.
> So the user vs kernel distinction _has_ to be in the name.
>
> The "kernel vs faulting" doesn't necessarily have to be there from an
> implementation standpoint, but it *should* be there, because
>
>  - it might affect implemmentation
>
>  - but even if it DOESN'T affect implementation, it should be separate
> just from the standpoint of being self-documenting code.
>
> > However you lose me on this "broken nvdimm semantics" contention.
> > There is nothing nvdimm-hardware specific about the copy_safe()
> > implementation, zero, nada, nothing new to the error model that DRAM
> > did not also inflict on the Linux implementation.
>
> Ok, so good. Let's kill this all, and just use memcpy(), and copy_to_user().
>
> Just make sure that the nvdimm code doesn't use invalid kernel
> addresses or other broken poisoning.
>
> Problem solved.
>
> You can't have it both ways. Either memcpy just works, or it doesn't.

It doesn't, but copy_to_user() is frustratingly close and you can see
in the patch that I went ahead and used copy_user_generic() to
implement the backend of the default "fast" implementation.

However now I see that copy_user_generic() works for the wrong reason.
It works because the exception on the source address due to poison
looks no different than a write fault on the user address to the
caller, it's still just a short copy. So it makes copy_to_user() work
for the wrong reason relative to the name.

How about, following your suggestion, introduce copy_mc_to_user() (can
just use copy_user_generic() internally) and copy_mc_to_kernel() for
the other the helpers that the copy_to_iter() implementation needs?
That makes it clear that no mmu-faults are expected on reads, only
exceptions, and no protection-faults are expected at all for
copy_mc_to_kernel() even if it happens to accidentally handle it.
Following Jann's ex_handler_uaccess() example I could arrange for
copy_mc_to_kernel() to use a new _ASM_EXTABLE_MC() to validate that
the only type of exception meant to be handled is MC and warn
otherwise?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
