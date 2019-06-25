Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2383455A22
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Jun 2019 23:44:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 79B22212A36D2;
	Tue, 25 Jun 2019 14:44:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.215.195; helo=mail-pg1-f195.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5BD0021945DC7
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 14:44:30 -0700 (PDT)
Received: by mail-pg1-f195.google.com with SMTP id f25so81859pgv.10
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 14:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9dxyIPqcP8jDSy0GUtYumC+DRq05muFlYTTdqsbRigE=;
 b=CBgOJWoCd+Fc53ql2nDssO+3HsUmUHghSmATbhbDAMMpF6nnORQWVw+Hq1HTm1+4GK
 mQHsRsX5RNemJD6QxreHSxOT67tge5XWXzRCKnBwl0OZXWfGlr3Pe7RX4sofS7SjRnSm
 7yHVDXmprq8VLN1k4mzmRvjNvPq0c/Nb8A+GhjnWqhtnJUul2oFGsjoqnU+cNe6JF9O7
 NjL+/6XycEZjIEg979rs9cYmNs0bx4zw6eCF9li0a3TMBmZHsTemfmOyNHn+yXWlMFGT
 ORuCdFNSbOJyYEaWEX3L2ksIVQMqlf0IBgjZvEa/k9UoEQisVHuHqG1h4ATB0Yqgx+PU
 JpuQ==
X-Gm-Message-State: APjAAAXJA7NOL2xazfUf7isqWvkGQHC0jwlp4LXGT/NSAjq82Esbw80w
 MTsSF5EIzwzwn1glgP8SAYU=
X-Google-Smtp-Source: APXvYqz8MfGhRhi/dlXuLkoaF1E80HXc/ju/CwZ7//TYZw6Vnsx8tuHl88GSOvVc/go3GBogDeg5Ig==
X-Received: by 2002:a63:7d18:: with SMTP id y24mr36133502pgc.438.1561499069415; 
 Tue, 25 Jun 2019 14:44:29 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id a20sm13423142pgb.72.2019.06.25.14.44.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 14:44:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 3C710401EB; Tue, 25 Jun 2019 21:44:27 +0000 (UTC)
Date: Tue, 25 Jun 2019 21:44:27 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
Message-ID: <20190625214427.GN19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
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

On Tue, Jun 25, 2019 at 01:28:25PM -0700, Brendan Higgins wrote:
> On Wed, Jun 19, 2019 at 5:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-06-17 01:25:56)
> > > diff --git a/kunit/test.c b/kunit/test.c
> > > new file mode 100644
> > > index 0000000000000..d05d254f1521f
> > > --- /dev/null
> > > +++ b/kunit/test.c
> > > @@ -0,0 +1,210 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Base unit test (KUnit) API.
> > > + *
> > > + * Copyright (C) 2019, Google LLC.
> > > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > > + */
> > > +
> > > +#include <linux/sched/debug.h>
> > > +#include <kunit/test.h>
> > > +
> > > +static bool kunit_get_success(struct kunit *test)
> > > +{
> > > +       unsigned long flags;
> > > +       bool success;
> > > +
> > > +       spin_lock_irqsave(&test->lock, flags);
> > > +       success = test->success;
> > > +       spin_unlock_irqrestore(&test->lock, flags);
> >
> > I still don't understand the locking scheme in this code. Is the
> > intention to make getter and setter APIs that are "safe" by adding in a
> > spinlock that is held around getting and setting various members in the
> > kunit structure?
> 
> Yes, your understanding is correct. It is possible for a user to write
> a test such that certain elements may be updated in different threads;
> this would most likely happen in the case where someone wants to make
> an assertion or an expectation in a thread created by a piece of code
> under test. Although this should generally be avoided, it is possible,
> and there are occasionally good reasons to do so, so it is
> functionality that we should support.
> 
> Do you think I should add a comment to this effect?
> 
> > In what situation is there more than one thread reading or writing the
> > kunit struct? Isn't it only a single process that is going to be
> 
> As I said above, it is possible that the code under test may spawn a
> new thread that may make an expectation or an assertion. It is not a
> super common use case, but it is possible.

I wonder if it is worth to have then different types of tests based on
locking requirements. One with no locking, since it seems you imply
most tests would fall under this category, then locking, and another
with IRQ context.

If no locking is done at all for all tests which do not require locking,
is there any gains at run time? I'm sure it might be minimum but
curious.

> > operating on this structure? And why do we need to disable irqs? Are we
> > expecting to be modifying the unit tests from irq contexts?
> 
> There are instances where someone may want to test a driver which has
> an interrupt handler in it. I actually have (not the greatest) example
> here. Now in these cases, I expect someone to use a mock irqchip or
> some other fake mechanism to trigger the interrupt handler and not
> actual hardware; technically speaking in this case, it is not going to
> be accessed from a "real" irq context; however, the code under test
> should think that it is in an irq context; given that, I figured it is
> best to just treat it as a real irq context. Does that make sense?

Since its a new architecture and since you seem to imply most tests
don't require locking or even IRQs disabled, I think its worth to
consider the impact of adding such extreme locking requirements for
an initial ramp up.

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
