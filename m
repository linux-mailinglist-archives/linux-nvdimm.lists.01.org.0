Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5495A55BDC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 01:02:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC241212A36E5;
	Tue, 25 Jun 2019 16:02:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.210.195; helo=mail-pf1-f195.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 245622129F059
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 16:02:56 -0700 (PDT)
Received: by mail-pf1-f195.google.com with SMTP id y15so189392pfn.5
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 16:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IAVXlfOigyJbEa5HhE6BwBcpEncScOxFXJXYNv1k45k=;
 b=MtNUGI4azwIJYKailv42VPuNFL/k5YZIHArbDctikpIwIq2RBmUr0ByNzUlohhJ8/l
 fRv36xC4OFAYeTCoufH/whtjA4qqGIZRGQgZ43hGQs2jZD/I4COyANOyET3ERxC0AK27
 l+BkfXu/KcucHdKStrxHdCH2cwqyIxFHNQ/W4jWm9OEfJoje9n+fA/Zx7i2clMpaeh5J
 4zRWpVgCCB7AmmCXnw90Uv3nZYbmaS6dPb+DPE//Ps8GFCpn/vDT8ySSV0DGa8GVCGMd
 r/khlT0658M0f1fceRe+uAuYBE1LVDbyXqa8FBNU7KboIQEfzyEKZZOBl5Bcihcm/pEV
 1IKg==
X-Gm-Message-State: APjAAAU7QOXjW8Y+hhxBiWPi3qeP90gk6eWtE6mFK6rEMQnNLYv9G/FH
 61I7m/bHvl/qTCf2UFyqeJI=
X-Google-Smtp-Source: APXvYqzZBw/dqZhBTNHNMDfHye5/2eZRaAS1PSupftYRQhWIaCqeSFUapN9xTbqyZVwDxqRVbGqHHQ==
X-Received: by 2002:a17:90a:ac13:: with SMTP id
 o19mr354796pjq.143.1561503775428; 
 Tue, 25 Jun 2019 16:02:55 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id r1sm92074pji.15.2019.06.25.16.02.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 16:02:54 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 64827401EB; Tue, 25 Jun 2019 23:02:53 +0000 (UTC)
Date: Tue, 25 Jun 2019 23:02:53 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
Message-ID: <20190625230253.GQ19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
 <20190625214427.GN19023@42.do-not-panic.com>
 <CAFd5g47OABqN127cPKqoCOA_Wr9w=LFh_0XkF7LXu2iY9sFkSw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFd5g47OABqN127cPKqoCOA_Wr9w=LFh_0XkF7LXu2iY9sFkSw@mail.gmail.com>
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

On Tue, Jun 25, 2019 at 03:14:45PM -0700, Brendan Higgins wrote:
> On Tue, Jun 25, 2019 at 2:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > Since its a new architecture and since you seem to imply most tests
> > don't require locking or even IRQs disabled, I think its worth to
> > consider the impact of adding such extreme locking requirements for
> > an initial ramp up.
> 
> Fair enough, I can see the point of not wanting to use irq disabled
> until we get someone complaining about it, but I think making it
> thread safe is reasonable. It means there is one less thing to confuse
> a KUnit user and the only penalty paid is some very minor performance.

One reason I'm really excited about kunit is speed... so by all means I
think we're at a good point to analyze performance optimizationsm if
they do make sense.

While on the topic of parallization, what about support for running
different test cases in parallel? Or at the very least different kunit
modules in parallel.  Few questions come up based on this prospect:

  * Why not support parallelism from the start?
  * Are you opposed to eventually having this added? For instance, there is
    enough code on lib/test_kmod.c for batching tons of kthreads each
    one running its own thing for testing purposes which could be used
    as template.
  * If we eventually *did* support it:
    - Would logs be skewed?
    - Could we have a way to query: give me log for only kunit module
      named "foo"?

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
