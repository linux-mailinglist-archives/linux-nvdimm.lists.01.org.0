Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A90D354C7
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Jun 2019 02:48:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43B622128D867;
	Tue,  4 Jun 2019 17:48:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 770922128D6BA
 for <linux-nvdimm@lists.01.org>; Tue,  4 Jun 2019 17:48:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t28so10394596lje.9
 for <linux-nvdimm@lists.01.org>; Tue, 04 Jun 2019 17:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pv23Ci9XYYXbAvdmjUDu6QVKJnotvin7bH7iuxivMig=;
 b=bCfiN04tgowJLuApBvXwZWyNMtGb9FgYGJp5LkSEcg4PdHWnZmIBeM/cM9k5AbYodp
 rettTdhr1CO5CzRe80O5GNP151HRdnuXMuXParmN+k4ysLrvJ8T4FJPz5UBNGPIWWhDv
 jLzSs2o7zt6OpGXykmBbYrEGKSLH0DyvmhFwA2O4C1gJAlb4gCQQYVi8jqNR76aV2CAE
 B26xYkubYvYF6WWvFMWbUtKHUYW3SWHpux/uSw6Ty7qvZxcnWDlOTriysJ/qSBj39HJL
 iN8/XK32e67VWiHpnny1O7oiB03Lzd4/CGvnWXT8rNKGMQku64Dn87Rnbdfu/kl1KQN3
 xajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pv23Ci9XYYXbAvdmjUDu6QVKJnotvin7bH7iuxivMig=;
 b=F4vkLdgsIEGSWppuQoJs4UOBrgFEqvIErmlEzpHcHv9KFRFw6OhheR3wJzy4zPBFzE
 gr7MKCie0dGsvvQF0iZWWhmyV72xkqouoSiy1nK20qdr2DY9spXfeSXqUGUE+Qi8wYA6
 cfhppC7JVHshrAzoIIk3zLRs5FNiO5uYlaY35yzv++4oZAalJv0t3hg/LrOyHLwEGcTm
 rzP08wA8OWL8RbKNWksXuou5Y0WpifGRV1AnloNtG9BJH5BlCVE5UcmIeKB95AFyKbjz
 Eh8mmrvkt92HbUECrU2b9uVETN1ulZw43k+3DVJpLKWSg6WpYbJ9i3Izbiz+jdSCkiq6
 yU7w==
X-Gm-Message-State: APjAAAU4DazaQAQyZ7wJ9nSbbVay/d4WsQ8u4FJEjlbhqCzw/uwxl9NS
 1IClx4RK2AiyE5SRYJPbZcXhLp6n4Tm7DQPUCe+Nng==
X-Google-Smtp-Source: APXvYqxvjJ99N3aai52FzW/2dSKhKjlCCwgFuNgdJiXvkROkaHK9M4UqMQad+SFwjoWlFMwgkqQd/uzHdaUnjHCnq4g=
X-Received: by 2002:a2e:a318:: with SMTP id l24mr6685023lje.36.1559695679940; 
 Tue, 04 Jun 2019 17:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-5-brendanhiggins@google.com>
 <20190517175841.F3396216FD@mail.kernel.org>
In-Reply-To: <20190517175841.F3396216FD@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 4 Jun 2019 17:47:48 -0700
Message-ID: <CAFd5g456V4aQUSxxTAizun8ak4zogcAt4-YGgebX2L55Kb-xEg@mail.gmail.com>
Subject: Re: [PATCH v4 04/18] kunit: test: add kunit_stream a std::stream like
 logger
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

On Fri, May 17, 2019 at 10:58 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-05-14 15:16:57)
> > diff --git a/kunit/kunit-stream.c b/kunit/kunit-stream.c
> > new file mode 100644
> > index 0000000000000..1884f1b550888
> > --- /dev/null
> > +++ b/kunit/kunit-stream.c
> > @@ -0,0 +1,152 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * C++ stream style string formatter and printer used in KUnit for outputting
> > + * KUnit messages.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <kunit/kunit-stream.h>
> > +#include <kunit/string-stream.h>
> > +
> > +static const char *kunit_stream_get_level(struct kunit_stream *this)
> > +{
> > +       unsigned long flags;
> > +       const char *level;
> > +
> > +       spin_lock_irqsave(&this->lock, flags);
> > +       level = this->level;
> > +       spin_unlock_irqrestore(&this->lock, flags);
> > +
> > +       return level;
>
> Please remove this whole function and inline it to the one call-site.
>
> > +}
> > +
> > +void kunit_stream_set_level(struct kunit_stream *this, const char *level)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&this->lock, flags);
> > +       this->level = level;
> > +       spin_unlock_irqrestore(&this->lock, flags);
>
> I don't get the locking here. What are we protecting against? Are tests
> running in parallel using the same kunit_stream? If so, why is the level
> changeable in one call and then adding strings is done in a different
> function call? It would make sense to combine the level setting and
> string adding so that it's one atomic operation if it's truly a parallel
> operation, or remove the locking entirely.

I think you are right. I am not sure it makes sense for two separate
threads to share a kunit_stream; even if locked properly, it would end
up printing out corrupted text.

In anycase, I think it makes sense to decide the level when the stream
is allocated which would sidestep this issue entirely.

