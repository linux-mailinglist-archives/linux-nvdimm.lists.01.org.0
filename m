Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F3B9BA1B
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Aug 2019 03:34:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 64C6F20215F7E;
	Fri, 23 Aug 2019 18:37:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e4a; helo=mail-vs1-xe4a.google.com;
 envelope-from=3k5rgxq4kdmyn3qzpmztussuz4s00sxq.o0yxuz69-z7puyyxu454.cd.03s@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com
 [IPv6:2607:f8b0:4864:20::e4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C056E20215F56
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:37:14 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id k1so3185958vsq.8
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=u6vmmnwRUzLKD5y/rsoe3hBquEKZMDYQLdEtGhcWv3g=;
 b=HVklJPxbqbRBtpBK3hdl+VswNRV4P2EWUoTQ6/jzlla/43tMUYx52ieNsrWja1cMAd
 aJXK63eT0AeMDFxYtZyBESJGuF52uPkRIRazyPmUFSSpZlHx/sV1I2pC8wcJoG/Jy+z7
 0ebrqRvPPaqx+epAoYNiv2Z6F0OPXUrzfluIz3B0PZsRxGAjoAWPYO3kBtG4yhrHecAA
 fwkXjbrqFMOaTYkIzZof+8WI+OZNq8YRk4OSEiBdVc0hDOjOiYENTJZIZIQpFAlgeRT6
 5UwDu9vDrX9VEXJMCDM32wr6kC4xm78SHY7UBAnZUT4L8JjxDdyUQ0eJ2Gew4CMdHuAQ
 esXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=u6vmmnwRUzLKD5y/rsoe3hBquEKZMDYQLdEtGhcWv3g=;
 b=qipG+J4cqZ/ykEKgxPXlsCmiENKgisuRtv3WFhZyrZh67ZA8vFWi4DqsSfQVPM/tmB
 GnpkNzMTrFOlrqTNzDQ2CW3zKsCJVcZaqJ+x5U6k/M2HuDBRWLCUfBWcN1lJxXUr+GgK
 e1WhsHfyFnnMV8Y4RV9I0L+gk7U6QAk0PpENZOz/1D5GDQbXSo/4V8QzG11TA3OA/d93
 lu98P38AisSxJDdu+ngJxxd2iFk/hZnsx/N1HZnF2pUdwuask5BjBh64/NDED3+RBidg
 3TzZvfbWqxUocMqiuyYjGKHbpXp1337j1XwSMSMqFizpxqVcrTi45ofNDwfcNKnGgWHe
 D5wQ==
X-Gm-Message-State: APjAAAW9j0qZL7Ky4qA36UsbCAByV4EYtHeoTWGRp8aqITr/u/mRzLxi
 kDz0tHmpfE/IoykVVpdiTx6AZyg9h+6/etq31yRe1w==
X-Google-Smtp-Source: APXvYqwBNX0MXCogqcD2ZWv4/PeYSKyopYGJC89lxHpR6CjYFzzu83jqcycsHbnwRnQxtUoBH+I61TfjBVcTRyxmbsVxMw==
X-Received: by 2002:a67:dd91:: with SMTP id i17mr4328220vsk.21.1566610475582; 
 Fri, 23 Aug 2019 18:34:35 -0700 (PDT)
Date: Fri, 23 Aug 2019 18:34:07 -0700
Message-Id: <20190824013425.175645-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v15 00/18] kunit: introduce KUnit, the Linux kernel unit
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
 richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

## TL;DR

This revision addresses comments from Shuah by fixing a couple
checkpatch warnings and fixing some comment readability issues. No API
or major structual changes have been made since v13.

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
This patchset is on the kunit/rfc/v5.3/v15 branch.

## Changes Since Last Version

- Moved comment from inline in macro to kernel-doc to address checkpatch
  warning.
- Demoted BUG() to WARN_ON.
- Formatted some kernel-doc comments to make them more readible.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.3/v15

-- 
2.23.0.187.g17f5b7556c-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
