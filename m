Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ABDB9B4D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 02:19:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 577402194EB7C;
	Fri, 20 Sep 2019 17:22:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com;
 envelope-from=3p2yfxq4kdign3qzpmztussuz4s00sxq.o0yxuz69-z7puyyxu454.cd.03s@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 498AD202EDBBB
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:22:43 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 135so142369pgc.23
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=81bTdnV8q540oYjJugd7eaSyRyEnhqDeUpcm4E8NRvg=;
 b=MCwcP9KpfkpafhYAed+1msefhSMuudCRT1L9Y6zDxaGsXPUuRshT33gu9ByqVcwWWP
 Id395tGG9TccLnJ4N1x/fuhhMND5AFqIyRbEcqA/AnKwApjzhUXA8bX60CWgzoLIAhu6
 tQnRdJlOqa25r+eh+OuLocs6Cq3eaDOuqpSZGkGfMkPRANRmmPTSyatTcVXgliYETvDD
 cdo2QnZzmrJY4MVgKUBlm+H3pahexbMPBIQOaw4EX9ePUPuFlC90gcA8zaueKov8DZ71
 fMY/wfmyuiejgm/VT72l5qMKFsJ4HqOVmlI3QC8jzXoIHR0VuJVKWzDGPtIYVZNUkUry
 qzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=81bTdnV8q540oYjJugd7eaSyRyEnhqDeUpcm4E8NRvg=;
 b=qbR0xQKsk+SXtEzM2ciC2suq1YYhnKtqVO4Mx6MA9hyETWeoq7/XizGgDga4KMZBMT
 90qcCxCxqgCudbXW6aJGchhPuWhQ3Z9hq4Q9XZV6ABw7zoB+rgTj2RJ38TtEk+RBgC4S
 mgQYk9Gt5n9po18lLFMKvsKBZReRKomP2dB8x2IP05tY/2oHjHKCfYN5KOsUluSqfQh/
 B5gVUHCDFB0RMzDkan2wuzKPY462kVKDNkgMzAs0EdFLaw+Zcg2M9ztYAiU2xbd5iq/F
 KaINkScy0kjo+cdeT9qk+1ayWVI8L6eL4elUmOREQNY4HbpD4iydeSCRVcYtWtg+nzIL
 uOZg==
X-Gm-Message-State: APjAAAV7okfTpBkueCY/2zw2xZ9/VsQGISlFxsJVls2cYvoN8GqxjO+u
 U0R60/qTjjk2sc1Tt2UebQSr+wt+pyy2kSC2MhTVhA==
X-Google-Smtp-Source: APXvYqzqxFlx1iZXLRP5+ouAJwgDVj6hE/Xe0YTXM9oyD1z0IwtUExJZ+XcUq0IaaTm0+opY4E8ThwpaBvjppGIaEoN3vg==
X-Received: by 2002:a63:115c:: with SMTP id 28mr17751216pgr.69.1569025191979; 
 Fri, 20 Sep 2019 17:19:51 -0700 (PDT)
Date: Fri, 20 Sep 2019 17:18:53 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-18-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 17/19] kernel/sysctl-test: Add null pointer test for
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
 kunit-dev@googlegroups.com, richard@nod.at, torvalds@linux-foundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch,
 mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
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
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 kernel/Makefile      |   2 +
 kernel/sysctl-test.c | 392 +++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug    |  11 ++
 3 files changed, 405 insertions(+)
 create mode 100644 kernel/sysctl-test.c

diff --git a/kernel/Makefile b/kernel/Makefile
index ef0d95a190b4..63e9ea6122c2 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -113,6 +113,8 @@ obj-$(CONFIG_TORTURE_TEST) += torture.o
 obj-$(CONFIG_HAS_IOMEM) += iomem.o
 obj-$(CONFIG_RSEQ) += rseq.o
 
+obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
+
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
new file mode 100644
index 000000000000..2a63241a8453
--- /dev/null
+++ b/kernel/sysctl-test.c
@@ -0,0 +1,392 @@
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
+	/*
+	 * proc_dointvec expects a buffer in user space, so we allocate one. We
+	 * also need to cast it to __user so sparse doesn't get mad.
+	 */
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
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
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
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
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
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
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
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
+	size_t len = 4;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	/* Store 13 in the data field. */
+	*((int *)table.data) = 13;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
+					       user_buffer, &len, &pos));
+	KUNIT_ASSERT_EQ(test, (size_t)3, len);
+	buffer[len] = '\0';
+	/* And we read 13 back out. */
+	KUNIT_EXPECT_STREQ(test, "13\n", buffer);
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
+	size_t len = 5;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	*((int *)table.data) = -16;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
+					       user_buffer, &len, &pos));
+	KUNIT_ASSERT_EQ(test, (size_t)4, len);
+	buffer[len] = '\0';
+	KUNIT_EXPECT_STREQ(test, "-16\n", (char *)buffer);
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
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+
+	memcpy(buffer, input, len);
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
+					       user_buffer, &len, &pos));
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
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+
+	memcpy(buffer, input, len);
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
+					       user_buffer, &len, &pos));
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
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
+					     - (INT_MAX + INT_MIN) + 1;
+
+	/*
+	 * We use this rigmarole to create a string that contains a value one
+	 * less than the minimum accepted value.
+	 */
+	KUNIT_ASSERT_LT(test,
+			(size_t)snprintf(buffer, max_len, "-%lu",
+					 abs_of_less_than_min),
+			max_len);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec(&table, KUNIT_PROC_WRITE,
+						     user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, max_len, len);
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
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
+
+	KUNIT_ASSERT_GT(test, greater_than_max, (unsigned long)INT_MAX);
+	KUNIT_ASSERT_LT(test, (size_t)snprintf(buffer, max_len, "%lu",
+					       greater_than_max),
+			max_len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec(&table, KUNIT_PROC_WRITE,
+						     user_buffer, &len, &pos));
+	KUNIT_ASSERT_EQ(test, max_len, len);
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
index 1c69640e712f..9331c864df81 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1967,6 +1967,17 @@ config TEST_SYSCTL
 
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
2.23.0.351.gc4317032e6-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
