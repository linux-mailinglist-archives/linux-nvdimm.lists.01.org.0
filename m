Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB7219E003
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 22:59:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3839210FC51CF;
	Fri,  3 Apr 2020 14:00:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DF02B10FC51CF
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 14:00:15 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Kgvgb091312;
	Fri, 3 Apr 2020 20:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=aWwL2dw1amMnjxGbEA20MHDnANmHdBnMzBZpLCwshUc=;
 b=O3c1TcJZg1fYCNi25GGQm8Uj5K3/0kCuOR7JATha8Srfz1I/O5WULLshTRYir6CQr8sf
 U7sj4sq1oA4uiAPk355f1RPxnJ6W1tT7lWcD9H7qb92crCmJazlHWx/KoQfdxN5brZ8a
 rTlqh1LUBxKdBOp6au//9NC9KtQ0RnAmdxKl0zQ2KDJ9yuXa1ED4hgw5SOEXn45s4r0b
 SZOAjQrkMp0SMeCl5b7GpmyqChAaxtYCAeobQVsKsAkA8jralDB0nsaqhYpTHIthagN/
 RaIcRTdGBBhXYm/f7bSEfYNzbCry/nrktAHNphxE3fYdn94lN5riF1H1btA5kRkm65FG tw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 303aqj3p7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KhF58100110;
	Fri, 3 Apr 2020 20:59:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 304sjtxx98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:23 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033KxMK0010541;
	Fri, 3 Apr 2020 20:59:22 GMT
Received: from paddy.uk.oracle.com (/10.175.206.152)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 03 Apr 2020 13:59:21 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 10/10] daxctl/test: Add tests for dynamic dax regions
Date: Fri,  3 Apr 2020 21:59:00 +0100
Message-Id: <20200403205900.18035-11-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403205900.18035-1-joao.m.martins@oracle.com>
References: <20200403205900.18035-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=1 mlxlogscore=659 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=712 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
Message-ID-Hash: E2XEYGT22X7ZO576EWKMKTWKUY2XWKJL
X-Message-ID-Hash: E2XEYGT22X7ZO576EWKMKTWKUY2XWKJL
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E2XEYGT22X7ZO576EWKMKTWKUY2XWKJL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a couple tests which exercise the new sysfs based
interface for Soft-Reserved regions (by EFI/HMAT, or
efi_fake_mem).

The tests exercise the daxctl orchestration surrounding
for creating/disabling/destroying/reconfiguring devices.
Furthermore it exercises dax region space allocation
code paths particularly:

 1) zeroing out and reconfiguring a dax device from
 its current size to be max available and back to initial
 size

 2) creates devices from holes in the beginning,
 middle of the region.

 3) reconfigures devices in a interleaving fashion

 4) test adjust of the region towards beginning and end

The tests assume you pass a valid efi_fake_mem parameter
marked as EFI_MEMORY_SP e.g.

	efi_fake_mem=112G@16G:0x40000

Naturally it bails out from the test if hmem device driver
isn't loaded/builtin or no region is found.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 test/Makefile.am      |   1 +
 test/daxctl-create.sh | 293 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+)
 create mode 100755 test/daxctl-create.sh

diff --git a/test/Makefile.am b/test/Makefile.am
index 1d24a65ded8b..6b7c82f9a4e2 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -58,6 +58,7 @@ TESTS +=\
 	device-dax \
 	device-dax-fio.sh \
 	daxctl-devices.sh \
+	daxctl-create.sh \
 	dm.sh \
 	mmap.sh
 
