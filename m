Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9DD6C346
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 00:54:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 70767212C01D9;
	Wed, 17 Jul 2019 15:56:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5B9C1212BF9D8
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 15:56:39 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2019 15:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,275,1559545200"; d="scan'208";a="191413601"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2019 15:54:10 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v6 13/13] test: Add a unit test for
 daxctl-reconfigure-device and friends
Date: Wed, 17 Jul 2019 16:54:00 -0600
Message-Id: <20190717225400.9494-14-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717225400.9494-1-vishal.l.verma@intel.com>
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add a new unit test to test dax device reconfiguration and memory
operations. This teaches test/common about daxctl, and adds an ACPI.NFIT
bus variable. Since we have to operate on the ACPI.NFIT bus, the test is
marked as destructive.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test/Makefile.am       |  3 +-
 test/common            | 19 ++++++++--
 test/daxctl-devices.sh | 81 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 4 deletions(-)
 create mode 100755 test/daxctl-devices.sh

diff --git a/test/Makefile.am b/test/Makefile.am
index 874c4bb..84474d0 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -49,7 +49,8 @@ TESTS +=\
 	dax.sh \
 	device-dax \
 	device-dax-fio.sh \
-	mmap.sh
+	mmap.sh \
+	daxctl-devices.sh
 
 if ENABLE_KEYUTILS
 TESTS += security.sh
diff --git a/test/common b/test/common
index 1b9d3da..1814a0c 100644
--- a/test/common
+++ b/test/common
@@ -15,12 +15,25 @@ else
 	exit 1
 fi
 
-# NFIT_TEST_BUS[01]
+# DAXCTL
 #
-NFIT_TEST_BUS0=nfit_test.0
-NFIT_TEST_BUS1=nfit_test.1
+if [ -f "../daxctl/daxctl" ] && [ -x "../daxctl/daxctl" ]; then
+	export DAXCTL=../daxctl/daxctl
+elif [ -f "./daxctl/daxctl" ] && [ -x "./daxctl/daxctl" ]; then
+	export DAXCTL=./daxctl/daxctl
+else
+	echo "Couldn't find an daxctl binary"
+	exit 1
+fi
 
 
+# NFIT_TEST_BUS[01]
+#
+NFIT_TEST_BUS0="nfit_test.0"
+NFIT_TEST_BUS1="nfit_test.1"
+ACPI_BUS="ACPI.NFIT"
+E820_BUS="e820"
+
 # Functions
 
 # err
diff --git a/test/daxctl-devices.sh b/test/daxctl-devices.sh
new file mode 100755
index 0000000..cfd9362
--- /dev/null
+++ b/test/daxctl-devices.sh
@@ -0,0 +1,81 @@
+#!/bin/bash -Ex
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2019 Intel Corporation. All rights reserved.
+
+rc=77
+. ./common
+
+trap 'cleanup $LINENO' ERR
+
+cleanup()
+{
+	printf "Error at line %d\n" "$1"
+	[[ $testdev ]] && reset_dev
+	exit $rc
+}
+
+find_testdev()
+{
+	local rc=77
+
+	# find a victim device
+	testbus="$ACPI_BUS"
+	testdev=$("$NDCTL" list -b "$testbus" -Ni | jq -er '.[0].dev | .//""')
+	if [[ ! $testdev  ]]; then
+		printf "Unable to find a victim device\n"
+		exit "$rc"
+	fi
+	printf "Found victim dev: %s on bus: %s\n" "$testdev" "$testbus"
+}
+
+setup_dev()
+{
+	test -n "$testbus"
+	test -n "$testdev"
+
+	"$NDCTL" destroy-namespace -f -b "$testbus" "$testdev"
+	testdev=$("$NDCTL" create-namespace -b "$testbus" -m devdax -fe "$testdev" -s 256M | \
+		jq -er '.dev')
+	test -n "$testdev"
+}
+
+reset_dev()
+{
+	"$NDCTL" destroy-namespace -f -b "$testbus" "$testdev"
+}
+
+daxctl_get_dev()
+{
+	"$NDCTL" list -n "$1" -X | jq -er '.[].daxregion.devices[0].chardev'
+}
+
+daxctl_get_mode()
+{
+	"$DAXCTL" list -d "$1" | jq -er '.[].mode'
+}
+
+daxctl_test()
+{
+	local daxdev
+
+	daxdev=$(daxctl_get_dev "$testdev")
+	test -n "$daxdev"
+
+	"$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "system-ram" ]]
+	"$DAXCTL" online-memory "$daxdev"
+	"$DAXCTL" offline-memory "$daxdev"
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+	"$DAXCTL" reconfigure-device -m system-ram "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "system-ram" ]]
+	"$DAXCTL" reconfigure-device -O -m devdax "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+}
+
+find_testdev
+setup_dev
+rc=1
+daxctl_test
+reset_dev
+exit 0
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
