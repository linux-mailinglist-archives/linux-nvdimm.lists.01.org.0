Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5CB8ADB3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 06:27:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 38BDC21329963;
	Mon, 12 Aug 2019 21:29:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B5BDB21324690
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 21:29:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n9so44348914pgc.1
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 21:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fQL9RUtIML/PZe8MNFP8yQiCjWtKgPLyEfIL1k8PJhc=;
 b=fbg8VeT4fWy8MdPE5NDtumx+KrkUlXY0FY4hQL0ZwFaSB+aAw9A23C2a0B2+TAgTcn
 QRSm6g30QyXjT5+Li/OxZJId+1mikYGNYaRjFswNcd6fvPG4iGcxHlUtL+YOAsZsA1S0
 rcxRRdXDnZm1MmAStKLyKDuVzVZJLX5Lpcsp/wnXCV2B+DSuCumnuklf6b0VFdNwZEgN
 UTua35jaJGosxDOytq+pTP+fwXsPV3GIbr3R559nMEJhIG1Zt9VqS/XG0JoEGRztyMPv
 pjPkYqPfyv4d0basCqZO32/EFQQWHTlJ0mQAVIAE2306A8Q+UbbHGf9TCQnW3CYkOtTX
 JP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fQL9RUtIML/PZe8MNFP8yQiCjWtKgPLyEfIL1k8PJhc=;
 b=ESaVAEiI0LsOaVoyhJ7yzDys2SgtOgJlRaffyomiiHspY6EOanq3+H7uise8pKtgtV
 sU4cQjuKxOZA9chfZh8dGydFXwK0n9i5ZfU563uBYHtcOmixelVnN09FJDzc5Pdq0ffS
 c9mC99obwB7R2KZTE6ib6lfV2j2GbVO37/1AE1D/Q4Kvq89HKOrqWRpA/oWVeQi9eqJn
 CpDzCYE8Kh606NOdw/nfmtvHNzJVXgGcawEjEq7Dmar2oz/M/cTvlY3SE0LhjYMX4VON
 6Q7KBGuWfqTPK/9BugrjrAjxVqB4BRdLK1xfaiclXWhHHakiOHbjdRV1/TCYsqRlrGKm
 L5Gg==
X-Gm-Message-State: APjAAAUSoELiXUwieczTbG5ORUnGLYpVPyHgi1zvolv7K2D87HoAXhVB
 he4jp9Ql9WRciG8SK7Cl9xEGlfCHmEviy2lQefFl8g==
X-Google-Smtp-Source: APXvYqyDNtjg1vEeMDr2gVCEsRefZmM7lb53WZNnRaIftMCnD83RA48eWcYK2L1Qi2YiTKmhvzfk7GUpdRuiK3gA3Wg=
X-Received: by 2002:a63:b919:: with SMTP id z25mr32569272pge.201.1565670436109; 
 Mon, 12 Aug 2019 21:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-5-brendanhiggins@google.com>
 <20190812234644.E054D20679@mail.kernel.org>
 <CAFd5g44huOiR9B0H1C2TtiPy63BDuwi_Qpb_exF3zmT3ttV8eg@mail.gmail.com>
In-Reply-To: <CAFd5g44huOiR9B0H1C2TtiPy63BDuwi_Qpb_exF3zmT3ttV8eg@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 12 Aug 2019 21:27:05 -0700
Message-ID: <CAFd5g44GxE-p+Jk_46GYA-WWVHLW7w=yE+K_tbbdiniDfrk-2w@mail.gmail.com>
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

On Mon, Aug 12, 2019 at 4:56 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, Aug 12, 2019 at 4:46 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-08-12 11:24:07)
> > > Add `struct kunit_assert` and friends which provide a structured way to
> > > capture data from an expectation or an assertion (introduced later in
> > > the series) so that it may be printed out in the event of a failure.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---
> >
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> >
> > Just some minor nits below
> >
> > > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > > new file mode 100644
> > > index 0000000000000..55f1b88b0cb4d
> > > --- /dev/null
> > > +++ b/include/kunit/assert.h
> > > @@ -0,0 +1,183 @@
> > [...]
> > > +                           struct string_stream *stream);
> > > +
> > > +struct kunit_fail_assert {
> > > +       struct kunit_assert assert;
> > > +};
> > > +
> > > +void kunit_fail_assert_format(const struct kunit_assert *assert,
> > > +                             struct string_stream *stream);
> > > +
> > > +#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {                           \
> > > +               .assert = KUNIT_INIT_ASSERT_STRUCT(test,                       \
> > > +                                                  type,                       \
> > > +                                                  kunit_fail_assert_format)   \
> >
> > This one got indented one too many times?
>
> Not unless I have been using the wrong formatting for multiline
> macros. You can see this commit applied here:
> https://kunit.googlesource.com/linux/+/870964da2990920030990dd1ffb647ef408e52df/include/kunit/assert.h#59
>
> I have test, type, and kunit_fail_assert_format all column aligned (it
> just doesn't render nicely in the patch format).

Disregard that last comment. I just looked at the line immediately
above your comment and thought it looked correct. Sorry about that
(you were pointing out that the .assert line looked wrong, correct?).

> > > +}
> > > +
> > > +struct kunit_unary_assert {
> > > +       struct kunit_assert assert;
> > > +       const char *condition;
> > > +       bool expected_true;
> > > +};
> > > +
> > > +void kunit_unary_assert_format(const struct kunit_assert *assert,
> > > +                              struct string_stream *stream);
> > > +
> > [...]
> > > +#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,                             \
> > > +                                           type,                              \
> > > +                                           op_str,                            \
> > > +                                           left_str,                          \
> > > +                                           left_val,                          \
> > > +                                           right_str,                         \
> > > +                                           right_val) {                       \
> > > +       .assert = KUNIT_INIT_ASSERT_STRUCT(test,                               \
> > > +                                          type,                               \
> > > +                                          kunit_binary_str_assert_format),    \
> > > +       .operation = op_str,                                                   \
> > > +       .left_text = left_str,                                                 \
> > > +       .left_value = left_val,                                                \
> > > +       .right_text = right_str,                                               \
> > > +       .right_value = right_val                                               \
> > > +}
> >
> > It would be nice to have kernel doc on these macros so we know how to
> > use them.
>
> Sounds good. Will fix.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
