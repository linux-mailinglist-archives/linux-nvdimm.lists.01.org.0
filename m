Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF49E57C0
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Oct 2019 03:20:43 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C031100EA603;
	Fri, 25 Oct 2019 18:21:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3E9C1100EA603
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 18:21:50 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 18:20:39 -0700
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400";
   d="scan'208";a="202765243"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 18:20:39 -0700
Subject: [ndctl PATCH 1/2] test/dax.sh: Make dax.sh more robust vs small
 namespaces
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Fri, 25 Oct 2019 18:06:22 -0700
Message-ID: <157205198226.4128114.4933188611203174148.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157205197710.4128114.10329643056047769577.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157205197710.4128114.10329643056047769577.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: EEIGG5TJZASP4AOEQTANRTMSB46FAZCV
X-Message-ID-Hash: EEIGG5TJZASP4AOEQTANRTMSB46FAZCV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EEIGG5TJZASP4AOEQTANRTMSB46FAZCV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If the namespace returned by test/dax-dev is too small ext4 may default
to a 1K block-size. A 1K block-size precludes dax operation, so force a
4K block-size in all cases.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/dax.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/dax.sh b/test/dax.sh
index 45c2027494e8..44bc6436a4a9 100755
--- a/test/dax.sh
+++ b/test/dax.sh
@@ -68,7 +68,7 @@ json=$($NDCTL list -N -n $dev)
 eval $(json2var <<< "$json")
 rc=1
 
-mkfs.ext4 /dev/$blockdev
+mkfs.ext4 -b 4096 /dev/$blockdev
 mount /dev/$blockdev $MNT -o dax
 fallocate -l 1GiB $MNT/$FILE
 run_test $LINENO
@@ -80,7 +80,7 @@ eval $(json2var <<< "$json")
 [ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
 
 #note the blockdev returned from ndctl create-namespace lacks the /dev prefix
-mkfs.ext4 /dev/$blockdev
+mkfs.ext4 -b 4096 /dev/$blockdev
 mount /dev/$blockdev $MNT -o dax
 fallocate -l 1GiB $MNT/$FILE
 run_test $LINENO
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
