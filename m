Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E03E630FC
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Jul 2019 08:35:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C167212B206A;
	Mon,  8 Jul 2019 23:35:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com;
 envelope-from=3sjukxq4kdj08obka7kefddfkpdlldib.9ljifkru-ksafjjifpqp.xy.lod@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A63B8212B0FD1
 for <linux-nvdimm@lists.01.org>; Mon,  8 Jul 2019 23:35:31 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id e95so10142432plb.9
 for <linux-nvdimm@lists.01.org>; Mon, 08 Jul 2019 23:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=9wLNCIVSUoQqeGTB89N+LVaQjLOY/UYArK2AxbIGTyA=;
 b=Pwon0M81V8AVB76h9QMHCNyf6Ulo+uJ38ERHtm3Xcp0TzHyqnKl2GlxHoih+L8HolU
 5ZpEEgMugCkhBR4w4LveLAOSR5ykLS47Q4LPrbXzwTX+DOyL7g4G0YeeErgwSDZyrhn8
 LXUChxba+34N3snEaXoRInodE6kMchtz/+MRZsXSAOKiSbRkvjpbf21ljZNQ8y2DnURc
 b+tugML870Ip6KdPO77zIHX7nWh+xLka+1u/PvilYLm+7nE6ZqWzgUdFM4j+EYPQr/3d
 MR2s/9sFFou0ckScoyUGwgdE2iCnQ8VvMT0bpPdXUNl977MQQeLz2Ro2Wb1z0A+4IjVC
 m7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=9wLNCIVSUoQqeGTB89N+LVaQjLOY/UYArK2AxbIGTyA=;
 b=bCHe6wHgWbxs6HX7zj4MRcrlT1YuJQG7kQ+pEQBHcblOLXOVbggkwoiKbZW/XWNcYK
 y4ejCRPNCeK9g6puFt2ECdnbO7cu74XPfw29TKZ5OWUw8iWaZD6AtGPEzBsn2NW8t7Cc
 YxgJm7Z53QsKdEWmffmPlp0pLkWzrEL9Rf7V2LDH0Rcpch1MXmbVSm/l4dVDAIpSf2NL
 fEzoPVisyhVefbAp8/7Ty2D9z2LjAaGr4EKomhw9HsQr5XSVkLBoKcdHrtVCn6eeuZzb
 7vlEeB0pZCpJS+8PQDLPevGUpv0K0FpydZjoyw3C5LC5JvPS0Xj9dhZ6k38hbFIbF4vS
 T0vw==
X-Gm-Message-State: APjAAAXCtxGqnHB8z7h/DV+WahSfQBrvc4lhVNfWgYbMbtRvfjS0GBvV
 XXGhgqA5gVFn4DkCwmcEyi+Eeda4F7gox9ZnvSMq1Q==
X-Google-Smtp-Source: APXvYqzzn6RZAD8ygVXxDl0uBJXywpEu9a9paRDsXOVggF+cFJf8KYH3zugHg8P99JXPssZkr1JuI9EwxMwEA51QDQ6w1w==
X-Received: by 2002:a63:374a:: with SMTP id g10mr28256682pgn.31.1562654130804; 
 Mon, 08 Jul 2019 23:35:30 -0700 (PDT)
Date: Mon,  8 Jul 2019 23:30:22 -0700
In-Reply-To: <20190709063023.251446-1-brendanhiggins@google.com>
Message-Id: <20190709063023.251446-18-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 17/18] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
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
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com,
 Iurii Zaikin <yzaikin@google.com>, jdike@addtoit.com, dan.carpenter@oracle.com,
 devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com,
 linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr,
 kunit-dev@googlegroups.com, richard@nod.at, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Iurii Zaikin <yzaikin@google.com>

KUnit tests for initialized data behavior of proc_dointvec that is
explicitly checked in the code. Includes basic parsing tests including
int min/max overflow.

