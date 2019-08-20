Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CEE96D08
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 01:20:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7D61F21962301;
	Tue, 20 Aug 2019 16:22:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a49; helo=mail-vk1-xa49.google.com;
 envelope-from=3vybcxq4kdlgzpclbylfgeeglqemmejc.amkjglsv-ltbgkkjgqrq.yz.mpe@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com
 [IPv6:2607:f8b0:4864:20::a49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8E49C2020D331
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 16:22:10 -0700 (PDT)
Received: by mail-vk1-xa49.google.com with SMTP id j63so218249vkc.13
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=d/yRotIqofKL6ivNLT0spFL8C+ImKotVaARxIwjjT6U=;
 b=AVw2bVu+4NwiDCTMe7ctCvAsytyWg/rXh1qSlFIYcZ34MZ2W4zFBX61usfUDXKDI+U
 6mkzeHkKvCm3jsXc7ellvdvzMZ/yYq5pQYIgEJEeej2GmzjldUwbhas7sVL0y1BF9R5Q
 aeLd89FDK15SPfbl+SuyrbqBs3o2uiag6LIW+dn6YgaIXzRVfITYu/qa+PVnh2pu0la1
 EgwkQGeMgeft4WVs3y+cr1sGSCDFeF0e6bPs6wefJLtZGnA3fREotyJnv1WY33ED8Kos
 PZta1YwDrJCXLZftQ0jdf7GzZQX+uUMqkEw7bGquy+vwd3aApIC+kCto7n+WJu4zEbsw
 +lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=d/yRotIqofKL6ivNLT0spFL8C+ImKotVaARxIwjjT6U=;
 b=LijFH2sf1H7aJbdIbOVtnH2WjsEruRGOSY8F3eg1cpT/pRk4JOpUf2piZW2QLSl785
 fYS7g91xjy2vPuIQLbKunhWy7gIKmP0KMIaZSM/Lbi4cwLrOf1q99xDnr8z1e+lSEYPp
 1FRyyi9HqpVaqjrOZyS6uKav3hsYSkpbZWFlt8XuzdEeWftZo/PFVDgGrGUbqQ2rJG2w
 ZrHBVRCzRG7CmcHxgleVUQgLHry4vA8XttMqrB3tu5td4z100yT0RwajD+Xh7YIb+RSD
 l0iGulnC5WKv6snlPqgeRNipKBNefmVf0hGEW+D+ySlACpBTrd/7Igdsdhi4aD2WxqHK
 6ovw==
X-Gm-Message-State: APjAAAWmg+26EV068Byv0ll1ARYT1CuvuyleI094rL5z/mPbRw4rUzpa
 RkENWeoJPYAyIgl4lEh33XfpI768GjmJOMpDIm30Ng==
X-Google-Smtp-Source: APXvYqxI/nPId+DHfk6D741GOqFrVhdMCpaqnV+6xqhMReBcYshk3sm1bvTSqco2NKWiElhS3+UgytqYYzLVwPw9MVYXZA==
X-Received: by 2002:a67:2605:: with SMTP id m5mr19353609vsm.120.1566343253112; 
 Tue, 20 Aug 2019 16:20:53 -0700 (PDT)
Date: Tue, 20 Aug 2019 16:20:28 -0700
Message-Id: <20190820232046.50175-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v14 00/18] kunit: introduce KUnit, the Linux kernel unit
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

This revision addresses comments from Shuah by removing two macros that
were causing checkpatch errors. No API or major structual changes have
been made since v13.

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
This patchset is on the kunit/rfc/v5.3/v14 branch.

## Changes Since Last Version

- Removed to macros which helped define expectation and assertion
  macros; these values are now just copied and pasted. Change was made
  to fix checkpatch error, as suggested by Shuah.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.3/v14

-- 
2.23.0.rc1.153.gdeed80330f-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
