Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C267D9BA2B
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Aug 2019 03:34:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EB63720216B75;
	Fri, 23 Aug 2019 18:37:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::74a; helo=mail-qk1-x74a.google.com;
 envelope-from=3ozrgxq4kdnq1h4d30d78668di6ee6b4.2ecb8dkn-dl38ccb8iji.qr.eh6@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C061120216B65
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:37:28 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a197so10729359qkg.12
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=A/zQkhdJ0zgpEq6YjF9OuggkjVQiHOCCIQR7n9CDjDc=;
 b=hgdXPJ519Y7wIEG5MYmhF3Rn7JyDM33O3GeiJkqZiK0wlNJfh9yKgEjAWSsfZJyQE/
 b5Z6/vN7Nrwrelg2KoRAcJKUNc/MChTh0qvZK34qVwMcCmBDjzd+m9CWhYiAqXPRcS/h
 QgZBEdoVa8hfLKsqgyksSk2eGhn/OO+sLlxB7BqJSlxwR4KHaD1LMHe2PHc3cTEPtFxO
 gG3DDhrm9B/76870fcqEPal8eq8qRN9A4vPQB5Dk/OQytPxHZEKc9U4Co++eK9VzYQe8
 h58L+suR61Gcq8Hql9EKvySXAtu1LQHUQZ8ykNmVhChQkoEDLH2a9Y0VQvbF39HI9uYo
 8A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=A/zQkhdJ0zgpEq6YjF9OuggkjVQiHOCCIQR7n9CDjDc=;
 b=DiM4U8nU4FJIZZ7cdc16KEjSefPq28t6U3qUgk2W4GffwG1xlw0zgbUrAh9ewhDwki
 K9BUT8vBX3iaqthLWuI/4QOVfPQJmcl7THFzSW3/8RL2IzNTQMI4sgvK098udiQBiWap
 k1SK7Z4c5YLwX7PiVZMlpjp2o2maFG8qThQmlXq5I323y6jqMmj2jnqgc3ZOV5xTP8+Z
 LpZYXnAuOrl4is+TJXIPg0ZL68NurPKVrR+hqvhR0Saz8+UReylTMC31smbf0JSGohvT
 nNcCJRaQErNQocV5dSw8SQwq5iNYJMfO902VxZjQ4ZTwMbnNAvq6Tlg3PVS4lnFRc4xq
 vADA==
X-Gm-Message-State: APjAAAXU2cgycTmQ8kLk8OsFZRl+bYjMwDTGCrQOqD9dyvJ9gsG+UVlN
 AgFMe2HQGAcYUP9mPUOdemPWehJCYpqAYL9Na1APPA==
X-Google-Smtp-Source: APXvYqx/u2C34EMLa+YCakxpQfTuLq5lj1lqqCflGoJJSiVBgSMroTxZ/I6UZWA/Of+t6RivAD1Y3J2owCPoHMAl1GqW7Q==
X-Received: by 2002:ac8:764f:: with SMTP id i15mr7494832qtr.194.1566610489785; 
 Fri, 23 Aug 2019 18:34:49 -0700 (PDT)
Date: Fri, 23 Aug 2019 18:34:12 -0700
In-Reply-To: <20190824013425.175645-1-brendanhiggins@google.com>
Message-Id: <20190824013425.175645-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190824013425.175645-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v15 05/18] kunit: test: add the concept of expectations
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

Add support for expectations, which allow properties to be specified and
then verified in tests.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/test.h | 836 +++++++++++++++++++++++++++++++++++++++++++
 kunit/test.c         |  62 ++++
 2 files changed, 898 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 6781c756f11b..30a62de16bc9 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -9,6 +9,8 @@
 #ifndef _KUNIT_TEST_H
 #define _KUNIT_TEST_H
 
+#include <kunit/assert.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -372,4 +374,838 @@ void __printf(3, 4) kunit_printk(const char *level,
 #define kunit_err(test, fmt, ...) \
 	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
 
