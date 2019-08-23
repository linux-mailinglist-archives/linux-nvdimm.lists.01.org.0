Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1269B4F5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Aug 2019 18:56:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F10AE20215F4E;
	Fri, 23 Aug 2019 09:57:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1E23D2020F94A
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 09:57:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id c81so6803391pfc.11
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Eyf6j/gVXVMMGXLncNU6lJUKpGu2Lo5yONVStoS/vek=;
 b=e01cmg4z2qwwlBVZIjj4r36ADGh74/HeChPT4Xc3+xnauYALx3ljaOb6I0OHCgWFC6
 rQxkkwcba9H0Hwo+Qn77ABmG9DcTvYF8jibhnaTMPM1nrVdxNKZzEmIE/ikiUQByAdoH
 yzEmfG2SvpPGPU2xmVzi+3oSOWq4YxaRhM2q4S5p8J7KfJ7M8z/t0cYNHKqAKQJPb97d
 M0Sl3D1TCEATpmxYmpnyeLih62JNGKj1u5mYPI2u3NUgBY9qaF0H4OGOAhUUKn8kIoVI
 EUeI0F//okgpXz0iE6tX+sO6KYH2on7TpOEso17lY5c2LzqOvEhSxertM1ss+ZduvLJl
 Y+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Eyf6j/gVXVMMGXLncNU6lJUKpGu2Lo5yONVStoS/vek=;
 b=GtXyuXoKP+MAuXzp1C5xwlHp6N4DpXOt455Mh2Ly51cE0qOeiICjDpnbSzAJaWWszE
 MBSFphAeXIFY9UR8DH4I4iOU/rO8pS1RnIJVnXzKhe+cbXr3hks2ruELJdss75ZG19uW
 O1L+8jYqaWFN6WTS4twwKswdlKAc1bcy8kZjfgnxSj77XnQT893VNVxuyv42Up0cgLve
 0gsIfRTP+l79cIp10Sb7j3FE3oX3PhQLTgBGMW6FIzvAzKYNbq6OvdfO4GBWdjYAwJam
 shVXtnUbWMRdEDR+cDnZ7vJcDim4N24DjOCcSh7tIzVtT44FwcM10EVR2RFJvKpy0wr9
 bwIw==
X-Gm-Message-State: APjAAAX43PfM0xUahwLKgTpMBBh3OBduN+Ly4Mq+0ez/JtblHh7VN96c
 Bceyc7HOviQf/OwEWwHOV9BkCwQMByWdRjHe8byplA==
X-Google-Smtp-Source: APXvYqzUeOo2SBQqFHYb3fUN3a7IGUdSrb038esoP6u8HBz15ROwgjz1I/1KuXnhYobli1bMCbq38tH2g/9gUzXVvIY=
X-Received: by 2002:a63:eb51:: with SMTP id b17mr4695072pgk.384.1566579394591; 
 Fri, 23 Aug 2019 09:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
 <20190820232046.50175-10-brendanhiggins@google.com>
 <ae6722ce-80ac-5840-5c4b-6f6726e4239d@kernel.org>
