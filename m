Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B3031F3C3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 03:04:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 39E63100F2276;
	Thu, 18 Feb 2021 18:03:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 58A94100F225C
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 18:03:53 -0800 (PST)
IronPort-SDR: VZtIKIEOOjRKZH5+jbfzadA2UpLhCtjK9BKaekTABD+1W/fuC0VSJIaIGw0PN18Jb+HCx53v35
 0eBfAI3KE4kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181151501"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="181151501"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:53 -0800
IronPort-SDR: MjxmKymbTVshbh6mM9zj4PBw+ZX7GQQ4FIPpND9aPEBckJohvzy61p7o6mO9xh1cWdWoH/WHCt
 hJim7qcyXPlA==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="513509650"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:52 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl PATCH v2 06/13] test: rename 'ndctl_test_*' helpers to 'test_*'
Date: Thu, 18 Feb 2021 19:03:24 -0700
Message-Id: <20210219020331.725687-7-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: WKQIZBDTQMGGZK5WJW43EHGWOFHBE7HW
X-Message-ID-Hash: WKQIZBDTQMGGZK5WJW43EHGWOFHBE7HW
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WKQIZBDTQMGGZK5WJW43EHGWOFHBE7HW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for using the test harness for libcxl, rename
ndctl_test_* helpers to make them more generic.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test.h                        | 16 +++++------
 ndctl/bat.c                   |  6 ++--
 ndctl/test.c                  |  6 ++--
 test/ack-shutdown-count-set.c | 10 +++----
 test/blk_namespaces.c         | 10 +++----
 test/core.c                   | 24 ++++++++--------
 test/dax-dev.c                |  8 +++---
 test/dax-pmd.c                |  6 ++--
 test/dax-poison.c             |  2 +-
 test/device-dax.c             | 16 +++++------
 test/dpa-alloc.c              | 10 +++----
 test/dsm-fail.c               | 10 +++----
 test/libndctl.c               | 52 +++++++++++++++++------------------
 test/multi-pmem.c             | 16 +++++------
 test/parent-uuid.c            | 10 +++----
 test/pmem_namespaces.c        | 10 +++----
 test/revoke-devmem.c          |  8 +++---
 README.md                     |  2 +-
 18 files changed, 111 insertions(+), 111 deletions(-)

diff --git a/test.h b/test.h
index 216e2b4..3db11b5 100644
--- a/test.h
+++ b/test.h
@@ -6,15 +6,15 @@
 
 struct test_ctx;
 struct ndctl_ctx;
-struct test_ctx *ndctl_test_new(unsigned int kver);
-int ndctl_test_result(struct test_ctx *test, int rc);
-int ndctl_test_get_skipped(struct test_ctx *test);
-int ndctl_test_get_attempted(struct test_ctx *test);
-int __ndctl_test_attempt(struct test_ctx *test, unsigned int kver,
+struct test_ctx *test_new(unsigned int kver);
+int test_result(struct test_ctx *test, int rc);
+int test_get_skipped(struct test_ctx *test);
+int test_get_attempted(struct test_ctx *test);
+int __test_attempt(struct test_ctx *test, unsigned int kver,
 		const char *caller, int line);
-#define ndctl_test_attempt(t, v) __ndctl_test_attempt(t, v, __func__, __LINE__)
-void __ndctl_test_skip(struct test_ctx *test, const char *caller, int line);
-#define ndctl_test_skip(t) __ndctl_test_skip(t, __func__, __LINE__)
+#define test_attempt(t, v) __test_attempt(t, v, __func__, __LINE__)
+void __test_skip(struct test_ctx *test, const char *caller, int line);
+#define test_skip(t) __test_skip(t, __func__, __LINE__)
 struct ndctl_namespace *ndctl_get_test_dev(struct ndctl_ctx *ctx);
 void builtin_xaction_namespace_reset(void);
 
diff --git a/ndctl/bat.c b/ndctl/bat.c
index 18773fd..a3452fa 100644
--- a/ndctl/bat.c
+++ b/ndctl/bat.c
@@ -32,9 +32,9 @@ int cmd_bat(int argc, const char **argv, struct ndctl_ctx *ctx)
 		usage_with_options(u, options);
 
 	if (force)
-		test = ndctl_test_new(UINT_MAX);
+		test = test_new(UINT_MAX);
 	else
-		test = ndctl_test_new(0);
+		test = test_new(0);
 
 	if (!test) {
 		fprintf(stderr, "failed to initialize test\n");
@@ -48,5 +48,5 @@ int cmd_bat(int argc, const char **argv, struct ndctl_ctx *ctx)
 
 	rc = test_pmem_namespaces(loglevel, test, ctx);
 	fprintf(stderr, "test_pmem_namespaces: %s\n", rc ? "FAIL" : "PASS");
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/ndctl/test.c b/ndctl/test.c
index 7af3681..92713df 100644
--- a/ndctl/test.c
+++ b/ndctl/test.c
@@ -42,9 +42,9 @@ int cmd_test(int argc, const char **argv, struct ndctl_ctx *ctx)
 		usage_with_options(u, options);
 
 	if (force)
-		test = ndctl_test_new(UINT_MAX);
+		test = test_new(UINT_MAX);
 	else
-		test = ndctl_test_new(0);
+		test = test_new(0);
 	if (!test)
 		return EXIT_FAILURE;
 
@@ -69,5 +69,5 @@ int cmd_test(int argc, const char **argv, struct ndctl_ctx *ctx)
 	rc = test_multi_pmem(loglevel, test, ctx);
 	fprintf(stderr, "test-multi-pmem: %s\n", result(rc));
 
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/ack-shutdown-count-set.c b/test/ack-shutdown-count-set.c
index 37262cf..dc47f13 100644
--- a/test/ack-shutdown-count-set.c
+++ b/test/ack-shutdown-count-set.c
@@ -62,7 +62,7 @@ static int do_test(struct ndctl_ctx *ctx, struct test_ctx *test)
 	struct log_ctx log_ctx;
 	int rc = 0;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 15, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 15, 0)))
 		return 77;
 
 	if (!bus)
