Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645055AD5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 00:15:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 70E56212A36E0;
	Tue, 25 Jun 2019 15:14:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D92C4212A36DB
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 15:14:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y15so132111pfn.5
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 15:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3T/u7V091HbAklhSEBy2pvLlCGAKMdVNlTSclQyRnpc=;
 b=ZoosysAkLc7RgErWxK5FnvM9RfcOs6mWm5WOqtPjUqxIqHpReyhsVFvslRzLoV3q6k
 miAcaLs/6/zELponnm9xpGa9FZgG6JHCtwbwwbsHrYPAVLPTXKnsAGZekzo/1E+v3r7q
 MAyz+XT8oIYL+RBKU6gcMfBPkx0i9G9kx5C+icFSHWtjKBEQssSIkQPmyDMJkhDb/APn
 rRRqx5pehUt6wHDwbMbahfsOf2X1S8Q3jv4bjOdkgKsJGdYPvje9VOWjIuTF7Q/SCVfF
 wDn/9hiMVLqSYlkj9TG58JxRLAwgxPn7xvEpgJy0gDIbJSP6wZCqkWFGLqYmeLIB06YQ
 qR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3T/u7V091HbAklhSEBy2pvLlCGAKMdVNlTSclQyRnpc=;
 b=ue65VTpD4Zvylk9jAoFLybN9cOlGLPVqgagsnrg+6VgJ9ieUcHSJBLrVbAOQ2k3D8V
 Tr5kcbiotvfdKKCjSV1tAhuZJMNPiDMmsjnQkUkugLGWdga6w0Ua7ZCkzcPg9SAKVEnX
 DFz2+bU+szwIHlzZ4OvlLpAT0kVe7vnukVFDMdMYgYRT9xbk6OqTt/FuUkB4zojicDUL
 l/3n8V6E+OXf137L31vpKapjZuXyaAqSdcBfkcIdWDbGVuYlM01dAUZspHMhW4Di3gh+
 wFxfCDtZzgFkXIn17kUXET70GIcdFs5VKOtuz6AAkAumtpCRzeu1VWNap78vHosCF7dD
 dyow==
X-Gm-Message-State: APjAAAWeVcbrAcvbgRZm1Ow2Qtu1OpUsMIoBqSK8bKK46NTCQT48p/Vo
 qFbSJwBx6H47tvPZCaDUViUsquwBuhyv4B/BJ3LIcg==
X-Google-Smtp-Source: APXvYqzlEoDZX+cOnuipK7PjmAMWm3uFqbtUZEXyCZSNz1gEBa4cWncDmW9O+QuwSqz4K1dG1pGT/q+vccTvIeTjlVo=
X-Received: by 2002:a63:1459:: with SMTP id 25mr40704314pgu.201.1561500896729; 
 Tue, 25 Jun 2019 15:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
 <20190625214427.GN19023@42.do-not-panic.com>
In-Reply-To: <20190625214427.GN19023@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 25 Jun 2019 15:14:45 -0700
Message-ID: <CAFd5g47OABqN127cPKqoCOA_Wr9w=LFh_0XkF7LXu2iY9sFkSw@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
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

On Tue, Jun 25, 2019 at 2:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Jun 25, 2019 at 01:28:25PM -0700, Brendan Higgins wrote:
> > On Wed, Jun 19, 2019 at 5:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Brendan Higgins (2019-06-17 01:25:56)
> > > > diff --git a/kunit/test.c b/kunit/test.c
> > > > new file mode 100644
> > > > index 0000000000000..d05d254f1521f
> > > > --- /dev/null
> > > > +++ b/kunit/test.c
> > > > @@ -0,0 +1,210 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Base unit test (KUnit) API.
> > > > + *
> > > > + * Copyright (C) 2019, Google LLC.
> > > > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > > > + */
> > > > +
> > > > +#include <linux/sched/debug.h>
> > > > +#include <kunit/test.h>
> > > > +
> > > > +static bool kunit_get_success(struct kunit *test)
> > > > +{
> > > > +       unsigned long flags;
> > > > +       bool success;
> > > > +
> > > > +       spin_lock_irqsave(&test->lock, flags);
> > > > +       success = test->success;
> > > > +       spin_unlock_irqrestore(&test->lock, flags);
> > >
> > > I still don't understand the locking scheme in this code. Is the
> > > intention to make getter and setter APIs that are "safe" by adding in a
> > > spinlock that is held around getting and setting various members in the
> > > kunit structure?
> >
> > Yes, your understanding is correct. It is possible for a user to write
> > a test such that certain elements may be updated in different threads;
> > this would most likely happen in the case where someone wants to make
> > an assertion or an expectation in a thread created by a piece of code
> > under test. Although this should generally be avoided, it is possible,
> > and there are occasionally good reasons to do so, so it is
> > functionality that we should support.
> >
> > Do you think I should add a comment to this effect?
> >
> > > In what situation is there more than one thread reading or writing the
> > > kunit struct? Isn't it only a single process that is going to be
> >
> > As I said above, it is possible that the code under test may spawn a
> > new thread that may make an expectation or an assertion. It is not a
> > super common use case, but it is possible.
>
> I wonder if it is worth to have then different types of tests based on
> locking requirements. One with no locking, since it seems you imply
> most tests would fall under this category, then locking, and another
> with IRQ context.
>
> If no locking is done at all for all tests which do not require locking,
> is there any gains at run time? I'm sure it might be minimum but
> curious.

Yeah, I don't think it is worth it.

I don't think we need to be squeezing every ounce of performance out
of unit tests, since they are inherently a cost and are not intended
to be run in a production deployed kernel as part of normal production
usage.

> > > operating on this structure? And why do we need to disable irqs? Are we
> > > expecting to be modifying the unit tests from irq contexts?
> >
> > There are instances where someone may want to test a driver which has
> > an interrupt handler in it. I actually have (not the greatest) example
> > here. Now in these cases, I expect someone to use a mock irqchip or
> > some other fake mechanism to trigger the interrupt handler and not
> > actual hardware; technically speaking in this case, it is not going to
> > be accessed from a "real" irq context; however, the code under test
> > should think that it is in an irq context; given that, I figured it is
> > best to just treat it as a real irq context. Does that make sense?
>
> Since its a new architecture and since you seem to imply most tests
> don't require locking or even IRQs disabled, I think its worth to
> consider the impact of adding such extreme locking requirements for
> an initial ramp up.

Fair enough, I can see the point of not wanting to use irq disabled
until we get someone complaining about it, but I think making it
thread safe is reasonable. It means there is one less thing to confuse
a KUnit user and the only penalty paid is some very minor performance.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
