Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A51D86F68
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Aug 2019 03:35:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 499FD2131D57C;
	Thu,  8 Aug 2019 18:38:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DC52B21309D22
 for <linux-nvdimm@lists.01.org>; Thu,  8 Aug 2019 18:38:14 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Aug 2019 18:35:43 -0700
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; d="scan'208";a="326492355"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Aug 2019 18:35:43 -0700
Subject: [ndctl PATCH] daxctl/test: Skip daxctl-devices.sh on older kernels
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 08 Aug 2019 18:21:26 -0700
Message-ID: <156531368648.2136155.13013612862545053331.stgit@dwillia2-desk3.amr.corp.intel.com>
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

If the 'kmem' module is missing skip the test to support running the
unit tests on older -stable kernels pre-v5.1.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/daxctl-devices.sh |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/test/daxctl-devices.sh b/test/daxctl-devices.sh
index 04f53f7b13ab..4102fb6990ae 100755
--- a/test/daxctl-devices.sh
+++ b/test/daxctl-devices.sh
@@ -18,6 +18,13 @@ find_testdev()
 {
 	local rc=77
 
+	# The kmem driver is needed to change the device mode, only
+	# kernels >= v5.1 might have it available. Skip if not.
+	if ! modinfo kmem; then
+		"Unable to find kmem module"
+		exit $rc
+	fi
+
 	# find a victim device
 	testbus="$ACPI_BUS"
 	testdev=$("$NDCTL" list -b "$testbus" -Ni | jq -er '.[0].dev | .//""')

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
