Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B42BACDE
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Sep 2019 05:30:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 47EA7202EF28C;
	Sun, 22 Sep 2019 20:33:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=santosh@fossix.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 37EBD202ECFB2
 for <linux-nvdimm@lists.01.org>; Sun, 22 Sep 2019 20:32:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c17so7205304pgg.4
 for <linux-nvdimm@lists.01.org>; Sun, 22 Sep 2019 20:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sywvno9oH6C2x7JbbNTuKFc1cVwyreXcpG9Pmze4Bmg=;
 b=XsiDZzS9Mw2A+1DlYsO5UXdfdymh05336cO/Tgk8VrqHsocnL6VKYPDQlR37mAyF0w
 fnX8FLe4KPkQdTvbPAetfYbt3MygY9ZJT8mRoRXZ9NE1eI7VI1gTj8GWPrh91Kdx9kni
 G8MOw+HcHQn+AWI+qSqrHC8j44WHVQovHuAcaixkSsDOMQEpCDBQ0oASPmeI93q99bf0
 +iSVD8IHYE2uRK5/vLI0KdcyKiDjTk872aYlbgLjuYoIs+U3OyGdOzg1yE0TPaO8zBEt
 SYq3J58ipPI1UMo5Fa3bUuw6SmTUnONRSbLNoGUlIdYGpSFHTjdkDseSfKOTPD6vebcS
 djkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sywvno9oH6C2x7JbbNTuKFc1cVwyreXcpG9Pmze4Bmg=;
 b=mVevP8Y8JmQY9T18IpRrcvDYile3UgXyRoQN+6FpQxuujNk0+tPw62z6buuCZYKs1Z
 ZIjc90uOLdd6jvAFtqbqD03RVu2xNbMkUK0upBOmy9M1IOqIC8OSlPWGBu0ZcSXPaCko
 NgMJgJoAi7SV9TF6m6+qnUe6Fz4WVb3WtKIvAkVEKR+Gi2KcnvluyQmulre3l3bI6JAq
 S+0drfCbATR00kXg5n72yTw9P14jvZPOzkszbI4WkmNK9v9Ybx1pcMWS8KSdfpeEWbC6
 oLilYfGOPZDfulb1q9ClPCKavqX4r8J19pE2fNNDoIvOOTapaX+2gXZPVznGjqFLPu25
 KyTw==
X-Gm-Message-State: APjAAAWxgbR8e7OgDOR0rLfP0JN732gkuDT9RKllMZIroOYy9W62ZkVU
 DBa750SYsTLp0wBSJEVvCGFep94Fu2Y=
X-Google-Smtp-Source: APXvYqyLQNHUr8VS/qzdxQlGgvLcrzOc1ZUKAo9lN41iIEGM/3Ok0QtessYVRHvwTrazMuKAO++P3A==
X-Received: by 2002:a17:90a:9306:: with SMTP id
 p6mr17831475pjo.3.1569209424830; 
 Sun, 22 Sep 2019 20:30:24 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.73])
 by smtp.gmail.com with ESMTPSA id s1sm15338873pjs.31.2019.09.22.20.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2019 20:30:24 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2/2] Enable ndctl tests for emulated pmem devices
Date: Mon, 23 Sep 2019 09:00:15 +0530
Message-Id: <20190923033015.26732-2-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923033015.26732-1-santosh@fossix.org>
References: <20190923033015.26732-1-santosh@fossix.org>
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
Cc: harish@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

For QEMU emulated devices and other platforms, nfit drivers are not needed.
This patch achieves that by relying upon the environment variable called
'WITHOUT_NFIT'. If 'WITHOUT_NFIT=y', nfit drivers (nfit_test and
libnvdimm_test) are not loaded.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 configure.ac           |  8 ++++++++
 test/btt-pad-compat.sh |  5 ++++-
 test/clear.sh          |  5 ++++-
 test/common            | 19 ++++++++++++++-----
 test/core.c            |  6 ++++++
 test/create.sh         |  5 ++++-
 test/daxdev-errors.c   | 14 ++++++++++----
 test/daxdev-errors.sh  |  5 ++++-
 test/dpa-alloc.c       | 17 +++++++++++++----
 test/libndctl.c        | 21 +++++++++++++++++----
 10 files changed, 84 insertions(+), 21 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4737cff..33fbd0b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -145,6 +145,14 @@ if test "x$with_bash" = "xyes"; then
 		[BASH_COMPLETION_DIR=$($PKG_CONFIG --variable=completionsdir bash-completion)], [])
 fi
 
+AC_CANONICAL_HOST
+AS_CASE([$host_cpu],
+  [x86_64|arm*],
+  [
+	AC_DEFINE([ACPI], [1], ["Build for ACPI NFIT"])
+  ]
+)
+
 AC_SUBST([BASH_COMPLETION_DIR])
 AM_CONDITIONAL([ENABLE_BASH_COMPLETION], [test "x$with_bash" = "xyes"])
 
