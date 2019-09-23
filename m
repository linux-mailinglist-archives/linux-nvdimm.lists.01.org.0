Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C7BB050
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Sep 2019 11:03:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 91559202EF294;
	Mon, 23 Sep 2019 02:05:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com;
 envelope-from=3v4qixq4kdiafvirherlmkkmrwksskpi.gsqpmry1-rzhmqqpmwxw.45.svk@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F02DF202ECFC3
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 02:05:51 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p15so8232076plq.4
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=jTA+bk9ZymR7w9FA5GVlXgp3DFkWG3VqdQfYnO3OtT4=;
 b=HzT/wz4SoEap1VJBZzBroY9I9l7BfAws+lWLhj3ak3eT2nV8x2xtW4HkzjZrYAl/UT
 B3CEuWuv33gJJRnUBWFS4HUBN6HTDd0V7JxAF3EmiWeycM0EwhidgH9Kd+YeqAooprZw
 3Ys5EpPRQbjf6o/qr5GTPP8i3QHMGAVAf++dQtu7TTDX/VG5SSpfnVsGtGG9nrmp5bwv
 /c5WEsAjR6AEUE+swJoernNjSH1hvyu1mOr/fcCKywolOClGzzF9t/KnRYzNYBjX4r+q
 j3eXPKt2u8+UUy7A1y0ajjZM9SlFCi4iGGRAfei5e1PxIbVVIHAja1w8pLtc6SYMRDBZ
 cf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jTA+bk9ZymR7w9FA5GVlXgp3DFkWG3VqdQfYnO3OtT4=;
 b=tsoplQ5dd/Vxjd3I+ddA5ORf9g8QD8M6yVpAz0alYhwekiGNrWWl0MdtAx2sD2WxH+
 PBP3PqCXRhZdkWLdBiUh9E1Q0jG4+EAgriasecH1ROdR6qbsP/ShrQaSNbElc6Ey1a4f
 UjuAZn+x+v1bROOV3zYNMdoI+vK9gglS8bXvV1kloavFCj2BABp86Lg79AutCoMGyVkw
 E3U0228BTHyDhck8PPIVpt7ZLYIFgILHN/R3mbtcRkQdkuWoONigFKq1YzSPSzc6N4gm
 Dii+YsiedWwyKryYTFUkWUmqugbsyFdy7iWf3OFgcw+/yuSsNnOh1QSerKuY9LakU+nL
 vR1Q==
X-Gm-Message-State: APjAAAV5HmG7WFLxGdDS6z8yHDIZOjleq8S1XCvJkQD0wFdJbgViZ7zK
 BLN8PBee2u45RwwH+IKzLn7HNV6bjpmiE+a28giA5A==
X-Google-Smtp-Source: APXvYqyFKRsdtx0KUWCbDpyTywKUKlMhLoCdw6SwcyE3RsaYT9vYz+SvM7Kt8aLepmdB42QaTTUmPtKVT1IfHZyQnVahDA==
X-Received: by 2002:a63:31c6:: with SMTP id
 x189mr28099653pgx.240.1569229399227; 
 Mon, 23 Sep 2019 02:03:19 -0700 (PDT)
Date: Mon, 23 Sep 2019 02:02:39 -0700
In-Reply-To: <20190923090249.127984-1-brendanhiggins@google.com>
Message-Id: <20190923090249.127984-10-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v18 09/19] kunit: test: add support for test abort
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

Add support for aborting/bailing out of test cases, which is needed for
implementing assertions.

An assertion is like an expectation, but bails out of the test case
early if the assertion is not met. The idea with assertions is that you
use them to state all the preconditions for your test. Logically
speaking, these are the premises of the test case, so if a premise isn't
true, there is no point in continuing the test case because there are no
conclusions that can be drawn without the premises. Whereas, the
expectation is the thing you are trying to prove.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/test.h      |   2 +
 include/kunit/try-catch.h |  75 +++++++++++++++++++++
 lib/kunit/Makefile        |   3 +-
 lib/kunit/test.c          | 137 +++++++++++++++++++++++++++++++++-----
 lib/kunit/try-catch.c     | 118 ++++++++++++++++++++++++++++++++
 5 files changed, 319 insertions(+), 16 deletions(-)
 create mode 100644 include/kunit/try-catch.h
 create mode 100644 lib/kunit/try-catch.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 30a62de16bc9..3d554d7c1c79 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -10,6 +10,7 @@
 #define _KUNIT_TEST_H
 
 #include <kunit/assert.h>
