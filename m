Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1716B391
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Jul 2019 03:55:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F00DF212BF54D;
	Tue, 16 Jul 2019 18:58:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com;
 envelope-from=3kiauxq4kdneye1a0xa45335af3bb381.zb985ahk-ai059985fgf.no.be3@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C514021A07A92
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 18:58:21 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id u16so1726504pgj.7
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 18:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=g73VbK9hP8iwHcV/w0DEWc6A8T81W2obxVf/JscQhPY=;
 b=Vbb6ETWdoL7/dyTwrtnSjUAJji8HmC0dbYlvBQhYL3ZtcFa53MTUkxRV21Vh+xQzRU
 gtcMrgV6CsUcmCq6PHa2QI2RapBr3kPi3qcDZTk/V+RQINbCgIAGW9XgyyKfzkIP+4A2
 Cj9ApaRpGtUkElZpxENbPQ4y/LhEkO32Y8s6YtL6EobTN8efWAzcypCT1B1B2UtD/u4i
 A3n0+WeJDp01P7yO5hdDAfarVytQtTxJ7QrOXdADRb4dC2e7V8+WsZndPYZvAMZpQ4s7
 2BclIo1VrtBu6iu7lEVSZ2YJI8piqhPI0Z2qIl5B2wcZ4ToCguieuFOeyAl4qvN2wNXh
 HDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=g73VbK9hP8iwHcV/w0DEWc6A8T81W2obxVf/JscQhPY=;
 b=JMON5QHyR+OhiBpd5BiMHdffUQ4RlZ5IEzhOYql2IDZFsamWNqZQiVzsvMnmt+3Ha+
 NifPOnaG4+f0LCH62VOXjPcS21FM/g+IZ/wD0uXBfTKMZnqVmae6T4u0bvub09HBu4wy
 H0ETS2L0h7/iYmIBgc+KYQZxSzu1yAcU7yyUwHvgWl59oj4ZGGhZd4IFAhTC0tzGPowG
 zJ/k21oYdbqHrkfoVF8nzhn5BF0HUW4MfsgUtrtb25sE+ko70rEOBuAZiH/dagVwD2ZY
 0xR4oxBCLPfji+6uz2BU7dySYtg1f1Zt/G9XckrmPquZ0LZ7ybSY1+1P1Ry2HAYNUasE
 y5wA==
X-Gm-Message-State: APjAAAU9sqepV8Iepyou4DilLdmc6Od5q+sWqRiRbzrIaXY/fOGcdevT
 vEgoS/KdJOU/kYcjXqKa6mBqNzNzErmbnVj1h0I1Jw==
X-Google-Smtp-Source: APXvYqzIJkjKQ3S+2BDLj5Fx/7Xa9wrPBuZpZW0wEdv7tjBDXndxr0psGCLPsqNbiarNlPEHuGD5doQNqhtuO1IsifVYng==
X-Received: by 2002:a63:2606:: with SMTP id m6mr37469748pgm.436.1563328552353; 
 Tue, 16 Jul 2019 18:55:52 -0700 (PDT)
Date: Tue, 16 Jul 2019 18:55:25 -0700
Message-Id: <20190717015543.152251-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v11 00/18] kunit: introduce KUnit, the Linux kernel unit
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

This patchset addresses comments from Stephen Boyd. No changes affect
the API, and all changes are specific to patches 02, 03, and 04;
however, there were some significant changes to how string_stream and
kunit_stream work under the hood.

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
This patchset is on the kunit/rfc/v5.2/v11 branch.

## Changes Since Last Version

- Went back to using spinlock in `struct string_stream`. Needed for so
  that it is compatible with different GFP flags to address comment from
  Stephen.
- Added string_stream_append function to string_stream API. - suggested
  by Stephen.
- Made all string fragments and other allocations internal to
  string_stream and kunit_stream managed by the KUnit resource
  management API.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2/v11

-- 
2.22.0.510.g264f2c817a-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
