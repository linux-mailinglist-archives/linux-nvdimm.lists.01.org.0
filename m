Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B11C1D2F
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 May 2020 20:29:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 58BCA11460B64;
	Fri,  1 May 2020 11:27:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C9A1311460B61
	for <linux-nvdimm@lists.01.org>; Fri,  1 May 2020 11:27:38 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g4so3438577ljl.2
        for <linux-nvdimm@lists.01.org>; Fri, 01 May 2020 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rg73oT2i7CN6P9GKzkav2692ScwMvCV8w1kfBm2rvpc=;
        b=DBxmwg4XXi8IArR4p+XyseptF37LsJFDYGKqn4Fej360l2/VSOaUYBVFHiPhk/xhQ8
         s6lROshASV7jHjtWyNPvqjhgrgkaFVzegagn8zAtbWr/xDt6AORujuznySe6OYHZ6Vgb
         o4yy070krugoANDoZtUamLdr0Ij+rfCPnRdZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rg73oT2i7CN6P9GKzkav2692ScwMvCV8w1kfBm2rvpc=;
        b=C7ECpJJEV7pav0GM3VSYQ0tZA31hnQIzcj9YgYeCHPcNMo+SEuL8KiCfacCoJhiRCD
         +BivhDCD7vVij0jSGIUebSM9kIx4z6jjPAfd/1TvpfeKlnpJSxhPKzTnNDwjq8iKvGId
         Uu7/lzlzicZlDUrMu31ITgfGqJkVJSocTRv2jl0i7TYOH36wd15B7oMSoM7K2Eg434p3
         Kku0NSovgYV/DPvGyijeKQim4QYtavslD+3+zMh5K5VTpj4EQc4g9LTwynvB6qDQZohT
         OpycOMCWXb7YzMRimNJiSU5DocUP0/VkmxL7t1J9dTCLtZbKrvrhg3oEeVAJd4JNRBWL
         j2mw==
X-Gm-Message-State: AGi0PublabOrIFyIqObAcyBFlevnRVyGv+TrhJpKuAIQEW5AP0TRYswF
	czO2OuqJP+06sj+ImwFbLqcE6EtZkN8=
X-Google-Smtp-Source: APiQypKP87fPtYLNZQ5ibSsMfIR+7chz41tm6FF0cTynDTlu4TGsUqRlcS2BHkdivu04W9Yi1EHBHQ==
X-Received: by 2002:a2e:a313:: with SMTP id l19mr3164748lje.133.1588357733618;
        Fri, 01 May 2020 11:28:53 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id a15sm2381514ljb.37.2020.05.01.11.28.51
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 11:28:52 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id a21so3376670ljj.11
        for <linux-nvdimm@lists.01.org>; Fri, 01 May 2020 11:28:51 -0700 (PDT)
X-Received: by 2002:a2e:7308:: with SMTP id o8mr3129793ljc.16.1588357731518;
 Fri, 01 May 2020 11:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
 <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com> <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
 <CAPcyv4g0a406X9-=NATJZ9QqObim9Phdkb_WmmhsT9zvXsGSpw@mail.gmail.com>
 <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com> <CAPcyv4jvgCGU700x_U6EKyGsHwQBoPkJUF+6gP4YDPupjdViyQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jvgCGU700x_U6EKyGsHwQBoPkJUF+6gP4YDPupjdViyQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 May 2020 11:28:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPkwF2+y6wZd=VD9BooKxHRWhSVW8dr+WSeeSPkJk7kQ@mail.gmail.com>
Message-ID: <CAHk-=wiPkwF2+y6wZd=VD9BooKxHRWhSVW8dr+WSeeSPkJk7kQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: JNHF2IENDR4PCWDTC2JCXUUN7A7LDNVO
X-Message-ID-Hash: JNHF2IENDR4PCWDTC2JCXUUN7A7LDNVO
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JNHF2IENDR4PCWDTC2JCXUUN7A7LDNVO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 6:21 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> However now I see that copy_user_generic() works for the wrong reason.
> It works because the exception on the source address due to poison
> looks no different than a write fault on the user address to the
> caller, it's still just a short copy. So it makes copy_to_user() work
> for the wrong reason relative to the name.

Right.

And it won't work that way on other architectures. On x86, we have a
generic function that can take faults on either side, and we use it
for both cases (and for the "in_user" case too), but that's an
artifact of the architecture oddity.

In fact, it's probably wrong even on x86 - because it can hide bugs -
but writing those things is painful enough that everybody prefers
having just one function.

That's particularly true since that "one function" is actually a whole
family of functions - just for different optimizations.

Plus on x86 you can't reasonably even have different code sequences
for that case, because CLAC/STAC don't have a "enable users read
accesses" vs "write accesses" case. It's an all-or-nothing "enable
user faults".

We _used_ to have a difference on x86, back when we did the whole "fs
segment points to user space".

But on other architectures, there really is a difference between
"copy_to_user()" and "copy_from_user()", and the functions won't do
fault handling for the kernel side accesses.

> How about, following your suggestion, introduce copy_mc_to_user() (can
> just use copy_user_generic() internally) and copy_mc_to_kernel() for
> the other the helpers that the copy_to_iter() implementation needs?

Yes. That at least solves my naming worries, and is conceptually
something that works on other architectures.

Those other architectures may not have nvdimm support yet, but I think
everybody is at least looking at it.

And I really do think it will make the users more readable too, when
you see on a source level that "oh, this code is expecting that it
could take a poison fault/machine check on the source/destination".

> Following Jann's ex_handler_uaccess() example I could arrange for
> copy_mc_to_kernel() to use a new _ASM_EXTABLE_MC() to validate that
> the only type of exception meant to be handled is MC and warn
> otherwise?

That may be a good idea, but won't work for any shared case.

IOW, it would be lovely to have a "copy_mc_to_user()" check that if
it's a write fault, it's because it's a user address (and if it's a
read fault it's because it's a poisoned page or mc or whatever, but a
valid kernel address).

But it's exactly the kind of thing that we currently don't do even for
the bog-standard "copy_to_user()", because we share all the code
because we're lazy.

And as DavidL pointed out - if you ever have "iomem" as a source or
destination, you need yet another case. Not because they can take
another kind of fault (although on some platforms you have the machine
checks for that too), but because they have *very* different
performance profiles (and the ERMS "rep movsb" sucks baby donkeys
through a straw).

              Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
