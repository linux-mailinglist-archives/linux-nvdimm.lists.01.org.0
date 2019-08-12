Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E88A5A0
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 20:24:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B11A12130A4F7;
	Mon, 12 Aug 2019 11:27:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::84a; helo=mail-qt1-x84a.google.com;
 envelope-from=35q5rxq4kdhsaqdmczmghffhmrfnnfkd.bnlkhmtw-muchllkhrsr.z0.nqf@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0B576212B0FED
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 11:26:59 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e32so97315308qtc.7
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=9mTljNvnyVjruVsrPNgUh53D69b4G0uh+rf/XKR7JZU=;
 b=LnitzvMrBNB6LXONfL+PvwD9Ikk/vWzKySiopcnIrxQgVqiY5+jLuNhJ9ZjzPBotY0
 Y0ntD2wGlkRwN/WqMUqePvF0CIftp/LQyZGsiE/rMamSPolRPy/gI1hWyTFrYjj8Az0S
 iO+WLGSlSP4wDNeKPbhpSACldOlKIN0vm2AbpOTth5lwOi+wd5FtPBH+6DMV4BF7XZ5u
 DCsO7wsqQZmhB7r+8C/SPCwSznOeI9ADcdzFPsEOZDZ9rWtgCf15F0uO/DhlcKvYD1vS
 ikhy6UaROEOWv19ZHJDw8MIz7i0jbDy1yYL+vXOT6UpBhCm16LBtfsDmmxW8jdqFq7iG
 CYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=9mTljNvnyVjruVsrPNgUh53D69b4G0uh+rf/XKR7JZU=;
 b=Ka+DaFJlsSPQxsXkubpBMtocl8cjlm15Bh4xppl4H4w1WKm97KwVnuh7DXSYf/TEM1
 rlyCErX2BMNTB1pydLuKL7xfeUXIuu6XomnvJ3g7+tclIHVK6+Wq7QaS45gnjUrKIrmP
 +3CFmlXGaT5PjvOrTQhjS9zXogRsxUbt+K3ElX20CFJv3AL81CyIQnxKwnyiuyG3VnQR
 72ozxLpRT4JlSs5hdjT50gd9Mw4zAjud59dxgbSuEA6yzVpJO//fDRe2b6fnRSOJAsFx
 VrQqXcczKTiQ3AhYbK30Vtz9RyiVyIFQx564cgVhFnioe1q64Q5ExrWRy9x2S34bqoXa
 yz1g==
X-Gm-Message-State: APjAAAU7rOWAtqcbFgGebs6lUn3UP0Sn/A/loHDazDi6QIuvx4gIu+3B
 D7q7RdpfvXWp/2rlXB82h4horBA1y/lYxGfyimQpPA==
X-Google-Smtp-Source: APXvYqyX/pgx0ykzeqZ6WcltGi5sso4Ln3mqeyyrGVZaHJD02/SPkwtsL4N8Ya+oDgvaUGfqUr1kIJOvfUwiqmtqKuHktw==
X-Received: by 2002:a37:4a88:: with SMTP id
 x130mr13395431qka.501.1565634278957; 
 Mon, 12 Aug 2019 11:24:38 -0700 (PDT)
Date: Mon, 12 Aug 2019 11:24:03 -0700
Message-Id: <20190812182421.141150-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v12 00/18] kunit: introduce KUnit, the Linux kernel unit
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

This revision removes dependence on kunit_stream in favor of
kunit_assert, as suggested by Stephen Boyd. kunit_assert provides a more
structured interface for constructing messages and allows most required
data to be stored on the stack for most expectations until it is
determined that a failure message must be produced.

As a part of introducing kunit_assert, expectations (KUNIT_EXPECT_*) and
assertions (KUNIT_ASSERT_*) have been substantially refactored.
Nevertheless, behavior should be the same.

As this revision, adds a new patch, it, [PATCH v12 04/18], needs to be
reviewed. All other patches have appropriate reviews and acks.

I also rebased the patchset on v5.3-rc3.

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
This patchset is on the kunit/rfc/v5.3/v12 branch.

## Changes Since Last Version

- Dropped patch "[PATCH v11 04/18] kunit: test: add kunit_stream a
  std::stream like logger" and replaced it with "[PATCH v12 04/18]
  kunit: test: add assertion printing library", which provides a totally
  new mechanism for constructing expectation/assertion failure messages.
- Substantially refactored expectations and assertions definitions in
  [PATCH 05/18] and [PATCH 11/18] respectively.
- Rebased patchset on v5.3-rc3.
- Fixed a minor documentation bug.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.3/v12

-- 
2.23.0.rc1.153.gdeed80330f-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