+/**
+ * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
+ * @test: The test context object.
+ *
+ * The opposite of KUNIT_FAIL(), it is an expectation that cannot fail. In other
+ * words, it does nothing and only exists for code clarity. See
+ * KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_SUCCEED(test) do {} while (0)
+
+void kunit_do_assertion(struct kunit *test,
+			struct kunit_assert *assert,
+			bool pass,
+			const char *fmt, ...);
+
+#define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
+	struct assert_class __assertion = INITIALIZER;			       \
+	kunit_do_assertion(test,					       \
+			   &__assertion.assert,				       \
+			   pass,					       \
+			   fmt,						       \
+			   ##__VA_ARGS__);				       \
+} while (0)
+
+
+#define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)		       \
+	KUNIT_ASSERTION(test,						       \
+			false,						       \
+			kunit_fail_assert,				       \
+			KUNIT_INIT_FAIL_ASSERT_STRUCT(test, assert_type),      \
+			fmt,						       \
+			##__VA_ARGS__)
+
+/**
+ * KUNIT_FAIL() - Always causes a test to fail when evaluated.
+ * @test: The test context object.
+ * @fmt: an informational message to be printed when the assertion is made.
+ * @...: string format arguments.
+ *
+ * The opposite of KUNIT_SUCCEED(), it is an expectation that always fails. In
+ * other words, it always results in a failed expectation, and consequently
+ * always causes the test case to fail when evaluated. See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_FAIL(test, fmt, ...)					       \
+	KUNIT_FAIL_ASSERTION(test,					       \
+			     KUNIT_EXPECTATION,				       \
+			     fmt,					       \
+			     ##__VA_ARGS__)
+
+#define KUNIT_UNARY_ASSERTION(test,					       \
+			      assert_type,				       \
+			      condition,				       \
+			      expected_true,				       \
+			      fmt,					       \
+			      ...)					       \
+	KUNIT_ASSERTION(test,						       \
+			!!(condition) == !!expected_true,		       \
+			kunit_unary_assert,				       \
+			KUNIT_INIT_UNARY_ASSERT_STRUCT(test,		       \
+						       assert_type,	       \
+						       #condition,	       \
+						       expected_true),	       \
+			fmt,						       \
+			##__VA_ARGS__)
+
+#define KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)       \
+	KUNIT_UNARY_ASSERTION(test,					       \
+			      assert_type,				       \
+			      condition,				       \
+			      true,					       \
+			      fmt,					       \
+			      ##__VA_ARGS__)
+
+#define KUNIT_TRUE_ASSERTION(test, assert_type, condition) \
+	KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, NULL)
+
+#define KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)      \
+	KUNIT_UNARY_ASSERTION(test,					       \
+			      assert_type,				       \
+			      condition,				       \
+			      false,					       \
+			      fmt,					       \
+			      ##__VA_ARGS__)
+
+#define KUNIT_FALSE_ASSERTION(test, assert_type, condition) \
+	KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, NULL)
+
+/*
+ * A factory macro for defining the assertions and expectations for the basic
+ * comparisons defined for the built in types.
+ *
+ * Unfortunately, there is no common type that all types can be promoted to for
+ * which all the binary operators behave the same way as for the actual types
+ * (for example, there is no type that long long and unsigned long long can
+ * both be cast to where the comparison result is preserved for all values). So
+ * the best we can do is do the comparison in the original types and then coerce
+ * everything to long long for printing; this way, the comparison behaves
+ * correctly and the printed out value usually makes sense without
+ * interpretation, but can always be interpreted to figure out the actual
+ * value.
+ */
+#define KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    op,					       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+do {									       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	((void)__typecheck(__left, __right));				       \
+									       \
+	KUNIT_ASSERTION(test,						       \
+			__left op __right,				       \
+			assert_class,					       \
+			ASSERT_CLASS_INIT(test,				       \
+					  assert_type,			       \
+					  #op,				       \
+					  #left,			       \
+					  __left,			       \
+					  #right,			       \
+					  __right),			       \
+			fmt,						       \
+			##__VA_ARGS__);					       \
+} while (0)
+
+#define KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, ==, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, !=, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, <, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, <=, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, >, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, >=, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_EQ_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_EQ_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_NE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_LT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_LT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_LT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_LE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_LE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_GT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_GT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_GE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_GE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left,				       \
+				   op,					       \
+				   right,				       \
+				   fmt,					       \
+				   ...)					       \
+do {									       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	KUNIT_ASSERTION(test,						       \
+			strcmp(__left, __right) op 0,			       \
+			kunit_binary_str_assert,			       \
+			KUNIT_INIT_BINARY_ASSERT_STRUCT(test,		       \
+							assert_type,	       \
+							#op,		       \
+							#left,		       \
+							__left,		       \
+							#right,		       \
+							__right),	       \
+			fmt,						       \
+			##__VA_ARGS__);					       \
+} while (0)
+
+#define KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
+#define KUNIT_BINARY_STR_EQ_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
+#define KUNIT_BINARY_STR_NE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
+						assert_type,		       \
+						ptr,			       \
+						fmt,			       \
+						...)			       \
+do {									       \
+	typeof(ptr) __ptr = (ptr);					       \
+									       \
+	KUNIT_ASSERTION(test,						       \
+			!IS_ERR_OR_NULL(__ptr),				       \
+			kunit_ptr_not_err_assert,			       \
+			KUNIT_INIT_PTR_NOT_ERR_STRUCT(test,		       \
+						      assert_type,	       \
+						      #ptr,		       \
+						      __ptr),		       \
+			fmt,						       \
+			##__VA_ARGS__);					       \
+} while (0)
+
+#define KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, assert_type, ptr)	       \
+	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
+						assert_type,		       \
+						ptr,			       \
+						NULL)
+
+/**
+ * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails when this does
+ * not evaluate to true.
+ *
+ * This and expectations of the form `KUNIT_EXPECT_*` will cause the test case
+ * to fail when the specified condition is not met; however, it will not prevent
+ * the test case from continuing to run; this is otherwise known as an
+ * *expectation failure*.
+ */
+#define KUNIT_EXPECT_TRUE(test, condition) \
+	KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+
+#define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)		       \
+	KUNIT_TRUE_MSG_ASSERTION(test,					       \
+				 KUNIT_EXPECTATION,			       \
+				 condition,				       \
+				 fmt,					       \
+				 ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_FALSE() - Makes a test failure when the expression is not false.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails when this does
+ * not evaluate to false.
+ *
+ * Sets an expectation that @condition evaluates to false. See
+ * KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_FALSE(test, condition) \
+	KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+
+#define KUNIT_EXPECT_FALSE_MSG(test, condition, fmt, ...)		       \
+	KUNIT_FALSE_MSG_ASSERTION(test,					       \
+				  KUNIT_EXPECTATION,			       \
+				  condition,				       \
+				  fmt,					       \
+				  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_EQ() - Sets an expectation that @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_EQ(test, left, right) \
+	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_PTR_EQ() - Expects that pointers @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_PTR_EQ(test, left, right)				       \
+	KUNIT_BINARY_PTR_EQ_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right)
+
+#define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are not
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_NE(test, left, right) \
+	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_PTR_NE() - Expects that pointers @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are not
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_PTR_NE(test, left, right)				       \
+	KUNIT_BINARY_PTR_NE_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right)
+
+#define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_LT() - An expectation that @left is less than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is less than the
+ * value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) < (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_LT(test, left, right) \
+	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_LE() - Expects that @left is less than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is less than or
+ * equal to the value that @right evaluates to. Semantically this is equivalent
+ * to KUNIT_EXPECT_TRUE(@test, (@left) <= (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_LE(test, left, right) \
+	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_GT() - An expectation that @left is greater than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is greater than
+ * the value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) > (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_GT(test, left, right) \
+	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_GE() - Expects that @left is greater than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is greater than
+ * the value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) >= (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_GE(test, left, right) \
+	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_STREQ() - Expects that strings @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, !strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_EXPECT_STREQ(test, left, right) \
+	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_STRNEQ() - Expects that strings @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * not equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_EXPECT_STRNEQ(test, left, right) \
+	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is not null and not
+ * an errno stored in a pointer. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, !IS_ERR_OR_NULL(@ptr)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr) \
+	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_EXPECTATION, ptr)
+
+#define KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
+	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
+						KUNIT_EXPECTATION,	       \
+						ptr,			       \
+						fmt,			       \
+						##__VA_ARGS__)
+
 #endif /* _KUNIT_TEST_H */
diff --git a/kunit/test.c b/kunit/test.c
index 68b1037ab74d..3cbceb34b3b3 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -120,6 +120,68 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
 			      test_case->name);
 }
 
