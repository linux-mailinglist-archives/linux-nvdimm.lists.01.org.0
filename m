Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98DD383BC
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 07:26:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B024321290D5E;
	Thu,  6 Jun 2019 22:26:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=santosh@fossix.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9E8CA2125F1E7
 for <linux-nvdimm@lists.01.org>; Thu,  6 Jun 2019 22:26:15 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a186so511720pfa.5
 for <linux-nvdimm@lists.01.org>; Thu, 06 Jun 2019 22:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/d9t0inNMCVSDjXCVps9G/GCO5vVjnUm03hqw/ZiUiQ=;
 b=D9wSmyjBJVSLxr9N3sOYxxRuXYjOPmxDaPxg9Vw4w5MWT3j4iaQiGKjYIDH+lYSbLk
 gLTjSkQX0wcdM+L+dV+QWjbauQK2XIzWSSnJPM91An93PWH8rOsdFQEf3C2YVjiyZNzu
 ROpvxgji9gak5RwwYT8k39rGXw/3tIE58BmAswp1HySWBUTYnfqKvkT8fG9GnomtvVPJ
 4HbjfWENuvr0MG7mKE+OYxcw3GnyIebHFGXhb6g+KTww5HqVIVnxTrbUyhgUszw6bs8P
 qH342ZbmASIeUJ8c+xPrqUolZgDf7DsoeKchj2yOvW33KyDRULlAUAbGIo25jPb4dhIM
 POxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/d9t0inNMCVSDjXCVps9G/GCO5vVjnUm03hqw/ZiUiQ=;
 b=JK9Ir21po2lRU8geTG+lQ/A6qZPlbdEEeVZqH7mMwA+8NFhCf5B2GrN0dvdwQgIOOI
 1eISoiMltEhApxFWdgy64VkJZQqzTulApRqMpZ6Z9BS75SOA1WVMIXsIlC5KMTYuPfCY
 7oSNjWKd6R1GWDXpOF/ivMLbUfiT8/3cWqnj+qvSnBdzdf5mkknKeJMJOCfRrtSQzC95
 7A6r8l/FceLb4Zlra0MWDTPR8BmZVjYsqpFjINFofPwnzI8WTNowdxKSy0yGecuZ9kYK
 qWpHKUQkmE7edPXmcVrZfPS3B2rJfD3NSdY0Ro2uszY+lnR84yXfDCeZeH8bGO9MmnZE
 bngw==
X-Gm-Message-State: APjAAAWYCG0oiWIRe51jieqK96C106jELwzZhLexlo0QcSw8JdNEl02Z
 0DaDDnNxLwlR7VvKW7Fl22J9JAwVrn0=
X-Google-Smtp-Source: APXvYqykFKfv3KwEYeGb2KLCbcI/IPpIjR6WCYRHg9BJ+UWsk/MYhyDmlcgHjWbK6SZPxsdxRLnTKg==
X-Received: by 2002:a62:e71a:: with SMTP id s26mr12261008pfh.89.1559885174198; 
 Thu, 06 Jun 2019 22:26:14 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.76])
 by smtp.gmail.com with ESMTPSA id i3sm803858pfa.175.2019.06.06.22.26.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 06 Jun 2019 22:26:13 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] Enable ndctl tests for emulated pmem devices
Date: Fri,  7 Jun 2019 10:55:58 +0530
Message-Id: <20190607052558.15037-1-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: harish@linux.ibm.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

For QEMU emulated devices, nfit drivers need not be loaded, also the
nfit_test, libnvdimm_test modules are not required. This patch adds a
configure option to enable testing on qemu without nfit dependencies.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 configure.ac         | 30 ++++++++++++++++++++++++++++++
 test/common          | 14 +++++++++++---
 test/core.c          |  7 ++++++-
 test/create.sh       |  6 +++++-
 test/daxdev-errors.c |  1 -
 test/dpa-alloc.c     |  2 --
 test/libndctl.c      |  2 --
 7 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6dca96e..115f59e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -148,6 +148,36 @@ fi
 AC_SUBST([BASH_COMPLETION_DIR])
 AM_CONDITIONAL([ENABLE_BASH_COMPLETION], [test "x$with_bash" = "xyes"])
 
+AC_CANONICAL_HOST
+AS_CASE([$host_cpu],
+  [x86_64|arm*],
+  [
+	AC_DEFINE([ACPI], [1], ["Build for ACPI NFIT"])
+  ]
+)
+
+# Build on a qemu
+AC_ARG_ENABLE(qemu-test,
+  [ --enable-qemu-test   Enable compilation for testing on qemu],
+  [case "${enableval}" in
+     yes | no ) QEMU_PMEM_TEST="${enableval}" ;;
+     *) AC_MSG_ERROR(bad value ${enableval} for --enable-qemu-test) ;;
+   esac],
+  [QEMU_PMEM_TEST="yes"]
+)
+
+AM_CONDITIONAL([QEMU_PMEM_TEST], [test "x$QEMU_PMEM_TEST" = "xyes"])
+
+if test "x$QEMU_PMEM_TEST" = "xyes"; then
+    AC_DEFINE([QEMU_PMEM_TEST], [1], ["build for qemu pmem testing"])
+    AC_DEFINE_UNQUOTED([NFIT_PROVIDER0], [["$BUS_PROVIDER0"]], ["pmem device"])
+    AC_DEFINE_UNQUOTED([NFIT_PROVIDER1], [["$BUS_PROVIDER1"]], ["pmem device"])
+    AC_MSG_NOTICE([building for pmem testing on qemu])
+else
+    AC_DEFINE_UNQUOTED([NFIT_PROVIDER0], [["nfit_test.0"]], ["nfit device"])
+    AC_DEFINE_UNQUOTED([NFIT_PROVIDER1], [["nfit_test.1"]], ["nfit device"])
+fi
+
 AC_ARG_ENABLE([local],
         AS_HELP_STRING([--disable-local], [build against kernel ndctl.h @<:@default=system@:>@]),
         [], [enable_local=yes])
