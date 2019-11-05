Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A607DF0410
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Nov 2019 18:27:31 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E34AA100DC427;
	Tue,  5 Nov 2019 09:30:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9587100DC426
	for <linux-nvdimm@lists.01.org>; Tue,  5 Nov 2019 09:30:08 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 09:27:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400";
   d="scan'208";a="232547274"
Received: from vverma7-desk1.amr.corp.intel.com (HELO vverma7-desk1.lm.intel.com) ([10.232.112.164])
  by fmsmga002.fm.intel.com with ESMTP; 05 Nov 2019 09:27:25 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 1/2] ndctl/namespace: Rework counts reported by enable-namespace
Date: Tue,  5 Nov 2019 10:27:12 -0700
Message-Id: <20191105172713.3628-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Message-ID-Hash: ZE52KOAJXRN2DK4VOG4J2U6SJC5X6FZX
X-Message-ID-Hash: ZE52KOAJXRN2DK4VOG4J2U6SJC5X6FZX
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZE52KOAJXRN2DK4VOG4J2U6SJC5X6FZX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add detection of 'seed' namespaces
(ndctl_namespace_is_configuration_idle()) to the enable-namespace
operatiuon and libndctl API. In libndctl, return a '1' for seed
namespaces. In namespace.c, reinterpret a '1' based on a check for a
seed namespace, and decide on skip vs success accordingly. Collect this
into a new namespace_enable helper, and make the reported count
consistent by also skipping namespaces that were already enabled.

Link: https://github.com/pmem/ndctl/issues/119
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---

Changes in v2:
- The kernel is the ultimate authority on enabling namespaces, so we
  should let it make the decision of how to handle seed namespaces
  instead of preemptively skipping them. Let the kernel make that
  decision, and fix up error reporting after the fact.

 ndctl/lib/libndctl.c |  9 +++++++--
 ndctl/namespace.c    | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index d6a2800..cde58ff 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -4045,8 +4045,13 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct ndctl_namespace *ndns)
 			return 1;
 		}
 
-		err(ctx, "%s: failed to enable\n", devname);
-		return rc ? rc : -ENXIO;
+		if (ndctl_namespace_is_configuration_idle(ndns)) {
+			dbg(ctx, "%s: skip seed namespace\n", devname);
+			return 1;
+		} else {
+			err(ctx, "%s: failed to enable\n", devname);
+			return rc ? rc : -ENXIO;
+		}
 	}
 	rc = 0;
 	dbg(ctx, "%s: enabled\n", devname);
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index a07d7e2..f2987ca 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -961,6 +961,36 @@ out:
 	return rc;
 }
 
+/*
+ * Adjust the return convention slightly differently from
+ * ndctl_namespace_enable(). We don't care as much if the enable resulted in
+ * a different namespace personality being attached. We care more about success,
+ * failure, or skipped.
+ * return 0 for success
+ * return < 0 for failure
+ * return > 0 for skipped
+ */
+static int namespace_enable(struct ndctl_namespace *ndns)
+{
+	int rc;
+
+	if (ndctl_namespace_is_enabled(ndns))
+		return 1;
+
+	rc = ndctl_namespace_enable(ndns);
+	if (rc < 0)
+		return rc;
+
+	/*
+	 * ndctl_namespace_enable() returns 'success' even for seed namespaces.
+	 * Reinterpret it to determine success vs. skipped.
+	 */
+	if (ndctl_namespace_is_configuration_idle(ndns))
+		return 1;
+
+	return 0;
+}
+
 static int enable_labels(struct ndctl_region *region)
 {
 	int mappings = ndctl_region_get_mappings(region);
@@ -1401,11 +1431,12 @@ static int do_xaction_namespace(const char *namespace,
 						(*processed)++;
 					break;
 				case ACTION_ENABLE:
-					rc = ndctl_namespace_enable(ndns);
-					if (rc >= 0) {
+					rc = namespace_enable(ndns);
+					if (rc == 0)
 						(*processed)++;
+					/* return success if skipped */
+					if (rc > 0)
 						rc = 0;
-					}
 					break;
 				case ACTION_DESTROY:
 					rc = namespace_destroy(region, ndns);
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
