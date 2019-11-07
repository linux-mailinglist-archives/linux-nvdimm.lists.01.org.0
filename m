Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00330F2645
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 05:11:00 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 373A8100DC3FD;
	Wed,  6 Nov 2019 20:13:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D5627100DC3FC
	for <linux-nvdimm@lists.01.org>; Wed,  6 Nov 2019 20:13:27 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:10:58 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400";
   d="scan'208";a="206041086"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:10:57 -0800
Subject: [PATCH 01/16] libnvdimm: Move attribute groups to device type
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 06 Nov 2019 19:56:41 -0800
Message-ID: <157309900111.1582359.2445687530383470348.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: OOKPOHOB64WGAROJVEIE7BN336GD2KFL
X-Message-ID-Hash: OOKPOHOB64WGAROJVEIE7BN336GD2KFL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: peterz@infradead.org, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OOKPOHOB64WGAROJVEIE7BN336GD2KFL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Statically initialize the attribute groups for each libnvdimm
device_type. This is a preparation step for removing unnecessary exports
of attributes that can be included in the device_type by default.

Also take the opportunity to mark 'struct device_type' instances const.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/btt_devs.c       |   24 +++++++-------
 drivers/nvdimm/dax_devs.c       |   27 ++++++---------
 drivers/nvdimm/namespace_devs.c |   68 +++++++++++++++++++++------------------
 drivers/nvdimm/nd.h             |    2 +
 drivers/nvdimm/pfn_devs.c       |   28 ++++++++--------
 5 files changed, 73 insertions(+), 76 deletions(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 3508a79110c7..05feb97e11ce 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -25,17 +25,6 @@ static void nd_btt_release(struct device *dev)
 	kfree(nd_btt);
 }
 
