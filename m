Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC74C17494F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:38:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D24A10FC3581;
	Sat, 29 Feb 2020 12:38:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4208710FC36E9
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:38:52 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:00 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="318461735"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:00 -0800
Subject: [ndctl PATCH 21/36] ndctl/namespace: Validate namespace size within
 validate_namespace_options()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:21:55 -0800
Message-ID: <158300771550.2141307.12922490826715458569.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 5A6D6CGREG3N6XZWGCRT2TRLF7YZ3WOY
X-Message-ID-Hash: 5A6D6CGREG3N6XZWGCRT2TRLF7YZ3WOY
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5A6D6CGREG3N6XZWGCRT2TRLF7YZ3WOY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently validate_namespace_options() handles default option conversion
for every namespace attribute except size. Move default size validation
internal to that helper in advance of teaching ndctl to require
namespace be at least 16M in size to host a metadata personality /
address abstraction.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 1747a061d5b7..6786bbb2e096 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -514,6 +514,29 @@ static int setup_namespace(struct ndctl_region *region,
 	return rc;
 }
 
+static int validate_available_capacity(struct ndctl_region *region,
+		struct parsed_parameters *p)
+{
+	unsigned long long available;
+
+	if (ndctl_region_get_nstype(region) == ND_DEVICE_NAMESPACE_IO)
+		available = ndctl_region_get_size(region);
+	else {
+		available = ndctl_region_get_max_available_extent(region);
+		if (available == ULLONG_MAX)
+			available = ndctl_region_get_available_size(region);
+	}
+	if (!available || p->size > available) {
+		debug("%s: insufficient capacity size: %llx avail: %llx\n",
+			ndctl_region_get_devname(region), p->size, available);
+		return -EAGAIN;
+	}
+
+	if (p->size == 0)
+		p->size = available;
+	return 0;
+}
+
 /*
  * validate_namespace_options - init parameters for setup_namespace
  * @region: parent of the namespace to create / reconfigure
@@ -552,6 +575,16 @@ static int validate_namespace_options(struct ndctl_region *region,
 	else if (ndns)
 		p->size = ndctl_namespace_get_size(ndns);
 
+	/*
+	 * Validate available capacity in the create case, in the
+	 * reconfigure case the capacity is already allocated.
+	 */
+	if (!ndns) {
+		rc = validate_available_capacity(region, p);
+		if (rc)
+			return rc;
+	}
+
 	if (param.uuid) {
 		if (uuid_parse(param.uuid, p->uuid) != 0) {
 			err("%s: invalid uuid\n", __func__);
@@ -847,7 +880,6 @@ static struct ndctl_namespace *region_get_namespace(struct ndctl_region *region)
 static int namespace_create(struct ndctl_region *region)
 {
 	const char *devname = ndctl_region_get_devname(region);
-	unsigned long long available;
 	struct ndctl_namespace *ndns;
 	struct parsed_parameters p;
 	int rc;
@@ -862,22 +894,6 @@ static int namespace_create(struct ndctl_region *region)
 		return -EAGAIN;
 	}
 
-	if (ndctl_region_get_nstype(region) == ND_DEVICE_NAMESPACE_IO)
-		available = ndctl_region_get_size(region);
-	else {
-		available = ndctl_region_get_max_available_extent(region);
-		if (available == ULLONG_MAX)
-			available = ndctl_region_get_available_size(region);
-	}
-	if (!available || p.size > available) {
-		debug("%s: insufficient capacity size: %llx avail: %llx\n",
-			devname, p.size, available);
-		return -EAGAIN;
-	}
-
-	if (p.size == 0)
-		p.size = available;
-
 	ndns = region_get_namespace(region);
 	if (!ndns || !ndctl_namespace_is_configuration_idle(ndns)) {
 		debug("%s: no %s namespace seed\n", devname,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
