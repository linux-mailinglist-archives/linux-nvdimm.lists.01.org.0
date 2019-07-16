Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A256A515
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Jul 2019 11:43:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C4BC7212B7DBF;
	Tue, 16 Jul 2019 02:45:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e49; helo=mail-vs1-xe49.google.com;
 envelope-from=3ljwtxq4kdasm2pyolystrrty3rzzrwp.nzxwty58-y6otxxwt343.bc.z2r@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com
 [IPv6:2607:f8b0:4864:20::e49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CDC10212AF0B2
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 02:45:38 -0700 (PDT)
Received: by mail-vs1-xe49.google.com with SMTP id m186so4218250vsm.2
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 02:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=pGdEsik+1M6jb/HINg07WI5yjzJ1jMxME0W4+2uDrMc=;
 b=eAEOpY1OH/FnKVljQodIm2gUsxEwhjJezpJfsDh5+L9jGMf2prsNq4n5iGGl8lhFcy
 3GIJYBh3yNP4rG6hnKRTyj90mHYFk0BHKtIgiGVyRA9kF/uIcjPZdmXbW8ZEQW4EZ5IH
 SXn4qORJzI5ksZoYb5wqvx7hlnvhT2sxT5FgtaGJr+HG+NjnhSJ69g9xxveqLaNBs89a
 ktkggSKnDQEOXJdhLHX3eRSCy+Xqa76qSYaf55Id0NRKz4na4h3mnh2/MOGZbY4WN6E8
 fCBR1frwWPhwmOtJudmJgXI/JrEuT7i8sdsJFK8HYCxGVYzU3slHOExwB171GfmM6DRJ
 5ZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=pGdEsik+1M6jb/HINg07WI5yjzJ1jMxME0W4+2uDrMc=;
 b=FOuhcRS9DpR0PoOL2K80+QxoKuwH62ElaXIsIbRiGfG15eU+jc0M3xX+kJDCYIoWa0
 JQp2/sicmh4cpABRp//DuaO4zupuuwPCKTbJ6xvuXbtTd0a9ZKwMhYaZVANUR8v1tMAl
 /6l5F9+Z1w9i1XVNng1CxXht6Ii6UOpRVmfbasChVxSTGwQV0GI+0cbD4wWaxBL8oKPx
 BWAch/QLY7Y8Oj9req9AQIKA9jvWY6Q0/KDumRhpmcc4E0DAnVQiDfrhHYJ8dO5wwOHd
 PvqP6Xol13dkW3cxA2eUO2PbwXmg+nIBbTxBBkhzKR+kkky6cEg7AHJcKsl0S/C0rIUF
 dNpg==
X-Gm-Message-State: APjAAAWoI9VH6ArJDhXIWsH86WM7900iqPCMZjk8Bf6JOJntBl5SDAYI
 Gl0wqV1rfH1jtaX35dsHWdPmjnQS3rftBnw3AAgeXg==
X-Google-Smtp-Source: APXvYqw3wlXdIHgaqyGI3Fkb5EoQvIKrYD7PYJZvCXqueiq4LTaNvNX4mlOb1gL0HCxxqPqMgE7qX6kvoBg4NaGW2/1i8w==
X-Received: by 2002:a9f:230c:: with SMTP id 12mr15226541uae.85.1563270188644; 
 Tue, 16 Jul 2019 02:43:08 -0700 (PDT)
Date: Tue, 16 Jul 2019 02:42:44 -0700
Message-Id: <20190716094302.180360-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v10 00/18] kunit: introduce KUnit, the Linux kernel unit
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

This patchset addresses comments from Stephen Boyd. Most changes are
pretty minor, but this does fix a couple of bugs pointed out by Stephen.

I imagine that Stephen will probably have some more comments, but I
wanted to get this out for him to look at as soon as possible.

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
This patchset is on the kunit/rfc/v5.2/v10 branch.

## Changes Since Last Version

- Went back to using spinlock in `struct kunit`. Needed for resource
  management API. Thanks to Stephen for this change.
- Fixed bug where an init failure may not be recorded as a failure in
  patch 01/18.
- Added append method to string_stream as suggested by Stephen.
- Mostly pretty minor changes after that, which mostly pertain to
  string_stream and kunit_stream.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2/v10

-- 
2.22.0.510.g264f2c817a-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