-static struct device_type nd_btt_device_type = {
-	.name = "nd_btt",
-	.release = nd_btt_release,
-};
-
-bool is_nd_btt(struct device *dev)
-{
-	return dev->type == &nd_btt_device_type;
-}
-EXPORT_SYMBOL(is_nd_btt);
-
 struct nd_btt *to_nd_btt(struct device *dev)
 {
 	struct nd_btt *nd_btt = container_of(dev, struct nd_btt, dev);
@@ -178,6 +167,18 @@ static const struct attribute_group *nd_btt_attribute_groups[] = {
 	NULL,
 };
 
+static const struct device_type nd_btt_device_type = {
+	.name = "nd_btt",
+	.release = nd_btt_release,
+	.groups = nd_btt_attribute_groups,
+};
+
+bool is_nd_btt(struct device *dev)
+{
+	return dev->type == &nd_btt_device_type;
+}
+EXPORT_SYMBOL(is_nd_btt);
+
 static struct device *__nd_btt_create(struct nd_region *nd_region,
 		unsigned long lbasize, u8 *uuid,
 		struct nd_namespace_common *ndns)
@@ -204,7 +205,6 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 	dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
 	dev->parent = &nd_region->dev;
 	dev->type = &nd_btt_device_type;
-	dev->groups = nd_btt_attribute_groups;
 	device_initialize(&nd_btt->dev);
 	if (ndns && !__nd_attach_ndns(&nd_btt->dev, ndns, &nd_btt->ndns)) {
 		dev_dbg(&ndns->dev, "failed, already claimed by %s\n",
diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 6d22b0f83b3b..99965077bac4 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -23,17 +23,6 @@ static void nd_dax_release(struct device *dev)
 	kfree(nd_dax);
 }
 
-static struct device_type nd_dax_device_type = {
-	.name = "nd_dax",
-	.release = nd_dax_release,
-};
-
-bool is_nd_dax(struct device *dev)
-{
-	return dev ? dev->type == &nd_dax_device_type : false;
-}
-EXPORT_SYMBOL(is_nd_dax);
-
 struct nd_dax *to_nd_dax(struct device *dev)
 {
 	struct nd_dax *nd_dax = container_of(dev, struct nd_dax, nd_pfn.dev);
@@ -43,13 +32,18 @@ struct nd_dax *to_nd_dax(struct device *dev)
 }
 EXPORT_SYMBOL(to_nd_dax);
 
-static const struct attribute_group *nd_dax_attribute_groups[] = {
-	&nd_pfn_attribute_group,
-	&nd_device_attribute_group,
-	&nd_numa_attribute_group,
-	NULL,
+static const struct device_type nd_dax_device_type = {
+	.name = "nd_dax",
+	.release = nd_dax_release,
+	.groups = nd_pfn_attribute_groups,
 };
 
+bool is_nd_dax(struct device *dev)
+{
+	return dev ? dev->type == &nd_dax_device_type : false;
+}
+EXPORT_SYMBOL(is_nd_dax);
+
 static struct nd_dax *nd_dax_alloc(struct nd_region *nd_region)
 {
 	struct nd_pfn *nd_pfn;
@@ -69,7 +63,6 @@ static struct nd_dax *nd_dax_alloc(struct nd_region *nd_region)
 
 	dev = &nd_pfn->dev;
 	dev_set_name(dev, "dax%d.%d", nd_region->id, nd_pfn->id);
-	dev->groups = nd_dax_attribute_groups;
 	dev->type = &nd_dax_device_type;
 	dev->parent = &nd_region->dev;
 
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index cca0a3ba1d2c..37471a272c1a 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -44,35 +44,9 @@ static void namespace_blk_release(struct device *dev)
 	kfree(nsblk);
 }
 
-static const struct device_type namespace_io_device_type = {
-	.name = "nd_namespace_io",
-	.release = namespace_io_release,
-};
-
-static const struct device_type namespace_pmem_device_type = {
-	.name = "nd_namespace_pmem",
-	.release = namespace_pmem_release,
-};
-
-static const struct device_type namespace_blk_device_type = {
-	.name = "nd_namespace_blk",
-	.release = namespace_blk_release,
-};
-
-static bool is_namespace_pmem(const struct device *dev)
-{
-	return dev ? dev->type == &namespace_pmem_device_type : false;
-}
-
-static bool is_namespace_blk(const struct device *dev)
-{
-	return dev ? dev->type == &namespace_blk_device_type : false;
-}
-
-static bool is_namespace_io(const struct device *dev)
-{
-	return dev ? dev->type == &namespace_io_device_type : false;
-}
+static bool is_namespace_pmem(const struct device *dev);
+static bool is_namespace_blk(const struct device *dev);
+static bool is_namespace_io(const struct device *dev);
 
 static int is_uuid_busy(struct device *dev, void *data)
 {
@@ -1680,6 +1654,39 @@ static const struct attribute_group *nd_namespace_attribute_groups[] = {
 	NULL,
 };
 
+static const struct device_type namespace_io_device_type = {
+	.name = "nd_namespace_io",
+	.release = namespace_io_release,
+	.groups = nd_namespace_attribute_groups,
+};
+
+static const struct device_type namespace_pmem_device_type = {
+	.name = "nd_namespace_pmem",
+	.release = namespace_pmem_release,
+	.groups = nd_namespace_attribute_groups,
+};
+
+static const struct device_type namespace_blk_device_type = {
+	.name = "nd_namespace_blk",
+	.release = namespace_blk_release,
+	.groups = nd_namespace_attribute_groups,
+};
+
+static bool is_namespace_pmem(const struct device *dev)
+{
+	return dev ? dev->type == &namespace_pmem_device_type : false;
+}
+
+static bool is_namespace_blk(const struct device *dev)
+{
+	return dev ? dev->type == &namespace_blk_device_type : false;
+}
+
+static bool is_namespace_io(const struct device *dev)
+{
+	return dev ? dev->type == &namespace_io_device_type : false;
+}
+
 struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 {
 	struct nd_btt *nd_btt = is_nd_btt(dev) ? to_nd_btt(dev) : NULL;
@@ -2078,7 +2085,6 @@ static struct device *nd_namespace_blk_create(struct nd_region *nd_region)
 	}
 	dev_set_name(dev, "namespace%d.%d", nd_region->id, nsblk->id);
 	dev->parent = &nd_region->dev;
-	dev->groups = nd_namespace_attribute_groups;
 
 	return &nsblk->common.dev;
 }
@@ -2109,7 +2115,6 @@ static struct device *nd_namespace_pmem_create(struct nd_region *nd_region)
 		return NULL;
 	}
 	dev_set_name(dev, "namespace%d.%d", nd_region->id, nspm->id);
-	dev->groups = nd_namespace_attribute_groups;
 	nd_namespace_pmem_set_resource(nd_region, nspm, 0);
 
 	return dev;
@@ -2608,7 +2613,6 @@ int nd_region_register_namespaces(struct nd_region *nd_region, int *err)
 		if (id < 0)
 			break;
 		dev_set_name(dev, "namespace%d.%d", nd_region->id, id);
-		dev->groups = nd_namespace_attribute_groups;
 		nd_device_register(dev);
 	}
 	if (i)
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index ee5c04070ef9..5c8b077b3237 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -297,7 +297,7 @@ struct device *nd_pfn_create(struct nd_region *nd_region);
 struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
 		struct nd_namespace_common *ndns);
 int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig);
