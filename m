Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B958AE1E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 06:55:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83C3121311C06;
	Mon, 12 Aug 2019 21:57:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7F06A2130A510
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 21:57:27 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C1D6E206C2;
 Tue, 13 Aug 2019 04:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565672110;
 bh=sNs8Jd2xkQEsuQp9rhkHGchWAQJXpnxX1ZLCePCDf18=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=r6BR1VpnUPJtcLpxSN6MzduXH/yQRPwo8roQ2PhzFBwrjyUmuDeet29A/zAYIKzoB
 rXSL+H7vMbDJlLtVTxK+pxHOYx2XBv7vlL5PTxOzCH7sywF+WyBUoRmzmArBuhPF9v
 rnjMiiYeiR/EOunpx0iR0Cc/RMwL2jKukJ0nIsg4=
MIME-Version: 1.0
In-Reply-To: <20190812182421.141150-12-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-12-brendanhiggins@google.com>
Subject: Re: [PATCH v12 11/18] kunit: test: add the concept of assertions
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com,
 gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org,
 robh@kernel.org, shuah@kernel.org, tytso@mit.edu,
 yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date: Mon, 12 Aug 2019 21:55:09 -0700
Message-Id: <20190813045510.C1D6E206C2@mail.kernel.org>
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

Quoting Brendan Higgins (2019-08-12 11:24:14)
> Add support for assertions which are like expectations except the test
> terminates if the assertion is not satisfied.
> 
> The idea with assertions is that you use them to state all the
> preconditions for your test. Logically speaking, these are the premises
> of the test case, so if a premise isn't true, there is no point in
> continuing the test case because there are no conclusions that can be
> drawn without the premises. Whereas, the expectation is the thing you
> are trying to prove. It is not used universally in x-unit style test
> frameworks, but I really like it as a convention.  You could still
> express the idea of a premise using the above idiom, but I think
> KUNIT_ASSERT_* states the intended idea perfectly.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

> + * Sets an expectation that the values that @left and @right evaluate to are
> + * not equal. This is semantically equivalent to
> + * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
> + * for more information.
> + */
> +#define KUNIT_ASSERT_STRNEQ(test, left, right)                                \
> +               KUNIT_BINARY_STR_NE_ASSERTION(test,                            \
> +                                             KUNIT_ASSERTION,                 \
> +                                             left,                            \
> +                                             right)
> +
> +#define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)                  \
> +               KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,                        \
> +                                                 KUNIT_ASSERTION,             \
> +                                                 left,                        \
> +                                                 right,                       \
> +                                                 fmt,                         \

Same question about tabbing too.

> diff --git a/kunit/test-test.c b/kunit/test-test.c
> index 88f4cdf03db2a..058f3fb37458a 100644
> --- a/kunit/test-test.c
> +++ b/kunit/test-test.c
> @@ -78,11 +78,13 @@ static int kunit_try_catch_test_init(struct kunit *test)
>         struct kunit_try_catch_test_context *ctx;
>  
>         ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);

Ah ok. Question still stands if kunit_kzalloc() should just have the
assertion on failure.

>         test->priv = ctx;
>  
>         ctx->try_catch = kunit_kmalloc(test,
>                                        sizeof(*ctx->try_catch),
>                                        GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->try_catch);
>  
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
