Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3BA57571
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 02:23:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B689212AB004;
	Wed, 26 Jun 2019 17:23:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 597C7212AAB65
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 17:23:25 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id ay6so237569plb.9
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 17:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c34/FfI7PALcZVh0MK4YlFiWvnY7m44Qb8oCZcTiVbU=;
 b=a1r7b0eQqi65SnqqxyoyNoD4dz3PJJz11oTPJDYx1ctiFPDiwwrUHcLazOdtvx2h+b
 BJ557GOrC/erbl4AklySqzJS15SQHRCyi1pl5V+Ls9UzeK+ybM4aUzx/S+y9D7ra9gXL
 ud7lUYI/Zqb2M3pihkmgYamKJ46DHL/UUeQ91qNrgnYGOngk+Ky+30mJQ2BAC1N4CLmf
 9YUjsBmnOgUwCj1x8uLgqFqywqoB2YH5RUIgldau68pKxTutIfleZKg6l9x3MWTSKJaB
 ouNqg9FBjBvdFyIKXW5If/Gp0dxolKfdIn0hpcE+lOOFMC9WXHkJlNZBl9+xdWTdckpr
 zuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c34/FfI7PALcZVh0MK4YlFiWvnY7m44Qb8oCZcTiVbU=;
 b=dyJIE/fq13uf0G9uhLvI+id5UizABhyUriuIt3emtALx01yoB469FQ5GFeBDdZCPHA
 Vjln99qCgxDFP/Xyv8cU2Rc7WdAvqaHnwwblWTKMHFFrQjQVLaDK2ecTQ/jI9psgOdjb
 hq9ygLexhZ5MMJEzWBAX2b+Vi4zuronymb6Jyri+TBDFgzpvv44iulPEaNePjNoj/HlY
 S26dVh04dFRmvKmfYi4hDJ7AiVskuDOEx+YlS2AQwWKel4qbDCrnNmrCEbPv/QgC5iHy
 kqjE2EH2dvLG5ymuTaJHtA0AvlxWa5PQT0xP8wsKjg4EcOesE5pghi5puYvm+qKCb9pH
 B6GA==
X-Gm-Message-State: APjAAAUGRgzEo2cS+m+NauIqDKtM2hlGzTlljRK9dt1kBdMJoohxdbHe
 pZqDEtlCapnIV3ZfKKbW32jQBaK6uZjLE/NlLwlZ6g==
X-Google-Smtp-Source: APXvYqz8ozeAzYHPHzqs1rNqRCdggL5+4sDGi+NHmPQJCmuSKDQDwiM3UtGQ8HWyljDXcSyRIYd62W6XpQAlC3xYRPM=
X-Received: by 2002:a17:902:29e6:: with SMTP id
 h93mr950785plb.297.1561595003889; 
 Wed, 26 Jun 2019 17:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-14-brendanhiggins@google.com>
 <20190626000150.GT19023@42.do-not-panic.com>
 <CAFd5g44kkepB2hZcpYL-NB5ZHYE5tP7W-0yducGCX7Khd9gd9w@mail.gmail.com>
 <20190626220350.GA19023@42.do-not-panic.com>
In-Reply-To: <20190626220350.GA19023@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 26 Jun 2019 17:23:12 -0700
Message-ID: <CAFd5g44ZbVCM3rksF44z_diiejS+Xc+qcXm120L+t+FHwuGyrA@mail.gmail.com>
Subject: Re: [PATCH v5 13/18] kunit: tool: add Python wrappers for running
 KUnit tests
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
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com,
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

On Wed, Jun 26, 2019 at 3:03 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Jun 26, 2019 at 01:02:55AM -0700, Brendan Higgins wrote:
> > On Tue, Jun 25, 2019 at 5:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Mon, Jun 17, 2019 at 01:26:08AM -0700, Brendan Higgins wrote:
> > > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
> > > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
> > > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-failure.log
> > > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
> > > >  create mode 100644 tools/testing/kunit/test_data/test_output_isolated_correctly.log
> > > >  create mode 100644 tools/testing/kunit/test_data/test_read_from_file.kconfig
> > >
> > > Why are these being added upstream? The commit log does not explain
> > > this.
> >
> > Oh sorry, those are for testing purposes. I thought that was clear
> > from being in the test_data directory. I will reference it in the
> > commit log in the next revision.
>
> Still, I don't get it. They seem to be results from a prior run. Why do
> we need them for testing purposes?

Those logs are the raw output from UML with KUnit installed. They are
for testing kunit_tool, the Python scripts added in this commit. One
of the things that kunit_tool does is parses the results output by
UML, extracts the KUnit data, and presents it in a user friendly
manner.

I added these logs so I could test that kunit_tool parses certain
kinds of output correctly. For example, I want to know that it parses
a test failure correctly and includes the appropriate context. So I
have a log from a unit test that failed, and I have a test (a Python
test that is also in this commit) that tests whether kunit_tool can
parse the log correctly.

Does that make sense?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
