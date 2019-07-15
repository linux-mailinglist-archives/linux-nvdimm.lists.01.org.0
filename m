Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581569EC9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Jul 2019 00:15:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 258F821962301;
	Mon, 15 Jul 2019 15:18:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 35AB2212B6D56
 for <linux-nvdimm@lists.01.org>; Mon, 15 Jul 2019 15:18:23 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8417320665;
 Mon, 15 Jul 2019 22:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563228954;
 bh=i+e+XmewuTOKZMYujCCinWE6HQCvbqktbBhowFdAdPg=;
 h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
 b=nit3wmf2HR893QM2K8DruIfSbcU7b/R5ef7zr8W96bJJyHcozB5YCZpfps75qxqEO
 oicHCnXQygK86xyEFQeyuPLu1I0HibYMiVLkrgmRaDPIEiL9kInXH2fdL5MKbiGjz1
 8gYmu0T+bLrbzSn3Rx2ZadHnq+yjFPagC4HFhmqk=
MIME-Version: 1.0
In-Reply-To: <20190712081744.87097-5-brendanhiggins@google.com>
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-5-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com,
 gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org,
 robh@kernel.org, shuah@kernel.org, tytso@mit.edu,
 yamada.masahiro@socionext.com
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like
 logger
User-Agent: alot/0.8.1
Date: Mon, 15 Jul 2019 15:15:53 -0700
Message-Id: <20190715221554.8417320665@mail.kernel.org>
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

Quoting Brendan Higgins (2019-07-12 01:17:30)
> diff --git a/include/kunit/kunit-stream.h b/include/kunit/kunit-stream.h
> new file mode 100644
> index 0000000000000..a7b53eabf6be4
> --- /dev/null
> +++ b/include/kunit/kunit-stream.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * C++ stream style string formatter and printer used in KUnit for outputting
> + * KUnit messages.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#ifndef _KUNIT_KUNIT_STREAM_H
> +#define _KUNIT_KUNIT_STREAM_H
> +
> +#include <linux/types.h>
> +#include <kunit/string-stream.h>
> +
> +struct kunit;
> +
> +/**
> + * struct kunit_stream - a std::stream style string builder.
> + *
> + * A std::stream style string builder. Allows messages to be built up and
> + * printed all at once.
> + */
> +struct kunit_stream {
> +       /* private: internal use only. */
> +       struct kunit *test;
> +       const char *level;

Is the level changed? See my comment below, but I wonder if this whole
struct can go away and the wrappers can just operate on 'struct
string_stream' instead.

> +       struct string_stream *internal_stream;
> +};
> diff --git a/kunit/kunit-stream.c b/kunit/kunit-stream.c
> new file mode 100644
> index 0000000000000..8bea1f22eafb5
> --- /dev/null
> +++ b/kunit/kunit-stream.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * C++ stream style string formatter and printer used in KUnit for outputting
> + * KUnit messages.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <kunit/kunit-stream.h>
> +#include <kunit/string-stream.h>
> +
> +void kunit_stream_add(struct kunit_stream *kstream, const char *fmt, ...)
> +{
> +       va_list args;
> +       struct string_stream *stream = kstream->internal_stream;
> +
> +       va_start(args, fmt);
> +
> +       if (string_stream_vadd(stream, fmt, args) < 0)
> +               kunit_err(kstream->test,
> +                         "Failed to allocate fragment: %s\n",
> +                         fmt);
> +
> +       va_end(args);
> +}
> +
> +void kunit_stream_append(struct kunit_stream *kstream,
> +                               struct kunit_stream *other)
> +{
> +       struct string_stream *other_stream = other->internal_stream;
> +       const char *other_content;
> +
> +       other_content = string_stream_get_string(other_stream);
> +
> +       if (!other_content) {
> +               kunit_err(kstream->test,
> +                         "Failed to get string from second argument for appending\n");
> +               return;
> +       }
> +
> +       kunit_stream_add(kstream, other_content);
> +}

Why can't this function be implemented in the string_stream API? Seems
valid to want to append one stream to another and that isn't
kunit_stream specific.

> +
> +void kunit_stream_clear(struct kunit_stream *kstream)
> +{
> +       string_stream_clear(kstream->internal_stream);
> +}
> +
> +void kunit_stream_commit(struct kunit_stream *kstream)
> +{
> +       struct string_stream *stream = kstream->internal_stream;
> +       struct string_stream_fragment *fragment;
> +       struct kunit *test = kstream->test;
> +       char *buf;
> +
> +       buf = string_stream_get_string(stream);
> +       if (!buf) {
> +               kunit_err(test,
> +                         "Could not allocate buffer, dumping stream:\n");
> +               list_for_each_entry(fragment, &stream->fragments, node) {
> +                       kunit_err(test, fragment->fragment);
> +               }
> +               kunit_err(test, "\n");
> +               goto cleanup;
> +       }
> +
> +       kunit_printk(kstream->level, test, buf);
> +       kfree(buf);
> +
> +cleanup:

Drop the goto and use an 'else' please.

> +       kunit_stream_clear(kstream);
> +}
> +
> +static int kunit_stream_init(struct kunit_resource *res, void *context)
> +{
> +       struct kunit *test = context;
> +       struct kunit_stream *stream;
> +
> +       stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> +       if (!stream)
> +               return -ENOMEM;
> +
> +       res->allocation = stream;
> +       stream->test = test;
> +       stream->internal_stream = alloc_string_stream(test);
> +
> +       if (!stream->internal_stream)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static void kunit_stream_free(struct kunit_resource *res)
> +{
> +       struct kunit_stream *stream = res->allocation;
> +
> +       if (!string_stream_is_empty(stream->internal_stream)) {
> +               kunit_err(stream->test,
> +                         "End of test case reached with uncommitted stream entries\n");
> +               kunit_stream_commit(stream);
> +       }
> +}
> +

Nitpick: Drop this extra newline.

> diff --git a/kunit/test.c b/kunit/test.c
> index f165c9d8e10b0..29edf34a89a37 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
> @@ -120,6 +120,12 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
>                               test_case->name);
>  }
>  
> +void kunit_fail(struct kunit *test, struct kunit_stream *stream)

Why doesn't 'struct kunit' have a 'struct kunit_stream' inside of it? It
seems that the two are highly related, to the point that it might just
make sense to have

	struct kunit {
		struct kunit_stream stream;
		...
	};

> +{
> +       kunit_set_failure(test);
> +       kunit_stream_commit(stream);

And then this function can just take a test and the stream can be
associated with the test directly. Use container_of() to get to the test
when the only pointer in hand is for the stream too.

> +}
> +
>  void kunit_init_test(struct kunit *test, const char *name)
>  {
>         mutex_init(&test->lock);
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
