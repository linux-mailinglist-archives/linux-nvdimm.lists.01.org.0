Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5B7558CE
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Jun 2019 22:28:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7706F212A36D3;
	Tue, 25 Jun 2019 13:28:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 86C2B2129F0E3
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 13:28:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id c85so18689pfc.1
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qq39ykktkvFBpmzRtbgM4tstWpOedFNE8kr26lh/InM=;
 b=ni94OwioZx/gzf2szVloCDZTFFpJCo2YKSFZ2X9qr6bxYnBeEpnnagfszyXnnz51L8
 DkJXaethFUsoHnz8KOQVG2ZSAlP6R4YiehiVV+cY7fw97Xus3XNQzLPLdgQULmgYaWnL
 GEAS55DRith5+cQIVd4nDD9PnOpK5SEC0mcAjXyMYNE83XKQ2Jfbx9GzYoD6pnR9q88y
 VjAnVY+gy9KsY/4+Tbda/+4DRlDyvSks4s9chgBxuZrKHnC3t/s2Oqm9eCfJpWO+nPcJ
 ixgXgEVA9P9D5QKdeUq3VIirHZ16lxLB0iDdlrfqM9fruDTYYR+l+8zODcodp3flRnlv
 dArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qq39ykktkvFBpmzRtbgM4tstWpOedFNE8kr26lh/InM=;
 b=agldTlx5KoYQ0soMrnGd1vUFVY2cNcQcUuaUz13VpuohLAXd3hWfWXh2IcPIEcQ05l
 ygf6AaPRDiv8zx30VdZGnHvzmS03qGSnQJEwJJTSL5sS2dNdFnTICXbsdbsMPWUK2UOS
 YTCM4m7zYVAWOaAp1lW0qrcMg2BK60fkYJP57p0ZNmdoQBemf1s7kNZYWiP7diPsJPeh
 zeb7LCSEKXixUd/VP+/3TEJJKaMEuU6ss2REomIWvG9myX5bjk0VToDhebdM/SRqN14r
 9YJvxNdIW1ZXhabNmtVb1tSRVcPg4f0sXxzN/A+wgICHYXcQHSoZ8IZ+DOVB4Q8BvYAM
 cckA==
X-Gm-Message-State: APjAAAWRrKJBbfV5vHMfTzEkxAwlbAtl3QWNAn+rAX3sFnklrVV7D/2k
 FhEEe87QM3gJkWFtS4XXF2Vr+CZRMF6jeSe6N+DQNA==
X-Google-Smtp-Source: APXvYqzvk20XXdVFtm6zl0X1nrjaH0TttItfcdP9iwaQ+JKQIeNhKF1pa7VSVvlXNPpMAUzP/tv1oR2JBEXuSnWnLw4=
X-Received: by 2002:a17:90b:f0e:: with SMTP id
 br14mr754020pjb.117.1561494516332; 
 Tue, 25 Jun 2019 13:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190620001526.93426218BE@mail.kernel.org>
In-Reply-To: <20190620001526.93426218BE@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 25 Jun 2019 13:28:25 -0700
Message-ID: <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
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