@@ -102,7 +102,7 @@ static int test_ack_shutdown_count_set(int loglevel, struct test_ctx *test,
 	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		result = 77;
-		ndctl_test_skip(test);
+		test_skip(test);
 		fprintf(stderr, "%s unavailable skipping tests\n",
 				"nfit_test");
 		return result;
@@ -117,7 +117,7 @@ static int test_ack_shutdown_count_set(int loglevel, struct test_ctx *test,
 
 int main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
@@ -128,9 +128,9 @@ int main(int argc, char *argv[])
 
 	rc = ndctl_new(&ctx);
 	if (rc)
-		return ndctl_test_result(test, rc);
+		return test_result(test, rc);
 	rc = test_ack_shutdown_count_set(LOG_DEBUG, test, ctx);
 	ndctl_unref(ctx);
 
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/blk_namespaces.c b/test/blk_namespaces.c
index aa221b8..ec4cd62 100644
--- a/test/blk_namespaces.c
+++ b/test/blk_namespaces.c
@@ -210,7 +210,7 @@ int test_blk_namespaces(int log_level, struct test_ctx *test,
 	struct ndctl_namespace *ndns[2];
 	struct ndctl_region *region, *blk_region = NULL;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 2, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 2, 0)))
 		return 77;
 
 	ndctl_set_log_priority(ctx, log_level);
@@ -232,7 +232,7 @@ int test_blk_namespaces(int log_level, struct test_ctx *test,
 		ndctl_invalidate(ctx);
 		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
 		if (rc < 0 || !bus) {
-			ndctl_test_skip(test);
+			test_skip(test);
 			fprintf(stderr, "nfit_test unavailable skipping tests\n");
 			return 77;
 		}
@@ -337,7 +337,7 @@ int test_blk_namespaces(int log_level, struct test_ctx *test,
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
@@ -349,9 +349,9 @@ int __attribute__((weak)) main(int argc, char *argv[])
 
 	rc = ndctl_new(&ctx);
 	if (rc)
-		return ndctl_test_result(test, rc);
+		return test_result(test, rc);
 
 	rc = test_blk_namespaces(LOG_DEBUG, test, ctx);
 	ndctl_unref(ctx);
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/core.c b/test/core.c
index bde40bb..1caf01e 100644
--- a/test/core.c
+++ b/test/core.c
@@ -38,7 +38,7 @@ static unsigned int get_system_kver(void)
 	return KERNEL_VERSION(a,b,c);
 }
 
-struct test_ctx *ndctl_test_new(unsigned int kver)
+struct test_ctx *test_new(unsigned int kver)
 {
 	struct test_ctx *test = calloc(1, sizeof(*test));
 
@@ -53,15 +53,15 @@ struct test_ctx *ndctl_test_new(unsigned int kver)
 	return test;
 }
 
-int ndctl_test_result(struct test_ctx *test, int rc)
+int test_result(struct test_ctx *test, int rc)
 {
-	if (ndctl_test_get_skipped(test))
+	if (test_get_skipped(test))
 		fprintf(stderr, "attempted: %d skipped: %d\n",
-				ndctl_test_get_attempted(test),
-				ndctl_test_get_skipped(test));
+				test_get_attempted(test),
+				test_get_skipped(test));
 	if (rc && rc != 77)
 		return rc;
-	if (ndctl_test_get_skipped(test) >= ndctl_test_get_attempted(test))
+	if (test_get_skipped(test) >= test_get_attempted(test))
 		return 77;
 	/* return success if no failures and at least one test not skipped */
 	return 0;
@@ -74,7 +74,7 @@ static char *kver_str(char *buf, unsigned int kver)
 	return buf;
 }
 
