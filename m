Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4919F37F2DC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 May 2021 08:13:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2B55100EAB48;
	Wed, 12 May 2021 23:13:03 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 798B8100EAB48
	for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 23:13:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id j12so14285455pgh.7
        for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 23:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21lF0kFww8u+VQRqFv9/mONMyiJ9ESesCkeF8U+Ure4=;
        b=t4nBKJK29RuIQerNTRt5gqs5rZjBY7vcnB71ADMObfZE5aW2GlwsEgw+nWZOspC3EO
         qPf7Fq7H3WSQOynXzBiXzkiCJc9EDdkdLviMXuDM1EnDwZRr3ibwOGhD9YsdJaKmE4yZ
         aOIh4YljBWlEg9gguWXfudHZN44elTFYsqMEhLYudBsLauBt7xcuBbkBIbD67ROa2CwO
         F24vSererafiCs3k2l29IHC/r53/GYCRszqfuOrcpzAXh8hTtKkHc51fe7n8oMSEMI6G
         GBmaBe73EOG2OXtkIntghdi3ftj3XnE+RQE30c/N/HTWQ8GgYArubgzS1kYqQ7iO4TkC
         o9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21lF0kFww8u+VQRqFv9/mONMyiJ9ESesCkeF8U+Ure4=;
        b=NP1pOn9oYjba90j6HsqQWA0rvSC58Wr42C10zTMwfss20XgA2I/9L+U3Gsq0sUCLYu
         YR4dL8WTAjKJuNwRFLX++4qjkWsnS4VYTMXPPEVX1oR2kwWotSScHr3DfaUMZKdx9U9e
         x+IHNeEuOFkEyrkKDL3NF5hGcIDfl0dVa0Ttm6Q11Y5xCzfRTW/imFx/Z+Fb7xRkYjUJ
         +AaIMq7SIz/btCy3+f6FxhOzBhYSlS/XivDW4Dr7Mw43c8Nj+vKBB5CqI0t4Q1jH3kvT
         7wS2mtwXMoORKSia2rTHaoHn6qmPoZ2Flsj3+zJIw7z7oN2jrMvBkqfOHv984Wgi5ADV
         GBfg==
X-Gm-Message-State: AOAM530rKZCoOEp9FAXM9IdB61Hi6xSedERgloHWiFicBr7nrJ8iGjlu
	QwcjWLIWqNcJRcyOIdtYnRG8hC0AEUGSvg==
X-Google-Smtp-Source: ABdhPJyfOHoM1522kSvcmoNFz3nqYfGvkqxE55hEpShqXsK2NKaw9Hqts95wqgzatxsbIG31uks7EQ==
X-Received: by 2002:a17:90a:6285:: with SMTP id d5mr21127097pjj.3.1620886379896;
        Wed, 12 May 2021 23:12:59 -0700 (PDT)
Received: from desktop.fossix.local ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id gf21sm1422351pjb.20.2021.05.12.23.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:12:59 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [ndctl V5 2/4] test: Don't skip tests if nfit modules are missing
Date: Thu, 13 May 2021 11:42:16 +0530
Message-Id: <20210513061218.760322-2-santosh@fossix.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513061218.760322-1-santosh@fossix.org>
References: <20210513061218.760322-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: MNGBWBCI2DPZZJOCMBEQLMPEK5JJVDCM
X-Message-ID-Hash: MNGBWBCI2DPZZJOCMBEQLMPEK5JJVDCM
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MNGBWBCI2DPZZJOCMBEQLMPEK5JJVDCM/>
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
 test/core.c                   | 28 ++++++++++++++++++++++++++--
 test/dpa-alloc.c              |  2 +-
 test/dsm-fail.c               |  2 +-
 test/libndctl.c               |  2 +-
 test/multi-pmem.c             |  2 +-
 test/parent-uuid.c            |  2 +-
 test/pmem_namespaces.c        |  2 +-
 10 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/test.h b/test.h
index cba8d41..7de13fe 100644
--- a/test.h
+++ b/test.h
@@ -20,7 +20,7 @@ void builtin_xaction_namespace_reset(void);
 
 struct kmod_ctx;
 struct kmod_module;
-int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
+int ndctl_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		struct ndctl_ctx *nd_ctx, int log_level,
 		struct ndctl_test *test);
 
