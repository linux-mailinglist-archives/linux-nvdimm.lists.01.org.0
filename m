Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6650EF02D
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Nov 2019 23:26:27 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2ED5100EA545;
	Mon,  4 Nov 2019 14:29:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3672B100EA542
	for <linux-nvdimm@lists.01.org>; Mon,  4 Nov 2019 14:29:11 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 14:26:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400";
   d="scan'208";a="232234577"
Received: from vverma7-desk1.amr.corp.intel.com (HELO vverma7-desk1.lm.intel.com) ([10.232.112.164])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2019 14:26:22 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v4 1/2] ndctl/namespace: remove open coded is_namespace_active()
Date: Mon,  4 Nov 2019 15:26:17 -0700
Message-Id: <20191104222618.20692-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Message-ID-Hash: L4VFP26P3U7KZT5DFENV7BO2WVLA64QY
X-Message-ID-Hash: L4VFP26P3U7KZT5DFENV7BO2WVLA64QY
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L4VFP26P3U7KZT5DFENV7BO2WVLA64QY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Replace the open coded namespace active check with the one provided by
libndctl - ndctl_namespace_is_active().

is_namespace_active() additionally checked for a non-NULL 'ndns', which
the libndctl API doesn't do. However, all the callers either performed
that check themselves, or made prior assumptions about ndns being valid
by dereferencing it earlier.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/namespace.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 7fb0007..8d1044a 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -453,14 +453,6 @@ static int setup_namespace(struct ndctl_region *region,
 	return rc;
 }
 
-static int is_namespace_active(struct ndctl_namespace *ndns)
-{
-	return ndns && (ndctl_namespace_is_enabled(ndns)
-		|| ndctl_namespace_get_pfn(ndns)
-		|| ndctl_namespace_get_dax(ndns)
-		|| ndctl_namespace_get_btt(ndns));
-}
-
 /*
  * validate_namespace_options - init parameters for setup_namespace
  * @region: parent of the namespace to create / reconfigure
@@ -787,7 +779,7 @@ static struct ndctl_namespace *region_get_namespace(struct ndctl_region *region)
 	/* prefer the 0th namespace if it is idle */
 	ndctl_namespace_foreach(region, ndns)
 		if (ndctl_namespace_get_id(ndns) == 0
-				&& !is_namespace_active(ndns))
+				&& !ndctl_namespace_is_active(ndns))
 			return ndns;
 	return ndctl_region_get_namespace_seed(region);
 }
@@ -827,7 +819,7 @@ static int namespace_create(struct ndctl_region *region)
 		p.size = available;
 
 	ndns = region_get_namespace(region);
-	if (!ndns || is_namespace_active(ndns)) {
+	if (!ndns || ndctl_namespace_is_active(ndns)) {
 		debug("%s: no %s namespace seed\n", devname,
 				ndns ? "idle" : "available");
 		return -EAGAIN;
@@ -1074,7 +1066,7 @@ static int namespace_reconfig(struct ndctl_region *region,
 	}
 
 	ndns = region_get_namespace(region);
-	if (!ndns || is_namespace_active(ndns)) {
+	if (!ndns || ndctl_namespace_is_active(ndns)) {
 		debug("%s: no %s namespace seed\n",
 				ndctl_region_get_devname(region),
 				ndns ? "idle" : "available");
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
