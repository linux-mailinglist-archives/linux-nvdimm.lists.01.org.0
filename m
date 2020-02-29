Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4CE17493A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:36:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E41F10FC3404;
	Sat, 29 Feb 2020 12:37:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 29EFA10FC33F7
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:37:27 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:35 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="239110039"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:35 -0800
Subject: [ndctl PATCH 05/36] ndctl/build: Fix distcheck
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 29 Feb 2020 12:20:30 -0800
Message-ID: <158300763037.2141307.975664766998251964.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: XM7Z7WERGCUGSAIMT53ZFYVCPTB5R5MH
X-Message-ID-Hash: XM7Z7WERGCUGSAIMT53ZFYVCPTB5R5MH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Auke Kok <auke-jan.h.kok@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XM7Z7WERGCUGSAIMT53ZFYVCPTB5R5MH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

- Add missing dependencies to EXTRA_DIST

- Fix up relative path names

- Fix up test cleanup to not leave straggling file behind

Reported-by: Auke Kok <auke-jan.h.kok@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/Makefile.am                |    4 +++-
 test/blk-exhaust.sh             |    2 +-
 test/btt-check.sh               |    2 +-
 test/btt-errors.sh              |    7 ++++---
 test/btt-pad-compat.sh          |    5 +++--
 test/clear.sh                   |    2 +-
 test/create.sh                  |    2 +-
 test/dax.sh                     |    2 +-
 test/daxctl-devices.sh          |    2 +-
 test/daxdev-errors.sh           |    2 +-
 test/device-dax-fio.sh          |    2 +-
 test/firmware-update.sh         |    2 +-
 test/inject-error.sh            |    2 +-
 test/inject-smart.sh            |    2 +-
 test/label-compat.sh            |    5 +++--
 test/max_available_extent_ns.sh |    2 +-
 test/mmap.sh                    |    2 +-
 test/monitor.sh                 |    2 +-
 test/multi-dax.sh               |    2 +-
 test/pfn-meta-errors.sh         |    2 +-
 test/pmem-errors.sh             |   11 ++---------
 test/rescan-partitions.sh       |    2 +-
 test/sector-mode.sh             |    2 +-
 test/security.sh                |    2 +-
 24 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/test/Makefile.am b/test/Makefile.am
index 5e795a9e7fdc..58873a6bc341 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -27,7 +27,9 @@ TESTS =\
 	max_available_extent_ns.sh \
 	pfn-meta-errors.sh
 
-EXTRA_DIST = $(TESTS)
+EXTRA_DIST = $(TESTS) common \
+		btt-pad-compat.xxd \
+		nmem1.bin nmem2.bin nmem3.bin nmem4.bin
 
 check_PROGRAMS =\
 	libndctl \
diff --git a/test/blk-exhaust.sh b/test/blk-exhaust.sh
index 326ce73ade6c..db7dc25aecbd 100755
--- a/test/blk-exhaust.sh
+++ b/test/blk-exhaust.sh
@@ -15,7 +15,7 @@ set -e
 
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 check_min_kver "4.11" || do_skip "may lack blk-exhaustion fix"
 
diff --git a/test/btt-check.sh b/test/btt-check.sh
index ceabee52b868..bd782f477728 100755
--- a/test/btt-check.sh
+++ b/test/btt-check.sh
@@ -19,7 +19,7 @@ blockdev=""
 bs=4096
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 trap 'err $LINENO' ERR
 
