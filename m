Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF04F1A353
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 21:08:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 210602126578C;
	Fri, 10 May 2019 12:08:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0F42821237808
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
Subject: [ndctl PATCH 1/4] ndctl/namespace.c: fix resource leak
Date: Fri, 10 May 2019 13:08:36 -0600
Message-Id: <20190510190839.29637-2-vishal.l.verma@intel.com>
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

Static analysis warns that we could be leaking cmd_cap and cmd_clear.
Fix the error handling to avoid the leaks.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/namespace.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index c7abcbf..e281298 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1083,40 +1083,42 @@ static int bus_send_clear(struct ndctl_bus *bus, unsigned long long start,
 	rc = ndctl_cmd_submit_xlat(cmd_cap);
 	if (rc < 0) {
 		debug("bus: %s failed to submit cmd: %d\n", busname, rc);
-		ndctl_cmd_unref(cmd_cap);
-		return rc;
+		goto out_cap;
 	}
 
 	/* send clear_error */
 	if (ndctl_cmd_ars_cap_get_range(cmd_cap, &range)) {
 		debug("bus: %s failed to get ars_cap range\n", busname);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto out_cap;
 	}
 
 	cmd_clear = ndctl_bus_cmd_new_clear_error(range.address,
 					range.length, cmd_cap);
 	if (!cmd_clear) {
 		debug("bus: %s failed to create cmd\n", busname);
-		return -ENOTTY;
+		rc = -ENOTTY;
+		goto out_cap;
 	}
 
 	rc = ndctl_cmd_submit_xlat(cmd_clear);
 	if (rc < 0) {
 		debug("bus: %s failed to submit cmd: %d\n", busname, rc);
-		ndctl_cmd_unref(cmd_clear);
-		return rc;
+		goto out_clr;
 	}
 
 	cleared = ndctl_cmd_clear_error_get_cleared(cmd_clear);
 	if (cleared != range.length) {
 		debug("bus: %s expected to clear: %lld actual: %lld\n",
 				busname, range.length, cleared);
-		return -ENXIO;
+		rc = -ENXIO;
 	}
 
-	ndctl_cmd_unref(cmd_cap);
+out_clr:
 	ndctl_cmd_unref(cmd_clear);
-	return 0;
+out_cap:
+	ndctl_cmd_unref(cmd_cap);
+	return rc;
 }
 
 static int nstype_clear_badblocks(struct ndctl_namespace *ndns,
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