diff --git a/test/daxctl-create.sh b/test/daxctl-create.sh
new file mode 100755
index 000000000000..f46b9273ef20
--- /dev/null
+++ b/test/daxctl-create.sh
@@ -0,0 +1,293 @@
+#!/bin/bash -Ex
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2020, Oracle and/or its affiliates.
+
+rc=77
+. $(dirname $0)/common
+
+trap 'cleanup $LINENO' ERR
+
+cleanup()
+{
+	printf "Error at line %d\n" "$1"
+	[[ $testdev ]] && reset
+	exit $rc
+}
+
+find_testdev()
+{
+	local rc=77
+
+	# The hmem driver is needed to change the device mode, only
+	# kernels >= v5.6 might have it available. Skip if not.
+	if ! modinfo hmem; then
+		# check if hmem is builtin
+		if [ ! -d "/sys/module/device_hmem" ]; then
+			printf "Unable to find hmem module\n"
+			exit $rc
+		fi
+	fi
+
+	# find a victim region provided by dax_hmem
+	testpath=$("$DAXCTL" list -r 0 | jq -er '.[0].path | .//""')
+	if [[ ! "$testpath" == *"hmem"* ]]; then
+		printf "Unable to find a victim region\n"
+		exit "$rc"
+	fi
+
+	# find a victim device
+	testdev=$("$DAXCTL" list -D -r 0 | jq -er '.[0].chardev | .//""')
+	if [[ ! $testdev  ]]; then
+		printf "Unable to find a victim device\n"
+		exit "$rc"
+	fi
+	printf "Found victim dev: %s on region id 0\n" "$testdev"
+}
+
+setup_dev()
+{
+	test -n "$testdev"
+
+	"$DAXCTL" disable-device "$testdev"
+	"$DAXCTL" reconfigure-device -s 0 "$testdev"
+	available=$("$DAXCTL" list -r 0 | jq -er '.[0].available_size | .//""')
+}
+
+reset_dev()
+{
+	test -n "$testdev"
+
+	"$DAXCTL" disable-device "$testdev"
+	"$DAXCTL" reconfigure-device -s $available "$testdev"
+}
+
+reset()
+{
+	test -n "$testdev"
+
+	"$DAXCTL" disable-device all
+	"$DAXCTL" destroy-device all
+	"$DAXCTL" reconfigure-device -s $available "$testdev"
+}
+
+clear_dev()
+{
+	"$DAXCTL" disable-device "$testdev"
+	"$DAXCTL" reconfigure-device -s 0 "$testdev"
+}
+
+test_pass()
+{
+	local rc=1
+
+	# Available size
+	_available_size=$("$DAXCTL" list -r 0 | jq -er '.[0].available_size | .//""')
+	if [[ ! $_available_size == $available ]]; then
+		printf "Unexpected available size $_available_size != $available\n"
+		exit "$rc"
+	fi
+}
+
+fail_if_available()
+{
+	local rc=1
+
+	_size=$("$DAXCTL" list -r 0 | jq -er '.[0].available_size | .//""')
+	if [[ $_size ]]; then
+		printf "Unexpected available size $_size\n"
+		exit "$rc"
+	fi
+}
+
+daxctl_get_dev()
+{
+	"$DAXCTL" list -d "$1" | jq -er '.[].chardev'
+}
+
+daxctl_get_mode()
+{
+	"$DAXCTL" list -d "$1" | jq -er '.[].mode'
+}
+
+daxctl_test_multi()
+{
+	local daxdev
+
+	size=$(expr $available / 4)
+
+	if [[ $2 ]]; then
+		"$DAXCTL" disable-device "$testdev"
+		"$DAXCTL" reconfigure-device -s $size "$testdev"
+	fi
+
+	daxdev_1=$("$DAXCTL" create-device -s $size | jq -er '.[].chardev')
+	test -n $daxdev_1
+
+	daxdev_2=$("$DAXCTL" create-device -s $size | jq -er '.[].chardev')
+	test -n $daxdev_2
+
+	if [[ ! $2 ]]; then
+		daxdev_3=$("$DAXCTL" create-device -s $size | jq -er '.[].chardev')
+		test -n $daxdev_3
+	fi
+
+	# Hole
+	"$DAXCTL" disable-device  $1 &&	"$DAXCTL" destroy-device  $1
+
+	# Pick space in the created hole and at the end
+	new_size=$(expr $size \* 2)
+	daxdev_4=$("$DAXCTL" create-device -s $new_size | jq -er '.[].chardev')
+	test -n $daxdev_4
+
+	fail_if_available
+
+	"$DAXCTL" disable-device all
+	"$DAXCTL" destroy-device all
+}
+
+daxctl_test_multi_reconfig()
+{
+	local ncfgs=$1
+	local daxdev
+
+	size=$(expr $available / $ncfgs)
+
+	test -n "$testdev"
+
+	"$DAXCTL" disable-device "$testdev"
+	"$DAXCTL" reconfigure-device -s $size "$testdev"
+	"$DAXCTL" disable-device "$testdev"
+
+	daxdev_1=$("$DAXCTL" create-device -s $size | jq -er '.[].chardev')
+	"$DAXCTL" disable-device "$daxdev_1"
+
+	start=$(expr $size + $size)
+	max=$(expr $ncfgs / 2 \* $size)
+	for i in $(seq $start $size $max)
+	do
+		"$DAXCTL" disable-device "$testdev"
+		"$DAXCTL" reconfigure-device -s $i "$testdev"
+
+		"$DAXCTL" disable-device "$daxdev_1"
+		"$DAXCTL" reconfigure-device -s $i "$daxdev_1"
+	done
+
+	fail_if_available
+
+	"$DAXCTL" disable-device "$daxdev_1" && "$DAXCTL" destroy-device "$daxdev_1"
+}
+
+daxctl_test_adjust()
+{
+	local rc=1
+	local ncfgs=4
+	local daxdev
+
+	size=$(expr $available / $ncfgs)
+
+	test -n "$testdev"
+
+	start=$(expr $size + $size)
+	for i in $(seq 1 1 $ncfgs)
+	do
+		daxdev=$("$DAXCTL" create-device -s $size)
+	done
+
+	daxdev=$(daxctl_get_dev "dax0.1")
+	"$DAXCTL" disable-device "$daxdev" && "$DAXCTL" destroy-device "$daxdev"
+	daxdev=$(daxctl_get_dev "dax0.4")
+	"$DAXCTL" disable-device "$daxdev" && "$DAXCTL" destroy-device "$daxdev"
+
+	daxdev=$(daxctl_get_dev "dax0.2")
+	"$DAXCTL" disable-device "$daxdev"
+	"$DAXCTL" reconfigure-device -s $(expr $size \* 2) "$daxdev"
+
+	daxdev=$(daxctl_get_dev "dax0.3")
+	"$DAXCTL" disable-device "$daxdev"
+	"$DAXCTL" reconfigure-device -s $(expr $size \* 2) "$daxdev"
+
+	fail_if_available
+
+	daxdev=$(daxctl_get_dev "dax0.3")
+	"$DAXCTL" disable-device "$daxdev" && "$DAXCTL" destroy-device "$daxdev"
+	daxdev=$(daxctl_get_dev "dax0.2")
+	"$DAXCTL" disable-device "$daxdev" && "$DAXCTL" destroy-device "$daxdev"
+}
+
+# Test 0:
+# Sucessfully zero out the region device and allocate the whole space again.
+daxctl_test0()
+{
+	clear_dev
+	test_pass
+}
+
+# Test 1:
+# Sucessfully creates and destroys a device with the whole available space
+daxctl_test1()
+{
+	local daxdev
+
+	daxdev=$("$DAXCTL" create-device | jq -er '.[].chardev')
+
+	test -n "$daxdev"
+	fail_if_available
+
+	"$DAXCTL" disable-device "$daxdev" && "$DAXCTL" destroy-device "$daxdev"
+
+	clear_dev
+	test_pass
+}
+
+# Test 2: space at the middle and at the end
+# Successfully pick space in the middle and space at the end, by
+# having the region device reconfigured with some of the memory.
+daxctl_test2()
+{
+	daxctl_test_multi "dax0.1" 1
+	clear_dev
+	test_pass
+}
+
+# Test 3: space at the beginning and at the end
+# Successfully pick space in the beginning and space at the end, by
+# having the region device emptied (so region beginning starts with dax0.1).
+daxctl_test3()
+{
+	daxctl_test_multi "dax0.1"
+	clear_dev
+	test_pass
+}
+
+# Test 4: space at the end
+# Successfully reconfigure two devices in increasingly bigger allocations.
+# The difference is that it reuses an existing resource, and only needs to
+# pick at the end of the region
+daxctl_test4()
+{
+	daxctl_test_multi_reconfig 8
+	clear_dev
+	test_pass
+}
+
+# Test 5: space adjust
+# Successfully adjusts two resources to fill the whole region
+# First adjusts towards the beginning of region, the second towards the end.
+daxctl_test5()
+{
+	daxctl_test_adjust
+	clear_dev
+	test_pass
+}
+
+find_testdev
+rc=1
+setup_dev
+daxctl_test0
+daxctl_test1
+daxctl_test2
+daxctl_test3
+daxctl_test4
+daxctl_test5
+reset_dev
+exit 0
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