diff --git a/test/btt-pad-compat.sh b/test/btt-pad-compat.sh
index a5fc796..1e5ce48 100755
--- a/test/btt-pad-compat.sh
+++ b/test/btt-pad-compat.sh
@@ -187,7 +187,10 @@ do_tests()
 	ns_info_wipe
 }
 
-modprobe nfit_test
+if [ -z "$WITHOUT_NFIT" ]; then
+    modprobe nfit_test
+fi
+
 check_prereq xxd
 rc=1
 reset
diff --git a/test/clear.sh b/test/clear.sh
index f0b4a9b..e0b1f84 100755
--- a/test/clear.sh
+++ b/test/clear.sh
@@ -22,7 +22,10 @@ check_min_kver "4.6" || do_skip "lacks clear poison support"
 trap 'err $LINENO' ERR
 
 # setup (reset nfit_test dimms)
-modprobe nfit_test
+if [ -z "$WITHOUT_NFIT" ]; then
+    modprobe nfit_test
+fi
+
 $NDCTL disable-region -b $TEST_BUS0 all
 $NDCTL zero-labels -b $TEST_BUS0 all
 $NDCTL enable-region -b $TEST_BUS0 all
diff --git a/test/common b/test/common
index 54085ae..1251ba5 100644
--- a/test/common
+++ b/test/common
@@ -29,10 +29,17 @@ fi
 
 # TEST_BUS[01]
 #
-TEST_BUS0="nfit_test.0"
-TEST_BUS1="nfit_test.1"
-ACPI_BUS="ACPI.NFIT"
-E820_BUS="e820"
+echo $WITHOUT_NFIT
+if [ -n "$WITHOUT_NFIT" ]; then
+    echo $BUS_PROVIDER0
+    TEST_BUS0="$BUS_PROVIDER0"
+    TEST_BUS1="$BUS_PROVIDER1"
+else
+    TEST_BUS0="nfit_test.0"
+    TEST_BUS1="nfit_test.1"
+    ACPI_BUS="ACPI.NFIT"
+    E820_BUS="e820"
+fi
 
 # Functions
 
@@ -84,7 +91,9 @@ _cleanup()
 {
 	$NDCTL disable-region -b $TEST_BUS0 all
 	$NDCTL disable-region -b $TEST_BUS1 all
-	modprobe -r nfit_test
+	if [ -z "$WITHOUT_NFIT" ]; then
+	    modprobe -r nfit_test
+	fi
 }
 
 # json2var
diff --git a/test/core.c b/test/core.c
index 888f5d8..1f0c215 100644
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
 
@@ -239,9 +243,11 @@ retry:
 		ndctl_bus_foreach(nd_ctx, bus) {
 			struct ndctl_region *region;
 
+#ifdef ACPI
 			if (strncmp(ndctl_bus_get_provider(bus),
 						"nfit_test", 9) != 0)
 				continue;
+#endif
 			ndctl_region_foreach(bus, region)
 				ndctl_region_disable_invalidate(region);
 		}
diff --git a/test/create.sh b/test/create.sh
index 1398c79..afc34ac 100755
--- a/test/create.sh
+++ b/test/create.sh
@@ -23,7 +23,10 @@ check_min_kver "4.5" || do_skip "may lack namespace mode attribute"
 trap 'err $LINENO' ERR
 
 # setup (reset nfit_test dimms)
-modprobe nfit_test
+if [ -z "$WITHOUT_NFIT" ]; then
+    modprobe nfit_test
+fi
+
 $NDCTL disable-region -b $TEST_BUS0 all
 $NDCTL zero-labels -b $TEST_BUS0 all
 $NDCTL enable-region -b $TEST_BUS0 all
