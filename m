Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF321E4C5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 00:19:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECF3521277799;
	Tue, 14 May 2019 15:19:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com;
 envelope-from=3_z7bxa4kdny3j6f52f9a88afk8gg8d6.4gedafmp-fn5aeedaklk.st.gj8@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C70ED21276BB8
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 15:19:43 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id g11so412770plt.23
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Lws/EEgAna63rQ3vCEL1Uuu3Iu+1ZPUf+T+yTIZZ48c=;
 b=e/AVxKLY/BTIPy4M0b2OmdVg9I3Cjf+83tQc/8RUiKrxRYVCGqg3Zl0SrlluXiU/O/
 pwRWVuewqkQb+4jm3lDA+uWqqZl/5Qp2jsoqkSh7txRje8sBKgc2T24cBCYyPIDbL3Td
 2vOT6mtX7FAkvYixgfpQMuOXbD+WsLVTxJRWRjPcIHwh7xhhVzaUINCrENO+6zqHBIXX
 1IbAD9CKmDlwv5PLKIqbnItGhE3IuhWhKpDPTriVbhNQOEnRRWM36VOw1YpDb6jyrZ4J
 jLuqmwKAU9M8W3HAZbA4spHc+Ryxcow/wAF3N76tVz5jJtszzJCzEVPYaTO2Oq9+4bCM
 GX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Lws/EEgAna63rQ3vCEL1Uuu3Iu+1ZPUf+T+yTIZZ48c=;
 b=IcAziw4LFpXm499oidZRP6lakGbKMyhvi/InWUDDtSyonowZwO6dLm8Z4vpQeLXb6P
 +2DU3Al9Drlho9vofz3XRkRntBIps1UTG14jttoGVbKyc0bcHa4ZEOQbej1M50dT4EUz
 M4sqSR9x4jByIRfmaQODG99EIEpTUlSNwDdfHQ+Uej6fRdOPoXE4X2X2UEUpJTvawXPt
 q9LNcDkOHA0zkzU1Rd9uAfV7FgQacgMKB2zmPpGyS31OA+5smSNLl8jOHHTgWHhSWBTi
 MAmVm7vW5OEzB0UGWUHs1Bw9g1BizLrqaGdwu6I9Er9ovi3mhQedmFPHdAaxU1h0jhhH
 xlQg==
X-Gm-Message-State: APjAAAWEgIS9D637g4nf+HzRT9dSZ/epFemLZ7lrF8BS7oefxLUZu1J/
 EDyW8UYziOHXivgRJQJoMvv74u65DL0cy/SJo5KRnw==
X-Google-Smtp-Source: APXvYqyZO5hIVWx6sj5d5P+JfXAMjq8I7SEzOnNldWvrtI+QS/XQfLFxsuITIB0YkKXfskRKbkqe8bGObCnzw53RKnA6Hg==
X-Received: by 2002:a63:1a42:: with SMTP id a2mr39736396pgm.358.1557872383130; 
 Tue, 14 May 2019 15:19:43 -0700 (PDT)
Date: Tue, 14 May 2019 15:17:10 -0700
In-Reply-To: <20190514221711.248228-1-brendanhiggins@google.com>
Message-Id: <20190514221711.248228-18-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v4 17/18] kernel/sysctl-test: Add null pointer test for
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
---
 kernel/Makefile      |   2 +
 kernel/sysctl-test.c | 293 +++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug    |   6 +
 3 files changed, 301 insertions(+)
 create mode 100644 kernel/sysctl-test.c

diff --git a/kernel/Makefile b/kernel/Makefile
index 6c57e78817dad..c81a8976b6a4b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -112,6 +112,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
 obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_RSEQ) += rseq.o
 
+obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
+
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
new file mode 100644
index 0000000000000..fe0f2bae66085
--- /dev/null
+++ b/kernel/sysctl-test.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test of proc sysctl.
+ */
+
+#include <kunit/test.h>
+#include <linux/printk.h>
+#include <linux/sysctl.h>
+#include <linux/uaccess.h>
+
+static int i_zero;
+static int i_one_hundred = 100;
+
+struct test_sysctl_data {
+	int int_0001;
+	int int_0002;
+	int int_0003[4];
+
+	unsigned int uint_0001;
+
+	char string_0001[65];
+};
+
+static struct test_sysctl_data test_data = {
+	.int_0001 = 60,
+	.int_0002 = 1,
+
+	.int_0003[0] = 0,
+	.int_0003[1] = 1,
+	.int_0003[2] = 2,
+	.int_0003[3] = 3,
+
+	.uint_0001 = 314,
+
+	.string_0001 = "(none)",
+};
+
+static void sysctl_test_dointvec_null_tbl_data(struct kunit *test)
+{
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	size_t len;
+	loff_t pos;
+
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, len);
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, len);
+}
+
+static void sysctl_test_dointvec_table_maxlen_unset(struct kunit *test)
+{
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &test_data.int_0001,
+		.maxlen		= 0,
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	size_t len;
+	loff_t pos;
+
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, len);
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, len);
+}
+
+static void sysctl_test_dointvec_table_len_is_zero(struct kunit *test)
+{
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &test_data.int_0001,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	size_t len;
+	loff_t pos;
+
+	len = 0;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, len);
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, len);
+}
+
+static void sysctl_test_dointvec_table_read_but_position_set(struct kunit *test)
+{
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &test_data.int_0001,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	size_t len;
+	loff_t pos;
+
+	len = 1234;
+	pos = 1;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, 0, len);
+}
+
+static void sysctl_test_dointvec_happy_single_positive(struct kunit *test)
+{
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &test_data.int_0001,
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
+	table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
+	KUNIT_EXPECT_EQ(test, 9, *(int *)table.data);
+}
+
+static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
+{
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &test_data.int_0001,
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
+	table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
+	KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);
+}
+
+static void sysctl_test_dointvec_single_less_int_min(struct kunit *test)
+{
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &test_data.int_0001,
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
+	KUNIT_EXPECT_LT(test,
+			snprintf(input, sizeof(input), "-%lu",
+				 abs_of_less_than_min),
+			sizeof(input));
+
+	table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			proc_dointvec(&table, 1, input, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, 0, *(int *)table.data);
+}
+
+static void sysctl_test_dointvec_single_greater_int_max(struct kunit *test)
+{
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &test_data.int_0001,
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
+	KUNIT_EXPECT_GT(test, greater_than_max, INT_MAX);
+	KUNIT_EXPECT_LT(test, snprintf(input, sizeof(input), "%lu",
+				       greater_than_max),
+			sizeof(input));
+	table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			proc_dointvec(&table, 1, input, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, 0, *(int *)table.data);
+}
+
+static int sysctl_test_init(struct kunit *test)
+{
+	return 0;
+}
+
+/*
+ * This is run once after each test case, see the comment on example_test_module
+ * for more information.
+ */
+static void sysctl_test_exit(struct kunit *test)
+{
+}
+
+/*
+ * Here we make a list of all the test cases we want to add to the test module
+ * below.
+ */
+static struct kunit_case sysctl_test_cases[] = {
+	/*
+	 * This is a helper to create a test case object from a test case
+	 * function; its exact function is not important to understand how to
+	 * use KUnit, just know that this is how you associate test cases with a
+	 * test module.
+	 */
+	KUNIT_CASE(sysctl_test_dointvec_null_tbl_data),
+	KUNIT_CASE(sysctl_test_dointvec_table_maxlen_unset),
+	KUNIT_CASE(sysctl_test_dointvec_table_len_is_zero),
+	KUNIT_CASE(sysctl_test_dointvec_table_read_but_position_set),
+	KUNIT_CASE(sysctl_test_dointvec_happy_single_positive),
+	KUNIT_CASE(sysctl_test_dointvec_happy_single_negative),
+	KUNIT_CASE(sysctl_test_dointvec_single_less_int_min),
+	KUNIT_CASE(sysctl_test_dointvec_single_greater_int_max),
+	{},
+};
+
+/*
+ * This defines a suite or grouping of tests.
+ *
+ * Test cases are defined as belonging to the suite by adding them to
+ * `test_cases`.
+ *
+ * Often it is desirable to run some function which will set up things which
+ * will be used by every test; this is accomplished with an `init` function
+ * which runs before each test case is invoked. Similarly, an `exit` function
+ * may be specified which runs after every test case and can be used to for
+ * cleanup. For clarity, running tests in a test module would behave as follows:
+ *
+ * module.init(test);
+ * module.test_case[0](test);
+ * module.exit(test);
+ * module.init(test);
+ * module.test_case[1](test);
+ * module.exit(test);
+ * ...;
+ */
+static struct kunit_module sysctl_test_module = {
+	.name = "sysctl_test",
+	.init = sysctl_test_init,
+	.exit = sysctl_test_exit,
+	.test_cases = sysctl_test_cases,
+};
+
+/*
+ * This registers the above test module telling KUnit that this is a suite of
+ * tests that need to be run.
+ */
+module_test(sysctl_test_module);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d5a4a4036d2f8..772af4ec70111 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1908,6 +1908,12 @@ config TEST_SYSCTL
 
 	  If unsure, say N.
 
+config SYSCTL_KUNIT_TEST
+	bool "KUnit test for sysctl"
+	depends on KUNIT
+	help
+	  Enables KUnit sysctl test.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
-- 
2.21.0.1020.gf2820cf01a-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
