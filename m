Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659AE5D7AE
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jul 2019 22:57:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B1EE221962301;
	Tue,  2 Jul 2019 13:57:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.210.194; helo=mail-pf1-f194.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 41657211A2DB2
 for <linux-nvdimm@lists.01.org>; Tue,  2 Jul 2019 13:57:16 -0700 (PDT)
Received: by mail-pf1-f194.google.com with SMTP id d126so45374pfd.2
 for <linux-nvdimm@lists.01.org>; Tue, 02 Jul 2019 13:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DtQmDM1bjxYXcqNKxDIhe3kpTPPYxiOv+5lbfQfOZdE=;
 b=tLWyLXn9VRCmw9R1YwIR5ZhyO8RtAbgFji9yXl7qtl3sI0KEdGWFvVUcU7S9LjUM1X
 +4yfsfonasbNg1B7qxgWwv0AadVzieMo+eqT/OC1oKZR9sakdNsZuBLL4jnfDr7Stsay
 BB7lCWZWylt95cc1Uq0/bYJXWegU9Bc85lYs5c9jLRwJ7nx2E6dDnidr2eFeWiIn/Rat
 LdRCfP6EHVzM4We8+kgHLgRF55e/8ah8ogrTa5SuxbRyYVeZJlJfizMXeLTb5umddQus
 eTDzedUYeSYQukxoQsvAd8pxhYbyV8Cj4GrysrlCz+GYTXlnmQ0hP+9yJ3xhFNQ878eN
 FXyQ==
X-Gm-Message-State: APjAAAXu26hvPw7j8Qb/bYhpNuwr5+Bw/E2FJIqS2WO1/PhTnl7MEcLW
 3vsbORFjQ55ARtyiGVNH/uM=
X-Google-Smtp-Source: APXvYqxgfIVc55JlioUk1yKtSLmO9ntomZUFE6/lH8QIzZr758B9lCLwgU+mAmopE2kMlm4WWSK35A==
X-Received: by 2002:a63:f342:: with SMTP id t2mr30570356pgj.83.1562101035558; 
 Tue, 02 Jul 2019 13:57:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id d26sm16963231pfn.29.2019.07.02.13.57.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 13:57:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id DC91A40251; Tue,  2 Jul 2019 20:57:12 +0000 (UTC)
Date: Tue, 2 Jul 2019 20:57:12 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 07/18] kunit: test: add initial tests
Message-ID: <20190702205712.GS19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-8-brendanhiggins@google.com>
 <20190625232249.GS19023@42.do-not-panic.com>
 <CAFd5g46mnd=a0OqFCx0hOHX+DxW+5yA2LXH5Q0gEg8yUZK=4FA@mail.gmail.com>
 <CAFd5g46=7OQDREdLDTiMgVWq-Xj2zfOw8cRhPJEihSbO89MDyA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFd5g46=7OQDREdLDTiMgVWq-Xj2zfOw8cRhPJEihSbO89MDyA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Tue, Jul 02, 2019 at 10:52:50AM -0700, Brendan Higgins wrote:
> On Wed, Jun 26, 2019 at 12:53 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Tue, Jun 25, 2019 at 4:22 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Mon, Jun 17, 2019 at 01:26:02AM -0700, Brendan Higgins wrote:
> > > > diff --git a/kunit/example-test.c b/kunit/example-test.c
> > > > new file mode 100644
> > > > index 0000000000000..f44b8ece488bb
> > > > --- /dev/null
> > > > +++ b/kunit/example-test.c
> > >
> > > <-- snip -->
> > >
> > > > +/*
> > > > + * This defines a suite or grouping of tests.
> > > > + *
> > > > + * Test cases are defined as belonging to the suite by adding them to
> > > > + * `kunit_cases`.
> > > > + *
> > > > + * Often it is desirable to run some function which will set up things which
> > > > + * will be used by every test; this is accomplished with an `init` function
> > > > + * which runs before each test case is invoked. Similarly, an `exit` function
> > > > + * may be specified which runs after every test case and can be used to for
> > > > + * cleanup. For clarity, running tests in a test module would behave as follows:
> > > > + *
> > >
> > > To be clear this is not the kernel module init, but rather the kunit
> > > module init. I think using kmodule would make this clearer to a reader.
> >
> > Seems reasonable. Will fix in next revision.
> >
> > > > + * module.init(test);
> > > > + * module.test_case[0](test);
> > > > + * module.exit(test);
> > > > + * module.init(test);
> > > > + * module.test_case[1](test);
> > > > + * module.exit(test);
> > > > + * ...;
> > > > + */
> 
> Do you think it might be clearer yet to rename `struct kunit_module
> *module;` to `struct kunit_suite *suite;`?

Yes. Definitely. Or struct kunit_test. Up to you.

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
