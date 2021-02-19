Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2877F31F3C4
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 03:04:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 560C1100EAB7B;
	Thu, 18 Feb 2021 18:03:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B3628100F225C
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 18:03:53 -0800 (PST)
IronPort-SDR: Mm3wbPRrHdWD4JPlhZuOyyXZpkdnFZk+HEvRp9kojX5sQwbLfYMQCjMqOVSPPZ++odiT3i6w5F
 iarGlZJ3L+Tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181151505"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="181151505"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:53 -0800
IronPort-SDR: qGZR5lSwoC3/hxxopv5dvODCiX/rB9P4FYbngL1kyD8mwR97t2BytcxnqGvDHdKnjm981PvE+d
 3o0wVr5fdLdg==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="513509659"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:52 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl PATCH v2 07/13] test: introduce a libcxl unit test
Date: Thu, 18 Feb 2021 19:03:25 -0700
Message-Id: <20210219020331.725687-8-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 5TPQ2A5CCHGUD23LC53YXMZ56KHX3ME5
X-Message-ID-Hash: 5TPQ2A5CCHGUD23LC53YXMZ56KHX3ME5
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5TPQ2A5CCHGUD23LC53YXMZ56KHX3ME5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a new 'libcxl' test containing a basic harness for unit testing
libcxl APIs. Include sanity tests such as making sure the test is
running in an emulated environment, the ability to load and unload
modules. Submit an 'Identify Device' command, and verify that it
succeeds, and the identify data returned is as expected from an emulated
QEMU device.

Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test/libcxl-expect.h |  13 +++
 test/libcxl.c        | 268 +++++++++++++++++++++++++++++++++++++++++++
 test/Makefile.am     |  12 +-
 3 files changed, 291 insertions(+), 2 deletions(-)
 create mode 100644 test/libcxl-expect.h
 create mode 100644 test/libcxl.c

