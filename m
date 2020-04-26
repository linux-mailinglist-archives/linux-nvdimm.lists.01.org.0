Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7B01B8E97
	for <lists+linux-nvdimm@lfdr.de>; Sun, 26 Apr 2020 11:53:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94A4810113FDE;
	Sun, 26 Apr 2020 02:52:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7B5141010633E
	for <linux-nvdimm@lists.01.org>; Sun, 26 Apr 2020 02:52:29 -0700 (PDT)
IronPort-SDR: jq6X72wRSjqUkROMcN6+Gyasvf9XyZy4h9wIWdcBfFoddEzGRPUGrUYPlV15ShJYumt/vxzXKI
 LwTPwuMBoxCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2020 02:53:11 -0700
IronPort-SDR: Qi8tUW/UaN/V0kM+3tL+HgbCCp5DmxMl3lthV78cgotuf4M36PrYBzyiFbdRwhjNys+EazPj5C
 RkFQQZip9hOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,319,1583222400";
   d="scan'208";a="245795262"
Received: from redhaire-mobl1.gar.corp.intel.com ([10.213.149.250])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2020 02:53:09 -0700
From: Redhairer Li <redhairer.li@intel.com>
To: linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com
Subject: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting relative to seed devices
Date: Sun, 26 Apr 2020 17:52:32 +0800
Message-Id: <20200426095232.27524-1-redhairer.li@intel.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Message-ID-Hash: PKZPQ3YQH4223CJAA7KWJMB2QM7HSWTL
X-Message-ID-Hash: PKZPQ3YQH4223CJAA7KWJMB2QM7HSWTL
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Redhairer Li <redhairer.li@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PKZPQ3YQH4223CJAA7KWJMB2QM7HSWTL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
 ndctl/region.c       |  4 +++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index ee737cb..49f362b 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -4231,6 +4231,7 @@ NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
 	const char *bdev = NULL;
 	char path[50];
 	int fd;
+	unsigned long long size = ndctl_namespace_get_size(ndns);
 
 	if (pfn && ndctl_pfn_is_enabled(pfn))
 		bdev = ndctl_pfn_get_block_device(pfn);
@@ -4260,9 +4261,13 @@ NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
 					devname, bdev, strerror(errno));
 			return -errno;
 		}
-	} else
-		ndctl_namespace_disable_invalidate(ndns);
-
+	} else {
+		if (size == 0)
+			/* Don't try to disable idle namespace (no capacity allocated) */
+			return -ENXIO;
+		else
+			ndctl_namespace_disable_invalidate(ndns);
+	}
 	return 0;
 }
 
diff --git a/ndctl/region.c b/ndctl/region.c
index 7945007..0014bb9 100644
--- a/ndctl/region.c
+++ b/ndctl/region.c
@@ -72,6 +72,7 @@ static int region_action(struct ndctl_region *region, enum device_action mode)
 {
 	struct ndctl_namespace *ndns;
 	int rc = 0;
+	unsigned long long size;
 
 	switch (mode) {
 	case ACTION_ENABLE:
@@ -80,7 +81,8 @@ static int region_action(struct ndctl_region *region, enum device_action mode)
 	case ACTION_DISABLE:
 		ndctl_namespace_foreach(region, ndns) {
 			rc = ndctl_namespace_disable_safe(ndns);
-			if (rc)
+			size = ndctl_namespace_get_size(ndns);
+			if (rc && size != 0)
 				return rc;
 		}
 		rc = ndctl_region_disable_invalidate(region);
-- 
2.20.1.windows.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
