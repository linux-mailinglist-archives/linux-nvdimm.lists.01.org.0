Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBE257409
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 00:02:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DFB8E21962301;
	Wed, 26 Jun 2019 15:02:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.214.194; helo=mail-pl1-f194.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6EF3D212A36C4
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 15:02:07 -0700 (PDT)
Received: by mail-pl1-f194.google.com with SMTP id b7so79239pls.6
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 15:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pncFvuTLXYoGgXNL3R5Dcm7FSED9aawZhvXRFRAEX+A=;
 b=GeNKqlhBs1dhsD97rccjJI/da7z153JNy/QWj7jQOZzTa0xUFdnp7FLyyItPO/gk0P
 smO4jy4Mx9DfWQD9qTBQX7xS2NFw+3ZH1GXnWK+tPPy8oScNuvxpPm67+FoyA21h1qlV
 ZF1nCdLdqzCaIIBMFDDTNcN45WoTC27txwgesDnriz3xBdbu964FQdfdmSQtrwsMqy7T
 iWACanqO9/9rHhfySv6AZTAwvtgBaOqnwoExqmMU705FqUw7shWrDxdHjQawZ8HvjVHs
 uups9pgMnIphPHWU0EdJFL0unPyCphk+ssjsMt+sNgzLqbRLdw0SGqtDlMXTRgG8xaai
 QpRw==
X-Gm-Message-State: APjAAAVb2V8jBten+Xj/cDZJvXPKYeUUZ3z04XcVz7kxdotr/jdEM2Yy
 i3/KqKglffkHyZK/BKIwnBY=
X-Google-Smtp-Source: APXvYqz2bPP4PqTF9BuVt2O9juLFvMSSMYKeoVt6+esjv4Dsli0F9B+q17JOFwfl4ENv66EipVz4ng==
X-Received: by 2002:a17:902:a517:: with SMTP id
 s23mr381726plq.306.1561586526522; 
 Wed, 26 Jun 2019 15:02:06 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id t13sm3933781pjo.13.2019.06.26.15.02.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 15:02:05 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 67612401D0; Wed, 26 Jun 2019 22:02:04 +0000 (UTC)
Date: Wed, 26 Jun 2019 22:02:04 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
Message-ID: <20190626220204.GZ19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
 <20190625214427.GN19023@42.do-not-panic.com>
 <CAFd5g47OABqN127cPKqoCOA_Wr9w=LFh_0XkF7LXu2iY9sFkSw@mail.gmail.com>
 <20190625230253.GQ19023@42.do-not-panic.com>
 <CAFd5g45fSdpytudDyD3Yo1ti=kU_JJ6S9yz53_L=pnZTjQFU9A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFd5g45fSdpytudDyD3Yo1ti=kU_JJ6S9yz53_L=pnZTjQFU9A@mail.gmail.com>
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

On Tue, Jun 25, 2019 at 11:41:47PM -0700, Brendan Higgins wrote:
> On Tue, Jun 25, 2019 at 4:02 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, Jun 25, 2019 at 03:14:45PM -0700, Brendan Higgins wrote:
> > > On Tue, Jun 25, 2019 at 2:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > Since its a new architecture and since you seem to imply most tests
> > > > don't require locking or even IRQs disabled, I think its worth to
> > > > consider the impact of adding such extreme locking requirements for
> > > > an initial ramp up.
> > >
> > > Fair enough, I can see the point of not wanting to use irq disabled
> > > until we get someone complaining about it, but I think making it
> > > thread safe is reasonable. It means there is one less thing to confuse
> > > a KUnit user and the only penalty paid is some very minor performance.
> >
> > One reason I'm really excited about kunit is speed... so by all means I
> > think we're at a good point to analyze performance optimizationsm if
> > they do make sense.
> 
> Yeah, but I think there are much lower hanging fruit than this (as you
> point out below). I am all for making/keeping KUnit super fast, but I
> also don't want to waste time with premature optimizations and I think
> having thread safe expectations and non-thread safe expectations hurts
> usability.
> 
> Still, I am on board with making this a mutex instead of a spinlock for now.
> 
> > While on the topic of parallization, what about support for running
> > different test cases in parallel? Or at the very least different kunit
> > modules in parallel.  Few questions come up based on this prospect:
> >
> >   * Why not support parallelism from the start?
> 
> Just because it is more work and there isn't much to gain from it right now.
> 
> Some numbers:
> I currently have a collection of 86 test cases in the branch that this
> patchset is from.

