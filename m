Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E78D7595C3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 10:09:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 52EE9212AB4D1;
	Fri, 28 Jun 2019 01:09:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 801AB212AAB61
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 01:09:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x15so2588449pfq.0
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yibP/Iv6ps2Lbs4MfioQUnaQ1X0MZgCBiZaerRAAUs0=;
 b=e5kLlPi61UOlg3aWbm3hyHJ6zEvPrbJg4WaMTgr5J7N6beCFHbvMVMWvXm34zFIMK6
 sy+TCthgNvl6QKdGAvF199JWgLSzY0riL7Qema9Z8eQSMrEVD7QmDgObmKA9VnGm6jQk
 Qk9Vw4tG1NS/Rsaor+MwqJJtzbW9NLCCg64qdKIwo/lqdLjqjD0HoEJZR2UkGwIQNQU7
 B8LVi8olEdiEG1gQQPAGB3QH7tntl/R65/A9R5rItsLpolqg+IRJEp1Du/WH5LqoOfL3
 I3l8I0kuDspWHSG/V5vI+q5UJh9nND3VlxUlk753w0GhWsuvm1nMSIm2VqKl1wq8mbGo
 9uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yibP/Iv6ps2Lbs4MfioQUnaQ1X0MZgCBiZaerRAAUs0=;
 b=VdI5i++7mdSWX0AwmsThGfqRKuGndnuzbV3AAPOAQjZzd1VUwigDh6rB0NHOgD4PZ+
 QY5g6bfy+ArWvZt2TuTo/TnnsGi25FKnOt5LFh1DerSKMymY27nRJAsrhP+YPivA0dR2
 ErQyCpfLOt4wa+1gsozIELZ9NneS67ECezm9fcY9hHu0DpuLsNtvnfd4TrgSnl+lIYlJ
 upz98dyCe+qAsWXDcOQi8XFvaYkGrG3iyxPM+EX2SK6txEbrb3uUv40UnMDXoyRVmEwj
 moJno9yyPKqdFo4X74qcXN56zL3alQe/vOyeMKkvwDQJG4scBNXg8Pmg+SPYRdgRw7+4
 rVnA==
X-Gm-Message-State: APjAAAXDBelzzUGlVzs90O4zVmEns79M3mMh/r23nXDJ2VaVwoE2ARWv
 LHYrRovGIJL3YbiW9MTAIIee23yNA65tcdq3W6lVug==
X-Google-Smtp-Source: APXvYqwa5Gi43WdeQYYulM3cScojWTt0/MI+kDN9NbNdt1CeW4jxKTFR3Algm98Jmh+XvwAADJqdAi9a1c1dDVA05Ew=
X-Received: by 2002:a17:90a:be0d:: with SMTP id
 a13mr11033056pjs.84.1561709395368; 
 Fri, 28 Jun 2019 01:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
 <20190626034100.B238520883@mail.kernel.org>
 <CAFd5g46zHAupdUh3wDuqPJti2M+_=oje_5weFe7AVLQfkDDM6A@mail.gmail.com>
 <20190627181636.5EA752064A@mail.kernel.org>
In-Reply-To: <20190627181636.5EA752064A@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 28 Jun 2019 01:09:44 -0700
Message-ID: <CAFd5g44V3ZLNazUOgOo2sFR3zzbNnTkH4e9uxGX4iHi7G73Mzw@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
To: Stephen Boyd <sboyd@kernel.org>
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
Cc: Petr Mladek <pmladek@suse.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
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
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 27, 2019 at 11:16 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-06-26 16:00:40)
> > On Tue, Jun 25, 2019 at 8:41 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > > scenario like below, but where it is a problem. There could be three
> > > CPUs, or even one CPU and three threads if you want to describe the
> > > extra thread scenario.
> > >
> > > Here's my scenario where it isn't needed:
> > >
> > >     CPU0                                      CPU1
> > >     ----                                      ----
> > >     kunit_run_test(&test)
> > >                                               test_case_func()
> > >                                                 ....
> > >                                               [mock hardirq]
> > >                                                 kunit_set_success(&test)
> > >                                               [hardirq ends]
> > >                                                 ...
> > >                                                 complete(&test_done)
> > >       wait_for_completion(&test_done)
> > >       kunit_get_success(&test)
> > >
> > > We don't need to care about having locking here because success or
> > > failure only happens in one place and it's synchronized with the
> > > completion.
> >
> > Here is the scenario I am concerned about:
> >
> > CPU0                      CPU1                       CPU2
> > ----                      ----                       ----
> > kunit_run_test(&test)
> >                           test_case_func()
> >                             ....
> >                             schedule_work(foo_func)
> >                           [mock hardirq]             foo_func()
> >                             ...                        ...
> >                             kunit_set_success(false)   kunit_set_success(false)
> >                           [hardirq ends]               ...
> >                             ...
> >                             complete(&test_done)
> >   wait_for_completion(...)
> >   kunit_get_success(&test)
> >
> > In my scenario, since both CPU1 and CPU2 update the success status of
> > the test simultaneously, even though they are setting it to the same
> > value. If my understanding is correct, this could result in a
> > write-tear on some architectures in some circumstances. I suppose we
> > could just make it an atomic boolean, but I figured locking is also
> > fine, and generally preferred.
>
> This is what we have WRITE_ONCE() and READ_ONCE() for. Maybe you could
> just use that in the getter and setters and remove the lock if it isn't
> used for anything else.
>
> It may also be a good idea to have a kunit_fail_test() API that fails
> the test passed in with a WRITE_ONCE(false). Otherwise, the test is
> assumed successful and it isn't even possible for a test to change the
> state from failure to success due to a logical error because the API
> isn't available. Then we don't really need to have a generic
> kunit_set_success() function at all. We could have a kunit_test_failed()
> function too that replaces the kunit_get_success() function. That would
> read better in an if condition.

You know what, I think you are right.

Sorry, for not realizing this earlier, I think you mentioned something
along these lines a long time ago.

Thanks for your patience!

> >
> > Also, to be clear, I am onboard with dropping then IRQ stuff for now.
> > I am fine moving to a mutex for the time being.
> >
>
> Ok.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