-int __ndctl_test_attempt(struct test_ctx *test, unsigned int kver,
+int __test_attempt(struct test_ctx *test, unsigned int kver,
 			 const char *caller, int line)
 {
 	char requires[KVER_STRLEN], current[KVER_STRLEN];
@@ -89,19 +89,19 @@ int __ndctl_test_attempt(struct test_ctx *test, unsigned int kver,
 	return 0;
 }
 
-void __ndctl_test_skip(struct test_ctx *test, const char *caller, int line)
+void __test_skip(struct test_ctx *test, const char *caller, int line)
 {
 	test->skip++;
 	test->attempt = test->skip;
 	fprintf(stderr, "%s: explicit skip %s:%d\n", __func__, caller, line);
 }
 
-int ndctl_test_get_attempted(struct test_ctx *test)
+int test_get_attempted(struct test_ctx *test)
 {
 	return test->attempt;
 }
 
-int ndctl_test_get_skipped(struct test_ctx *test)
+int test_get_skipped(struct test_ctx *test)
 {
 	return test->skip;
 }
@@ -155,7 +155,7 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		 * than 4.7.
 		 */
 		if (strcmp(name, "dax") == 0
-				&& !ndctl_test_attempt(test,
+				&& !test_attempt(test,
 					KERNEL_VERSION(4, 7, 0)))
 			continue;
 
@@ -164,7 +164,7 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		 */
 		if ((strcmp(name, "dax_pmem_core") == 0
 				|| strcmp(name, "dax_pmem_compat") == 0)
-				&& !ndctl_test_attempt(test,
+				&& !test_attempt(test,
 					KERNEL_VERSION(5, 1, 0)))
 			continue;
 
diff --git a/test/dax-dev.c b/test/dax-dev.c
index 99eda26..d61104f 100644
--- a/test/dax-dev.c
+++ b/test/dax-dev.c
@@ -93,7 +93,7 @@ static int emit_e820_device(int loglevel, struct test_ctx *test)
 	struct ndctl_ctx *ctx;
 	struct ndctl_namespace *ndns;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 3, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 3, 0)))
 		return 77;
 
 	err = ndctl_new(&ctx);
@@ -106,7 +106,7 @@ static int emit_e820_device(int loglevel, struct test_ctx *test)
 	if (!ndns) {
 		fprintf(stderr, "%s: failed to find usable victim device\n",
 				__func__);
-		ndctl_test_skip(test);
+		test_skip(test);
 		err = 77;
 	} else {
 		fprintf(stdout, "%s\n", ndctl_namespace_get_devname(ndns));
@@ -118,7 +118,7 @@ static int emit_e820_device(int loglevel, struct test_ctx *test)
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	int rc;
 
 	if (!test) {
@@ -127,5 +127,5 @@ int __attribute__((weak)) main(int argc, char *argv[])
 	}
 
 	rc = emit_e820_device(LOG_DEBUG, test);
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/dax-pmd.c b/test/dax-pmd.c
index a362b14..ecc2d16 100644
--- a/test/dax-pmd.c
+++ b/test/dax-pmd.c
@@ -45,7 +45,7 @@ int test_dax_remap(struct test_ctx *test, int dax_fd, unsigned long align,
 	struct sigaction act;
 	int rc, val;
 
-	if ((fsdax || align == SZ_2M) && !ndctl_test_attempt(test, KERNEL_VERSION(5, 8, 0))) {
+	if ((fsdax || align == SZ_2M) && !test_attempt(test, KERNEL_VERSION(5, 8, 0))) {
 		/* kernel's prior to 5.8 may crash on this test */
 		fprintf(stderr, "%s: SKIP mremap() test\n", __func__);
 		return 0;
@@ -351,7 +351,7 @@ err_mmap:
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	int fd, rc;
 
 	if (!test) {
@@ -366,5 +366,5 @@ int __attribute__((weak)) main(int argc, char *argv[])
 	rc = test_pmd(test, fd);
 	if (fd >= 0)
 		close(fd);
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/dax-poison.c b/test/dax-poison.c
index 800faaf..8f96ddb 100644
--- a/test/dax-poison.c
+++ b/test/dax-poison.c
@@ -52,7 +52,7 @@ int test_dax_poison(struct test_ctx *test, int dax_fd, unsigned long align,
 	void *buf;
 	int rc;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 19, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 19, 0)))
 		return 77;
 
 	/*
diff --git a/test/device-dax.c b/test/device-dax.c
index 47ea04f..738c474 100644
--- a/test/device-dax.c
+++ b/test/device-dax.c
@@ -95,7 +95,7 @@ static int verify_data(struct daxctl_dev *dev, char *dax_buf,
 	struct timeval tv1, tv2, tv_diff;
 	unsigned long i;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 9, 0)))
 		return 0;
 
 	/* verify data and cache mode */
@@ -150,10 +150,10 @@ static int __test_device_dax(unsigned long align, int loglevel,
 		return 77;
 	}
 
-	if (align > SZ_2M && !ndctl_test_attempt(test, KERNEL_VERSION(4, 11, 0)))
+	if (align > SZ_2M && !test_attempt(test, KERNEL_VERSION(4, 11, 0)))
 		return 77;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 7, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 7, 0)))
 		return 77;
 
 	/* setup up fsdax mode pmem device and seed with verification data */
@@ -241,7 +241,7 @@ static int __test_device_dax(unsigned long align, int loglevel,
 	 * Prior to 4.8-final these tests cause crashes, or are
 	 * otherwise not supported.
 	 */
-	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0))) {
+	if (test_attempt(test, KERNEL_VERSION(4, 9, 0))) {
 		static const bool devdax = false;
 		int fd2;
 
@@ -349,7 +349,7 @@ static int __test_device_dax(unsigned long align, int loglevel,
 	rc = EXIT_SUCCESS;
 	p = (int *) (buf + align);
 	*p = 0xff;
-	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0))) {
+	if (test_attempt(test, KERNEL_VERSION(4, 9, 0))) {
 		/* after 4.9 this test will properly get sigbus above */
 		rc = EXIT_FAILURE;
 		fprintf(stderr, "%s: failed to unmap after reset\n",
@@ -378,7 +378,7 @@ static int test_device_dax(int loglevel, struct test_ctx *test,
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
@@ -389,9 +389,9 @@ int __attribute__((weak)) main(int argc, char *argv[])
 
 	rc = ndctl_new(&ctx);
 	if (rc < 0)
-		return ndctl_test_result(test, rc);
+		return test_result(test, rc);
 
 	rc = test_device_dax(LOG_DEBUG, test, ctx);
 	ndctl_unref(ctx);
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
index 56a3eff..62e0597 100644
--- a/test/dpa-alloc.c
+++ b/test/dpa-alloc.c
@@ -285,13 +285,13 @@ int test_dpa_alloc(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx)
 	struct kmod_ctx *kmod_ctx;
 	int err, result = EXIT_FAILURE;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 2, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 2, 0)))
 		return 77;
 
 	ndctl_set_log_priority(ctx, loglevel);
 	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
-		ndctl_test_skip(test);
+		test_skip(test);
 		fprintf(stderr, "nfit_test unavailable skipping tests\n");
 		return 77;
 	}
