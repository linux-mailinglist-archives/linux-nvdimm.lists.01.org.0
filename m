Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E9519B89
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 12:25:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 75576212657B0;
	Fri, 10 May 2019 03:25:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 02BA7212657A6
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 03:25:19 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v17so5052388otp.13
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iI9UjzWLOTz9GmvdS5N+dD4tpC8SGzYvR6XlaJd6X3w=;
 b=RWz50WjGVhE778RI5E/gnmwHtyGZ0gaAmZ0iZ0plK5kWhBoeeKOWqyMXplH8fTtUsP
 YFZpCe51wfH5rpKYyGn5ULLWDdnHqiz/qOEV7NBjxq+KfO41fJG4qhtbH5TVMqmlTXuD
 b5rf6YzechDPYqaa7IxCgG1hq1vCZ1jw2HsD3qL0n5got4d9IQUHA7ngtw1jru23KETZ
 S2a1Yzky70EiE/cKvmqv3j36xHYkNkJZpgW2MH+/MVDg0jSJzsPJ2n3uuvsMbcTdrYqq
 lTHYE5RDq+PIvvcx+UdbW+CJ6Tf73MUjggBvl433KWXT2rTGYfdgh08GkTh9dkD5qrWP
 Kl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iI9UjzWLOTz9GmvdS5N+dD4tpC8SGzYvR6XlaJd6X3w=;
 b=CiM+wIQXbCsEGCghKk8h/aGI9siRXCUouOgpQSJytqsGJFytF1/Ax/VqETmOf5m9bf
 biH8FsHlu2m7bnYbt9TCU5aqD0y4A60jYnpRJeMIFdXhSxgL0IgCQoeQ1cx9oV1Iqbya
 JLO5Tr85LbFdkBPDCxWGlHKI7U4pCTtno7ZSkUUOugsgaKgyhpMFdwUfPYNKZhTDarwB
 k/RJdh+ItyWLr2ZwKLi5MFCQlJN5vUBXO4dkEfrhviZxA7GzRLVAmcX9unIKLKuhXMYY
 grW7Qgl5+LaA3klGz/B3czHEIaER6mJcZStUof+s5GrfUUxpZQaYGiPCX8WlbXZivca2
 x42A==
X-Gm-Message-State: APjAAAUtTIUqZz97428MB4Tja9irGsrTuXkG8/t1tI6fJYw1C8JuArdO
 Smv8EP9xUizujADeJxUn01YLh8PgJxD224EObkVclA==
X-Google-Smtp-Source: APXvYqxXdPfUlpaL4uIAwV7G2qrVEfAWWo/p1axPqhCLsuZp8oSxIViDaU9/ZJAkWQ8RAXvu3wGakIwT/norp7EOSwY=
X-Received: by 2002:a9d:640f:: with SMTP id h15mr622694otl.338.1557483918605; 
 Fri, 10 May 2019 03:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <CAK7LNARzaeZ+ZNbDSii2cpFkk4bUqOu3keNq4qX0LhftuK8+MQ@mail.gmail.com>
In-Reply-To: <CAK7LNARzaeZ+ZNbDSii2cpFkk4bUqOu3keNq4qX0LhftuK8+MQ@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 10 May 2019 03:25:06 -0700
Message-ID: <CAFd5g47iaxW5Nk+sELxgasnbpNX7O6kwUTT7gMWoN3gA=_we6Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "Cc: Shuah Khan" <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 DTML <devicetree@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Tim Bird <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> On Thu, May 2, 2019 at 8:02 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > ## TLDR
> >
> > I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> > 5.2.
> >
> > Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
> > we would merge through your tree when the time came? Am I remembering
> > correctly?
> >
> > ## Background
> >
> > This patch set proposes KUnit, a lightweight unit testing and mocking
> > framework for the Linux kernel.
> >
> > Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> > it does not require installing the kernel on a test machine or in a VM
> > and does not require tests to be written in userspace running on a host
> > kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> > can run several dozen tests in under a second. Currently, the entire
> > KUnit test suite for KUnit runs in under a second from the initial
> > invocation (build time excluded).
> >
> > KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> > Googletest/Googlemock for C++. KUnit provides facilities for defining
> > unit test cases, grouping related test cases into test suites, providing
> > common infrastructure for running tests, mocking, spying, and much more.
> >
> > ## What's so special about unit testing?
> >
> > A unit test is supposed to test a single unit of code in isolation,
> > hence the name. There should be no dependencies outside the control of
> > the test; this means no external dependencies, which makes tests orders
> > of magnitudes faster. Likewise, since there are no external dependencies,
> > there are no hoops to jump through to run the tests. Additionally, this
> > makes unit tests deterministic: a failing unit test always indicates a
> > problem. Finally, because unit tests necessarily have finer granularity,
> > they are able to test all code paths easily solving the classic problem
> > of difficulty in exercising error handling code.
> >
> > ## Is KUnit trying to replace other testing frameworks for the kernel?
> >
> > No. Most existing tests for the Linux kernel are end-to-end tests, which
> > have their place. A well tested system has lots of unit tests, a
> > reasonable number of integration tests, and some end-to-end tests. KUnit
> > is just trying to address the unit test space which is currently not
> > being addressed.
> >
> > ## More information on KUnit
> >
> > There is a bunch of documentation near the end of this patch set that
> > describes how to use KUnit and best practices for writing unit tests.
> > For convenience I am hosting the compiled docs here:
> > https://google.github.io/kunit-docs/third_party/kernel/docs/
> > Additionally for convenience, I have applied these patches to a branch:
> > https://kunit.googlesource.com/linux/+/kunit/rfc/v5.1-rc7/v1
> > The repo may be cloned with:
> > git clone https://kunit.googlesource.com/linux
> > This patchset is on the kunit/rfc/v5.1-rc7/v1 branch.
> >
> > ## Changes Since Last Version
> >
> > None. I just rebased the last patchset on v5.1-rc7.
> >
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
>
> The following is the log of 'git am' of this series.
> I see several 'new blank line at EOF' warnings.
>
>
>
> masahiro@pug:~/workspace/bsp/linux$ git am ~/Downloads/*.patch
> Applying: kunit: test: add KUnit test runner core
> Applying: kunit: test: add test resource management API
> Applying: kunit: test: add string_stream a std::stream like string builder
> .git/rebase-apply/patch:223: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kunit: test: add kunit_stream a std::stream like logger
> Applying: kunit: test: add the concept of expectations
> .git/rebase-apply/patch:475: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kbuild: enable building KUnit
> Applying: kunit: test: add initial tests
> .git/rebase-apply/patch:203: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kunit: test: add support for test abort
> .git/rebase-apply/patch:453: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kunit: test: add tests for kunit test abort
> Applying: kunit: test: add the concept of assertions
> .git/rebase-apply/patch:518: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kunit: test: add test managed resource tests
> Applying: kunit: tool: add Python wrappers for running KUnit tests
> .git/rebase-apply/patch:457: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kunit: defconfig: add defconfigs for building KUnit tests
> Applying: Documentation: kunit: add documentation for KUnit
> .git/rebase-apply/patch:71: new blank line at EOF.
> +
> .git/rebase-apply/patch:209: new blank line at EOF.
> +
> .git/rebase-apply/patch:848: new blank line at EOF.
> +
> warning: 3 lines add whitespace errors.
> Applying: MAINTAINERS: add entry for KUnit the unit testing framework
> Applying: kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
> Applying: MAINTAINERS: add proc sysctl KUnit test to PROC SYSCTL section

Sorry about this! I will have it fixed on the next revision.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
