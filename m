Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A98816D319
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 19:50:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C63D212CFEDD;
	Thu, 18 Jul 2019 10:52:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 89AB92194EB76
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 10:52:53 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C3EC421019;
 Thu, 18 Jul 2019 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563472224;
 bh=6tSD0Suq+WYw0e1Of1mjiPhBMB1Sm91MrrAFE36jpOc=;
 h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
 b=qhh1Yzvu9wkDER9y45leq7ittg2ChvzEFbwwLVZc06ECTh2DoTQNSKaogbtmfkT68
 1l2DbFS/qt/oI4MDEM0RfDRSnGQfBEZtVR9UZ8zb3LGf5E0Nrh56Y4ypa4K4xT9cYG
 u2MA/NXEj9SHiUe3C8HpY4EmJNMMPRP3PJB9AiWI=
MIME-Version: 1.0
In-Reply-To: <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-5-brendanhiggins@google.com>
 <20190715221554.8417320665@mail.kernel.org>
 <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
 <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com>
 <20190716175021.9CA412173C@mail.kernel.org>
 <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like
 logger
To: Brendan Higgins <brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date: Thu, 18 Jul 2019 10:50:23 -0700
Message-Id: <20190718175024.C3EC421019@mail.kernel.org>
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
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Quoting Brendan Higgins (2019-07-16 11:52:01)
> On Tue, Jul 16, 2019 at 10:50 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> 
> > The only hypothetical case where this can't be done is a complicated
> > assertion or expectation that does more than one check and can't be
> > written as a function that dumps out what went wrong. Is this a real
> > problem? Maybe such an assertion should just open code that logic so we
> > don't have to build up a string for all the other simple cases.
> 
> I have some expectations in follow up patchsets for which I created a
> set of composable matchers for matching structures and function calls
> that by their nature cannot be written as a single function. The
> matcher thing is a bit speculative, I know, but for any kind of
> function call matching, you need to store a record of functions you
> are expecting to have called and then each one needs to have a set of
> expectations defined by the user; I don't think there is a way to do
> that that doesn't involve having multiple separate functions each
> having some information useful to constructing the message.
> 
> I know the code in question isn't in this patchset; the function
> matching code was in one of the earlier versions of the RFC, but I
> dropped it to make this patchset smaller and more manageable. So I get
> it if you would like me to drop it and add it back in when I try to
> get the function and structure matching stuff in, but I would really
> prefer to keep it as is if you don't care too much.

Do you have a link to those earlier patches?

> 
> > It seems far simpler to get rid of the string stream API and just have a
> > struct for this.
> >
> >         struct kunit_fail_msg {
> >                 const char *line;
> >                 const char *file;
> >                 const char *func;
> >                 const char *msg;
> >         };
> >
> > Then you can have the assertion macros create this on the stack (with
> > another macro?).
> >
> >         #define DEFINE_KUNIT_FAIL_MSG(name, _msg) \
> >                 struct kunit_fail_msg name = { \
> >                         .line =  __LINE__, \
> >                         .file = __FILE__, \
> >                         .func = __func__, \
> >                         .msg = _msg, \
> >                 }
> >
> > I don't want to derail this whole series on this topic, but it seems
> > like a bunch of code is there to construct this same set of information
> > over and over again into a buffer a little bit at a time and then throw
> > it away when nothing fails just because we may want to support the case
> > where we have some unstructured data to inform the user about.
> 
> Yeah, that's fair. I think there are a number of improvements to be
> made with how the expectations are defined other than that, but I was
> hoping I could do that after this patchset is merged. I just figured
> with the kinds of things I would like to do, it would lead to a whole
> new round of discussion.
> 
> In either case, I think I would still like to use the `struct
> kunit_stream` as part of the interface to share the failure message
> with the test case runner code in test.c, at least eventually, so that
> I only have to have one way to receive data from expectations, but I
> think I can do that and still do what you suggest by just constructing
> the kunit_stream at the end of expectations where it is feasible.
> 
> All in all I agree with what you are saying, but I would rather do it
> as a follow up possibly once we have some more code on the table. I
> could just see this opening up a whole new can of worms where we
> debate about exactly how expectations and assertions work for another
> several months, only to rip it all out shortly there after. I know
> that's how these things go, but that's my preference.
> 
> I can do what you suggest if you feel strongly about it, but I would
> prefer to hold off until later. It's your call.
> 

The crux of my complaint is that the string stream API is too loosely
defined to be usable. It allows tests to build up a string of
unstructured information, but with certain calling constraints so we
have to tread carefully. If there was more structure to the data that's
being recorded then the test case runner could operate on the data
without having to do string/stream operations, allocations, etc. This
would make the assertion logic much more concrete and specific to kunit,
instead of this small kunit wrapper that's been placed on top of string
stream.

TL;DR: If we can get rid of the string stream API I'd view that as an
improvement because building arbitrary strings in the kernel is complex,
error prone and has calling context concerns.

Is the intention that other code besides unit tests will use this string
stream API to build up strings? Any targets in mind? This would be a
good way to get the API merged upstream given that its 2019 and we
haven't had such an API in the kernel so far.

An "object oriented" (strong quotes!) approach where kunit_fail_msg is
the innermost struct in some assertion specific structure might work
nicely and allow the test runner to call a generic 'format' function to
print out the message based on the type of assertion/expectation it is.
It probably would mean less code size too because the strings that are
common will be in the common printing function instead of created twice,
in the macros/code and then copied to the heap for the string stream.

	struct kunit_assert {
		const char *line;
		const char *file;
		const char *func;
		void (*format)(struct kunit_assert *assert);
	};

	struct kunit_comparison_assert {
		enum operator operator;
		const char *left;
		const char *right;
		struct kunit_assert assert;
	};

	struct kunit_bool_assert {
		const char *truth;
		const char *statement;
		struct kunit_assert assert;
	};

	void kunit_format_comparison(struct kunit_assert *assert)
	{
		struct kunit_comparison_assert *comp = container_of(assert, ...)

		kunit_printk(...)
	}

Maybe other people have opinions here on if you should do it now or
later. Future coding is not a great argument because it's hard to
predict the future. On the other hand, this patchset is in good shape to
merge and I'd like to use it to write unit tests for code I maintain so
I don't want to see this stall out. Sorry if I'm opening the can of
worms you're talking about.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
