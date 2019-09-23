Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C31BB022
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Sep 2019 11:02:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2A7721962301;
	Mon, 23 Sep 2019 02:05:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com;
 envelope-from=3p4qixq4kdgghxktjgtnommotymuumrk.iusrotad-tbjossroyzy.gh.uxm@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4938A202ECFC3
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 02:05:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t19so8916803pgh.6
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=+//vbVEMytWRwDD1N32OMbhHMumt9Xl/FOLbXSEK5is=;
 b=Wo7ehhiSQ+WIaAzvJJIRhAtBle0DOtoQcRTc6cN8yWkyMcIxO/qRPi3lis8moobXcP
 CWq6T7egEucWpE3o0mcg1Fim8i0wua01qVVyk1p7x23lzN65yKj38xSG2yAGPACDtY/L
 k9b99co46gj6eFnAa2vIAd61Da+0JD7DfgXlo4z5vnS+OMaWkl9BWS2aWH3clklOe5AY
 MpNL2/72iPL2TQrXaW8zvZdPF1qmUxROiXG3LY7iDmZwzCSmlaSB1lFKSe2m7LbgkMlL
 VPJoEmp/UWp8QZCppZh0FRuDte3wmphK5vqQCfTTZGbcCjKasCbUH3v+pqeoJin62QBc
 KNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=+//vbVEMytWRwDD1N32OMbhHMumt9Xl/FOLbXSEK5is=;
 b=lEhkfilhWmFZYa/C2k/VJqT55B4sGd1cF3j6rnqXRgY0N0GHI/QVqYWJrqIHu0rNo3
 AKuJBFqoFaSog7Rshg4faugg0UYD8AjV/TkSrsQZ7gZxabd77WjQFHqkoLwD1F2gsL5N
 T05So6/LahB/M1MDUzruSHqiiTMDkRS4XKiaKRc8Qq53rLb5qUKtCHPlyIDHNLN0bzxy
 jHgFudT1xAG8sVqajl5d6MPbVOCzyC7FHSkaY8ExPe+j98k9t6OOexC7hrSM+YdbopMX
 KtOI/jTn8UTHMI+oIUB9HR0IwbUz6zksI2ArpnEOk/9K3L5zXEb4mbkB7HY0hnCe4i7M
 Bxjg==
X-Gm-Message-State: APjAAAUat9eF7qQOGQBHN9HrDXrbNOq8ozPI0m9efVGRQvbuecZqNbYu
 bnomuyEm+aCq2702Os/dWZ+IHPZB7XlS7TL0fU1pFQ==
X-Google-Smtp-Source: APXvYqwTDC2q3PPtmYSRUk/N+oqZsXyU/gpa64/Ucwnxxx5rMGjxbO9ch8qc4bPavftsq7Zb9hWXi4lrxe+MOJuGjhr0WA==
X-Received: by 2002:a63:1b66:: with SMTP id b38mr28254193pgm.54.1569229375372; 
 Mon, 23 Sep 2019 02:02:55 -0700 (PDT)
Date: Mon, 23 Sep 2019 02:02:30 -0700
Message-Id: <20190923090249.127984-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From: Brendan Higgins <brendanhiggins@google.com>
To: frowand.list@gmail.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com, 
 keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org, 
 peterz@infradead.org, robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, 
 tytso@mit.edu, yamada.masahiro@socionext.com
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org,
 linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com,
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, torvalds@linux-foundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

## TL;DR

This revision addresses comments from Linus[1] and Randy[2], by moving
top level `kunit/` directory to `lib/kunit/` and likewise moves top
level Kconfig entry under lib/Kconfig.debug, so the KUnit submenu now
shows up under the "Kernel Hacking" menu.

As a consequence of this, I rewrote patch 06/18 (kbuild: enable building
KUnit) - now 06/19 (lib: enable building KUnit in lib/), and now needs
to be re-acked/reviewed.

