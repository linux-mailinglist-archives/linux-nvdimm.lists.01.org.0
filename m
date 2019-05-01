Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B812910FCB
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 01:04:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 96B2C21B02822;
	Wed,  1 May 2019 16:04:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com;
 envelope-from=3-sxkxa4kdfo3j6f52f9a88afk8gg8d6.4gedafmp-fn5aeedaklk.st.gj8@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 30559212377E6
 for <linux-nvdimm@lists.01.org>; Wed,  1 May 2019 16:04:26 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id s26so196118pfm.18
 for <linux-nvdimm@lists.01.org>; Wed, 01 May 2019 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=+G7LPM+i6NmkVoLbCU7sAmRt474gzlRI9LU6GUnDedQ=;
 b=uzPCjNqZ93NeuPZv1xpyKr2I02dQc9jXSsfzeRE9d/VVIp/KCqGRtPOuQRczZOqBBy
 KiP0Jy16kw2cRjZ6q7g+FeMc92Wd2TQJatyA3GeaZ43pwFhVKKyPeEfwzNjUVFB1OwTT
 agFWxKDeW5uLx19DJdgcnZ4Y7WL7qraikxIcYSHrBt48BZQb9XBvWHjAkQ+HZ3MhaW26
 TMbwN4V6UA52307leg95t5nPs2bB2AiVWTvE7NcOI+LNeFGFRd2a02pQt53fgw7rDKMX
 /ZNZzs/kjy3pQoqX3aX1uFENj83rL1Cnr94qmhaM2bj/vEkOD4mivJEc+5p3TCaKvqIV
 uzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=+G7LPM+i6NmkVoLbCU7sAmRt474gzlRI9LU6GUnDedQ=;
 b=OSbQmg/Q90NUeAp8wuOqNGO2T+Y9hm4WoWrxPmSHDZ1RyC7A5VQtHhkPnET7HLARjW
 hu7W8v3FttMiqCODIkTCxbeS7eVKW0bBC+bf/HExK4CSSfjwsNPkNyrL4lq5fEviHKe8
 3Mv2eCJ9LOfg3/OXrEMP7yOrvOwbVOaHCoKk2LaGl69uC3cDOj5dLW0R5QL4jTMryThe
 yGaQe2uAE9RM4Kum1LsEZ5+5L9BFa7SZYAq7VfYBfMwhJV+jKP02gfeZ5P1cFXQHR1LZ
 6I/Aw9iBTN5yodMI6aVjYCHW+OrDVP1enOm5e5xYFS/rFVAA3967nlgH3UyqWcmvpEZr
 Q9TQ==
X-Gm-Message-State: APjAAAV83/oJT4XqccLz3vpA1Nx7Y/uR57lzbzWlQ1Ir7zzWZflr8OYz
 miC+wCm1Ivto86gjZ04KI4B8oG6gcO9IFowYCoaNjg==
X-Google-Smtp-Source: APXvYqxsjU1jFWzO3KypwMN2P1uX9t76vdHAoPQyTHx1Ml5WxKjLGQPFdzuPJIDtR+IZMzabIuwjhDfLR7kIiw0TlZZr+w==
X-Received: by 2002:a63:30c5:: with SMTP id w188mr617139pgw.76.1556751865309; 
 Wed, 01 May 2019 16:04:25 -0700 (PDT)
Date: Wed,  1 May 2019 16:01:19 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 10/17] kunit: test: add the concept of assertions
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

Add support for assertions which are like expectations except the test
terminates if the assertion is not satisfied.

The idea with assertions is that you use them to state all the
preconditions for your test. Logically speaking, these are the premises
of the test case, so if a premise isn't true, there is no point in
continuing the test case because there are no conclusions that can be
drawn without the premises. Whereas, the expectation is the thing you
are trying to prove. It is not used universally in x-unit style test
frameworks, but I really like it as a convention.  You could still
express the idea of a premise using the above idiom, but I think
KUNIT_ASSERT_* states the intended idea perfectly.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h       | 401 ++++++++++++++++++++++++++++++++++++-
 kunit/string-stream-test.c |  12 +-
 kunit/test-test.c          |   2 +
 kunit/test.c               |  33 +++
 4 files changed, 439 insertions(+), 9 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 1b77caeb5d51f..bb2f3e63a3522 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -85,9 +85,10 @@ struct kunit;
  * @name: the name of the test case.
  *
  * A test case is a function with the signature, ``void (*)(struct kunit *)``
