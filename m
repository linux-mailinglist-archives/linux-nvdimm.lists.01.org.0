Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DECF2646
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 05:11:06 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DDE4100DC3FF;
	Wed,  6 Nov 2019 20:13:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E0FC4100DC2A4
	for <linux-nvdimm@lists.01.org>; Wed,  6 Nov 2019 20:13:32 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:02 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400";
   d="scan'208";a="377299261"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:02 -0800
Subject: [PATCH 02/16] libnvdimm: Move region attribute group definition
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 06 Nov 2019 19:56:46 -0800
Message-ID: <157309900624.1582359.6929998072035982264.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: JXLNFVH27LMBPRO475GYYFJTQZCAYYUE
X-Message-ID-Hash: JXLNFVH27LMBPRO475GYYFJTQZCAYYUE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: peterz@infradead.org, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JXLNFVH27LMBPRO475GYYFJTQZCAYYUE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for moving region attributes from device attribute groups
to the region device-type, reorder the declaration so that it can be
referenced by the device-type definition without forward declarations.
No functional changes are intended to result from this change.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/region_devs.c |  208 +++++++++++++++++++++---------------------
 1 file changed, 104 insertions(+), 104 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef423ba1a711..e89f2eb3678c 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -140,36 +140,6 @@ static void nd_region_release(struct device *dev)
 		kfree(nd_region);
 }
 
-static struct device_type nd_blk_device_type = {
-	.name = "nd_blk",
-	.release = nd_region_release,
-};
-
-static struct device_type nd_pmem_device_type = {
-	.name = "nd_pmem",
-	.release = nd_region_release,
-};
-
-static struct device_type nd_volatile_device_type = {
-	.name = "nd_volatile",
-	.release = nd_region_release,
-};
-
-bool is_nd_pmem(struct device *dev)
-{
-	return dev ? dev->type == &nd_pmem_device_type : false;
-}
-
-bool is_nd_blk(struct device *dev)
-{
-	return dev ? dev->type == &nd_blk_device_type : false;
-}
-
-bool is_nd_volatile(struct device *dev)
-{
-	return dev ? dev->type == &nd_volatile_device_type : false;
-}
-
 struct nd_region *to_nd_region(struct device *dev)
 {
 	struct nd_region *nd_region = container_of(dev, struct nd_region, dev);
@@ -674,80 +644,6 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 	return 0;
 }
 
-struct attribute_group nd_region_attribute_group = {
-	.attrs = nd_region_attributes,
-	.is_visible = region_visible,
-};
-EXPORT_SYMBOL_GPL(nd_region_attribute_group);
-
-u64 nd_region_interleave_set_cookie(struct nd_region *nd_region,
-		struct nd_namespace_index *nsindex)
-{
-	struct nd_interleave_set *nd_set = nd_region->nd_set;
-
-	if (!nd_set)
-		return 0;
-
-	if (nsindex && __le16_to_cpu(nsindex->major) == 1
-			&& __le16_to_cpu(nsindex->minor) == 1)
-		return nd_set->cookie1;
-	return nd_set->cookie2;
-}
-
-u64 nd_region_interleave_set_altcookie(struct nd_region *nd_region)
-{
-	struct nd_interleave_set *nd_set = nd_region->nd_set;
-
-	if (nd_set)
-		return nd_set->altcookie;
-	return 0;
-}
-
-void nd_mapping_free_labels(struct nd_mapping *nd_mapping)
-{
-	struct nd_label_ent *label_ent, *e;
-
-	lockdep_assert_held(&nd_mapping->lock);
-	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
-		list_del(&label_ent->list);
-		kfree(label_ent);
-	}
-}
-
-/*
- * When a namespace is activated create new seeds for the next
- * namespace, or namespace-personality to be configured.
- */
-void nd_region_advance_seeds(struct nd_region *nd_region, struct device *dev)
-{
-	nvdimm_bus_lock(dev);
-	if (nd_region->ns_seed == dev) {
-		nd_region_create_ns_seed(nd_region);
-	} else if (is_nd_btt(dev)) {
-		struct nd_btt *nd_btt = to_nd_btt(dev);
-
-		if (nd_region->btt_seed == dev)
-			nd_region_create_btt_seed(nd_region);
-		if (nd_region->ns_seed == &nd_btt->ndns->dev)
-			nd_region_create_ns_seed(nd_region);
-	} else if (is_nd_pfn(dev)) {
-		struct nd_pfn *nd_pfn = to_nd_pfn(dev);
-
-		if (nd_region->pfn_seed == dev)
-			nd_region_create_pfn_seed(nd_region);
-		if (nd_region->ns_seed == &nd_pfn->ndns->dev)
-			nd_region_create_ns_seed(nd_region);
-	} else if (is_nd_dax(dev)) {
-		struct nd_dax *nd_dax = to_nd_dax(dev);
-
-		if (nd_region->dax_seed == dev)
-			nd_region_create_dax_seed(nd_region);
-		if (nd_region->ns_seed == &nd_dax->nd_pfn.ndns->dev)
-			nd_region_create_ns_seed(nd_region);
-	}
-	nvdimm_bus_unlock(dev);
-}
-
 static ssize_t mappingN(struct device *dev, char *buf, int n)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
