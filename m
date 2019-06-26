Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDD05627E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 08:42:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AF396212A36FF;
	Tue, 25 Jun 2019 23:42:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 15279212A36FC
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 23:41:59 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a93so859612pla.7
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 23:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=97fNQhRc8wq4ewqRwHUZivSXGNy3wo+DiktNt6BuM1o=;
 b=m8w/QLFUOkV2r8nM4dXom4nB8yKJb7/7QTMOMQn0qijo9CexrHeK+bR0MPOk7K64RN
 oMDOQhVkXnI4UYsxoZERTzMchuU8ZuSXQVbe7PD7GBq58swJ1B0wl9zg2T1jDJjIFcpW
 O/5R7uaHiYc5vvAJDPHpVhmTpcBeCykDYFrlkLu92iDqXDEGHmkNFrPVme8ha3yeMa+9
 SSjqnz+drMupIrIAA5p2oUG6JB/gHz+XdzOb+NPLguWQM152NiUsdJnj04d+wIazVHoY
 RqDDXsDiktD7TWekl63ZaXNaVelF0ltlqznPeRmml4YQVzfq60nVLckHZybN7zV2zT1m
 aBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=97fNQhRc8wq4ewqRwHUZivSXGNy3wo+DiktNt6BuM1o=;
 b=lfOh6ZFu8UkPeJH4R3QZSyYSc0QvrkW34K0eAKQTYMXZshD7/czSdYTrhf7nAG2A69
 K9SRtlt7VzmuS5j0cSRcBxSlleQCV+Vsq39AM95jspA4yo5UD0bMKQ1/x/kSoJVUKqGp
 U8aHu69ddJ9DsEmQCMOTrkq8J7OVdgRI/yXn0A3ujjD5c9C98mwnZKpDA9K5tUKhQe2f
 1oBVgTSgiMm4RHl5UIlwMIBgi5idjuVwrlTpdzVz3oBvGydylO5KXMSPi0T/f0HKKJat
 AzFzXqjzhdRb7w5U6rtyE/wcOcDcsP6ok4X8CL09VDgFxUspan1Cth5KsdR/axZuiSvV
 Sv9w==
X-Gm-Message-State: APjAAAX6U0Jkuff7zaeMDoVdwb2M1OA3ieZFtX7yrUlnyWZiXmyl0GBH
 wZcZ+aoyZwJeA66IjX85LKV3/qADAl9i0JcDqQUyXQ==
X-Google-Smtp-Source: APXvYqybmTOAarjOR0jsvnzpNTD7C7S9tNEkokPreMksaC4ZkzPoppWa0LA/1WlZ/NQmXAUQqe9Hs4JcwK0nevbM4K4=
X-Received: by 2002:a17:902:1004:: with SMTP id
 b4mr3503891pla.325.1561531318934; 
 Tue, 25 Jun 2019 23:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
 <20190625214427.GN19023@42.do-not-panic.com>
 <CAFd5g47OABqN127cPKqoCOA_Wr9w=LFh_0XkF7LXu2iY9sFkSw@mail.gmail.com>
 <20190625230253.GQ19023@42.do-not-panic.com>
In-Reply-To: <20190625230253.GQ19023@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 25 Jun 2019 23:41:47 -0700
Message-ID: <CAFd5g45fSdpytudDyD3Yo1ti=kU_JJ6S9yz53_L=pnZTjQFU9A@mail.gmail.com>
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

On Tue, Jun 25, 2019 at 4:02 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Jun 25, 2019 at 03:14:45PM -0700, Brendan Higgins wrote:
> > On Tue, Jun 25, 2019 at 2:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > Since its a new architecture and since you seem to imply most tests
> > > don't require locking or even IRQs disabled, I think its worth to
> > > consider the impact of adding such extreme locking requirements for
> > > an initial ramp up.
> >
> > Fair enough, I can see the point of not wanting to use irq disabled
> > until we get someone complaining about it, but I think making it
> > thread safe is reasonable. It means there is one less thing to confuse
> > a KUnit user and the only penalty paid is some very minor performance.
>
> One reason I'm really excited about kunit is speed... so by all means I
> think we're at a good point to analyze performance optimizationsm if
> they do make sense.