On Wed, Jun 19, 2019 at 5:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-06-17 01:25:56)
> > diff --git a/kunit/test.c b/kunit/test.c
> > new file mode 100644
> > index 0000000000000..d05d254f1521f
> > --- /dev/null
> > +++ b/kunit/test.c
> > @@ -0,0 +1,210 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Base unit test (KUnit) API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <linux/sched/debug.h>
> > +#include <kunit/test.h>
> > +
> > +static bool kunit_get_success(struct kunit *test)
> > +{
> > +       unsigned long flags;
> > +       bool success;
> > +
> > +       spin_lock_irqsave(&test->lock, flags);
> > +       success = test->success;
> > +       spin_unlock_irqrestore(&test->lock, flags);
>
> I still don't understand the locking scheme in this code. Is the
> intention to make getter and setter APIs that are "safe" by adding in a
> spinlock that is held around getting and setting various members in the
> kunit structure?

Yes, your understanding is correct. It is possible for a user to write
a test such that certain elements may be updated in different threads;
this would most likely happen in the case where someone wants to make
an assertion or an expectation in a thread created by a piece of code
under test. Although this should generally be avoided, it is possible,
and there are occasionally good reasons to do so, so it is
functionality that we should support.

Do you think I should add a comment to this effect?

> In what situation is there more than one thread reading or writing the
> kunit struct? Isn't it only a single process that is going to be

As I said above, it is possible that the code under test may spawn a
new thread that may make an expectation or an assertion. It is not a
super common use case, but it is possible.

> operating on this structure? And why do we need to disable irqs? Are we
> expecting to be modifying the unit tests from irq contexts?

There are instances where someone may want to test a driver which has
an interrupt handler in it. I actually have (not the greatest) example
here. Now in these cases, I expect someone to use a mock irqchip or
some other fake mechanism to trigger the interrupt handler and not
actual hardware; technically speaking in this case, it is not going to
be accessed from a "real" irq context; however, the code under test
should think that it is in an irq context; given that, I figured it is
best to just treat it as a real irq context. Does that make sense?

> > +
> > +       return success;
> > +}
> > +
> > +static void kunit_set_success(struct kunit *test, bool success)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&test->lock, flags);
> > +       test->success = success;
> > +       spin_unlock_irqrestore(&test->lock, flags);
> > +}
> > +
> > +static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> > +{
> > +       return vprintk_emit(0, level, NULL, 0, fmt, args);
> > +}
> > +
> > +static int kunit_printk_emit(int level, const char *fmt, ...)
> > +{
> > +       va_list args;
> > +       int ret;
> > +
> > +       va_start(args, fmt);
> > +       ret = kunit_vprintk_emit(level, fmt, args);
> > +       va_end(args);
> > +
> > +       return ret;
> > +}
> > +
> > +static void kunit_vprintk(const struct kunit *test,
> > +                         const char *level,
> > +                         struct va_format *vaf)
> > +{
> > +       kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> > +}
> > +
> > +static bool kunit_has_printed_tap_version;
>
> Can you please move this into function local scope in the function
> below?

Sure, that makes sense.

> > +
> > +static void kunit_print_tap_version(void)
> > +{
> > +       if (!kunit_has_printed_tap_version) {
> > +               kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
> > +               kunit_has_printed_tap_version = true;
> > +       }
> > +}
> > +
> [...]
> > +
> > +static bool kunit_module_has_succeeded(struct kunit_module *module)
> > +{
> > +       const struct kunit_case *test_case;
> > +       bool success = true;
> > +
> > +       for (test_case = module->test_cases; test_case->run_case; test_case++)
> > +               if (!test_case->success) {
> > +                       success = false;
> > +                       break;
>
> Why not 'return false'?

Also a good point. Will fix.

> > +               }
> > +
> > +       return success;
>
> And 'return true'?

Will fix.

> > +}
> > +
> > +static size_t kunit_module_counter = 1;
> > +
> > +static void kunit_print_subtest_end(struct kunit_module *module)
> > +{
> > +       kunit_print_ok_not_ok(false,
> > +                             kunit_module_has_succeeded(module),
> > +                             kunit_module_counter++,
> > +                             module->name);
> > +}
> > +
> > +static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
> > +                                           size_t test_number)
> > +{
> > +       kunit_print_ok_not_ok(true,
> > +                             test_case->success,
> > +                             test_number,
> > +                             test_case->name);
> > +}
> > +
> > +void kunit_init_test(struct kunit *test, const char *name)
> > +{
> > +       spin_lock_init(&test->lock);
> > +       test->name = name;
> > +       test->success = true;
> > +}
> > +
> > +/*
> > + * Performs all logic to run a test case.
> > + */
> > +static void kunit_run_case(struct kunit_module *module,
> > +                          struct kunit_case *test_case)
> > +{
> > +       struct kunit test;
> > +       int ret = 0;
> > +
> > +       kunit_init_test(&test, test_case->name);
> > +
> > +       if (module->init) {
> > +               ret = module->init(&test);
> > +               if (ret) {
> > +                       kunit_err(&test, "failed to initialize: %d\n", ret);
> > +                       kunit_set_success(&test, false);
> > +                       return;
> > +               }
> > +       }
> > +
> > +       if (!ret)
> > +               test_case->run_case(&test);
>
> Do we need this if condition? ret can only be set to non-zero above but
> then we'll exit the function early so it seems unnecessary. Given that,
> ret should probably be moved into the module->init path.

Whoops. Sorry, another instance of how it evolved over time and I
forgot why I did the check. Will fix.

> > +
> > +       if (module->exit)
> > +               module->exit(&test);
> > +
> > +       test_case->success = kunit_get_success(&test);
> > +}
> > +

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
