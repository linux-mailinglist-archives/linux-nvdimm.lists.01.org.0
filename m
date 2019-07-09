Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DAD63073
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Jul 2019 08:32:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 38BC4212ACEC2;
	Mon,  8 Jul 2019 23:32:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com;
 envelope-from=3cdukxq4kdpeukxgwtgabzzbglzhhzex.vhfebgnq-gowbffeblml.tu.hkz@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 480B121959CB2
 for <linux-nvdimm@lists.01.org>; Mon,  8 Jul 2019 23:32:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i188so11496153yba.20
 for <linux-nvdimm@lists.01.org>; Mon, 08 Jul 2019 23:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=ccEO1tkkeH8HT1/mhIGVUKFl/9lAslI495fANVrqi9k=;
 b=e2JKyD27N2epGYfKgaRHgJrtns9MYtHULutiWECP0zFRJv3jgMPgvU/mgzt7m2CruN
 qyDh4tO7vEMXIwz5uC90ZiqlsOp6jxtaX8TLEstg/mB6t2n5nc3E1nANny//4ZuViIuT
 Q3ccwNzcmvwEgQPy45ljMduIsRcMZ+yyArZsE7tNVMmyeTDybeKjOVOQs49sE+w8xRgU
 l6IbFINnO1SRMJvZ1e6x0/QcQs5GYjWItk2Tf6QcJnNv92P+Yml808NgCvyRAieR+7tt
 vVHGQ59GH0W9PqLAZQXcyb1ZKKpl+uFrILyK+81ZrKs3HHFsWjaaDhu+6fgoH9G5s9wC
 jETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=ccEO1tkkeH8HT1/mhIGVUKFl/9lAslI495fANVrqi9k=;
 b=YV61prYXJpZh1vSzHRX4OJIpjJuRwOir9+5SI228QY8w4tM3B9UEWFhTnIScCSv9yZ
 2XdvtoCKCoOkWdG4Nfr/1v8i6ZMbm8DphfFpGX79GOy9RGiTinL/Txn77wT+KIkkkR03
 pJpXUWUJFij0aqe8bZDE2HLIXpG/ov5UzhDHqKkm563WOiXQhqkOilpYu/LDy3U5C/Ty
 wwU2StCPBZQyYQo80vMjoxxBjYtuu/bct4PCdcKBW3NQDazudOqUnBb7R6ejMSK/EdFA
 Z4Ii7PI4lj0ZmHBocj07C/4HNYPftGrQiLMsKd3CjCJarkHpgblHvPZjYImeuCAUQ8KO
 P5SA==
X-Gm-Message-State: APjAAAWyImoJTcoQFCBhyJdPypxAQaC7pQ66uHptBLaKAqexU310tIYQ
 hzsb0S6WUTewPC5cRo1oaEER9wUpykGtJ2QW91rPww==
X-Google-Smtp-Source: APXvYqxTCUgwXCc9biuo/mRL1pSgsNPvKrcZOBY5oaano9+5jCyWavrpS1UTvqWVKgVXm3lya3N2nYit0+zc7OI5xI8uZg==
X-Received: by 2002:a81:710a:: with SMTP id m10mr13083743ywc.277.1562653960705; 
 Mon, 08 Jul 2019 23:32:40 -0700 (PDT)
Date: Mon,  8 Jul 2019 23:30:05 -0700
Message-Id: <20190709063023.251446-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 00/18] kunit: introduce KUnit, the Linux kernel unit
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
 Jonathan Corbet <corbet@lwn.net>, linux-nvdimm@lists.01.org,
 khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, Iurii Zaikin <yzaikin@google.com>,
 jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 Michal Marek <michal.lkml@markovi.net>, richard@nod.at, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

## TL;DR

This is a pretty straightforward follow-up to Luis' comments on PATCH
v6: There is nothing that changes any functionality or usage.

As for our current status, we only need reviews/acks on the following
patches:

- [PATCH v7 06/18] kbuild: enable building KUnit
  - Need a review or ack from Masahiro Yamada or Michal Marek
- [PATCH v7 08/18] objtool: add kunit_try_catch_throw to the noreturn
  list
  - Need a review or ack from Josh Poimboeuf or Peter Zijlstra

Other than that, I think we should be good to go.

## Background

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
(however, KUnit still allows you to run tests on test machines or in VMs
if you want[1]) and does not require tests to be written in userspace
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
For convenience I am hosting the compiled docs here[2].

Additionally for convenience, I have applied these patches to a
branch[3]. The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/rfc/v5.2/v7 branch.

## Changes Since Last Version

Aside from renaming `struct kunit_module` to `struct kunit_suite`, there
isn't really anything in here that changes any functionality:

- Rebased on v5.2
- Added Iurii as a maintainer for PROC SYSCTL, as suggested by Luis.
- Removed some references to spinlock that I failed to remove in the
  previous version, as pointed out by Luis.
- Cleaned up some comments, as suggested by Luis.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2/v7

-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
