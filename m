Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D11C06F7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 21:51:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 11CDC110BB080;
	Thu, 30 Apr 2020 12:49:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 05999100DCB65
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 12:49:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w20so675025ljj.0
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buJprfejQSl5yOput5ZzEt1+jJW0SdBoSZ4YNZtieEY=;
        b=VUySWc9/2/N9fwGhjHudR0NYsyMdMYZXogyCdl4rAuef6cbEQbsUZSSi0oWuzE4z5h
         oCVQ61Pc7cnFxML60ozbbHuETGxsnqdWrMhn5WWKV0YPtGOtTP7g+li2MpWKMXtZQPIL
         fURRW8u5/c5rMyeSpaud7CEBjaUNeWdlVUYJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buJprfejQSl5yOput5ZzEt1+jJW0SdBoSZ4YNZtieEY=;
        b=K2wvvbuMmyB+GR2BituhU74m+0g13n+ESu/WLKykyQBHtGb8I23GWhglYwyfFtVdr1
         UtZoTq1No4UWo7RJBTi6/ipi7dRiTgqWLNbHrX2VsRPLoK0XaFhjakI67iwAbXoQ41hP
         ZX24oi0EruORusF+8+oVudXQ/hrvVekQ7qGHj/0uQwlT5tZfm23l6oor8N62yg6Q5K7L
         hTqpTmAapFk1uRIc7WrDH7YVlfzBv4W4xUYw+R8HDyZRyvlCNxt3JWYavUyacJmzyExT
         VpjfayJLdq+v8mZYSbsiG+vEDnzvnfUEAX4uqHEt4TL4bjhnKBhund76H0WspM+biv+R
         HFSw==
X-Gm-Message-State: AGi0PuYTU3Z+6sMfHHyOnaHiki1JdDhCzZncydmRYyMYUYsx11xX1gSL
	8bO2FHmyZ6ceIs250qwnRcX649U+mjo=
X-Google-Smtp-Source: APiQypLr80OFrF+32Ufv2QQ/UMsw65ksiOgGwWjojLfR8V111LfrzIhTsAAyJSUDHnu0d2mB7vghzQ==
X-Received: by 2002:a2e:a417:: with SMTP id p23mr331178ljn.19.1588276259909;
        Thu, 30 Apr 2020 12:50:59 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t16sm574440lff.72.2020.04.30.12.50.57
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 12:50:57 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id t11so2266493lfe.4
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 12:50:57 -0700 (PDT)
X-Received: by 2002:a05:6512:1114:: with SMTP id l20mr178100lfg.31.1588276256935;
 Thu, 30 Apr 2020 12:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com> <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Apr 2020 12:50:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
Message-ID: <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: "Luck, Tony" <tony.luck@intel.com>
Message-ID-Hash: RTNFZI6U3CDZN6OV7HUSYKPGSCWCTWGJ
X-Message-ID-Hash: RTNFZI6U3CDZN6OV7HUSYKPGSCWCTWGJ
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RTNFZI6U3CDZN6OV7HUSYKPGSCWCTWGJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 12:23 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> How about
>
>         try_copy_catch(void *dst, void *src, size_t count, int *fault)
>
> returns number of bytes not-copied (like copy_to_user etc).
>
> if return is not zero, "fault" tells you what type of fault
> cause the early stop (#PF, #MC).

That just makes things worse.

The problem isn't "what fault did I get?".

The problem is "what is the point of this function?".

In other words, I want the code to explain _why_ it uses a particular function.

So the question the function should answer is not "Why did it take a
fault?", but "Why isn't this just a 'memcpy()'"?

When somebody writes

    x = copy_to_user(a,b,c);

the "why is it not a memcpy" question never comes up, because the code
is obvious. It's not a memory copy, because it's copying to user
space, and user space is different!

In contrast, if you write

    x = copy_safe(a,b,c);

then what is going on? There is no rhyme or reason to the call. Is the
source unsafe? Wny? Is the destination faulting? Why? Both? How?

So "copy_to_user()" _answers_ a question. But "copy_safe()" just
results in more questions. See the difference?

And notice that the "why did it fault" question is NOT about your
"what kind of fault did it take" question. That question is generally
pretty much uninteresting.

The question I want answered is "why is this function being called AT ALL".

Again, "copy_to_user()" can fail, and we know to check failure cases.
But more importantly, the _reason_ it can fail is obvious from the
name and from the use. There's no confusion about "why".

"copy_safe()"? or "try_copy_catch()"? No such thing. It doesn't answer
that fundamental "why" question.

And yes, this also has practical consequences. If you know that the
failure is due to the source being some special memory (and if we care
about the MC case with unaligned accesses), then the function in
question should probably strive to make those _source_ accesses be the
aligned ones.  But if it's the destination that is special memory,
then it's the writes to the destination that should be aligned. If you
need both, you may need to be either mutually aligned, or do byte
accesses, or do special shifting copies. So it matters for any initial
alignment code (if the thing has alignment issues to begin with).

I haven't even gotten an answer to the "why would the write fail".
When I asked, Dan said

 "writes can mmu-fault now that memcpy_mcsafe() is also used by
_copy_to_iter_mcsafe()"

but as mentioned, the only reason I can find for _that_ is that the
destination is user space.

In which case a "copy_safe()" absolutely could never work.

If I can't figure out the "why is this function used" or even figure
out why it needs the semantics it claims it needs, then there's a
problem.

Personally, I suspect that the *easiest* way to support the broken
nvdimm semantics is to not have a "copy" function at all as the basic
accessor model.

Why? Exactly because "copy" is not a fundamental well-defined action.
You get nasty combinatorial explosions of different things, where you
have three different kinds of sources (user, RAM, nvdimm) and three
different kinds of destinations.

And that's ignoring the whole "maybe you don't want to do a plain
copy, maybe you want to calculate a RAID checksum, or do a 'strcpy()'
or whatever". If those are ever issues, you get another explosion of
combinations.

The only *fundamental* access would likely be a single read/write
operation, not a copy operation. Think "get_user()" instead of
"copy_from_user()".  Even there you get combinatorial explosions with
access sizes, but you can often generate those automatically or with
simple patterns, and then you can build up the copy functions from
that if you really need to.

                   Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
