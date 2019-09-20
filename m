Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19549B9AEA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 01:51:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8164121962301;
	Fri, 20 Sep 2019 16:50:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::749; helo=mail-qk1-x749.google.com;
 envelope-from=3pl6fxq4kdgskanwmjwqrpprwbpxxpun.lxvurwdg-wemrvvurbcb.jk.xap@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 799AB202ECFBC
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 16:50:38 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id g62so10091364qkb.20
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 16:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=XEXF0aWtRP7hmX6yjkpnHC7BrzYVm/zOhA0NZRgvhNA=;
 b=Mnl/xUt/iq+dEEkDLu+rS6kLaTA1cBG/Up5iQxR1KnfFtl2jaH1Qq8yrbkHrR3xWwF
 ZiqXyQfe+hi+QMzsYsmhNq3ok2pc887+hl09rc3VilL9J1HjNFQuJfTe4u7ZDxYGqh96
 lV3egN3rbFfRqBS+Zgga6kwtpqqTX+rg5sLJOYCsaYQ9Ev6CRts/XUpyK29rQw2Bm87j
 g9unpjMaFPgplDS2FrFojx8N7uaRAl20o4vMsTNdCYZ197pZObKEfZ3+FLWy9rCNx2fu
 HT6cJVpQem0QtthzHc19srcc+z8va0f3vBai2hCMd8veINkjIFAjp6dBSOnu4wcIHUBE
 kJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=XEXF0aWtRP7hmX6yjkpnHC7BrzYVm/zOhA0NZRgvhNA=;
 b=uFFpcxiqiNf0oPfKUX7A+y+5mAhAXakJWRVnavY1tKnDVfjsrhEWBD2hXjJ9v+MGZ+
 IyDBb9exvXylde6j32991xJNN8Ze6yK8BhKf062+K+P+x0oBVND9kXqn965N0IvJ2RY1
 M4Y8rJEHpf66dNDBFPH26ufCV6STksURDblRbhGSwc0D4ZEsG+ZLCoTURYvgCD1jutAW
 sUUBX0v60wZsbzPH0QT5pflLjJuo44R5uBOHYZSLvSjnU1rVPHTXWyUKEbSd4I0i3Qxz
 CAKQQiqKqvK3g8/bSn0AOGt+2w8JyxR9H8jCID6zVw91fyx8uGdicU7M+lOGpkbVnNqV
 ZWmQ==
X-Gm-Message-State: APjAAAU3jNDYi3ukonkSBsBmWJTyWb1R9cqiUmOxjm4vTNqeXR8t/lyJ
 /cE5Vm0rXt73EnQ3sqlMEXKvJVAaMT/X/8uGiGgZiQ==
X-Google-Smtp-Source: APXvYqxNIqLpGLjV48CwFHexJgokuv/hbZaizFyuLYUXP38r8L9oG7NginMJKrCXc2ldDDvSv5tHg94t16QDZIgIOPWNzw==
X-Received: by 2002:a63:2c3:: with SMTP id 186mr1260317pgc.60.1569021606032;
 Fri, 20 Sep 2019 16:20:06 -0700 (PDT)
Date: Fri, 20 Sep 2019 16:19:14 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 10/19] kunit: test: add tests for kunit test abort
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

Add KUnit tests for the KUnit test abort mechanism (see preceding
commit). Add tests both for general try catch mechanism as well as
non-architecture specific mechanism.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 lib/kunit/Makefile    |   3 +-
 lib/kunit/test-test.c | 106 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 lib/kunit/test-test.c

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index c9176c9c578c..769d9402b5d3 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_KUNIT) +=			test.o \
 					assert.o \
 					try-catch.o
 
-obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
+					string-stream-test.o
 
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
new file mode 100644
index 000000000000..06d34d36b103
--- /dev/null
+++ b/lib/kunit/test-test.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for core test infrastructure.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/test.h>
+
+struct kunit_try_catch_test_context {
+	struct kunit_try_catch *try_catch;
+	bool function_called;
+};
+
+static void kunit_test_successful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+static void kunit_test_no_catch(void *data)
+{
+	struct kunit *test = data;
+
+	KUNIT_FAIL(test, "Catch should not be called\n");
+}
+
+static void kunit_test_try_catch_successful_try_no_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_successful_try,
+			     kunit_test_no_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static void kunit_test_unsuccessful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_throw(try_catch);
+	KUNIT_FAIL(test, "This line should never be reached\n");
+}
+
+static void kunit_test_catch(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+static void kunit_test_try_catch_unsuccessful_try_does_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_unsuccessful_try,
+			     kunit_test_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static int kunit_try_catch_test_init(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	test->priv = ctx;
+
+	ctx->try_catch = kunit_kmalloc(test,
+				       sizeof(*ctx->try_catch),
+				       GFP_KERNEL);
+	if (!ctx->try_catch)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static struct kunit_case kunit_try_catch_test_cases[] = {
+	KUNIT_CASE(kunit_test_try_catch_successful_try_no_catch),
+	KUNIT_CASE(kunit_test_try_catch_unsuccessful_try_does_catch),
+	{}
+};
+
+static struct kunit_suite kunit_try_catch_test_suite = {
+	.name = "kunit-try-catch-test",
+	.init = kunit_try_catch_test_init,
+	.test_cases = kunit_try_catch_test_cases,
+};
+kunit_test_suite(kunit_try_catch_test_suite);
-- 
2.23.0.351.gc4317032e6-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
