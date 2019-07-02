Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9D45D5AC
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jul 2019 19:53:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F99B21962301;
	Tue,  2 Jul 2019 10:53:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C28FD21962301
 for <linux-nvdimm@lists.01.org>; Tue,  2 Jul 2019 10:53:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id i8so4837137pgm.13
 for <linux-nvdimm@lists.01.org>; Tue, 02 Jul 2019 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cUzLBUlR97uqGXzOFylb6nkkxBtyYZ1OhN+qvdTrCD0=;
 b=roBJOIwXGuFOf1wltfxmsClcFxlkrjzp9+21T7P87pZ44BH/GjP/X/NuZ8mK2FoMzO
 XotmCr6d6KsdJATAIIUbq5Oy4zR4Azgkp4HhOE4XiupuZAs2/ZBggUQTxGqGQNrNXKUR
 RK1F2iELvIHqPezIMEexxn9HQjKb0Q7OjYsSgJwmHDUbD4xwBf6WQFlfeS4XFqE89Pff
 n78AWxKci0ljIJl3H7X5khQxePoPu8jM9jZ95VMb0Zsz46NlIICQ2qPhYIcCIBC8U20Z
 P1PLSOLwoWTdUhh3getWGZNkHFehqyZ7w/vmIfDcbd6OQGJv5O6KIgY9x4cjlJKaYt87
 yyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cUzLBUlR97uqGXzOFylb6nkkxBtyYZ1OhN+qvdTrCD0=;
 b=Qtti4S0wdPArZs002OE6JULA4Arb4VBSOCDGMxoUWY49h20KUAGT67Wa6JRLgEb4Qg
 73zNPp64mmUA2bTbpK6mvJKl8k/TD+SgVPraDAQau7F2A5JI6eZcErjRcG6jVQgtDq7w
 6XOOpK8YnFIM6YC/CB2ZZiJuNe+uiilxB/jTY9ve8N2gtjTdy8emg0hNRHVtkjn4fika
 9+j5zLCOnPy1REXhMr0zCI4lr8a3kSu85LEUzC9PuDNvSbQwMNt24tSh2edWD0Ugip4j
 +RjnUVsLU0I/szURJ0Ni/kYKrrjQpRgPzVzMya5AoVXRvpNKF7Ko7frY++51D/63MZGV
 aELw==
X-Gm-Message-State: APjAAAUrqEyahSfDh4iz9X6bgAtrqIebdtovbqjFVIqopdgTKEmO1rYM
 Z5L+fnniXrivXwq6Hn3hpRSlBqNBK4hvenTOt+QGIg==
X-Google-Smtp-Source: APXvYqw1QIOarVsPwN3Ymzn8KxtORstMAVkiFcCA6YNhVqWiDT/WJraRMIndv08KnJT+5qaDY4tAvp9OnwXy65WsZqM=
X-Received: by 2002:a63:205f:: with SMTP id r31mr23471478pgm.159.1562089981635; 
 Tue, 02 Jul 2019 10:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-8-brendanhiggins@google.com>
 <20190625232249.GS19023@42.do-not-panic.com>
 <CAFd5g46mnd=a0OqFCx0hOHX+DxW+5yA2LXH5Q0gEg8yUZK=4FA@mail.gmail.com>
In-Reply-To: <CAFd5g46mnd=a0OqFCx0hOHX+DxW+5yA2LXH5Q0gEg8yUZK=4FA@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 2 Jul 2019 10:52:50 -0700
Message-ID: <CAFd5g46=7OQDREdLDTiMgVWq-Xj2zfOw8cRhPJEihSbO89MDyA@mail.gmail.com>
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

On Wed, Jun 26, 2019 at 12:53 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Jun 25, 2019 at 4:22 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Jun 17, 2019 at 01:26:02AM -0700, Brendan Higgins wrote:
> > > diff --git a/kunit/example-test.c b/kunit/example-test.c
> > > new file mode 100644
> > > index 0000000000000..f44b8ece488bb
> > > --- /dev/null
> > > +++ b/kunit/example-test.c
> >
> > <-- snip -->
> >
> > > +/*
> > > + * This defines a suite or grouping of tests.
> > > + *
> > > + * Test cases are defined as belonging to the suite by adding them to
> > > + * `kunit_cases`.
> > > + *
> > > + * Often it is desirable to run some function which will set up things which
> > > + * will be used by every test; this is accomplished with an `init` function
> > > + * which runs before each test case is invoked. Similarly, an `exit` function
> > > + * may be specified which runs after every test case and can be used to for
> > > + * cleanup. For clarity, running tests in a test module would behave as follows:
> > > + *
> >
> > To be clear this is not the kernel module init, but rather the kunit
> > module init. I think using kmodule would make this clearer to a reader.
>
> Seems reasonable. Will fix in next revision.
>
> > > + * module.init(test);
> > > + * module.test_case[0](test);
> > > + * module.exit(test);
> > > + * module.init(test);
> > > + * module.test_case[1](test);
> > > + * module.exit(test);
> > > + * ...;
> > > + */

Do you think it might be clearer yet to rename `struct kunit_module
*module;` to `struct kunit_suite *suite;`?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
