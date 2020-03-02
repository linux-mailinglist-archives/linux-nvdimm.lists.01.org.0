Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 763CC176776
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Mar 2020 23:36:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CDE0510FC360D;
	Mon,  2 Mar 2020 14:37:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E117610FC35A0
	for <linux-nvdimm@lists.01.org>; Mon,  2 Mar 2020 14:37:11 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 14:36:20 -0800
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400";
   d="scan'208";a="233349392"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 14:36:20 -0800
Subject: [PATCH 3/5] ACPI: HMAT: Refactor hmat_register_target_device to
 hmem_register_device
From: Dan Williams <dan.j.williams@intel.com>
To: linux-acpi@vger.kernel.org
Date: Mon, 02 Mar 2020 14:20:14 -0800
Message-ID: <158318761484.2216124.2049322072599482736.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: QXB5LP4DHDAB7MTIZ2BDKDD4K44IUANA
X-Message-ID-Hash: QXB5LP4DHDAB7MTIZ2BDKDD4K44IUANA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QXB5LP4DHDAB7MTIZ2BDKDD4K44IUANA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for exposing "Soft Reserved" memory ranges without an
HMAT, move the hmem device registration to its own compilation unit and
make the implementation generic.

The generic implementation drops usage acpi_map_pxm_to_online_node()
that was translating ACPI proximity domain values and instead relies on
numa_map_to_online_node() to determine the numa node for the device.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa/hmat.c  |   68 ++++-----------------------------------------
 drivers/dax/Kconfig       |    4 +++
 drivers/dax/Makefile      |    3 +-
 drivers/dax/hmem/Makefile |    5 +++
 drivers/dax/hmem/device.c |   64 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dax/hmem/hmem.c   |    2 +
 include/linux/dax.h       |    8 +++++
 7 files changed, 89 insertions(+), 65 deletions(-)
 create mode 100644 drivers/dax/hmem/Makefile
 create mode 100644 drivers/dax/hmem/device.c
 rename drivers/dax/{hmem.c => hmem/hmem.c} (98%)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d3db121e393a..2379efcea570 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -24,6 +24,7 @@
 #include <linux/mutex.h>
 #include <linux/node.h>
 #include <linux/sysfs.h>
+#include <linux/dax.h>
 
 static u8 hmat_revision;
 int hmat_disable __initdata;
@@ -635,66 +636,6 @@ static void hmat_register_target_perf(struct memory_target *target)
 	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
 }
 
-static void hmat_register_target_device(struct memory_target *target,
-		struct resource *r)
-{
-	/* define a clean / non-busy resource for the platform device */
-	struct resource res = {
-		.start = r->start,
-		.end = r->end,
-		.flags = IORESOURCE_MEM,
-	};
-	struct platform_device *pdev;
-	struct memregion_info info;
-	int rc, id;
-
-	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
-			IORES_DESC_SOFT_RESERVED);
-	if (rc != REGION_INTERSECTS)
-		return;
-
-	id = memregion_alloc(GFP_KERNEL);
-	if (id < 0) {
-		pr_err("memregion allocation failure for %pr\n", &res);
-		return;
-	}
-
-	pdev = platform_device_alloc("hmem", id);
-	if (!pdev) {
-		pr_err("hmem device allocation failure for %pr\n", &res);
-		goto out_pdev;
-	}
-
-	pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
-	info = (struct memregion_info) {
-		.target_node = acpi_map_pxm_to_node(target->memory_pxm),
-	};
-	rc = platform_device_add_data(pdev, &info, sizeof(info));
-	if (rc < 0) {
-		pr_err("hmem memregion_info allocation failure for %pr\n", &res);
-		goto out_pdev;
-	}
-
-	rc = platform_device_add_resources(pdev, &res, 1);
-	if (rc < 0) {
-		pr_err("hmem resource allocation failure for %pr\n", &res);
-		goto out_resource;
-	}
-
-	rc = platform_device_add(pdev);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "device add failed for %pr\n", &res);
-		goto out_resource;
-	}
-
-	return;
-
-out_resource:
-	put_device(&pdev->dev);
-out_pdev:
-	memregion_free(id);
-}
-
 static void hmat_register_target_devices(struct memory_target *target)
 {
 	struct resource *res;
@@ -706,8 +647,11 @@ static void hmat_register_target_devices(struct memory_target *target)
 	if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
 		return;
 
-	for (res = target->memregions.child; res; res = res->sibling)
-		hmat_register_target_device(target, res);
+	for (res = target->memregions.child; res; res = res->sibling) {
+		int target_nid = acpi_map_pxm_to_node(target->memory_pxm);
+
+		hmem_register_device(target_nid, res);
+	}
 }
 
 static void hmat_register_target(struct memory_target *target)
diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 3b6c06f07326..a229f45d34aa 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -48,6 +48,10 @@ config DEV_DAX_HMEM
 
 	  Say M if unsure.
 
+config DEV_DAX_HMEM_DEVICES
+	depends on DEV_DAX_HMEM
+	def_bool y
+
 config DEV_DAX_KMEM
 	tristate "KMEM DAX: volatile-use of persistent memory"
 	default DEV_DAX
diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
index 80065b38b3c4..9d4ba672d305 100644
--- a/drivers/dax/Makefile
+++ b/drivers/dax/Makefile
@@ -2,11 +2,10 @@
 obj-$(CONFIG_DAX) += dax.o
 obj-$(CONFIG_DEV_DAX) += device_dax.o
 obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
-obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
 
 dax-y := super.o
 dax-y += bus.o
 device_dax-y := device.o
-dax_hmem-y := hmem.o
 
 obj-y += pmem/
+obj-y += hmem/
diff --git a/drivers/dax/hmem/Makefile b/drivers/dax/hmem/Makefile
new file mode 100644
index 000000000000..a9d353d0c9ed
--- /dev/null
+++ b/drivers/dax/hmem/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
+obj-$(CONFIG_DEV_DAX_HMEM_DEVICES) += device.o
+
+dax_hmem-y := hmem.o
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
new file mode 100644
index 000000000000..99bc15a8b031
--- /dev/null
+++ b/drivers/dax/hmem/device.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/platform_device.h>
+#include <linux/memregion.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+
+void hmem_register_device(int target_nid, struct resource *r)
+{
+	/* define a clean / non-busy resource for the platform device */
+	struct resource res = {
+		.start = r->start,
+		.end = r->end,
+		.flags = IORESOURCE_MEM,
+	};
+	struct platform_device *pdev;
+	struct memregion_info info;
+	int rc, id;
+
+	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
+			IORES_DESC_SOFT_RESERVED);
+	if (rc != REGION_INTERSECTS)
+		return;
+
+	id = memregion_alloc(GFP_KERNEL);
+	if (id < 0) {
+		pr_err("memregion allocation failure for %pr\n", &res);
+		return;
+	}
+
+	pdev = platform_device_alloc("hmem", id);
+	if (!pdev) {
+		pr_err("hmem device allocation failure for %pr\n", &res);
+		goto out_pdev;
+	}
+
+	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
+	info = (struct memregion_info) {
+		.target_node = target_nid,
+	};
+	rc = platform_device_add_data(pdev, &info, sizeof(info));
+	if (rc < 0) {
+		pr_err("hmem memregion_info allocation failure for %pr\n", &res);
+		goto out_pdev;
+	}
+
+	rc = platform_device_add_resources(pdev, &res, 1);
+	if (rc < 0) {
+		pr_err("hmem resource allocation failure for %pr\n", &res);
+		goto out_resource;
+	}
+
+	rc = platform_device_add(pdev);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "device add failed for %pr\n", &res);
+		goto out_resource;
+	}
+
+	return;
+
+out_resource:
+	put_device(&pdev->dev);
+out_pdev:
+	memregion_free(id);
+}
diff --git a/drivers/dax/hmem.c b/drivers/dax/hmem/hmem.c
similarity index 98%
rename from drivers/dax/hmem.c
rename to drivers/dax/hmem/hmem.c
index fe7214daf62e..29ceb5795297 100644
--- a/drivers/dax/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -3,7 +3,7 @@
 #include <linux/memregion.h>
 #include <linux/module.h>
 #include <linux/pfn_t.h>
-#include "bus.h"
+#include "../bus.h"
 
 static int dax_hmem_probe(struct platform_device *pdev)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9bd8528bd305..9f6c282e9140 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -239,4 +239,12 @@ static inline bool dax_mapping(struct address_space *mapping)
 	return mapping->host && IS_DAX(mapping->host);
 }
 
+#ifdef CONFIG_DEV_DAX_HMEM_DEVICES
+void hmem_register_device(int target_nid, struct resource *r);
+#else
+static inline void hmem_register_device(int target_nid, struct resource *r)
+{
+}
+#endif
+
 #endif
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