## Background

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
(however, KUnit still allows you to run tests on test machines or in VMs
if you want[3]) and does not require tests to be written in userspace
running on a host kernel. Additionally, KUnit is fast: From invocation
to completion KUnit can run several dozen tests in about a second.
Currently, the entire KUnit test suite for KUnit runs in under a second
from the initial invocation (build time excluded).

KUnit is heavily inspired by JUnit, Python's unittest.mock, and
Googletest/Googlemock for C++. KUnit provides facilities for defining
unit test cases, grouping related test cases into test suites, providing
common infrastructure for running tests, mocking, spying, and much more.

### What's so special about unit testing?

A unit test is supposed to test a single unit of code in isolation,
hence the name. There should be no dependencies outside the control of
the test; this means no external dependencies, which makes tests orders
of magnitudes faster. Likewise, since there are no external dependencies,
there are no hoops to jump through to run the tests. Additionally, this
makes unit tests deterministic: a failing unit test always indicates a
problem. Finally, because unit tests necessarily have finer granularity,
they are able to test all code paths easily solving the classic problem
of difficulty in exercising error handling code.

### Is KUnit trying to replace other testing frameworks for the kernel?

No. Most existing tests for the Linux kernel are end-to-end tests, which
have their place. A well tested system has lots of unit tests, a
reasonable number of integration tests, and some end-to-end tests. KUnit
is just trying to address the unit test space which is currently not
being addressed.

### More information on KUnit

There is a bunch of documentation near the end of this patch set that
describes how to use KUnit and best practices for writing unit tests.
For convenience I am hosting the compiled docs here[4].

Additionally for convenience, I have applied these patches to a
branch[5]. The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/initial/v5.3/v18 branch.

## History since v15

### v18

 - Addrssed comments on 07/19 (kunit: test: add initial tests) from
   Randy Dunlap by removing redundant dependencies from Kconfig entries.

### v17

 - Addressed comments on 06/19 (lib: enable building KUnit in lib/) from
   Stephen Boyd by moving KUnit submenu ahead of Runtime Testing
   submenu.

### v16

 - Addressed comments from Linus Torvalds by moving all kunit/ paths to
   lib/kunit/.
 - Addressed comments by Randy Dunlap by moving KUnit Kconfig under
   lib/Kconfig.debug so the KUnit submenu shows up under the "Kernel
   Hacking" menu.

[1] https://www.lkml.org/lkml/2019/9/20/696
[2] https://www.lkml.org/lkml/2019/9/20/738
[3] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[4] https://google.github.io/kunit-docs/third_party/kernel/docs/
[5] https://kunit.googlesource.com/linux/+/kunit/initial/v5.3/v18

---
Avinash Kondareddy (1):
  kunit: test: add tests for KUnit managed resources

Brendan Higgins (16):
  kunit: test: add KUnit test runner core
  kunit: test: add test resource management API
  kunit: test: add string_stream a std::stream like string builder
  kunit: test: add assertion printing library
  kunit: test: add the concept of expectations
  lib: enable building KUnit in lib/
  kunit: test: add initial tests
  objtool: add kunit_try_catch_throw to the noreturn list
  kunit: test: add support for test abort
  kunit: test: add tests for kunit test abort
  kunit: test: add the concept of assertions
  kunit: defconfig: add defconfigs for building KUnit tests
  Documentation: kunit: add documentation for KUnit
  MAINTAINERS: add entry for KUnit the unit testing framework
  MAINTAINERS: add proc sysctl KUnit test to PROC SYSCTL section
  kunit: fix failure to build without printk

Felix Guo (1):
  kunit: tool: add Python wrappers for running KUnit tests

