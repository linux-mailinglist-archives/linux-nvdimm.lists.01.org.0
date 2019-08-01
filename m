Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D8F7E2C0
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Aug 2019 20:55:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 63D7F212FD51B;
	Thu,  1 Aug 2019 11:58:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8CC70212E15BF
 for <linux-nvdimm@lists.01.org>; Thu,  1 Aug 2019 11:58:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m30so34600205pff.8
 for <linux-nvdimm@lists.01.org>; Thu, 01 Aug 2019 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yanPVyyCo7aV5PHJPTHnUF5WwSupWh42aAlO/2TU4qM=;
 b=AXEJGSbzy2nisZCuQomwcAJjsmAS3tsN47D57OouJ7agEzm6inwYRVuQHNR+bPjtqR
 9UzQ05+qRlUInKBsk4vQH8hvJVlwufmneBdZeObqoysE3ZQd/BS43SlI+a070qUA+GFP
 zGdObxqzuaBUkQi+613lUJ+GcPdnTPQ8max5aW44qTMSrTr7ootlST/1JXY0DWLChkPU
 ZltkXhvybDqjkXR6mrxErttgqxF4cTX9l2/i4pArlHsqyX8ykeUJsS6FZqsYTc1h6k5J
 Bwnn1W+citAhlj45JYHcp8CJHpN/h+1KGAAyVB5oHCOQgrPo5/XgonZSlSrX+PfHOS4i
 YaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yanPVyyCo7aV5PHJPTHnUF5WwSupWh42aAlO/2TU4qM=;
 b=l4ga3ibA9OmWY2nqwC4V5xSzAhIlwhH0vl2FDui4MeObYHjKq1HgU/BudIw9ZK3akz
 p5niBvVrulF5gejFnMn/2S3FLc1JIJ4Z8DAqctGDgBWH3HWP/fzcnC7Ms0lXthWNaiOh
 WQTwuT/FuxV9hSqKt0r1oTJT1GzS96+hjeCVEJBYX04osDSJZ77u0B5/y8/1MGAGF8SQ
 M68yaSJXnrzJ9tNEJQ9NLq7Jb7GWdqpt0LpKQN6FDPDh4DJh0z5fQo4/ckWWKXUTbNTd
 vma34fkwL4fi05vFURttjSNU1Sf5dLKfrd75PdnhpEzbZTZPsLEtmwP9fUlbXgSK5Owo
 jF5A==
X-Gm-Message-State: APjAAAVJn1KqInlXXE0x+In//pASthWZtUh27iltLAgZCMqOA0D+4lr2
 gtsYQdyCHkbrZEwTUbt6BmAujVhqV6cB+5KsM6xRUw==
X-Google-Smtp-Source: APXvYqzoFLt8JjfyNttcO+f/0oII0xixTgSXhZRfLC4Blo6PZ1XHxN/CDmHW1v1/KBomRNqbKOVo9+SEvV2fnQP9DnA=
X-Received: by 2002:aa7:81ca:: with SMTP id c10mr55681458pfn.185.1564685731859; 
 Thu, 01 Aug 2019 11:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190716175021.9CA412173C@mail.kernel.org>
 <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
 <20190718175024.C3EC421019@mail.kernel.org>
 <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com>
 <20190719000834.GA3228@google.com> <20190722200347.261D3218C9@mail.kernel.org>
 <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
 <20190722235411.06C1320840@mail.kernel.org>
 <20190724073125.xyzfywctrcvg6fmh@pathway.suse.cz>
 <CAFd5g47v3Mr4GEGOjqyYy9Jwwm+ow7ypbu9j88rxEN06QCzdxQ@mail.gmail.com>
 <20190726083148.d4gf57w2nt5k7t6n@pathway.suse.cz>
In-Reply-To: <20190726083148.d4gf57w2nt5k7t6n@pathway.suse.cz>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 1 Aug 2019 11:55:20 -0700
Message-ID: <CAFd5g46iAhDZ5C_chi7oYLVOkwcoj6+0nw+kPWuXhqWwWKd9jA@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like
 logger
To: Petr Mladek <pmladek@suse.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Kevin Hilman <khilman@baylibre.com>, David Rientjes <rientjes@google.com>,
 Timothy Bird <Tim.Bird@sony.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Joel Stanley <joel@jms.id.au>, devicetree <devicetree@vger.kernel.org>,
 John Ogness <john.ogness@linutronix.de>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>,
 Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>,
 kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jul 26, 2019 at 1:31 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2019-07-25 13:21:12, Brendan Higgins wrote:
> > On Wed, Jul 24, 2019 at 12:31 AM Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > On Mon 2019-07-22 16:54:10, Stephen Boyd wrote:
> > > > Quoting Brendan Higgins (2019-07-22 15:30:49)
> > > > > On Mon, Jul 22, 2019 at 1:03 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > >
> > > > > >
> > > > > > What's the calling context of the assertions and expectations? I still
> > > > > > don't like the fact that string stream needs to allocate buffers and
> > > > > > throw them into a list somewhere because the calling context matters
> > > > > > there.
> > > > >
> > > > > The calling context is the same as before, which is anywhere.
> > > >
> > > > Ok. That's concerning then.
> > > >
> > > > >
> > > > > > I'd prefer we just wrote directly to the console/log via printk
> > > > > > instead. That way things are simple because we use the existing
> > > > > > buffering path of printk, but maybe there's some benefit to the string
> > > > > > stream that I don't see? Right now it looks like it builds a string and
> > > > > > then dumps it to printk so I'm sort of lost what the benefit is over
> > > > > > just writing directly with printk.
> > > > >
> > > > > It's just buffering it so the whole string gets printed uninterrupted.
> > > > > If we were to print out piecemeal to printk, couldn't we have another
> > > > > call to printk come in causing it to garble the KUnit message we are
> > > > > in the middle of printing?
> > > >
> > > > Yes, printing piecemeal by calling printk many times could lead to
> > > > interleaving of messages if something else comes in such as an interrupt
> > > > printing something. Printk has some support to hold "records" but I'm
> > > > not sure how that would work here because KERN_CONT talks about only
> > > > being used early on in boot code. I haven't looked at printk in detail
> > > > though so maybe I'm all wrong and KERN_CONT just works?
> > >
> > > KERN_CONT does not guarantee that the message will get printed
> > > together. The pieces get interleaved with messages printed in
> > > parallel.
> > >
> > > Note that KERN_CONT was originally really meant to be used only during
> > > boot. It was later used more widely and ended in the best effort category.
> > >
> > > There were several attempts to make it more reliable. But it was
> > > always either too complicated or error prone or both.
> > >
> > > You need to use your own buffering if you rely want perfect output.
> > > The question is if it is really worth the complexity. Also note that
> > > any buffering reduces the chance that the messages will reach
> > > the console.
> >
> > Seems like that settles it then. Thanks!
> >
> > > BTW: There is a work in progress on a lockless printk ring buffer.
> > > It will make printk() more secure regarding deadlocks. But it might
> > > make transparent handling of continuous lines even more tricky.
> > >
> > > I guess that local buffering, before calling printk(), will be
> > > even more important then. Well, it might really force us to create
> > > an API for it.
> >
> > Cool! Can you CC me on that discussion?
>
> Adding John Oggness into CC.
>
> John, please CC Brendan Higgins on the patchsets eventually switching
> printk() into the lockless buffer. The test framework is going to
> do its own buffering to keep the related messages together.
>
> The lockless ringbuffer might make handling of related (partial)
> lines worse or better. It might justify KUnit's extra buffering
> or it might allow to get rid of it.

Thanks for CC'ing me on the printk ringbuffer thread. It looks like it
actually probably won't affect my needs for KUnit logging. The biggest
reason I need some sort of buffering system is to be able to compose
messages piece meal into a single message that will be printed out to
the user as a single message with no messages from other printk
callers printed out in the middle of mine.

The prb does look interesting; however, it appears that to get the
semantics that I need, I would have to put my entire message in a
single data block and would consequently need to know the size of my
message a priori, which is problematic. Consequently, it seems as
though I will probably need to compose my entire message using my own
buffering system.

> > > Note that stroring the messages into the printk log is basically safe in any
> > > context. It uses temporary per-CPU buffers for recursive messages and
> > > in NMI. The only problem is panic() when some CPU gets stuck with the
> > > lock taken. This will get solved by the lockless ringbuffer. Also
> > > the temporary buffers will not be necessary any longer.
> >
> > Sure, I think Stephen's concern is all the supporting code that is
> > involved. Not printk specifically. It just means a lot more of KUnit
> > has to be IRQ safe.
>
> I see.
>
> BTW: I wonder if KUnit could reuse the existing seq_buf implementation
> for buffering messages.
>
> I am sorry if it has already been proposed and rejected for some
> reason. I might have missed it. Feel free to just point me to
> same older mail.

Yeah, we discussed it briefly here:

https://lkml.org/lkml/2019/5/17/497

Looks like I forgot to include my reasoning in the commit text, sorry
about that.

> > > Much bigger problems are with consoles. There are many of them. It
> > > means a lot of code and more locks involved, including scheduler
> > > locks. Note that console lock is a semaphore.
> >
> > That shouldn't affect us though, right? As long as we continue to use
> > the printk interface?
>
> I guess that it should not affect KUnit.
>
> The only problem might be if the testing framework calls printk()
> inside scheduler or console code. And only when the tested code
> uses the same locks that will be used by the called printk().

Yeah, well printk will not be our only problem in those instances.

> To be honest I do not fully understand KUnit design. I am not
> completely sure how the tested code is isolated from the running
> system. Namely, I do not know if the tested code shares
> the same locks with the system running the test.

No worries, I don't expect printk to be the hang up in those cases. It
sounds like KUnit has a long way to evolve before printk is going to
be a limitation.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