@@ -306,7 +306,7 @@ int test_dpa_alloc(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx)
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
@@ -317,9 +317,9 @@ int __attribute__((weak)) main(int argc, char *argv[])
 
 	rc = ndctl_new(&ctx);
 	if (rc)
-		return ndctl_test_result(test, rc);
+		return test_result(test, rc);
 
 	rc = test_dpa_alloc(LOG_DEBUG, test, ctx);
 	ndctl_unref(ctx);
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/dsm-fail.c b/test/dsm-fail.c
index baba9a1..def5540 100644
--- a/test/dsm-fail.c
+++ b/test/dsm-fail.c
@@ -184,7 +184,7 @@ static int do_test(struct ndctl_ctx *ctx, struct test_ctx *test)
 	unsigned int handle;
 	int rc, err = 0;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 9, 0)))
 		return 77;
 
 	if (!bus)
@@ -349,7 +349,7 @@ int test_dsm_fail(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx)
 	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		result = 77;
-		ndctl_test_skip(test);
+		test_skip(test);
 		fprintf(stderr, "%s unavailable skipping tests\n",
 				"nfit_test");
 		return result;
@@ -364,7 +364,7 @@ int test_dsm_fail(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx)
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
@@ -375,8 +375,8 @@ int __attribute__((weak)) main(int argc, char *argv[])
 
 	rc = ndctl_new(&ctx);
 	if (rc)