@@ -861,6 +757,110 @@ struct attribute_group nd_mapping_attribute_group = {
 };
 EXPORT_SYMBOL_GPL(nd_mapping_attribute_group);
 
+struct attribute_group nd_region_attribute_group = {
+	.attrs = nd_region_attributes,
+	.is_visible = region_visible,
+};
+EXPORT_SYMBOL_GPL(nd_region_attribute_group);
+
+static struct device_type nd_blk_device_type = {
+	.name = "nd_blk",
+	.release = nd_region_release,
+};
+
+static struct device_type nd_pmem_device_type = {
+	.name = "nd_pmem",
+	.release = nd_region_release,
+};
+
+static struct device_type nd_volatile_device_type = {
+	.name = "nd_volatile",
+	.release = nd_region_release,
+};
+
+bool is_nd_pmem(struct device *dev)
+{
+	return dev ? dev->type == &nd_pmem_device_type : false;
+}
+
+bool is_nd_blk(struct device *dev)
+{
+	return dev ? dev->type == &nd_blk_device_type : false;
+}
+
+bool is_nd_volatile(struct device *dev)
+{
+	return dev ? dev->type == &nd_volatile_device_type : false;
+}
+
+u64 nd_region_interleave_set_cookie(struct nd_region *nd_region,
+		struct nd_namespace_index *nsindex)
+{
+	struct nd_interleave_set *nd_set = nd_region->nd_set;
+
+	if (!nd_set)
+		return 0;
+
+	if (nsindex && __le16_to_cpu(nsindex->major) == 1
+			&& __le16_to_cpu(nsindex->minor) == 1)
+		return nd_set->cookie1;
+	return nd_set->cookie2;
+}
+
+u64 nd_region_interleave_set_altcookie(struct nd_region *nd_region)
+{
+	struct nd_interleave_set *nd_set = nd_region->nd_set;
+
+	if (nd_set)
+		return nd_set->altcookie;
+	return 0;
+}
+
+void nd_mapping_free_labels(struct nd_mapping *nd_mapping)
+{
+	struct nd_label_ent *label_ent, *e;
+
+	lockdep_assert_held(&nd_mapping->lock);
+	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
+		list_del(&label_ent->list);
+		kfree(label_ent);
+	}
+}
+
+/*
+ * When a namespace is activated create new seeds for the next
+ * namespace, or namespace-personality to be configured.
+ */
+void nd_region_advance_seeds(struct nd_region *nd_region, struct device *dev)
+{
+	nvdimm_bus_lock(dev);
+	if (nd_region->ns_seed == dev) {
+		nd_region_create_ns_seed(nd_region);
+	} else if (is_nd_btt(dev)) {
+		struct nd_btt *nd_btt = to_nd_btt(dev);
+
+		if (nd_region->btt_seed == dev)
+			nd_region_create_btt_seed(nd_region);
+		if (nd_region->ns_seed == &nd_btt->ndns->dev)
+			nd_region_create_ns_seed(nd_region);
+	} else if (is_nd_pfn(dev)) {
+		struct nd_pfn *nd_pfn = to_nd_pfn(dev);
+
+		if (nd_region->pfn_seed == dev)
+			nd_region_create_pfn_seed(nd_region);
+		if (nd_region->ns_seed == &nd_pfn->ndns->dev)
+			nd_region_create_ns_seed(nd_region);
+	} else if (is_nd_dax(dev)) {
+		struct nd_dax *nd_dax = to_nd_dax(dev);
+
+		if (nd_region->dax_seed == dev)
+			nd_region_create_dax_seed(nd_region);
+		if (nd_region->ns_seed == &nd_dax->nd_pfn.ndns->dev)
+			nd_region_create_ns_seed(nd_region);
+	}
+	nvdimm_bus_unlock(dev);
+}
+
 int nd_blk_region_init(struct nd_region *nd_region)
 {
 	struct device *dev = &nd_region->dev;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
