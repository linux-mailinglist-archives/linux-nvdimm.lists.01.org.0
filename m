Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E96B9B43
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 02:19:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 11B0E202EDBB7;
	Fri, 20 Sep 2019 17:22:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com;
 envelope-from=3n2yfxq4kdiafvirherlmkkmrwksskpi.gsqpmry1-rzhmqqpmwxw.45.svk@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BDB0E202EDB95
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:22:34 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id m1so3385665pgq.5
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=XW6ObdsygoQczUzhnAeFOiZL9hvh/FcVMF1CQf4gGoM=;
 b=OrXvrJLBWdLqzisxoi8jU3vfGJHtOA49Qe2IxJF1qY85Ltuv1VwdewF86chLIvz32z
 KMzqrdOToNSByFyZ2dtSd+S58a3y8Le91vWVHXV2AEyg5za8+MXqqAFFaPeiqaKqP7ye
 QssFQ2Zoy4K12eci4z4lh64cJ4BKfaGDlV7ttPAI0Ar8tzBtuUXYfLFNDdVy5EMdOxlK
 vg/Mw8OTiExxDCqWdxhIB+EnyETMxIjBAUlIIgaPR5SRtnDhki+k5hLZxocHZJzUjMPg
 a/UwC9PNPe7ZNuJrR0x44aV53+HC8k8Dx6+Lv315/koAVawVj73NbIA5UjpREgfvE2/D
 9+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=XW6ObdsygoQczUzhnAeFOiZL9hvh/FcVMF1CQf4gGoM=;
 b=HhdAmoAKBEB1iqn6DjSzQmIsf16c19GmjkXKEdkAeLghV0kg3zrJk6l3LzdDrsyHa9
 yzuIBvgZI4nbxEBGif6tmO3iLRXbE6ICCFDFF9m2VzhAxXIHJirZjh2ElPr8jvo4ktgP
 JP2j9NJ8h5cgnV8V3SEbrgtJjgWEC6/L4GuHVAsLQ0e27JWf9nvraFsgZSnB0d7TKbvq
 t0oZ7EA5QaTI4FBKZQlN6jmWA3IvflnR03nW9hqlTVu6YOt1bV1BX7rsJNpFYjHsPrHZ
 eDK953T12l35hdCq4UkcBAImiO163ZDy0LkGfNOdLEt+S/u+2Lop8nkmb+5aPRA5Td/A
 H+ng==
X-Gm-Message-State: APjAAAVU0zDgOM45L1gwwNZjEsZfSkolMjGSb4rUhDvBCbfj9SpaGcdZ
 5OlVjWUphVsF26IPw4iy6lHqIPVQUrC6MWop0/RWSQ==
X-Google-Smtp-Source: APXvYqyjc1DyyONzzE1r5kKElYjmc90nIgLhJ5fKoZYKnD+M18JEyoN80pnNSuYm0c4+CAQbqRnKvYHt4UI2u9+ac2GJaQ==
X-Received: by 2002:a63:4d4b:: with SMTP id n11mr4239710pgl.409.1569025183314; 
 Fri, 20 Sep 2019 17:19:43 -0700 (PDT)
Date: Fri, 20 Sep 2019 17:18:50 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-15-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 14/19] kunit: defconfig: add defconfigs for building KUnit
 tests
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
 richard@nod.at, torvalds@linux-foundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add defconfig for UML and a fragment that can be used to configure other
architectures for building KUnit tests. Add option to kunit_tool to use
a defconfig to create the kunitconfig.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/configs/kunit_defconfig              |  3 +++
 tools/testing/kunit/configs/all_tests.config |  3 +++
 tools/testing/kunit/kunit.py                 | 28 +++++++++++++++++---
 tools/testing/kunit/kunit_kernel.py          |  3 ++-
 4 files changed, 32 insertions(+), 5 deletions(-)
 create mode 100644 arch/um/configs/kunit_defconfig
 create mode 100644 tools/testing/kunit/configs/all_tests.config

diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
new file mode 100644
index 000000000000..9235b7d42d38
--- /dev/null
+++ b/arch/um/configs/kunit_defconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
new file mode 100644
index 000000000000..9235b7d42d38
--- /dev/null
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index da11bd62a4b8..0944dea5c321 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -11,6 +11,7 @@ import argparse
 import sys
 import os
 import time
+import shutil
 
 from collections import namedtuple
 from enum import Enum, auto
@@ -21,7 +22,7 @@ import kunit_parser
 
 KunitResult = namedtuple('KunitResult', ['status','result'])
 
-KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir'])
+KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
 
 class KunitStatus(Enum):
 	SUCCESS = auto()
@@ -29,8 +30,16 @@ class KunitStatus(Enum):
 	BUILD_FAILURE = auto()
 	TEST_FAILURE = auto()
 
+def create_default_kunitconfig():
+	if not os.path.exists(kunit_kernel.KUNITCONFIG_PATH):
+		shutil.copyfile('arch/um/configs/kunit_defconfig',
+				kunit_kernel.KUNITCONFIG_PATH)
+
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
+	if request.defconfig:
+		create_default_kunitconfig()
+
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir)
 	config_end = time.time()
@@ -72,7 +81,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	else:
 		return KunitResult(KunitStatus.SUCCESS, test_result)
 
-def main(argv, linux):
+def main(argv, linux=None):
 	parser = argparse.ArgumentParser(
 			description='Helps writing and running KUnit tests.')
 	subparser = parser.add_subparsers(dest='subcommand')
@@ -99,13 +108,24 @@ def main(argv, linux):
 				'directory.',
 				type=str, default=None, metavar='build_dir')
 
+	run_parser.add_argument('--defconfig',
+				help='Uses a default kunitconfig.',
+				action='store_true')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if cli_args.defconfig:
+			create_default_kunitconfig()
+
+		if not linux:
+			linux = kunit_kernel.LinuxSourceTree()
+
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
 				       cli_args.jobs,
-				       cli_args.build_dir)
+				       cli_args.build_dir,
+				       cli_args.defconfig)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
@@ -113,4 +133,4 @@ def main(argv, linux):
 		parser.print_help()
 
 if __name__ == '__main__':
-	main(sys.argv[1:], kunit_kernel.LinuxSourceTree())
+	main(sys.argv[1:])
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 07c0abf2f47d..bf3876835331 100644
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
2.23.0.351.gc4317032e6-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
