Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EE8174950
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:38:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40D3D10FC358E;
	Sat, 29 Feb 2020 12:39:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1CB9F10FC3581
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:38:58 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:06 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="232874111"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:05 -0800
Subject: [ndctl PATCH 22/36] ndctl/namespace: Clarify 16M minimum size
 requirement
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Jane Chu <jane.chu@oracle.com>, vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:22:00 -0800
Message-ID: <158300772061.2141307.11673421240647847117.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: GNJLEJT45Q5J5C5LRHYLVV3ZXLBWXODT
X-Message-ID-Hash: GNJLEJT45Q5J5C5LRHYLVV3ZXLBWXODT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GNJLEJT45Q5J5C5LRHYLVV3ZXLBWXODT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The kernel enforces a minimum size for any "claimed" namespace i.e. any
namespace that is wrapped in an address abstraction like the btt or
devdax. The "no such device or address" default print is confusing, so
replace with an explicit error message.

Reported-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 6786bbb2e096..397bd4acd1d1 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -560,6 +560,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 	struct ndctl_pfn *pfn = NULL;
 	struct ndctl_dax *dax = NULL;
 	unsigned long region_align;
+	bool default_size = false;
 	unsigned int ways;
 	int rc = 0;
 
@@ -574,10 +575,13 @@ static int validate_namespace_options(struct ndctl_region *region,
 		p->size = __parse_size64(param.size, &units);
 	else if (ndns)
 		p->size = ndctl_namespace_get_size(ndns);
+	else
+		default_size = true;
 
 	/*
 	 * Validate available capacity in the create case, in the
-	 * reconfigure case the capacity is already allocated.
+	 * reconfigure case the capacity is already allocated. A default
+	 * size will be established from available capacity.
 	 */
 	if (!ndns) {
 		rc = validate_available_capacity(region, p);
@@ -769,6 +773,21 @@ static int validate_namespace_options(struct ndctl_region *region,
 		return -EINVAL;
 	}
 
+	/*
+	 * Catch attempts to create sub-16M namespaces to match the
+	 * kernel's restriction (see nd_namespace_store())
+	 */
+	if (p->size < SZ_16M && p->mode != NDCTL_NS_MODE_RAW) {
+		if (default_size) {
+			debug("%s: insufficient capacity for mode: %s\n",
+					region_name, util_nsmode_name(p->mode));
+			return -EAGAIN;
+		}
+		error("'--size=' must be >= 16MiB for '%s' mode\n",
+				util_nsmode_name(p->mode));
+		return -EINVAL;
+	}
+
 	if (param.sector_size) {
 		struct ndctl_btt *btt;
 		int num, i;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
