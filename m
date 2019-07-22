Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF57070CA2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Jul 2019 00:31:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 16A26212C01DB;
	Mon, 22 Jul 2019 15:33:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 492CB212BF9DF
 for <linux-nvdimm@lists.01.org>; Mon, 22 Jul 2019 15:33:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r1so18041351pfq.12
 for <linux-nvdimm@lists.01.org>; Mon, 22 Jul 2019 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6t6Z8yaBFYoLHYTxv5eDMWvXoAnvu95Bt2xJR7LIXPM=;
 b=Pbqc45wUlOY+YQt8+tSNpR+Cy6b3vnFhYwUa9M0evgqUef7NsHugFBm+TCmFklkAQH
 /1lrgZc1GAgvI4D0R8SZOkah3X6ZV5+9yK4hR1+P74j8LxSFoEWTibbwplmZTPC/CN6J
 CYgHBM2VUAJ4iwonvfOrv7/nFN03R96MD9MhaJ7IY1fqBOMtGMDM4zDdufDEjOTvMaCY
 7svj3GjmBdASH8FN7s+NOxJSOa/i5DqzWQUHmgUS274UJhAHDbRAGIXUC22gLI2OvU69
 zPfYScJFPjUqVHvxdjR/3qAKP+Pi6GaNPjDX3yguwdNPbSjWNDcNmixX7XdD79jAV0Q0
 oEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6t6Z8yaBFYoLHYTxv5eDMWvXoAnvu95Bt2xJR7LIXPM=;
 b=XwfUzdLOeiWs/QAOkttyleAr0eWBVYGHye27rfUCcsatqqVfe9Wr6xs+73X9tl68b9
 umfCIr3c15ieIhg1XLVx0hUKEZrCd176/Xu90eflGoWTOt/oXSn6UpmiNrtSZjdaoU/e
 6GhyXI36N5FaxPvHStp7Dhw56/ztVOrlkOHM2RBqhVxUqcAz5sgt0H7vLbV4lGzWv/4+
 0yu/i/gxr+b5DkyptoYQ27pANegVLr5OoxR8RjBBTFAt7Dx/9KL5as5eESZ18c87UT8C
 OXW3jpdtrqVRHjgNNm7TC4n5fhdKGJnIt9+7sbRfybOp2oJFZv4HOQklYazUhuwlMETd
 aKDA==
X-Gm-Message-State: APjAAAWss3x3yCFLP+TNSOX20DOV+boH+xLM4Q5ZZ6SkQt8FSDXc5ang
 RpGcM8QE9LbMoJncFOVIrnkKj+Urs82aHLTjwD/VBg==
X-Google-Smtp-Source: APXvYqyO0RsU5hJiKN1UBBMLEqs8dzVSGIuLzMYi1uVToZEbJ6XuzYxALmxwq0bVMsvtqwjv25P0M3jBSrq2d1nPCNQ=
X-Received: by 2002:aa7:81ca:: with SMTP id c10mr2499024pfn.185.1563834660552; 
 Mon, 22 Jul 2019 15:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-5-brendanhiggins@google.com>
 <20190715221554.8417320665@mail.kernel.org>
 <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
 <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com>
 <20190716175021.9CA412173C@mail.kernel.org>
 <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
 <20190718175024.C3EC421019@mail.kernel.org>
 <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com>
 <20190719000834.GA3228@google.com> <20190722200347.261D3218C9@mail.kernel.org>
In-Reply-To: <20190722200347.261D3218C9@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 22 Jul 2019 15:30:49 -0700
Message-ID: <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like
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

On Mon, Jul 22, 2019 at 1:03 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-18 17:08:34)
> > On Thu, Jul 18, 2019 at 12:22:33PM -0700, Brendan Higgins wrote:
> >
> > I started poking around with your suggestion while we are waiting. A
> > couple early observations:
> >
> > 1) It is actually easier to do than I previously thought and will probably
> >    help with getting more of the planned TAP output stuff working.
> >
> >    That being said, this is still a pretty substantial undertaking and
> >    will likely take *at least* a week to implement and properly review.
> >    Assuming everything goes extremely well (no unexpected issues on my
> >    end, very responsive reviewers, etc).
> >
> > 2) It *will* eliminate the need for kunit_stream.
> >
> > 3) ...but, it *will not* eliminate the need for string_stream.
> >
> > Based on my early observations, I do think it is worth doing, but I
> > don't think it is worth trying to make it in this patchset (unless I
> > have already missed the window, or it is going to be open for a while):
>
> The merge window is over. Typically code needs to be settled a few weeks
> before it opens (i.e. around -rc4 or -rc5) for most maintainers to pick
> up patches for the next merge window.

Yeah, it closed on Sunday, right?

I thought we might be able to squeak in since it was *mostly* settled,
and Shuah sent me an email two weeks ago which I interpreted to mean
she was still willing to take it.

In any case, it doesn't matter now.

