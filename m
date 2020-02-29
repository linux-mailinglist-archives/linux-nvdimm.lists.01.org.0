Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87D7174951
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:38:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5430910FC36EE;
	Sat, 29 Feb 2020 12:39:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7C29F10FC36EE
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:39:03 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:11 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="439607935"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:11 -0800
Subject: [ndctl PATCH 23/36] ndctl/test: Regression test 'failed to track'
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:22:06 -0800
Message-ID: <158300772625.2141307.11205947066964903072.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: DBG3JAHIK2ZCLIFJF2ZIPJOAFLECFTH7
X-Message-ID-Hash: DBG3JAHIK2ZCLIFJF2ZIPJOAFLECFTH7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DBG3JAHIK2ZCLIFJF2ZIPJOAFLECFTH7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Exercise the failing condition behind kernel commit c4703ce11c23
"libnvdimm/namespace: Fix label tracking error", i.e. rename (change
uuid) allocated namespace capacity.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/Makefile.am   |    3 ++-
 test/track-uuid.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100755 test/track-uuid.sh

diff --git a/test/Makefile.am b/test/Makefile.am
index bbe58a06d9d0..cce60c5221fd 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -25,7 +25,8 @@ TESTS =\
 	inject-smart.sh \
 	monitor.sh \
 	max_available_extent_ns.sh \
-	pfn-meta-errors.sh
+	pfn-meta-errors.sh \
+	track-uuid.sh
 
 EXTRA_DIST += $(TESTS) common \
 		btt-pad-compat.xxd \
diff --git a/test/track-uuid.sh b/test/track-uuid.sh
new file mode 100755
index 000000000000..ab77e52708b6
--- /dev/null
+++ b/test/track-uuid.sh
@@ -0,0 +1,40 @@
+#!/bin/bash -Ex
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2018 Intel Corporation. All rights reserved.
+
+blockdev=""
+rc=77
+
+. ./common
+
+set -e
+trap 'err $LINENO' ERR
+
+# setup (reset nfit_test dimms)
+modprobe nfit_test
+$NDCTL disable-region -b $NFIT_TEST_BUS0 all
+$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
+$NDCTL enable-region -b $NFIT_TEST_BUS0 all
+
+rc=1
+
+# create a fsdax namespace and clear errors (if any)
+dev="x"
+json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem -m raw)
+eval "$(echo "$json" | json2var)"
+[ $dev = "x" ] && echo "fail: $LINENO" && exit 1
+
+$NDCTL disable-namespace $dev
+# On broken kernels this reassignment of capacity triggers a warning
+# with the following signature, and results in ENXIO.
+#     WARNING: CPU: 11 PID: 1378 at drivers/nvdimm/label.c:721 __pmem_label_update+0x55d/0x570 [libnvdimm]
+#     Call Trace:
+#      nd_pmem_namespace_label_update+0xd6/0x160 [libnvdimm]
+#      uuid_store+0x15c/0x170 [libnvdimm]
+#      kernfs_fop_write+0xf0/0x1a0
+#      __vfs_write+0x26/0x150
+uuidgen > /sys/bus/nd/devices/$dev/uuid
+$NDCTL enable-namespace $dev
+
+_cleanup
+exit 0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
