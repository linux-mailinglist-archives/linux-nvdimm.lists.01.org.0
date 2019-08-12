Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B058ABBE
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 02:04:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1EABF2132996C;
	Mon, 12 Aug 2019 17:06:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3EACB2131D59A
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 16:59:00 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r26so14328180pgl.10
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 16:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gYpSAuCXXKxryh8QTeN+G2zHTLzdvz4q0W6bw5kxZF4=;
 b=kj+TnowRhwNBHJOh8ghz79tlvll8x/4UGw5bdSUzfSM675Bmppn0T+5pwwMqUi1Pj8
 SkfxC53wkTjuPEqLDzqpMT8o02usB1hT7ISXFNR37RoScwW9mBXE4G6OWWcEhGxQ4RjE
 ZULQCeKPfhmyKaUvhvxsP1ztH072L3pIFOOb1mQPoepGl9JYtada5S4xJGf8kTW6G2ed
 agtpkDcP4Se/8cfElAOE/jMH6pWLmTG0sCRAYFHxhMUFNN99If6/5pZXWUcydlo5gP79
 cH+LRfP7b/BQG+d1ym6KyAQRfa3JaLfiK6f13kXjD96rm3bbdFV/J9GFHUpWjzV//M/H
 yS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gYpSAuCXXKxryh8QTeN+G2zHTLzdvz4q0W6bw5kxZF4=;
 b=qcHunK4sU2eBqyEpwRlnvNoTpwApvqZcf9uGg4syGeLDOQRqGxWa7zP1j4/sjeOjKF
 CeEMFE0I5VJR9KkLN9o8x+pevNmmXJdQjXq68GzvtPKZQEKTTZ+f8QTPRtAzgBGuc8Wq
 0IIltHeCnRr16nhCyyZCaLCTwUEvcRkEOwta5T6lk861F3+BI0Gi18J1vhT092dqdh3Q
 kNW+r0xePD/8QzuFRTrEDd3tJjofpeZKo5Woza9bZcpJuaDhTtJdvfeo8HkoSQkAMeAD
 IhwnVocZFT5/AVRw7Cnkj2AR8o+JpybwafOw/nvHqTfxqhrmw09AkiEWG+cxreYp0cbc
 n4HQ==
X-Gm-Message-State: APjAAAUNhGTak6t8Ec0K4qrNIrOxf/a4egYlH4pFMliY1+Uq8ZwmeeGf
 v94iQhqtwUA8nPcZii7cPhFkplluHsqlktKPSjPalQ==
X-Google-Smtp-Source: APXvYqw7Md+FhMdhe7gt7ZbaYFjad4Qutk9q143YLYnyDZF1R0tUF3skBOerqPAJS3PaDxgm1xGa9mrupUlIDIlaGXw=
X-Received: by 2002:a63:b919:: with SMTP id z25mr31882885pge.201.1565654201390; 
 Mon, 12 Aug 2019 16:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-5-brendanhiggins@google.com>
 <20190812234644.E054D20679@mail.kernel.org>
In-Reply-To: <20190812234644.E054D20679@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 12 Aug 2019 16:56:29 -0700
Message-ID: <CAFd5g44huOiR9B0H1C2TtiPy63BDuwi_Qpb_exF3zmT3ttV8eg@mail.gmail.com>
Subject: Re: [PATCH v12 04/18] kunit: test: add assertion printing library
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

On Mon, Aug 12, 2019 at 4:46 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 11:24:07)
> > Add `struct kunit_assert` and friends which provide a structured way to
> > capture data from an expectation or an assertion (introduced later in
> > the series) so that it may be printed out in the event of a failure.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> Just some minor nits below
>
> > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > new file mode 100644
> > index 0000000000000..55f1b88b0cb4d
> > --- /dev/null
> > +++ b/include/kunit/assert.h
> > @@ -0,0 +1,183 @@
> [...]
> > +                           struct string_stream *stream);
> > +
> > +struct kunit_fail_assert {
> > +       struct kunit_assert assert;
> > +};
> > +
> > +void kunit_fail_assert_format(const struct kunit_assert *assert,
> > +                             struct string_stream *stream);
> > +
> > +#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {                           \
> > +               .assert = KUNIT_INIT_ASSERT_STRUCT(test,                       \
> > +                                                  type,                       \
> > +                                                  kunit_fail_assert_format)   \
>
> This one got indented one too many times?

Not unless I have been using the wrong formatting for multiline
macros. You can see this commit applied here:
https://kunit.googlesource.com/linux/+/870964da2990920030990dd1ffb647ef408e52df/include/kunit/assert.h#59

I have test, type, and kunit_fail_assert_format all column aligned (it
just doesn't render nicely in the patch format).

> > +}
> > +
> > +struct kunit_unary_assert {
> > +       struct kunit_assert assert;
> > +       const char *condition;
> > +       bool expected_true;
> > +};
> > +
> > +void kunit_unary_assert_format(const struct kunit_assert *assert,
> > +                              struct string_stream *stream);
> > +
> [...]
> > +#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,                             \
> > +                                           type,                              \
> > +                                           op_str,                            \
> > +                                           left_str,                          \
> > +                                           left_val,                          \
> > +                                           right_str,                         \
> > +                                           right_val) {                       \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(test,                               \
> > +                                          type,                               \
> > +                                          kunit_binary_str_assert_format),    \
> > +       .operation = op_str,                                                   \
> > +       .left_text = left_str,                                                 \
> > +       .left_value = left_val,                                                \
> > +       .right_text = right_str,                                               \
> > +       .right_value = right_val                                               \
> > +}
>
> It would be nice to have kernel doc on these macros so we know how to
> use them.

Sounds good. Will fix.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
