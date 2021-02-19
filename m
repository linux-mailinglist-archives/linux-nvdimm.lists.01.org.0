Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DFC31F3C2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 03:04:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 084A6100EAAE7;
	Thu, 18 Feb 2021 18:03:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C6BE8100EBBD7
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 18:03:52 -0800 (PST)
IronPort-SDR: 6DqnmSz8xtqpTUfzEYCAuHD6SETC7TiDrdpX0+mlNl+QjfaXS/KinQ9ivcx9uO0vJLeZ8F/7AC
 Obb7eHuiTRuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181151496"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="181151496"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:52 -0800
IronPort-SDR: yIlRRH9BLXKB8N2Y49ZF8FZgJsO83etyT1wDWRSxmSQDqcvW6o1VuLsoFpdBkiGh3xcWMxSmRj
 ZlyYqIqg8uuA==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="513509644"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:51 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl PATCH v2 05/13] test: rename 'ndctl_test' to 'test_ctx'
Date: Thu, 18 Feb 2021 19:03:23 -0700
Message-Id: <20210219020331.725687-6-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: PSHBRBTXZ7HEHNIZYEXWC7D7NMS66V2J
X-Message-ID-Hash: PSHBRBTXZ7HEHNIZYEXWC7D7NMS66V2J
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PSHBRBTXZ7HEHNIZYEXWC7D7NMS66V2J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for using the common test core for libcxl tests, rename
the 'ndctl_test' structure to 'test_ctx'

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test.h                        | 36 +++++++++++++++++------------------
 ndctl/bat.c                   |  2 +-
 ndctl/test.c                  |  2 +-
 test/ack-shutdown-count-set.c |  8 ++++----
 test/blk_namespaces.c         |  6 +++---
 test/core.c                   | 20 +++++++++----------
 test/dax-dev.c                |  4 ++--
 test/dax-pmd.c                |  9 +++++----
 test/dax-poison.c             |  4 ++--
 test/daxdev-errors.c          |  2 +-
 test/device-dax.c             | 10 +++++-----
 test/dpa-alloc.c              |  6 +++---
 test/dsm-fail.c               |  6 +++---
 test/libndctl.c               | 34 ++++++++++++++++-----------------
 test/multi-pmem.c             |  9 +++++----
 test/parent-uuid.c            |  5 +++--
 test/pmem_namespaces.c        |  6 +++---
 test/revoke-devmem.c          |  6 +++---
 18 files changed, 89 insertions(+), 86 deletions(-)

diff --git a/test.h b/test.h
index cba8d41..216e2b4 100644
--- a/test.h
+++ b/test.h
@@ -4,16 +4,16 @@
 #define __TEST_H__
 #include <stdbool.h>
 
-struct ndctl_test;
+struct test_ctx;
 struct ndctl_ctx;
-struct ndctl_test *ndctl_test_new(unsigned int kver);
-int ndctl_test_result(struct ndctl_test *test, int rc);
-int ndctl_test_get_skipped(struct ndctl_test *test);
-int ndctl_test_get_attempted(struct ndctl_test *test);
-int __ndctl_test_attempt(struct ndctl_test *test, unsigned int kver,
+struct test_ctx *ndctl_test_new(unsigned int kver);
+int ndctl_test_result(struct test_ctx *test, int rc);
+int ndctl_test_get_skipped(struct test_ctx *test);
+int ndctl_test_get_attempted(struct test_ctx *test);
+int __ndctl_test_attempt(struct test_ctx *test, unsigned int kver,
 		const char *caller, int line);
 #define ndctl_test_attempt(t, v) __ndctl_test_attempt(t, v, __func__, __LINE__)
-void __ndctl_test_skip(struct ndctl_test *test, const char *caller, int line);
+void __ndctl_test_skip(struct test_ctx *test, const char *caller, int line);
 #define ndctl_test_skip(t) __ndctl_test_skip(t, __func__, __LINE__)
 struct ndctl_namespace *ndctl_get_test_dev(struct ndctl_ctx *ctx);
 void builtin_xaction_namespace_reset(void);
@@ -22,27 +22,27 @@ struct kmod_ctx;
 struct kmod_module;
 int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		struct ndctl_ctx *nd_ctx, int log_level,
-		struct ndctl_test *test);
+		struct test_ctx *test);
 
 struct ndctl_ctx;