Signed-off-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/Makefile      |   2 +
 kernel/sysctl-test.c | 375 +++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug    |  11 ++
 3 files changed, 388 insertions(+)
 create mode 100644 kernel/sysctl-test.c

diff --git a/kernel/Makefile b/kernel/Makefile
index a8d923b5481ba..50fd511cd0ee0 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -114,6 +114,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
 obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_RSEQ) += rseq.o
 
+obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
+
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
new file mode 100644
index 0000000000000..fc27b2c1185ca
--- /dev/null
+++ b/kernel/sysctl-test.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test of proc sysctl.
+ */
+
+#include <kunit/test.h>
+#include <linux/sysctl.h>
+
+#define KUNIT_PROC_READ 0
+#define KUNIT_PROC_WRITE 1
+
+static int i_zero;
+static int i_one_hundred = 100;
+
+/*
+ * Test that proc_dointvec will not try to use a NULL .data field even when the
+ * length is non-zero.
+ */
+static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
+{
+	struct ctl_table null_data_table = {
+		.procname = "foo",
+		/*
+		 * Here we are testing that proc_dointvec behaves correctly when
+		 * we give it a NULL .data field. Normally this would point to a
+		 * piece of memory where the value would be stored.
+		 */
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	size_t len;
+	loff_t pos;
+
+	/*
+	 * We don't care what the starting length is since proc_dointvec should
+	 * not try to read because .data is NULL.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&null_data_table,
+					       KUNIT_PROC_READ, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+
+	/*
+	 * See above.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&null_data_table,
+					       KUNIT_PROC_WRITE, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Similar to the previous test, we create a struct ctrl_table that has a .data
+ * field that proc_dointvec cannot do anything with; however, this time it is
+ * because we tell proc_dointvec that the size is 0.
+ */
+static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table data_maxlen_unset_table = {
+		.procname = "foo",
+		.data		= &data,
+		/*
+		 * So .data is no longer NULL, but we tell proc_dointvec its
+		 * length is 0, so it still shouldn't try to use it.
+		 */
+		.maxlen		= 0,
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	size_t len;
+	loff_t pos;
+
+	/*
+	 * As before, we don't care what buffer length is because proc_dointvec
+	 * cannot do anything because its internal .data buffer has zero length.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&data_maxlen_unset_table,
+					       KUNIT_PROC_READ, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+
+	/*
+	 * See previous comment.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&data_maxlen_unset_table,
+					       KUNIT_PROC_WRITE, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Here we provide a valid struct ctl_table, but we try to read and write from
+ * it using a buffer of zero length, so it should still fail in a similar way as
+ * before.
+ */
+static void sysctl_test_api_dointvec_table_len_is_zero(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	/*
+	 * However, now our read/write buffer has zero length.
+	 */
+	size_t len = 0;
+	loff_t pos;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buffer,
+					       &len, &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE, buffer,
+					       &len, &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Test that proc_dointvec refuses to read when the file position is non-zero.
+ */
+static void sysctl_test_api_dointvec_table_read_but_position_set(
+		struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	/*
+	 * We don't care about our buffer length because we start off with a
+	 * non-zero file position.
+	 */
+	size_t len = 1234;
+	/*
+	 * proc_dointvec should refuse to read into the buffer since the file
+	 * pos is non-zero.
+	 */
+	loff_t pos = 1;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buffer,
+					       &len, &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Test that we can read a two digit number in a sufficiently size buffer.
+ * Nothing fancy.
+ */
+static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	/* Put something in the buffer for debugging purposes. */
+	char buf[] = "bogus";
+	size_t len = sizeof(buf) - 1;
+	loff_t pos = 0;
+	/* Store 13 in the data field. */
+	*((int *)table.data) = 13;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buf,
+					       &len, &pos));
+	KUNIT_ASSERT_EQ(test, (size_t)3, len);
+	buf[len] = '\0';
+	/* And we read 13 back out. */
+	KUNIT_EXPECT_STREQ(test, "13\n", (char *)buf);
+}
+
+/*
+ * Same as previous test, just now with negative numbers.
+ */
+static void sysctl_test_dointvec_read_happy_single_negative(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	char buf[] = "bogus";
+	size_t len = sizeof(buf) - 1;
+	loff_t pos = 0;
+	*((int *)table.data) = -16;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buf,
+					       &len, &pos));
+	KUNIT_ASSERT_EQ(test, (size_t)4, len);
+	buf[len] = '\0';
+	KUNIT_EXPECT_STREQ(test, "-16\n", (char *)buf);
+}
+
+/*
+ * Test that a simple positive write works.
+ */
+static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	char input[] = "9";
+	size_t len = sizeof(input) - 1;
+	loff_t pos = 0;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE, input,
+					       &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
+	KUNIT_EXPECT_EQ(test, 9, *((int *)table.data));
+}
+
+/*
+ * Same as previous test, but now with negative numbers.
+ */
+static void sysctl_test_dointvec_write_happy_single_negative(struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	char input[] = "-9";
+	size_t len = sizeof(input) - 1;
+	loff_t pos = 0;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE, input,
+					       &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
+	KUNIT_EXPECT_EQ(test, -9, *((int *)table.data));
+}
+
+/*
+ * Test that writing a value smaller than the minimum possible value is not
+ * allowed.
+ */
+static void sysctl_test_api_dointvec_write_single_less_int_min(
+		struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	char input[32];
+	size_t len = sizeof(input) - 1;
+	loff_t pos = 0;
+	unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
+					     - (INT_MAX + INT_MIN) + 1;
+
+	/*
+	 * We use this rigmarole to create a string that contains a value one
+	 * less than the minimum accepted value.
+	 */
+	KUNIT_ASSERT_LT(test,
+			(size_t)snprintf(input, sizeof(input), "-%lu",
+					 abs_of_less_than_min),
+			sizeof(input));
+
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			proc_dointvec(&table, KUNIT_PROC_WRITE, input, &len,
+				      &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
+}
+
+/*
+ * Test that writing the maximum possible value works.
+ */
+static void sysctl_test_api_dointvec_write_single_greater_int_max(
+		struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	char input[32];
+	size_t len = sizeof(input) - 1;
+	loff_t pos = 0;
+	unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
+
+	KUNIT_ASSERT_GT(test, greater_than_max, (unsigned long)INT_MAX);
+	KUNIT_ASSERT_LT(test, (size_t)snprintf(input, sizeof(input), "%lu",
+					       greater_than_max),
+			sizeof(input));
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			proc_dointvec(&table, KUNIT_PROC_WRITE, input, &len,
+				      &pos));
+	KUNIT_ASSERT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
+}
+
+static struct kunit_case sysctl_test_cases[] = {
+	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
+	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
+	KUNIT_CASE(sysctl_test_api_dointvec_table_len_is_zero),
+	KUNIT_CASE(sysctl_test_api_dointvec_table_read_but_position_set),
+	KUNIT_CASE(sysctl_test_dointvec_read_happy_single_positive),
+	KUNIT_CASE(sysctl_test_dointvec_read_happy_single_negative),
+	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_positive),
+	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	{}
+};
+
+static struct kunit_suite sysctl_test_suite = {
+	.name = "sysctl_test",
+	.test_cases = sysctl_test_cases,
+};
+
+kunit_test_suite(sysctl_test_suite);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cbdfae3798965..6f8007800a76f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1939,6 +1939,17 @@ config TEST_SYSCTL
 
 	  If unsure, say N.
 
+config SYSCTL_KUNIT_TEST
+	bool "KUnit test for sysctl"
+	depends on KUNIT
+	help
+	  This builds the proc sysctl unit test, which runs on boot.
+	  Tests the API contract and implementation correctness of sysctl.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