Impressive, imagine 86 tests and kunit is not even *merged yet*.

> I turned on PRINTK_TIME and looked at the first
> KUnit output and the last. On UML, start time was 0.090000, and end
> time was 0.090000. Looks like sched_clock is not very good on UML.

Since you have a python thing that kicks tests, what if you just run
time on it?

> Still it seems quite likely that all of these tests run around 0.01
> seconds or less on UML: I ran KUnit with only 2 test cases enabled
> three times and got an average runtime of 1.55867 seconds with a
> standard deviation of 0.0346747. I then ran it another three times
> with all test cases enabled and got an average runtime of 1.535
> seconds with a standard deviation of 0.0150997. The second average is
> less, but that doesn't really mean anything because it is well within
> one standard deviation with a very small sample size. Nevertheless, we
> can conclude that the actual runtime of those 84 test cases is most
> likely within one standard deviation, so on the order of 0.01 seconds.
> 
> On x86 running on QEMU, first message from KUnit was printed at
> 0.194251 and the last KUnit message was printed at 0.340915, meaning
> that all 86 test cases ran in about 0.146664 seconds.

Pretty impressive numbers. But can you blame me for expressing the
desire to possibly being able to do better? I am not saying -- let's
definitely have parallelism in place *now*. Just wanted to hear out
tangibles of why we *don't* want it now.

And.. also, since we are reviewing now, try to target so that the code
can later likely get a face lift to support parallelism without
requiring much changes.

> In any case, running KUnit tests in parallel is definitely something I
> plan on adding it eventually, but it just doesn't really seem worth it
> right now.

Makes sense!

> I find the incremental build time of the kernel to
> typically be between 3 and 30 seconds, and a clean build to be between
> 30 seconds to several minutes, depending on the number of available
> cores, so I don't think most users would even notice the amount of
> runtime contributed by the actual unit tests until we start getting
> into the 1000s of test cases. I don't suspect it will become an issue
> until we get into the 10,000s of test cases. I think we are a pretty
> long way off from that.

All makes sense, and agreed based on the numbers you are providing.
Thanks for the details!

> >   * Are you opposed to eventually having this added? For instance, there is
> >     enough code on lib/test_kmod.c for batching tons of kthreads each
> >     one running its own thing for testing purposes which could be used
> >     as template.
> 
> I am not opposed to adding it eventually at all. I actually plan on
> doing so, just not in this patchset. There are a lot of additional
> features, improvements, and sugar that I really want to add, so much
> so that most of it doesn't belong in this patchset; I just think this
> is one of those things that belongs in a follow up. I tried to boil
> down this patchset to as small as I could while still being useful;
> this is basically an MVP. Maybe after this patchset gets merged I
> should post a list of things I have ready for review, or would like to
> work on, and people can comment on what things they want to see next.

Groovy.

> >   * If we eventually *did* support it:
> >     - Would logs be skewed?
> 
> Probably, before I went with the TAP approach, I was tagging each
> message with the test case it came from and I could have parsed it and
> assembled a coherent view of the logs using that; now that I am using
> TAP conforming output, that won't work. I haven't really thought too
> hard about how to address it, but there are ways. For the UML users, I
> am planning on adding a feature to guarantee hermeticity between tests
> running in different modules by adding a feature that allows a single
> kernel to be built with all tests included, and then determine which
> tests get run by passing in command line arguments or something. This
> way you can get the isolation from running tests in separate
> environments without increasing the build cost. We could also use this
> method to achieve parallelism by dispatching multiple kernels at once.

Indeed. Or... wait for it... containers... There tools for these sorts
of things already. And I'm evaluating such prospects now for some other
tests I care for.

> That only works for UML, but I imagine you could do something similar
> for users running tests under qemu.

Or containers.

> >     - Could we have a way to query: give me log for only kunit module
> >       named "foo"?
> 
> Yeah, I think that would make sense as part of the hermeticity thing I
> mentioned above.
> 
> Hope that seems reasonable!

All groovy. Thanks for the details!

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
