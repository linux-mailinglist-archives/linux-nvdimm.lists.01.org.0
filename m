Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5525A21CF4
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 19:58:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 591BE21250454;
	Fri, 17 May 2019 10:58:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5CDEF2118DC27
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:58:42 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F3396216FD;
 Fri, 17 May 2019 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1558115922;
 bh=6wuDO6C2j5ISFUHqCZvEZgXgmSk5Y1yp2LQuMtU2X3c=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=sDtAwiFiKEC7wD2Ufzw/udB7/5BWIyScyUaJXH5U6VCsDwlqQoDM/P4m+X1+94VzN
 UMN8BtoINRqIUVkug6vKVri3xHvdA3/CbFFhbNpR4pZcBbxJrTK6xZUmI6Dk+l/a4V
 1dq1lsjIu2TctOk9kzXv+Q2ILY/h6f897iZjhR+M=
MIME-Version: 1.0
In-Reply-To: <20190514221711.248228-5-brendanhiggins@google.com>
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-5-brendanhiggins@google.com>
Subject: Re: [PATCH v4 04/18] kunit: test: add kunit_stream a std::stream like
 logger
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com,
 gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org,
 robh@kernel.org, shuah@kernel.org, tytso@mit.edu,
 yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date: Fri, 17 May 2019 10:58:41 -0700
Message-Id: <20190517175841.F3396216FD@mail.kernel.org>
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

Quoting Brendan Higgins (2019-05-14 15:16:57)
> diff --git a/kunit/kunit-stream.c b/kunit/kunit-stream.c
> new file mode 100644
> index 0000000000000..1884f1b550888
> --- /dev/null
> +++ b/kunit/kunit-stream.c
> @@ -0,0 +1,152 @@
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
> +static const char *kunit_stream_get_level(struct kunit_stream *this)
> +{
> +       unsigned long flags;
> +       const char *level;
> +
> +       spin_lock_irqsave(&this->lock, flags);
> +       level = this->level;
> +       spin_unlock_irqrestore(&this->lock, flags);
> +
> +       return level;

Please remove this whole function and inline it to the one call-site.

> +}
> +
> +void kunit_stream_set_level(struct kunit_stream *this, const char *level)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&this->lock, flags);
> +       this->level = level;
> +       spin_unlock_irqrestore(&this->lock, flags);

I don't get the locking here. What are we protecting against? Are tests
running in parallel using the same kunit_stream? If so, why is the level
changeable in one call and then adding strings is done in a different
function call? It would make sense to combine the level setting and
string adding so that it's one atomic operation if it's truly a parallel
operation, or remove the locking entirely.

> +}
> +
> +void kunit_stream_add(struct kunit_stream *this, const char *fmt, ...)
> +{
> +       va_list args;
> +       struct string_stream *stream = this->internal_stream;
> +
> +       va_start(args, fmt);
> +
> +       if (string_stream_vadd(stream, fmt, args) < 0)
> +               kunit_err(this->test, "Failed to allocate fragment: %s\n", fmt);
> +
> +       va_end(args);
> +}
> +
> +void kunit_stream_append(struct kunit_stream *this,
> +                               struct kunit_stream *other)
> +{
> +       struct string_stream *other_stream = other->internal_stream;
> +       const char *other_content;
> +
> +       other_content = string_stream_get_string(other_stream);
> +
> +       if (!other_content) {
> +               kunit_err(this->test,
> +                         "Failed to get string from second argument for appending.\n");
> +               return;
> +       }
> +
> +       kunit_stream_add(this, other_content);
> +}
> +
> +void kunit_stream_clear(struct kunit_stream *this)
> +{
> +       string_stream_clear(this->internal_stream);
> +}
> +
> +void kunit_stream_commit(struct kunit_stream *this)

Should this be rather called kunit_stream_flush()?

> +{
> +       struct string_stream *stream = this->internal_stream;
> +       struct string_stream_fragment *fragment;
> +       const char *level;
> +       char *buf;
> +
> +       level = kunit_stream_get_level(this);
> +       if (!level) {
> +               kunit_err(this->test,
> +                         "Stream was committed without a specified log level.\n");

Drop the full-stop?

> +               level = KERN_ERR;
> +               kunit_stream_set_level(this, level);
> +       }
> +
> +       buf = string_stream_get_string(stream);
> +       if (!buf) {
> +               kunit_err(this->test,

Can you grow a local variable for 'this->test'? It's used many times.

Also, 'this' is not very kernel idiomatic. We usually name variables by
their type instead of 'this' which is a keyword in other languages.
Perhaps it could be named 'kstream'?

> +                        "Could not allocate buffer, dumping stream:\n");
> +               list_for_each_entry(fragment, &stream->fragments, node) {
> +                       kunit_err(this->test, fragment->fragment);
> +               }
> +               kunit_err(this->test, "\n");
> +               goto cleanup;
> +       }
> +
> +       kunit_printk(level, this->test, buf);
> +       kfree(buf);
> +
> +cleanup:
> +       kunit_stream_clear(this);
> +}
> +
> +static int kunit_stream_init(struct kunit_resource *res, void *context)
> +{
> +       struct kunit *test = context;
> +       struct kunit_stream *stream;
> +
> +       stream = kzalloc(sizeof(*stream), GFP_KERNEL);

Of course, here it's called 'stream', so maybe it should be 'kstream'
here too.

> +       if (!stream)
> +               return -ENOMEM;
> +
> +       res->allocation = stream;
> +       stream->test = test;
> +       spin_lock_init(&stream->lock);
> +       stream->internal_stream = new_string_stream();

Can new_string_stream() be renamed to alloc_string_stream()? Sorry, I
just see so much C++ isms in here it's hard to read from the kernel
developer perspective.

> +
> +       if (!stream->internal_stream) {

Nitpick: Please join this to the "allocation" event above instead of
keeping it separated.

> +               kfree(stream);
> +               return -ENOMEM;
> +       }
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
> +                        "End of test case reached with uncommitted stream entries.\n");
> +               kunit_stream_commit(stream);
> +       }
> +
> +       destroy_string_stream(stream->internal_stream);
> +       kfree(stream);
> +}
> +
> +struct kunit_stream *kunit_new_stream(struct kunit *test)
> +{
> +       struct kunit_resource *res;
> +
> +       res = kunit_alloc_resource(test,
> +                                  kunit_stream_init,
> +                                  kunit_stream_free,
> +                                  test);
> +
> +       if (res)
> +               return res->allocation;
> +       else
> +               return NULL;

Don't have if (...) return ...; else return ..., just return instead of
else.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
