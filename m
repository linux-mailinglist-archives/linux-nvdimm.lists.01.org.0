Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2359B8ABBF
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 02:04:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 331DF2132996F;
	Mon, 12 Aug 2019 17:06:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6EB152131D59A
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 16:59:19 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 533E82063F;
 Mon, 12 Aug 2019 23:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565654221;
 bh=Bqdkmnp6mwn7+uGtiuDRkW/S4L7BPoXk0yV/X+vBL54=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=xH5Jr1y+zA4g2T4Lqz5yO5pV+3YI+m+g1R3ck6bSJoBiMnDkJSdrB5821koEnOM1x
 ozemBUqGL2ni/PA36r1U7ZN9xHwvK3C4GSABt23yhMwa/Dx7vomqnds0asZ6RIkXYl
 YOqHX4j25oAAbX9XJcyROx5ez17nbuRYexkCgIEQ=
MIME-Version: 1.0
In-Reply-To: <20190812182421.141150-6-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-6-brendanhiggins@google.com>
Subject: Re: [PATCH v12 05/18] kunit: test: add the concept of expectations
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com,
 gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org,
 robh@kernel.org, shuah@kernel.org, tytso@mit.edu,
 yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date: Mon, 12 Aug 2019 16:57:00 -0700
Message-Id: <20190812235701.533E82063F@mail.kernel.org>
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

Quoting Brendan Higgins (2019-08-12 11:24:08)
> Add support for expectations, which allow properties to be specified and
> then verified in tests.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Just some minor nits again.

> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d0bf112910caf..2625bcfeb19ac 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -9,8 +9,10 @@
>  #ifndef _KUNIT_TEST_H
>  #define _KUNIT_TEST_H
>  
> +#include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
> +#include <kunit/assert.h>

Can you alphabet sort these?

>  
>  struct kunit_resource;
>  
> @@ -319,4 +321,845 @@ void __printf(3, 4) kunit_printk(const char *level,
>  #define kunit_err(test, fmt, ...) \
>                 kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
>  
> +/*
> + * Generates a compile-time warning in case of comparing incompatible types.
> + */
> +#define __kunit_typecheck(lhs, rhs) \
> +       ((void) __typecheck(lhs, rhs))

Is there a reason why this can't be inlined and the __kunit_typecheck()
macro can't be removed?

> +
> +/**
> + * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
> + * @test: The test context object.
[...]
> + * @condition: an arbitrary boolean expression. The test fails when this does
> + * not evaluate to true.
> + *
> + * This and expectations of the form `KUNIT_EXPECT_*` will cause the test case
> + * to fail when the specified condition is not met; however, it will not prevent
> + * the test case from continuing to run; this is otherwise known as an
> + * *expectation failure*.
> + */
> +#define KUNIT_EXPECT_TRUE(test, condition) \
> +               KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)

A lot of these macros seem double indented.

> +
> +#define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)                      \
> +               KUNIT_TRUE_MSG_ASSERTION(test,                                 \
> +                                        KUNIT_EXPECTATION,                    \
> +                                        condition,                            \
> +                                        fmt,                                  \
> +                                        ##__VA_ARGS__)
> +
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
