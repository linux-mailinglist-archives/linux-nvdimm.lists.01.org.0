Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A3F174949
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:37:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA55310FC3413;
	Sat, 29 Feb 2020 12:38:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6278C10FC3413
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:38:32 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:40 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="242720932"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:39 -0800
Subject: [ndctl PATCH 17/36] ndctl/test: Checkout device-mapper + dax
 operation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:21:35 -0800
Message-ID: <158300769510.2141307.17564634923798818361.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: AOUA2GMTZOUTVKL7DUDZRMTJQNQORWY5
X-Message-ID-Hash: AOUA2GMTZOUTVKL7DUDZRMTJQNQORWY5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AOUA2GMTZOUTVKL7DUDZRMTJQNQORWY5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Given recent kernel changes broke the device-mapper use case, introduce
a basic unit test to prevent this from regressing in the future.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/Makefile.am |    5 ++--
 test/dm.sh       |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100755 test/dm.sh

diff --git a/test/Makefile.am b/test/Makefile.am
index bde491247a47..13a0419226a6 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -54,8 +54,9 @@ TESTS +=\
 	dax-xfs.sh \
 	device-dax \
 	device-dax-fio.sh \
-	mmap.sh \
-	daxctl-devices.sh
+	daxctl-devices.sh \
+	dm.sh \
+	mmap.sh
 
 if ENABLE_KEYUTILS
 TESTS += security.sh
diff --git a/test/dm.sh b/test/dm.sh
new file mode 100755
index 000000000000..fb498c95a29b
--- /dev/null
+++ b/test/dm.sh
@@ -0,0 +1,75 @@
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
+MNT=test_dax_mnt
+TEST_DM_PMEM=/dev/mapper/test_pmem
+NAME=$(basename $TEST_DM_PMEM)
+
+mkdir -p $MNT
+
+TEST_SIZE=$((1<<30))
+
+rc=$FAIL
+cleanup() {
+	if [ $rc -ne $SUCCESS ]; then
+		echo "test/dm.sh: failed at line $1"
+	fi
+	if mountpoint -q $MNT; then
+		umount $MNT
+	fi
+
+	if [ -L $TEST_DM_PMEM ]; then
+		dmsetup remove $TEST_DM_PMEM
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
+dev="x"
+json=$($NDCTL create-namespace -b ACPI.NFIT -s $TEST_SIZE -t pmem -m fsdax -n "$NAME")
+eval $(echo $json | json2var )
+[ $dev = "x" ] && echo "fail: $LINENO" && exit 1
+[ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
+
+pmem0=/dev/$blockdev
+size0=$((size/512))
+
+json=$($NDCTL create-namespace -b ACPI.NFIT -s $TEST_SIZE -t pmem -m fsdax -n "$NAME")
+eval $(echo $json | json2var )
+[ $dev = "x" ] && echo "fail: $LINENO" && exit 1
+[ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
+
+pmem1=/dev/$blockdev
+size1=$((size/512))
+
+cat <<EOF |
+0 $size0 linear $pmem0 0
+$size0 $size1 linear $pmem1 0
+EOF
+dmsetup create $(basename $NAME)
+
+mkfs.ext4 -b 4096 $TEST_DM_PMEM
+mount -o dax $TEST_DM_PMEM $MNT
+umount $MNT
+
+rc=$SUCCESS
+cleanup $LINENO
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
