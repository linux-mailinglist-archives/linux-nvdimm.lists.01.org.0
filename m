Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE23EB9AF8
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 01:53:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3942A21962301;
	Fri, 20 Sep 2019 16:52:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::d49; helo=mail-io1-xd49.google.com;
 envelope-from=3jv6fxq4kdfivby7xu7120027c08805y.w86527eh-7fx26652cdc.kl.8b0@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com
 [IPv6:2607:f8b0:4864:20::d49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ECD47202ECFD5
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 16:52:32 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id a22so9098928ioq.23
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 16:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=LlDxu00B0OzvuovDosveyIDw8KU4lJ2GOfkiYezINd8=;
 b=N26H16PeB92Pzl6lPp6nCfT+PilgL6qd85S4+vwAeEm5comxKddmbwGtBxoLj4T1+N
 T+lecaE+9ZZeldFL3k/DkhRxX8yMw97FJ6x92hwdekFFNniWW1TV5I6GbmogeZ4wfA5+
 sUgHP98H+KnzB2pLcRO0rLPv13vj0ttmDpASE8HJdss9c+my2i/GFEmz59rRn088VlUj
 LYylutT8CRHcSWwLlMZkQFhXEIP5lD9IVGgphY7eWfr93254WKcsCQz8wt6L5oKvqfRh
 7H0/ZibYNiEQ5Ps+hZu89r8VJsrEckOJvBqvxLO506mXaqFZkbbaMQ7q27GZQa3VYtFT
 ZTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=LlDxu00B0OzvuovDosveyIDw8KU4lJ2GOfkiYezINd8=;
 b=tI38eZ0QzzTj18St9+ntl645syOF1tM34ct/eWLxuTzQ38NYogtw5Y/Gxep/f2060O
 Oit/Fx6GQndFyvI8NR2ZGEUePi4xz0ByZhTs0HCrasMyiRMO/kHx7tH87WqtCcj2KNMm
 wBALdhn9DiviqikyI2pnyJ7WSksAYDAJObseJxNx/tpnkdSSV4R1uckZQuAfJtd2lwXC
 8Lt6hwOjEbXOvqa3s2MEhKA+cmFuII+IuwYXITH6sKxtFtWxkkcOwC9XREyBoHXo8ohC
 qgdIebtjEAsZM7oZNc8+Zad6j7mwoCMVy7NMfxLvLhPwPWFaUkcR7xRY4QgZr32xmBqU
 6NFQ==
X-Gm-Message-State: APjAAAV6sCEuhG6xKZ9fy8M7rfjovglRNK3UtF/4hQVuc5Ocjy/Ju6km
 QuVVaOOC9hWeYcw0zRLuRCezm2lOaKD5cp5ujzGhXQ==
X-Google-Smtp-Source: APXvYqxYpiSSezL4EG3ijvlKNO9++PDpIPGbhjXWKA9Xrb1cR6wNPpVZ0+z9/2xJ07dTCq1EyvkcGxiw+rsRAZg5Ek5ljA==
X-Received: by 2002:a63:d901:: with SMTP id r1mr17831768pgg.159.1569021581598; 
 Fri, 20 Sep 2019 16:19:41 -0700 (PDT)
Date: Fri, 20 Sep 2019 16:19:05 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 01/19] kunit: test: add KUnit test runner core
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

Add core facilities for defining unit tests; this provides a common way
to define test cases, functions that execute code which is under test
and determine whether the code under test behaves as expected; this also
provides a way to group together related test cases in test suites (here
we call them test_modules).

Just define test cases and how to execute them for now; setting
expectations on code will be defined later.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/test.h | 188 ++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/Kconfig    |  17 ++++
 lib/kunit/Makefile   |   1 +
 lib/kunit/test.c     | 191 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 397 insertions(+)
 create mode 100644 include/kunit/test.h
 create mode 100644 lib/kunit/Kconfig
 create mode 100644 lib/kunit/Makefile
 create mode 100644 lib/kunit/test.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
