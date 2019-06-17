Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0CA47C48
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 10:26:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C62E21962301;
	Mon, 17 Jun 2019 01:26:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e49; helo=mail-vs1-xe49.google.com;
 envelope-from=3sk4hxq4kdfs4k7g63gab99bgl9hh9e7.5hfebgnq-go6bffeblml.tu.hk9@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com
 [IPv6:2607:f8b0:4864:20::e49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3EEF121290DD8
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:26:28 -0700 (PDT)
Received: by mail-vs1-xe49.google.com with SMTP id b23so2039075vsl.20
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=zNrbPgNoeDBUYkvT6WCexqCkglYQYBNMsP2F15bRgzw=;
 b=F28MpQerLXJBLIWRmLuUF47CK1rSBKHh7j1mspgJvxgCYybn8PwQ2icrUPzaqHKgGS
 mIu6S0C5yyN6Zp7XldkF4xD6ADXRhtF07Z6XHvYu+FHZ9BpcPtjJxLCah/daYKhStBrL
 e/azebcPGRR+yjxTyj/+CmfyBaWB+WOK/5hBX1ABlx6ES4eRURKdAl7TuCUbbrUa+sjf
 9OQaMEJ7JNvJccGJ6qWVmFF6O+lhb+vAocDwkUu3q6gqVcuoz5bWd98JWAnSkbeD9kFd
 w/O94T1vg1eotXi2ejHuC1Kdzez1DiJfvULK/QbuJ+i3Z9G8uOEi+IwB+QVFDgZbeEoQ
 +qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=zNrbPgNoeDBUYkvT6WCexqCkglYQYBNMsP2F15bRgzw=;
 b=GfkI+CuGPHAG6vAXHc5wzE1YQHvvscFGfWAVtUP7NXcnjbBkM3ei6Ym6lZ6Q+Iyk11
 0mYRcuCCwfSkBtC0xOitLZTZUK3uy2uZbPhZ/tWDp6ycTmZbHEUklnAiH15GtKsXjR/j
 X/WkATT4nVsgd0igj6YUs7UdRWxGXNeUOSTH/2LS7TTU/bX7V2WOR44qxYN1uu8VGWnh
 k3daimyXBXCDunyGt5SSAdf6NAEEmWR/owVD5/eC1Q2u6P4bvIiTVDLRd8mKK1OeUMtd
 4XAV73UiXCGqxj4VRcs5936bZqkNL50wzfYtpHMDV0qZFYakPf0aTQqcWkt8WKB1+2Sb
 g5hQ==
X-Gm-Message-State: APjAAAUGZdmo5Mv7OtOj/bYXWo6uYzLV4rXX1+cIK/0UANydpeAPlX3Z
 rWYMnnA702Ait/rP/SCTUdXQKduaYp1Uq8NjNPc8Aw==
X-Google-Smtp-Source: APXvYqyXlDV32pvvOQl7kYiQYbcmB9/A0bZjtVL0WweMM4MzW8RHZHRv/iYANe9ZkFTYpBh8wMtYLyjkF5jTpySuFxTL7Q==
X-Received: by 2002:a67:c419:: with SMTP id c25mr46425824vsk.136.1560759986427; 
 Mon, 17 Jun 2019 01:26:26 -0700 (PDT)
Date: Mon, 17 Jun 2019 01:25:55 -0700
Message-Id: <20190617082613.109131-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 00/18] kunit: introduce KUnit, the Linux kernel unit
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

A not so quick follow-up to Stephen's suggestions on PATCH v4. Nothing
that really changes any functionality or usage with the minor exception
of a couple public functions that Stephen asked me to rename.
Nevertheless, a good deal of clean up and fixes. See changes below.

As for our current status, right now we got Reviewed-bys on all patches
except:

- [PATCH v5 08/18] objtool: add kunit_try_catch_throw to the noreturn
  list

However, it would probably be good to get reviews/acks from the
subsystem maintainers on:

- [PATCH v5 06/18] kbuild: enable building KUnit
- [PATCH v5 08/18] objtool: add kunit_try_catch_throw to the noreturn
  list
