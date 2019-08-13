Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 258848AE90
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 07:09:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8B7B521324680;
	Mon, 12 Aug 2019 22:11:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 17EBD2131D56F
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 22:11:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d1so17798457pgp.4
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 22:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uLkfmiy/QyxG+42Kpd1Hh2gG09JBSRi1kuJ0irEOT+Q=;
 b=blOJdc2kt55ZqQDvPUZbAMrG0e9V6Lpz+glDC3wqeZ0WFkpdzH+BHVuWLKpOnhb42G
 g/4gIqAUYUWwrSZVnoWlA0+3BTuFFHTn4QIkPhZ/yY/qHdFseTm5A1T8f5E1IwOIGPkQ
 NjL2X3JkoAgV9wX66vJ01slCy0p6rnZ7bkyjxanoLsFcwNNC9ezGHFtGPQthuBsXEPdD
 Vzi/25vZpUBOV4gIKVVTs3IY9Dq9AiSUtfWFy0iWSPQYG787ViekPjFY+1C9grp4yxiQ
 WMAj2QOcebo3fC3yliGOOPA8v9/MAYuJN9q8LYDdlO8ROvEqJbK4dyCfU63RlOwjE9t3
 XXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uLkfmiy/QyxG+42Kpd1Hh2gG09JBSRi1kuJ0irEOT+Q=;
 b=Bv4fdcgd1cm2nOc+VamitUWoqV8dyt8sQmlketv8N1bgQFcTRCgjB8TeoAJUUagwxB
 Fske03TqEgT5m66Vy235tRnzGl5bw8C+wb1mNymf2wKiB+P3YPB4pZU5G6UGkUv/HSzM
 v3MrMo+BGymFLZlHf4manKhl88BB40E65fYeh+ViQ5ro5KKGk4wkr2//kf6NwbPF24c4
 BgUwwfpNWoGhRuBT6G/4JVP/2f/i2T8kFetH2KLkdlGHKU7Eeq1kOX2/l7RplAz7Le03
 yXdJN9Xg3lNxbraEtnr6X5U1ZaqZBMUwRGBVcJzXuqvyEYfuOsRa2JAdFvmr3KudXGXv
 OWrQ==
X-Gm-Message-State: APjAAAVXF2J5uj4PHeZMzzxv/kww/VHELQSuy3xM+nsKUHpMPzCuqzVe
 silTKQMk40etd17EYCw0PV+dWONTIg8ZxZ9eeHmvgw==
X-Google-Smtp-Source: APXvYqwuRvdkQRBufOH1je8RsECuoe8PsScuGBBjY118Ufh882DHOjHaTVKhOCRIYEV6VNsZUpt68lWBTKVfNRYZXa8=
X-Received: by 2002:a17:90a:c391:: with SMTP id
 h17mr524990pjt.131.1565672978100; 
 Mon, 12 Aug 2019 22:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-12-brendanhiggins@google.com>
 <20190813045510.C1D6E206C2@mail.kernel.org>
In-Reply-To: <20190813045510.C1D6E206C2@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 12 Aug 2019 22:09:26 -0700
Message-ID: <CAFd5g47jrUd+ES4AaWsLDRCfsGiKDB-rOP6TR-NdymCeVAK3Kg@mail.gmail.com>
Subject: Re: [PATCH v12 11/18] kunit: test: add the concept of assertions
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

On Mon, Aug 12, 2019 at 9:55 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 11:24:14)
> > Add support for assertions which are like expectations except the test
> > terminates if the assertion is not satisfied.
> >
> > The idea with assertions is that you use them to state all the
> > preconditions for your test. Logically speaking, these are the premises
> > of the test case, so if a premise isn't true, there is no point in
> > continuing the test case because there are no conclusions that can be
> > drawn without the premises. Whereas, the expectation is the thing you
> > are trying to prove. It is not used universally in x-unit style test
> > frameworks, but I really like it as a convention.  You could still
> > express the idea of a premise using the above idiom, but I think
> > KUNIT_ASSERT_* states the intended idea perfectly.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> > + * Sets an expectation that the values that @left and @right evaluate to are
> > + * not equal. This is semantically equivalent to
> > + * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
> > + * for more information.
> > + */
> > +#define KUNIT_ASSERT_STRNEQ(test, left, right)                                \
> > +               KUNIT_BINARY_STR_NE_ASSERTION(test,                            \
> > +                                             KUNIT_ASSERTION,                 \
> > +                                             left,                            \
> > +                                             right)
> > +
> > +#define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)                  \
> > +               KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,                        \
> > +                                                 KUNIT_ASSERTION,             \
> > +                                                 left,                        \
> > +                                                 right,                       \
> > +                                                 fmt,                         \
>
> Same question about tabbing too.

Yep. WIll fix.

> > diff --git a/kunit/test-test.c b/kunit/test-test.c
> > index 88f4cdf03db2a..058f3fb37458a 100644
> > --- a/kunit/test-test.c
> > +++ b/kunit/test-test.c
> > @@ -78,11 +78,13 @@ static int kunit_try_catch_test_init(struct kunit *test)
> >         struct kunit_try_catch_test_context *ctx;
> >
> >         ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
>
> Ah ok. Question still stands if kunit_kzalloc() should just have the
> assertion on failure.

Right. In the previous patch KUNIT_ASSERT_* doesn't exist yet, so I
can't use it. And rather than fall back to return -ENOMEM like I
should have, I evidently forgot to do that.

> >         test->priv = ctx;
> >
> >         ctx->try_catch = kunit_kmalloc(test,
> >                                        sizeof(*ctx->try_catch),
> >                                        GFP_KERNEL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->try_catch);
> >
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
