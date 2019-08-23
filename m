Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2319B56E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Aug 2019 19:28:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0AB7C20215F56;
	Fri, 23 Aug 2019 10:30:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A2FBA20215F42
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 10:30:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l21so6122152pgm.3
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JpGZpvS6y7xgN7XnzsEu5TdSqjOQTKTe7TuWBgzpXxk=;
 b=DPbWDrNSkF3m3LM0LR49Pzw0ikWe08dHQLzlDwCCEd7SbY6lXjBe4g0E0/Oh0SS+8L
 1E2R3whjpm/iFQXBpTT4okhqcaJ9ZnLIQH02NXVEugo9GHSE50Jg8iFRbsmg/FsPppnw
 MrLpLS4WEb0jVHfL7Ku4uZCHChd+71dF0jelCrk2VXPZsc/GseLHkRq3LfohfXHpj4oa
 AeTShyhb7KisbZpowlWSJWUH5/NPhwM3qX6O9qpBe+sFL60yTW4cJ4vUQwBWpprLutHO
 5jYbqQDNL1N504EYpXBVjn24evq+dP/NDByqBukweHmVAjQPQCqMp6Hlv66N/RkoT59S
 yfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JpGZpvS6y7xgN7XnzsEu5TdSqjOQTKTe7TuWBgzpXxk=;
 b=kVxMf5rTpKXkq08NS24oBMFH8GFsCnJqHnQByzm6yWi5t91PLNhbCtUlh+SJX8SO3J
 RuQI1GMjiAKORYhUAYJI5k1YqL6ZGsqSY46qFR3KiPAeO7sjMGaFiMq1Id+7RjyHft6l
 z0GFFIVhOrHL8peXwQ6QWsl0BdAtAi0lk1kpYOEMLiTha8XD+Uf924YXcEL8z3D5+7+J
 03dUohEOEoiGq9iWO8OJjolZhPI9CggAl4FgulTX3L0E6UcaQSchPHr5ks2SHuT2Cj+q
 Db3oqJF6HfWl0wt4MS4RC93qbQaV5kQ6anHRX3nVEIluN0uPZXDebkvNo/YU40H0Wub2
 xHdw==
X-Gm-Message-State: APjAAAX/Po6z+A6WflSlO5ULlvNLoPWcq98oYAi2yiKdE+AV7fu4R4Ks
 liPIkhV1rPdwH1ldh2X1FI/+smELx/Pp671UBIdJWg==
X-Google-Smtp-Source: APXvYqxO41uhCLsTUJZzB3icsTW0bMGI+WWDOYyKC539Pf/Fhot22x5RnB49yWHNSNlX8BLD0YS+A9/mQTKWddz6BQY=
X-Received: by 2002:a63:b919:: with SMTP id z25mr4863766pge.201.1566581281074; 
 Fri, 23 Aug 2019 10:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
 <20190820232046.50175-2-brendanhiggins@google.com>
 <7f2c8908-75f6-b793-7113-ad57c51777ce@kernel.org>
 <CAFd5g44mRK9t4f58i_YMEt=e9RTxwrrhFY_V2LW_E7bUwR3cdg@mail.gmail.com>
 <4513d9f3-a69b-a9a4-768b-86c2962b62e0@kernel.org>
In-Reply-To: <4513d9f3-a69b-a9a4-768b-86c2962b62e0@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 23 Aug 2019 10:27:49 -0700
Message-ID: <CAFd5g446J=cVW4QW+QeZMLDi+ANqshAW6KTrFFBTusPcdr6-GA@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] kunit: test: add KUnit test runner core
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

