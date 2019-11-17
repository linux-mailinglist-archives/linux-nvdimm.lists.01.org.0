Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8926FFFB27
	for <lists+linux-nvdimm@lfdr.de>; Sun, 17 Nov 2019 18:59:42 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 304C5100DC3EF;
	Sun, 17 Nov 2019 10:00:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 00BD0100DC3F0
	for <linux-nvdimm@lists.01.org>; Sun, 17 Nov 2019 10:00:43 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:38 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400";
   d="scan'208";a="204001957"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:38 -0800
Subject: [PATCH v2 09/18] dax: Create a dax device_type
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 17 Nov 2019 09:45:22 -0800
Message-ID: <157401272218.43284.1616508957994921177.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 7RBKS6GSABV5Y3LBC6SLGXTRLOAIPPNB
X-Message-ID-Hash: 7RBKS6GSABV5Y3LBC6SLGXTRLOAIPPNB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7RBKS6GSABV5Y3LBC6SLGXTRLOAIPPNB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Move the open coded release method and attribute groups to a 'struct
device_type' instance.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157309904365.1582359.5451327195246651379.stgit@dwillia2-desk3.amr.corp.intel.com
---
 drivers/dax/bus.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 8fafbeab510a..f3e6e00ece40 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -373,6 +373,11 @@ static void dev_dax_release(struct device *dev)
 	kfree(dev_dax);
 }
 
+static const struct device_type dev_dax_type = {
+	.release = dev_dax_release,
+	.groups = dax_attribute_groups,
+};
+
 static void unregister_dev_dax(void *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
@@ -430,8 +435,7 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
 	else
 		dev->class = dax_class;
 	dev->parent = parent;
-	dev->groups = dax_attribute_groups;
-	dev->release = dev_dax_release;
+	dev->type = &dev_dax_type;
 	dev_set_name(dev, "dax%d.%d", dax_region->id, id);
 
 	rc = device_add(dev);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
