Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4918C2F813B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 15 Jan 2021 17:51:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F169100F2271;
	Fri, 15 Jan 2021 08:51:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 86488100EB343
	for <linux-nvdimm@lists.01.org>; Fri, 15 Jan 2021 08:51:37 -0800 (PST)
IronPort-SDR: VhaRi3/KbmMs7firXyaEkLibN7H2f3hqo28Xf4b6NIdeR9sF5oJ3xUiYL2dY6h+W6xfKylLtU6
 uKFzKE4oXAgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="166243989"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400";
   d="scan'208";a="166243989"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 08:51:36 -0800
IronPort-SDR: Ef/9Pk7OR2f9mXp1fa8kD4kWsAg6o+QD/jVVNHNYplZyToYKtdSGXgV4z6OHjo1u9bxoHJ+OGS
 HGNIfhdZN/Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400";
   d="scan'208";a="568522887"
Received: from unknown (HELO localhost.itwn.intel.com) ([10.5.251.103])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2021 08:51:35 -0800
From: redhairer <redhairer.li@intel.com>
To: linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com
Subject: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting relative to seed devices
Date: Fri, 15 Jan 2021 22:50:32 +0800
Message-Id: <20210115145032.11147-1-redhairer.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAPcyv4gupvktDG2PdCL6SyO4gwC1WoP8PKmPv1gP6pp8i10esQ@mail.gmail.com>
References: <CAPcyv4gupvktDG2PdCL6SyO4gwC1WoP8PKmPv1gP6pp8i10esQ@mail.gmail.com>
MIME-Version: 1.0
Message-ID-Hash: CSUPPVJJC3OXSNF22PBMG2MH6ZDPDQJ6
X-Message-ID-Hash: CSUPPVJJC3OXSNF22PBMG2MH6ZDPDQJ6
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Redhairer Li <redhairer.li@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CSUPPVJJC3OXSNF22PBMG2MH6ZDPDQJ6/>
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
 ndctl/lib/libndctl.c | 11 ++++++++---
 ndctl/namespace.c    |  8 ++++----
 ndctl/region.c       |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 5546963..b477098 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -4614,6 +4614,7 @@ NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
 	const char *bdev = NULL;
 	char path[50];
 	int fd;
+	unsigned long long size = ndctl_namespace_get_size(ndns);
 
 	if (pfn && ndctl_pfn_is_enabled(pfn))
 		bdev = ndctl_pfn_get_block_device(pfn);
@@ -4643,9 +4644,13 @@ NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
 					devname, bdev, strerror(errno));
 			return -errno;
 		}
-	} else
-		ndctl_namespace_disable_invalidate(ndns);
-
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
index e734248..77a75b4 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1110,7 +1110,7 @@ static int namespace_destroy(struct ndctl_region *region,
 		return -EBUSY;
 	} else {
 		rc = ndctl_namespace_disable_safe(ndns);
-		if (rc)
+		if (rc < 0)
 			return rc;
 	}
 
@@ -1395,7 +1395,7 @@ static int dax_clear_badblocks(struct ndctl_dax *dax)
 		return -ENXIO;
 
 	rc = ndctl_namespace_disable_safe(ndns);
-	if (rc) {
+	if (rc < 0) {
 		error("%s: unable to disable namespace: %s\n", devname,
 			strerror(-rc));
 		return rc;
@@ -1419,7 +1419,7 @@ static int pfn_clear_badblocks(struct ndctl_pfn *pfn)
 		return -ENXIO;
 
 	rc = ndctl_namespace_disable_safe(ndns);
-	if (rc) {
+	if (rc < 0) {
 		error("%s: unable to disable namespace: %s\n", devname,
 			strerror(-rc));
 		return rc;
@@ -1442,7 +1442,7 @@ static int raw_clear_badblocks(struct ndctl_namespace *ndns)
 		return -ENXIO;
 
 	rc = ndctl_namespace_disable_safe(ndns);
-	if (rc) {
+	if (rc < 0) {
 		error("%s: unable to disable namespace: %s\n", devname,
 			strerror(-rc));
 		return rc;
diff --git a/ndctl/region.c b/ndctl/region.c
index 7945007..df64fc9 100644
--- a/ndctl/region.c
+++ b/ndctl/region.c
@@ -80,7 +80,7 @@ static int region_action(struct ndctl_region *region, enum device_action mode)
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