+#include <kunit/try-catch.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -172,6 +173,7 @@ struct kunit {
 
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
+	struct kunit_try_catch try_catch;
 	/*
 	 * success starts as true, and may only be set to false during a
 	 * test case; thus, it is safe to update this across multiple
diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
new file mode 100644
index 000000000000..404f336cbdc8
--- /dev/null
+++ b/include/kunit/try-catch.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * An API to allow a function, that may fail, to be executed, and recover in a
+ * controlled manner.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TRY_CATCH_H
+#define _KUNIT_TRY_CATCH_H
+
+#include <linux/types.h>
+
+typedef void (*kunit_try_catch_func_t)(void *);
+
+struct completion;
+struct kunit;
+
+/**
+ * struct kunit_try_catch - provides a generic way to run code which might fail.
+ * @test: The test case that is currently being executed.
+ * @try_completion: Completion that the control thread waits on while test runs.
+ * @try_result: Contains any errno obtained while running test case.
+ * @try: The function, the test case, to attempt to run.
+ * @catch: The function called if @try bails out.
+ * @context: used to pass user data to the try and catch functions.
+ *
+ * kunit_try_catch provides a generic, architecture independent way to execute
+ * an arbitrary function of type kunit_try_catch_func_t which may bail out by
+ * calling kunit_try_catch_throw(). If kunit_try_catch_throw() is called, @try
+ * is stopped at the site of invocation and @catch is called.
+ *
+ * struct kunit_try_catch provides a generic interface for the functionality
+ * needed to implement kunit->abort() which in turn is needed for implementing
+ * assertions. Assertions allow stating a precondition for a test simplifying
+ * how test cases are written and presented.
+ *
+ * Assertions are like expectations, except they abort (call
+ * kunit_try_catch_throw()) when the specified condition is not met. This is
+ * useful when you look at a test case as a logical statement about some piece
+ * of code, where assertions are the premises for the test case, and the
+ * conclusion is a set of predicates, rather expectations, that must all be
+ * true. If your premises are violated, it does not makes sense to continue.
+ */
+struct kunit_try_catch {
+	/* private: internal use only. */
+	struct kunit *test;
+	struct completion *try_completion;
+	int try_result;
+	kunit_try_catch_func_t try;
+	kunit_try_catch_func_t catch;
+	void *context;
+};
+
+void kunit_try_catch_init(struct kunit_try_catch *try_catch,
+			  struct kunit *test,
+			  kunit_try_catch_func_t try,
+			  kunit_try_catch_func_t catch);
+
+void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context);
+
+void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch);
+
+static inline int kunit_try_catch_get_result(struct kunit_try_catch *try_catch)
+{
+	return try_catch->try_result;
+}
+
+/*
+ * Exposed for testing only.
+ */
+void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch);
+
+#endif /* _KUNIT_TRY_CATCH_H */
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 4e46450bcb3a..c9176c9c578c 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
 					string-stream.o \
-					assert.o
+					assert.o \
+					try-catch.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3cbceb34b3b3..b2ca9b94c353 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -7,7 +7,9 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/try-catch.h>
 #include <linux/kernel.h>
+#include <linux/sched/debug.h>
 
 static void kunit_set_failure(struct kunit *test)
 {
@@ -162,6 +164,19 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
 	WARN_ON(string_stream_destroy(stream));
 }
 
+static void __noreturn kunit_abort(struct kunit *test)
+{
+	kunit_try_catch_throw(&test->try_catch); /* Does not return. */
+
+	/*
+	 * Throw could not abort from test.
+	 *
+	 * XXX: we should never reach this line! As kunit_try_catch_throw is
+	 * marked __noreturn.
+	 */
+	WARN_ONCE(true, "Throw could not abort from test!\n");
+}
+
 void kunit_do_assertion(struct kunit *test,
 			struct kunit_assert *assert,
 			bool pass,
@@ -180,6 +195,9 @@ void kunit_do_assertion(struct kunit *test,
 	kunit_fail(test, assert);
 
 	va_end(args);
+
+	if (assert->type == KUNIT_ASSERTION)
+		kunit_abort(test);
 }
 
 void kunit_init_test(struct kunit *test, const char *name)
@@ -191,33 +209,122 @@ void kunit_init_test(struct kunit *test, const char *name)
 }
 
 /*
- * Performs all logic to run a test case.
+ * Initializes and runs test case. Does not clean up or do post validations.
  */