-int test_parent_uuid(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx);
-int test_multi_pmem(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx);
+int test_parent_uuid(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx);
+int test_multi_pmem(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx);
 int test_dax_directio(int dax_fd, unsigned long align, void *dax_addr, off_t offset);
-int test_dax_remap(struct ndctl_test *test, int dax_fd, unsigned long align, void *dax_addr,
+int test_dax_remap(struct test_ctx *test, int dax_fd, unsigned long align, void *dax_addr,
 		off_t offset, bool fsdax);
 #ifdef ENABLE_POISON
-int test_dax_poison(struct ndctl_test *test, int dax_fd, unsigned long align,
+int test_dax_poison(struct test_ctx *test, int dax_fd, unsigned long align,
 		void *dax_addr, off_t offset, bool fsdax);
 #else
-static inline int test_dax_poison(struct ndctl_test *test, int dax_fd,
+static inline int test_dax_poison(struct test_ctx *test, int dax_fd,
 		unsigned long align, void *dax_addr, off_t offset, bool fsdax)
 {
 	return 0;
 }
 #endif
-int test_dpa_alloc(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx);
-int test_dsm_fail(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx);
-int test_libndctl(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx);
-int test_blk_namespaces(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx);
-int test_pmem_namespaces(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx);
+int test_dpa_alloc(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx);
+int test_dsm_fail(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx);
+int test_libndctl(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx);
+int test_blk_namespaces(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx);
+int test_pmem_namespaces(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx);
 #endif /* __TEST_H__ */
diff --git a/ndctl/bat.c b/ndctl/bat.c
index ef00a3b..18773fd 100644
--- a/ndctl/bat.c
+++ b/ndctl/bat.c
@@ -9,7 +9,7 @@
 int cmd_bat(int argc, const char **argv, struct ndctl_ctx *ctx)
 {
 	int loglevel = LOG_DEBUG, i, rc;
-	struct ndctl_test *test;
+	struct test_ctx *test;
 	bool force = false;
 	const char * const u[] = {
 		"ndctl bat [<options>]",
diff --git a/ndctl/test.c b/ndctl/test.c
index 6a05d8d..7af3681 100644
--- a/ndctl/test.c
+++ b/ndctl/test.c
@@ -18,7 +18,7 @@ static char *result(int rc)
 
 int cmd_test(int argc, const char **argv, struct ndctl_ctx *ctx)
 {
-	struct ndctl_test *test;
+	struct test_ctx *test;
 	int loglevel = LOG_DEBUG, i, rc;
 	const char * const u[] = {
 		"ndctl test [<options>]",
diff --git a/test/ack-shutdown-count-set.c b/test/ack-shutdown-count-set.c
index fb1d82b..37262cf 100644
--- a/test/ack-shutdown-count-set.c
+++ b/test/ack-shutdown-count-set.c
@@ -54,7 +54,7 @@ static void reset_bus(struct ndctl_bus *bus)
 		ndctl_dimm_zero_labels(dimm);
 }
 
-static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
+static int do_test(struct ndctl_ctx *ctx, struct test_ctx *test)
 {
 	struct ndctl_bus *bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
 	struct ndctl_dimm *dimm;
@@ -91,8 +91,8 @@ out:
 	return rc;
 }
 
-static int test_ack_shutdown_count_set(int loglevel, struct ndctl_test *test,
-		struct ndctl_ctx *ctx)
+static int test_ack_shutdown_count_set(int loglevel, struct test_ctx *test,
+				       struct ndctl_ctx *ctx)
 {
 	struct kmod_module *mod;
 	struct kmod_ctx *kmod_ctx;
@@ -117,7 +117,7 @@ static int test_ack_shutdown_count_set(int loglevel, struct ndctl_test *test,
 
 int main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
diff --git a/test/blk_namespaces.c b/test/blk_namespaces.c
index d7f00cb..aa221b8 100644
--- a/test/blk_namespaces.c
+++ b/test/blk_namespaces.c
@@ -198,8 +198,8 @@ static int ns_do_io(const char *bdev)
 
 static const char *comm = "test-blk-namespaces";
 
-int test_blk_namespaces(int log_level, struct ndctl_test *test,
-		struct ndctl_ctx *ctx)
+int test_blk_namespaces(int log_level, struct test_ctx *test,
+			struct ndctl_ctx *ctx)
 {
 	char bdev[50];
 	int rc = -ENXIO;
@@ -337,7 +337,7 @@ int test_blk_namespaces(int log_level, struct ndctl_test *test,
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
diff --git a/test/core.c b/test/core.c
index cc7d8d9..bde40bb 100644
--- a/test/core.c
+++ b/test/core.c
@@ -15,7 +15,7 @@
 
 #define KVER_STRLEN 20
 
-struct ndctl_test {
+struct test_ctx {
 	unsigned int kver;
 	int attempt;
 	int skip;
@@ -38,9 +38,9 @@ static unsigned int get_system_kver(void)
 	return KERNEL_VERSION(a,b,c);
 }
 
-struct ndctl_test *ndctl_test_new(unsigned int kver)
+struct test_ctx *ndctl_test_new(unsigned int kver)
 {
-	struct ndctl_test *test = calloc(1, sizeof(*test));
+	struct test_ctx *test = calloc(1, sizeof(*test));
 
 	if (!test)
 		return NULL;
@@ -53,7 +53,7 @@ struct ndctl_test *ndctl_test_new(unsigned int kver)
 	return test;
 }
 
-int ndctl_test_result(struct ndctl_test *test, int rc)
+int ndctl_test_result(struct test_ctx *test, int rc)
 {
 	if (ndctl_test_get_skipped(test))
 		fprintf(stderr, "attempted: %d skipped: %d\n",
@@ -74,8 +74,8 @@ static char *kver_str(char *buf, unsigned int kver)
 	return buf;
 }
 
-int __ndctl_test_attempt(struct ndctl_test *test, unsigned int kver,
-		const char *caller, int line)
+int __ndctl_test_attempt(struct test_ctx *test, unsigned int kver,
+			 const char *caller, int line)
 {
 	char requires[KVER_STRLEN], current[KVER_STRLEN];
 
@@ -89,26 +89,26 @@ int __ndctl_test_attempt(struct ndctl_test *test, unsigned int kver,
 	return 0;
 }
 
-void __ndctl_test_skip(struct ndctl_test *test, const char *caller, int line)
+void __ndctl_test_skip(struct test_ctx *test, const char *caller, int line)
 {
 	test->skip++;
 	test->attempt = test->skip;
 	fprintf(stderr, "%s: explicit skip %s:%d\n", __func__, caller, line);
 }
 
-int ndctl_test_get_attempted(struct ndctl_test *test)
+int ndctl_test_get_attempted(struct test_ctx *test)
 {
 	return test->attempt;
 }
 
-int ndctl_test_get_skipped(struct ndctl_test *test)
+int ndctl_test_get_skipped(struct test_ctx *test)
 {
 	return test->skip;
 }
 
 int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		struct ndctl_ctx *nd_ctx, int log_level,
-		struct ndctl_test *test)
+		struct test_ctx *test)
 {
 	int rc;
 	unsigned int i;
diff --git a/test/dax-dev.c b/test/dax-dev.c
index 6a1b76d..99eda26 100644
--- a/test/dax-dev.c
+++ b/test/dax-dev.c
@@ -87,7 +87,7 @@ struct ndctl_namespace *ndctl_get_test_dev(struct ndctl_ctx *ctx)
 	return rc ? NULL : ndns;
 }
 
-static int emit_e820_device(int loglevel, struct ndctl_test *test)
+static int emit_e820_device(int loglevel, struct test_ctx *test)
 {
 	int err;
 	struct ndctl_ctx *ctx;
@@ -118,7 +118,7 @@ static int emit_e820_device(int loglevel, struct ndctl_test *test)
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	int rc;
 
 	if (!test) {
diff --git a/test/dax-pmd.c b/test/dax-pmd.c
index 401826d..a362b14 100644
--- a/test/dax-pmd.c
+++ b/test/dax-pmd.c
@@ -37,8 +37,9 @@ static void sigbus(int sig, siginfo_t *siginfo, void *d)
 	siglongjmp(sj_env, 1);
 }
 
-int test_dax_remap(struct ndctl_test *test, int dax_fd, unsigned long align, void *dax_addr,
-		off_t offset, bool fsdax)
+int test_dax_remap(struct test_ctx *test, int dax_fd, unsigned long align,
+		   void *dax_addr,
+		   off_t offset, bool fsdax)
 {
 	void *anon, *remap, *addr;
 	struct sigaction act;
@@ -271,7 +272,7 @@ int test_dax_directio(int dax_fd, unsigned long align, void *dax_addr, off_t off
 }
 
 /* test_pmd assumes that fd references a pre-allocated + dax-capable file */
-static int test_pmd(struct ndctl_test *test, int fd)
+static int test_pmd(struct test_ctx *test, int fd)
 {
 	unsigned long long m_align, p_align, pmd_off;
 	static const bool fsdax = true;
@@ -350,7 +351,7 @@ err_mmap:
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	int fd, rc;
 
 	if (!test) {
diff --git a/test/dax-poison.c b/test/dax-poison.c
index a4ef12e..800faaf 100644
--- a/test/dax-poison.c
+++ b/test/dax-poison.c
@@ -43,8 +43,8 @@ static void sigbus_hdl(int sig, siginfo_t *si, void *ptr)
 	siglongjmp(sj_env, 1);
 }
 
-int test_dax_poison(struct ndctl_test *test, int dax_fd, unsigned long align,
-		void *dax_addr, off_t offset, bool fsdax)
+int test_dax_poison(struct test_ctx *test, int dax_fd, unsigned long align,
+		    void *dax_addr, off_t offset, bool fsdax)
 {
 	unsigned char *addr = MAP_FAILED;
 	struct sigaction act;
diff --git a/test/daxdev-errors.c b/test/daxdev-errors.c
index fbbea21..4cb6b4d 100644
--- a/test/daxdev-errors.c
+++ b/test/daxdev-errors.c
@@ -29,7 +29,7 @@
 
 struct check_cmd {
 	struct ndctl_cmd *cmd;
-	struct ndctl_test *test;
+	struct test_ctx *test;
 };
 
 static sigjmp_buf sj_env;
diff --git a/test/device-dax.c b/test/device-dax.c
index 5f0da29..47ea04f 100644
--- a/test/device-dax.c
+++ b/test/device-dax.c
@@ -90,7 +90,7 @@ static void sigbus(int sig, siginfo_t *siginfo, void *d)
 #define VERIFY_TIME(x) (suseconds_t) ((ALIGN(x, SZ_2M) / SZ_4K) * 60)
 
 static int verify_data(struct daxctl_dev *dev, char *dax_buf,
-		unsigned long align, int salt, struct ndctl_test *test)
+		unsigned long align, int salt, struct test_ctx *test)
 {
 	struct timeval tv1, tv2, tv_diff;
 	unsigned long i;
@@ -129,7 +129,7 @@ static int verify_data(struct daxctl_dev *dev, char *dax_buf,
 }
 
 static int __test_device_dax(unsigned long align, int loglevel,
-		struct ndctl_test *test, struct ndctl_ctx *ctx)
+		struct test_ctx *test, struct ndctl_ctx *ctx)
 {
 	unsigned long i;
 	struct sigaction act;
@@ -361,8 +361,8 @@ static int __test_device_dax(unsigned long align, int loglevel,
 	return rc;
 }
 
-static int test_device_dax(int loglevel, struct ndctl_test *test,
-		struct ndctl_ctx *ctx)
+static int test_device_dax(int loglevel, struct test_ctx *test,
+			   struct ndctl_ctx *ctx)
 {
 	unsigned long i, aligns[] = { SZ_4K, SZ_2M, SZ_1G };
 	int rc;
@@ -378,7 +378,7 @@ static int test_device_dax(int loglevel, struct ndctl_test *test,
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
index e922009..56a3eff 100644
--- a/test/dpa-alloc.c
+++ b/test/dpa-alloc.c
@@ -32,7 +32,7 @@ struct test_dpa_namespace {
 
 #define MIN_SIZE SZ_4M
 
-static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
+static int do_test(struct ndctl_ctx *ctx, struct test_ctx *test)
 {
 	unsigned int default_available_slots, available_slots, i;
 	struct ndctl_region *region, *blk_region = NULL;
@@ -279,7 +279,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	return 0;
 }
 
-int test_dpa_alloc(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
+int test_dpa_alloc(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx)
 {
 	struct kmod_module *mod;
 	struct kmod_ctx *kmod_ctx;
@@ -306,7 +306,7 @@ int test_dpa_alloc(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
diff --git a/test/dsm-fail.c b/test/dsm-fail.c
index 9dfd8b0..baba9a1 100644
--- a/test/dsm-fail.c
+++ b/test/dsm-fail.c
@@ -174,7 +174,7 @@ static int test_regions_enable(struct ndctl_bus *bus,
 	return 0;
 }
 
-static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
+static int do_test(struct ndctl_ctx *ctx, struct test_ctx *test)
 {
 	struct ndctl_bus *bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
 	struct ndctl_region *region, *victim_region = NULL;
@@ -339,7 +339,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	return err;
 }
 
-int test_dsm_fail(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
+int test_dsm_fail(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx)
 {
 	struct kmod_module *mod;
 	struct kmod_ctx *kmod_ctx;
@@ -364,7 +364,7 @@ int test_dsm_fail(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
diff --git a/test/libndctl.c b/test/libndctl.c
index 24d72b3..9917fa9 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -613,7 +613,7 @@ static int validate_dax(struct ndctl_dax *dax)
 	const char *devname = ndctl_namespace_get_devname(ndns);
 	struct ndctl_region *region = ndctl_dax_get_region(dax);
 	struct ndctl_ctx *ctx = ndctl_dax_get_ctx(dax);
-	struct ndctl_test *test = ndctl_get_private_data(ctx);
+	struct test_ctx *test = ndctl_get_private_data(ctx);
 	struct daxctl_region *dax_region = NULL, *found;
 	int rc = -ENXIO, fd, count, dax_expect;
 	struct daxctl_dev *dax_dev, *seed;
@@ -725,7 +725,7 @@ static int __check_dax_create(struct ndctl_region *region,
 {
 	struct ndctl_dax *dax_seed = ndctl_region_get_dax_seed(region);
 	struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
-	struct ndctl_test *test = ndctl_get_private_data(ctx);
+	struct test_ctx *test = ndctl_get_private_data(ctx);
 	enum ndctl_namespace_mode mode;
 	struct ndctl_dax *dax;
 	const char *devname;
@@ -835,7 +835,7 @@ static int __check_pfn_create(struct ndctl_region *region,
 {
 	struct ndctl_pfn *pfn_seed = ndctl_region_get_pfn_seed(region);
 	struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
-	struct ndctl_test *test = ndctl_get_private_data(ctx);
+	struct test_ctx *test = ndctl_get_private_data(ctx);
 	enum ndctl_namespace_mode mode;
 	struct ndctl_pfn *pfn;
 	const char *devname;
@@ -978,7 +978,7 @@ static int check_btt_size(struct ndctl_btt *btt)
 	unsigned long long actual, expect;
 	int size_select, sect_select;
 	struct ndctl_ctx *ctx = ndctl_btt_get_ctx(btt);
-	struct ndctl_test *test = ndctl_get_private_data(ctx);
+	struct test_ctx *test = ndctl_get_private_data(ctx);
 	struct ndctl_namespace *ndns = ndctl_btt_get_namespace(btt);
 
 	if (!ndns)
@@ -1049,7 +1049,7 @@ static int check_btt_create(struct ndctl_region *region, struct ndctl_namespace
 		struct namespace *namespace)
 {
 	struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
-	struct ndctl_test *test = ndctl_get_private_data(ctx);
+	struct test_ctx *test = ndctl_get_private_data(ctx);
 	struct btt *btt_s = namespace->btt_settings;
 	int i, fd, retry = 10;
 	struct ndctl_btt *btt;
@@ -1257,7 +1257,7 @@ static int check_pfn_autodetect(struct ndctl_bus *bus,
 	struct ndctl_region *region = ndctl_namespace_get_region(ndns);
 	struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
 	const char *devname = ndctl_namespace_get_devname(ndns);
-	struct ndctl_test *test = ndctl_get_private_data(ctx);
+	struct test_ctx *test = ndctl_get_private_data(ctx);
 	struct pfn *auto_pfn = namespace->pfn_settings;
 	struct ndctl_pfn *pfn, *found = NULL;
 	enum ndctl_namespace_mode mode;
@@ -1354,7 +1354,7 @@ static int check_dax_autodetect(struct ndctl_bus *bus,
 	struct ndctl_region *region = ndctl_namespace_get_region(ndns);
 	struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
 	const char *devname = ndctl_namespace_get_devname(ndns);
-	struct ndctl_test *test = ndctl_get_private_data(ctx);
+	struct test_ctx *test = ndctl_get_private_data(ctx);
 	struct dax *auto_dax = namespace->dax_settings;
 	struct ndctl_dax *dax, *found = NULL;
 	enum ndctl_namespace_mode mode;
@@ -1439,7 +1439,7 @@ static int check_btt_autodetect(struct ndctl_bus *bus,
 	struct ndctl_region *region = ndctl_namespace_get_region(ndns);
 	struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
 	const char *devname = ndctl_namespace_get_devname(ndns);
-	struct ndctl_test *test = ndctl_get_private_data(ctx);
+	struct test_ctx *test = ndctl_get_private_data(ctx);
 	struct btt *auto_btt = namespace->btt_settings;
 	struct ndctl_btt *btt, *found = NULL;
 	enum ndctl_namespace_mode mode;
@@ -1665,7 +1665,7 @@ static int check_namespaces(struct ndctl_region *region,
 		struct namespace **namespaces, enum ns_mode mode)
 {
 	struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
-	struct ndctl_test *test = ndctl_get_private_data(ctx);
+	struct test_ctx *test = ndctl_get_private_data(ctx);
 	struct ndctl_bus *bus = ndctl_region_get_bus(region);
 	struct ndctl_namespace **ndns_save;
 	struct namespace *namespace;
@@ -2028,7 +2028,7 @@ static int check_btts(struct ndctl_region *region, struct btt **btts)
 struct check_cmd {
 	int (*check_fn)(struct ndctl_bus *bus, struct ndctl_dimm *dimm, struct check_cmd *check);
 	struct ndctl_cmd *cmd;
-	struct ndctl_test *test;
+	struct test_ctx *test;
 };
 
 static struct check_cmd *check_cmds;
@@ -2396,7 +2396,7 @@ static int check_smart_threshold(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
 #define BITS_PER_LONG 32
 static int check_commands(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
 		unsigned long bus_commands, unsigned long dimm_commands,
-		struct ndctl_test *test)
+		struct test_ctx *test)
 {
 	/*
 	 * For now, by coincidence, these are indexed in test execution
@@ -2467,7 +2467,7 @@ static int check_commands(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
 
 static int check_dimms(struct ndctl_bus *bus, struct dimm *dimms, int n,
 		unsigned long bus_commands, unsigned long dimm_commands,
-		struct ndctl_test *test)
+		struct test_ctx *test)
 {
 	long long dsc;
 	int i, j, rc;
@@ -2588,7 +2588,7 @@ static void reset_bus(struct ndctl_bus *bus)
 		ndctl_region_enable(region);
 }
 
-static int do_test0(struct ndctl_ctx *ctx, struct ndctl_test *test)
+static int do_test0(struct ndctl_ctx *ctx, struct test_ctx *test)
 {
 	struct ndctl_bus *bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER0);
 	struct ndctl_region *region;
@@ -2646,7 +2646,7 @@ static int do_test0(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	return check_regions(bus, regions0, ARRAY_SIZE(regions0), BTT);
 }
 
-static int do_test1(struct ndctl_ctx *ctx, struct ndctl_test *test)
+static int do_test1(struct ndctl_ctx *ctx, struct test_ctx *test)
 {
 	struct ndctl_bus *bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER1);
 	int rc;
@@ -2670,13 +2670,13 @@ static int do_test1(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	return check_regions(bus, regions1, ARRAY_SIZE(regions1), BTT);
 }
 
-typedef int (*do_test_fn)(struct ndctl_ctx *ctx, struct ndctl_test *test);
+typedef int (*do_test_fn)(struct ndctl_ctx *ctx, struct test_ctx *test);
 static do_test_fn do_test[] = {
 	do_test0,
 	do_test1,
 };
 
-int test_libndctl(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
+int test_libndctl(int loglevel, struct test_ctx *test, struct ndctl_ctx *ctx)
 {
 	unsigned int i;
 	struct kmod_module *mod;
@@ -2716,7 +2716,7 @@ int test_libndctl(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
diff --git a/test/multi-pmem.c b/test/multi-pmem.c
index 3d10952..7e4f211 100644
--- a/test/multi-pmem.c
+++ b/test/multi-pmem.c
@@ -53,7 +53,7 @@ static void destroy_namespace(struct ndctl_namespace *ndns)
 
 /* Check that the namespace device is gone (if it wasn't the seed) */
 static int check_deleted(struct ndctl_region *region, const char *devname,
-		struct ndctl_test *test)
+		struct test_ctx *test)
 {
 	struct ndctl_namespace *ndns;
 
@@ -73,7 +73,7 @@ static int check_deleted(struct ndctl_region *region, const char *devname,
 	return 0;
 }
 
-static int do_multi_pmem(struct ndctl_ctx *ctx, struct ndctl_test *test)
+static int do_multi_pmem(struct ndctl_ctx *ctx, struct test_ctx *test)
 {
 	int i;
 	char devname[100];
@@ -238,7 +238,8 @@ static int do_multi_pmem(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	return 0;
 }
 
-int test_multi_pmem(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
+int test_multi_pmem(int loglevel, struct test_ctx *test,
+		    struct ndctl_ctx *ctx)
 {
 	struct kmod_module *mod;
 	struct kmod_ctx *kmod_ctx;
@@ -267,7 +268,7 @@ int test_multi_pmem(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
diff --git a/test/parent-uuid.c b/test/parent-uuid.c
index 6424e9f..0164de3 100644
--- a/test/parent-uuid.c
+++ b/test/parent-uuid.c
@@ -208,7 +208,8 @@ static int do_test(struct ndctl_ctx *ctx)
 	return 0;
 }
 
-int test_parent_uuid(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
+int test_parent_uuid(int loglevel, struct test_ctx *test,
+		     struct ndctl_ctx *ctx)
 {
 	struct kmod_module *mod;
 	struct kmod_ctx *kmod_ctx;
@@ -235,7 +236,7 @@ int test_parent_uuid(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ct
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
diff --git a/test/pmem_namespaces.c b/test/pmem_namespaces.c
index f0f2edd..5e847d7 100644
--- a/test/pmem_namespaces.c
+++ b/test/pmem_namespaces.c
@@ -161,8 +161,8 @@ static int ns_do_io(const char *bdev)
 
 static const char *comm = "test-pmem-namespaces";
 
-int test_pmem_namespaces(int log_level, struct ndctl_test *test,
-		struct ndctl_ctx *ctx)
+int test_pmem_namespaces(int log_level, struct test_ctx *test,
+			 struct ndctl_ctx *ctx)
 {
 	struct ndctl_region *region, *pmem_region = NULL;
 	struct kmod_ctx *kmod_ctx = NULL;
@@ -262,7 +262,7 @@ int test_pmem_namespaces(int log_level, struct ndctl_test *test,
 
 int __attribute__((weak)) main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
diff --git a/test/revoke-devmem.c b/test/revoke-devmem.c
index bb8979e..0d67d93 100644
--- a/test/revoke-devmem.c
+++ b/test/revoke-devmem.c
@@ -32,8 +32,8 @@ static void sigbus(int sig, siginfo_t *siginfo, void *d)
 #define err(fmt, ...) \
 	fprintf(stderr, "%s: " fmt, __func__, ##__VA_ARGS__)
 
-static int test_devmem(int loglevel, struct ndctl_test *test,
-		struct ndctl_ctx *ctx)
+static int test_devmem(int loglevel, struct test_ctx *test,
+		       struct ndctl_ctx *ctx)
 {
 	void *buf;
 	int fd, rc;
@@ -124,7 +124,7 @@ out_devmem:
 
 int main(int argc, char *argv[])
 {
-	struct ndctl_test *test = ndctl_test_new(0);
+	struct test_ctx *test = ndctl_test_new(0);
 	struct ndctl_ctx *ctx;
 	int rc;
 
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
