Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B1F1E47E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 00:18:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 119E221276BB4;
	Tue, 14 May 2019 15:18:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c4a; helo=mail-yw1-xc4a.google.com;
 envelope-from=3vt7bxa4kdjqzf2b1yb56446bg4cc492.0ca96bil-bj16aa96ghg.op.cf4@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-yw1-xc4a.google.com (mail-yw1-xc4a.google.com
 [IPv6:2607:f8b0:4864:20::c4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A43312127674A
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 15:18:38 -0700 (PDT)
Received: by mail-yw1-xc4a.google.com with SMTP id q2so672111ywd.9
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=cYVYiRlOTl+HHTHC4VnotSZcOxpzrVA2zwYQx1TkL4M=;
 b=dXBGU2hHcMiE4u+kb9J0rgbPRA4L+RwX45cYa7yjiJOCgqCswGeD1mKQmYJ6ivvUvL
 hz+pb6xz9vh3w43kb631cryEdSDHtIZVieHMMWphtl1A6rDk8I9nIBvYIT4ONVxPPTWS
 Rc44UOaIBM5/C2FXGtCr4x9wMlYwh+Lct8Lz2+R11hye7FDumEMyWFoGxyB6nxrP2S7P
 vw0ZSsMWkKNfPWQzwt+B1Vg+TV5xVPk6HFRUpomF6jcG65/n1SHgvaVqR5WhZ053WvLp
 ZPPCKOL/5LkzTvBnDk8o1F4CaDNZAyYrHp24c2sNqUDJUfyGmAqSLFIE+nPjO/grh5xe
 nj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=cYVYiRlOTl+HHTHC4VnotSZcOxpzrVA2zwYQx1TkL4M=;
 b=fGDd7iNx7xFZo4n7ane3xiGqxlMB/9hgRlltGvfB2V2iIPd1DMm8BR2b31zizhdd2T
 IaMHFedVDdmv9Lf01FNZC83PDSdHajXuZGUIVGbdx63nbgKNXjgaWcTIUHtZ6WdlVQ+Y
 IB0RsgbW6PRYcDzfoVnp43bbZTKqKDKNE9Hc0szHmsiSpgiPtDHvxDKhFU2PU8B6L+gC
 myloHmbkM0oToae3SYRJHRRRzp2ww6mJM8mM9ND2gC06POfQ0QtEQyLqbn/gPMFnVZLq
 Vdla0pG3vc9hic8cT+ctshQdMKMCRHeQkhW2xyqrJe8Qeuosq7YM8waO0zD80qGbKt/t
 3CmQ==
X-Gm-Message-State: APjAAAWtTX8mY2jogPn8Q90qfMxEQlpJMs2iEb2zywHlAw+VvrQd/+Pj
 UquG/HaRz915Qm1GSiYtpJGLXV3nXiPwf0cZzsdHbQ==
X-Google-Smtp-Source: APXvYqzQ6dKuzahWylpitsM/95C+uvJi8W1WIQ4jGgq8U1/lvr0pPL58kmPdhaSXWdlNzcnwppp1Yj1xdH/Iqu8xgB3+Kw==
X-Received: by 2002:a81:5e0a:: with SMTP id s10mr19670374ywb.451.1557872317694; 
 Tue, 14 May 2019 15:18:37 -0700 (PDT)
Date: Tue, 14 May 2019 15:16:57 -0700
In-Reply-To: <20190514221711.248228-1-brendanhiggins@google.com>
Message-Id: <20190514221711.248228-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v4 04/18] kunit: test: add kunit_stream a std::stream like
 logger
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

A lot of the expectation and assertion infrastructure prints out fairly
complicated test failure messages, so add a C++ style log library for
for logging test results.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/kunit/kunit-stream.h |  85 ++++++++++++++++++++
 include/kunit/test.h         |   3 +
 kunit/Makefile               |   3 +-
 kunit/kunit-stream.c         | 152 +++++++++++++++++++++++++++++++++++
 kunit/test.c                 |   7 ++
 5 files changed, 249 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/kunit-stream.h
 create mode 100644 kunit/kunit-stream.c

diff --git a/include/kunit/kunit-stream.h b/include/kunit/kunit-stream.h
new file mode 100644
index 0000000000000..d457a54fe0100
--- /dev/null
+++ b/include/kunit/kunit-stream.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string formatter and printer used in KUnit for outputting
+ * KUnit messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_KUNIT_STREAM_H
+#define _KUNIT_KUNIT_STREAM_H
+
+#include <linux/types.h>
+#include <kunit/string-stream.h>
+
+struct kunit;
+
+/**
+ * struct kunit_stream - a std::stream style string builder.
+ *
+ * A std::stream style string builder. Allows messages to be built up and
+ * printed all at once.
+ */
+struct kunit_stream {
+	/* private: internal use only. */
+	struct kunit *test;
+	spinlock_t lock; /* Guards level. */
+	const char *level;
+	struct string_stream *internal_stream;
+};
+
+/**
+ * kunit_new_stream() - constructs a new &struct kunit_stream.
+ * @test: The test context object.
+ *
+ * Constructs a new test managed &struct kunit_stream.
+ */
+struct kunit_stream *kunit_new_stream(struct kunit *test);
+
+/**
+ * kunit_stream_set_level(): sets the level that string should be printed at.
+ * @this: the stream being operated on.
+ * @level: the print level the stream is set to output to.
+ *
+ * Sets the print level at which the stream outputs.
+ */
+void kunit_stream_set_level(struct kunit_stream *this, const char *level);
+
+/**
+ * kunit_stream_add(): adds the formatted input to the internal buffer.
+ * @this: the stream being operated on.
+ * @fmt: printf style format string to append to stream.
+ *
+ * Appends the formatted string, @fmt, to the internal buffer.
+ */
+void __printf(2, 3) kunit_stream_add(struct kunit_stream *this,
+				     const char *fmt, ...);
+
+/**
+ * kunit_stream_append(): appends the contents of @other to @this.
+ * @this: the stream to which @other is appended.
+ * @other: the stream whose contents are appended to @this.
+ *
+ * Appends the contents of @other to @this.
+ */
+void kunit_stream_append(struct kunit_stream *this, struct kunit_stream *other);
+
+/**
+ * kunit_stream_commit(): prints out the internal buffer to the user.
+ * @this: the stream being operated on.
+ *
+ * Outputs the contents of the internal buffer as a kunit_printk formatted
+ * output.
+ */
+void kunit_stream_commit(struct kunit_stream *this);
+
+/**
+ * kunit_stream_clear(): clears the internal buffer.
+ * @this: the stream being operated on.
+ *
+ * Clears the contents of the internal buffer.
+ */
+void kunit_stream_clear(struct kunit_stream *this);
+
+#endif /* _KUNIT_KUNIT_STREAM_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 5e86d88cd5305..4bc839884a83c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <kunit/kunit-stream.h>
 
 struct kunit_resource;
 
@@ -172,6 +173,8 @@ struct kunit {
 
 void kunit_init_test(struct kunit *test, const char *name);
 
+void kunit_fail(struct kunit *test, struct kunit_stream *stream);
+
 int kunit_run_tests(struct kunit_module *module);
 
 /**
diff --git a/kunit/Makefile b/kunit/Makefile
index 275b565a0e81f..6ddc622ee6b1c 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
-					string-stream.o
+					string-stream.o \
+					kunit-stream.o
diff --git a/kunit/kunit-stream.c b/kunit/kunit-stream.c
new file mode 100644
index 0000000000000..1884f1b550888
--- /dev/null
+++ b/kunit/kunit-stream.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ stream style string formatter and printer used in KUnit for outputting
+ * KUnit messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/kunit-stream.h>
+#include <kunit/string-stream.h>
+
+static const char *kunit_stream_get_level(struct kunit_stream *this)
+{
+	unsigned long flags;
+	const char *level;
+
+	spin_lock_irqsave(&this->lock, flags);
+	level = this->level;
+	spin_unlock_irqrestore(&this->lock, flags);
+
+	return level;
+}
+
+void kunit_stream_set_level(struct kunit_stream *this, const char *level)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&this->lock, flags);
+	this->level = level;
+	spin_unlock_irqrestore(&this->lock, flags);
+}
+
+void kunit_stream_add(struct kunit_stream *this, const char *fmt, ...)
+{
+	va_list args;
+	struct string_stream *stream = this->internal_stream;
+
+	va_start(args, fmt);
+
+	if (string_stream_vadd(stream, fmt, args) < 0)
+		kunit_err(this->test, "Failed to allocate fragment: %s\n", fmt);
+
+	va_end(args);
+}
+
+void kunit_stream_append(struct kunit_stream *this,
+				struct kunit_stream *other)
+{
+	struct string_stream *other_stream = other->internal_stream;
+	const char *other_content;
+
+	other_content = string_stream_get_string(other_stream);
+
+	if (!other_content) {
+		kunit_err(this->test,
+			  "Failed to get string from second argument for appending.\n");
+		return;
+	}
+
+	kunit_stream_add(this, other_content);
+}
+
+void kunit_stream_clear(struct kunit_stream *this)
+{
+	string_stream_clear(this->internal_stream);
+}
+
+void kunit_stream_commit(struct kunit_stream *this)
+{
+	struct string_stream *stream = this->internal_stream;
+	struct string_stream_fragment *fragment;
+	const char *level;
+	char *buf;
+
+	level = kunit_stream_get_level(this);
+	if (!level) {
+		kunit_err(this->test,
+			  "Stream was committed without a specified log level.\n");
+		level = KERN_ERR;
+		kunit_stream_set_level(this, level);
+	}
+
+	buf = string_stream_get_string(stream);
+	if (!buf) {
+		kunit_err(this->test,
+			 "Could not allocate buffer, dumping stream:\n");
+		list_for_each_entry(fragment, &stream->fragments, node) {
+			kunit_err(this->test, fragment->fragment);
+		}
+		kunit_err(this->test, "\n");
+		goto cleanup;
+	}
+
+	kunit_printk(level, this->test, buf);
+	kfree(buf);
+
+cleanup:
+	kunit_stream_clear(this);
+}
+
+static int kunit_stream_init(struct kunit_resource *res, void *context)
+{
+	struct kunit *test = context;
+	struct kunit_stream *stream;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+
+	res->allocation = stream;
+	stream->test = test;
+	spin_lock_init(&stream->lock);
+	stream->internal_stream = new_string_stream();
+
+	if (!stream->internal_stream) {
+		kfree(stream);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void kunit_stream_free(struct kunit_resource *res)
+{
+	struct kunit_stream *stream = res->allocation;
+
+	if (!string_stream_is_empty(stream->internal_stream)) {
+		kunit_err(stream->test,
+			 "End of test case reached with uncommitted stream entries.\n");
+		kunit_stream_commit(stream);
+	}
+
+	destroy_string_stream(stream->internal_stream);
+	kfree(stream);
+}
+
+struct kunit_stream *kunit_new_stream(struct kunit *test)
+{
+	struct kunit_resource *res;
+
+	res = kunit_alloc_resource(test,
+				   kunit_stream_init,
+				   kunit_stream_free,
+				   test);
+
+	if (res)
+		return res->allocation;
+	else
+		return NULL;
+}
diff --git a/kunit/test.c b/kunit/test.c
index a15e6f8c41582..0bb6f53a7f87e 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -138,6 +138,13 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
 			      test_case->name);
 }
 
+void kunit_fail(struct kunit *test, struct kunit_stream *stream)
+{
+	kunit_set_success(test, false);
+	kunit_stream_set_level(stream, KERN_ERR);
+	kunit_stream_commit(stream);
+}
+
 void kunit_init_test(struct kunit *test, const char *name)
 {
 	spin_lock_init(&test->lock);
-- 
2.21.0.1020.gf2820cf01a-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
