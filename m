Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EFB77C35
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:55:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8411212E46FA;
	Sat, 27 Jul 2019 14:58:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 95370212E259E
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:58:02 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:35 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="182272570"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:35 -0700
Subject: [ndctl PATCH v2 22/26] ndctl/namespace: Clarify 16M minimum size
 requirement
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:41:18 -0700
Message-ID: <156426367840.531577.5216422482939398348.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
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
index 69900c4e4e60..75ea366574f8 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -534,6 +534,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 	unsigned long long size_align, units = 1, resource;
 	struct ndctl_pfn *pfn = NULL;
 	struct ndctl_dax *dax = NULL;
+	bool default_size = false;
 	unsigned int ways;
 	int rc = 0;
 
@@ -548,10 +549,13 @@ static int validate_namespace_options(struct ndctl_region *region,
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
@@ -719,6 +723,21 @@ static int validate_namespace_options(struct ndctl_region *region,
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
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
