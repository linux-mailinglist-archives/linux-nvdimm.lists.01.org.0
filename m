Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE6E69E42
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Jul 2019 23:26:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD5B0212B5F14;
	Mon, 15 Jul 2019 14:28:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 24D75211F35FF
 for <linux-nvdimm@lists.01.org>; Mon, 15 Jul 2019 14:28:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b13so8023004pfo.1
 for <linux-nvdimm@lists.01.org>; Mon, 15 Jul 2019 14:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L1iVnKb9KyH2VdRaa+1X1AxuS2MqitxfIlVlkn/kOv8=;
 b=OKadg9adfR8FnEoQT6HdGl96SBZxASHai1a3d6JJ7kS2KeuZ1gp/Sww0dZ4FNnRfmX
 dsWE9zqYktoShjIU+eYZsCRcFIJfFws6QoK2qlbR+qOq4rr/hOZP2M3LcnN2q482/I73
 uk9eNSjzCb/KkfhP4BJ2nmSyKV5xwGPcSeH7IrIsnT+SSVepNWQYB1x9JIyW2ECp5yWy
 v4jcSyoBZJSrmeWQFBgJn1mNjyDuuQcjVCEz7vy2pTS+5CwXEpnaX+c+7wd+NdqiTuWs
 jLfiDc8e4oMqUtNtGi1qAx20ReiWP9Qgxngtq/5EbA2D41xPwKDuHWOLS0EUq/G9lFRU
 uKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L1iVnKb9KyH2VdRaa+1X1AxuS2MqitxfIlVlkn/kOv8=;
 b=sAo+ain4eS1Y17y5WIrO1fAmqrUMCedK0UAbPo3HufNk5cvKGIQyWAnMQJVMb8lSWC
 uxWCqU2LmQYCzS2lKcqwQ9ADKjwoT1l3bHnTNwcsR7v9Xqnv77A71oUp4hSBux/+wzUu
 a0IVpx8WfC/f3vNhNDYobToo+t+ZuWaIJ0V3Wc/Nf35LXC8GXUeb6jwuZAqRb6OaOvan
 iPXMZMV1gh+gYhcSDd5T4DFzrhd37KystyybxcKDmKga8TgyOF2g9IgcwmCE/ndombO5
 YPeGnu7tJxzt8MaGBb9g39NYfv2b+C1YuHW433d4Di0FdlsOwRRM/4YfXShRCPu/gGf4
 NmTw==
X-Gm-Message-State: APjAAAX3L5KTdfDG3E/kswMam40IMMk2n3vLa8rUnI7aN5IAZA3hosV5
 EyGUxqK0yqxIni0fMbWqxcmY++hdeou3mZULPJ70gA==
X-Google-Smtp-Source: APXvYqxYpwH7M9Tn69WNYt23pvYEmwOFSLt2yT+zRsvwVW6B093wD7DIpVEsyGIo3whwBHoCVELofo1GZGIk7QmjTys=
X-Received: by 2002:a63:205f:: with SMTP id r31mr29138784pgm.159.1563225956600; 
 Mon, 15 Jul 2019 14:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-2-brendanhiggins@google.com>
 <20190715201054.C69AA2086C@mail.kernel.org>
In-Reply-To: <20190715201054.C69AA2086C@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 15 Jul 2019 14:25:45 -0700
Message-ID: <CAFd5g44kWHYceo85qxL98JKH2FYBwVLFuLzqNR+APpMC1aKWUQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/18] kunit: test: add KUnit test runner core
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

On Mon, Jul 15, 2019 at 1:10 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-12 01:17:27)
> > Add core facilities for defining unit tests; this provides a common way
> > to define test cases, functions that execute code which is under test
> > and determine whether the code under test behaves as expected; this also
> > provides a way to group together related test cases in test suites (here
> > we call them test_modules).
> >
> > Just define test cases and how to execute them for now; setting
> > expectations on code will be defined later.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> Minor nits below.
>
> > diff --git a/kunit/test.c b/kunit/test.c
> > new file mode 100644
> > index 0000000000000..571e4c65deb5c
> > --- /dev/null
> > +++ b/kunit/test.c
> > @@ -0,0 +1,189 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Base unit test (KUnit) API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <kunit/test.h>
> > +
> > +static void kunit_set_failure(struct kunit *test)
> > +{
> > +       WRITE_ONCE(test->success, false);
> > +}
> > +
> [...]
> > +
> > +void kunit_init_test(struct kunit *test, const char *name)
> > +{
> > +       test->name = name;
> > +       test->success = true;
> > +}
> > +
> > +/*
> > + * Performs all logic to run a test case.
> > + */
> > +static void kunit_run_case(struct kunit_suite *suite,
> > +                          struct kunit_case *test_case)
> > +{
> > +       struct kunit test;
> > +       int ret = 0;
> > +
> > +       kunit_init_test(&test, test_case->name);
> > +
> > +       if (suite->init) {
> > +               ret = suite->init(&test);
>
> Can you push the ret definition into this if scope? That way we can
> avoid default initialize to 0 for it.

Sure! I would actually prefer that from a cosmetic standpoint. I just
thought that mixing declarations and code was against the style guide.

> > +               if (ret) {
> > +                       kunit_err(&test, "failed to initialize: %d\n", ret);
> > +                       kunit_set_failure(&test);
>
> Do we need to 'test_case->success = test.success' here too? Or is the
> test failure extracted somewhere else?

Er, yes. That's kind of embarrassing. Good catch.

> > +                       return;
> > +               }
> > +       }
> > +
> > +       test_case->run_case(&test);
> > +
> > +       if (suite->exit)
> > +               suite->exit(&test);
> > +
> > +       test_case->success = test.success;

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
