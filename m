Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D4177C24
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:54:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E476D212E2590;
	Sat, 27 Jul 2019 14:56:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B586A212E15BE
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:56:31 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:54:04 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="173436269"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:54:04 -0700
Subject: [ndctl PATCH v2 05/26] ndctl/test: Update dax-dev to handle
 multiple e820 ranges
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:39:47 -0700
Message-ID: <156426358717.531577.8906778081129951458.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Establish a convention that the first, lowest-index, region on the e820
bus always enables in fsdax mode without need for an nd_pfn instance.
This is in preparation for a defining a collision test that requires
multiple section-mis-aligned regions defined by memmap=nn!ss.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/dax-dev.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/test/dax-dev.c b/test/dax-dev.c
index 0183b7af2052..49ccaa334e31 100644
--- a/test/dax-dev.c
+++ b/test/dax-dev.c
@@ -33,17 +33,28 @@ struct ndctl_namespace *ndctl_get_test_dev(struct ndctl_ctx *ctx)
 	struct ndctl_bus *bus;
 	struct ndctl_dax *dax;
 	struct ndctl_pfn *pfn;
-	struct ndctl_region *region;
 	struct ndctl_namespace *ndns;
 	enum ndctl_namespace_mode mode;
+	struct ndctl_region *region, *min = NULL;
 
 	bus = ndctl_bus_get_by_provider(ctx, "e820");
 	if (!bus)
 		goto out;
 
-	region = ndctl_region_get_first(bus);
-	if (!region)
+	ndctl_region_foreach(bus, region) {
+		if (!min) {
+			min = region;
+			continue;
+		}
+		if (ndctl_region_get_id(region) < ndctl_region_get_id(min))
+			min = region;
+	}
+	if (!min)
 		goto out;
+	region = min;
+
+	/* attempt to re-enable the region if a previous test disabled it */
+	ndctl_region_enable(region);
 
 	ndns = ndctl_namespace_get_first(region);
 	if (!ndns)

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