- * that makes expectations (see KUNIT_EXPECT_TRUE()) about code under test. Each
- * test case is associated with a &struct kunit_module and will be run after the
- * module's init function and followed by the module's exit function.
+ * that makes expectations and assertions (see KUNIT_EXPECT_TRUE() and
+ * KUNIT_ASSERT_TRUE()) about code under test. Each test case is associated with
+ * a &struct kunit_module and will be run after the module's init function and
+ * followed by the module's exit function.
  *
  * A test case should be static and should only be created with the KUNIT_CASE()
  * macro; additionally, every array of test cases should be terminated with an
@@ -705,4 +706,398 @@ static inline void kunit_expect_binary(struct kunit *test,
 	KUNIT_EXPECT_END(test, !IS_ERR_OR_NULL(__ptr), __stream);	       \
 } while (0)
 
+static inline struct kunit_stream *kunit_assert_start(struct kunit *test,
+						      const char *file,
+						      const char *line)
+{
+	struct kunit_stream *stream = kunit_new_stream(test);
+
+	kunit_stream_add(stream, "ASSERTION FAILED at %s:%s\n\t", file, line);
+
+	return stream;
+}
+
+static inline void kunit_assert_end(struct kunit *test,
+				    bool success,
+				    struct kunit_stream *stream)
+{
+	if (!success) {
+		test->fail(test, stream);
+		test->abort(test);
+	} else {
+		kunit_stream_clear(stream);
+	}
+}
+
+#define KUNIT_ASSERT_START(test) \
+		kunit_assert_start(test, __FILE__, __stringify(__LINE__))
+
+#define KUNIT_ASSERT_END(test, success, stream) \
+		kunit_assert_end(test, success, stream)
+
+#define KUNIT_ASSERT(test, success, message) do {			       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+									       \
+	kunit_stream_add(__stream, message);				       \
+	KUNIT_ASSERT_END(test, success, __stream);			       \
+} while (0)
+
+#define KUNIT_ASSERT_MSG(test, success, message, fmt, ...) do {		       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+									       \
+	kunit_stream_add(__stream, message);				       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+	KUNIT_ASSERT_END(test, success, __stream);			       \
+} while (0)
+
+#define KUNIT_ASSERT_FAILURE(test, fmt, ...) do {			       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+									       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+	KUNIT_ASSERT_END(test, false, __stream);			       \
+} while (0)
+
+/**
+ * KUNIT_ASSERT_TRUE() - Sets an assertion that @condition is true.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails and aborts when
+ * this does not evaluate to true.
+ *
+ * This and assertions of the form `KUNIT_ASSERT_*` will cause the test case to
+ * fail *and immediately abort* when the specified condition is not met. Unlike
+ * an expectation failure, it will prevent the test case from continuing to run;
+ * this is otherwise known as an *assertion failure*.
+ */
+#define KUNIT_ASSERT_TRUE(test, condition)				       \
+		KUNIT_ASSERT(test, (condition),				       \
+			     "Asserted " #condition " is true, but is false.\n")
+
+#define KUNIT_ASSERT_TRUE_MSG(test, condition, fmt, ...)		       \
+		KUNIT_ASSERT_MSG(test, (condition),			       \
+				 "Asserted " #condition " is true, but is false.\n",\
+				 fmt, ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_FALSE() - Sets an assertion that @condition is false.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression.
+ *
+ * Sets an assertion that the value that @condition evaluates to is false. This
+ * is the same as KUNIT_EXPECT_FALSE(), except it causes an assertion failure
+ * (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_FALSE(test, condition)				       \
+		KUNIT_ASSERT(test, !(condition),			       \
+			     "Asserted " #condition " is false, but is true.\n")
+
+#define KUNIT_ASSERT_FALSE_MSG(test, condition, fmt, ...)		       \
+		KUNIT_ASSERT_MSG(test, !(condition),			       \
+				 "Asserted " #condition " is false, but is true.\n",\
+				 fmt, ##__VA_ARGS__)
+
+void kunit_assert_binary_msg(struct kunit *test,
+			     long long left, const char *left_name,
+			     long long right, const char *right_name,
+			     bool compare_result,
+			     const char *compare_name,
+			     const char *file,
+			     const char *line,
+			     const char *fmt, ...);
+
+static inline void kunit_assert_binary(struct kunit *test,
+				       long long left, const char *left_name,
+				       long long right, const char *right_name,
+				       bool compare_result,
+				       const char *compare_name,
+				       const char *file,
+				       const char *line)
+{
+	kunit_assert_binary_msg(test,
+				left, left_name,
+				right, right_name,
+				compare_result,
+				compare_name,
+				file,
+				line,
+				NULL);
+}
+
+/*
+ * A factory macro for defining the expectations for the basic comparisons
+ * defined for the built in types.
+ *
+ * Unfortunately, there is no common type that all types can be promoted to for
+ * which all the binary operators behave the same way as for the actual types
+ * (for example, there is no type that long long and unsigned long long can
+ * both be cast to where the comparison result is preserved for all values). So
+ * the best we can do is do the comparison in the original types and then coerce
+ * everything to long long for printing; this way, the comparison behaves
+ * correctly and the printed out value usually makes sense without
+ * interpretation, but can always be interpretted to figure out the actual
+ * value.
+ */
+#define KUNIT_ASSERT_BINARY(test, left, condition, right) do {		       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	kunit_assert_binary(test,					       \
+			    (long long) __left, #left,			       \
+			    (long long) __right, #right,		       \
+			    __left condition __right, #condition,	       \
+			    __FILE__, __stringify(__LINE__));		       \
+} while (0)
+
+#define KUNIT_ASSERT_BINARY_MSG(test, left, condition, right, fmt, ...) do {   \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	kunit_assert_binary_msg(test,					       \
+				(long long) __left, #left,		       \
+				(long long) __right, #right,		       \
+				__left condition __right, #condition,	       \
+				__FILE__, __stringify(__LINE__),	       \
+				fmt, ##__VA_ARGS__);			       \
+} while (0)
+
+/**
+ * KUNIT_ASSERT_EQ() - Sets an assertion that @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * equal. This is the same as KUNIT_EXPECT_EQ(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_EQ(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, ==, right)
+
+#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					==,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are not
+ * equal. This is the same as KUNIT_EXPECT_NE(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NE(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, !=, right)
+
+#define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					!=,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_LT() - An assertion that @left is less than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is less than the
+ * value that @right evaluates to. This is the same as KUNIT_EXPECT_LT(), except
+ * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
+ * is not met.
+ */
+#define KUNIT_ASSERT_LT(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, <, right)
+
+#define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					<,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+/**
+ * KUNIT_ASSERT_LE() - An assertion that @left is less than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is less than or
+ * equal to the value that @right evaluates to. This is the same as
+ * KUNIT_EXPECT_LE(), except it causes an assertion failure (see
+ * KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_LE(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, <=, right)
+
+#define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					<=,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+/**
+ * KUNIT_ASSERT_GT() - An assertion that @left is greater than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is greater than the
+ * value that @right evaluates to. This is the same as KUNIT_EXPECT_GT(), except
+ * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
+ * is not met.
+ */
+#define KUNIT_ASSERT_GT(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, >, right)
+
+#define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					>,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_GE() - Assertion that @left is greater than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is greater than the
+ * value that @right evaluates to. This is the same as KUNIT_EXPECT_GE(), except
+ * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
+ * is not met.
+ */
+#define KUNIT_ASSERT_GE(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, >=, right)
+
+#define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					>=,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_STREQ() - An assertion that strings @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * equal. This is the same as KUNIT_EXPECT_STREQ(), except it causes an
+ * assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_STREQ(test, left, right) do {			       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Asserted " #left " == " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+									       \
+	KUNIT_ASSERT_END(test, !strcmp(left, right), __stream);		       \
+} while (0)
+
+#define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...) do {	       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Asserted " #left " == " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+									       \
+	KUNIT_ASSERT_END(test, !strcmp(left, right), __stream);		       \
+} while (0)
+
+/**
+ * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * not equal. This is semantically equivalent to
+ * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
+ * for more information.
+ */
+#define KUNIT_ASSERT_STRNEQ(test, left, right) do {			       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Asserted " #left " == " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+									       \
+	KUNIT_ASSERT_END(test, strcmp(left, right), __stream);		       \
+} while (0)
+
+#define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...) do {	       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Asserted " #left " == " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+									       \
+	KUNIT_ASSERT_END(test, strcmp(left, right), __stream);		       \
+} while (0)
+
+/**
+ * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an assertion that the value that @ptr evaluates to is not null and not
+ * an errno stored in a pointer. This is the same as
+ * KUNIT_EXPECT_NOT_ERR_OR_NULL(), except it causes an assertion failure (see
+ * KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr) do {			       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(ptr) __ptr = (ptr);					       \
+									       \
+	if (!__ptr)							       \
+		kunit_stream_add(__stream,				       \
+				 "Asserted " #ptr " is not null, but is.\n");  \
+	if (IS_ERR(__ptr))						       \
+		kunit_stream_add(__stream,				       \
+				 "Asserted " #ptr " is not error, but is: %ld\n",\
+				 PTR_ERR(__ptr));			       \
+									       \
+	KUNIT_ASSERT_END(test, !IS_ERR_OR_NULL(__ptr), __stream);	       \
+} while (0)
+
+#define KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...) do {	       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(ptr) __ptr = (ptr);					       \
+									       \
+	if (!__ptr) {							       \
+		kunit_stream_add(__stream,				       \
+				 "Asserted " #ptr " is not null, but is.\n");  \
+		kunit_stream_add(__stream, fmt, ##__VA_ARGS__);		       \
+	}								       \
+	if (IS_ERR(__ptr)) {						       \
+		kunit_stream_add(__stream,				       \
+				 "Asserted " #ptr " is not error, but is: %ld\n",\
+				 PTR_ERR(__ptr));			       \
+									       \
+		kunit_stream_add(__stream, fmt, ##__VA_ARGS__);		       \
+	}								       \
+	KUNIT_ASSERT_END(test, !IS_ERR_OR_NULL(__ptr), __stream);	       \
+} while (0)
+
 #endif /* _KUNIT_TEST_H */
diff --git a/kunit/string-stream-test.c b/kunit/string-stream-test.c
index b2a98576797c9..96819b99b5713 100644
--- a/kunit/string-stream-test.c
+++ b/kunit/string-stream-test.c
@@ -19,7 +19,7 @@ static void string_stream_test_get_string(struct kunit *test)
 	string_stream_add(stream, " %s", "bar");
 
 	output = string_stream_get_string(stream);
-	KUNIT_EXPECT_STREQ(test, output, "Foo bar");
+	KUNIT_ASSERT_STREQ(test, output, "Foo bar");
 	kfree(output);
 	destroy_string_stream(stream);
 }
