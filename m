Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C3467DE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 20:52:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C9942129EBBC;
	Fri, 14 Jun 2019 11:52:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1DA1F2129EBB8
 for <linux-nvdimm@lists.01.org>; Fri, 14 Jun 2019 11:52:33 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jun 2019 11:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,373,1557212400"; d="scan'208";a="185051531"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2019 11:52:32 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH] libndctl/inject: Refuse error injection for BTT
 namespaces
Date: Fri, 14 Jun 2019 12:52:22 -0600
Message-Id: <20190614185222.30068-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
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
Cc: Marek de Rosier <marekx.de.rosier@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Error injection on a BTT namespace would treat the namespace as 'raw'
for the purposes of the injection. This can be useful for development,
but to a user this can be surprising, as injecting with --block=1 would
corrupt the BTT info block, and the BTT would be lost.

The unit tests do not rely on injecting errors directly into a BTT
namespace - they convert the namespace to 'raw' mode before performing
such an injection. For development and testing purposes, we will still
retain this ability by enforcing that the BTT namespace be explicitly
forced into raw mode before injection.

Reported-by: Marek de Rosier <marekx.de.rosier@intel.com>
Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/lib/inject.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/ndctl/lib/inject.c b/ndctl/lib/inject.c
index c35d0f3..815f254 100644
--- a/ndctl/lib/inject.c
+++ b/ndctl/lib/inject.c
@@ -34,28 +34,36 @@ NDCTL_EXPORT int ndctl_bus_has_error_injection(struct ndctl_bus *bus)
 	return 0;
 }
 
-static void ndctl_namespace_get_injection_bounds(
+static int ndctl_namespace_get_injection_bounds(
 		struct ndctl_namespace *ndns, unsigned long long *ns_offset,
 		unsigned long long *ns_size)
 {
 	struct ndctl_pfn *pfn = ndctl_namespace_get_pfn(ndns);
 	struct ndctl_dax *dax = ndctl_namespace_get_dax(ndns);
+	struct ndctl_btt *btt = ndctl_namespace_get_btt(ndns);
 
 	if (!ns_offset || !ns_size)
-		return;
+		return -ENXIO;
 
 	if (pfn) {
 		*ns_offset = ndctl_pfn_get_resource(pfn);
 		*ns_size = ndctl_pfn_get_size(pfn);
-		return;
-	} else if (dax) {
+		return 0;
+	}
+
+	if (dax) {
 		*ns_offset = ndctl_dax_get_resource(dax);
 		*ns_size = ndctl_dax_get_size(dax);
-		return;
+		return 0;
 	}
-	/* raw or btt */
+
+	if (btt)
+		return -EOPNOTSUPP;
+
+	/* raw */
 	*ns_offset = ndctl_namespace_get_resource(ndns);
 	*ns_size = ndctl_namespace_get_size(ndns);
+	return 0;
 }
 
 static int block_to_spa_offset(struct ndctl_namespace *ndns,
@@ -64,8 +72,11 @@ static int block_to_spa_offset(struct ndctl_namespace *ndns,
 {
 	struct ndctl_ctx *ctx = ndctl_namespace_get_ctx(ndns);
 	unsigned long long ns_offset, ns_size;
+	int rc;
 
-	ndctl_namespace_get_injection_bounds(ndns, &ns_offset, &ns_size);
+	rc = ndctl_namespace_get_injection_bounds(ndns, &ns_offset, &ns_size);
+	if (rc)
+		return rc;
 	*offset = ns_offset + block * 512;
 	*length = count * 512;
 
@@ -98,8 +109,10 @@ static int ndctl_namespace_get_clear_unit(struct ndctl_namespace *ndns)
 	struct ndctl_cmd *cmd;
 	int rc;
 
-	ndctl_namespace_get_injection_bounds(ndns, &ns_offset,
+	rc = ndctl_namespace_get_injection_bounds(ndns, &ns_offset,
 		&ns_size);
+	if (rc)
+		return rc;
 	cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
 	rc = ndctl_cmd_submit(cmd);
 	if (rc < 0) {
@@ -438,8 +451,10 @@ NDCTL_EXPORT int ndctl_namespace_injection_status(struct ndctl_namespace *ndns)
 		return -EOPNOTSUPP;
 
 	if (ndctl_bus_has_nfit(bus)) {
-		ndctl_namespace_get_injection_bounds(ndns, &ns_offset,
+		rc = ndctl_namespace_get_injection_bounds(ndns, &ns_offset,
 			&ns_size);
+		if (rc)
+			return rc;
 
 		cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
 		rc = ndctl_cmd_submit(cmd);
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
