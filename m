Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB562BA093
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 03:37:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A1DD100EF25D;
	Thu, 19 Nov 2020 18:37:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C28A1100EF25B
	for <linux-nvdimm@lists.01.org>; Thu, 19 Nov 2020 18:37:30 -0800 (PST)
IronPort-SDR: CtkMlwIei1cS4DCQ0eH1Cgo9vU256EkkeKPFS1g+adSOiM9GwTekkYs1OkYj9Gdf0rVeaDyYV0
 itFXg/GVS2NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="170621281"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400";
   d="scan'208";a="170621281"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 18:37:27 -0800
IronPort-SDR: se48A92A3Rjjbj82vDLQNjUawRaPJYHp0AEK6ud2eVbHNrsJr7w5iADqyU9lMC3A1+OYV/dD0e
 YILW692w9Vfw==
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400";
   d="scan'208";a="360268598"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 18:37:25 -0800
Subject: [ndctl PATCH] ndctl/namespace: Reconfigure in-place
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 19 Nov 2020 18:37:25 -0800
Message-ID: <160583984571.3214303.18399638980700230679.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: C7HR7AU6E52SPY6W6JWSJAOFXAIIG7M7
X-Message-ID-Hash: C7HR7AU6E52SPY6W6JWSJAOFXAIIG7M7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Steve Scargall <steve.scargall@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C7HR7AU6E52SPY6W6JWSJAOFXAIIG7M7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

While it has been documented that the namespace reconfiguration process
involves destroying and recreating a namespace, the kernel device changing
as result of a reconfigure operation is surprising. For example a sequence
like:

ndctl create-namespace -s 4G
ndctl create-namespace -s 4G
ndctl create-namespace -s 4G

Results in 3 namespaces:

namespace0.0
namespace0.1
namespace0.2

...whereby after each creation step the next seed is incremented. At the
end of this process namespace0.3 is the next namespace that will be
created. However, when reconfiguration also picks the seed for the target
vessel of the new namespace configuration it is unexpected that:

ndctl create-namespace -e namespace0.1 -m sector

...results in namespace0.3 becoming enabled.

Teach the reconfigure path in ndctl to try to reuse the existing kernel
device whenever possible.

Reported-by: Steve Scargall <steve.scargall@intel.com>
Link: https://github.com/pmem/ndctl/issues/152
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   69 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index f61e0fcda015..f223650628b8 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1091,11 +1091,10 @@ static int zero_info_block(struct ndctl_namespace *ndns)
 	return rc;
 }
 
-static int namespace_destroy(struct ndctl_region *region,
+static int namespace_prep_reconfig(struct ndctl_region *region,
 		struct ndctl_namespace *ndns)
 {
 	const char *devname = ndctl_namespace_get_devname(ndns);
-	unsigned long long size;
 	bool did_zero = false;
 	int rc;
 
@@ -1109,12 +1108,12 @@ static int namespace_destroy(struct ndctl_region *region,
 		error("%s is active, specify --force for re-configuration\n",
 				devname);
 		return -EBUSY;
-	} else {
-		rc = ndctl_namespace_disable_safe(ndns);
-		if (rc)
-			return rc;
 	}
 
+	rc = ndctl_namespace_disable_safe(ndns);
+	if (rc)
+		return rc;
+
 	ndctl_namespace_set_enforce_mode(ndns, NDCTL_NS_MODE_RAW);
 
 	rc = zero_info_block(ndns);
@@ -1126,6 +1125,7 @@ static int namespace_destroy(struct ndctl_region *region,
 	switch (ndctl_namespace_get_type(ndns)) {
         case ND_DEVICE_NAMESPACE_PMEM:
         case ND_DEVICE_NAMESPACE_BLK:
+		rc = 2;
 		break;
 	default:
 		/*
@@ -1137,14 +1137,31 @@ static int namespace_destroy(struct ndctl_region *region,
 			rc = 0;
 		else
 			rc = 1;
-		goto out;
+		break;
 	}
 
+	return rc;
+}
+
+static int namespace_destroy(struct ndctl_region *region,
+		struct ndctl_namespace *ndns)
+{
+	const char *devname = ndctl_namespace_get_devname(ndns);
+	unsigned long long size;
+	int rc;
+
+	rc = namespace_prep_reconfig(region, ndns);
+	if (rc < 0)
+		return rc;
+
 	size = ndctl_namespace_get_size(ndns);
 
-	rc = ndctl_namespace_delete(ndns);
-	if (rc)
-		debug("%s: failed to reclaim\n", devname);
+	/* Labeled namespace, destroy label / allocation */
+	if (rc == 2) {
+		rc = ndctl_namespace_delete(ndns);
+		if (rc)
+			debug("%s: failed to reclaim\n", devname);
+	}
 
 	/*
 	 * Don't report a destroyed namespace when no capacity was
@@ -1153,7 +1170,6 @@ static int namespace_destroy(struct ndctl_region *region,
 	if (size == 0 && rc == 0)
 		rc = 1;
 
-out:
 	return rc;
 }
 
@@ -1167,7 +1183,7 @@ static int enable_labels(struct ndctl_region *region)
 
 	/* no dimms => no labels */
 	if (!mappings)
-		return 0;
+		return -ENODEV;
 
 	count = 0;
 	ndctl_dimm_foreach_in_region(region, dimm) {
@@ -1182,7 +1198,7 @@ static int enable_labels(struct ndctl_region *region)
 
 	/* all the dimms must support labeling */
 	if (count != mappings)
-		return 0;
+		return -ENODEV;
 
 	ndctl_region_disable_invalidate(region);
 	count = 0;
@@ -1250,23 +1266,28 @@ static int namespace_reconfig(struct ndctl_region *region,
 	if (rc)
 		return rc;
 
-	rc = namespace_destroy(region, ndns);
+	rc = namespace_prep_reconfig(region, ndns);
 	if (rc < 0)
 		return rc;
 
 	/* check if we can enable labels on this region */
 	if (ndctl_region_get_nstype(region) == ND_DEVICE_NAMESPACE_IO
 			&& p.autolabel) {
-		/* if this fails, try to continue label-less */
-		enable_labels(region);
-	}
-
-	ndns = region_get_namespace(region);
-	if (!ndns || !ndctl_namespace_is_configuration_idle(ndns)) {
-		debug("%s: no %s namespace seed\n",
-				ndctl_region_get_devname(region),
-				ndns ? "idle" : "available");
-		return -ENODEV;
+		/*
+		 * If this fails, try to continue label-less, if this
+		 * got far enough to invalidate the region than @ndns is
+		 * now invalid.
+		 */
+		rc = enable_labels(region);
+		if (rc != -ENODEV)
+			ndns = region_get_namespace(region);
+		if (!ndns || (rc != -ENODEV
+				&& !ndctl_namespace_is_configuration_idle(ndns))) {
+			debug("%s: no %s namespace seed\n",
+					ndctl_region_get_devname(region),
+					ndns ? "idle" : "available");
+			return -ENODEV;
+		}
 	}
 
 	return setup_namespace(region, ndns, &p);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