@@ -34,16 +34,16 @@ static void string_stream_test_add_and_clear(struct kunit *test)
 		string_stream_add(stream, "A");
 
 	output = string_stream_get_string(stream);
-	KUNIT_EXPECT_STREQ(test, output, "AAAAAAAAAA");
-	KUNIT_EXPECT_EQ(test, stream->length, 10);
-	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
+	KUNIT_ASSERT_STREQ(test, output, "AAAAAAAAAA");
+	KUNIT_ASSERT_EQ(test, stream->length, 10);
+	KUNIT_ASSERT_FALSE(test, string_stream_is_empty(stream));
 	kfree(output);
 
 	string_stream_clear(stream);
 
 	output = string_stream_get_string(stream);
-	KUNIT_EXPECT_STREQ(test, output, "");
-	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+	KUNIT_ASSERT_STREQ(test, output, "");
+	KUNIT_ASSERT_TRUE(test, string_stream_is_empty(stream));
 	destroy_string_stream(stream);
 }
 
diff --git a/kunit/test-test.c b/kunit/test-test.c
index c81ae6efb959f..4bd7a34d0a6cb 100644
--- a/kunit/test-test.c
+++ b/kunit/test-test.c
@@ -110,11 +110,13 @@ static int kunit_try_catch_test_init(struct kunit *test)
 	struct kunit_try_catch_test_context *ctx;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 	test->priv = ctx;
 
 	ctx->try_catch = kunit_kmalloc(test,
 				       sizeof(*ctx->try_catch),
 				       GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->try_catch);
 
 	return 0;
 }