new file mode 100644
index 000000000000..e30d1bf2fb68
--- /dev/null
+++ b/include/kunit/test.h
@@ -0,0 +1,188 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TEST_H
+#define _KUNIT_TEST_H
+
+#include <linux/types.h>
+
+struct kunit;
+
+/**
+ * struct kunit_case - represents an individual test case.
+ *
+ * @run_case: the function representing the actual test case.
+ * @name:     the name of the test case.
+ *
+ * A test case is a function with the signature,
+ * ``void (*)(struct kunit *)`` that makes expectations (see
+ * KUNIT_EXPECT_TRUE()) about code under test. Each test case is associated
+ * with a &struct kunit_suite and will be run after the suite's init
+ * function and followed by the suite's exit function.
+ *
+ * A test case should be static and should only be created with the
+ * KUNIT_CASE() macro; additionally, every array of test cases should be
+ * terminated with an empty test case.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	void add_test_basic(struct kunit *test)
+ *	{
+ *		KUNIT_EXPECT_EQ(test, 1, add(1, 0));
+ *		KUNIT_EXPECT_EQ(test, 2, add(1, 1));
+ *		KUNIT_EXPECT_EQ(test, 0, add(-1, 1));
+ *		KUNIT_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
+ *		KUNIT_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
+ *	}
+ *
+ *	static struct kunit_case example_test_cases[] = {
+ *		KUNIT_CASE(add_test_basic),
+ *		{}
+ *	};
+ *
+ */
+struct kunit_case {
+	void (*run_case)(struct kunit *test);
+	const char *name;
+
+	/* private: internal use only. */
+	bool success;
+};
+
+/**
+ * KUNIT_CASE - A helper for creating a &struct kunit_case
+ *
+ * @test_name: a reference to a test case function.
+ *
+ * Takes a symbol for a function representing a test case and creates a
+ * &struct kunit_case object from it. See the documentation for
+ * &struct kunit_case for an example on how to use it.
+ */
+#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
+
+/**
+ * struct kunit_suite - describes a related collection of &struct kunit_case
+ *
+ * @name:	the name of the test. Purely informational.
+ * @init:	called before every test case.
+ * @exit:	called after every test case.
+ * @test_cases:	a null terminated array of test cases.
+ *
+ * A kunit_suite is a collection of related &struct kunit_case s, such that
+ * @init is called before every test case and @exit is called after every
+ * test case, similar to the notion of a *test fixture* or a *test class*
+ * in other unit testing frameworks like JUnit or Googletest.
+ *
+ * Every &struct kunit_case must be associated with a kunit_suite for KUnit
+ * to run it.
+ */
+struct kunit_suite {
+	const char name[256];
+	int (*init)(struct kunit *test);
+	void (*exit)(struct kunit *test);
+	struct kunit_case *test_cases;
+};
+
+/**
+ * struct kunit - represents a running instance of a test.
+ *
+ * @priv: for user to store arbitrary data. Commonly used to pass data
+ *	  created in the init function (see &struct kunit_suite).
+ *
+ * Used to store information about the current context under which the test
+ * is running. Most of this data is private and should only be accessed
+ * indirectly via public functions; the one exception is @priv which can be
+ * used by the test writer to store arbitrary data.
+ */
+struct kunit {
+	void *priv;
+
+	/* private: internal use only. */
+	const char *name; /* Read only after initialization! */
+	/*
+	 * success starts as true, and may only be set to false during a
+	 * test case; thus, it is safe to update this across multiple
+	 * threads using WRITE_ONCE; however, as a consequence, it may only
+	 * be read after the test case finishes once all threads associated
+	 * with the test case have terminated.
+	 */
+	bool success; /* Read only after test_case finishes! */
+};
+
+void kunit_init_test(struct kunit *test, const char *name);
+
+int kunit_run_tests(struct kunit_suite *suite);
+
+/**
+ * kunit_test_suite() - used to register a &struct kunit_suite with KUnit.
+ *
+ * @suite: a statically allocated &struct kunit_suite.
+ *
+ * Registers @suite with the test framework. See &struct kunit_suite for
+ * more information.
+ *
+ * NOTE: Currently KUnit tests are all run as late_initcalls; this means
+ * that they cannot test anything where tests must run at a different init
+ * phase. One significant restriction resulting from this is that KUnit
+ * cannot reliably test anything that is initialize in the late_init phase;
+ * another is that KUnit is useless to test things that need to be run in
+ * an earlier init phase.
+ *
+ * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
+ * late_initcalls.  I have some future work planned to dispatch all KUnit
+ * tests from the same place, and at the very least to do so after
+ * everything else is definitely initialized.
+ */
+#define kunit_test_suite(suite)						       \
+	static int kunit_suite_init##suite(void)			       \
+	{								       \
+		return kunit_run_tests(&suite);				       \
+	}								       \
+	late_initcall(kunit_suite_init##suite)
+
+void __printf(3, 4) kunit_printk(const char *level,
+				 const struct kunit *test,
+				 const char *fmt, ...);
+
+/**
+ * kunit_info() - Prints an INFO level message associated with @test.
+ *
+ * @test: The test context object.
+ * @fmt:  A printk() style format string.
+ *
+ * Prints an info level message associated with the test suite being run.
+ * Takes a variable number of format parameters just like printk().
+ */
+#define kunit_info(test, fmt, ...) \
+	kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
+
+/**
+ * kunit_warn() - Prints a WARN level message associated with @test.
+ *
+ * @test: The test context object.
+ * @fmt:  A printk() style format string.
+ *
+ * Prints a warning level message.
+ */
+#define kunit_warn(test, fmt, ...) \
+	kunit_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
+
+/**
+ * kunit_err() - Prints an ERROR level message associated with @test.
+ *
+ * @test: The test context object.
+ * @fmt:  A printk() style format string.
+ *
+ * Prints an error level message.
+ */
+#define kunit_err(test, fmt, ...) \
+	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
+
+#endif /* _KUNIT_TEST_H */
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
new file mode 100644
index 000000000000..330ae83527c2
--- /dev/null
+++ b/lib/kunit/Kconfig
@@ -0,0 +1,17 @@
+#
+# KUnit base configuration
+#
+
+menu "KUnit support"
+
+config KUNIT
+	bool "Enable support for unit tests (KUnit)"
+	help
+	  Enables support for kernel unit tests (KUnit), a lightweight unit
+	  testing and mocking framework for the Linux kernel. These tests are
+	  able to be run locally on a developer's workstation without a VM or
+	  special hardware when using UML. Can also be used on most other
+	  architectures. For more information, please see
+	  Documentation/dev-tools/kunit/.
+
+endmenu
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
new file mode 100644
index 000000000000..5efdc4dea2c0
--- /dev/null
+++ b/lib/kunit/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_KUNIT) +=			test.o
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
new file mode 100644
index 000000000000..d3dda359f99b
--- /dev/null
+++ b/lib/kunit/test.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/kernel.h>
+
+static void kunit_set_failure(struct kunit *test)
+{
+	WRITE_ONCE(test->success, false);
+}
+
+static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
+{
+	return vprintk_emit(0, level, NULL, 0, fmt, args);
+}
+
+static int kunit_printk_emit(int level, const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = kunit_vprintk_emit(level, fmt, args);
+	va_end(args);
+
+	return ret;
+}
+
+static void kunit_vprintk(const struct kunit *test,
+			  const char *level,
+			  struct va_format *vaf)
+{
+	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
+}
+
+static void kunit_print_tap_version(void)
+{
+	static bool kunit_has_printed_tap_version;
+
+	if (!kunit_has_printed_tap_version) {
+		kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
+		kunit_has_printed_tap_version = true;
+	}
+}
+
+static size_t kunit_test_cases_len(struct kunit_case *test_cases)
+{
+	struct kunit_case *test_case;
+	size_t len = 0;
+
+	for (test_case = test_cases; test_case->run_case; test_case++)
+		len++;
+
+	return len;
+}
+
+static void kunit_print_subtest_start(struct kunit_suite *suite)
+{
+	kunit_print_tap_version();
+	kunit_printk_emit(LOGLEVEL_INFO, "\t# Subtest: %s\n", suite->name);
+	kunit_printk_emit(LOGLEVEL_INFO,
+			  "\t1..%zd\n",
+			  kunit_test_cases_len(suite->test_cases));
+}
+
+static void kunit_print_ok_not_ok(bool should_indent,
+				  bool is_ok,
+				  size_t test_number,
+				  const char *description)
+{
+	const char *indent, *ok_not_ok;
+
+	if (should_indent)
+		indent = "\t";
+	else
+		indent = "";
+
+	if (is_ok)
+		ok_not_ok = "ok";
+	else
+		ok_not_ok = "not ok";
+
+	kunit_printk_emit(LOGLEVEL_INFO,
+			  "%s%s %zd - %s\n",
+			  indent, ok_not_ok, test_number, description);
+}
+
+static bool kunit_suite_has_succeeded(struct kunit_suite *suite)
+{
+	const struct kunit_case *test_case;
+
+	for (test_case = suite->test_cases; test_case->run_case; test_case++)
+		if (!test_case->success)
+			return false;
+
+	return true;
+}
+
+static void kunit_print_subtest_end(struct kunit_suite *suite)
+{
+	static size_t kunit_suite_counter = 1;
+
+	kunit_print_ok_not_ok(false,
+			      kunit_suite_has_succeeded(suite),
+			      kunit_suite_counter++,
+			      suite->name);
+}
+
+static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
+					    size_t test_number)
+{
+	kunit_print_ok_not_ok(true,
+			      test_case->success,
+			      test_number,
+			      test_case->name);
+}
+
+void kunit_init_test(struct kunit *test, const char *name)
+{
+	test->name = name;
+	test->success = true;
+}
+
+/*
+ * Performs all logic to run a test case.
+ */
+static void kunit_run_case(struct kunit_suite *suite,
+			   struct kunit_case *test_case)
+{
+	struct kunit test;
+
+	kunit_init_test(&test, test_case->name);
+
+	if (suite->init) {
+		int ret;
+
+		ret = suite->init(&test);
+		if (ret) {
+			kunit_err(&test, "failed to initialize: %d\n", ret);
+			kunit_set_failure(&test);
+			test_case->success = test.success;
+			return;
+		}
+	}
+
+	test_case->run_case(&test);
+
+	if (suite->exit)
+		suite->exit(&test);
+
+	test_case->success = test.success;
+}
+
+int kunit_run_tests(struct kunit_suite *suite)
+{
+	struct kunit_case *test_case;
+	size_t test_case_count = 1;
+
+	kunit_print_subtest_start(suite);
+
+	for (test_case = suite->test_cases; test_case->run_case; test_case++) {
+		kunit_run_case(suite, test_case);
+		kunit_print_test_case_ok_not_ok(test_case, test_case_count++);
+	}
+
+	kunit_print_subtest_end(suite);
+
+	return 0;
+}
+
+void kunit_printk(const char *level,
+		  const struct kunit *test,
+		  const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	kunit_vprintk(test, level, &vaf);
+
+	va_end(args);
+}
-- 
2.23.0.351.gc4317032e6-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
