Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8ED174945
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:37:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BBAF10FC3582;
	Sat, 29 Feb 2020 12:38:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A1BA810FC3581
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:38:11 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:19 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="273073885"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:19 -0800
Subject: [ndctl PATCH 13/36] ndctl/test: Update dax-dev to handle multiple
 e820 ranges
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:21:13 -0800
Message-ID: <158300767374.2141307.707811872453358886.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: FK4K632L6WW5IEY45Q3PH3XO7URYV2MN
X-Message-ID-Hash: FK4K632L6WW5IEY45Q3PH3XO7URYV2MN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FK4K632L6WW5IEY45Q3PH3XO7URYV2MN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