diff --git a/kunit/test.c b/kunit/test.c
index 5eace2a527a4e..55561eadc459d 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -425,3 +425,36 @@ void kunit_expect_binary_msg(struct kunit *test,
 	kunit_expect_end(test, compare_result, stream);
 }
 
+void kunit_assert_binary_msg(struct kunit *test,
+			     long long left, const char *left_name,
+			     long long right, const char *right_name,
+			     bool compare_result,
+			     const char *compare_name,
+			     const char *file,
+			     const char *line,
+			     const char *fmt, ...)
+{
+	struct kunit_stream *stream = kunit_assert_start(test, file, line);
+	struct va_format vaf;
+	va_list args;
+
+	kunit_stream_add(stream,
+			 "Asserted %s %s %s, but\n",
+			 left_name, compare_name, right_name);
+	kunit_stream_add(stream, "\t\t%s == %lld\n", left_name, left);
+	kunit_stream_add(stream, "\t\t%s == %lld\n", right_name, right);
+
+	if (fmt) {
+		va_start(args, fmt);
+
+		vaf.fmt = fmt;
+		vaf.va = &args;
+
+		kunit_stream_add(stream, "\n%pV", &vaf);
+
+		va_end(args);
+	}
+
+	kunit_assert_end(test, compare_result, stream);
+}
+
-- 
2.21.0.593.g511ec345e18-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