> > +}
> > +
> > +void kunit_stream_add(struct kunit_stream *this, const char *fmt, ...)
> > +{
> > +       va_list args;
> > +       struct string_stream *stream = this->internal_stream;
> > +
> > +       va_start(args, fmt);
> > +
> > +       if (string_stream_vadd(stream, fmt, args) < 0)
> > +               kunit_err(this->test, "Failed to allocate fragment: %s\n", fmt);
> > +
> > +       va_end(args);
> > +}
> > +
> > +void kunit_stream_append(struct kunit_stream *this,
> > +                               struct kunit_stream *other)
> > +{
> > +       struct string_stream *other_stream = other->internal_stream;
> > +       const char *other_content;
> > +
> > +       other_content = string_stream_get_string(other_stream);
> > +
> > +       if (!other_content) {
> > +               kunit_err(this->test,
> > +                         "Failed to get string from second argument for appending.\n");
> > +               return;
> > +       }
> > +
> > +       kunit_stream_add(this, other_content);
> > +}
> > +
> > +void kunit_stream_clear(struct kunit_stream *this)
> > +{
> > +       string_stream_clear(this->internal_stream);
> > +}
> > +
> > +void kunit_stream_commit(struct kunit_stream *this)
>
> Should this be rather called kunit_stream_flush()?

So the intention is that the string in the buffer will not get printed
out until commit is called. In this way, you can build up a message
and then decide not to print it. This is useful when you are parsing
through a lot of data that would be useful in debugging a failing or
broken test, but are not yet sure if it is going to pass or not.

I think flush has the connotation, that you are just forcing the
buffer to get written out now, but that it will happen regardless
eventually, where commit has the correct connotation that you *must*
call it in order to write out the data stored in the buffer.

Seems as though I should probably add this distinction to the
kernel-doc comment.

> > +{
> > +       struct string_stream *stream = this->internal_stream;
> > +       struct string_stream_fragment *fragment;
> > +       const char *level;
> > +       char *buf;
> > +
> > +       level = kunit_stream_get_level(this);
> > +       if (!level) {
> > +               kunit_err(this->test,
> > +                         "Stream was committed without a specified log level.\n");
>
> Drop the full-stop?

Whoops, nice catch. Will fix in next revision.

> > +               level = KERN_ERR;
> > +               kunit_stream_set_level(this, level);
> > +       }
> > +
> > +       buf = string_stream_get_string(stream);
> > +       if (!buf) {
> > +               kunit_err(this->test,
>
> Can you grow a local variable for 'this->test'? It's used many times.

Sure, will fix in next revision.

> Also, 'this' is not very kernel idiomatic. We usually name variables by
> their type instead of 'this' which is a keyword in other languages.
> Perhaps it could be named 'kstream'?

Seems reasonable. Will fix in next revision.

> > +                        "Could not allocate buffer, dumping stream:\n");
> > +               list_for_each_entry(fragment, &stream->fragments, node) {
> > +                       kunit_err(this->test, fragment->fragment);
> > +               }
> > +               kunit_err(this->test, "\n");
> > +               goto cleanup;
> > +       }
> > +
> > +       kunit_printk(level, this->test, buf);
> > +       kfree(buf);
> > +
> > +cleanup:
> > +       kunit_stream_clear(this);
> > +}
> > +
> > +static int kunit_stream_init(struct kunit_resource *res, void *context)
> > +{
> > +       struct kunit *test = context;
> > +       struct kunit_stream *stream;
> > +
> > +       stream = kzalloc(sizeof(*stream), GFP_KERNEL);
>
> Of course, here it's called 'stream', so maybe it should be 'kstream'
> here too.

Will do.

>
> > +       if (!stream)
> > +               return -ENOMEM;
> > +
> > +       res->allocation = stream;
> > +       stream->test = test;
> > +       spin_lock_init(&stream->lock);
> > +       stream->internal_stream = new_string_stream();
>
> Can new_string_stream() be renamed to alloc_string_stream()? Sorry, I
> just see so much C++ isms in here it's hard to read from the kernel
> developer perspective.

No problem. WIll fix in next revision.

> > +
> > +       if (!stream->internal_stream) {
>
> Nitpick: Please join this to the "allocation" event above instead of
> keeping it separated.

Yeah, that's a lot cleaner. Will do.

> > +               kfree(stream);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void kunit_stream_free(struct kunit_resource *res)
> > +{
> > +       struct kunit_stream *stream = res->allocation;
> > +
> > +       if (!string_stream_is_empty(stream->internal_stream)) {
> > +               kunit_err(stream->test,
> > +                        "End of test case reached with uncommitted stream entries.\n");
> > +               kunit_stream_commit(stream);
> > +       }
> > +
> > +       destroy_string_stream(stream->internal_stream);
> > +       kfree(stream);
> > +}
> > +
> > +struct kunit_stream *kunit_new_stream(struct kunit *test)
> > +{
> > +       struct kunit_resource *res;
> > +
> > +       res = kunit_alloc_resource(test,
> > +                                  kunit_stream_init,
> > +                                  kunit_stream_free,
> > +                                  test);
> > +
> > +       if (res)
> > +               return res->allocation;
> > +       else
> > +               return NULL;
>
> Don't have if (...) return ...; else return ..., just return instead of
> else.

Sorry. Will fix.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