On Fri, Aug 23, 2019 at 10:05 AM shuah <shuah@kernel.org> wrote:
>
> On 8/23/19 10:48 AM, Brendan Higgins wrote:
> > On Fri, Aug 23, 2019 at 8:33 AM shuah <shuah@kernel.org> wrote:
> >>
> >> Hi Brendan,
> >>
> >> On 8/20/19 5:20 PM, Brendan Higgins wrote:
> >>> Add core facilities for defining unit tests; this provides a common way
> >>> to define test cases, functions that execute code which is under test
> >>> and determine whether the code under test behaves as expected; this also
> >>> provides a way to group together related test cases in test suites (here
> >>> we call them test_modules).
> >>>
> >>> Just define test cases and how to execute them for now; setting
> >>> expectations on code will be defined later.
> >>>
> >>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> >>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> >>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> >>> ---
> >>>    include/kunit/test.h | 179 ++++++++++++++++++++++++++++++++++++++++
> >>>    kunit/Kconfig        |  17 ++++
> >>>    kunit/Makefile       |   1 +
> >>>    kunit/test.c         | 191 +++++++++++++++++++++++++++++++++++++++++++
> >>>    4 files changed, 388 insertions(+)
> >>>    create mode 100644 include/kunit/test.h
> >>>    create mode 100644 kunit/Kconfig
> >>>    create mode 100644 kunit/Makefile
> >>>    create mode 100644 kunit/test.c
> >>>
> >>> diff --git a/include/kunit/test.h b/include/kunit/test.h
> >>> new file mode 100644
> >>> index 0000000000000..e0b34acb9ee4e
> >>> --- /dev/null
> >>> +++ b/include/kunit/test.h
> >>> @@ -0,0 +1,179 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +/*
> >>> + * Base unit test (KUnit) API.
> >>> + *
> >>> + * Copyright (C) 2019, Google LLC.
> >>> + * Author: Brendan Higgins <brendanhiggins@google.com>
> >>> + */
> >>> +
> >>> +#ifndef _KUNIT_TEST_H
> >>> +#define _KUNIT_TEST_H
> >>> +
> >>> +#include <linux/types.h>
> >>> +
> >>> +struct kunit;
> >>> +
> >>> +/**
> >>> + * struct kunit_case - represents an individual test case.
> >>> + * @run_case: the function representing the actual test case.
> >>> + * @name: the name of the test case.
> >>> + *
> >>> + * A test case is a function with the signature, ``void (*)(struct kunit *)``
> >>> + * that makes expectations (see KUNIT_EXPECT_TRUE()) about code under test. Each
> >>> + * test case is associated with a &struct kunit_suite and will be run after the
> >>> + * suite's init function and followed by the suite's exit function.
> >>> + *
> >>> + * A test case should be static and should only be created with the KUNIT_CASE()
> >>> + * macro; additionally, every array of test cases should be terminated with an
> >>> + * empty test case.
> >>> + *
> >>> + * Example:
> >>
> >> Can you fix these line continuations. It makes it very hard to read.
> >> Sorry for this late comment. These comments lines are longer than 80
> >> and wrap.
> >
> > None of the lines in this commit are over 80 characters in column
> > width. Some are exactly 80 characters (like above).
> >
> > My guess is that you are seeing the diff added text (+ ), which when
> > you add that to a line which is exactly 80 char in length ends up
> > being over 80 char in email. If you apply the patch you will see that
> > they are only 80 chars.
> >
> >>
> >> There are several comment lines in the file that are way too long.
> >
> > Note that checkpatch also does not complain about any over 80 char
> > lines in this file.
> >
> > Sorry if I am misunderstanding what you are trying to tell me. Please
> > confirm either way.
> >
>
> WARNING: Avoid unnecessary line continuations
> #258: FILE: include/kunit/test.h:137:
> +                */                                                            \
>
> total: 0 errors, 2 warnings, 388 lines checked

Ah, okay so you don't like the warning about the line continuation.
That's not because it is over 80 char, but because there is a line
continuation after a comment. I don't really see a way to get rid of
it without removing the comment from inside the macro.

I put this TODO there in the first place a Luis' request, and I put it
in the body of the macro because this macro already had a kernel-doc
comment and I didn't think that an implementation detail TODO belonged
in the user documentation.

> Go ahead fix these. It appears there are few lines that either longer
> than 80. In general, I keep them around 75, so it is easier read.

Sorry, the above is the only checkpatch warning other than the
reminder to update the MAINTAINERS file.

Are you saying you want me to go through and make all the lines fit in
75 char column width? I hope not because that is going to be a pretty
substantial change to make.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
