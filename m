Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8A1DD9B8
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Oct 2019 18:54:10 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D75D01007B75F;
	Sat, 19 Oct 2019 09:56:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB39B1007B759
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 09:56:05 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 09:54:06 -0700
X-IronPort-AV: E=Sophos;i="5.67,316,1566889200";
   d="scan'208";a="201003372"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 09:54:06 -0700
Subject: [ndctl PATCH 2/4] test/dax.sh: Fix xfs 2M alignment
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 19 Oct 2019 09:39:49 -0700
Message-ID: <157150318904.3940762.5575454752395795101.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157150317870.3940762.5638079137146963300.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157150317870.3940762.5638079137146963300.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: SB6LZLUQVUFKAZRHF6VNMF4SJGY3SLBB
X-Message-ID-Hash: SB6LZLUQVUFKAZRHF6VNMF4SJGY3SLBB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SB6LZLUQVUFKAZRHF6VNMF4SJGY3SLBB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update the mkfs parameters for the xfs test to ensure 2M aligned
extents, and validate proper alignment in dax-pmd.c.

Link: https://lkml.kernel.org/r/CAPcyv4g2U6YYj6BO_nMgUYPfE2d04pZvKP0JQwNAMy9HZ3UNvg@mail.gmail.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/dax-pmd.c |    3 ++-
 test/dax.sh    |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/test/dax-pmd.c b/test/dax-pmd.c
index 8ed3e9b764f9..0c95b20707c2 100644
--- a/test/dax-pmd.c
+++ b/test/dax-pmd.c
@@ -234,10 +234,11 @@ static int test_pmd(struct ndctl_test *test, int fd)
 
 	for (i = 0; i < map->fm_mapped_extents; i++) {
 		ext = &map->fm_extents[i];
+		p_align = ALIGN(ext->fe_physical, HPAGE_SIZE) - ext->fe_physical;
 		fprintf(stderr, "[%ld]: l: %llx p: %llx len: %llx flags: %x\n",
 				i, ext->fe_logical, ext->fe_physical,
 				ext->fe_length, ext->fe_flags);
-		if (ext->fe_length > 2 * HPAGE_SIZE) {
+		if (ext->fe_length > 2 * HPAGE_SIZE && p_align == 0) {
 			fprintf(stderr, "found potential huge extent\n");
 			break;
 		}
diff --git a/test/dax.sh b/test/dax.sh
index b8eb4ce54e10..59d5eafadae8 100755
--- a/test/dax.sh
+++ b/test/dax.sh
@@ -69,7 +69,7 @@ json=$($NDCTL create-namespace -m raw -f -e $dev)
 eval $(json2var <<< "$json")
 [ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
 
-mkfs.xfs -f /dev/$blockdev -m reflink=0
+mkfs.xfs -f -d su=2m,sw=1,agcount=2 -m reflink=0 /dev/$blockdev
 mount /dev/$blockdev $MNT -o dax
 fallocate -l 1GiB $MNT/$FILE
 run_test $LINENO
@@ -80,7 +80,7 @@ json=$($NDCTL create-namespace -m fsdax -M dev -f -e $dev)
 eval $(json2var <<< "$json")
 [ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
 
-mkfs.xfs -f /dev/$blockdev -m reflink=0
+mkfs.xfs -f -d su=2m,sw=1,agcount=2 -m reflink=0 /dev/$blockdev
 mount /dev/$blockdev $MNT -o dax
 fallocate -l 1GiB $MNT/$FILE
 run_test $LINENO
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