diff --git a/test/btt-errors.sh b/test/btt-errors.sh
index 00c07960ae7b..a56069789d4b 100755
--- a/test/btt-errors.sh
+++ b/test/btt-errors.sh
@@ -16,14 +16,14 @@ FILE=image
 blockdev=""
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 cleanup()
 {
 	rm -f $FILE
 	rm -f $MNT/$FILE
-	if [ -n "$blockdev" ]; then
-		umount "/dev/$blockdev"
+	if grep -q "$MNT" /proc/mounts; then
+		umount $MNT
 	else
 		rc=77
 	fi
@@ -160,5 +160,6 @@ dd if=/dev/$blockdev of=/dev/null iflag=direct bs=4096 count=1 && err $LINENO ||
 $NDCTL disable-region -b $NFIT_TEST_BUS0 all
 $NDCTL zero-labels -b $NFIT_TEST_BUS0 all
 $NDCTL enable-region -b $NFIT_TEST_BUS0 all
+cleanup
 _cleanup
 exit 0
diff --git a/test/btt-pad-compat.sh b/test/btt-pad-compat.sh
index 2c1f2718c701..b1a46edeaf9d 100755
--- a/test/btt-pad-compat.sh
+++ b/test/btt-pad-compat.sh
@@ -16,7 +16,8 @@ size=""
 blockdev=""
 rc=77
 
-. ./common
+BASE=$(dirname $0)
+. $BASE/common
 
 trap 'err $LINENO' ERR
 
@@ -107,7 +108,7 @@ force_raw()
 copy_xxd_img()
 {
 	local bdev="$1"
-	local xxd_patch="btt-pad-compat.xxd"
+	local xxd_patch="$BASE/btt-pad-compat.xxd"
 
 	test -s "$xxd_patch"
 	test -b "$bdev"
diff --git a/test/clear.sh b/test/clear.sh
index 1bd12da1675a..1fffd166504a 100755
--- a/test/clear.sh
+++ b/test/clear.sh
@@ -15,7 +15,7 @@ set -e
 
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 check_min_kver "4.6" || do_skip "lacks clear poison support"
 
diff --git a/test/create.sh b/test/create.sh
index 8d787976a06f..520f3a9c1dc1 100755
--- a/test/create.sh
+++ b/test/create.sh
@@ -16,7 +16,7 @@ set -e
 SECTOR_SIZE="4096"
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 check_min_kver "4.5" || do_skip "may lack namespace mode attribute"
 
diff --git a/test/dax.sh b/test/dax.sh
index 3933107920a9..5383c433283f 100755
--- a/test/dax.sh
+++ b/test/dax.sh
@@ -11,7 +11,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 # General Public License for more details.
 
-. ./common
+. $(dirname $0)/common
 
 MNT=test_dax_mnt
 FILE=image
diff --git a/test/daxctl-devices.sh b/test/daxctl-devices.sh
index 00f4715d74dd..ff2bcd212294 100755
--- a/test/daxctl-devices.sh
+++ b/test/daxctl-devices.sh
@@ -3,7 +3,7 @@
 # Copyright(c) 2019 Intel Corporation. All rights reserved.
 
 rc=77
-. ./common
+. $(dirname $0)/common
 
 trap 'cleanup $LINENO' ERR
 
diff --git a/test/daxdev-errors.sh b/test/daxdev-errors.sh
index c5adb7260527..15d3e67d1166 100755
--- a/test/daxdev-errors.sh
+++ b/test/daxdev-errors.sh
@@ -15,7 +15,7 @@ set -e
 
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 check_min_kver "4.12" || do_skip "lacks dax dev error handling"
 
diff --git a/test/device-dax-fio.sh b/test/device-dax-fio.sh
index b6d5e0eb1170..d4ca7ab238e4 100755
--- a/test/device-dax-fio.sh
+++ b/test/device-dax-fio.sh
@@ -11,7 +11,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 # General Public License for more details.
 
-. ./common
+. $(dirname $0)/common
 
 rc=77
 
diff --git a/test/firmware-update.sh b/test/firmware-update.sh
index 7852e58e915e..ed7d7e53772c 100755
--- a/test/firmware-update.sh
+++ b/test/firmware-update.sh
@@ -6,7 +6,7 @@ rc=77
 dev=""
 image="update-fw.img"
 
-. ./common
+. $(dirname $0)/common
 
 trap 'err $LINENO' ERR
 
diff --git a/test/inject-error.sh b/test/inject-error.sh
index 825bf181f24c..5667b5131c7a 100755
--- a/test/inject-error.sh
+++ b/test/inject-error.sh
@@ -18,7 +18,7 @@ rc=77
 err_block=42
 err_count=8
 
-. ./common
+. $(dirname $0)/common
 
 trap 'err $LINENO' ERR
 
diff --git a/test/inject-smart.sh b/test/inject-smart.sh
index 18655bab2291..5e563df546b8 100755
--- a/test/inject-smart.sh
+++ b/test/inject-smart.sh
@@ -3,7 +3,7 @@
 # Copyright(c) 2018 Intel Corporation. All rights reserved.
 
 rc=77
-. ./common
+. $(dirname $0)/common
 bus="$NFIT_TEST_BUS0"
 inj_val="42"
 
diff --git a/test/label-compat.sh b/test/label-compat.sh
index dc6226d5e94e..a29dd1367233 100755
--- a/test/label-compat.sh
+++ b/test/label-compat.sh
@@ -15,7 +15,8 @@ set -e
 
 rc=77
 
-. ./common
+BASE=$(dirname $0)
+. $BASE/common
 
 check_min_kver "4.11" || do_skip "may not provide reliable isetcookie values"
 
@@ -36,7 +37,7 @@ dimms=$($NDCTL list -DRi -r $region | jq -r "$query" | xargs)
 i=1
 for d in $dimms
 do
-	$NDCTL write-labels $d -i nmem${i}.bin
+	$NDCTL write-labels $d -i $BASE/nmem${i}.bin
 	i=$((i+1))
 done
 
diff --git a/test/max_available_extent_ns.sh b/test/max_available_extent_ns.sh
index 1c7e7bfa1b83..c6acdabf7fd7 100755
--- a/test/max_available_extent_ns.sh
+++ b/test/max_available_extent_ns.sh
@@ -5,7 +5,7 @@
 
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 trap 'err $LINENO' ERR
 
diff --git a/test/mmap.sh b/test/mmap.sh
index d072ea289f31..0bcc35f619f5 100755
--- a/test/mmap.sh
+++ b/test/mmap.sh
@@ -11,7 +11,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 # General Public License for more details.
 
-. ./common
+. $(dirname $0)/common
 
 MNT=test_mmap_mnt
 FILE=image
diff --git a/test/monitor.sh b/test/monitor.sh
index 29d4ea13d0b7..261fbfa3d461 100755
--- a/test/monitor.sh
+++ b/test/monitor.sh
@@ -12,7 +12,7 @@ monitor_regions=""
 monitor_namespace=""
 smart_supported_bus=""
 
-. ./common
+. $(dirname $0)/common
 
 trap 'err $LINENO' ERR
 
diff --git a/test/multi-dax.sh b/test/multi-dax.sh
index 0829bf2462c4..110ba3d80339 100755
--- a/test/multi-dax.sh
+++ b/test/multi-dax.sh
@@ -15,7 +15,7 @@ set -e
 
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 check_min_kver "4.13" || do_skip "may lack multi-dax support"
 
diff --git a/test/pfn-meta-errors.sh b/test/pfn-meta-errors.sh
index 14a15aed98dd..4ac33d86b8d3 100755
--- a/test/pfn-meta-errors.sh
+++ b/test/pfn-meta-errors.sh
@@ -6,7 +6,7 @@
 blockdev=""
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 force_raw()
 {
diff --git a/test/pmem-errors.sh b/test/pmem-errors.sh
index 3d905082c8e6..f9c8eb213df0 100755
--- a/test/pmem-errors.sh
+++ b/test/pmem-errors.sh
@@ -6,7 +6,7 @@ MNT=test_dax_mnt
 FILE=image
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 cleanup()
 {
@@ -113,14 +113,7 @@ echo $((start_sect + 1)) 1 > /sys/block/$blockdev/badblocks
 : The following 'dd' is expected to hit an I/O Error
 dd if=$MNT/$FILE of=/dev/null iflag=direct bs=4096 count=1 && err $LINENO || true
 
-# cleanup
-rm -f $FILE
-rm -f $MNT/$FILE
-if [ -n "$blockdev" ]; then
-	umount /dev/$blockdev
-fi
-rmdir $MNT
-
+cleanup
 _cleanup
 
 exit 0
diff --git a/test/rescan-partitions.sh b/test/rescan-partitions.sh
index 9c7b7a0151df..b3f2b167053f 100755
--- a/test/rescan-partitions.sh
+++ b/test/rescan-partitions.sh
@@ -7,7 +7,7 @@ size=""
 blockdev=""
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 trap 'err $LINENO' ERR
 
diff --git a/test/sector-mode.sh b/test/sector-mode.sh
index 4b964c5eebc7..eef8dc6d6a3e 100755
--- a/test/sector-mode.sh
+++ b/test/sector-mode.sh
@@ -13,7 +13,7 @@
 
 rc=77
 
-. ./common
+. $(dirname $0)/common
 
 set -e
 trap 'err $LINENO' ERR
diff --git a/test/security.sh b/test/security.sh
index 183e3fea22dd..771135b7ab18 100755
--- a/test/security.sh
+++ b/test/security.sh
@@ -11,7 +11,7 @@ masterpath="$keypath/$masterkey.blob"
 backup_key=0
 backup_handle=0
 
-. ./common
+. $(dirname $0)/common
 
 trap 'err $LINENO' ERR
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
