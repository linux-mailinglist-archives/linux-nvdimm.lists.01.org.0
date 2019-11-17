Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1169FFB1D
	for <lists+linux-nvdimm@lfdr.de>; Sun, 17 Nov 2019 18:59:25 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D921E100DC3E6;
	Sun, 17 Nov 2019 10:00:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1AAA3100DC3DB
	for <linux-nvdimm@lists.01.org>; Sun, 17 Nov 2019 10:00:27 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:21 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400";
   d="scan'208";a="217631921"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:21 -0800
Subject: [PATCH v2 06/18] libnvdimm: Move nd_mapping_attribute_group to
 device_type
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 17 Nov 2019 09:45:05 -0800
Message-ID: <157401270566.43284.8963531428718028531.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: Y6H2Q7WE5FNM4DBO4YRJS6EITAPGG7XD
X-Message-ID-Hash: Y6H2Q7WE5FNM4DBO4YRJS6EITAPGG7XD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y6H2Q7WE5FNM4DBO4YRJS6EITAPGG7XD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A 'struct device_type' instance can carry default attributes for the
device. Use this facility to remove the export of
nd_mapping_attribute_group and put the responsibility on the core rather
than leaf implementations to define this attribute.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157309902686.1582359.6749533709859492704.stgit@dwillia2-desk3.amr.corp.intel.com
---
 arch/powerpc/platforms/pseries/papr_scm.c |    6 ------
 drivers/acpi/nfit/core.c                  |    1 -
 drivers/nvdimm/region_devs.c              |    4 ++--
 include/linux/libnvdimm.h                 |    1 -
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 6428834d7cd5..0405fb769336 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -284,11 +284,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	return 0;
 }
 
-static const struct attribute_group *region_attr_groups[] = {
-	&nd_mapping_attribute_group,
-	NULL,
-};
-
 static const struct attribute_group *bus_attr_groups[] = {
 	&nvdimm_bus_attribute_group,
 	NULL,
@@ -362,7 +357,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	mapping.size = p->blocks * p->block_size; // XXX: potential overflow?
 
 	memset(&ndr_desc, 0, sizeof(ndr_desc));
-	ndr_desc.attr_groups = region_attr_groups;
 	target_nid = dev_to_node(&p->pdev->dev);
 	online_nid = papr_scm_node(target_nid);
 	ndr_desc.numa_node = online_nid;
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 99e20b8b6ea0..69c406ecc3a6 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2196,7 +2196,6 @@ static const struct attribute_group acpi_nfit_region_attribute_group = {
 };
 
 static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
-	&nd_mapping_attribute_group,
 	&acpi_nfit_region_attribute_group,
 	NULL,
 };
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index f97166583294..0afc1973e938 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -751,11 +751,10 @@ static struct attribute *mapping_attributes[] = {
 	NULL,
 };
 
-struct attribute_group nd_mapping_attribute_group = {
+static const struct attribute_group nd_mapping_attribute_group = {
 	.is_visible = mapping_visible,
 	.attrs = mapping_attributes,
 };
-EXPORT_SYMBOL_GPL(nd_mapping_attribute_group);
 
 static const struct attribute_group nd_region_attribute_group = {
 	.attrs = nd_region_attributes,
@@ -766,6 +765,7 @@ static const struct attribute_group *nd_region_attribute_groups[] = {
 	&nd_device_attribute_group,
 	&nd_region_attribute_group,
 	&nd_numa_attribute_group,
+	&nd_mapping_attribute_group,
 	NULL,
 };
 
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 312248d334c7..eb597d1cb891 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -67,7 +67,6 @@ enum {
 
 extern struct attribute_group nvdimm_bus_attribute_group;
 extern struct attribute_group nvdimm_attribute_group;
-extern struct attribute_group nd_mapping_attribute_group;
 
 struct nvdimm;
 struct nvdimm_bus_descriptor;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
