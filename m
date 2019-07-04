Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E55F01D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jul 2019 02:37:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 17837212AD5B0;
	Wed,  3 Jul 2019 17:37:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a4a; helo=mail-vk1-xa4a.google.com;
 envelope-from=3luodxq4kdcydtgpfcpjkiikpuiqqing.eqonkpwz-pxfkoonkuvu.cd.qti@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com
 [IPv6:2607:f8b0:4864:20::a4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 72B35212AD598
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 17:37:03 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id w137so450594vkd.21
 for <linux-nvdimm@lists.01.org>; Wed, 03 Jul 2019 17:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=3dkcwHp7UkbBjeC+jKJgdEez1r7JnE/QFVNxh/Av3lE=;
 b=P/9Q0U57X0Mjr2pSdVR3fq5Q9Stk+yaqd+YUm9sq0ou6AVsZSt/1N/33ozuhbgY2vA
 l95M1OTPG7AMpCdkXNxZwoF74wXCpWnPckCjmlCUOfpVWb6OUe1dqoKeBMLQ2rRoWAC+
 fNHaGobDGBWH78hBlHjYyz8R5pV2r1lKhN6q853RMfM6pw8GA8VVYjvcvo3uf8gDuuir
 ENB2mZWRXg62IrhKkC86LfkNF4vHPkE6nmhUv9Xome467fLx+E9J0pgZrqEdzyy++0mz
 884zs7eBSkOyiHbrPJJuzc+Z2DaP9Fz7PcxSltbsQgqsrKy/bR2ai8bDNYsLrfqN7e+f
 Qiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=3dkcwHp7UkbBjeC+jKJgdEez1r7JnE/QFVNxh/Av3lE=;
 b=hUmUPNai80OU8EQQWPWucJqnGwRbcY2lia22NhNtK9CRv3GtBpcyaIeXEbSvp+rmwK
 45n97U1xvZgl4B71c1BFrHUItsnSq0tE6Wyf5wWqxGg9op1/5flrKiXzRA5sJKSeODwU
 Sd//TFeq+h2MT2zp5fj5xnChP+a+123OmuJ+3iUV9gQTBDG+xUj+hq3Rt6rLPhRnf05M
 WY4NyLi6SVmZGBvciPpYpneEweIbyfxx65+FMZOho11uv12cP8+mB4DuUHrY6UmvdBfo
 jmh5+iDrqVJX9jj5Q7znUlsKhLj3F+zep9yxvsLw8XPzuWzlOpvvp33YK0rdypg/jI4Z
 kpXw==
X-Gm-Message-State: APjAAAWXFtE66eG+a3dw99AlZfMgdopofE4NOhLxQx+SWUibo1BfOsri
 yycxXqlWnXEJZaebI26Yli26uIm/KdyjkzITmrpX9g==
X-Google-Smtp-Source: APXvYqxifi+9P2uuB2xECPxDjII80enpIo8mSlNTAxiC8KmAvRxtyVWjtDGXaCnqTdPCo5Xn7dOc4Z0daGhonP28ve9Qzg==
X-Received: by 2002:a1f:5945:: with SMTP id n66mr6468396vkb.58.1562200621022; 
 Wed, 03 Jul 2019 17:37:01 -0700 (PDT)
Date: Wed,  3 Jul 2019 17:35:57 -0700
Message-Id: <20190704003615.204860-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v6 00/18] kunit: introduce KUnit, the Linux kernel unit
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

This is a pretty straightforward follow-up to Stephen and Luis' comments
on PATCH v5: There is nothing that really changes any functionality or
usage with the minor exception that I renamed `struct kunit_module` to
`struct kunit_suite`. Nevertheless, a good deal of clean ups and fixes.
See "Changes Since Last Version" section below.

As for our current status, right now we got Reviewed-bys on all patches
except:

- [PATCH v6 08/18] objtool: add kunit_try_catch_throw to the noreturn
  list

However, it would probably be good to get reviews/acks from the
subsystem maintainers on:

- [PATCH v6 06/18] kbuild: enable building KUnit
- [PATCH v6 08/18] objtool: add kunit_try_catch_throw to the noreturn
  list
- [PATCH v6 15/18] Documentation: kunit: add documentation for KUnit
- [PATCH v6 17/18] kernel/sysctl-test: Add null pointer test for
  sysctl.c:proc_dointvec()

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
This patchset is on the kunit/rfc/v5.2-rc7/v6 branch.

## Changes Since Last Version

Aside from renaming `struct kunit_module` to `struct kunit_suite`, there
isn't really anything in here that changes any functionality:

- Rebased on v5.2-rc7
- Got rid of spinlocks.
  - Now update success field using WRITE_ONCE. - Suggested by Stephen
  - Other instances replaced by mutex. - Suggested by Stephen and Luis
- Renamed `struct kunit_module` to `struct kunit_suite`. - Inspired by
  Luis.
- Fixed a broken example of how to use kunit_tool. - Pointed out by Ted
- Added descriptions to unit tests. - Suggested by Luis
- Labeled unit tests which tested the API. - Suggested by Luis
- Made a number of minor cleanups. - Suggested by Luis and Stephen.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2-rc7/v6

-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
