Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20529FFB21
	for <lists+linux-nvdimm@lfdr.de>; Sun, 17 Nov 2019 18:59:31 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECD35100DC3E9;
	Sun, 17 Nov 2019 10:00:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A2DE100DC3EA
	for <linux-nvdimm@lists.01.org>; Sun, 17 Nov 2019 10:00:32 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:26 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400";
   d="scan'208";a="289042016"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:26 -0800
Subject: [PATCH v2 07/18] libnvdimm: Move nvdimm_attribute_group to
 device_type
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 17 Nov 2019 09:45:10 -0800
Message-ID: <157401271088.43284.16320038373036215858.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: IAQMRIQ5CXAY2FVCZTMJKXLWOC24XYLH
X-Message-ID-Hash: IAQMRIQ5CXAY2FVCZTMJKXLWOC24XYLH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IAQMRIQ5CXAY2FVCZTMJKXLWOC24XYLH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A 'struct device_type' instance can carry default attributes for the
device. Use this facility to remove the export of
nvdimm_attribute_group and put the responsibility on the core rather
than leaf implementations to define this attribute.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157309903201.1582359.10966209746585062329.stgit@dwillia2-desk3.amr.corp.intel.com
---
 arch/powerpc/platforms/pseries/papr_scm.c |    9 ++-----
 drivers/acpi/nfit/core.c                  |    1 -
 drivers/nvdimm/dimm_devs.c                |   36 +++++++++++++++--------------
 include/linux/libnvdimm.h                 |    1 -
 4 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 0405fb769336..8354737ac340 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -289,11 +289,6 @@ static const struct attribute_group *bus_attr_groups[] = {
 	NULL,
 };
 
-static const struct attribute_group *papr_scm_dimm_groups[] = {
-	&nvdimm_attribute_group,
-	NULL,
-};
-
 static inline int papr_scm_node(int node)
 {
 	int min_dist = INT_MAX, dist;
@@ -339,8 +334,8 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	dimm_flags = 0;
 	set_bit(NDD_ALIASING, &dimm_flags);
 
-	p->nvdimm = nvdimm_create(p->bus, p, papr_scm_dimm_groups,
-				dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
+	p->nvdimm = nvdimm_create(p->bus, p, NULL, dimm_flags,
+				  PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
 	if (!p->nvdimm) {
 		dev_err(dev, "Error creating DIMM object for %pOF\n", p->dn);
 		goto err;
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 69c406ecc3a6..84fc1f865802 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1698,7 +1698,6 @@ static const struct attribute_group acpi_nfit_dimm_attribute_group = {
 };
 
 static const struct attribute_group *acpi_nfit_dimm_attribute_groups[] = {
-	&nvdimm_attribute_group,
 	&acpi_nfit_dimm_attribute_group,
 	NULL,
 };
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 278867c68682..94ea6dba6b4f 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -202,22 +202,6 @@ static void nvdimm_release(struct device *dev)
 	kfree(nvdimm);
 }
 
-static const struct attribute_group *nvdimm_attribute_groups[] = {
-	&nd_device_attribute_group,
-	NULL,
-};
-
-static const struct device_type nvdimm_device_type = {
-	.name = "nvdimm",
-	.release = nvdimm_release,
-	.groups = nvdimm_attribute_groups,
-};
-
-bool is_nvdimm(struct device *dev)
-{
-	return dev->type == &nvdimm_device_type;
-}
-
 struct nvdimm *to_nvdimm(struct device *dev)
 {
 	struct nvdimm *nvdimm = container_of(dev, struct nvdimm, dev);
@@ -456,11 +440,27 @@ static umode_t nvdimm_visible(struct kobject *kobj, struct attribute *a, int n)
 	return 0;
 }
 
-struct attribute_group nvdimm_attribute_group = {
+static const struct attribute_group nvdimm_attribute_group = {
 	.attrs = nvdimm_attributes,
 	.is_visible = nvdimm_visible,
 };
-EXPORT_SYMBOL_GPL(nvdimm_attribute_group);
+
+static const struct attribute_group *nvdimm_attribute_groups[] = {
+	&nd_device_attribute_group,
+	&nvdimm_attribute_group,
+	NULL,
+};
+
+static const struct device_type nvdimm_device_type = {
+	.name = "nvdimm",
+	.release = nvdimm_release,
+	.groups = nvdimm_attribute_groups,
+};
+
+bool is_nvdimm(struct device *dev)
+{
+	return dev->type == &nvdimm_device_type;
+}
 
 struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 		void *provider_data, const struct attribute_group **groups,
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index eb597d1cb891..3644af97bcb4 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -66,7 +66,6 @@ enum {
 };
 
 extern struct attribute_group nvdimm_bus_attribute_group;
-extern struct attribute_group nvdimm_attribute_group;
 
 struct nvdimm;
 struct nvdimm_bus_descriptor;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
