Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2891A354
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 21:08:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6287D212377E1;
	Fri, 10 May 2019 12:08:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4C4BA21237AC1
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 12:08:44 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 May 2019 12:08:43 -0700
X-ExtLoop1: 1
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by orsmga007.jf.intel.com with ESMTP; 10 May 2019 12:08:43 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 2/4] ndctl/namespace.c: fix an unchecked return value
Date: Fri, 10 May 2019 13:08:37 -0600
Message-Id: <20190510190839.29637-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510190839.29637-1-vishal.l.verma@intel.com>
References: <20190510190839.29637-1-vishal.l.verma@intel.com>
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

Static analysis complains that we were neglecting to check the return
value from the ndctl_enable_namespace call in nstype_clear_badblocks.

The instance pointed out is in an error-out path, so there isn't much to
do there, however if the enable fails, we can check for it and print a
message. This ends up being more user friendly in addition to quelling
the warning.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/namespace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index e281298..31e6ecd 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1134,8 +1134,10 @@ static int nstype_clear_badblocks(struct ndctl_namespace *ndns,
 
 	region_begin = ndctl_region_get_resource(region);
 	if (region_begin == ULLONG_MAX) {
-		ndctl_namespace_enable(ndns);
-		return -errno;
+		rc = -errno;
+		if (ndctl_namespace_enable(ndns) < 0)
+			error("%s: failed to reenable namespace\n", devname);
+		return rc;
 	}
 
 	dev_end = dev_begin + dev_size - 1;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
