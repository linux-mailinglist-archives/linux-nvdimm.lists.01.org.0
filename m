Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A885E10FE8
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 01:04:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 85682212377F4;
	Wed,  1 May 2019 16:04:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::249; helo=mail-oi1-x249.google.com;
 envelope-from=3cybkxa4kdgwlboxnkxrsqqsxcqyyqvo.mywvsxeh-xfnswwvscdc.kl.ybq@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com
 [IPv6:2607:f8b0:4864:20::249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C85E621962301
 for <linux-nvdimm@lists.01.org>; Wed,  1 May 2019 16:04:44 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id y197so323649oia.22
 for <linux-nvdimm@lists.01.org>; Wed, 01 May 2019 16:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=chqbiB4K0p/zEKsVbXe4iW2Xpj6yAVIrWQhjpUaEvyA=;
 b=GE0P464mBtC8wrhfBO7g793E4I4dqW2RIP7+tHwU/PC57hjNo6fmzw5HElvCwVJ32i
 ZkuQrQPVcHSfFt6v723klhDSf/BCGNNvLIImZbUWeECzTjsM5G6js6Y4BB5vjlq16LAN
 nySbgJK0p0eYO+3PMfew/5txRXxjgd1tovWq5YKZjGYzlDxEQ+Q6GSZnOMuy+DFhqKMT
 uJ3lLNt16MIjzkoA11kKC2qDuhYsfvUVFDvaTEF8ASb3zPAzcT2kDwqalnmACvYsWp+Z
 7T2yCIRZwzp4TkmtK1c2L5CoSAeNHI4xKfYHm9/xZ7l5IMHM0zff93mqcrZ2D4EpNlPo
 NA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=chqbiB4K0p/zEKsVbXe4iW2Xpj6yAVIrWQhjpUaEvyA=;
 b=I+ms70Gec9yk1E8hJu/buWkWAAF8AZo8AJNin2l6XVx23f7CKA7slzVzYJu5OJXxBD
 +4K6ozph817l03063944CNyTRiwS201KxKwHmsJ51QP0TzklUC0rm7C5AmC9qPcJ6P+9
 odietrlBt8m/RDZxbLzHlSSm7mS7vZ00mibhSF0yZnk7z9ZwDPjj2dsHNo3pK3/PVe1s
 j3E/3j7sLRmgIyOjawSUUZO458mr6THJL+dRf+pc8Ea3mVQjpgpbbqw4wJ5w+rk6eSuO
 jw7sNW/81nTUlnrwdXb5GeFe/QvdlyHat6nU4SZHyFGNQF1e4QGw/RmDAJhw0HIPh5j7
 2WWQ==
X-Gm-Message-State: APjAAAXObDC52m3g94WeUW9wMK4OJ8QOZonEPMumx/fikqHe0tihg6gE
 9owzcFp7WDLTy/jNlDbDafNT0h70DwfrXROKZ0xcpw==
X-Google-Smtp-Source: APXvYqziahGWgdBZbQfWG2ft5ebLp+ozkgppLiv8kSSis3P9fMvGcrL9eofrdvhLG15CPkadoMaZYjcvL9G8Pk6lBON+yg==
X-Received: by 2002:aca:cd88:: with SMTP id d130mr481038oig.63.1556751883876; 
 Wed, 01 May 2019 16:04:43 -0700 (PDT)
Date: Wed,  1 May 2019 16:01:22 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-14-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 13/17] kunit: defconfig: add defconfigs for building KUnit
 tests
From: Brendan Higgins <brendanhiggins@google.com>
To: frowand.list@gmail.com, gregkh@linuxfoundation.org, keescook@google.com, 
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org, 
 sboyd@kernel.org, shuah@kernel.org
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
 richard@nod.at, linux-kernel@vger.kernel.org, daniel@ffwll.ch,
 mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add defconfig for UML and a fragment that can be used to configure other
architectures for building KUnit tests. Add option to kunit_tool to use
a defconfig to create the kunitconfig.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/configs/kunit_defconfig              |  8 ++++++++
 tools/testing/kunit/configs/all_tests.config |  8 ++++++++
 tools/testing/kunit/kunit.py                 | 17 +++++++++++++++--
 tools/testing/kunit/kunit_kernel.py          |  3 ++-
 4 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/configs/kunit_defconfig
 create mode 100644 tools/testing/kunit/configs/all_tests.config

diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
new file mode 100644
index 0000000000000..bfe49689038f1
--- /dev/null
+++ b/arch/um/configs/kunit_defconfig
@@ -0,0 +1,8 @@
+CONFIG_OF=y
+CONFIG_OF_UNITTEST=y
+CONFIG_OF_OVERLAY=y
+CONFIG_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
new file mode 100644
index 0000000000000..bfe49689038f1
--- /dev/null
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -0,0 +1,8 @@
+CONFIG_OF=y
+CONFIG_OF_UNITTEST=y
+CONFIG_OF_OVERLAY=y
+CONFIG_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7413ec7351a20..63e9fb3b60200 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -11,6 +11,7 @@ import argparse
 import sys
 import os
 import time
+import shutil
 
 import kunit_config
 import kunit_kernel
@@ -36,14 +37,26 @@ parser.add_argument('--build_dir',
 		    'directory.',
 		    type=str, default=None, metavar='build_dir')
 
-cli_args = parser.parse_args()
+parser.add_argument('--defconfig',
+		    help='Uses a default kunitconfig.',
+		    action='store_true')
 
-linux = kunit_kernel.LinuxSourceTree()
+def create_default_kunitconfig():
+	if not os.path.exists(kunit_kernel.KUNITCONFIG_PATH):
+		shutil.copyfile('arch/um/configs/kunit_defconfig',
+				kunit_kernel.KUNITCONFIG_PATH)
+
+cli_args = parser.parse_args()
 
 build_dir = None
 if cli_args.build_dir:
 	build_dir = cli_args.build_dir
 
+if cli_args.defconfig:
+	create_default_kunitconfig()
+
+linux = kunit_kernel.LinuxSourceTree()
+
 config_start = time.time()
 success = linux.build_reconfig(build_dir)
 config_end = time.time()
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 07c0abf2f47df..bf38768353313 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,6 +14,7 @@ import os
 import kunit_config
 
 KCONFIG_PATH = '.config'
+KUNITCONFIG_PATH = 'kunitconfig'
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -81,7 +82,7 @@ class LinuxSourceTree(object):
 
 	def __init__(self):
 		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file('kunitconfig')
+		self._kconfig.read_from_file(KUNITCONFIG_PATH)
 		self._ops = LinuxSourceTreeOperations()
 
 	def clean(self):
-- 
2.21.0.593.g511ec345e18-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
