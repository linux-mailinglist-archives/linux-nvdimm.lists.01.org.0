Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADB4641C2
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jul 2019 09:15:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 05CFD212B205B;
	Wed, 10 Jul 2019 00:15:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com;
 envelope-from=3kzalxq4kddgvlyhxuhbcaachmaiiafy.wigfchor-hpxcggfcmnm.uv.ila@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8DF17212AF0CE
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:15:31 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id d187so919456pga.7
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=0pW1BcsjTPSHyEkMo96k/o71l5W8M51wh7ZyhpVzADM=;
 b=mHi2l865KLWjgVk77JKmNtYGZe0xgmJqUcNAffie+cN+57XolMX3GDCpJ2ZH1ceLYR
 MfFyvnNY0Qwe0x/ZOIiekj7NzIlsbUZDTxthSd/LJOgqPFNF5dEsFtGMwPVF/nYSdHyJ
 3VdZcCGqzormHX3dS/yuInQiUg9E6laAPfQmLbGCGEz4HepJhwqJgmDJF7yj1dr6aCix
 Siqg+NV9jVwUY3x9AB0/e1BJUu0lC4cmATkNcO/Wd9E8nEXdmqgE1jZEc5mwC0ai37Am
 Pbg5JO4uqte1qi5grtXQRrH7O14tsuFUMbYzcI0pjXuihXi7w4+aV03+iVTZpiuzAPq1
 67HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=0pW1BcsjTPSHyEkMo96k/o71l5W8M51wh7ZyhpVzADM=;
 b=iw+rgOlPkEHu1QZq2cz8xYTvD2tK5rmLINauph0Ka43yfmqqz3SxOPF9w/dlTsRMIa
 /GsOIA1oFrzuTK2yosHmOLNa3KClnt375fNYBfX6HBH1QC1/IQTSj2hpuI5Wu7Wo0vW8
 30y3EcVFIj17FXA8/MiL0WCAhM/dDm8Z8Egv5XXin5IjM+cgxamQLcyZjBwCmL/ult0L
 bAqX1vgJP9M3t9lIJ5xW8VmtqW9a/IpA2e5krZZLTqYhMNEH2olLC8CmSRH9OVSa5t97
 V6ITwGiqo8RcIDHvTSssCBmlfllk1kOTfKkNSaF3aMkoNpJ2vx0jBtdhnNOeizmrZc1z
 SrRw==
X-Gm-Message-State: APjAAAWq6mZYIEhwta7aAtqH3ZZpNaY82qPhWjTXO8qcCChATQJs+HP7
 Sju9/KZGHlCEX91FjI/igRMGCQat4HsmTQ3kwgbhug==
X-Google-Smtp-Source: APXvYqyb0LRYaKSRSGjVUbWvUV4R01ShtwO7/fsNXpVB/VnszhSBSXJqqHQquziMhALgKYKtHVI7t5pL3wpE0iRmNMtOpg==
X-Received: by 2002:a63:1f56:: with SMTP id q22mr33295799pgm.315.1562742929971; 
 Wed, 10 Jul 2019 00:15:29 -0700 (PDT)
Date: Wed, 10 Jul 2019 00:14:50 -0700
Message-Id: <20190710071508.173491-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 00/18] kunit: introduce KUnit, the Linux kernel unit
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

This new patch set only contains a very minor change suggested by
Masahiro to [PATCH v7 06/18] and is otherwise identical to PATCH v7.

Also, with Josh's ack on the preceding patch set, I think we now have
all necessary reviews and acks from all interested parties.

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
This patchset is on the kunit/rfc/v5.2/v8 branch.

## Changes Since Last Version

Like I said in the TL;DR, there is only one minor change since the
previous revision. That change only affects patch 06/18; it makes it so
that make doesn't attempt to scan the kunit/ directory when CONFIG_KUNIT
is not set as suggested by Masahiro.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2/v8

-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
