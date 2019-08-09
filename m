Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B986F67
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Aug 2019 03:35:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 30B9821311C1B;
	Thu,  8 Aug 2019 18:38:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B399B21309D22
 for <linux-nvdimm@lists.01.org>; Thu,  8 Aug 2019 18:38:12 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Aug 2019 18:35:38 -0700
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; d="scan'208";a="350362602"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Aug 2019 18:35:38 -0700
Subject: [ndctl PATCH] ndctl/test: Add xfs reflink dependency
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 08 Aug 2019 18:21:21 -0700
Message-ID: <156531368129.2136155.4247732841095137080.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Starting with xfsprogs version 5.1.0 it will enable reflink by default.
Any scripts, like ndctl unit tests, that were doing:

    mkfs.xfs $pmem; mount -o dax $pmem $mnt

...must now do:

    mkfs.xfs -m reflink=0 $pmem; mount -o dax $pmem $mnt

Cc: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/dax.sh  |    4 ++--
 test/mmap.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/dax.sh b/test/dax.sh
index e703e1222dee..3bb44ac0a26c 100755
--- a/test/dax.sh
+++ b/test/dax.sh
@@ -69,7 +69,7 @@ json=$($NDCTL create-namespace -m raw -f -e $dev)
 eval $(json2var <<< "$json")
 [ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
 
-mkfs.xfs -f /dev/$blockdev
+mkfs.xfs -f /dev/$blockdev -m reflink=0
 mount /dev/$blockdev $MNT -o dax
 fallocate -l 1GiB $MNT/$FILE
 run_test
@@ -80,7 +80,7 @@ json=$($NDCTL create-namespace -m fsdax -M dev -f -e $dev)
 eval $(json2var <<< "$json")
 [ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
 
-mkfs.xfs -f /dev/$blockdev
+mkfs.xfs -f /dev/$blockdev -m reflink=0
 mount /dev/$blockdev $MNT -o dax
 fallocate -l 1GiB $MNT/$FILE
 run_test
diff --git a/test/mmap.sh b/test/mmap.sh
index afe50fd2199b..d072ea289f31 100755
--- a/test/mmap.sh
+++ b/test/mmap.sh
@@ -70,7 +70,7 @@ fallocate -l 1GiB $MNT/$FILE
 test_mmap
 umount $MNT
 
-mkfs.xfs -f $DEV
+mkfs.xfs -f $DEV -m reflink=0
 mount $DEV $MNT -o dax
 fallocate -l 1GiB $MNT/$FILE
 test_mmap

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
