Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ABD123D79
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Dec 2019 03:51:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4608510113634;
	Tue, 17 Dec 2019 18:55:19 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=yi.zhang@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 81A1010113602
	for <linux-nvdimm@lists.01.org>; Tue, 17 Dec 2019 18:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1576637512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VpTMRvlR9bJrRBCDegstpRdbfuqMrf8GaVSNPtFhq34=;
	b=WZ0JqndCY1mr4ygt4uKrySnp6wp3ny1p66vefHgVXNnZoklE6+k6CGWORYNGEeDZNxGfc3
	Ghs/r7YUV+xzP8/J8QU6y7jggNTQozjeXiCT91td6XvclFv6eLYxqeI3S9HJXoalmis+fO
	P926QWoO7FsM0hRfpZT4NyrHHJiX6e4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-104Ni0U5MEa_p39lGktepQ-1; Tue, 17 Dec 2019 21:51:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 460B81005502;
	Wed, 18 Dec 2019 02:51:49 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (dhcp-12-105.nay.redhat.com [10.66.12.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2C31760FC1;
	Wed, 18 Dec 2019 02:51:47 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com
Subject: [PATCH ndctl] ndctl, test: add bus-id parameter for start-scrub/wait-scrub operation
Date: Wed, 18 Dec 2019 10:51:45 +0800
Message-Id: <20191218025145.26741-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 104Ni0U5MEa_p39lGktepQ-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: Q7VR2Q2GGX4XKRMPCVVHADJNM66OPZ52
X-Message-ID-Hash: Q7VR2Q2GGX4XKRMPCVVHADJNM66OPZ52
X-MailFrom: yi.zhang@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q7VR2Q2GGX4XKRMPCVVHADJNM66OPZ52/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On some NVDIMM servers, scrub operation will take long time to be finished
as it start on all nvdimm buses in the system, add the bus-id parameter to
do the scrub on the NFIT_TEST_BUS0

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 test/btt-errors.sh      | 4 ++--
 test/clear.sh           | 2 +-
 test/inject-error.sh    | 2 +-
 test/pfn-meta-errors.sh | 2 +-
 test/pmem-errors.sh     | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/btt-errors.sh b/test/btt-errors.sh
index cb35865..00c0796 100755
--- a/test/btt-errors.sh
+++ b/test/btt-errors.sh
@@ -115,7 +115,7 @@ bb_inj=$((dataoff/512))
 
 # inject badblocks for one page at the start of the file
 $NDCTL inject-error --block="$bb_inj" --count=8 $dev
-$NDCTL start-scrub && $NDCTL wait-scrub
+$NDCTL start-scrub $NFIT_TEST_BUS0 && $NDCTL wait-scrub $NFIT_TEST_BUS0
 
 force_raw 0
 mount -o nodelalloc "/dev/$blockdev" $MNT
@@ -149,7 +149,7 @@ map=$(hexdump -s 96 -n 4 "/dev/$raw_bdev" | head -1 | cut -d' ' -f2-)
 map=$(tr -d ' ' <<< "0x${map#* }${map%% *}")
 bb_inj=$((map/512))
 $NDCTL inject-error --block="$bb_inj" --count=1 $dev
-$NDCTL start-scrub && $NDCTL wait-scrub
+$NDCTL start-scrub $NFIT_TEST_BUS0 && $NDCTL wait-scrub $NFIT_TEST_BUS0
 force_raw 0
 
 # make sure reading the first block of the namespace fails
diff --git a/test/clear.sh b/test/clear.sh
index 17d5bed..1bd12da 100755
--- a/test/clear.sh
+++ b/test/clear.sh
@@ -41,7 +41,7 @@ err_sector="$(((size/512) / 2))"
 err_count=8
 if ! read sector len < /sys/block/$blockdev/badblocks; then
 	$NDCTL inject-error --block="$err_sector" --count=$err_count $dev
-	$NDCTL start-scrub && $NDCTL wait-scrub
+	$NDCTL start-scrub $NFIT_TEST_BUS0 && $NDCTL wait-scrub $NFIT_TEST_BUS0
 fi
 read sector len < /sys/block/$blockdev/badblocks
 [ $((sector * 2)) -ne $((size /512)) ] && echo "fail: $LINENO" && exit 1
diff --git a/test/inject-error.sh b/test/inject-error.sh
index 49e68b3..825bf18 100755
--- a/test/inject-error.sh
+++ b/test/inject-error.sh
@@ -77,7 +77,7 @@ do_tests()
 
 	# inject normally
 	$NDCTL inject-error --block=$err_block --count=$err_count $dev
-	$NDCTL start-scrub && $NDCTL wait-scrub
+	$NDCTL start-scrub $NFIT_TEST_BUS0 && $NDCTL wait-scrub $NFIT_TEST_BUS0
 	check_status "$err_block" "$err_count"
 	if read -r sector len < /sys/block/$blockdev/badblocks; then
 		test "$sector" -eq "$err_block"
diff --git a/test/pfn-meta-errors.sh b/test/pfn-meta-errors.sh
index 2b57f19..14a15ae 100755
--- a/test/pfn-meta-errors.sh
+++ b/test/pfn-meta-errors.sh
@@ -61,7 +61,7 @@ mblk="$((metaoff/512))"
 # inject in the middle of the struct page area
 bb_inj=$(((dblk - mblk)/2))
 $NDCTL inject-error --block="$bb_inj" --count=32 $dev
-$NDCTL start-scrub && $NDCTL wait-scrub
+$NDCTL start-scrub $NFIT_TEST_BUS0 && $NDCTL wait-scrub $NFIT_TEST_BUS0
 
 # after probe from the enable-namespace, the error should've been cleared
 force_raw 0
diff --git a/test/pmem-errors.sh b/test/pmem-errors.sh
index 9553a3f..3d90508 100755
--- a/test/pmem-errors.sh
+++ b/test/pmem-errors.sh
@@ -46,7 +46,7 @@ err_sector="$(((size/512) / 2))"
 err_count=8
 if ! read sector len < /sys/block/$blockdev/badblocks; then
 	$NDCTL inject-error --block="$err_sector" --count=$err_count $dev
-	$NDCTL start-scrub; $NDCTL wait-scrub
+	$NDCTL start-scrub $NFIT_TEST_BUS0; $NDCTL wait-scrub $NFIT_TEST_BUS0
 fi
 read sector len < /sys/block/$blockdev/badblocks
 [ $((sector * 2)) -ne $((size /512)) ] && echo "fail: $LINENO" && false
-- 
2.21.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
