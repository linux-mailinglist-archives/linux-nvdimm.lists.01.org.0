Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B24CFFB1A
	for <lists+linux-nvdimm@lfdr.de>; Sun, 17 Nov 2019 18:59:20 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C3690100DC3E3;
	Sun, 17 Nov 2019 10:00:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3F758100DC3E3
	for <linux-nvdimm@lists.01.org>; Sun, 17 Nov 2019 10:00:22 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:16 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400";
   d="scan'208";a="208629785"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:16 -0800
Subject: [PATCH v2 05/18] libnvdimm: Move nd_region_attribute_group to
 device_type
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 17 Nov 2019 09:45:00 -0800
Message-ID: <157401270052.43284.15637974636712508503.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: DP65RU3XOY6FGFAWUBU5KK3ISB34FBAZ
X-Message-ID-Hash: DP65RU3XOY6FGFAWUBU5KK3ISB34FBAZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DP65RU3XOY6FGFAWUBU5KK3ISB34FBAZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A 'struct device_type' instance can carry default attributes for the
device. Use this facility to remove the export of
nd_region_attribute_group and put the responsibility on the core rather
than leaf implementations to define this attribute.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157309902169.1582359.16828508538444551337.stgit@dwillia2-desk3.amr.corp.intel.com
---
 arch/powerpc/platforms/pseries/papr_scm.c |    1 -
 drivers/acpi/nfit/core.c                  |    1 -
 drivers/nvdimm/e820.c                     |    6 ------
 drivers/nvdimm/of_pmem.c                  |    6 ------
 drivers/nvdimm/region_devs.c              |    4 ++--
 include/linux/libnvdimm.h                 |    1 -
 6 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 6ffda03a6349..6428834d7cd5 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -285,7 +285,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 }
 
 static const struct attribute_group *region_attr_groups[] = {
-	&nd_region_attribute_group,
 	&nd_mapping_attribute_group,
 	NULL,
 };
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index b3213faf37b5..99e20b8b6ea0 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2196,7 +2196,6 @@ static const struct attribute_group acpi_nfit_region_attribute_group = {
 };
 
 static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
-	&nd_region_attribute_group,
 	&nd_mapping_attribute_group,
 	&acpi_nfit_region_attribute_group,
 	NULL,
diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index adde2864c6a4..9a971a59dec7 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -13,11 +13,6 @@ static const struct attribute_group *e820_pmem_attribute_groups[] = {
 	NULL,
 };
 
-static const struct attribute_group *e820_pmem_region_attribute_groups[] = {
-	&nd_region_attribute_group,
-	NULL,
-};
-
 static int e820_pmem_remove(struct platform_device *pdev)
 {
 	struct nvdimm_bus *nvdimm_bus = platform_get_drvdata(pdev);
@@ -45,7 +40,6 @@ static int e820_register_one(struct resource *res, void *data)
 
 	memset(&ndr_desc, 0, sizeof(ndr_desc));
 	ndr_desc.res = res;
-	ndr_desc.attr_groups = e820_pmem_region_attribute_groups;
 	ndr_desc.numa_node = e820_range_to_nid(res->start);
 	ndr_desc.target_node = ndr_desc.numa_node;
 	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 41348fa6b74c..c0b5ac36df9d 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -9,11 +9,6 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 
-static const struct attribute_group *region_attr_groups[] = {
-	&nd_region_attribute_group,
-	NULL,
-};
-
 static const struct attribute_group *bus_attr_groups[] = {
 	&nvdimm_bus_attribute_group,
 	NULL,
@@ -65,7 +60,6 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 		 * structures so passing a stack pointer is fine.
 		 */
 		memset(&ndr_desc, 0, sizeof(ndr_desc));
-		ndr_desc.attr_groups = region_attr_groups;
 		ndr_desc.numa_node = dev_to_node(&pdev->dev);
 		ndr_desc.target_node = ndr_desc.numa_node;
 		ndr_desc.res = &pdev->resource[i];
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index e4281f806adc..f97166583294 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -757,14 +757,14 @@ struct attribute_group nd_mapping_attribute_group = {
 };
 EXPORT_SYMBOL_GPL(nd_mapping_attribute_group);
 
-struct attribute_group nd_region_attribute_group = {
+static const struct attribute_group nd_region_attribute_group = {
 	.attrs = nd_region_attributes,
 	.is_visible = region_visible,
 };
-EXPORT_SYMBOL_GPL(nd_region_attribute_group);
 
 static const struct attribute_group *nd_region_attribute_groups[] = {
 	&nd_device_attribute_group,
+	&nd_region_attribute_group,
 	&nd_numa_attribute_group,
 	NULL,
 };
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index e9a4e25fc708..312248d334c7 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -67,7 +67,6 @@ enum {
 
 extern struct attribute_group nvdimm_bus_attribute_group;
 extern struct attribute_group nvdimm_attribute_group;
-extern struct attribute_group nd_region_attribute_group;
 extern struct attribute_group nd_mapping_attribute_group;
 
 struct nvdimm;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
