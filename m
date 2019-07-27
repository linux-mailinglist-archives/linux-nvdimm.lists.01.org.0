Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C239977C30
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:55:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3959F212E25B2;
	Sat, 27 Jul 2019 14:57:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 259BC212E259E
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:57:37 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:10 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="161739904"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:09 -0700
Subject: [ndctl PATCH v2 17/26] ndctl/test: Checkout device-mapper + dax
 operation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:40:52 -0700
Message-ID: <156426365289.531577.3024221395183254159.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Given recent kernel changes broke the device-mapper use case, introduce
a basic unit test to prevent this from regressing in the future.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/Makefile.am |    1 +
 test/dm.sh       |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100755 test/dm.sh

diff --git a/test/Makefile.am b/test/Makefile.am
index 874c4bbfaa90..2a1e03d26f6c 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -49,6 +49,7 @@ TESTS +=\
 	dax.sh \
 	device-dax \
 	device-dax-fio.sh \
+	dm.sh \
 	mmap.sh
 
 if ENABLE_KEYUTILS
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
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
