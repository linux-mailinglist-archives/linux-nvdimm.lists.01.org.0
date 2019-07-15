Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7AC69C64
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Jul 2019 22:10:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B29521A070B8;
	Mon, 15 Jul 2019 13:13:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6535F212AB4CB
 for <linux-nvdimm@lists.01.org>; Mon, 15 Jul 2019 13:13:23 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C69AA2086C;
 Mon, 15 Jul 2019 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563221454;
 bh=VRTZWx/5sKJHdH3qQkzEYYxjC5JMv+S2b65daQVUdGU=;
 h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
 b=JQmD4doZtzPy2RsxVJTfXU4+HVaWbuij6HH8oF8RC7zWY3b+zfLb6BjosM4nFE8Zv
 mrb4jXugiyvntNyKdYloWJPzuahddLnXpqJKuYJRQSRO/Vb9WmX1qLLp99cO9XQ/uR
 gs7n762HrytDofL3ccz7u/kjKohqqEh0qv06XoyM=
MIME-Version: 1.0
In-Reply-To: <20190712081744.87097-2-brendanhiggins@google.com>
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-2-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com,
 gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org,
 robh@kernel.org, shuah@kernel.org, tytso@mit.edu,
 yamada.masahiro@socionext.com
Subject: Re: [PATCH v9 01/18] kunit: test: add KUnit test runner core
User-Agent: alot/0.8.1
Date: Mon, 15 Jul 2019 13:10:53 -0700
Message-Id: <20190715201054.C69AA2086C@mail.kernel.org>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org,
 linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com,
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Quoting Brendan Higgins (2019-07-12 01:17:27)
> Add core facilities for defining unit tests; this provides a common way
> to define test cases, functions that execute code which is under test
> and determine whether the code under test behaves as expected; this also
> provides a way to group together related test cases in test suites (here
> we call them test_modules).
> 
> Just define test cases and how to execute them for now; setting
> expectations on code will be defined later.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Minor nits below.

> diff --git a/kunit/test.c b/kunit/test.c
> new file mode 100644
> index 0000000000000..571e4c65deb5c
> --- /dev/null
> +++ b/kunit/test.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base unit test (KUnit) API.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <kunit/test.h>
> +
> +static void kunit_set_failure(struct kunit *test)
> +{
> +       WRITE_ONCE(test->success, false);
> +}
> +
[...]
> +
> +void kunit_init_test(struct kunit *test, const char *name)
> +{
> +       test->name = name;
> +       test->success = true;
> +}
> +
> +/*
> + * Performs all logic to run a test case.
> + */
> +static void kunit_run_case(struct kunit_suite *suite,
> +                          struct kunit_case *test_case)
> +{
> +       struct kunit test;
> +       int ret = 0;
> +
> +       kunit_init_test(&test, test_case->name);
> +
> +       if (suite->init) {
> +               ret = suite->init(&test);

Can you push the ret definition into this if scope? That way we can
avoid default initialize to 0 for it.

> +               if (ret) {
> +                       kunit_err(&test, "failed to initialize: %d\n", ret);
> +                       kunit_set_failure(&test);

Do we need to 'test_case->success = test.success' here too? Or is the
test failure extracted somewhere else?

> +                       return;
> +               }
> +       }
> +
> +       test_case->run_case(&test);
> +
> +       if (suite->exit)
> +               suite->exit(&test);
> +
> +       test_case->success = test.success;
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