Iurii Zaikin (1):
  kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()

 Documentation/dev-tools/index.rst             |    1 +
 Documentation/dev-tools/kunit/api/index.rst   |   16 +
 Documentation/dev-tools/kunit/api/test.rst    |   11 +
 Documentation/dev-tools/kunit/faq.rst         |   62 +
 Documentation/dev-tools/kunit/index.rst       |   79 +
 Documentation/dev-tools/kunit/start.rst       |  180 ++
 Documentation/dev-tools/kunit/usage.rst       |  576 +++++++
 MAINTAINERS                                   |   13 +
 arch/um/configs/kunit_defconfig               |    3 +
 include/kunit/assert.h                        |  356 ++++
 include/kunit/string-stream.h                 |   51 +
 include/kunit/test.h                          | 1490 +++++++++++++++++
 include/kunit/try-catch.h                     |   75 +
 kernel/Makefile                               |    2 +
 kernel/sysctl-test.c                          |  392 +++++
 lib/Kconfig.debug                             |   13 +
 lib/Makefile                                  |    2 +
 lib/kunit/Kconfig                             |   36 +
 lib/kunit/Makefile                            |    9 +
 lib/kunit/assert.c                            |  141 ++
 lib/kunit/example-test.c                      |   88 +
 lib/kunit/string-stream-test.c                |   52 +
 lib/kunit/string-stream.c                     |  217 +++
 lib/kunit/test-test.c                         |  331 ++++
 lib/kunit/test.c                              |  478 ++++++
 lib/kunit/try-catch.c                         |  118 ++
 tools/objtool/check.c                         |    1 +
 tools/testing/kunit/.gitignore                |    3 +
 tools/testing/kunit/configs/all_tests.config  |    3 +
 tools/testing/kunit/kunit.py                  |  136 ++
 tools/testing/kunit/kunit_config.py           |   66 +
 tools/testing/kunit/kunit_kernel.py           |  149 ++
 tools/testing/kunit/kunit_parser.py           |  310 ++++
 tools/testing/kunit/kunit_tool_test.py        |  206 +++
 .../test_is_test_passed-all_passed.log        |   32 +
 .../test_data/test_is_test_passed-crash.log   |   69 +
 .../test_data/test_is_test_passed-failure.log |   36 +
 .../test_is_test_passed-no_tests_run.log      |   75 +
 .../test_output_isolated_correctly.log        |  106 ++
 .../test_data/test_read_from_file.kconfig     |   17 +
 40 files changed, 6001 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/api/index.rst
 create mode 100644 Documentation/dev-tools/kunit/api/test.rst
 create mode 100644 Documentation/dev-tools/kunit/faq.rst
 create mode 100644 Documentation/dev-tools/kunit/index.rst
 create mode 100644 Documentation/dev-tools/kunit/start.rst
 create mode 100644 Documentation/dev-tools/kunit/usage.rst
 create mode 100644 arch/um/configs/kunit_defconfig
 create mode 100644 include/kunit/assert.h
 create mode 100644 include/kunit/string-stream.h
 create mode 100644 include/kunit/test.h
 create mode 100644 include/kunit/try-catch.h
 create mode 100644 kernel/sysctl-test.c
 create mode 100644 lib/kunit/Kconfig
 create mode 100644 lib/kunit/Makefile
 create mode 100644 lib/kunit/assert.c
 create mode 100644 lib/kunit/example-test.c
 create mode 100644 lib/kunit/string-stream-test.c
 create mode 100644 lib/kunit/string-stream.c
 create mode 100644 lib/kunit/test-test.c
 create mode 100644 lib/kunit/test.c
 create mode 100644 lib/kunit/try-catch.c
 create mode 100644 tools/testing/kunit/.gitignore
 create mode 100644 tools/testing/kunit/configs/all_tests.config
 create mode 100755 tools/testing/kunit/kunit.py
 create mode 100644 tools/testing/kunit/kunit_config.py
 create mode 100644 tools/testing/kunit/kunit_kernel.py
 create mode 100644 tools/testing/kunit/kunit_parser.py
 create mode 100755 tools/testing/kunit/kunit_tool_test.py
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-failure.log
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
 create mode 100644 tools/testing/kunit/test_data/test_output_isolated_correctly.log
 create mode 100644 tools/testing/kunit/test_data/test_read_from_file.kconfig

-- 
2.23.0.351.gc4317032e6-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