diff --git a/test/libcxl-expect.h b/test/libcxl-expect.h
new file mode 100644
index 0000000..acb8db9
--- /dev/null
+++ b/test/libcxl-expect.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 Intel Corporation. All rights reserved. */
+#ifndef __LIBCXL_EXPECT_H__
+#define __LIBCXL_EXPECT_H__
+#include <stdbool.h>
+
+#define EXPECT_FW_VER "BWFW VERSION 00"
+
+/* Identify command fields */
+#define EXPECT_CMD_IDENTIFY_PARTITION_ALIGN 0ULL
+#define EXPECT_CMD_IDENTIFY_LSA_SIZE 1024U
+
+#endif /* __LIBCXL_EXPECT_H__ */
diff --git a/test/libcxl.c b/test/libcxl.c
new file mode 100644
index 0000000..9662f34
--- /dev/null
+++ b/test/libcxl.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: LGPL-2.1
+/* Copyright (C) 2021, Intel Corporation. All rights reserved. */
+#include <stdio.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <errno.h>
+#include <unistd.h>
+#include <limits.h>
+#include <syslog.h>
+#include <libkmod.h>
+#include <sys/wait.h>
+#include <uuid/uuid.h>
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <sys/select.h>
+#include <linux/version.h>
+
+#include <util/size.h>
+#include <ccan/short_types/short_types.h>
+#include <ccan/array_size/array_size.h>
+#include <ccan/endian/endian.h>
+#include <cxl/libcxl.h>
+#include <cxl/cxl_mem.h>
+#include <test.h>
+#include "libcxl-expect.h"
+
+#define TEST_SKIP 77
+
+const char *mod_list[] = {
+	"cxl_mem",
+	"cxl_bus",
+};
+
+static int test_cxl_presence(struct cxl_ctx *ctx)
+{
+	struct cxl_memdev *memdev;
+	int count = 0;
+
+	cxl_memdev_foreach(ctx, memdev)
+		count++;
+
+	if (count == 0) {
+		fprintf(stderr, "%s: no cxl memdevs found\n", __func__);
+		return TEST_SKIP;
+	}
+
+	return 0;
+}
+
+/*
+ * Only continue with tests if all CXL devices in the system are qemu-emulated
+ * 'fake' devices. For now, use the firmware_version to check for this. Later,
+ * this might need to be changed to a vendor specific command.
+ *
+ * TODO: Change this to produce a list of devices that are safe to run tests
+ * against, and only run subsequent tests on this list. That will allow devices
+ * from other, non-emulated sources to be present in the system, and still run
+ * these unit tests safely.
+ */
+static int test_cxl_emulation_env(struct cxl_ctx *ctx)
+{
+	struct cxl_memdev *memdev;
+
+	cxl_memdev_foreach(ctx, memdev) {
+		const char *fw;
+
+		fw = cxl_memdev_get_firmware_verison(memdev);
+		if (!fw)
+			return -ENXIO;
+		if (strcmp(fw, EXPECT_FW_VER) != 0) {
+			fprintf(stderr,
+				"%s: found non-emulation device, aborting\n",
+				__func__);
+			return TEST_SKIP;
+		}
+	}
+	return 0;
+}
+
+static int test_cxl_modules(struct cxl_ctx *ctx)
+{
+	int rc;
+	unsigned int i;
+	const char *name;
+	struct kmod_module *mod;
+	struct kmod_ctx *kmod_ctx;
+
+	kmod_ctx = kmod_new(NULL, NULL);
+	if (!kmod_ctx)
+		return -ENXIO;
+	kmod_set_log_priority(kmod_ctx, LOG_DEBUG);
+
+	/* test module removal */
+	for (i = 0; i < ARRAY_SIZE(mod_list); i++) {
+		int state;
+
+		name = mod_list[i];
+
+		rc = kmod_module_new_from_name(kmod_ctx, name, &mod);
+		if (rc) {
+			fprintf(stderr, "%s: %s.ko: missing\n", __func__, name);
+			break;
+		}
+
+		state = kmod_module_get_initstate(mod);
+		if (state == KMOD_MODULE_LIVE) {
+			rc = kmod_module_remove_module(mod, 0);
+			if (rc) {
+				fprintf(stderr,
+					"%s: %s.ko: failed to remove: %d\n",
+					__func__, name, rc);
+				break;
+			}
+		} else if (state == KMOD_MODULE_BUILTIN) {
+			fprintf(stderr,
+				"%s: %s is builtin, skipping module removal test\n",
+				__func__, name);
+		} else {
+			fprintf(stderr,
+				"%s: warning: %s.ko: unexpected state (%d), trying to continue\n",
+				__func__, name, state);
+		}
+	}
+
+	if (rc)
+		goto out;
+
+	/* test module insertion */
+	for (i = 0; i < ARRAY_SIZE(mod_list); i++) {
+		name = mod_list[i];
+		rc = kmod_module_new_from_name(kmod_ctx, name, &mod);
+		if (rc) {
+			fprintf(stderr, "%s: %s.ko: missing\n", __func__, name);
+			break;
+		}
+
+		rc = kmod_module_probe_insert_module(mod,
+				KMOD_PROBE_APPLY_BLACKLIST,
+				NULL, NULL, NULL, NULL);
+	}
+
+out:
+	kmod_unref(kmod_ctx);
+	return rc;
+}
+
+#define expect(c, name, field, expect) \
+do { \
+	if (cxl_cmd_##name##_get_##field(c) != expect) { \
+		fprintf(stderr, \
+			"%s: %s: " #field " mismatch\n", \
+			__func__, cxl_cmd_get_devname(c)); \
+		cxl_cmd_unref(cmd); \
+		return -ENXIO; \
+	} \
+} while (0)
+
+static int test_cxl_cmd_identify(struct cxl_ctx *ctx)
+{
+	struct cxl_memdev *memdev;
+	struct cxl_cmd *cmd;
+	int rc;
+
+	cxl_memdev_foreach(ctx, memdev) {
+		char fw_rev[0x10];
+
+		cmd = cxl_cmd_new_identify(memdev);
+		if (!cmd)
+			return -ENOMEM;
+		rc = cxl_cmd_submit(cmd);
+		if (rc < 0) {
+			fprintf(stderr, "%s: %s: cmd submission failed: %s\n",
+				__func__, cxl_memdev_get_devname(memdev),
+				strerror(-rc));
+			goto out_fail;
+		}
+		rc = cxl_cmd_get_mbox_status(cmd);
+		if (rc) {
+			fprintf(stderr,
+				"%s: %s: cmd failed with firmware status: %d\n",
+				__func__, cxl_memdev_get_devname(memdev), rc);
+			rc = -ENXIO;
+			goto out_fail;
+		}
+
+		rc = cxl_cmd_identify_get_fw_rev(cmd, fw_rev, 0x10);
+		if (rc)
+			goto out_fail;
+		if (strncmp(fw_rev, EXPECT_FW_VER, 0x10) != 0) {
+			fprintf(stderr,
+				"%s: fw_rev mismatch. Expected %s, got %s\n",
+				__func__, EXPECT_FW_VER, fw_rev);
+			rc = -ENXIO;
+			goto out_fail;
+		}
+
+		expect(cmd, identify, lsa_size, EXPECT_CMD_IDENTIFY_LSA_SIZE);
+		expect(cmd, identify, partition_align,
+			EXPECT_CMD_IDENTIFY_PARTITION_ALIGN);
+		cxl_cmd_unref(cmd);
+	}
+	return 0;
+
+out_fail:
+	cxl_cmd_unref(cmd);
+	return rc;
+}
+
+typedef int (*do_test_fn)(struct cxl_ctx *ctx);
+
+static do_test_fn do_test[] = {
+	test_cxl_modules,
+	test_cxl_presence,
+	test_cxl_emulation_env,
+	test_cxl_cmd_identify,
+};
+
+static int test_libcxl(int loglevel, struct test_ctx *test, struct cxl_ctx *ctx)
+{
+	unsigned int i;
+	int err, result = EXIT_FAILURE;
+
+	if (!test_attempt(test, KERNEL_VERSION(5, 12, 0)))
+		return 77;
+
+	cxl_set_log_priority(ctx, loglevel);
+	cxl_set_private_data(ctx, test);
+
+	for (i = 0; i < ARRAY_SIZE(do_test); i++) {
+		err = do_test[i](ctx);
+		if (err < 0) {
+			fprintf(stderr, "test[%d] failed: %d\n", i, err);
+			break;
+		} else if (err == TEST_SKIP) {
+			fprintf(stderr, "test[%d]: SKIP\n", i);
+			test_skip(test);
+			result = TEST_SKIP;
+			break;
+		}
+		fprintf(stderr, "test[%d]: PASS\n", i);
+	}
+
+	if (i >= ARRAY_SIZE(do_test))
+		result = EXIT_SUCCESS;
+	return result;
+}
+
+int __attribute__((weak)) main(int argc, char *argv[])
+{
+	struct test_ctx *test = test_new(0);
+	struct cxl_ctx *ctx;
+	int rc;
+
+	if (!test) {
+		fprintf(stderr, "failed to initialize test\n");
+		return EXIT_FAILURE;
+	}
+
+	rc = cxl_new(&ctx);
+	if (rc)
+		return test_result(test, rc);
+	rc = test_libcxl(LOG_DEBUG, test, ctx);
+	cxl_unref(ctx);
+	return test_result(test, rc);
+}
diff --git a/test/Makefile.am b/test/Makefile.am
index c5b8764..ce492a4 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -44,7 +44,8 @@ check_PROGRAMS =\
 	hugetlb \
 	daxdev-errors \
 	ack-shutdown-count-set \
-	list-smart-dimm
+	list-smart-dimm \
+	libcxl
 
 if ENABLE_DESTRUCTIVE
 TESTS +=\
@@ -61,7 +62,8 @@ TESTS +=\
 	daxctl-devices.sh \
 	daxctl-create.sh \
 	dm.sh \
-	mmap.sh
+	mmap.sh \
+	libcxl
 
 if ENABLE_KEYUTILS
 TESTS += security.sh
@@ -190,3 +192,9 @@ list_smart_dimm_LDADD = \
 		$(JSON_LIBS) \
 		$(UUID_LIBS) \
 		../libutil.a
+
+LIBCXL_LIB =\
+	../cxl/lib/libcxl.la
+
+libcxl_SOURCES = libcxl.c $(testcore)
+libcxl_LDADD = $(LIBCXL_LIB) $(UUID_LIBS) $(KMOD_LIBS)
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