- [PATCH v5 15/18] Documentation: kunit: add documentation for KUnit
- [PATCH v5 17/18] kernel/sysctl-test: Add null pointer test for
  sysctl.c:proc_dointvec()
- [PATCH v5 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
  SYSCTL section

Other than that, I think we should be good to go.

One last thing, I updated the background to include my thoughts on KUnit
vs. in kernel testing with kselftest in the background sections as
suggested by Frank in the discussion on PATCH v2.

## Background

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
(however, KUnit still allows you to run tests on test machines or in VMs
if you want[1]) and does not require tests to be written in userspace
running on a host kernel. Additionally, KUnit is fast: From invocation
to completion KUnit can run several dozen tests in under a second.
Currently, the entire KUnit test suite for KUnit runs in under a second
from the initial invocation (build time excluded).

KUnit is heavily inspired by JUnit, Python's unittest.mock, and
Googletest/Googlemock for C++. KUnit provides facilities for defining
unit test cases, grouping related test cases into test suites, providing
common infrastructure for running tests, mocking, spying, and much more.

### But wait! Doesn't kselftest support in kernel testing?!

In a previous version of this patchset Frank pointed out that kselftest
already supports writing a test that resides in the kernel using the
test module feature[2]. LWN did a really great summary on this
discussion here[3].

Kselftest has a feature that allows a test module to be loaded into a
kernel using the kselftest framework; this does allow someone to write
tests against kernel code not directly exposed to userland; however, it
does not provide much of a framework around how to structure the tests.
The kselftest test module feature just provides a header which has a
standardized way of reporting test failures, and then provides
infrastructure to load and run the tests using the kselftest test
harness.

The kselftest test module does not seem to be opinionated at all in
regards to how tests are structured, how they check for failures, how
tests are organized. Even in the method it provides for reporting
failures is pretty simple; it doesn't have any more advanced failure
reporting or logging features. Given what's there, I think it is fair to
say that it is not actually a framework, but a feature that makes it
possible for someone to do some checks in kernel space.

Furthermore, kselftest test module has very few users. I checked for all
the tests that use it using the following grep command:

grep -Hrn -e 'kselftest_module\.h'

and only got three results: lib/test_strscpy.c, lib/test_printf.c, and
lib/test_bitmap.c.

So despite kselftest test module's existence, there really is no feature
overlap between kselftest and KUnit, save one: that you can use either
to write an in-kernel test, but this is a very small feature in
comparison to everything that KUnit allows you to do. KUnit is a full
x-unit style unit testing framework, whereas kselftest looks a lot more
like an end-to-end/functional testing framework, with a feature that
makes it possible to write in-kernel tests.

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
This patchset is on the kunit/rfc/v5.2-rc4/v5 branch.

## Changes Since Last Version

Aside from a couple public function renames, there isn't really anything
in here that changes any functionality.

- Went through and fixed a couple of anti-patterns suggested by Stephen
  Boyd. Things like:
  - Dropping an else clause at the end of a function.
  - Dropping the comma on the closing sentinel, `{}`, of a list.
- Inlines a bunch of functions in the test case running logic in patch
  01/18 to make it more readable as suggested by Stephen Boyd
- Found and fixed bug in resource deallocation logic in patch 02/18. Bug
  was discovered as a result of making a change suggested by Stephen
  Boyd. This does not substantially change how any of the code works
  conceptually.
- Renamed new_string_stream() to alloc_string_stream() as suggested by
  Stephen Boyd.
- Made string-stream a KUnit managed object - based on a suggestion made
  by Stephen Boyd.
- Renamed kunit_new_stream() to alloc_kunit_stream() as suggested by
  Stephen Boyd.
- Removed the ability to set log level after allocating a kunit_stream,
  as suggested by Stephen Boyd.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html#test-module
[3] https://lwn.net/Articles/790235/
[4] https://google.github.io/kunit-docs/third_party/kernel/docs/
[5] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2-rc4/v5

-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