Yeah, but I think there are much lower hanging fruit than this (as you
point out below). I am all for making/keeping KUnit super fast, but I
also don't want to waste time with premature optimizations and I think
having thread safe expectations and non-thread safe expectations hurts
usability.

Still, I am on board with making this a mutex instead of a spinlock for now.

> While on the topic of parallization, what about support for running
> different test cases in parallel? Or at the very least different kunit
> modules in parallel.  Few questions come up based on this prospect:
>
>   * Why not support parallelism from the start?

Just because it is more work and there isn't much to gain from it right now.

Some numbers:
I currently have a collection of 86 test cases in the branch that this
patchset is from. I turned on PRINTK_TIME and looked at the first
KUnit output and the last. On UML, start time was 0.090000, and end
time was 0.090000. Looks like sched_clock is not very good on UML.

Still it seems quite likely that all of these tests run around 0.01
seconds or less on UML: I ran KUnit with only 2 test cases enabled
three times and got an average runtime of 1.55867 seconds with a
standard deviation of 0.0346747. I then ran it another three times
with all test cases enabled and got an average runtime of 1.535
seconds with a standard deviation of 0.0150997. The second average is
less, but that doesn't really mean anything because it is well within
one standard deviation with a very small sample size. Nevertheless, we
can conclude that the actual runtime of those 84 test cases is most
likely within one standard deviation, so on the order of 0.01 seconds.

On x86 running on QEMU, first message from KUnit was printed at
0.194251 and the last KUnit message was printed at 0.340915, meaning
that all 86 test cases ran in about 0.146664 seconds.

In any case, running KUnit tests in parallel is definitely something I
plan on adding it eventually, but it just doesn't really seem worth it
right now. I find the incremental build time of the kernel to
typically be between 3 and 30 seconds, and a clean build to be between
30 seconds to several minutes, depending on the number of available
cores, so I don't think most users would even notice the amount of
runtime contributed by the actual unit tests until we start getting
into the 1000s of test cases. I don't suspect it will become an issue
until we get into the 10,000s of test cases. I think we are a pretty
long way off from that.

>   * Are you opposed to eventually having this added? For instance, there is
>     enough code on lib/test_kmod.c for batching tons of kthreads each
>     one running its own thing for testing purposes which could be used
>     as template.

I am not opposed to adding it eventually at all. I actually plan on
doing so, just not in this patchset. There are a lot of additional
features, improvements, and sugar that I really want to add, so much
so that most of it doesn't belong in this patchset; I just think this
is one of those things that belongs in a follow up. I tried to boil
down this patchset to as small as I could while still being useful;
this is basically an MVP. Maybe after this patchset gets merged I
should post a list of things I have ready for review, or would like to
work on, and people can comment on what things they want to see next.

>   * If we eventually *did* support it:
>     - Would logs be skewed?

Probably, before I went with the TAP approach, I was tagging each
message with the test case it came from and I could have parsed it and
assembled a coherent view of the logs using that; now that I am using
TAP conforming output, that won't work. I haven't really thought too
hard about how to address it, but there are ways. For the UML users, I
am planning on adding a feature to guarantee hermeticity between tests
running in different modules by adding a feature that allows a single
kernel to be built with all tests included, and then determine which
tests get run by passing in command line arguments or something. This
way you can get the isolation from running tests in separate
environments without increasing the build cost. We could also use this
method to achieve parallelism by dispatching multiple kernels at once.
That only works for UML, but I imagine you could do something similar
for users running tests under qemu.

>     - Could we have a way to query: give me log for only kunit module
>       named "foo"?

Yeah, I think that would make sense as part of the hermeticity thing I
mentioned above.

Hope that seems reasonable!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
