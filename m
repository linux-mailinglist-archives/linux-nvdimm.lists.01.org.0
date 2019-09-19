Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA512B8836
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Sep 2019 01:46:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F036202EC049;
	Thu, 19 Sep 2019 16:45:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=dave.jiang@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9A961202EC042
 for <linux-nvdimm@lists.01.org>; Thu, 19 Sep 2019 16:45:40 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 16:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,526,1559545200"; d="scan'208";a="217476015"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
 by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2019 16:46:36 -0700
Subject: [PATCH] libnvdimm: prevent nvdimm from requesting key when security
 is disabled
From: Dave Jiang <dave.jiang@intel.com>
To: dan.j.williams@intel.com
Date: Thu, 19 Sep 2019 16:46:36 -0700
Message-ID: <156893679671.13979.11441470387200549191.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
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
Cc: jthumshirn@suse.com, peter.stark@ts.fujitsu.com, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Current implementation attempts to request keys from the keyring even when
security is not enabled. Change behavior so when security is disabled it
will skip key request.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/nvdimm/security.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 9e45b207ff01..89b85970912d 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -177,6 +177,10 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
 			|| !nvdimm->sec.flags)
 		return -EIO;
 
+	/* No need to go further if security is disabled */
+	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
+		return 0;
+
 	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
 		dev_dbg(dev, "Security operation in progress.\n");
 		return -EBUSY;

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
