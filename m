Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB01D5742E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 00:16:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B0B51212AAB6B;
	Wed, 26 Jun 2019 15:16:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EF78421C8EFA2
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 15:16:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so158911pfq.0
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 15:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GeRJM7RinPoMIQ6Cxu4JfD/FJhf/Q7830l4heE4Z/70=;
 b=S6f2tU7Miw4rgiEW47807L33bYsjxaGq9kSV5FlqDefi2WxZ9lTn6WNXPehPhg/T1u
 QlukqMtHkRexD1aKOxiS1bTcFztoPMq6vRmfl07xvAlF8qkmKEYcRYv6yewHpyrNh/C2
 b54UNQQh2z4Ml5QHakDNUwkkVSa3wpee9qOwZX656U2rr12uOzmYMsnmgvSxd7nO2lJu
 uPRgbm1UzaYtxmtry6zEXpmUHhjd6DhSWjC+3Gn8V/HQxryzbZ7pGyLo06Eq0gUDpp5U
 DjOJXTOOdEhiALmttRxHwycmxPuBaL40MgKhCWjDKs1lUcvOyyLeVeXFZ4cT8o8pd53u
 IzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GeRJM7RinPoMIQ6Cxu4JfD/FJhf/Q7830l4heE4Z/70=;
 b=elUA98Or14O70kG9bESHgQe9bCOjcXfIH0rmsTTqh1weV8Ey6H0YHAvCco5Tm6sUsh
 ZIbRA9+4Z4rHz1E36+KMX4gkBNhGtcr6TtditVt7AoAaknKV/Puvtk2LiAFo32aAgDH8
 155TvzK5P3/sYVK3yBioxNsr0iW87dcXwT4PWhFNoY7b0oV6S/OWrXkHZzdUthgvtr00
 HaJYNmMEZCx1V8pPUrVXSbNR+XpteDDKj4HsAtZ04YoA6IwqAGGrcwDMJ6n6vWdbzp2J
 ui+cVk/AvJnlXakpmJ4NeSFjSz3bQAet4ih+QRLU2RwdWmARe0h08LZmjRynvCBDtbCA
 vRMw==
X-Gm-Message-State: APjAAAUOmGiZ7UmB0wjuJ8xGoZTGXtTjzwv6VhqpNC4uh8Ui1ly2F/cp
 F201JRj4bsjwTZregkhYeW1KK+tc1mTfbxRQDwe6Rg==
X-Google-Smtp-Source: APXvYqzsQMLB7isztv92bzu5YXVWaHFQchBB4ZbMDdOvCDM8VotktY7nYV0uIl6GRCqZMb6GciobJW+UAft7ArjB2vg=
X-Received: by 2002:a17:90b:f0e:: with SMTP id
 br14mr1630712pjb.117.1561587408779; 
 Wed, 26 Jun 2019 15:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190625223312.GP19023@42.do-not-panic.com>
 <CAFd5g46TLAONgXiZkFM98BPd-sariMTwhmYG9hSJ+M9=r-ixeg@mail.gmail.com>
 <20190626033643.GX19023@42.do-not-panic.com>
In-Reply-To: <20190626033643.GX19023@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 26 Jun 2019 15:16:36 -0700
Message-ID: <CAFd5g45PTtPumkpp1i41kkixZaR55pbqaF2DsuKNmh5UyAVwOg@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
To: Luis Chamberlain <mcgrof@kernel.org>
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
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>,
 linux-fsdevel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jun 25, 2019 at 8:36 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Jun 25, 2019 at 05:07:32PM -0700, Brendan Higgins wrote:
> > On Tue, Jun 25, 2019 at 3:33 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Mon, Jun 17, 2019 at 01:25:56AM -0700, Brendan Higgins wrote:
> > > > +/**
> > > > + * module_test() - used to register a &struct kunit_module with KUnit.
> > > > + * @module: a statically allocated &struct kunit_module.
> > > > + *
> > > > + * Registers @module with the test framework. See &struct kunit_module for more
> > > > + * information.
> > > > + */
> > > > +#define module_test(module) \
> > > > +             static int module_kunit_init##module(void) \
> > > > +             { \
> > > > +                     return kunit_run_tests(&module); \
> > > > +             } \
> > > > +             late_initcall(module_kunit_init##module)
> > >
> > > Becuase late_initcall() is used, if these modules are built-in, this
> > > would preclude the ability to test things prior to this part of the
> > > kernel under UML or whatever architecture runs the tests. So, this
> > > limits the scope of testing. Small detail but the scope whould be
> > > documented.
> >
> > You aren't the first person to complain about this (and I am not sure
> > it is the first time you have complained about it). Anyway, I have
> > some follow on patches that will improve the late_initcall thing, and
> > people seemed okay with discussing the follow on patches as part of a
> > subsequent patchset after this gets merged.
> >
> > I will nevertheless document the restriction until then.
>
> To be clear, I am not complaining about it. I just find it simply
> critical to document its limitations, so folks don't try to invest
> time and energy on kunit right away for an early init test, if it
> cannot support it.
>
> If support for that requires some work, it may be worth mentioning
> as well.

Makes sense. And in anycase, it is something I do want to do, just not
right now. I will put a TODO here in the next revision.

> > > > +static void kunit_print_tap_version(void)
> > > > +{
> > > > +     if (!kunit_has_printed_tap_version) {
> > > > +             kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
> > >
> > > What is this TAP thing? Why should we care what version it is on?
> > > Why are we printing this?
> >
> > It's part of the TAP specification[1]. Greg and Frank asked me to make
> > the intermediate format conform to TAP. Seems like something else I
> > should probable document...
>
> Yes thanks!
>
> > > > +             kunit_has_printed_tap_version = true;
> > > > +     }
> > > > +}
> > > > +
> > > > +static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> > > > +{
> > > > +     struct kunit_case *test_case;
> > > > +     size_t len = 0;
> > > > +
> > > > +     for (test_case = test_cases; test_case->run_case; test_case++)
> > >
> > > If we make the last test case NULL, we'd just check for test_case here,
> > > and save ourselves an extra few bytes per test module. Any reason why
> > > the last test case cannot be NULL?
> >
> > Is there anyway to make that work with a statically defined array?
>
> No you're right.
>
> > Basically, I want to be able to do something like:
> >
> > static struct kunit_case example_test_cases[] = {
> >         KUNIT_CASE(example_simple_test),
> >         KUNIT_CASE(example_mock_test),
> >         {}
> > };
> >
> > FYI,
> > #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
>
> >
> > In order to do what you are proposing, I think I need an array of
> > pointers to test cases, which is not ideal.
>
> Yeah, you're right. The only other alternative is to have a:
>
> struct kunit_module {
>        const char name[256];
>        int (*init)(struct kunit *test);
>        void (*exit)(struct kunit *test);
>        struct kunit_case *test_cases;
> +       unsigned int num_cases;
> };
>
> And then something like:
>
> #define KUNIT_MODULE(name, init, exit, cases) { \
>         .name = name, \
>         .init = init, \
>         .exit = exit, \
>         .test_cases = cases,
>         num_cases = ARRAY_SIZE(cases), \
> }
>
> Let's evaluate which is better: one extra test case per all test cases, or
> an extra unsigned int for each kunit module.

I am in favor of the current method since init and exit are optional
arguments. I could see myself (actually I am planning on) adding more
optional things to the kunit_module, so having optional arguments will
make my life a lot easier since I won't have to go through big
refactorings around the kernel to support new features that tie in
here.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