diff --git a/test/ack-shutdown-count-set.c b/test/ack-shutdown-count-set.c
index fb1d82b..c561ff3 100644
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
index d7f00cb..f076e85 100644
--- a/test/blk_namespaces.c
+++ b/test/blk_namespaces.c
@@ -228,7 +228,7 @@ int test_blk_namespaces(int log_level, struct ndctl_test *test,
 
 	if (!bus) {
 		fprintf(stderr, "ACPI.NFIT unavailable falling back to nfit_test\n");
-		rc = nfit_test_init(&kmod_ctx, &mod, NULL, log_level, test);
+		rc = ndctl_test_init(&kmod_ctx, &mod, NULL, log_level, test);
 		ndctl_invalidate(ctx);
 		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
 		if (rc < 0 || !bus) {
diff --git a/test/core.c b/test/core.c
index cc7d8d9..2b03aa9 100644
--- a/test/core.c
+++ b/test/core.c
@@ -11,6 +11,7 @@
 #include <util/log.h>
 #include <util/sysfs.h>
 #include <ndctl/libndctl.h>
+#include <ndctl/ndctl.h>
 #include <ccan/array_size/array_size.h>
 
 #define KVER_STRLEN 20
@@ -106,11 +107,11 @@ int ndctl_test_get_skipped(struct ndctl_test *test)
 	return test->skip;
 }
 
-int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
+int ndctl_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		struct ndctl_ctx *nd_ctx, int log_level,
 		struct ndctl_test *test)
 {
-	int rc;
+	int rc, family = -1;
 	unsigned int i;
 	const char *name;
 	struct ndctl_bus *bus;
@@ -127,10 +128,28 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		"nd_e820",
 		"nd_pmem",
 	};
+	char *test_env;
 
 	log_init(&log_ctx, "test/init", "NDCTL_TEST");
 	log_ctx.log_priority = log_level;
 
+	/*
+	 * The following two checks determine the platform family. For
+	 * Intel/platforms which support ACPI, check sysfs; for other platforms
+	 * determine from the environment variable NVDIMM_TEST_FAMILY
+	 */
+	if (access("/sys/bus/acpi", F_OK) == 0)
+		family = NVDIMM_FAMILY_INTEL;
+
+	test_env = getenv("NDCTL_TEST_FAMILY");
+	if (test_env && strcmp(test_env, "PAPR") == 0)
+		family = NVDIMM_FAMILY_PAPR;
+
+	if (family == -1) {
+		log_err(&log_ctx, "Cannot determine NVDIMM family\n");
+		return -ENOTSUP;
+	}
+
 	*ctx = kmod_new(NULL, NULL);
 	if (!*ctx)
 		return -ENXIO;
@@ -185,6 +204,11 @@ retry:
 
 		path = kmod_module_get_path(*mod);
 		if (!path) {
+			if (family != NVDIMM_FAMILY_INTEL &&
+			    (strcmp(name, "nfit") == 0 ||
+			     strcmp(name, "nd_e820") == 0))
+				continue;
+
 			log_err(&log_ctx, "%s.ko: failed to get path\n", name);
 			break;
 		}
diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
index e922009..0b3bb7a 100644
--- a/test/dpa-alloc.c
+++ b/test/dpa-alloc.c
@@ -289,7 +289,7 @@ int test_dpa_alloc(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
 		return 77;
 
 	ndctl_set_log_priority(ctx, loglevel);
-	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
+	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		ndctl_test_skip(test);
 		fprintf(stderr, "nfit_test unavailable skipping tests\n");
diff --git a/test/dsm-fail.c b/test/dsm-fail.c
index 9dfd8b0..0a6383d 100644
--- a/test/dsm-fail.c
+++ b/test/dsm-fail.c
@@ -346,7 +346,7 @@ int test_dsm_fail(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
 	int result = EXIT_FAILURE, err;
 
 	ndctl_set_log_priority(ctx, loglevel);
-	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
+	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		result = 77;
 		ndctl_test_skip(test);
diff --git a/test/libndctl.c b/test/libndctl.c
index 24d72b3..0e88fce 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -2692,7 +2692,7 @@ int test_libndctl(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
 	daxctl_set_log_priority(daxctl_ctx, loglevel);
 	ndctl_set_private_data(ctx, test);
 
-	err = nfit_test_init(&kmod_ctx, &mod, ctx, loglevel, test);
+	err = ndctl_test_init(&kmod_ctx, &mod, ctx, loglevel, test);
 	if (err < 0) {
 		ndctl_test_skip(test);
 		fprintf(stderr, "nfit_test unavailable skipping tests\n");
diff --git a/test/multi-pmem.c b/test/multi-pmem.c
index 3d10952..3ea08cc 100644
--- a/test/multi-pmem.c
+++ b/test/multi-pmem.c
@@ -249,7 +249,7 @@ int test_multi_pmem(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx
 
 	ndctl_set_log_priority(ctx, loglevel);
 
-	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
+	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		result = 77;
 		ndctl_test_skip(test);
diff --git a/test/parent-uuid.c b/test/parent-uuid.c
index 6424e9f..bded33a 100644
--- a/test/parent-uuid.c
+++ b/test/parent-uuid.c
@@ -218,7 +218,7 @@ int test_parent_uuid(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ct
 		return 77;
 
 	ndctl_set_log_priority(ctx, loglevel);
-	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
+	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
 	if (err < 0) {
 		ndctl_test_skip(test);
 		fprintf(stderr, "nfit_test unavailable skipping tests\n");
diff --git a/test/pmem_namespaces.c b/test/pmem_namespaces.c
index f0f2edd..a4db1ae 100644
--- a/test/pmem_namespaces.c
+++ b/test/pmem_namespaces.c
@@ -191,7 +191,7 @@ int test_pmem_namespaces(int log_level, struct ndctl_test *test,
 
 	if (!bus) {
 		fprintf(stderr, "ACPI.NFIT unavailable falling back to nfit_test\n");
-		rc = nfit_test_init(&kmod_ctx, &mod, NULL, log_level, test);
+		rc = ndctl_test_init(&kmod_ctx, &mod, NULL, log_level, test);
 		ndctl_invalidate(ctx);
 		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
 		if (rc < 0 || !bus) {
-- 
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
