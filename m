Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8E4641DB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jul 2019 09:15:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB27D212B5EEB;
	Wed, 10 Jul 2019 00:15:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::849; helo=mail-qt1-x849.google.com;
 envelope-from=3pzalxq4kdewp5s1ro1vwuuw16u22uzs.q20zw18b-19rw00zw676.ef.25u@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D277E212B2063
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:15:50 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 97so1357679qtb.16
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ef4x4rIYEjXAUsOwLGAl/ehMOJtbGdS1NNHHbtE3RYE=;
 b=cv0FhaBnT8sIOJX4UO7zyAd38+6SjIeDUMVqdusMiTVgkNsImibP4lJXYN/4Qex6jK
 VF+CiSBjt81zH7Dj8GQys9m5gAtrQYR0IfMqrReIrMG73CRRnf94McSae/SBAD+z3n2m
 fAPNVtZPuFY016upkbT03Klx17TvZgsbkRd2kiOJwJCzfJWerr4zA4UKaj06V/v4V2AU
 lovevOgS4jEUNgRpMjf4oEWfVzDcKUPKQNSDg+JHoKdrtFgHmkafF82uOtBzSpEeUsMw
 iXTCScpyTEQP72TaJPEeGXnBB+gMX+lhlz/srnTpYSajv4HcdVd/oZQ1eX5pt+8nl+RZ
 y61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ef4x4rIYEjXAUsOwLGAl/ehMOJtbGdS1NNHHbtE3RYE=;
 b=ZHIHuzkL313BXNO3KxHPMupUZ8PD4QjmJRK3/2AJ8ePQeqy1Fwl/6cEq8qO5D6nx8m
 ie3oKxxKG8IsLVfGEr3KzTh94B9/I86JwotvIaNNaeOz8rRYhGmxvxXlVV0kFyxRvgq5
 G5Vds5rj55v4chi7zW3DFLq+lVgfOcr/0BbmMvieNUFTCt/UFjxP8bGJP3LNJorcmi6T
 RY0SZy+n0dc4HNNyYLbIez0noMZsSYy0F0vxJWOdBPeNFm3w4F/u868JBE0MjEoM/R3I
 iRJjeIxOPAogrYvNXn8dvzdGeZBdcbactwN2PLbWXpImtaDxNfOJcvpKoPO3XUssz7Me
 Npdg==
X-Gm-Message-State: APjAAAWil9EXWu8Gct47mmNOd/YdcNIbSzLDDofop4NLsoW7iz8BkcwO
 5O0rzVIimzczjiBySv+KXCTxHHLqzWrDAVFQyl7xPQ==
X-Google-Smtp-Source: APXvYqyMobJXqnNbAj/cGM/+SnYBhfNoCPG06BYi23WGY/9Bxh6lHiR5/Badoa6Srvlzlc8icohrZ2WuZ/Gsr8+9jH6keQ==
X-Received: by 2002:ac8:2d08:: with SMTP id n8mr21982152qta.383.1562742949599; 
 Wed, 10 Jul 2019 00:15:49 -0700 (PDT)
Date: Wed, 10 Jul 2019 00:14:53 -0700
In-Reply-To: <20190710071508.173491-1-brendanhiggins@google.com>
Message-Id: <20190710071508.173491-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 03/18] kunit: test: add string_stream a std::stream like
 string builder
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

A number of test features need to do pretty complicated string printing
where it may not be possible to rely on a single preallocated string
with parameters.

So provide a library for constructing the string as you go similar to
C++'s std::string.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/kunit/string-stream.h |  49 ++++++++++++
 kunit/Makefile                |   3 +-
 kunit/string-stream.c         | 147 ++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/string-stream.h
 create mode 100644 kunit/string-stream.c

diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
new file mode 100644
index 0000000000000..0552a05781afe
--- /dev/null
+++ b/include/kunit/string-stream.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_STRING_STREAM_H
+#define _KUNIT_STRING_STREAM_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/kref.h>
+#include <stdarg.h>
+
+struct string_stream_fragment {
+	struct list_head node;
+	char *fragment;
+};
+
+struct string_stream {
+	size_t length;
+	struct list_head fragments;
+	/* length and fragments are protected by this lock */
+	spinlock_t lock;
+};
+
+struct kunit;
+
+struct string_stream *alloc_string_stream(struct kunit *test);
+
+void string_stream_get(struct string_stream *stream);
+
+int string_stream_put(struct string_stream *stream);
+
+int string_stream_add(struct string_stream *stream, const char *fmt, ...);
+
+int string_stream_vadd(struct string_stream *stream,
+		       const char *fmt,
+		       va_list args);
+
+char *string_stream_get_string(struct string_stream *stream);
+
+void string_stream_clear(struct string_stream *stream);
+
+bool string_stream_is_empty(struct string_stream *stream);
+
+#endif /* _KUNIT_STRING_STREAM_H */
diff --git a/kunit/Makefile b/kunit/Makefile
index 5efdc4dea2c08..275b565a0e81f 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1 +1,2 @@
-obj-$(CONFIG_KUNIT) +=			test.o
+obj-$(CONFIG_KUNIT) +=			test.o \
+					string-stream.o
diff --git a/kunit/string-stream.c b/kunit/string-stream.c
new file mode 100644
index 0000000000000..0463a92dad74b
--- /dev/null
+++ b/kunit/string-stream.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <kunit/string-stream.h>
+#include <kunit/test.h>
+
+int string_stream_vadd(struct string_stream *stream,
+		       const char *fmt,
+		       va_list args)
+{
+	struct string_stream_fragment *frag_container;
+	int len;
+	va_list args_for_counting;
+	unsigned long flags;
+
+	/* Make a copy because `vsnprintf` could change it */
+	va_copy(args_for_counting, args);
+
+	/* Need space for null byte. */
+	len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
+
+	va_end(args_for_counting);
+
+	frag_container = kmalloc(sizeof(*frag_container), GFP_KERNEL);
+	if (!frag_container)
+		return -ENOMEM;
+
+	frag_container->fragment = kmalloc(len, GFP_KERNEL);
+	if (!frag_container->fragment) {
+		kfree(frag_container);
+		return -ENOMEM;
+	}
+
+	len = vsnprintf(frag_container->fragment, len, fmt, args);
+	spin_lock_irqsave(&stream->lock, flags);
+	stream->length += len;
+	list_add_tail(&frag_container->node, &stream->fragments);
+	spin_unlock_irqrestore(&stream->lock, flags);
+
+	return 0;
+}
+
+int string_stream_add(struct string_stream *stream, const char *fmt, ...)
+{
+	va_list args;
+	int result;
+
+	va_start(args, fmt);
+	result = string_stream_vadd(stream, fmt, args);
+	va_end(args);
+
+	return result;
+}
+
+void string_stream_clear(struct string_stream *stream)
+{
+	struct string_stream_fragment *frag_container, *frag_container_safe;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stream->lock, flags);
+	list_for_each_entry_safe(frag_container,
+				 frag_container_safe,
+				 &stream->fragments,
+				 node) {
+		list_del(&frag_container->node);
+		kfree(frag_container->fragment);
+		kfree(frag_container);
+	}
+	stream->length = 0;
+	spin_unlock_irqrestore(&stream->lock, flags);
+}
+
+char *string_stream_get_string(struct string_stream *stream)
+{
+	struct string_stream_fragment *frag_container;
+	size_t buf_len = stream->length + 1; /* +1 for null byte. */
+	char *buf;
+	unsigned long flags;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	spin_lock_irqsave(&stream->lock, flags);
+	list_for_each_entry(frag_container, &stream->fragments, node)
+		strlcat(buf, frag_container->fragment, buf_len);
+	spin_unlock_irqrestore(&stream->lock, flags);
+
+	return buf;
+}
+
+bool string_stream_is_empty(struct string_stream *stream)
+{
+	bool is_empty;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stream->lock, flags);
+	is_empty = list_empty(&stream->fragments);
+	spin_unlock_irqrestore(&stream->lock, flags);
+
+	return is_empty;
+}
+
+static int string_stream_init(struct kunit_resource *res, void *context)
+{
+	struct string_stream *stream;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+
+	res->allocation = stream;
+	INIT_LIST_HEAD(&stream->fragments);
+	spin_lock_init(&stream->lock);
+
+	return 0;
+}
+
+static void string_stream_free(struct kunit_resource *res)
+{
+	struct string_stream *stream = res->allocation;
+
+	string_stream_clear(stream);
+	kfree(stream);
+}
+
+struct string_stream *alloc_string_stream(struct kunit *test)
+{
+	struct kunit_resource *res;
+
+	res = kunit_alloc_resource(test,
+				   string_stream_init,
+				   string_stream_free,
+				   NULL);
+
+	if (!res)
+		return NULL;
+
+	return res->allocation;
+}
-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
