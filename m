Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210098AE76
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 07:04:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 00E612131BA52;
	Mon, 12 Aug 2019 22:07:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A1C7A2130A4E6
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 22:06:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w26so5611785pfq.12
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 22:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yw2VPeqxmsRoQHPYiMspo9WSTIZItOOYPkJzlzz97sQ=;
 b=R+xjVFNBTOKx66Ip6R2LUuGGTv9eRVrdSycmzhhLqv6ShkSGz9R0iiaQlwquO7BkEU
 x0+Ib4JO36b96tMczjZmXSHPyXXgXTGAWZTVVhOp2T/QIbWWY9V/IwNi6o7K3rnqxKD6
 ziqRin5+uEzkBO92V/m+9MKxmbzCf0EpwYeh574LKHHRRabDjwTHNTwZWhEFkvfuCrXM
 uElR/9bIqUIPxCl1QveNg860hXAYpRf6f2BJRo4B5oKRtiCThZ4ssb+YGhqyKYj3MwTn
 75s7SvppXdJK7apvtGoXkIluns/j2aGIDRd+g49iLbsgOZ5chYru9qT65dM05aT4eQAY
 d3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yw2VPeqxmsRoQHPYiMspo9WSTIZItOOYPkJzlzz97sQ=;
 b=fEVYI3nBO1q8uk8bNdQ4U7D6GIbpHRtZeBPz52wcoFmPdIHUAsQWl0mT6UkopskJA7
 VCd9WpohChfXn+DcrDkKxpD8MMt5twQwocBu87PuKYpUdmo643ZgO1XzdYSk3qZgJyIV
 zbILX0ICI9PVJqozDpD8KYLCq9sUklICz8pnuHDg9FUEeHHUobtdyfnaviCOJbhmDLMA
 3ixL+g8X2ZhYZy6sfnxcAwJRjjD0QaAWjkymVxTafwyozBm4ZLIsfdfhsGaQQy5JNya9
 4FC+h3IbKGeLiBOmCg9zhzQNEOHY68DA05PNSallTh1s0ijx/qAKTzqi1ixgwGqZa1Rr
 uLcQ==
X-Gm-Message-State: APjAAAWvJGnWTvxzJh8KFBsl1P+00DppDU5dFNk6JwjFM8NaV801WVZ6
 qrEOZLJdHeiLglPAGgAaNQlY6fNi42FrChSDZFNRgw==
X-Google-Smtp-Source: APXvYqzY7+RzhfN0PwrRrz6X4tFGzeJErvdkB+WMoL53BHH2m/gFw2SJjgYuiLuK2/VE++6KBxdxNTyzwKrq+P1ZkEU=
X-Received: by 2002:a63:eb51:: with SMTP id b17mr32062966pgk.384.1565672681626; 
 Mon, 12 Aug 2019 22:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-6-brendanhiggins@google.com>
 <20190812235701.533E82063F@mail.kernel.org>
 <20190813003352.GA235915@google.com>
 <20190813050206.2A49C206C2@mail.kernel.org>
In-Reply-To: <20190813050206.2A49C206C2@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 12 Aug 2019 22:04:30 -0700
Message-ID: <CAFd5g44VBzDSjxHGUZ=8A9hempQ0_3Ym_8qzj0ETEJ8AzM6poA@mail.gmail.com>
Subject: Re: [PATCH v12 05/18] kunit: test: add the concept of expectations
To: Stephen Boyd <sboyd@kernel.org>
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

On Mon, Aug 12, 2019 at 10:02 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 17:33:52)
> > On Mon, Aug 12, 2019 at 04:57:00PM -0700, Stephen Boyd wrote:
> > > Quoting Brendan Higgins (2019-08-12 11:24:08)
> > > > + */
> > > > +#define KUNIT_EXPECT_TRUE(test, condition) \
> > > > +               KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
> > >
> > > A lot of these macros seem double indented.
> >
> > In a case you pointed out in the preceding patch, I was just keeping the
> > arguments column aligned.
> >
> > In this case I am just indenting two tabs for a line continuation. I
> > thought I found other instances in the kernel that did this early on
> > (and that's also what the Linux kernel vim plugin wanted me to do).
> > After a couple of spot checks, it seems like one tab for this kind of
> > line continuation seems more common. I personally don't feel strongly
> > about any particular version. I just want to know now what the correct
> > indentation is for macros before I go through and change them all.
> >
> > I think there are three cases:
> >
> > #define macro0(param0, param1) \
> >                 a_really_long_macro(...)
> >
> > In this first case, I use two tabs for the first indent, I think you are
> > telling me this should be one tab.
>
> Yes. Should be one.
>
> >
> > #define macro1(param0, param1) {                                               \
> >         statement_in_a_block0;                                                 \
> >         statement_in_a_block1;                                                 \
> >         ...                                                                    \
> > }
> >
> > In this case, every line is in a block and is indented as it would be in
> > a function body. I think you are okay with this, and now that I am
> > thinking about it, what I think you are proposing for macro0 will make
> > these two cases more consistent.
> >
> > #define macro2(param0,                                                         \
> >                param1,                                                         \
> >                param2,                                                         \
> >                param3,                                                         \
> >                ...,                                                            \
> >                paramn) ...                                                     \
> >
> > In this last case, the body would be indented as in macro0, or macro1,
> > but the parameters passed into the macro are column aligned, consistent
> > with one of the acceptable ways of formatting function parameters that
> > don't fit on a single line.
> >
> > In all cases, I put 1 space in between the closing parameter paren and
> > the line continuation `\`, if only one `\` is needed. Otherwise, I align
> > all the `\s` to the 80th column. Is this okay, or would you prefer that
> > I align them all to the 80th column, or something else?
> >
>
> This all sounds fine and I'm not nitpicking this style. Just the double
> tabs making lines longer than required.

Sounds good. Will do.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
