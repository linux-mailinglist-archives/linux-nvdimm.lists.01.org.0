Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26433324A6C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Feb 2021 07:13:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8A531100EB326;
	Wed, 24 Feb 2021 22:13:14 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AAD57100EB84F
	for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 22:13:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id i14so1245141pjz.4
        for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 22:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QIXWc8wfA9Cjw0TZUWfQhKZd/QAeiKZT+i++8Gju+E=;
        b=j5ojXWZzHjFbpaKa3Ei9U2+AtjZKt/3wL1tjUUgzYwnsglOoho19epOQkafRa5wHXw
         7wEafD4NA/jJ1ETO7pnd7vXRYvFKBz1RfZA6b0JjiTcU5pyktVcGlhIwuXewzt0WHm/8
         n7paSN6pYoJIRneSU9FLxRPMSaxr7hiC0gEyBSGOe4X/QBgjjrKh5+pVtgHAtGvQ1r0+
         ZYuzpj472NQKRhZG3GHSZ+kPseWoCh44IdOT1rgKri6FQVhP2ulQCF9JawEbwYqeCjim
         XhjZJcjXG8epzc1k/p4gUJZA1JnRiqwa4gwxZGD+hZ9c7ZnNliERphCyd+gI+QTFyxI+
         Tgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QIXWc8wfA9Cjw0TZUWfQhKZd/QAeiKZT+i++8Gju+E=;
        b=il8UQXAsr0SIJvQp0xEwhaAVrcbhj8w7/qEiPrOW8P2jsXbUqUWhjfcVOVr+F8jOFw
         feCKHEBOOJXhICBQW/YITAyNfwxCURdzB74B9f1dhIHT8qSoEmFg0juxvj4n+0W+TaFH
         m83muocnHRrgj3QrYDiMO9OXalae7BYDY0Z2AH+TRqhXwdiQQcwin5cOlglhs5+44efy
         Yr2mVbvYnJJsx+heKvET3DFBQ5DFUn42wZ+ldvPTFLifwOdJ9fZzSRcO/09wgoaWLtOv
         3hOQAtFfpWbA/vkKX/5Jo+5jY/yYJi9IHt3hEVV5fa6XgUa+64lcmz2FxgNgnd01KMGM
         9a3g==
X-Gm-Message-State: AOAM530KYPLibvVRVTPxG5OuOXrk8H8X6YhRwH62PLwrQA3Kjs7A1uZ5
	DLv3qV9xGL6Atp3pBh+ys3X9g7RhgueXOQ==
X-Google-Smtp-Source: ABdhPJww3viEwDVlUf5DBw8SvVZYOdTQREAa5ppwdTCiBonRLkFrSMBBwATXGlaVxYMu98jAMDQVZw==
X-Received: by 2002:a17:90a:b38b:: with SMTP id e11mr1710199pjr.205.1614233591714;
        Wed, 24 Feb 2021 22:13:11 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id d24sm4327803pfr.139.2021.02.24.22.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 22:13:11 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH v2 1/4] test: Don't skip tests if nfit modules are missing
Date: Thu, 25 Feb 2021 11:43:00 +0530
Message-Id: <20210225061303.654267-1-santosh@fossix.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Message-ID-Hash: T4I2Q6AF7ZJKXKBVVXC3BEULW2Y6LKTO
X-Message-ID-Hash: T4I2Q6AF7ZJKXKBVVXC3BEULW2Y6LKTO
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T4I2Q6AF7ZJKXKBVVXC3BEULW2Y6LKTO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For NFIT to be available ACPI is a must, so don't fail when nfit modules
are missing on a platform that doesn't support ACPI.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test.h                        |  2 +-
 test/ack-shutdown-count-set.c |  2 +-
 test/blk_namespaces.c         |  2 +-
 test/core.c                   | 23 +++++++++++++++++++++--
 test/dpa-alloc.c              |  2 +-
 test/dsm-fail.c               |  2 +-
 test/libndctl.c               |  2 +-
 test/multi-pmem.c             |  2 +-
 test/parent-uuid.c            |  2 +-
 test/pmem_namespaces.c        |  2 +-
 10 files changed, 30 insertions(+), 11 deletions(-)

Changelog:
v2:
  * Patch 2: Fix a bug, I skip erroring out if PAPR family, but condition had INTEL family instead.
    That change was there to test the same code on x86, but accidently committed. Now have
    a environment variable to force test PAPR family on x86.

  * Patch 4: Remove stray code, artifact of refactoring in patch 1.
  
diff --git a/test.h b/test.h
index 3f6212e..94d8936 100644
--- a/test.h
+++ b/test.h
@@ -30,7 +30,7 @@ void builtin_xaction_namespace_reset(void);
 
 struct kmod_ctx;
 struct kmod_module;
-int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
+int ndctl_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		struct ndctl_ctx *nd_ctx, int log_level,
 		struct ndctl_test *test);
 
