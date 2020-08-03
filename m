Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1628D239EBE
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 07:19:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D3F4A12A6D4C8;
	Sun,  2 Aug 2020 22:19:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2FCE412A6D4C0
	for <linux-nvdimm@lists.01.org>; Sun,  2 Aug 2020 22:19:05 -0700 (PDT)
IronPort-SDR: QFzxzw9Ok6EFHBqvZ3jZ8JcBKkwIDvlq5ZV+POj/o4ktkpZlsNAA6DfZkz2k5uooeYBDsfRQU7
 P+JOseMaUG9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="149487639"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="149487639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:19:04 -0700
IronPort-SDR: SumpHh205qw57WT/Mpo2On6n3xwfxetUe0KbJxRwxR5vjJ39dFBWuS80bMcHurN5xvzkQxRVLg
 0yCWyWwuidmg==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="492211942"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:19:04 -0700
Subject: [PATCH v4 04/23] ACPI: HMAT: Refactor hmat_register_target_device
 to hmem_register_device
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Sun, 02 Aug 2020 22:02:45 -0700
Message-ID: <159643096584.4062302.5035370788475153738.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 4E2HW7L7EMQRF543WEXR7D2GIZ7II4M3
X-Message-ID-Hash: 4E2HW7L7EMQRF543WEXR7D2GIZ7II4M3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, joao.m.martins@oracle.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4E2HW7L7EMQRF543WEXR7D2GIZ7II4M3/>
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
Link: https://lore.kernel.org/r/158318761484.2216124.2049322072599482736.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa/hmat.c  |   68 ++++-----------------------------------------
 drivers/dax/Kconfig       |    4 +++
 drivers/dax/Makefile      |    3 +-
 drivers/dax/hmem.c        |   56 -------------------------------------
 drivers/dax/hmem/Makefile |    5 +++
 drivers/dax/hmem/device.c |   65 +++++++++++++++++++++++++++++++++++++++++++
 drivers/dax/hmem/hmem.c   |   56 +++++++++++++++++++++++++++++++++++++
 include/linux/dax.h       |    8 +++++
 8 files changed, 145 insertions(+), 120 deletions(-)
 delete mode 100644 drivers/dax/hmem.c
 create mode 100644 drivers/dax/hmem/Makefile
 create mode 100644 drivers/dax/hmem/device.c
 create mode 100644 drivers/dax/hmem/hmem.c

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index a12e36a12618..134bcb40b2af 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -24,6 +24,7 @@
 #include <linux/mutex.h>
 #include <linux/node.h>
 #include <linux/sysfs.h>
+#include <linux/dax.h>
 
 static u8 hmat_revision;
 static int hmat_disable __initdata;
@@ -640,66 +641,6 @@ static void hmat_register_target_perf(struct memory_target *target)
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
@@ -711,8 +652,11 @@ static void hmat_register_target_devices(struct memory_target *target)
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
diff --git a/drivers/dax/hmem.c b/drivers/dax/hmem.c
deleted file mode 100644
index fe7214daf62e..000000000000
--- a/drivers/dax/hmem.c
+++ /dev/null
@@ -1,56 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/platform_device.h>
-#include <linux/memregion.h>
-#include <linux/module.h>
-#include <linux/pfn_t.h>
-#include "bus.h"
-
-static int dax_hmem_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct dev_pagemap pgmap = { };
-	struct dax_region *dax_region;
-	struct memregion_info *mri;
-	struct dev_dax *dev_dax;
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOMEM;
-
-	mri = dev->platform_data;
-	memcpy(&pgmap.res, res, sizeof(*res));
-
-	dax_region = alloc_dax_region(dev, pdev->id, res, mri->target_node,
-			PMD_SIZE, PFN_DEV|PFN_MAP);
-	if (!dax_region)
-		return -ENOMEM;
-
-	dev_dax = devm_create_dev_dax(dax_region, 0, &pgmap);
-	if (IS_ERR(dev_dax))
-		return PTR_ERR(dev_dax);
-
-	/* child dev_dax instances now own the lifetime of the dax_region */
-	dax_region_put(dax_region);
-	return 0;
-}
-
-static int dax_hmem_remove(struct platform_device *pdev)
-{
-	/* devm handles teardown */
-	return 0;
-}
-
-static struct platform_driver dax_hmem_driver = {
-	.probe = dax_hmem_probe,
-	.remove = dax_hmem_remove,
-	.driver = {
-		.name = "hmem",
-	},
-};
-
-module_platform_driver(dax_hmem_driver);
-
-MODULE_ALIAS("platform:hmem*");
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Intel Corporation");
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
index 000000000000..b9dd6b27745c
--- /dev/null
+++ b/drivers/dax/hmem/device.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/platform_device.h>
+#include <linux/memregion.h>
+#include <linux/module.h>
+#include <linux/dax.h>
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
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
new file mode 100644
index 000000000000..29ceb5795297
--- /dev/null
+++ b/drivers/dax/hmem/hmem.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/platform_device.h>
+#include <linux/memregion.h>
+#include <linux/module.h>
+#include <linux/pfn_t.h>
+#include "../bus.h"
+
+static int dax_hmem_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dev_pagemap pgmap = { };
+	struct dax_region *dax_region;
+	struct memregion_info *mri;
+	struct dev_dax *dev_dax;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	mri = dev->platform_data;
+	memcpy(&pgmap.res, res, sizeof(*res));
+
+	dax_region = alloc_dax_region(dev, pdev->id, res, mri->target_node,
+			PMD_SIZE, PFN_DEV|PFN_MAP);
+	if (!dax_region)
+		return -ENOMEM;
+
+	dev_dax = devm_create_dev_dax(dax_region, 0, &pgmap);
+	if (IS_ERR(dev_dax))
+		return PTR_ERR(dev_dax);
+
+	/* child dev_dax instances now own the lifetime of the dax_region */
+	dax_region_put(dax_region);
+	return 0;
+}
+
+static int dax_hmem_remove(struct platform_device *pdev)
+{
+	/* devm handles teardown */
+	return 0;
+}
+
+static struct platform_driver dax_hmem_driver = {
+	.probe = dax_hmem_probe,
+	.remove = dax_hmem_remove,
+	.driver = {
+		.name = "hmem",
+	},
+};
+
+module_platform_driver(dax_hmem_driver);
+
+MODULE_ALIAS("platform:hmem*");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Intel Corporation");
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 6904d4e0b2e0..5d2c3d9aeb5e 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -221,4 +221,12 @@ static inline bool dax_mapping(struct address_space *mapping)
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
