Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484C77C34
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:55:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 91D21212E46F8;
	Sat, 27 Jul 2019 14:57:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 93C92212E259E
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:57:57 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:30 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="173436463"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:30 -0700
Subject: [ndctl PATCH v2 21/26] ndctl/namespace: Validate namespace size
 within validate_namespace_options()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:41:13 -0700
Message-ID: <156426367330.531577.13173216611909512565.stgit@dwillia2-desk3.amr.corp.intel.com>
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
index 43a5fccac491..69900c4e4e60 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -489,6 +489,29 @@ static int is_namespace_active(struct ndctl_namespace *ndns)
 		|| ndctl_namespace_get_btt(ndns));
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
@@ -526,6 +549,16 @@ static int validate_namespace_options(struct ndctl_region *region,
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
 			debug("%s: invalid uuid\n", __func__);
@@ -797,7 +830,6 @@ static struct ndctl_namespace *region_get_namespace(struct ndctl_region *region)
 static int namespace_create(struct ndctl_region *region)
 {
 	const char *devname = ndctl_region_get_devname(region);
-	unsigned long long available;
 	struct ndctl_namespace *ndns;
 	struct parsed_parameters p;
 	int rc;
@@ -812,22 +844,6 @@ static int namespace_create(struct ndctl_region *region)
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
 	if (!ndns || is_namespace_active(ndns)) {
 		debug("%s: no %s namespace seed\n", devname,

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
