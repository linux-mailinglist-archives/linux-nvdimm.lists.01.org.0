Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 338559BA4E
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Aug 2019 03:35:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 46BCC20218C20;
	Fri, 23 Aug 2019 18:38:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::74a; helo=mail-qk1-x74a.google.com;
 envelope-from=3xjrgxq4kdpcaqdmczmghffhmrfnnfkd.bnlkhmtw-muchllkhrsr.z0.nqf@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 310C620216B75
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:38:03 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id z2so10780584qkf.2
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=mVpxfTux71sHv+1W528lITcQ9KtSvmuV5VpHRPavxdY=;
 b=JwKukJ54SVhCp3sYmkrgEmtiFSIEPXi4v5hzOhz9y+m3S7gHjC9bDYxqLQHTKzCZ5R
 lyGtOuo5lcLWrGu9Qlyj1KH1J6nqUjdL++87jueU4q2h5AI5GqlA6BXDayX0oyBVjjln
 9uwgSpj2c1mJhg2ZXZXiFVgNKVPDc3Vb/Yca1zmAB5GJLOAEtbtdR9d1se9eRsC7zpXk
 ze6Rd4euUR6qqg+vhWfEnG25nEh9ig7O+gHgHNpPnrpse4VaRpl7+kvRvfbMIIYs8P+e
 81GDySPPxnH/oJvpWOaC77/jokEhhqFRqoCS+pd1/ItrujaplOse+DoM7AjoRxnnu6sc
 kIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=mVpxfTux71sHv+1W528lITcQ9KtSvmuV5VpHRPavxdY=;
 b=IqaMK8jMBw7THZ81mFVs0kKMkMedaXl2ufZwW/5qLCakTVAQBotJ2kKYoy8yBTfP6h
 HXPhJsrLB5GhjXLQsv/KIQpr0CBAc7jgXGg6WsZZGUDY4FhCoyTQ/3SeP/IAloqEyP9D
 43d5D7ti4VrutVcnXTevFY7jQlmmoOow+RxGOHcYwI5CKjm7bM67e9CxZ12ofjCATyu8
 H+WddcTK9RmU8Gp/myKHpSHEDX9lzblgoQnisTW6MEV3f2cPIMk4dZGJvul7segLlv4z
 5n590YTqyQ3RY97/dTUweB3wK+7ybi+dGyMNJeJdSYfzQZkL/Bnp2eBSZOJomJaAqMsj
 XDbQ==
X-Gm-Message-State: APjAAAV5Ya6G1TDKczRp3qp67irVvtmdNCv4UGpf9MDpa5wqe3r8DIZO
 MDkiq8+6FoyWDdlXsQBb77D97sOnbBr0e20YzNGIkg==
X-Google-Smtp-Source: APXvYqwxJvkNO2gpEHnHaYrY3eGqjmg1KoqSkGd5X9D+kW96LWoTDQBHyp9xMZQgZwUOF3q/6S5zpLS+F7rvgiQLi7+43g==
X-Received: by 2002:a0c:b251:: with SMTP id k17mr6570552qve.132.1566610524332; 
 Fri, 23 Aug 2019 18:35:24 -0700 (PDT)
Date: Fri, 23 Aug 2019 18:34:24 -0700
In-Reply-To: <20190824013425.175645-1-brendanhiggins@google.com>
Message-Id: <20190824013425.175645-18-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190824013425.175645-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v15 17/18] kernel/sysctl-test: Add null pointer test for
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
index 5960e2980a8a..a425741907b0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1965,6 +1965,17 @@ config TEST_SYSCTL
 
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
2.23.0.187.g17f5b7556c-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
