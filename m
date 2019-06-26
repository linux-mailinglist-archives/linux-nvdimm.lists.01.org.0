Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89CA563C0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 09:53:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 085B3212A36F6;
	Wed, 26 Jun 2019 00:53:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 30FB42129F0E7
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 00:53:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t7so966805plr.11
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JHqsYYLzLAosbxbz1ZkSkQroLN+I/zt1AzacawmONrY=;
 b=WyqM1jV2u/kxM67gNNChMCD/srWLt8UFxif+PHuGpzbgE3LpTJrt7rEbevH6EDg7EA
 xF8tH7Jbh3PLlZYXRvyhQyTIN9G45hD9SE3+nPI4rxVnH9lZ6Wb6PT2UPR9Z7e8qw5Vo
 j4hYPGbTDYxJLGb6+arVCfAloAtiPanpPW4Xadwr7qterJdRgNGgoWGT+JtgLvBc9l+M
 DYSnM5SC1DrNcCapOU3OT8L/UFesJC+ezl51GMqT04qGxB9qB/8ifxdT+misqvwEisfJ
 +/kivnaJfyaOnnN1uM1pke3PaHrKRWJDezKNt97NibKS5p1mAANOOVhiidQQgXRP+WeK
 EcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JHqsYYLzLAosbxbz1ZkSkQroLN+I/zt1AzacawmONrY=;
 b=YcyeGzvVWGvrPrVNaJJhs5HrqBWXtArQGromuiZKPoNQHw7wlHjERTDzCSqcqocUlE
 pLPK2pmYvINlar+d0i3pQcvNpUr8Ui80NsKVch7EV74o+2EjKt5me9hn2XJ2AyLXas8h
 k3/awp0zLo5047GIMRbFMm7K4nCjsv2CCPgFjpgh7l1KWTMLvl/DB2jv/d98P5mvSbX5
 Qz3Q7lj3FHM7uOcNcs5jlCJjxyDQsLU0IknyZviqHQXMHtcZeXdUXqmrr+u+5YH1FB9L
 x+RzmEsAazmyqUUPQ3WRRtkTqSJ2JYZNF41C+tdh1hw4Id1PucbdD2KT4/IcaG/TtHsJ
 6O0g==
X-Gm-Message-State: APjAAAWMUAID8tNG49Sh0F9rRnSLhklpLuQeTFar5nF8EAdoyCeFdIR0
 LeH6zmOaJu5bLOtZ1WLbrow+oabGsHGmKofySZ1ovQ==
X-Google-Smtp-Source: APXvYqx0OC49B+0u9fYvW2+xXIuYcGfgocchgfhlK03aaHz2u6I5PoagyCc52QVITc8deDrbZKlEXXtykOtZNEDzro4=
X-Received: by 2002:a17:902:1004:: with SMTP id
 b4mr3862082pla.325.1561535609164; 
 Wed, 26 Jun 2019 00:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-8-brendanhiggins@google.com>
 <20190625232249.GS19023@42.do-not-panic.com>
In-Reply-To: <20190625232249.GS19023@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 26 Jun 2019 00:53:18 -0700
Message-ID: <CAFd5g46mnd=a0OqFCx0hOHX+DxW+5yA2LXH5Q0gEg8yUZK=4FA@mail.gmail.com>
Subject: Re: [PATCH v5 07/18] kunit: test: add initial tests
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

On Tue, Jun 25, 2019 at 4:22 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 01:26:02AM -0700, Brendan Higgins wrote:
> > diff --git a/kunit/example-test.c b/kunit/example-test.c
> > new file mode 100644
> > index 0000000000000..f44b8ece488bb
> > --- /dev/null
> > +++ b/kunit/example-test.c
>
> <-- snip -->
>
> > +/*
> > + * This defines a suite or grouping of tests.
> > + *
> > + * Test cases are defined as belonging to the suite by adding them to
> > + * `kunit_cases`.
> > + *
> > + * Often it is desirable to run some function which will set up things which
> > + * will be used by every test; this is accomplished with an `init` function
> > + * which runs before each test case is invoked. Similarly, an `exit` function
> > + * may be specified which runs after every test case and can be used to for
> > + * cleanup. For clarity, running tests in a test module would behave as follows:
> > + *
>
> To be clear this is not the kernel module init, but rather the kunit
> module init. I think using kmodule would make this clearer to a reader.

Seems reasonable. Will fix in next revision.

> > + * module.init(test);
> > + * module.test_case[0](test);
> > + * module.exit(test);
> > + * module.init(test);
> > + * module.test_case[1](test);
> > + * module.exit(test);
> > + * ...;
> > + */
>
>   Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
