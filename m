Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEEC17494B
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:37:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D44DA10FC340F;
	Sat, 29 Feb 2020 12:38:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 690AC10FC340E
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:38:37 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:45 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="411766810"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:45 -0800
Subject: [ndctl PATCH 18/36] ndctl/test: Exercise sub-section sized
 namespace creation/deletion
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:21:40 -0800
Message-ID: <158300770020.2141307.14389265093369914523.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: SRYWTWQQUJJBJYF5SJKKDJNOXIDPEBJS
X-Message-ID-Hash: SRYWTWQQUJJBJYF5SJKKDJNOXIDPEBJS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SRYWTWQQUJJBJYF5SJKKDJNOXIDPEBJS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For kernels that have removed the section-aligned namespace constraint
validate that multiple namespaces can be created / deleted that collide
within a given section.

While this test acts on the ACPI.NFIT bus it is not marked "destructive"
because it only operates in available capacity and marks each namespace
created with a unique volume name ("subsection-test").

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/Makefile.am    |    1 +
 test/sub-section.sh |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100755 test/sub-section.sh

diff --git a/test/Makefile.am b/test/Makefile.am
index 13a0419226a6..bbe58a06d9d0 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -49,6 +49,7 @@ if ENABLE_DESTRUCTIVE
 TESTS +=\
 	blk-ns \
 	pmem-ns \
+	sub-section.sh \
 	dax-dev \
 	dax-ext4.sh \
 	dax-xfs.sh \
diff --git a/test/sub-section.sh b/test/sub-section.sh
new file mode 100755
index 000000000000..91aa5c8e4834
--- /dev/null
+++ b/test/sub-section.sh
@@ -0,0 +1,77 @@
+#!/bin/bash -x
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2015-2019 Intel Corporation. All rights reserved.
+
+set -e
+
+SKIP=77
+FAIL=1
+SUCCESS=0
+
+. ./common
+
+check_min_kver "5.3" || do_skip "may lack align sub-section hotplug support"
+
+MNT=test_dax_mnt
+mkdir -p $MNT
+
+TEST_SIZE=$((16<<20))
+MIN_AVAIL=$((TEST_SIZE*4))
+MAX_NS=10
+NAME="subsection-test"
+
+ndctl list -N | jq -r ".[] | select(.name==\"subsection-test\") | .dev"
+
+rc=$FAIL
+cleanup() {
+	if [ $rc -ne $SUCCESS ]; then
+		echo "test/sub-section.sh: failed at line $1"
+	fi
+	if mountpoint -q $MNT; then
+		umount $MNT
+	fi
+	rmdir $MNT
+	# opportunistic cleanup, not fatal if these fail
+	namespaces=$($NDCTL list -N | jq -r ".[] | select(.name==\"$NAME\") | .dev")
+	for i in $namespaces
+	do
+		if ! $NDCTL destroy-namespace -f $i; then
+			echo "test/sub-section.sh: cleanup() failed to destroy $i"
+		fi
+	done
+	exit $rc
+}
+
+trap 'err $LINENO cleanup' ERR
+
+json=$($NDCTL list -R -b ACPI.NFIT)
+region=$(echo $json | jq -r "[.[] | select(.available_size >= $MIN_AVAIL)][0].dev")
+avail=$(echo $json | jq -r "[.[] | select(.available_size >= $MIN_AVAIL)][0].available_size")
+if [ -z $region ]; then
+	exit $SKIP
+fi
+
+iter=$((avail/TEST_SIZE))
+if [ $iter -gt $MAX_NS ]; then
+	iter=$MAX_NS;
+fi
+
+for i in $(seq 1 $iter)
+do
+	json=$($NDCTL create-namespace -s $TEST_SIZE --no-autorecover -r $region -n "$NAME")
+	dev=$(echo $json | jq -r ".blockdev")
+	mkfs.ext4 -b 4096 /dev/$dev
+	mount -o dax /dev/$dev $MNT
+	umount $MNT
+done
+
+namespaces=$($NDCTL list -N | jq -r ".[] | select(.name==\"$NAME\") | .dev")
+for i in $namespaces
+do
+	$NDCTL disable-namespace $i
+	$NDCTL enable-namespace $i
+	$NDCTL destroy-namespace $i -f
+done
+
+rc=$SUCCESS
+cleanup $LINENO
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
