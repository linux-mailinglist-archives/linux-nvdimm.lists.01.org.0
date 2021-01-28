Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA211307A45
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 17:05:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DCE84100EAB44;
	Thu, 28 Jan 2021 08:05:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B66BC100EAB41
	for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 08:05:25 -0800 (PST)
IronPort-SDR: /WEnxfbH/6WiFJov1gzs7LISLAig02YGKHtjmzeaT2T13LFyaijzg5Qu0pE0lbeJegzcsqOXTL
 idIa67JF3/dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="180335920"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400";
   d="scan'208";a="180335920"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 08:05:02 -0800
IronPort-SDR: enxwOT95FyvZcDAGyFtN/yx0hY4Z0Df5SS5mkxRF6UVxvUq08SFeBN/pkpdAVo5WvpDoB4u95W
 RPRBH3qy/x5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400";
   d="scan'208";a="473881816"
Received: from unknown (HELO localhost.itwn.intel.com) ([10.5.250.84])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2021 08:05:01 -0800
From: redhairer <redhairer.li@intel.com>
To: linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com
Subject: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting relative to seed devices
Date: Thu, 28 Jan 2021 22:03:39 +0800
Message-Id: <20210128140339.3080-1-redhairer.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAPcyv4iG9XMfrhKn+vSmU2RjyeaHtiF2pprGJ6t-56uOtPNSJg@mail.gmail.com>
References: <CAPcyv4iG9XMfrhKn+vSmU2RjyeaHtiF2pprGJ6t-56uOtPNSJg@mail.gmail.com>
MIME-Version: 1.0
Message-ID-Hash: 3Y7SYR3XCO2OAX2NLZL3U7EHLZQ3JNMO
X-Message-ID-Hash: 3Y7SYR3XCO2OAX2NLZL3U7EHLZQ3JNMO
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Redhairer Li <redhairer.li@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3Y7SYR3XCO2OAX2NLZL3U7EHLZQ3JNMO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Redhairer Li <redhairer.li@intel.com>

Seed namespaces are included in "ndctl disable-namespace all". However
since the user never "creates" them it is surprising to see
"disable-namespace" report 1 more namespace relative to the number that
have been created. Catch attempts to disable a zero-sized namespace:

Before:
{
  "dev":"namespace1.0",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1"
}
{
  "dev":"namespace1.1",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1.1"
}
{
  "dev":"namespace1.2",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1.2"
}
disabled 4 namespaces

After:
{
  "dev":"namespace1.0",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1"
}
{
  "dev":"namespace1.3",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1.3"
}
{
  "dev":"namespace1.1",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1.1"
}
disabled 3 namespaces

Signed-off-by: Redhairer Li <redhairer.li@intel.com>
---
 ndctl/lib/libndctl.c | 10 ++++++++--
 ndctl/namespace.c    |  8 ++++----
 ndctl/region.c       |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 36fb6fe..2f6d806 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -4602,6 +4602,7 @@ NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
 	const char *bdev = NULL;
 	char path[50];
 	int fd;
+	unsigned long long size = ndctl_namespace_get_size(ndns);
 
 	if (pfn && ndctl_pfn_is_enabled(pfn))
 		bdev = ndctl_pfn_get_block_device(pfn);
@@ -4631,8 +4632,13 @@ NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
 					devname, bdev, strerror(errno));
 			return -errno;
 		}
-	} else
-		ndctl_namespace_disable_invalidate(ndns);
+	} else {
+		if (size == 0)
+			/* No disable necessary due to no capacity allocated */
+			return 1;
+		else
+			ndctl_namespace_disable_invalidate(ndns);
+	}
 
 	return 0;
 }
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 0c8df9f..1feb74d 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1125,7 +1125,7 @@ static int namespace_prep_reconfig(struct ndctl_region *region,
 	}
 
 	rc = ndctl_namespace_disable_safe(ndns);
-	if (rc)
+	if (rc < 0)
 		return rc;
 
 	ndctl_namespace_set_enforce_mode(ndns, NDCTL_NS_MODE_RAW);
@@ -1431,7 +1431,7 @@ static int dax_clear_badblocks(struct ndctl_dax *dax)
 		return -ENXIO;
 
 	rc = ndctl_namespace_disable_safe(ndns);
-	if (rc) {
+	if (rc < 0) {
 		error("%s: unable to disable namespace: %s\n", devname,
 			strerror(-rc));
 		return rc;
@@ -1455,7 +1455,7 @@ static int pfn_clear_badblocks(struct ndctl_pfn *pfn)
 		return -ENXIO;
 
 	rc = ndctl_namespace_disable_safe(ndns);
-	if (rc) {
+	if (rc < 0) {
 		error("%s: unable to disable namespace: %s\n", devname,
 			strerror(-rc));
 		return rc;
@@ -1478,7 +1478,7 @@ static int raw_clear_badblocks(struct ndctl_namespace *ndns)
 		return -ENXIO;
 
 	rc = ndctl_namespace_disable_safe(ndns);
-	if (rc) {
+	if (rc < 0) {
 		error("%s: unable to disable namespace: %s\n", devname,
 			strerror(-rc));
 		return rc;
diff --git a/ndctl/region.c b/ndctl/region.c
index 3edb9b3..4552c4a 100644
--- a/ndctl/region.c
+++ b/ndctl/region.c
@@ -70,7 +70,7 @@ static int region_action(struct ndctl_region *region, enum device_action mode)
 	case ACTION_DISABLE:
 		ndctl_namespace_foreach(region, ndns) {
 			rc = ndctl_namespace_disable_safe(ndns);
-			if (rc)
+			if (rc < 0)
 				return rc;
 		}
 		rc = ndctl_region_disable_invalidate(region);
-- 
2.27.0.windows.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
