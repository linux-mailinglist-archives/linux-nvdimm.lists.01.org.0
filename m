Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B125977C25
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:54:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 30F4C212E2594;
	Sat, 27 Jul 2019 14:56:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0032B212E15B5
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:56:36 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:54:09 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="182272379"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:54:09 -0700
Subject: [ndctl PATCH v2 06/26] ndctl/test: Make dax.sh more robust vs small
 namespaces
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:39:52 -0700
Message-ID: <156426359229.531577.14331405344075253387.stgit@dwillia2-desk3.amr.corp.intel.com>
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

If the namespace returned by test/dax-dev is too small ext4 may default
to a 1K block-size. A 1K block-size precludes dax operation, so force a
4K block-size in all cases.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/dax.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/dax.sh b/test/dax.sh
index d38fd01acb07..e703e1222dee 100755
--- a/test/dax.sh
+++ b/test/dax.sh
@@ -47,7 +47,7 @@ json=$($NDCTL list -N -n $dev)
 eval $(json2var <<< "$json")
 rc=1
 
-mkfs.ext4 /dev/$blockdev
+mkfs.ext4 -b 4096 /dev/$blockdev
 mount /dev/$blockdev $MNT -o dax
 fallocate -l 1GiB $MNT/$FILE
 run_test
@@ -59,7 +59,7 @@ eval $(json2var <<< "$json")
 [ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
 
 #note the blockdev returned from ndctl create-namespace lacks the /dev prefix
-mkfs.ext4 /dev/$blockdev
+mkfs.ext4 -b 4096 /dev/$blockdev
 mount /dev/$blockdev $MNT -o dax
 fallocate -l 1GiB $MNT/$FILE
 run_test

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
