Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E857547C61
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 10:26:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AB16721296B25;
	Mon, 17 Jun 2019 01:26:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::74a; helo=mail-qk1-x74a.google.com;
 envelope-from=3zk4hxq4kdhcwmziyvicdbbdinbjjbgz.xjhgdips-iqydhhgdnon.vw.jmb@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1103A21295C9B
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:26:55 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id i196so8509700qke.20
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=cUnWzVAEdqo7bGTNoMyzrIXrLOc4T43iDGYg6P6lpY4=;
 b=wQ0RYif4cw/h0o/LGMM2xUdirnSFJ0JsUONqN1ZdxRULIgBX27MlLzTRLpa1oqIzdF
 P6Dwe5eWAU9fP9ddEtwJoCrtZpkdSZERoVGk1KckdNqq6Assl5VfFZQznKjm/HmXuK49
 CZxd6od0b+uFUd3MAZQwjmvIRHcQd30mnhpBn/jyXmtF5xsTA8g3KTVHkrTOecDtulCd
 EvJv96og8ZBKk/WdNNM5z9WjBb4S+PFOuuPD1vg/8OJf+FH4bQdzWs9v+uV0jtmGQvxp
 MkGoRvyb6LtEtcih/MTXiEeu14WrH0rX3zasBargq8yPieKjpn+ACHIjmQaFwaWnmTp/
 USGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=cUnWzVAEdqo7bGTNoMyzrIXrLOc4T43iDGYg6P6lpY4=;
 b=uVP5qnGyBg9P1CsyL0OXcQDWhKgRJSOi+v6F1NtXtiprkLfnt3eM5+9XNSzsgrV7GL
 BTl4aHVaSqVuG4Fr4nEW+SOYzjzR+Z/fkteKFrU07bg5g2TQJlyjT4lqUOu6pmQGZij+
 1mVllvcY949UgbSYn0MSk5GFF6svP3EF/GBWbNgmCTjRt5mFay1ZJTI/gZXPWYYvXyLj
 AI+FGW6106/ZnLRPe8GtEmcEB8Rot8+ZGUGxyE5CygDqO8CZXcy26fcIA31eBBrZtUgL
 S9VIXT4nKV6ZXfzHQ7kbwAkQcDqQE13sA16NMkf9ipnql6mwPndIPVMu382zbxhj698S
 xEZA==
X-Gm-Message-State: APjAAAUV8r2wN8zll5/VD0og1KqLG+Jt1FtNhHOxm7u3V3ZADlz3mYBX
 iQm/ZsV143vbNUKVdE1wiFw6W6kdFdyjoV1n664qaA==
X-Google-Smtp-Source: APXvYqxNXmCWnPByBmN+rCTqVJl6sYyohRlRCxNiROvAb9NP+5L7zbkrbYvqHQOdbMZE8mUlmYnX7lqsX/Z2RH+ZdUY5fw==
X-Received: by 2002:a37:4d82:: with SMTP id a124mr16268821qkb.72.1560760014245; 
 Mon, 17 Jun 2019 01:26:54 -0700 (PDT)
Date: Mon, 17 Jun 2019 01:25:59 -0700
In-Reply-To: <20190617082613.109131-1-brendanhiggins@google.com>
Message-Id: <20190617082613.109131-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 04/18] kunit: test: add kunit_stream a std::stream like
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
Changes Since Last Revision:
 - Renamed kunit_new_stream() to alloc_kunit_stream() as suggested by
   Stephen Boyd.
 - Removed the ability to set log level after allocating a stream, as
   suggested by Stephen Boyd.
 - Removed locking, as it is now unnecessary with the previous change.
 - Made a number of other small changes like renaming parameters as
   suggested by Stephen Boyd.
---
 include/kunit/kunit-stream.h |  81 +++++++++++++++++++++++
 include/kunit/test.h         |   3 +
 kunit/Makefile               |   3 +-
 kunit/kunit-stream.c         | 123 +++++++++++++++++++++++++++++++++++
 kunit/test.c                 |   6 ++
 5 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/kunit-stream.h
 create mode 100644 kunit/kunit-stream.c

