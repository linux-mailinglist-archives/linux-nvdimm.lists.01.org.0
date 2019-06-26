Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D31355CCC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 02:07:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F2C2F212A36F3;
	Tue, 25 Jun 2019 17:07:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 33F09212A36D2
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 17:07:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k13so233255pgq.9
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 17:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0CKSZbZdZTCXDsFevmx6xy0jVDdxhx+j1rEEB3vl63s=;
 b=Udp0DSI1eicbAQ93CL5kbvi8Xp/6zCCrOWD+4my5+Z2KobfpntEZptXwNDN+m1HYdl
 aWzrSvRzjBSRt+1Ke5gfgolTpuldTSDWCwjjFSm2u0fallCYK2AWnGnpndlL89sFN0Zl
 GTwNluZIxE+q2xxZzY/SPhBF2gsVikHJ199bU9KJdjOqqrHUctG5Or1EMQYsJztcsOoC
 DiYGphxIA91H14nI8J5aNbvthpK6V9fOCpd2OHMJOcinqK81dIeXjiZaAKjLmKAP2Jwx
 0nEa6ArcVSNjpUjZHNws6GQlmspmdwUJ/ZxXDeWnV3qF6zllsbtRDaXwGrbAJh9mZIai
 k2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0CKSZbZdZTCXDsFevmx6xy0jVDdxhx+j1rEEB3vl63s=;
 b=Q0fCgK1Q+0Aia4mGqEK1jmqcucBkrd/cwOlg1bWqx4SWInHl8nrVhy2ARimlh3bIcg
 LlM8H5R2vSu9xvbRsvYNXLCC5jvxe40PJr9YeP4xmMy21qNbx9ziY/sHmm4CGIOIB5jK
 enDhJtF0xah6U+2vEPLlsf6tHkjCfxZ3XVZ90KAjllTg9UGfL3aAE7djiuXf4IGwsVmh
 7TwME4vsSSvwpasAXjVN4IZYTvDzPYEHG+Sj2R+q6gJxh7IKYLplPvdKQlVDpzj0lfq7
 o/A9RbtYnmHZBDIq0+W7d8sKHPa5rWFl6D5TEWlUsBVELyhL4BDks7aZq8wwgHQwsJ3b
 UVYg==
X-Gm-Message-State: APjAAAXWRHlvqJqA1YF5VQv8BsYKypdgKsEf3NRBZ2GXgj2JhaiUEvHl
 76UC+V+3kQnXBhTOXEWPUbuDp70/3hJNA0xz4MruGg==
X-Google-Smtp-Source: APXvYqwFUlf+fXcTuEW4suwRhf8sO2Hw8q7BLLIj3tSrVcwKVl/cK8K/AXXabwkRnwCip/wX7DtGYsxR83H1S/Y9Z64=
X-Received: by 2002:a17:90a:be0d:: with SMTP id
 a13mr657604pjs.84.1561507663974; 
 Tue, 25 Jun 2019 17:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190625223312.GP19023@42.do-not-panic.com>
In-Reply-To: <20190625223312.GP19023@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 25 Jun 2019 17:07:32 -0700
Message-ID: <CAFd5g46TLAONgXiZkFM98BPd-sariMTwhmYG9hSJ+M9=r-ixeg@mail.gmail.com>
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

On Tue, Jun 25, 2019 at 3:33 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 01:25:56AM -0700, Brendan Higgins wrote:
> > +/**
> > + * module_test() - used to register a &struct kunit_module with KUnit.
> > + * @module: a statically allocated &struct kunit_module.
> > + *
> > + * Registers @module with the test framework. See &struct kunit_module for more
> > + * information.
> > + */
> > +#define module_test(module) \
> > +             static int module_kunit_init##module(void) \
> > +             { \
> > +                     return kunit_run_tests(&module); \
> > +             } \
> > +             late_initcall(module_kunit_init##module)
>
> Becuase late_initcall() is used, if these modules are built-in, this
> would preclude the ability to test things prior to this part of the
> kernel under UML or whatever architecture runs the tests. So, this
> limits the scope of testing. Small detail but the scope whould be
> documented.

You aren't the first person to complain about this (and I am not sure
it is the first time you have complained about it). Anyway, I have
some follow on patches that will improve the late_initcall thing, and
people seemed okay with discussing the follow on patches as part of a
subsequent patchset after this gets merged.

I will nevertheless document the restriction until then.

> > +static void kunit_print_tap_version(void)
> > +{
> > +     if (!kunit_has_printed_tap_version) {
> > +             kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
>
> What is this TAP thing? Why should we care what version it is on?
> Why are we printing this?

It's part of the TAP specification[1]. Greg and Frank asked me to make
the intermediate format conform to TAP. Seems like something else I
should probable document...

> > +             kunit_has_printed_tap_version = true;
> > +     }
> > +}
> > +
> > +static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> > +{
> > +     struct kunit_case *test_case;
> > +     size_t len = 0;
> > +
> > +     for (test_case = test_cases; test_case->run_case; test_case++)
>
> If we make the last test case NULL, we'd just check for test_case here,
> and save ourselves an extra few bytes per test module. Any reason why
> the last test case cannot be NULL?

Is there anyway to make that work with a statically defined array?

Basically, I want to be able to do something like:

static struct kunit_case example_test_cases[] = {
        KUNIT_CASE(example_simple_test),
        KUNIT_CASE(example_mock_test),
        {}
};

FYI,
#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }

In order to do what you are proposing, I think I need an array of
pointers to test cases, which is not ideal.

> > +void kunit_init_test(struct kunit *test, const char *name)
> > +{
> > +     spin_lock_init(&test->lock);
> > +     test->name = name;
> > +     test->success = true;
> > +}
> > +
> > +/*
> > + * Performs all logic to run a test case.
> > + */
> > +static void kunit_run_case(struct kunit_module *module,
> > +                        struct kunit_case *test_case)
> > +{
> > +     struct kunit test;
> > +     int ret = 0;
> > +
> > +     kunit_init_test(&test, test_case->name);
> > +
> > +     if (module->init) {
> > +             ret = module->init(&test);
>
> I believe if we used struct kunit_module *kmodule it would be much
> clearer who's init this is.

That's reasonable. I will fix in next revision.

Cheers!

[1] https://github.com/TestAnything/Specification/blob/tap-14-specification/specification.md
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