+static void kunit_print_string_stream(struct kunit *test,
+				      struct string_stream *stream)
+{
+	struct string_stream_fragment *fragment;
+	char *buf;
+
+	buf = string_stream_get_string(stream);
+	if (!buf) {
+		kunit_err(test,
+			  "Could not allocate buffer, dumping stream:\n");
+		list_for_each_entry(fragment, &stream->fragments, node) {
+			kunit_err(test, fragment->fragment);
+		}
+		kunit_err(test, "\n");
+	} else {
+		kunit_err(test, buf);
+		kunit_kfree(test, buf);
+	}
+}
+
+static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
+{
+	struct string_stream *stream;
+
+	kunit_set_failure(test);
+
+	stream = alloc_string_stream(test, GFP_KERNEL);
+	if (!stream) {
+		WARN(true,
+		     "Could not allocate stream to print failed assertion in %s:%d\n",
+		     assert->file,
+		     assert->line);
+		return;
+	}
+
+	assert->format(assert, stream);
+
+	kunit_print_string_stream(test, stream);
+
+	WARN_ON(string_stream_destroy(stream));
+}
+
+void kunit_do_assertion(struct kunit *test,
+			struct kunit_assert *assert,
+			bool pass,
+			const char *fmt, ...)
+{
+	va_list args;
+
+	if (pass)
+		return;
+
+	va_start(args, fmt);
+
+	assert->message.fmt = fmt;
+	assert->message.va = &args;
+
+	kunit_fail(test, assert);
+
+	va_end(args);
+}
+
 void kunit_init_test(struct kunit *test, const char *name)
 {
 	spin_lock_init(&test->lock);
-- 
2.23.0.187.g17f5b7556c-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