-static void kunit_run_case(struct kunit_suite *suite,
-			   struct kunit_case *test_case)
+static void kunit_run_case_internal(struct kunit *test,
+				    struct kunit_suite *suite,
+				    struct kunit_case *test_case)
 {
-	struct kunit test;
-
-	kunit_init_test(&test, test_case->name);
-
 	if (suite->init) {
 		int ret;
 
-		ret = suite->init(&test);
+		ret = suite->init(test);
 		if (ret) {
-			kunit_err(&test, "failed to initialize: %d\n", ret);
-			kunit_set_failure(&test);
-			test_case->success = test.success;
+			kunit_err(test, "failed to initialize: %d\n", ret);
+			kunit_set_failure(test);
 			return;
 		}
 	}
 
-	test_case->run_case(&test);
+	test_case->run_case(test);
+}
 
+static void kunit_case_internal_cleanup(struct kunit *test)
+{
+	kunit_cleanup(test);
+}
+
+/*
+ * Performs post validations and cleanup after a test case was run.
+ * XXX: Should ONLY BE CALLED AFTER kunit_run_case_internal!
+ */
+static void kunit_run_case_cleanup(struct kunit *test,
+				   struct kunit_suite *suite)
+{
 	if (suite->exit)
-		suite->exit(&test);
+		suite->exit(test);
+
+	kunit_case_internal_cleanup(test);
+}
+
+struct kunit_try_catch_context {
+	struct kunit *test;
+	struct kunit_suite *suite;
+	struct kunit_case *test_case;
+};
+
+static void kunit_try_run_case(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	struct kunit_suite *suite = ctx->suite;
+	struct kunit_case *test_case = ctx->test_case;
+
+	/*
+	 * kunit_run_case_internal may encounter a fatal error; if it does,
+	 * abort will be called, this thread will exit, and finally the parent
+	 * thread will resume control and handle any necessary clean up.
+	 */
+	kunit_run_case_internal(test, suite, test_case);
+	/* This line may never be reached. */
+	kunit_run_case_cleanup(test, suite);
+}
+
+static void kunit_catch_run_case(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	struct kunit_suite *suite = ctx->suite;
+	int try_exit_code = kunit_try_catch_get_result(&test->try_catch);
+
+	if (try_exit_code) {
+		kunit_set_failure(test);
+		/*
+		 * Test case could not finish, we have no idea what state it is
+		 * in, so don't do clean up.
+		 */
+		if (try_exit_code == -ETIMEDOUT) {
+			kunit_err(test, "test case timed out\n");
+		/*
+		 * Unknown internal error occurred preventing test case from
+		 * running, so there is nothing to clean up.
+		 */
+		} else {
+			kunit_err(test, "internal error occurred preventing test case from running: %d\n",
+				  try_exit_code);
+		}
+		return;
+	}
+
+	/*
+	 * Test case was run, but aborted. It is the test case's business as to
+	 * whether it failed or not, we just need to clean up.
+	 */
+	kunit_run_case_cleanup(test, suite);
+}
+
+/*
+ * Performs all logic to run a test case. It also catches most errors that
+ * occur in a test case and reports them as failures.
+ */
+static void kunit_run_case_catch_errors(struct kunit_suite *suite,
+					struct kunit_case *test_case)
+{
+	struct kunit_try_catch_context context;
+	struct kunit_try_catch *try_catch;
+	struct kunit test;
+
+	kunit_init_test(&test, test_case->name);
+	try_catch = &test.try_catch;
 
-	kunit_cleanup(&test);
+	kunit_try_catch_init(try_catch,
+			     &test,
+			     kunit_try_run_case,
+			     kunit_catch_run_case);
+	context.test = &test;
+	context.suite = suite;
+	context.test_case = test_case;
+	kunit_try_catch_run(try_catch, &context);
 
 	test_case->success = test.success;
 }
