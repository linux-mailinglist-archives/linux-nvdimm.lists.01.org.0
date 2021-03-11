Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D6B336D46
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Mar 2021 08:48:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1B5A9100F225A;
	Wed, 10 Mar 2021 23:48:53 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 26114100F2253
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 23:48:50 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id p21so13149558pgl.12
        for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 23:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XsQcKFUHnT+e9tJa0fXwky3kSM9G3uLObTgz2UIALwk=;
        b=AvdIe/kWIezhiWgSUf57lcmHUxPzAiaz4Z3Xq/pWDSv97BlTd4BeuGUCeKjfGCiPPY
         T1UmgtDv2Q/w3Ps94CBXH/k7AY/3ITV6jgyYllaLk0Te4Jvh3vISZSOdW3RLVVhx3UE0
         108DDX3N24MgxdLSSb3kh1qA22VKi0lQLWh84EU38P+89wc/yoqjOismItkwjxEvH0K3
         L97GJupMmmugxYw84cG5n/SzeDpLHPRS2OMsuMbvDuanjckb9wMlwtJASUQcff2B7Not
         Ts4zWjueYpHG+vOef4/wsGHubORinJRtpmDekoGlEEBPzDYEI6ZKlAK9/BPDlBeQ08Uz
         qPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XsQcKFUHnT+e9tJa0fXwky3kSM9G3uLObTgz2UIALwk=;
        b=Fh5ojQ0AuPfe+DXDjYV5QAuYHpqQK9IajZOLK1fXSG0AZe0RkxlkXECH3Wz2wHpIfP
         H1P8aqQKVSdK0yZLlxRJCPKdh93pxATVIfwUkHJx6FwtSc4L0aPcTy+avmPwMpu0TnvN
         XnrOrlXjUO/Pa3sC0+toRDnStu5dDTM94kEvbEyNM+E06fjEwv3zxQVOFi6deMJ9s1RA
         SOb4Rwuj3VlY1XtPw1wbKv4/dq11KzsY0iB+he0RfAWhtKuMLapxsvJhBa+qlLEDxbOE
         jrsHx9f7mvWCBPs2Cr4QfV0j3hCLBRAjD7zz8kYR/4VCAtjQvKDMRLTrS/nvKxUCifaD
         5roA==
X-Gm-Message-State: AOAM533ZJBf72CScC70SgK0eSvlcNxDuuKOpwI3gVtI+FcxY2+e8PvDO
	bBc919Fiimoi4VD+ZM2aGhfJoMTljfUcbQ==
X-Google-Smtp-Source: ABdhPJymRBfngJh1VcdJks100AnzJn/Abb9rnuT9j+lTx9JTai45Jco5aj+Cy1JCKwGWEw+VtG+0ZQ==
X-Received: by 2002:a63:1a51:: with SMTP id a17mr3299588pgm.125.1615448929326;
        Wed, 10 Mar 2021 23:48:49 -0800 (PST)
Received: from localhost.localdomain ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id t13sm1528580pfe.161.2021.03.10.23.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 23:48:49 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl PATCH v3 2/4] test: Don't skip tests if nfit modules are missing
Date: Thu, 11 Mar 2021 13:16:50 +0530
Message-Id: <20210311074652.2783560-2-santosh@fossix.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311074652.2783560-1-santosh@fossix.org>
References: <20210311074652.2783560-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: MM6IKZTY75SV4PAYKOGZFGCUAFPBTZ6X
X-Message-ID-Hash: MM6IKZTY75SV4PAYKOGZFGCUAFPBTZ6X
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MM6IKZTY75SV4PAYKOGZFGCUAFPBTZ6X/>
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
index cc7d8d9..903034a 100644
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
+	int rc, family = NVDIMM_FAMILY_INTEL;
 	unsigned int i;
 	const char *name;
 	struct ndctl_bus *bus;
@@ -127,6 +128,19 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
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
@@ -185,6 +199,11 @@ retry:
 
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
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