diff --git a/test/ack-shutdown-count-set.c b/test/ack-shutdown-count-set.c
index 742e976..6315a94 100644
--- a/test/ack-shutdown-count-set.c
+++ b/test/ack-shutdown-count-set.c
@@ -99,7 +99,7 @@ static int test_ack_shutdown_count_set(int loglevel, struct ndctl_test *test,
 	int result = EXIT_FAILURE, err;
 
 	ndctl_set_log_priority(ctx, loglevel);
-	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
+	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		result = 77;
 		ndctl_test_skip(test);
diff --git a/test/blk_namespaces.c b/test/blk_namespaces.c
index 437fcad..dfb0332 100644
--- a/test/blk_namespaces.c
+++ b/test/blk_namespaces.c
@@ -240,7 +240,7 @@ int test_blk_namespaces(int log_level, struct ndctl_test *test,
 
 	if (!bus) {
 		fprintf(stderr, "ACPI.NFIT unavailable falling back to nfit_test\n");
-		rc = nfit_test_init(&kmod_ctx, &mod, NULL, log_level, test);
+		rc = ndctl_test_init(&kmod_ctx, &mod, NULL, log_level, test);
 		ndctl_invalidate(ctx);
 		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
 		if (rc < 0 || !bus) {
diff --git a/test/core.c b/test/core.c
index 5118d86..8e48fd6 100644
--- a/test/core.c
+++ b/test/core.c
@@ -21,6 +21,7 @@
 #include <util/log.h>
 #include <util/sysfs.h>
 #include <ndctl/libndctl.h>
+#include <ndctl/ndctl.h>
 #include <ccan/array_size/array_size.h>
 
 #define KVER_STRLEN 20
@@ -116,11 +117,11 @@ int ndctl_test_get_skipped(struct ndctl_test *test)
 	return test->skip;
 }
 
-int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
+int ndctl_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		struct ndctl_ctx *nd_ctx, int log_level,
 		struct ndctl_test *test)
 {
-	int rc;
+	int rc, family = NVDIMM_FAMILY_INTEL;
 	unsigned int i;
 	const char *name;
 	struct ndctl_bus *bus;
@@ -137,6 +138,19 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		"nd_e820",
 		"nd_pmem",
 	};
+	char *test_env;
+
+	/* Do we want to force test PAPR? */
+	test_env = getenv("NDCTL_TEST_FAMILY");
+	if (test_env && strcmp(test_env, "PAPR") == 0)
+		family = NVDIMM_FAMILY_PAPR;
+
+	/* ACPI is a must for nfit, so if ACPI is not available let's default to
+	 * PAPR */
+	if (access("/sys/bus/acpi", F_OK) == -1) {
+		if (errno == ENOENT)
+			family = NVDIMM_FAMILY_PAPR;
+	}
 
 	log_init(&log_ctx, "test/init", "NDCTL_TEST");
 	log_ctx.log_priority = log_level;
@@ -195,6 +209,11 @@ retry:
 
 		path = kmod_module_get_path(*mod);
 		if (!path) {
+			if (family == NVDIMM_FAMILY_PAPR &&
+			    (strcmp(name, "nfit") == 0 ||
+			     strcmp(name, "nd_e820") == 0))
+				continue;
+
 			log_err(&log_ctx, "%s.ko: failed to get path\n", name);
 			break;
 		}
diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
index b757b9a..10af189 100644
--- a/test/dpa-alloc.c
+++ b/test/dpa-alloc.c
@@ -299,7 +299,7 @@ int test_dpa_alloc(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
 		return 77;
 
 	ndctl_set_log_priority(ctx, loglevel);
-	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
+	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		ndctl_test_skip(test);
 		fprintf(stderr, "nfit_test unavailable skipping tests\n");
diff --git a/test/dsm-fail.c b/test/dsm-fail.c
index b2c51db..1d03470 100644
--- a/test/dsm-fail.c
+++ b/test/dsm-fail.c
@@ -356,7 +356,7 @@ int test_dsm_fail(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
 	int result = EXIT_FAILURE, err;
 
 	ndctl_set_log_priority(ctx, loglevel);
-	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
+	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		result = 77;
 		ndctl_test_skip(test);
diff --git a/test/libndctl.c b/test/libndctl.c
index 994e0fa..5043ae0 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -2696,7 +2696,7 @@ int test_libndctl(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
 	daxctl_set_log_priority(daxctl_ctx, loglevel);
 	ndctl_set_private_data(ctx, test);
 
-	err = nfit_test_init(&kmod_ctx, &mod, ctx, loglevel, test);
+	err = ndctl_test_init(&kmod_ctx, &mod, ctx, loglevel, test);
 	if (err < 0) {
 		ndctl_test_skip(test);
 		fprintf(stderr, "nfit_test unavailable skipping tests\n");
diff --git a/test/multi-pmem.c b/test/multi-pmem.c
index cb7cd40..111aa28 100644
--- a/test/multi-pmem.c
+++ b/test/multi-pmem.c
@@ -259,7 +259,7 @@ int test_multi_pmem(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx
 
 	ndctl_set_log_priority(ctx, loglevel);
 
-	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
+	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		result = 77;
 		ndctl_test_skip(test);
diff --git a/test/parent-uuid.c b/test/parent-uuid.c
index f41ca2c..1e5a503 100644
--- a/test/parent-uuid.c
+++ b/test/parent-uuid.c
@@ -230,7 +230,7 @@ int test_parent_uuid(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ct
 		return 77;
 
 	ndctl_set_log_priority(ctx, loglevel);
-	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
+	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		ndctl_test_skip(test);
 		fprintf(stderr, "nfit_test unavailable skipping tests\n");
diff --git a/test/pmem_namespaces.c b/test/pmem_namespaces.c
index eac56ce..afa79a2 100644
--- a/test/pmem_namespaces.c
+++ b/test/pmem_namespaces.c
@@ -203,7 +203,7 @@ int test_pmem_namespaces(int log_level, struct ndctl_test *test,
 
 	if (!bus) {
 		fprintf(stderr, "ACPI.NFIT unavailable falling back to nfit_test\n");
-		rc = nfit_test_init(&kmod_ctx, &mod, NULL, log_level, test);
+		rc = ndctl_test_init(&kmod_ctx, &mod, NULL, log_level, test);
 		ndctl_invalidate(ctx);
 		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
 		if (rc < 0 || !bus) {
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