-		return ndctl_test_result(test, rc);
+		return test_result(test, rc);
 	rc = test_dsm_fail(LOG_DEBUG, test, ctx);
 	ndctl_unref(ctx);
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/libndctl.c b/test/libndctl.c
index 9917fa9..317fefe 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -639,7 +639,7 @@ static int validate_dax(struct ndctl_dax *dax)
 		return -ENXIO;
 	}
 
-	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 10, 0))) {
+	if (test_attempt(test, KERNEL_VERSION(4, 10, 0))) {
 		if (daxctl_region_get_size(dax_region)
 				!= ndctl_dax_get_size(dax)) {
 			fprintf(stderr, "%s: expect size: %llu != %llu\n",
@@ -745,7 +745,7 @@ static int __check_dax_create(struct ndctl_region *region,
 	ndctl_dax_set_align(dax, SZ_4K);
 
 	rc = ndctl_namespace_set_enforce_mode(ndns, NDCTL_NS_MODE_DAX);
-	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 13, 0)) && rc < 0) {
+	if (test_attempt(test, KERNEL_VERSION(4, 13, 0)) && rc < 0) {
 		fprintf(stderr, "%s: failed to enforce dax mode\n", devname);
 		return rc;
 	}
@@ -856,7 +856,7 @@ static int __check_pfn_create(struct ndctl_region *region,
 	 */
 	ndctl_pfn_set_align(pfn, SZ_4K);
 	rc = ndctl_namespace_set_enforce_mode(ndns, NDCTL_NS_MODE_MEMORY);
-	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 13, 0)) && rc < 0) {
+	if (test_attempt(test, KERNEL_VERSION(4, 13, 0)) && rc < 0) {
 		fprintf(stderr, "%s: failed to enforce pfn mode\n", devname);
 		return rc;
 	}
@@ -1030,7 +1030,7 @@ static int check_btt_size(struct ndctl_btt *btt)
 	}
 
 	/* prior to 4.8 btt devices did not have a size attribute */
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 8, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 8, 0)))
 		return 0;
 
 	expect = expect_table[size_select][sect_select];
