Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7BF8CAC0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Aug 2019 07:52:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 328AF20304302;
	Tue, 13 Aug 2019 22:54:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com;
 envelope-from=3ikftxq4kdasm2pyolystrrty3rzzrwp.nzxwty58-y6otxxwt343.bc.z2r@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B8571203042ED
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 22:54:17 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j9so13829233pgk.20
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 22:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=JIx6gT8XrMurJkYFq0Mwh3doyQoWfrR1Obdr19umRAo=;
 b=lYtLPslE++KBhps7EtMXbyUcustGXe90OzEpA99zwHxQbVzot3NR81r30SxELmpTRj
 bFTX6PGmhfSfkUB0/hnN4TiDWPb9DGLT5n61SEFnAdjshDyjj9bfjOnYsVA8+2Wxa382
 hltZppNluZLMP3S27A5ep9xYE0fIqIXqNkFfqFxv/fX4amYyXfyPeKZMuHa0KtJyXYcL
 3dfzQ9XQrdy8jFFrB3jJCdZRXVPkDPt0BxDMzHm0Rbo2i7qahJfYSiN5kDw0wJhAXIM9
 5J0ignULWuWomRnfxW/Cnhs9Nkq0yzbvKJSmYrGdmqVvm6nl9IXqxbyhcWibeLv1FLvS
 sTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=JIx6gT8XrMurJkYFq0Mwh3doyQoWfrR1Obdr19umRAo=;
 b=RYwdQDGraWYlMitZEj4aQc6utDq4NKeGm0LcVQzG76363X7OlWsp/4u00uXW6wh44O
 7FAWmE+0PsSP+Ey0PhgKS6kyqTBqy95jLynqGLEgeyncNuDqngcK2aWiAwJeS2+dGi6T
 cPHIcRjks+/IrojY/arRtrgmf12pRoxzNRlUa4fjfXLAyFq0Km7Au6QPMRZn+0QoaO/P
 fsc5KXOc4kQmeDAcHzPteRqo19PIZNH4ugVCxpGIFwN5UBBbDbOuFBuXi2SczmxChpBG
 hknn1GvkijvrfeSEFFPsBrhLkdPJz47MKGtA9e5noIljIzsFYWpBg1F5vUOLl19uHwzH
 Ru+w==
X-Gm-Message-State: APjAAAUG0ubVzliV3XQD4aCVAuuQx/JVSFYfs3OCxosi1BlFNPzYyn4y
 LHm0pifln7YPgCV8YbqpAx1co/kwByNG5Cvr8txDhw==
X-Google-Smtp-Source: APXvYqzpu9CiuWlTANWLufkskZGUP8V49k9uzqoRz2WmUPz8UVqc7iwJcusHzog7K8pIU/rzSJgkN1EhsWWgKYr26ckb6g==
X-Received: by 2002:a63:6c4:: with SMTP id 187mr34796011pgg.401.1565761928470; 
 Tue, 13 Aug 2019 22:52:08 -0700 (PDT)
Date: Tue, 13 Aug 2019 22:50:50 -0700
Message-Id: <20190814055108.214253-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v13 00/18] kunit: introduce KUnit, the Linux kernel unit
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
 rostedt@goodmis.org, julia.lawall@lip6.fr, Bjorn Helgaas <bhelgaas@google.com>,
 kunit-dev@googlegroups.com, richard@nod.at, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

## TL;DR

This revision addresses comments from Stephen and Bjorn Helgaas. Most
changes are pretty minor stuff that doesn't affect the API in anyway.
One significant change, however, is that I added support for freeing
kunit_resource managed resources before the test case is finished via
kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
KUnit on certain configurations (like the default one for x86, whoops).

Based on Stephen's feedback on the previous change, I think we are
pretty close. I am not expecting any significant changes from here on
out.

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
This patchset is on the kunit/rfc/v5.3/v13 branch.

## Changes Since Last Version

- Added support for freeing kunit_resources (KUnit managed resources)
  via kunit_resource_destroy() as suggested by Stephen.
- Promoted WARN() after __noreturn function to BUG() in
  "[PATCH v13 09/18] kunit: test: add support for test abort" as
  suggested by Stephen.
- Dropped concept of death test since I am not actually using it yet as
  pointed out by Stephen.
- Replaced usage of warn_slowpath_fmt with WARN in kunit_do_assertion
  since warn_slowpath_fmt is not available on some build configurations,
  as pointed out by Bjorn.
- Lots of other minor changes suggested by Stephen.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.3/v13

-- 
2.23.0.rc1.153.gdeed80330f-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