In-Reply-To: <ae6722ce-80ac-5840-5c4b-6f6726e4239d@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 23 Aug 2019 09:56:23 -0700
Message-ID: <CAFd5g451bF2-RGZ3wT9gO1FOu+8e8yQO9evvxtQQ9Vkh4UUhVQ@mail.gmail.com>
Subject: Re: [PATCH v14 09/18] kunit: test: add support for test abort
To: shuah <shuah@kernel.org>
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
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
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
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Aug 23, 2019 at 8:36 AM shuah <shuah@kernel.org> wrote:
>
> Hi Brendan,
>
> On 8/20/19 5:20 PM, Brendan Higgins wrote:
> > Add support for aborting/bailing out of test cases, which is needed for
> > implementing assertions.
> >
> > An assertion is like an expectation, but bails out of the test case
> > early if the assertion is not met. The idea with assertions is that you
> > use them to state all the preconditions for your test. Logically
> > speaking, these are the premises of the test case, so if a premise isn't
> > true, there is no point in continuing the test case because there are no
> > conclusions that can be drawn without the premises. Whereas, the
> > expectation is the thing you are trying to prove.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >   include/kunit/test.h      |   2 +
> >   include/kunit/try-catch.h |  75 +++++++++++++++++++++
> >   kunit/Makefile            |   3 +-
> >   kunit/test.c              | 137 +++++++++++++++++++++++++++++++++-----
> >   kunit/try-catch.c         | 118 ++++++++++++++++++++++++++++++++
> >   5 files changed, 319 insertions(+), 16 deletions(-)
> >   create mode 100644 include/kunit/try-catch.h
> >   create mode 100644 kunit/try-catch.c
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 6917b186b737a..390ce02f717b6 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -10,6 +10,7 @@
> >   #define _KUNIT_TEST_H
> >
> >   #include <kunit/assert.h>
> > +#include <kunit/try-catch.h>
> >   #include <linux/kernel.h>
> >   #include <linux/slab.h>
> >   #include <linux/types.h>
> > @@ -167,6 +168,7 @@ struct kunit {
> >
> >       /* private: internal use only. */
> >       const char *name; /* Read only after initialization! */
> > +     struct kunit_try_catch try_catch;
> >       /*
> >        * success starts as true, and may only be set to false during a test
> >        * case; thus, it is safe to update this across multiple threads using
> > diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
> > new file mode 100644
> > index 0000000000000..404f336cbdc85
> > --- /dev/null
> > +++ b/include/kunit/try-catch.h
> > @@ -0,0 +1,75 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * An API to allow a function, that may fail, to be executed, and recover in a
> > + * controlled manner.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_TRY_CATCH_H
> > +#define _KUNIT_TRY_CATCH_H
> > +
> > +#include <linux/types.h>
> > +
> > +typedef void (*kunit_try_catch_func_t)(void *);
> > +
> > +struct completion;
> > +struct kunit;
> > +
> > +/**
> > + * struct kunit_try_catch - provides a generic way to run code which might fail.
> > + * @test: The test case that is currently being executed.
> > + * @try_completion: Completion that the control thread waits on while test runs.
> > + * @try_result: Contains any errno obtained while running test case.
> > + * @try: The function, the test case, to attempt to run.
> > + * @catch: The function called if @try bails out.
> > + * @context: used to pass user data to the try and catch functions.
> > + *
> > + * kunit_try_catch provides a generic, architecture independent way to execute
> > + * an arbitrary function of type kunit_try_catch_func_t which may bail out by
> > + * calling kunit_try_catch_throw(). If kunit_try_catch_throw() is called, @try
> > + * is stopped at the site of invocation and @catch is called.
> > + *
> > + * struct kunit_try_catch provides a generic interface for the functionality
> > + * needed to implement kunit->abort() which in turn is needed for implementing
> > + * assertions. Assertions allow stating a precondition for a test simplifying
> > + * how test cases are written and presented.
> > + *
> > + * Assertions are like expectations, except they abort (call
> > + * kunit_try_catch_throw()) when the specified condition is not met. This is
> > + * useful when you look at a test case as a logical statement about some piece
> > + * of code, where assertions are the premises for the test case, and the
> > + * conclusion is a set of predicates, rather expectations, that must all be
> > + * true. If your premises are violated, it does not makes sense to continue.
> > + */
> > +struct kunit_try_catch {
> > +     /* private: internal use only. */
> > +     struct kunit *test;
> > +     struct completion *try_completion;
> > +     int try_result;
> > +     kunit_try_catch_func_t try;
> > +     kunit_try_catch_func_t catch;
> > +     void *context;
> > +};
> > +
> > +void kunit_try_catch_init(struct kunit_try_catch *try_catch,
> > +                       struct kunit *test,
> > +                       kunit_try_catch_func_t try,
> > +                       kunit_try_catch_func_t catch);
> > +
> > +void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context);
> > +
> > +void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch);
> > +
> > +static inline int kunit_try_catch_get_result(struct kunit_try_catch *try_catch)
> > +{
> > +     return try_catch->try_result;
> > +}
> > +
> > +/*
> > + * Exposed for testing only.
> > + */
> > +void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch);
> > +
> > +#endif /* _KUNIT_TRY_CATCH_H */
> > diff --git a/kunit/Makefile b/kunit/Makefile
> > index 4e46450bcb3a8..c9176c9c578c6 100644
> > --- a/kunit/Makefile
> > +++ b/kunit/Makefile
> > @@ -1,6 +1,7 @@
> >   obj-$(CONFIG_KUNIT) +=                      test.o \
> >                                       string-stream.o \
> > -                                     assert.o
> > +                                     assert.o \
> > +                                     try-catch.o
> >
> >   obj-$(CONFIG_KUNIT_TEST) +=         string-stream-test.o
> >
> > diff --git a/kunit/test.c b/kunit/test.c
> > index 3cbceb34b3b36..ded9895143209 100644
> > --- a/kunit/test.c
> > +++ b/kunit/test.c
> > @@ -7,7 +7,9 @@
> >    */
> >
> >   #include <kunit/test.h>
> > +#include <kunit/try-catch.h>
> >   #include <linux/kernel.h>
> > +#include <linux/sched/debug.h>
> >
> >   static void kunit_set_failure(struct kunit *test)
> >   {
> > @@ -162,6 +164,19 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
> >       WARN_ON(string_stream_destroy(stream));
> >   }
> >
> > +static void __noreturn kunit_abort(struct kunit *test)
> > +{
> > +     kunit_try_catch_throw(&test->try_catch); /* Does not return. */
> > +
> > +     /*
> > +      * Throw could not abort from test.
> > +      *
> > +      * XXX: we should never reach this line! As kunit_try_catch_throw is
> > +      * marked __noreturn.
> > +      */
> > +     BUG();
>
>
> I recall discussion on this. What's the point in keeping thie
> BUG() around when it doesn't even reach? It can even be a
> WARN_ON() in that case right?

Originally I had BUG() here, and Frank (I think it was Frank, sorry it
was a while ago) told me it should be WARN_ON(). In v12 Stephen told
me it should be BUG(), and nobody objected so I went back to making it
a BUG() (note I also mentioned this change on the cover letter of v13
and still no one objected).

You can see the most recent discussion with Stephen here:
https://lore.kernel.org/linux-kselftest/20190812182421.141150-1-brendanhiggins@google.com/T/#mb108adc525092dd72fd3368ecae34251bad29edf

Cheers
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