-extern struct attribute_group nd_pfn_attribute_group;
+extern const struct attribute_group *nd_pfn_attribute_groups[];
 #else
 static inline int nd_pfn_probe(struct device *dev,
 		struct nd_namespace_common *ndns)
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 60d81fae06ee..e809961e2b6f 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -26,17 +26,6 @@ static void nd_pfn_release(struct device *dev)
 	kfree(nd_pfn);
 }
 
-static struct device_type nd_pfn_device_type = {
-	.name = "nd_pfn",
-	.release = nd_pfn_release,
-};
-
-bool is_nd_pfn(struct device *dev)
-{
-	return dev ? dev->type == &nd_pfn_device_type : false;
-}
-EXPORT_SYMBOL(is_nd_pfn);
-
 struct nd_pfn *to_nd_pfn(struct device *dev)
 {
 	struct nd_pfn *nd_pfn = container_of(dev, struct nd_pfn, dev);
@@ -287,18 +276,30 @@ static umode_t pfn_visible(struct kobject *kobj, struct attribute *a, int n)
 	return a->mode;
 }
 
-struct attribute_group nd_pfn_attribute_group = {
+static struct attribute_group nd_pfn_attribute_group = {
 	.attrs = nd_pfn_attributes,
 	.is_visible = pfn_visible,
 };
 
-static const struct attribute_group *nd_pfn_attribute_groups[] = {
+const struct attribute_group *nd_pfn_attribute_groups[] = {
 	&nd_pfn_attribute_group,
 	&nd_device_attribute_group,
 	&nd_numa_attribute_group,
 	NULL,
 };
 
+static const struct device_type nd_pfn_device_type = {
+	.name = "nd_pfn",
+	.release = nd_pfn_release,
+	.groups = nd_pfn_attribute_groups,
+};
+
+bool is_nd_pfn(struct device *dev)
+{
+	return dev ? dev->type == &nd_pfn_device_type : false;
+}
+EXPORT_SYMBOL(is_nd_pfn);
+
 struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
 		struct nd_namespace_common *ndns)
 {
@@ -337,7 +338,6 @@ static struct nd_pfn *nd_pfn_alloc(struct nd_region *nd_region)
 
 	dev = &nd_pfn->dev;
 	dev_set_name(dev, "pfn%d.%d", nd_region->id, nd_pfn->id);
-	dev->groups = nd_pfn_attribute_groups;
 	dev->type = &nd_pfn_device_type;
 	dev->parent = &nd_region->dev;
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
