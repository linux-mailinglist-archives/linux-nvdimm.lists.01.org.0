Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B3627F3
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Jul 2019 20:08:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9DAE9212AC47D;
	Mon,  8 Jul 2019 11:08:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CAF1321A09130
 for <linux-nvdimm@lists.01.org>; Mon,  8 Jul 2019 11:08:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g2so3191663pfq.0
 for <linux-nvdimm@lists.01.org>; Mon, 08 Jul 2019 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pl4l3gaXCZ0Civm5i1pNfvFYe/9qjH5f6pxejgr6AT8=;
 b=SmOjZWgQtja4PiBSvkc/DsaRuuY8KuEdsMMIKFu//v+ppa1NV5GwqJ4JU08u4uuqXU
 KBGOdoVwwU+z3nPB5Yc7Nj2ei2N1Y2sszCQi7aydqX+v1bs0R5WVY9VfrLuAxD0X22yO
 et4/wVXqTEuA8XKb8I+GG2Cy0aB5wgbYiiI9zkmmG0P1bXmqCbs0GEYAywdf8m69uDNv
 i3LNyALK0qO5EHrEqLLK7h1Y4PRr0CfVpj56uFuOU19A9ib63eiTFseAJoBv3geF+XdI
 Ex1jzjCOgerKv5XAy3Zhbk2qyoHk/ecWgRcxMQ7auZjG3EZDzZIqKZ+9SL7kyLXtMMIf
 MRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pl4l3gaXCZ0Civm5i1pNfvFYe/9qjH5f6pxejgr6AT8=;
 b=uV5WEZy45xPOhrM6jCeo3pMpu+9OYJ+k6x9Ijj4/CQZOqZXo+nMbW/9E9ObXA9fiti
 CimqJxefpSL9L+6t36igCKnvR9VozwVJplZWziPY6isCKrBixvNLAdt8O5kODVo0gaTF
 BhowvLx6w06GbwtFJ3hx9B2d9yhqlFrYoycfBZuv49Jp+wZEgd3ESKX3tfRHw95Vvi9w
 xrn8gmIxrZGJnJX43zJAZsozrYTnClajA5HbgZxOrFGMvRgEe4kryfyolfKAKr5pQ0CU
 thM+BHZSeKkjBF4bLCdjJqu7uZvvr/FPjwcMts0+nOt3Jcb837BjlSiZIcMUrpvf7fBV
 l1OA==
X-Gm-Message-State: APjAAAVG4zMX0bNNfQrjxflzr7SOrUTOg9GYP8uhZ7GuMIFUhWbDiEvz
 8zY07YrZdph9cqrb5f2FxWFnIY/q1S0oiGpj22UJ2Q==
X-Google-Smtp-Source: APXvYqwoLoh11AGLeVf5uSZhLWgN1V0Lf0IPFYJElvqds2Mjg+FKGEtSZZdm1FCZKhiAeE2kYC6jZBxFraVmnG074HI=
X-Received: by 2002:a63:b919:: with SMTP id z25mr25337810pge.201.1562609318390; 
 Mon, 08 Jul 2019 11:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-2-brendanhiggins@google.com>
 <20190705201505.GA19023@42.do-not-panic.com>
In-Reply-To: <20190705201505.GA19023@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 8 Jul 2019 11:08:27 -0700
Message-ID: <CAFd5g45cF9rYc8YupnCgd=7xz_yW+_TMp_L+cSFUBW7d9njnVQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/18] kunit: test: add KUnit test runner core
To: Luis Chamberlain <mcgrof@kernel.org>
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
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>,
 linux-fsdevel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jul 5, 2019 at 1:15 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Jul 03, 2019 at 05:35:58PM -0700, Brendan Higgins wrote:
> > Add core facilities for defining unit tests; this provides a common way
> > to define test cases, functions that execute code which is under test
> > and determine whether the code under test behaves as expected; this also
> > provides a way to group together related test cases in test suites (here
> > we call them test_modules).
> >
> > Just define test cases and how to execute them for now; setting
> > expectations on code will be defined later.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>
> But a nitpick below, I think that can be fixed later with a follow up
> patch.
>
> > +/**
> > + * struct kunit - represents a running instance of a test.
> > + * @priv: for user to store arbitrary data. Commonly used to pass data created
> > + * in the init function (see &struct kunit_suite).
> > + *
> > + * Used to store information about the current context under which the test is
> > + * running. Most of this data is private and should only be accessed indirectly
> > + * via public functions; the one exception is @priv which can be used by the
> > + * test writer to store arbitrary data.
> > + *
> > + * A brief note on locking:
> > + *
> > + * First off, we need to lock because in certain cases a user may want to use an
> > + * expectation in a thread other than the thread that the test case is running
> > + * in.
>
> This as a prefix to the struct without a lock seems odd. It would be
> clearer I think if you'd explain here what locking mechanism we decided
> to use and why it suffices today.

Whoops, sorry this should have been in the next patch. Will fix.

> > +/**
> > + * suite_test() - used to register a &struct kunit_suite with KUnit.
>
> You mean kunit_test_suite()?

Yep, sorry about that. Will fix.

> > + * @suite: a statically allocated &struct kunit_suite.
> > + *
> > + * Registers @suite with the test framework. See &struct kunit_suite for more
> > + * information.
> > + *
> > + * NOTE: Currently KUnit tests are all run as late_initcalls; this means that
> > + * they cannot test anything where tests must run at a different init phase. One
> > + * significant restriction resulting from this is that KUnit cannot reliably
> > + * test anything that is initialize in the late_init phase.
>                             initialize prior to the late init phase.
>
>
> That is, this is useless to test things running early.

Yeah, I can add that phrasing in.

> > + *
> > + * TODO(brendanhiggins@google.com): Don't run all KUnit tests as late_initcalls.
> > + * I have some future work planned to dispatch all KUnit tests from the same
> > + * place, and at the very least to do so after everything else is definitely
> > + * initialized.
>
> TODOs are odd to be adding to documentation, this is just not common
> place practice. The NOTE should suffice for you.

Because it is a kernel doc? Would you usually make a separate
non-kernel doc comment for a TODO? I guess that makes sense.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
