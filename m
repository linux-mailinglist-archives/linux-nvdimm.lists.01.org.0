Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670FBB0DA
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Sep 2019 11:05:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C890621962301;
	Mon, 23 Sep 2019 02:07:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2E9BD202ECFC3
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 02:07:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z12so7649782pgp.9
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v8pa0Tk6FlMlkzD8bXA6NA6bMdvmrzwl4PAFIDbVMYM=;
 b=NvXQgh6IW3soN2kC6YtQSTm4nJDtjH7T1g1wwUk4J2MMTXgFeWqE4zDVwCvgvthfAE
 WGgMCY+3F8tX2ulk7a71LHHwNjjj6szslWqQDPwjwKZALkV5YkTouU1UbPdDScjYS1A3
 tU4aEIFZK99BR3XOVeaN/cSOFn3rfi7yObVLV3PWs+NfL5qPlxMyeRQLXGH1oSX1DcR+
 Y00Kq9GxGhG7rrAxC5FyQBB+KSDkFMah1k7qmSzRXBnClfBw0q/Abrxnd2xhD8r5qEtT
 Tri2HbzI2Jc1bPenj4gaZNMu/v3ap/CxdJdQ2lrX7Qpp+yqg86whqYHZk9TgPcLogoid
 i1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v8pa0Tk6FlMlkzD8bXA6NA6bMdvmrzwl4PAFIDbVMYM=;
 b=gNzJO74drnAauB2/otKA03GCVk42DhFrSABrSZyWoPXhjt4SSJH2o6uIJmMLGt3R3p
 +xjODwIvFhPOO/V6C+gtg/XHqIZDN+nLBJME+VywHyy8kcKKqY3IGgDgjZKWHYSf3Nil
 RXMKykGm6UbEQtz/AI88JqiHW3D41I/cYm2dgzOVnMYNc7T/FzEW2zgI/H3u1uRqOkuY
 x6H6W8A0zqQyHyIB7BoFr4QUjzQEDF2WU81JOgr3llzbCzGj2rU1rh0mRHYR6P4frP7h
 bghobLDdVTMBvF8FF40kKIRD8oO4k7L85hjC+2m99HLRP1/3Vw+n4pC5rT6vZOdEzXT1
 MsDw==
X-Gm-Message-State: APjAAAUELhmm+VNaM+l9k3bvp+T0kKsjtSAehMe17NDsmOuA+iZnfLuD
 obwib/E9cZ824jRbohd56lnFvfe90Pa/Iy3lh+9Bkw==
X-Google-Smtp-Source: APXvYqwcsKtiLcxSzZRbvj/9c2PAwvr8gZTaDk07lPhILKUwjb/s/yL4yzfAO84TT2ZemaVLn8TDzTeRlveY2nu9F6o=
X-Received: by 2002:a17:90a:1746:: with SMTP id
 6mr5388129pjm.117.1569229513429; 
 Mon, 23 Sep 2019 02:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
 <20190921001855.200947-8-brendanhiggins@google.com>
 <944ac47d-1411-9ebd-d0d4-a616c88c9c20@infradead.org>
In-Reply-To: <944ac47d-1411-9ebd-d0d4-a616c88c9c20@infradead.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 23 Sep 2019 02:05:02 -0700
Message-ID: <CAFd5g44e9bdK8h5+U1MkqPNuf2k9vnu-iPFLTzGajEHPEcRpHQ@mail.gmail.com>
Subject: Re: [PATCH v17 07/19] kunit: test: add initial tests
To: Randy Dunlap <rdunlap@infradead.org>
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
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sun, Sep 22, 2019 at 9:28 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/20/19 5:18 PM, Brendan Higgins wrote:
> > Add a test for string stream along with a simpler example.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  lib/kunit/Kconfig              | 25 ++++++++++
> >  lib/kunit/Makefile             |  4 ++
> >  lib/kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++
> >  lib/kunit/string-stream-test.c | 52 ++++++++++++++++++++
> >  4 files changed, 169 insertions(+)
> >  create mode 100644 lib/kunit/example-test.c
> >  create mode 100644 lib/kunit/string-stream-test.c
> >
> > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > index 666b9cb67a74..3868c226cf31 100644
> > --- a/lib/kunit/Kconfig
> > +++ b/lib/kunit/Kconfig
> > @@ -11,3 +11,28 @@ menuconfig KUNIT
> >         special hardware when using UML. Can also be used on most other
> >         architectures. For more information, please see
> >         Documentation/dev-tools/kunit/.
> > +
> > +if KUNIT
>
> The 'if' above provides the dependency clause, so the 2 'depends on KUNIT'
> below are not needed.  They are redundant.

Thanks for catching that. I fixed it in the new revision I just sent out.

> > +
> > +config KUNIT_TEST
> > +     bool "KUnit test for KUnit"
> > +     depends on KUNIT
> > +     help
> > +       Enables the unit tests for the KUnit test framework. These tests test
> > +       the KUnit test framework itself; the tests are both written using
> > +       KUnit and test KUnit. This option should only be enabled for testing
> > +       purposes by developers interested in testing that KUnit works as
> > +       expected.
> > +
> > +config KUNIT_EXAMPLE_TEST
> > +     bool "Example test for KUnit"
> > +     depends on KUNIT
> > +     help
> > +       Enables an example unit test that illustrates some of the basic
> > +       features of KUnit. This test only exists to help new users understand
> > +       what KUnit is and how it is used. Please refer to the example test
> > +       itself, lib/kunit/example-test.c, for more information. This option
> > +       is intended for curious hackers who would like to understand how to
> > +       use KUnit for kernel development.
> > +
> > +endif # KUNIT

Cheers
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