@@ -230,7 +337,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 	kunit_print_subtest_start(suite);
 
 	for (test_case = suite->test_cases; test_case->run_case; test_case++) {
-		kunit_run_case(suite, test_case);
+		kunit_run_case_catch_errors(suite, test_case);
 		kunit_print_test_case_ok_not_ok(test_case, test_case_count++);
 	}
 
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
new file mode 100644
index 000000000000..55686839eb61
--- /dev/null
+++ b/lib/kunit/try-catch.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An API to allow a function, that may fail, to be executed, and recover in a
+ * controlled manner.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/try-catch.h>
+#include <linux/completion.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/sched/sysctl.h>
+
+void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
+{
+	try_catch->try_result = -EFAULT;
+	complete_and_exit(try_catch->try_completion, -EFAULT);
+}
+
+static int kunit_generic_run_threadfn_adapter(void *data)
+{
+	struct kunit_try_catch *try_catch = data;
+
+	try_catch->try(try_catch->context);
+
+	complete_and_exit(try_catch->try_completion, 0);
+}
+
+static unsigned long kunit_test_timeout(void)
+{
+	unsigned long timeout_msecs;
+
+	/*
+	 * TODO(brendanhiggins@google.com): We should probably have some type of
+	 * variable timeout here. The only question is what that timeout value
+	 * should be.
+	 *
+	 * The intention has always been, at some point, to be able to label
+	 * tests with some type of size bucket (unit/small, integration/medium,
+	 * large/system/end-to-end, etc), where each size bucket would get a
+	 * default timeout value kind of like what Bazel does:
+	 * https://docs.bazel.build/versions/master/be/common-definitions.html#test.size
+	 * There is still some debate to be had on exactly how we do this. (For
+	 * one, we probably want to have some sort of test runner level
+	 * timeout.)
+	 *
+	 * For more background on this topic, see:
+	 * https://mike-bland.com/2011/11/01/small-medium-large.html
+	 */
+	if (sysctl_hung_task_timeout_secs) {
+		/*
+		 * If sysctl_hung_task is active, just set the timeout to some
+		 * value less than that.
+		 *
+		 * In regards to the above TODO, if we decide on variable
+		 * timeouts, this logic will likely need to change.
+		 */
+		timeout_msecs = (sysctl_hung_task_timeout_secs - 1) *
+				MSEC_PER_SEC;
+	} else {
+		timeout_msecs = 300 * MSEC_PER_SEC; /* 5 min */
+	}
+
+	return timeout_msecs;
+}
+
+void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
+{
+	DECLARE_COMPLETION_ONSTACK(try_completion);
+	struct kunit *test = try_catch->test;
+	struct task_struct *task_struct;
+	int exit_code, time_remaining;
+
+	try_catch->context = context;
+	try_catch->try_completion = &try_completion;
+	try_catch->try_result = 0;
+	task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
+				  try_catch,
+				  "kunit_try_catch_thread");
+	if (IS_ERR(task_struct)) {
+		try_catch->catch(try_catch->context);
+		return;
+	}
+
+	time_remaining = wait_for_completion_timeout(&try_completion,
+						     kunit_test_timeout());
+	if (time_remaining == 0) {
+		kunit_err(test, "try timed out\n");
+		try_catch->try_result = -ETIMEDOUT;
+	}
+
+	exit_code = try_catch->try_result;
+
+	if (!exit_code)
+		return;
+
+	if (exit_code == -EFAULT)
+		try_catch->try_result = 0;
+	else if (exit_code == -EINTR)
+		kunit_err(test, "wake_up_process() was never called\n");
+	else if (exit_code)
+		kunit_err(test, "Unknown error: %d\n", exit_code);
+
+	try_catch->catch(try_catch->context);
+}
+
+void kunit_try_catch_init(struct kunit_try_catch *try_catch,
+			  struct kunit *test,
+			  kunit_try_catch_func_t try,
+			  kunit_try_catch_func_t catch)
+{
+	try_catch->test = test;
+	try_catch->try = try;
+	try_catch->catch = catch;
+}
-- 
2.23.0.351.gc4317032e6-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