> > I do think it will make things much cleaner, but I don't think it will
> > achieve your desired goal of getting rid of an unstructured
> > {kunit|string}_stream style interface; it just adds a layer on top of it
> > that makes it harder to misuse.
>
> Ok.
>
> >
> > I attached a patch of what I have so far at the end of this email so you
> > can see what I am talking about. And of course, if you agree with my
> > assessment, so we can start working on it as a future patch.
> >
> > A couple things in regard to the patch I attached:
> >
> > 1) I wrote it pretty quickly so there are almost definitely mistakes.
> >    You should consider it RFC. I did verify it compiles though.
> >
> > 2) Also, I did use kunit_stream in writing it: all occurences should be
> >    pretty easy to replace with string_stream; nevertheless, the reason
> >    for this is just to make it easier to play with the current APIs. I
> >    wanted to have something working before I went through a big tedious
> >    refactoring. So sorry if it causes any confusion.
> >
> > 3) I also based the patch on all the KUnit patches I have queued up
> >    (includes things like mocking and such) since I want to see how this
> >    serialization thing will work with mocks and matchers and things like
> >    that.
>
> Great!
>
> >
> > From 53d475d3d56afcf92b452c6d347dbedfa1a17d34 Mon Sep 17 00:00:00 2001
> > From: Brendan Higgins <brendanhiggins@google.com>
> > Date: Thu, 18 Jul 2019 16:08:52 -0700
> > Subject: [PATCH v1] DO NOT MERGE: started playing around with the
> >  serialization api
> >
> > ---
> >  include/kunit/assert.h | 130 ++++++++++++++++++++++++++++++
> >  include/kunit/mock.h   |   4 +
> >  kunit/Makefile         |   3 +-
> >  kunit/assert.c         | 179 +++++++++++++++++++++++++++++++++++++++++
> >  kunit/mock.c           |   6 +-
> >  5 files changed, 318 insertions(+), 4 deletions(-)
> >  create mode 100644 include/kunit/assert.h
> >  create mode 100644 kunit/assert.c
> >
> > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > new file mode 100644
> > index 0000000000000..e054fdff4642f
> > --- /dev/null
> > +++ b/include/kunit/assert.h
> > @@ -0,0 +1,130 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Assertion and expectation serialization API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_ASSERT_H
> > +#define _KUNIT_ASSERT_H
> > +
> > +#include <kunit/test.h>
> > +#include <kunit/mock.h>
> > +
> > +enum kunit_assert_type {
> > +       KUNIT_ASSERTION,
> > +       KUNIT_EXPECTATION,
> > +};
> > +
> > +struct kunit_assert {
> > +       enum kunit_assert_type type;
> > +       const char *line;
> > +       const char *file;
> > +       struct va_format message;
> > +       void (*format)(struct kunit_assert *assert,
> > +                      struct kunit_stream *stream);
>
> Would passing in the test help too?

Yeah, it would probably be good to put one in `struct kunit_assert`.

> > +};
> > +
> > +void kunit_base_assert_format(struct kunit_assert *assert,
> > +                             struct kunit_stream *stream);
> > +
> > +void kunit_assert_print_msg(struct kunit_assert *assert,
> > +                           struct kunit_stream *stream);
> > +
> > +struct kunit_unary_assert {
> > +       struct kunit_assert assert;
> > +       const char *condition;
> > +       bool expected_true;
> > +};
> > +
> > +void kunit_unary_assert_format(struct kunit_assert *assert,
> > +                              struct kunit_stream *stream);
> > +
> > +struct kunit_ptr_not_err_assert {
> > +       struct kunit_assert assert;
> > +       const char *text;
> > +       void *value;
> > +};
> > +
> > +void kunit_ptr_not_err_assert_format(struct kunit_assert *assert,
> > +                                    struct kunit_stream *stream);
> > +
> > +struct kunit_binary_assert {
> > +       struct kunit_assert assert;
> > +       const char *operation;
> > +       const char *left_text;
> > +       long long left_value;
> > +       const char *right_text;
> > +       long long right_value;
> > +};
> > +
> > +void kunit_binary_assert_format(struct kunit_assert *assert,
> > +                               struct kunit_stream *stream);
> > +
> > +struct kunit_binary_ptr_assert {
> > +       struct kunit_assert assert;
> > +       const char *operation;
> > +       const char *left_text;
> > +       void *left_value;
> > +       const char *right_text;
> > +       void *right_value;
> > +};
> > +
> > +void kunit_binary_ptr_assert_format(struct kunit_assert *assert,
> > +                                   struct kunit_stream *stream);
> > +
> > +struct kunit_binary_str_assert {
> > +       struct kunit_assert assert;
> > +       const char *operation;
> > +       const char *left_text;
> > +       const char *left_value;
> > +       const char *right_text;
> > +       const char *right_value;
> > +};
> > +
> > +void kunit_binary_str_assert_format(struct kunit_assert *assert,
> > +                                   struct kunit_stream *stream);
> > +
> > +struct kunit_mock_assert {
> > +       struct kunit_assert assert;
> > +};
> > +
> > +struct kunit_mock_no_expectations {
> > +       struct kunit_mock_assert assert;
> > +};
>
> What's the purpose of making a wrapper struct with no other members?
> Just to make a different struct for some sort of type checking? I guess
> it's OK but I don't think it will be very useful in practice.

