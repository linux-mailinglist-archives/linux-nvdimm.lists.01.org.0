Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D32D967A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Dec 2020 11:41:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 37460100EF275;
	Mon, 14 Dec 2020 02:41:48 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1041; helo=mail-pj1-x1041.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3A6C4100EF276
	for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:41:45 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id iq13so6059710pjb.3
        for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qif9YpZbuur+TzIS1r6mFTZdfN6fJGqphVoft1K34yU=;
        b=dvoCvm78Di8iXWLpXlQI1hMMmd6ECwc4UuAq/aFGrDyx9M00/6RW3e7AhHoL3de2JM
         YvzeAlLStsrK1O+slx5tZCkte1FR5TPmuz+DDTZmJ3ffPgu2UN+TbvUPeDo7dGGXtSJL
         7WA5AeIdVyNuh55azmVjGJWwzqVfM+HEUt7mDyrW/leP5PR3VAHRHNifCFzdnxSEJhLY
         eOeowclnj0fQER+Nqerz5sUD/ulLKISEO6kSYQ6mtd2qY136pftsRXzwy1hkkGVuf9c3
         ovXg40J26e8k+SRFDsfp0NUyW4vRij0SXN4Z2e6Duq64NWwniYMDVpHmSjL98+OBaJgd
         21eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qif9YpZbuur+TzIS1r6mFTZdfN6fJGqphVoft1K34yU=;
        b=YbSau2uLZIZAYHnjB+MFcysKLWa2RMab1DYcpizZNEtHmYQAoLCAQlTSIdeIBGHYLR
         2E5nH/WK68zxppaBCBo2tHKMH6s6AKIyG+4JW5tyfZOW7VtlWre4CMx3N8oDcGMGDqm4
         x+Syphatv2Hy5Ek9f5jDI0QWRhGL3y2ji2uRiOtKziAnttNzzjY+tcPmKk9ZETVJTVq+
         aaH5oE2lfze4flNCmGAi0kNIgdFcM7q4y6ALF/evgSUkfCePEya5+WWrHPQ0KSIWe8Xw
         RrCwJVh9v+ZVDzCFd/ortGBsaHUnl+jSy1FMur1TyQV4r5Nc4DUUdHTLXl4WmorI/6wV
         ysHQ==
X-Gm-Message-State: AOAM533SUjqXCjmb2gV3giPcOuCFJYodyqhL7uqUmNQq+SHu0HK736zE
	uAGt1a4huXipf5PHFFAMveKAgkigvd1Ylw==
X-Google-Smtp-Source: ABdhPJyvk1kAiZKT22YQUml96ybK5VSpidOHyPpm4UgNMuxHW6wt/m1C05U58K6tU4tvQkwE6nYcLQ==
X-Received: by 2002:a17:902:bb8b:b029:da:beb:b81e with SMTP id m11-20020a170902bb8bb02900da0bebb81emr22202395pls.44.1607942504567;
        Mon, 14 Dec 2020 02:41:44 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id f193sm6208581pfa.81.2020.12.14.02.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 02:41:43 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl RFC v5 2/5] test: Don't skip tests if nfit modules are missing
Date: Mon, 14 Dec 2020 16:11:23 +0530
Message-Id: <20201214104126.2410043-2-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214104126.2410043-1-santosh@fossix.org>
References: <20201214103859.2409175-1-santosh@fossix.org>
 <20201214104126.2410043-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: Q6SMJNXN4UCULNTWOWZR4EBAPCGGKNRL
X-Message-ID-Hash: Q6SMJNXN4UCULNTWOWZR4EBAPCGGKNRL
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q6SMJNXN4UCULNTWOWZR4EBAPCGGKNRL/>
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
 test/core.c                   | 15 +++++++++++++--
 test/dpa-alloc.c              |  2 +-
 test/dsm-fail.c               |  2 +-
 test/libndctl.c               |  2 +-
 test/multi-pmem.c             |  2 +-
 test/parent-uuid.c            |  2 +-
 test/pmem_namespaces.c        |  2 +-
 10 files changed, 22 insertions(+), 11 deletions(-)

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
index 5118d86..974bbc4 100644
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
@@ -138,6 +139,11 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		"nd_pmem",
 	};
 
+	if (access("/sys/bus/acpi", F_OK) == 0) {
+		if (errno == ENOENT)
+			family = NVDIMM_FAMILY_PAPR;
+	}
+
 	log_init(&log_ctx, "test/init", "NDCTL_TEST");
 	log_ctx.log_priority = log_level;
 
@@ -195,6 +201,11 @@ retry:
 
 		path = kmod_module_get_path(*mod);
 		if (!path) {
+			if (family == NVDIMM_FAMILY_INTEL &&
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
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