diff --git a/include/kunit/kunit-stream.h b/include/kunit/kunit-stream.h
new file mode 100644
index 0000000000000..a7b53eabf6be4
--- /dev/null
+++ b/include/kunit/kunit-stream.h
@@ -0,0 +1,81 @@
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
+	const char *level;
+	struct string_stream *internal_stream;
+};
+
+/**
+ * alloc_kunit_stream() - constructs a new &struct kunit_stream.
+ * @test: The test context object.
+ * @level: The log level at which to print out the message.
+ *
+ * Constructs a new test managed &struct kunit_stream.
+ */
+struct kunit_stream *alloc_kunit_stream(struct kunit *test, const char *level);
+
+/**
+ * kunit_stream_add(): adds the formatted input to the internal buffer.
+ * @kstream: the stream being operated on.
+ * @fmt: printf style format string to append to stream.
+ *
+ * Appends the formatted string, @fmt, to the internal buffer.
+ */
+void __printf(2, 3) kunit_stream_add(struct kunit_stream *kstream,
+				     const char *fmt, ...);
+
+/**
+ * kunit_stream_append(): appends the contents of @other to @kstream.
+ * @kstream: the stream to which @other is appended.
+ * @other: the stream whose contents are appended to @kstream.
+ *
+ * Appends the contents of @other to @kstream.
+ */
+void kunit_stream_append(struct kunit_stream *kstream,
+			 struct kunit_stream *other);
+
+/**
+ * kunit_stream_commit(): prints out the internal buffer to the user.
+ * @kstream: the stream being operated on.
+ *
+ * Outputs the contents of the internal buffer as a kunit_printk formatted
+ * output. KUNIT_STREAM ONLY OUTPUTS ITS BUFFER TO THE USER IF COMMIT IS
+ * CALLED!!! The reason for this is that it allows us to construct a message
+ * before we know whether we want to print it out; this can be extremely handy
+ * if there is information you might need for a failure message that is easiest
+ * to collect in the steps leading up to the actual check.
+ */
+void kunit_stream_commit(struct kunit_stream *kstream);
+
+/**
+ * kunit_stream_clear(): clears the internal buffer.
+ * @kstream: the stream being operated on.
+ *
+ * Clears the contents of the internal buffer.
+ */
+void kunit_stream_clear(struct kunit_stream *kstream);
+
+#endif /* _KUNIT_KUNIT_STREAM_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 27bd95b6b5523..83fb7ace1b320 100644
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
index 0000000000000..8bea1f22eafb5
--- /dev/null
+++ b/kunit/kunit-stream.c
@@ -0,0 +1,123 @@
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
+void kunit_stream_add(struct kunit_stream *kstream, const char *fmt, ...)
+{
+	va_list args;
+	struct string_stream *stream = kstream->internal_stream;
+
+	va_start(args, fmt);
+
+	if (string_stream_vadd(stream, fmt, args) < 0)
+		kunit_err(kstream->test,
+			  "Failed to allocate fragment: %s\n",
+			  fmt);
+
+	va_end(args);
+}
+
+void kunit_stream_append(struct kunit_stream *kstream,
+				struct kunit_stream *other)
+{
+	struct string_stream *other_stream = other->internal_stream;
+	const char *other_content;
+
+	other_content = string_stream_get_string(other_stream);
+
+	if (!other_content) {
+		kunit_err(kstream->test,
+			  "Failed to get string from second argument for appending\n");
+		return;
+	}
+
+	kunit_stream_add(kstream, other_content);
+}
+
+void kunit_stream_clear(struct kunit_stream *kstream)
+{
+	string_stream_clear(kstream->internal_stream);
+}
+
+void kunit_stream_commit(struct kunit_stream *kstream)
+{
+	struct string_stream *stream = kstream->internal_stream;
+	struct string_stream_fragment *fragment;
+	struct kunit *test = kstream->test;
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
+		goto cleanup;
+	}
+
+	kunit_printk(kstream->level, test, buf);
+	kfree(buf);
+
+cleanup:
+	kunit_stream_clear(kstream);
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
+	stream->internal_stream = alloc_string_stream(test);
+
+	if (!stream->internal_stream)
+		return -ENOMEM;
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
+			  "End of test case reached with uncommitted stream entries\n");
+		kunit_stream_commit(stream);
+	}
+}
+
+struct kunit_stream *alloc_kunit_stream(struct kunit *test, const char *level)
+{
+	struct kunit_stream *kstream;
+	struct kunit_resource *res;
+
+	res = kunit_alloc_resource(test,
+				   kunit_stream_init,
+				   kunit_stream_free,
+				   test);
+
+	if (!res)
+		return NULL;
+
+	kstream = res->allocation;
+	kstream->level = level;
+
+	return kstream;
+}
diff --git a/kunit/test.c b/kunit/test.c
index 53838f5394303..9404e4d34fa3f 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -139,6 +139,12 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
 			      test_case->name);
 }
 
+void kunit_fail(struct kunit *test, struct kunit_stream *stream)
+{
+	kunit_set_success(test, false);
+	kunit_stream_commit(stream);
+}
+
 void kunit_init_test(struct kunit *test, const char *name)
 {
 	spin_lock_init(&test->lock);
-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
