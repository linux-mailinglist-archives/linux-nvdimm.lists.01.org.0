Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A190F2647
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 05:11:12 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60E05100DC2A5;
	Wed,  6 Nov 2019 20:13:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 87B40100DC2A5
	for <linux-nvdimm@lists.01.org>; Wed,  6 Nov 2019 20:13:38 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:08 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400";
   d="scan'208";a="353684989"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:08 -0800
Subject: [PATCH 03/16] libnvdimm: Move nd_device_attribute_group to
 device_type
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 06 Nov 2019 19:56:51 -0800
Message-ID: <157309901138.1582359.12909354140826530394.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: CKM26OUKAHC35KOAFUSR2OCAXWF2SKM3
X-Message-ID-Hash: CKM26OUKAHC35KOAFUSR2OCAXWF2SKM3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CKM26OUKAHC35KOAFUSR2OCAXWF2SKM3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A 'struct device_type' instance can carry default attributes for the
device. Use this facility to remove the export of
nd_device_attribute_group and put the responsibility on the core rather
than leaf implementations to define this attribute.

For regions this creates a new nd_region_attribute_groups[] added to the
per-region device-type instances.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c |    2 --
 drivers/acpi/nfit/core.c                  |    2 --
 drivers/nvdimm/bus.c                      |    3 +--
 drivers/nvdimm/dimm_devs.c                |    8 +++++++-
 drivers/nvdimm/e820.c                     |    1 -
 drivers/nvdimm/nd.h                       |    1 +
 drivers/nvdimm/of_pmem.c                  |    1 -
 drivers/nvdimm/region_devs.c              |   18 +++++++++++++-----
 include/linux/libnvdimm.h                 |    1 -
 9 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 61883291defc..04726f8fd189 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -286,7 +286,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 
 static const struct attribute_group *region_attr_groups[] = {
 	&nd_region_attribute_group,
-	&nd_device_attribute_group,
 	&nd_mapping_attribute_group,
 	&nd_numa_attribute_group,
 	NULL,
@@ -299,7 +298,6 @@ static const struct attribute_group *bus_attr_groups[] = {
 
 static const struct attribute_group *papr_scm_dimm_groups[] = {
 	&nvdimm_attribute_group,
-	&nd_device_attribute_group,
 	NULL,
 };
 
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 14e68f202f81..dec7c2b08672 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1699,7 +1699,6 @@ static const struct attribute_group acpi_nfit_dimm_attribute_group = {
 
 static const struct attribute_group *acpi_nfit_dimm_attribute_groups[] = {
 	&nvdimm_attribute_group,
-	&nd_device_attribute_group,
 	&acpi_nfit_dimm_attribute_group,
 	NULL,
 };
@@ -2199,7 +2198,6 @@ static const struct attribute_group acpi_nfit_region_attribute_group = {
 static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
 	&nd_region_attribute_group,
 	&nd_mapping_attribute_group,
-	&nd_device_attribute_group,
 	&nd_numa_attribute_group,
 	&acpi_nfit_region_attribute_group,
 	NULL,
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index d47412dcdf38..eb422527dd57 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -669,10 +669,9 @@ static struct attribute *nd_device_attributes[] = {
 /*
  * nd_device_attribute_group - generic attributes for all devices on an nd bus
  */
-struct attribute_group nd_device_attribute_group = {
+const struct attribute_group nd_device_attribute_group = {
 	.attrs = nd_device_attributes,
 };
-EXPORT_SYMBOL_GPL(nd_device_attribute_group);
 
 static ssize_t numa_node_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 196aa44c4936..278867c68682 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -202,9 +202,15 @@ static void nvdimm_release(struct device *dev)
 	kfree(nvdimm);
 }
 
-static struct device_type nvdimm_device_type = {
+static const struct attribute_group *nvdimm_attribute_groups[] = {
+	&nd_device_attribute_group,
+	NULL,
+};
+
+static const struct device_type nvdimm_device_type = {
 	.name = "nvdimm",
 	.release = nvdimm_release,
+	.groups = nvdimm_attribute_groups,
 };
 
 bool is_nvdimm(struct device *dev)
diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index 87f72f725e4f..adde2864c6a4 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -15,7 +15,6 @@ static const struct attribute_group *e820_pmem_attribute_groups[] = {
 
 static const struct attribute_group *e820_pmem_region_attribute_groups[] = {
 	&nd_region_attribute_group,
-	&nd_device_attribute_group,
 	NULL,
 };
 
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 5c8b077b3237..3f509bb6b5c0 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -298,6 +298,7 @@ struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
 		struct nd_namespace_common *ndns);
 int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig);
 extern const struct attribute_group *nd_pfn_attribute_groups[];
+extern const struct attribute_group nd_device_attribute_group;
 #else
 static inline int nd_pfn_probe(struct device *dev,
 		struct nd_namespace_common *ndns)
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 97187d6c0bdb..41348fa6b74c 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -11,7 +11,6 @@
 
 static const struct attribute_group *region_attr_groups[] = {
 	&nd_region_attribute_group,
-	&nd_device_attribute_group,
 	NULL,
 };
 
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index e89f2eb3678c..710b5111eaa8 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -763,19 +763,27 @@ struct attribute_group nd_region_attribute_group = {
 };
 EXPORT_SYMBOL_GPL(nd_region_attribute_group);
 
-static struct device_type nd_blk_device_type = {
+static const struct attribute_group *nd_region_attribute_groups[] = {
+	&nd_device_attribute_group,
+	NULL,
+};
+
+static const struct device_type nd_blk_device_type = {
 	.name = "nd_blk",
 	.release = nd_region_release,
+	.groups = nd_region_attribute_groups,
 };
 
-static struct device_type nd_pmem_device_type = {
+static const struct device_type nd_pmem_device_type = {
 	.name = "nd_pmem",
 	.release = nd_region_release,
+	.groups = nd_region_attribute_groups,
 };
 
-static struct device_type nd_volatile_device_type = {
+static const struct device_type nd_volatile_device_type = {
 	.name = "nd_volatile",
 	.release = nd_region_release,
+	.groups = nd_region_attribute_groups,
 };
 
 bool is_nd_pmem(struct device *dev)
@@ -931,8 +939,8 @@ void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
 EXPORT_SYMBOL(nd_region_release_lane);
 
 static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
-		struct nd_region_desc *ndr_desc, struct device_type *dev_type,
-		const char *caller)
+		struct nd_region_desc *ndr_desc,
+		const struct device_type *dev_type, const char *caller)
 {
 	struct nd_region *nd_region;
 	struct device *dev;
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index b6eddf912568..d7dbf42498af 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -67,7 +67,6 @@ enum {
 
 extern struct attribute_group nvdimm_bus_attribute_group;
 extern struct attribute_group nvdimm_attribute_group;
-extern struct attribute_group nd_device_attribute_group;
 extern struct attribute_group nd_numa_attribute_group;
 extern struct attribute_group nd_region_attribute_group;
 extern struct attribute_group nd_mapping_attribute_group;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
