Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A7DD9BA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Oct 2019 18:54:20 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0FEC31007B75C;
	Sat, 19 Oct 2019 09:56:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C8D891007B761
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 09:56:15 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 09:54:16 -0700
X-IronPort-AV: E=Sophos;i="5.67,316,1566889200";
   d="scan'208";a="348376818"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 09:54:16 -0700
Subject: [ndctl PATCH 4/4] test/dax.sh: Split into ext4 and xfs tests
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 19 Oct 2019 09:39:59 -0700
Message-ID: <157150319928.3940762.16493495662939393302.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157150317870.3940762.5638079137146963300.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157150317870.3940762.5638079137146963300.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: DUQYACINFXJW5TA3PI6PA6VWWWL3HVMN
X-Message-ID-Hash: DUQYACINFXJW5TA3PI6PA6VWWWL3HVMN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DUQYACINFXJW5TA3PI6PA6VWWWL3HVMN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Given the test can fail based on the fs make it a passed in parameter
and split the tests.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/Makefile.am |    3 +-
 test/dax-ext4.sh |    1 +
 test/dax-xfs.sh  |    1 +
 test/dax.sh      |  101 +++++++++++++++++++++++++++++++-----------------------
 4 files changed, 62 insertions(+), 44 deletions(-)
 create mode 120000 test/dax-ext4.sh
 create mode 120000 test/dax-xfs.sh

diff --git a/test/Makefile.am b/test/Makefile.am
index ffbe8a3d7e34..3612e58d46b6 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -48,7 +48,8 @@ TESTS +=\
 	pmem-ns \
 	sub-section.sh \
 	dax-dev \
-	dax.sh \
+	dax-ext4.sh \
+	dax-xfs.sh \
 	device-dax \
 	device-dax-fio.sh \
 	daxctl-devices.sh \
diff --git a/test/dax-ext4.sh b/test/dax-ext4.sh
new file mode 120000
index 000000000000..da4ec437a92a
--- /dev/null
+++ b/test/dax-ext4.sh
@@ -0,0 +1 @@
+dax.sh
\ No newline at end of file
diff --git a/test/dax-xfs.sh b/test/dax-xfs.sh
new file mode 120000
index 000000000000..da4ec437a92a
--- /dev/null
+++ b/test/dax-xfs.sh
@@ -0,0 +1 @@
+dax.sh
\ No newline at end of file
diff --git a/test/dax.sh b/test/dax.sh
index e5945fc3e335..ed1738d58bb7 100755
--- a/test/dax.sh
+++ b/test/dax.sh
@@ -58,6 +58,56 @@ run_test() {
 	fi
 }
 
+run_ext4() {
+	mkfs.ext4 -b 4096 /dev/$blockdev
+	mount /dev/$blockdev $MNT -o dax
+	fallocate -l 1GiB $MNT/$FILE
+	run_test $LINENO
+	umount $MNT
+
+	# convert pmem to put the memmap on the device
+	json=$($NDCTL create-namespace -m fsdax -M dev -f -e $dev)
+	eval $(json2var <<< "$json")
+	[ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
+	#note the blockdev returned from ndctl create-namespace lacks the /dev prefix
+
+	mkfs.ext4 -b 4096 /dev/$blockdev
+	mount /dev/$blockdev $MNT -o dax
+	fallocate -l 1GiB $MNT/$FILE
+	run_test $LINENO
+	umount $MNT
+	json=$($NDCTL create-namespace -m raw -f -e $dev)
+
+	eval $(json2var <<< "$json")
+	[ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
+	true
+}
+
+run_xfs() {
+	mkfs.xfs -f -d su=2m,sw=1,agcount=2 -m reflink=0 /dev/$blockdev
+	mount /dev/$blockdev $MNT -o dax
+	fallocate -l 1GiB $MNT/$FILE
+	run_test $LINENO
+	umount $MNT
+
+	# convert pmem to put the memmap on the device
+	json=$($NDCTL create-namespace -m fsdax -M dev -f -e $dev)
+	eval $(json2var <<< "$json")
+	[ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
+	mkfs.xfs -f -d su=2m,sw=1,agcount=2 -m reflink=0 /dev/$blockdev
+
+	mount /dev/$blockdev $MNT -o dax
+	fallocate -l 1GiB $MNT/$FILE
+	run_test $LINENO
+	umount $MNT
+	# revert namespace to raw mode
+
+	json=$($NDCTL create-namespace -m raw -f -e $dev)
+	eval $(json2var <<< "$json")
+	[ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
+	true
+}
+
 set -e
 mkdir -p $MNT
 trap 'err $LINENO cleanup' ERR
@@ -67,48 +117,13 @@ json=$($NDCTL list -N -n $dev)
 eval $(json2var <<< "$json")
 rc=1
 
-mkfs.ext4 -b 4096 /dev/$blockdev
-mount /dev/$blockdev $MNT -o dax
-fallocate -l 1GiB $MNT/$FILE
-run_test $LINENO
-umount $MNT
-
-# convert pmem to put the memmap on the device
-json=$($NDCTL create-namespace -m fsdax -M dev -f -e $dev)
-eval $(json2var <<< "$json")
-[ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
-
-#note the blockdev returned from ndctl create-namespace lacks the /dev prefix
-mkfs.ext4 -b 4096 /dev/$blockdev
-mount /dev/$blockdev $MNT -o dax
-fallocate -l 1GiB $MNT/$FILE
-run_test $LINENO
-umount $MNT
-
-json=$($NDCTL create-namespace -m raw -f -e $dev)
-eval $(json2var <<< "$json")
-[ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
-
-mkfs.xfs -f -d su=2m,sw=1,agcount=2 -m reflink=0 /dev/$blockdev
-mount /dev/$blockdev $MNT -o dax
-fallocate -l 1GiB $MNT/$FILE
-run_test $LINENO
-umount $MNT
-
-# convert pmem to put the memmap on the device
-json=$($NDCTL create-namespace -m fsdax -M dev -f -e $dev)
-eval $(json2var <<< "$json")
-[ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
-
-mkfs.xfs -f -d su=2m,sw=1,agcount=2 -m reflink=0 /dev/$blockdev
-mount /dev/$blockdev $MNT -o dax
-fallocate -l 1GiB $MNT/$FILE
-run_test $LINENO
-umount $MNT
-
-# revert namespace to raw mode
-json=$($NDCTL create-namespace -m raw -f -e $dev)
-eval $(json2var <<< "$json")
-[ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
+if [ $(basename $0) = "dax-ext4.sh" ]; then
+	run_ext4
+elif [ $(basename $0) = "dax-xfs.sh" ]; then
+	run_xfs
+else
+	run_ext4
+	run_xfs
+fi
 
 exit 0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