diff --git a/test/daxdev-errors.c b/test/daxdev-errors.c
index 29de16b..1022047 100644
--- a/test/daxdev-errors.c
+++ b/test/daxdev-errors.c
@@ -45,7 +45,6 @@ struct check_cmd {
 static sigjmp_buf sj_env;
 static int sig_count;
 
-static const char *NFIT_PROVIDER0 = "nfit_test.0";
 static struct check_cmd *check_cmds;
 
 static void sigbus_hdl(int sig, siginfo_t *siginfo, void *ptr)
@@ -245,7 +244,7 @@ static struct ndctl_dax * get_dax_region(struct ndctl_region *region)
 static int test_daxdev_clear_error(const char *bus_name,
 		const char *region_name)
 {
-	int rc = 0, i;
+	int rc = 0, i, with_nfit;
 	struct ndctl_ctx *ctx;
 	struct ndctl_bus *bus;
 	struct ndctl_region *region;
@@ -259,6 +258,7 @@ static int test_daxdev_clear_error(const char *bus_name,
         };
 	char path[256];
 	char buf[SYSFS_ATTR_SIZE];
+	char *bus_provider;
 	struct log_ctx log_ctx;
 
 	log_init(&log_ctx, "test/init", "NDCTL_DAXDEV_TEST");
@@ -266,7 +266,13 @@ static int test_daxdev_clear_error(const char *bus_name,
 	if (rc)
 		return rc;
 
-	bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER0);
+	with_nfit = strlen(getenv("WITHOUT_NFIT")) == 0;
+	if (with_nfit)
+		bus_provider = "nfit_test.0";
+	else
+		bus_provider = getenv("BUS_PROVIDER0");
+
+	bus = ndctl_bus_get_by_provider(ctx, bus_provider);
 	if (!bus) {
 		rc = -ENODEV;
 		goto cleanup;
@@ -289,7 +295,7 @@ static int test_daxdev_clear_error(const char *bus_name,
 	/* get badblocks */
 	if (snprintf(path, 256,
 			"/sys/devices/platform/%s/%s/%s/badblocks",
-			NFIT_PROVIDER0,
+			bus_provider,
 			bus_name,
 			ndctl_region_get_devname(region)) >= 256) {
 		fprintf(stderr, "%s: buffer too small!\n",
diff --git a/test/daxdev-errors.sh b/test/daxdev-errors.sh
index c877874..7678a9b 100755
--- a/test/daxdev-errors.sh
+++ b/test/daxdev-errors.sh
@@ -22,7 +22,10 @@ check_min_kver "4.12" || do_skip "lacks dax dev error handling"
 trap 'err $LINENO' ERR
 
 # setup (reset nfit_test dimms)
-modprobe nfit_test
+if [ -z "$WITHOUT_NFIT" ]; then
+    modprobe nfit_test
+fi
+
 $NDCTL disable-region -b $TEST_BUS0 all
 $NDCTL zero-labels -b $TEST_BUS0 all
 $NDCTL enable-region -b $TEST_BUS0 all
diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
index 9a9c6b6..25bbe0e 100644
--- a/test/dpa-alloc.c
+++ b/test/dpa-alloc.c
@@ -30,8 +30,6 @@
 #include <ndctl/libndctl.h>
 #include <ccan/array_size/array_size.h>
 
-static const char *NFIT_PROVIDER0 = "nfit_test.0";
-static const char *NFIT_PROVIDER1 = "nfit_test.1";
 #define NUM_NAMESPACES 4
 
 struct test_dpa_namespace {
@@ -46,23 +44,34 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 {
 	unsigned int default_available_slots, available_slots, i;
 	struct ndctl_region *region, *blk_region = NULL;
+	char *bus_provider0, *bus_provider1;
 	struct ndctl_namespace *ndns;
 	struct ndctl_dimm *dimm;
 	unsigned long size;
+	bool with_nfit;
 	struct ndctl_bus *bus;
 	char uuid_str[40];
 	int round;
 	int rc;
 
+	with_nfit = strlen(getenv("WITHOUT_NFIT")) == 0;
+	if (with_nfit) {
+		bus_provider0 = "nfit_test.0";
+		bus_provider1 = "nfit_test.1";
+	} else {
+		bus_provider0 = getenv("BUS_PROVIDER0");
+		bus_provider1 = getenv("BUS_PROVIDER1");
+	}
+
 	/* disable nfit_test.1, not used in this test */
-	bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER1);
+	bus = ndctl_bus_get_by_provider(ctx, bus_provider1);
 	if (!bus)
 		return -ENXIO;
 	ndctl_region_foreach(bus, region)
 		ndctl_region_disable_invalidate(region);
 
 	/* init nfit_test.0 */
-	bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER0);
+	bus = ndctl_bus_get_by_provider(ctx, bus_provider0);
 	if (!bus)
 		return -ENXIO;
 	ndctl_region_foreach(bus, region)
diff --git a/test/libndctl.c b/test/libndctl.c
index 02bb9cc..e6fa053 100644
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
@@ -2594,11 +2592,18 @@ static void reset_bus(struct ndctl_bus *bus)
 
 static int do_test0(struct ndctl_ctx *ctx, struct ndctl_test *test)
 {
-	struct ndctl_bus *bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER0);
+	struct ndctl_bus *bus;
 	struct ndctl_region *region;
 	struct ndctl_dimm *dimm;
+	bool with_nfit;
 	int rc;
 
+	with_nfit = strlen(getenv("WITHOUT_NFIT")) == 0;
+	if (with_nfit)
+		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
+	else
+		bus = ndctl_bus_get_by_provider(ctx, getenv("BUS_PROVIDER0"));
+
 	if (!bus)
 		return -ENXIO;
 
@@ -2646,9 +2651,17 @@ static int do_test0(struct ndctl_ctx *ctx, struct ndctl_test *test)
 
 static int do_test1(struct ndctl_ctx *ctx, struct ndctl_test *test)
 {
-	struct ndctl_bus *bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER1);
+	struct ndctl_bus *bus;
+	bool with_nfit;
 	int rc;
 
+	with_nfit = strlen(getenv("WITHOUT_NFIT")) == 0;
+	if (with_nfit)
+		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.1");
+	else
+		bus = ndctl_bus_get_by_provider(ctx, getenv("BUS_PROVIDER1"));
+
+
 	if (!bus)
 		return -ENXIO;
 
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
