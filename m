Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1772077C31
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:55:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8EAD9212E46ED;
	Sat, 27 Jul 2019 14:57:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DE7FB212E259E
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:57:41 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:15 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="175977682"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:15 -0700
Subject: [ndctl PATCH v2 18/26] ndctl/test: Exercise sub-section sized
 namespace creation/deletion
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:40:58 -0700
Message-ID: <156426365799.531577.4076109633772194960.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

For kernels that have removed the section-aligned namespace constraint
validate that multiple namespaces can be created / deleted that collide
within a given section.

While this test acts on the ACPI.NFIT bus it is not marked "destructive"
because it only operates in available capacity and marks each namespace
created with a unique volume name ("subsection-test").

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/Makefile.am    |    1 +
 test/sub-section.sh |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100755 test/sub-section.sh

diff --git a/test/Makefile.am b/test/Makefile.am
index 2a1e03d26f6c..decc8377258a 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -45,6 +45,7 @@ if ENABLE_DESTRUCTIVE
 TESTS +=\
 	blk-ns \
 	pmem-ns \
+	sub-section.sh \
 	dax-dev \
 	dax.sh \
 	device-dax \
diff --git a/test/sub-section.sh b/test/sub-section.sh
new file mode 100755
index 000000000000..c624fbdb2ce0
--- /dev/null
+++ b/test/sub-section.sh
@@ -0,0 +1,78 @@
+#!/bin/bash -x
+
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
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