diff --git a/test/common b/test/common
index 1b9d3da..5a75e22 100644
--- a/test/common
+++ b/test/common
@@ -17,8 +17,14 @@ fi
 
 # NFIT_TEST_BUS[01]
 #
-NFIT_TEST_BUS0=nfit_test.0
-NFIT_TEST_BUS1=nfit_test.1
+if [ -z $BUS_PROVIDER0]; then
+    NFIT_TEST_BUS0=nfit_test.0
+    NFIT_TEST_BUS1=nfit_test.1
+else
+    NFIT_TEST_BUS0=$BUS_PROVIDER0
+    NFIT_TEST_BUS1=$BUS_PROVIDER1
+    QEMU_PMEM_TEST=yes
+fi
 
 
 # Functions
@@ -71,7 +77,9 @@ _cleanup()
 {
 	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
 	$NDCTL disable-region -b $NFIT_TEST_BUS1 all
-	modprobe -r nfit_test
+	if [ "x$QEMU_PMEM_TEST" = "x" ]; then
+		modprobe -r nfit_test
+	fi
 }
 
 # json2var
diff --git a/test/core.c b/test/core.c
index b9e3bbf..4f5123f 100644
--- a/test/core.c
+++ b/test/core.c
@@ -126,7 +126,9 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 	struct ndctl_bus *bus;
 	struct log_ctx log_ctx;
 	const char *list[] = {
+#ifdef ACPI
 		"nfit",
+#endif
 		"device_dax",
 		"dax_pmem",
 		"dax_pmem_core",
@@ -134,7 +136,9 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		"libnvdimm",
 		"nd_blk",
 		"nd_btt",
+#ifdef ACPI
 		"nd_e820",
+#endif
 		"nd_pmem",
 	};
 
@@ -228,10 +232,11 @@ retry:
 		/* caller wants a full nfit_test reset */
 		ndctl_bus_foreach(nd_ctx, bus) {
 			struct ndctl_region *region;
-
+#ifdef ACPI
 			if (strncmp(ndctl_bus_get_provider(bus),
 						"nfit_test", 9) != 0)
 				continue;
+#endif
 			ndctl_region_foreach(bus, region)
 				ndctl_region_disable_invalidate(region);
 		}
diff --git a/test/create.sh b/test/create.sh
index 8d78797..7fdf696 100755
--- a/test/create.sh
+++ b/test/create.sh
@@ -23,7 +23,11 @@ check_min_kver "4.5" || do_skip "may lack namespace mode attribute"
 trap 'err $LINENO' ERR
 
 # setup (reset nfit_test dimms)
-modprobe nfit_test
+if [ -z $QEMU_PMEM_TEST ]; then
+    # setup (reset nfit_test dimms)
+    modprobe nfit_test
+fi
+
 $NDCTL disable-region -b $NFIT_TEST_BUS0 all
 $NDCTL zero-labels -b $NFIT_TEST_BUS0 all
 $NDCTL enable-region -b $NFIT_TEST_BUS0 all
diff --git a/test/daxdev-errors.c b/test/daxdev-errors.c
index 29de16b..c17e42a 100644
--- a/test/daxdev-errors.c
+++ b/test/daxdev-errors.c
@@ -45,7 +45,6 @@ struct check_cmd {
 static sigjmp_buf sj_env;
 static int sig_count;
 
-static const char *NFIT_PROVIDER0 = "nfit_test.0";
 static struct check_cmd *check_cmds;
 
 static void sigbus_hdl(int sig, siginfo_t *siginfo, void *ptr)
diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
index 9a9c6b6..2f100b1 100644
--- a/test/dpa-alloc.c
+++ b/test/dpa-alloc.c
@@ -30,8 +30,6 @@
 #include <ndctl/libndctl.h>
 #include <ccan/array_size/array_size.h>
 
-static const char *NFIT_PROVIDER0 = "nfit_test.0";
-static const char *NFIT_PROVIDER1 = "nfit_test.1";
 #define NUM_NAMESPACES 4
 
 struct test_dpa_namespace {
diff --git a/test/libndctl.c b/test/libndctl.c
index 02bb9cc..6c123f8 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -94,8 +94,6 @@
  *    dimm.
  */
 
-static const char *NFIT_PROVIDER0 = "nfit_test.0";
-static const char *NFIT_PROVIDER1 = "nfit_test.1";
 #define SZ_4K   0x00001000
 #define SZ_128K 0x00020000
 #define SZ_7M   0x00700000
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