@@ -1077,7 +1077,7 @@ static int check_btt_create(struct ndctl_region *region, struct ndctl_namespace
 		ndctl_btt_set_uuid(btt, btt_s->uuid);
 		ndctl_btt_set_sector_size(btt, btt_s->sector_sizes[i]);
 		rc = ndctl_namespace_set_enforce_mode(ndns, NDCTL_NS_MODE_SECTOR);
-		if (ndctl_test_attempt(test, KERNEL_VERSION(4, 13, 0)) && rc < 0) {
+		if (test_attempt(test, KERNEL_VERSION(4, 13, 0)) && rc < 0) {
 			fprintf(stderr, "%s: failed to enforce btt mode\n", devname);
 			goto err;
 		}
@@ -1094,7 +1094,7 @@ static int check_btt_create(struct ndctl_region *region, struct ndctl_namespace
 		}
 
 		/* prior to v4.5 the mode attribute did not exist */
-		if (ndctl_test_attempt(test, KERNEL_VERSION(4, 5, 0))) {
+		if (test_attempt(test, KERNEL_VERSION(4, 5, 0))) {
 			mode = ndctl_namespace_get_mode(ndns);
 			if (mode >= 0 && mode != NDCTL_NS_MODE_SECTOR)
 				fprintf(stderr, "%s: expected safe mode got: %d\n",
@@ -1102,7 +1102,7 @@ static int check_btt_create(struct ndctl_region *region, struct ndctl_namespace
 		}
 
 		/* prior to v4.13 the expected sizes were different due to BTT1.1 */
-		if (ndctl_test_attempt(test, KERNEL_VERSION(4, 13, 0))) {
+		if (test_attempt(test, KERNEL_VERSION(4, 13, 0))) {
 			rc = check_btt_size(btt);
 			if (rc)
 				goto err;
@@ -1287,7 +1287,7 @@ static int check_pfn_autodetect(struct ndctl_bus *bus,
 		return -ENXIO;
 
 	mode = ndctl_namespace_get_enforce_mode(ndns);
-	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 13, 0))
+	if (test_attempt(test, KERNEL_VERSION(4, 13, 0))
 			&& mode != NDCTL_NS_MODE_MEMORY) {
 		fprintf(stderr, "%s expected enforce_mode pfn\n", devname);
 		return -ENXIO;
@@ -1384,7 +1384,7 @@ static int check_dax_autodetect(struct ndctl_bus *bus,
 		return -ENXIO;
 
 	mode = ndctl_namespace_get_enforce_mode(ndns);
-	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 13, 0))
+	if (test_attempt(test, KERNEL_VERSION(4, 13, 0))
 			&& mode != NDCTL_NS_MODE_DAX) {
 		fprintf(stderr, "%s expected enforce_mode dax\n", devname);
 		return -ENXIO;
@@ -1469,7 +1469,7 @@ static int check_btt_autodetect(struct ndctl_bus *bus,
 		return -ENXIO;
 
 	mode = ndctl_namespace_get_enforce_mode(ndns);
-	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 13, 0))
+	if (test_attempt(test, KERNEL_VERSION(4, 13, 0))
 			&& mode != NDCTL_NS_MODE_SECTOR) {
 		fprintf(stderr, "%s expected enforce_mode btt\n", devname);
 		return -ENXIO;
@@ -1698,7 +1698,7 @@ static int check_namespaces(struct ndctl_region *region,
 		}
 
 		if (ndctl_region_get_type(region) == ND_DEVICE_REGION_PMEM
-				&& !ndctl_test_attempt(test, KERNEL_VERSION(4, 13, 0)))
+				&& !test_attempt(test, KERNEL_VERSION(4, 13, 0)))
 			/* pass, no sector_size support for pmem prior to 4.13 */;
 		else {
 			num_sector_sizes = namespace->num_sector_sizes;
@@ -2305,7 +2305,7 @@ static int check_smart_threshold(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
 	 * Starting with v4.9 smart threshold requests trigger the file
 	 * descriptor returned by ndctl_dimm_get_health_eventfd().
 	 */
-	if (ndctl_test_attempt(check->test, KERNEL_VERSION(4, 9, 0))) {
+	if (test_attempt(check->test, KERNEL_VERSION(4, 9, 0))) {
 		int pid = fork();
 
 		if (pid == 0) {
@@ -2380,7 +2380,7 @@ static int check_smart_threshold(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
 		ndctl_cmd_unref(cmd_set);
 	}
 
-	if (ndctl_test_attempt(check->test, KERNEL_VERSION(4, 9, 0))) {
+	if (test_attempt(check->test, KERNEL_VERSION(4, 9, 0))) {
 		wait(&rc);
 		if (WEXITSTATUS(rc) == EXIT_FAILURE) {
 			fprintf(stderr, "%s: expect health event trigger\n",
@@ -2423,7 +2423,7 @@ static int check_commands(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
 	 * The kernel did not start emulating v1.2 namespace spec smart data
 	 * until 4.9.
 	 */
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 9, 0)))
 		dimm_commands &= ~((1 << ND_CMD_SMART)
 				| (1 << ND_CMD_SMART_THRESHOLD));
 
@@ -2458,7 +2458,7 @@ static int check_commands(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
 	if (rc)
 		goto out;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 6, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 6, 0)))
 		goto out;
 
  out:
@@ -2514,7 +2514,7 @@ static int check_dimms(struct ndctl_bus *bus, struct dimm *dimms, int n,
 			return -ENXIO;
 		}
 
-		if (ndctl_test_attempt(test, KERNEL_VERSION(4, 7, 0))) {
+		if (test_attempt(test, KERNEL_VERSION(4, 7, 0))) {
 			if (ndctl_dimm_get_formats(dimm) != dimms[i].formats) {
 				fprintf(stderr, "dimm%d expected formats: %d got: %d\n",
 						i, dimms[i].formats,
@@ -2532,7 +2532,7 @@ static int check_dimms(struct ndctl_bus *bus, struct dimm *dimms, int n,
 			}
 		}
 
-		if (ndctl_test_attempt(test, KERNEL_VERSION(4, 7, 0))) {
+		if (test_attempt(test, KERNEL_VERSION(4, 7, 0))) {
 			if (ndctl_dimm_get_subsystem_vendor(dimm)
 					!= dimms[i].subsystem_vendor) {
 				fprintf(stderr,
@@ -2543,7 +2543,7 @@ static int check_dimms(struct ndctl_bus *bus, struct dimm *dimms, int n,
 			}
 		}
 
-		if (ndctl_test_attempt(test, KERNEL_VERSION(4, 8, 0))) {
+		if (test_attempt(test, KERNEL_VERSION(4, 8, 0))) {
 			if (ndctl_dimm_get_manufacturing_date(dimm)
 					!= dimms[i].manufacturing_date) {
 				fprintf(stderr,
@@ -2629,14 +2629,14 @@ static int do_test0(struct ndctl_ctx *ctx, struct test_ctx *test)
 	}
 
 	/* pfn and dax tests require vmalloc-enabled nfit_test */
-	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 8, 0))) {
+	if (test_attempt(test, KERNEL_VERSION(4, 8, 0))) {
 		rc = check_regions(bus, regions0, ARRAY_SIZE(regions0), DAX);
 		if (rc)
 			return rc;
 		reset_bus(bus);
 	}
 
-	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 8, 0))) {
+	if (test_attempt(test, KERNEL_VERSION(4, 8, 0))) {
 		rc = check_regions(bus, regions0, ARRAY_SIZE(regions0), PFN);
 		if (rc)
 			return rc;
@@ -2660,7 +2660,7 @@ static int do_test1(struct ndctl_ctx *ctx, struct test_ctx *test)
 	 * Starting with v4.10 the dimm on nfit_test.1 gets a unique
 	 * handle.
 	 */
-	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 10, 0)))
+	if (test_attempt(test, KERNEL_VERSION(4, 10, 0)))
 		dimms1[0].handle = DIMM_HANDLE(1, 0, 0, 0, 0);
 
 	rc = check_dimms(bus, dimms1, ARRAY_SIZE(dimms1), 0, 0, test);
@@ -2684,7 +2684,7 @@ int test_libndctl(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx)
 	struct daxctl_ctx *daxctl_ctx;
 	int err, result = EXIT_FAILURE;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 2, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 2, 0)))
 		return 77;
 
 	ndctl_set_log_priority(ctx, loglevel);
@@ -2694,7 +2694,7 @@ int test_libndctl(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx)
 
 	err = nfit_test_init(&kmod_ctx, &mod, ctx, loglevel, test);
 	if (err < 0) {
-		ndctl_test_skip(test);
+		test_skip(test);
 		fprintf(stderr, "nfit_test unavailable skipping tests\n");
 		return 77;
 	}
@@ -2716,7 +2716,7 @@ int test_libndctl(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx)
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
@@ -2727,8 +2727,8 @@ int __attribute__((weak)) main(int argc, char *argv[])
 
 	rc = ndctl_new(&ctx);
 	if (rc)
-		return ndctl_test_result(test, rc);
+		return test_result(test, rc);
 	rc = test_libndctl(LOG_DEBUG, test, ctx);
 	ndctl_unref(ctx);
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/multi-pmem.c b/test/multi-pmem.c
index 7e4f211..c3fb4f6 100644
--- a/test/multi-pmem.c
+++ b/test/multi-pmem.c
@@ -57,7 +57,7 @@ static int check_deleted(struct ndctl_region *region, const char *devname,
 {
 	struct ndctl_namespace *ndns;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 10, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 10, 0)))
 		return 0;
 
 	ndctl_namespace_foreach(region, ndns) {
@@ -85,8 +85,8 @@ static int do_multi_pmem(struct ndctl_ctx *ctx, struct test_ctx *test)
 	struct ndctl_namespace *namespaces[NUM_NAMESPACES];
 	unsigned long long blk_avail, blk_avail_orig, expect;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0))) {
-		ndctl_test_skip(test);
+	if (!test_attempt(test, KERNEL_VERSION(4, 9, 0))) {
+		test_skip(test);
 		return 77;
 	}
 
@@ -245,7 +245,7 @@ int test_multi_pmem(int loglevel, struct test_ctx *test,
 	struct kmod_ctx *kmod_ctx;
 	int err, result = EXIT_FAILURE;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 2, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 2, 0)))
 		return 77;
 
 	ndctl_set_log_priority(ctx, loglevel);
@@ -253,7 +253,7 @@ int test_multi_pmem(int loglevel, struct test_ctx *test,
 	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		result = 77;
-		ndctl_test_skip(test);
+		test_skip(test);
 		fprintf(stderr, "%s unavailable skipping tests\n",
 				"nfit_test");
 		return result;
@@ -268,7 +268,7 @@ int test_multi_pmem(int loglevel, struct test_ctx *test,
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
@@ -279,8 +279,8 @@ int __attribute__((weak)) main(int argc, char *argv[])
 
 	rc = ndctl_new(&ctx);
 	if (rc)
-		return ndctl_test_result(test, rc);
+		return test_result(test, rc);
 	rc = test_multi_pmem(LOG_DEBUG, test, ctx);
 	ndctl_unref(ctx);
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/parent-uuid.c b/test/parent-uuid.c
index 0164de3..7b0e622 100644
--- a/test/parent-uuid.c
+++ b/test/parent-uuid.c
@@ -215,13 +215,13 @@ int test_parent_uuid(int loglevel, struct test_ctx *test,
 	struct kmod_ctx *kmod_ctx;
 	int err, result = EXIT_FAILURE;
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 3, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 3, 0)))
 		return 77;
 
 	ndctl_set_log_priority(ctx, loglevel);
 	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
-		ndctl_test_skip(test);
+		test_skip(test);
 		fprintf(stderr, "nfit_test unavailable skipping tests\n");
 		return 77;
 	}
@@ -236,7 +236,7 @@ int test_parent_uuid(int loglevel, struct test_ctx *test,
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
@@ -247,9 +247,9 @@ int __attribute__((weak)) main(int argc, char *argv[])
 
 	rc = ndctl_new(&ctx);
 	if (rc)
-		return ndctl_test_result(test, rc);
+		return test_result(test, rc);
 
 	rc = test_parent_uuid(LOG_DEBUG, test, ctx);
 	ndctl_unref(ctx);
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/pmem_namespaces.c b/test/pmem_namespaces.c
index 5e847d7..5293613 100644
--- a/test/pmem_namespaces.c
+++ b/test/pmem_namespaces.c
@@ -173,7 +173,7 @@ int test_pmem_namespaces(int log_level, struct test_ctx *test,
 	int rc = -ENXIO;
 	char bdev[50];
 
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 2, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 2, 0)))
 		return 77;
 
 	ndctl_set_log_priority(ctx, log_level);
@@ -196,7 +196,7 @@ int test_pmem_namespaces(int log_level, struct test_ctx *test,
 		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
 		if (rc < 0 || !bus) {
 			rc = 77;
-			ndctl_test_skip(test);
+			test_skip(test);
 			fprintf(stderr, "nfit_test unavailable skipping tests\n");
 			goto err_module;
 		}
@@ -262,7 +262,7 @@ int test_pmem_namespaces(int log_level, struct test_ctx *test,
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
@@ -274,9 +274,9 @@ int __attribute__((weak)) main(int argc, char *argv[])
 
 	rc = ndctl_new(&ctx);
 	if (rc)
-		return ndctl_test_result(test, rc);
+		return test_result(test, rc);
 
 	rc = test_pmem_namespaces(LOG_DEBUG, test, ctx);
 	ndctl_unref(ctx);
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/test/revoke-devmem.c b/test/revoke-devmem.c
index 0d67d93..ac8d81c 100644
--- a/test/revoke-devmem.c
+++ b/test/revoke-devmem.c
@@ -44,7 +44,7 @@ static int test_devmem(int loglevel, struct test_ctx *test,
 	ndctl_set_log_priority(ctx, loglevel);
 
 	/* iostrict devmem started in kernel 4.5 */
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 5, 0)))
+	if (!test_attempt(test, KERNEL_VERSION(4, 5, 0)))
 		return 77;
 
 	ndns = ndctl_get_test_dev(ctx);
@@ -124,7 +124,7 @@ out_devmem:
 
 int main(int argc, char *argv[])
 {
-	struct test_ctx *test = ndctl_test_new(0);
+	struct test_ctx *test = test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
@@ -135,9 +135,9 @@ int main(int argc, char *argv[])
 
 	rc = ndctl_new(&ctx);
 	if (rc < 0)
-		return ndctl_test_result(test, rc);
+		return test_result(test, rc);
 
 	rc = test_devmem(LOG_DEBUG, test, ctx);
 	ndctl_unref(ctx);
-	return ndctl_test_result(test, rc);
+	return test_result(test, rc);
 }
diff --git a/README.md b/README.md
index 89dfc87..7a687ac 100644
--- a/README.md
+++ b/README.md
@@ -95,7 +95,7 @@ test/test-suite.log:
 SKIP: libndctl
 ==============
 test/init: nfit_test_init: nfit.ko: appears to be production version: /lib/modules/4.8.8-200.fc24.x86_64/kernel/drivers/acpi/nfit/nfit.ko.xz
-__ndctl_test_skip: explicit skip test_libndctl:2684
+__test_skip: explicit skip test_libndctl:2684
 nfit_test unavailable skipping tests
 ```
 
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
