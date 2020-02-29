Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F89F17495E
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:39:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF5FD10FC3761;
	Sat, 29 Feb 2020 12:40:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1989810FC36E6
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:40:13 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:39:20 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="232874204"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:39:20 -0800
Subject: [ndctl PATCH 36/36] ndctl/test: Regression test misaligned
 namespaces
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 29 Feb 2020 12:23:15 -0800
Message-ID: <158300779557.2141307.1119464097611805912.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: S7XE63TEIWTTB4RD23WAUZM62O5PVNGY
X-Message-ID-Hash: S7XE63TEIWTTB4RD23WAUZM62O5PVNGY
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S7XE63TEIWTTB4RD23WAUZM62O5PVNGY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The kernel is now requiring that namespace creation results in
cross-arch compatible namespaces by default. However, it must also
continue to support previously valid, but misaligned, namespaces. Use
the write-infoblock utility to create "legacy" configurations and
validate that the kernel still accepts it along with other corner case
configurations.

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/Makefile.am |    1 
 test/align.sh    |  118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100755 test/align.sh

diff --git a/test/Makefile.am b/test/Makefile.am
index cce60c5221fd..1d24a65ded8b 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -54,6 +54,7 @@ TESTS +=\
 	dax-dev \
 	dax-ext4.sh \
 	dax-xfs.sh \
+	align.sh \
 	device-dax \
 	device-dax-fio.sh \
 	daxctl-devices.sh \
diff --git a/test/align.sh b/test/align.sh
new file mode 100755
index 000000000000..0129255610ab
--- /dev/null
+++ b/test/align.sh
@@ -0,0 +1,118 @@
+#!/bin/bash -x
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+
+. $(dirname $0)/common
+
+rc=77
+cleanup() {
+	echo "align.sh: failed at line $1"
+	if [ "x$region" != "x" -a x$save_align != "x" ]; then
+		echo $save_align > $region_path/align
+	fi
+
+	if [ "x$ns1" != "x" ]; then
+		$NDCTL destroy-namespace -f $ns1
+	fi
+	if [ "x$ns2" != "x" ]; then
+		$NDCTL destroy-namespace -f $ns2
+	fi
+
+	exit $rc
+}
+
+is_aligned() {
+	val=$1
+	align=$2
+
+	if [ $((val & (align - 1))) -eq 0 ]; then
+		return 0
+	fi
+	return 1
+}
+
+set -e
+trap 'err $LINENO cleanup' ERR
+
+region=$($NDCTL list -R -b ACPI.NFIT | jq -r '.[] | [select(.available_size == .size)] | .[0].dev')
+
+if [ "x$region" = "xnull"  ]; then
+	unset $region
+	echo "unable to find empty region"
+	false
+fi
+
+region_path="/sys/bus/nd/devices/$region"
+save_align=$(cat $region_path/align)
+
+# check that the region is 1G aligned
+resource=$(cat $region_path/resource)
+is_aligned $resource $((1 << 30)) || (echo "need a 1GB aligned namespace to test alignment conditions" && false)
+
+rc=1
+
+# check that start-aligned, but end-misaligned namespaces can be created
+# and probed
+echo 4096 > $region_path/align
+SIZE=$(((1<<30) + (8<<10)))
+json=$($NDCTL create-namespace -r $region -s $SIZE -m fsdax -a 4K)
+eval $(json2var <<< "$json")
+$NDCTL disable-namespace $dev
+$NDCTL enable-namespace $dev
+ns1=$dev
+
+# check that start-misaligned namespaces can't be created until the
+# region alignment is set to a compatible value.
+# Note the namespace capacity alignment requirement in this case is
+# SUBSECTION_SIZE (2M) as the data alignment can be satisfied with
+# metadata padding.
+json=$($NDCTL create-namespace -r $region -s $SIZE -m fsdax -a 4K -f) || status="failed"
+if [ $status != "failed" ]; then
+	echo "expected namespace creation failure"
+	eval $(json2var <<< "$json")
+	$NDCTL destroy-namespace -f $dev
+	false
+fi
+
+# check that start-misaligned namespaces can't be probed. Since the
+# kernel does not support creating this misalignment, force it with a
+# custom info-block
+json=$($NDCTL create-namespace -r $region -s $SIZE -m raw)
+eval $(json2var <<< "$json")
+
+$NDCTL disable-namespace $dev
+$NDCTL write-infoblock $dev -a 4K
+$NDCTL enable-namespace $dev || status="failed"
+
+if [ $status != "failed" ]; then
+	echo "expected namespace enable failure"
+	$NDCTL destroy-namespace -f $dev
+	false
+fi
+ns2=$dev
+
+# check that namespace with proper inner padding can be enabled, even
+# though non-zero start_pad namespaces don't support dax
+$NDCTL write-infoblock $ns2 -a 4K -O 8K
+$NDCTL enable-namespace $ns2
+$NDCTL destroy-namespace $ns2 -f
+unset ns2
+
+# check that all namespace alignments can be created with the region
+# alignment at a compatible value
+SIZE=$((2 << 30))
+echo $((16 << 20)) > $region_path/align
+for i in $((1 << 30)) $((2 << 20)) $((4 << 10))
+do
+	json=$($NDCTL create-namespace -r $region -s $SIZE -m fsdax -a $i)
+	eval $(json2var <<< "$json")
+	ns2=$dev
+	$NDCTL disable-namespace $dev
+	$NDCTL enable-namespace $dev
+	$NDCTL destroy-namespace $dev -f
+	unset ns2
+done
+
+# final cleanup
+$NDCTL destroy-namespace $ns1 -f
+exit 0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
