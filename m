Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2C6685B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Jul 2019 10:17:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 04150212B5EF5;
	Fri, 12 Jul 2019 01:20:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com;
 envelope-from=3lkioxq4kdemgwjsifsmnllnsxlttlqj.htrqnsz2-s0inrrqnxyx.56.twl@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B600F212AF0D5
 for <linux-nvdimm@lists.01.org>; Fri, 12 Jul 2019 01:20:17 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id i13so5293749pgq.3
 for <linux-nvdimm@lists.01.org>; Fri, 12 Jul 2019 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=UvKno1DQ1En2T0BAydqL8aKwWtOHxHpLOB0ZXuFETLs=;
 b=JtlStr7snNzmz5ulMB5eP37s7rbgIx50z+AVGP2t2WlEdfRbEZO8W2XTT3bE3WZnLv
 keBpChTguji20fGG9MZtiJLfIGuGAQMR0xBWsqfAPNv7xBwu2S4omSfLGIwdCobd9HG0
 xEIx+MC/l52zarabPfgQ095HslgbhlLi4Z2VOa7yRbXGn1OMnhIjlbG9wufHRgT48Rw8
 N31KLcKdJR3xIPKj8X7rcKFfr9bJzXFefGvAJSqFErU5ciZBVgJrNxh12tyuyphu+Fd0
 ntbZjblO4lofJT/rrUQvPdmmolFfkVV45QPFi2V3CSuuX8nBjrc2V4ynCPPNIkIg5MTd
 4B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=UvKno1DQ1En2T0BAydqL8aKwWtOHxHpLOB0ZXuFETLs=;
 b=jYhKhKoMCe7eeuz49ULP9ceDLuQa2RCu6tda796XmVG5ZW5u9jVBdgzQQyR9l3RliI
 ztb+9kBFpJukSOLMVnW69Hh/5dEAspm68DM3GTC9Kp9072WSADGeaotdDj6mJ0PPNPHC
 a4G1LfLGThyB9P9C522/w6fl3ITDTWZyhtm+9M7HmtoNpybQruccjC1mLku9wcIAjmI5
 bk00QVqwTeLoZ/WE8ZH7iqkr3M4Prr60rmyeAo/C003FCmvLpZBoQ389XMIjfofVNCql
 iO6ZykJG+cvMwsnS9lYRdVopvGMrI/Cukgtbr5a3WX3flApbpRoZGOBDgkFiVgnWwIP2
 XWXw==
X-Gm-Message-State: APjAAAUTlrUKvK6tliFHVCOzCvwB/KidOx18N8fDKS5fV3fHsCWAOqxR
 1N8VSvsfs+Iozp5pkGKIne3MJgCXNQFaz1Ned5J+lg==
X-Google-Smtp-Source: APXvYqwxVjSSyLsmH5X5K9D5aFhrhgELvG+6tDMdeYJeUGZ3SfBpCQBrCaJmP5g1KYNhq+xNRut9+ZtuWUgQ3Ro3jfxY+Q==
X-Received: by 2002:a65:5348:: with SMTP id w8mr9232476pgr.176.1562919470178; 
 Fri, 12 Jul 2019 01:17:50 -0700 (PDT)
Date: Fri, 12 Jul 2019 01:17:26 -0700
Message-Id: <20190712081744.87097-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 00/18] kunit: introduce KUnit, the Linux kernel unit
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

This new patch set only contains a very minor change to address a sparse
warning in the PROC SYSCTL KUnit test. Otherwise this patchset is
identical to the previous.

As I mentioned in the previous patchset, all patches now have acks and
reviews.

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
This patchset is on the kunit/rfc/v5.2/v9 branch.

## Changes Since Last Version

Like I said in the TL;DR, there is only one minor change since the
previous revision. That change only affects patch 17/18; it addresses a
sparse warning in the PROC SYSCTL unit test.

Thanks to Masahiro for applying previous patches to a branch in his
kbuild tree and running sparse and other static analysis tools against
my patches.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2/v9

-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