Yeah, just for typing purposes. I don't mind integrating this into the
current patchset and then deciding if we want it or not.

> > +
> > +struct kunit_mock_declaration {
> > +       const char *function_name;
> > +       const char **type_names;
> > +       const void **params;
> > +       int len;
> > +};
> > +
> > +void kunit_mock_declaration_format(struct kunit_mock_declaration *declaration,
> > +                                  struct kunit_stream *stream);
> > +
> > +struct kunit_matcher_result {
> > +       struct kunit_assert assert;
> > +};
> > +
> > +struct kunit_mock_failed_match {
> > +       struct list_head node;
> > +       const char *expectation_text;
> > +       struct kunit_matcher_result *matcher_list;
>
> Minor nitpick: this code could use some const sprinkling.

Will do.

> > +       size_t matcher_list_len;
> > +};
> > +
> > +void kunit_mock_failed_match_format(struct kunit_mock_failed_match *match,
> > +                                   struct kunit_stream *stream);
> > +
> > +struct kunit_mock_no_match {
> > +       struct kunit_mock_assert assert;
> > +       struct kunit_mock_declaration declaration;
> > +       struct list_head failed_match_list;
> > +};
> > +
> > +void kunit_mock_no_match_format(struct kunit_assert *assert,
> > +                               struct kunit_stream *stream);
> > +
> > +#endif /*  _KUNIT_ASSERT_H */
> > diff --git a/kunit/assert.c b/kunit/assert.c
> > new file mode 100644
> > index 0000000000000..75bb6922a994e
> > --- /dev/null
> > +++ b/kunit/assert.c
> > @@ -0,0 +1,179 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Assertion and expectation serialization API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +#include <kunit/assert.h>
> > +
> > +void kunit_base_assert_format(struct kunit_assert *assert,
> > +                             struct kunit_stream *stream)
> > +{
> > +       const char *expect_or_assert;
> > +
> > +       if (assert->type == KUNIT_EXPECTATION)
> > +               expect_or_assert = "EXPECTATION";
> > +       else
> > +               expect_or_assert = "ASSERTION";
>
> Make this is a switch statement so we can have the compiler complain if
> an enum is missing.

Nice call! I didn't know the compiler warned about that. Will fix.

> > +
> > +       kunit_stream_add(stream, "%s FAILED at %s:%s\n",
> > +                        expect_or_assert, assert->file, assert->line);
> > +}
> > +
> > +void kunit_assert_print_msg(struct kunit_assert *assert,
> > +                           struct kunit_stream *stream)
> > +{
> > +       if (assert->message.fmt)
> > +               kunit_stream_add(stream, "\n%pV", &assert->message);
> > +}
> > +
> [...]
> > +
> > +void kunit_mock_failed_match_format(struct kunit_mock_failed_match *match,
> > +                                   struct kunit_stream *stream)
> > +{
> > +       struct kunit_matcher_result *result;
> > +       size_t i;
> > +
> > +       kunit_stream_add(stream,
> > +                        "Tried expectation: %s, but\n",
> > +                        match->expectation_text);
> > +       for (i = 0; i < match->matcher_list_len; i++) {
> > +               result = &match->matcher_list[i];
> > +               kunit_stream_add(stream, "\t");
> > +               result->assert.format(&result->assert, stream);
> > +               kunit_stream_add(stream, "\n");
> > +       }
>
> What's the calling context of the assertions and expectations? I still
> don't like the fact that string stream needs to allocate buffers and
> throw them into a list somewhere because the calling context matters
> there.

The calling context is the same as before, which is anywhere.

> I'd prefer we just wrote directly to the console/log via printk
> instead. That way things are simple because we use the existing
> buffering path of printk, but maybe there's some benefit to the string
> stream that I don't see? Right now it looks like it builds a string and
> then dumps it to printk so I'm sort of lost what the benefit is over
> just writing directly with printk.

It's just buffering it so the whole string gets printed uninterrupted.
If we were to print out piecemeal to printk, couldn't we have another
call to printk come in causing it to garble the KUnit message we are
in the middle of printing?

> Maybe it's this part that you wrote up above?
>
> > > Nevertheless, I think the debate over the usefulness of the
> > > string_stream and kunit_stream are separate topics. Even if we made
> > > kunit_stream more structured, I am pretty sure I would want to use
> > > string_stream or some variation for constructing the message.
>
> Why do we need string_stream to construct the message? Can't we just
> print it as we process it?

See preceding comment.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
