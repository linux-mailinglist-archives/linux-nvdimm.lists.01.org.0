Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFF62E7E6B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Dec 2020 07:17:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A513D100EBBBE;
	Wed, 30 Dec 2020 22:17:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhuling8@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A327B100EBBBD
	for <linux-nvdimm@lists.01.org>; Wed, 30 Dec 2020 22:17:54 -0800 (PST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D5ybw3pc4z15lVf;
	Thu, 31 Dec 2020 14:17:00 +0800 (CST)
Received: from huawei.com (10.44.142.101) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 31 Dec 2020
 14:17:42 +0800
From: Zhuling <zhuling8@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>, <will@kernel.org>,
	<dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>
Subject: [PATCH] arm64: add pmem module for kernel update
Date: Thu, 31 Dec 2020 13:31:56 +0800
Message-ID: <20201231053156.24276-1-zhuling8@huawei.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
X-Originating-IP: [10.44.142.101]
X-CFilter-Loop: Reflected
Message-ID-Hash: 2LYRAMDBXW2VPOYEYW344PGYS3JAD2FS
X-Message-ID-Hash: 2LYRAMDBXW2VPOYEYW344PGYS3JAD2FS
X-MailFrom: zhuling8@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: luanjianhai@huawei.com, luchunhua@huawei.com, sangyan@huawei.com, zhuling8@huawei.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2LYRAMDBXW2VPOYEYW344PGYS3JAD2FS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Category: feature
Bugzilla: NA
CVE: NA

Use reserved memory to create a pmem device to store the
processes information that dumped before kernel update.
When you want to use this feature you need to declare by
"pmemmem=pmem_size:pmem_phystart" in cmdline.
(exp: pmemmem=100M:0x202000000000)

Signed-off-by: Zhuling <zhuling8@huawei.com>
---
 arch/arm64/kernel/setup.c |   5 +++
 arch/arm64/mm/init.c      |  90 +++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/Kconfig    |  11 +++++
 drivers/nvdimm/Makefile   |   3 ++
 drivers/nvdimm/kup_pmem.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioport.h    |   1 +
 include/linux/mm.h        |   4 ++
 lib/Kconfig               |   6 +++
 8 files changed, 226 insertions(+)
 create mode 100644 drivers/nvdimm/kup_pmem.c

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 133257f..0bd9429 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -237,6 +237,11 @@ static void __init request_standard_resources(void)
 		if (kernel_data.start >= res->start &&
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
+#ifdef CONFIG_KUP_PMEM_MEMORY
+	if (pmem_res.end)
+		insert_resource(&iomem_resource, &pmem_res);
+#endif
+
 #ifdef CONFIG_KEXEC_CORE
 		/* Userspace will find "Crash kernel" region in /proc/iomem. */
 		if (crashk_res.end && crashk_res.start >= res->start &&
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 0955406..9d1395e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -62,6 +62,18 @@ EXPORT_SYMBOL(memstart_addr);
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 static phys_addr_t arm64_dma32_phys_limit __ro_after_init;

+#ifdef CONFIG_KUP_PMEM_MEMORY
+static unsigned long long pmem_size, pmem_phystart;
+
+struct resource pmem_res = {
+	.name = "Kpmem Dev",
+	.start = 0,
+	.end = 0,
+	.flags = IORESOURCE_MEM,
+	.desc = IORES_DESC_KPMEM_DEV
+};
+#endif
+
 #ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
@@ -123,6 +135,80 @@ static void __init reserve_crashkernel(void)
 }
 #endif /* CONFIG_KEXEC_CORE */

+#ifdef CONFIG_KUP_PMEM_MEMORY
+/*
+ * reserve_pmem() - reserves memory for pmem
+ *
+ * This function reserves memory area given in "pmemmem=" kernel command
+ * line parameter. The memory reserved is used by pmem restore progress
+ * when kernel update.
+ */
+static int __init parse_pmem(char *par)
+{
+	char *cur = par;
+
+	if (!par)
+		return 0;
+
+	pmem_size = 0;
+	pmem_phystart = 0;
+
+	pmem_size = memparse(par, &cur);
+	if (par == cur) {
+		pr_warn("pmem: memory value expected\n");
+		return -EINVAL;
+	}
+
+	if (*cur == ':')
+		pmem_phystart = memparse(cur+1, &cur);
+	else if (*cur != ' ' && *cur != '\0') {
+		pr_warn("pmem: unrecognized char %c\n", *cur);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+early_param("pmemmem", parse_pmem);
+
+static void __init reserve_pmem(void)
+{
+	if (!pmem_size || !pmem_phystart) {
+		return;
+	}
+
+	pmem_size = PAGE_ALIGN(pmem_size);
+
+	if (!memblock_is_region_memory(pmem_phystart, pmem_size)) {
+		pr_warn("cannot reserve pmem: region is not memory!\n");
+		return;
+	}
+
+	if (memblock_is_region_reserved(pmem_phystart, pmem_size)) {
+		pr_warn("cannot reserve pmem: region overlaps reserved memory!\n");
+		return;
+	}
+
+	if (!IS_ALIGNED(pmem_phystart, SZ_2M)) {
+		pr_warn("cannot reserve pmem: base address is not 2MB aligned\n");
+		return;
+	}
+	memblock_reserve(pmem_phystart, pmem_size);
+	memblock_remove(pmem_phystart, pmem_size);
+	pr_info("pmem reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
+		    pmem_phystart, pmem_phystart + pmem_size, pmem_size >> 20);
+
+	pmem_res.start = pmem_phystart;
+	pmem_res.end = pmem_phystart + pmem_size - 1;
+}
+#else
+static void __init reserve_pmem(void)
+{
+}
+static void __init reserve_pmem_pages(void)
+{
+}
+#endif /*CONFIG_KUP_PMEM_MEMORY*/
+
 #ifdef CONFIG_CRASH_DUMP
 static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
 		const char *uname, int depth, void *data)
@@ -390,6 +476,10 @@ void __init arm64_memblock_init(void)

 	reserve_elfcorehdr();

+#ifdef CONFIG_KUP_PMEM_MEMORY
+	reserve_pmem();
+#endif
+
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;

 	dma_contiguous_reserve(arm64_dma32_phys_limit);
diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index b7d1eb3..7f5fa22 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -119,6 +119,17 @@ config NVDIMM_KEYS
 	depends on ENCRYPTED_KEYS
 	depends on (LIBNVDIMM=ENCRYPTED_KEYS) || LIBNVDIMM=m

+config KUP_PMEM
+	tristate "Persistent memory for kernel update"
+	depends on LIBNVDIMM
+	depends on KUP_PMEM_MEMORY
+	default LIBNVDIMM
+	help
+	  Allows regions of persistent memory to be described in the
+	  device-tree.
+
+	  Select Y if unsure.
+
 config NVDIMM_TEST_BUILD
 	tristate "Build the unit test core"
 	depends on m
diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
index 29203f3..39fabc3 100644
--- a/drivers/nvdimm/Makefile
+++ b/drivers/nvdimm/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_ND_BLK) += nd_blk.o
 obj-$(CONFIG_X86_PMEM_LEGACY) += nd_e820.o
 obj-$(CONFIG_OF_PMEM) += of_pmem.o
 obj-$(CONFIG_VIRTIO_PMEM) += virtio_pmem.o nd_virtio.o
+obj-$(CONFIG_KUP_PMEM) += nd_kup_pmem.o

 nd_pmem-y := pmem.o

@@ -15,6 +16,8 @@ nd_blk-y := blk.o

 nd_e820-y := e820.o

+nd_kup_pmem-y := kup_pmem.o
+
 libnvdimm-y := core.o
 libnvdimm-y += bus.o
 libnvdimm-y += dimm_devs.o
diff --git a/drivers/nvdimm/kup_pmem.c b/drivers/nvdimm/kup_pmem.c
new file mode 100644
index 0000000..eadf95a
--- /dev/null
+++ b/drivers/nvdimm/kup_pmem.c
@@ -0,0 +1,106 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved.
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ *
+ * kup_pmem.c - kernel update support code.
+ *   create a pmem device to store the processes information that is dumped
+ *   when we want to kernel update.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/memory_hotplug.h>
+#include <linux/libnvdimm.h>
+#include <linux/module.h>
+#include <asm/io.h>
+
+static const struct attribute_group *kup_pmem_attribute_groups[] = {
+	&nvdimm_bus_attribute_group,
+	NULL,
+};
+
+static const struct attribute_group *kup_pmem_region_attribute_groups[] = {
+	&nd_region_attribute_group,
+	&nd_device_attribute_group,
+	NULL,
+};
+
+static int kup_pmem_remove(struct platform_device *pdev)
+{
+	struct nvdimm_bus *nvdimm_bus = platform_get_drvdata(pdev);
+
+	nvdimm_bus_unregister(nvdimm_bus);
+
+	return 0;
+}
+
+static int kup_register_one(struct resource *res, void *data)
+{
+	struct nd_region_desc ndr_desc;
+	struct nvdimm_bus *nvdimm_bus = data;
+
+	memset(&ndr_desc, 0, sizeof(ndr_desc));
+	ndr_desc.res = res;
+	ndr_desc.attr_groups = kup_pmem_region_attribute_groups;
+	ndr_desc.numa_node = NUMA_NO_NODE;
+	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
+	if (!nvdimm_pmem_region_create(nvdimm_bus, &ndr_desc))
+		return -ENXIO;
+	return 0;
+}
+
+static int kup_pmem_probe(struct platform_device *pdev)
+{
+	static struct nvdimm_bus_descriptor nd_desc;
+	struct device *dev = &pdev->dev;
+	struct nvdimm_bus *nvdimm_bus;
+	int rc = -ENXIO;
+
+	nd_desc.attr_groups = kup_pmem_attribute_groups;
+	nd_desc.provider_name = "kup_pmem";
+	nd_desc.module = THIS_MODULE;
+	nvdimm_bus = nvdimm_bus_register(dev, &nd_desc);
+	if (!nvdimm_bus)
+		goto err;
+	platform_set_drvdata(pdev, nvdimm_bus);
+
+	rc = walk_iomem_res_desc(IORES_DESC_KPMEM_DEV,
+			IORESOURCE_MEM, 0, -1, nvdimm_bus, kup_register_one);
+	if (rc)
+		goto err;
+
+	return 0;
+err:
+	nvdimm_bus_unregister(nvdimm_bus);
+	dev_err(dev, "kup_pmem: failed to register legacy persistent memory ranges\n");
+	return rc;
+}
+
+static struct platform_driver kup_pmem_driver = {
+	.probe = kup_pmem_probe,
+	.remove = kup_pmem_remove,
+	.driver = {
+		.name = "kup_pmem",
+	},
+};
+static struct platform_device *pdev;
+
+static __init int register_kup_pmem(void)
+{
+	platform_driver_register(&kup_pmem_driver);
+	pdev = platform_device_alloc("kup_pmem", -1);
+
+	return platform_device_add(pdev);
+}
+
+static __exit void unregister_kup_pmem(void)
+{
+	platform_device_del(pdev);
+	platform_driver_unregister(&kup_pmem_driver);
+}
+
+module_init(register_kup_pmem);
+module_exit(unregister_kup_pmem);
+MODULE_ALIAS("platform:kup_pmem*");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5135d4b..bba36f2 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -139,6 +139,7 @@ enum {
 	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
 	IORES_DESC_RESERVED			= 7,
 	IORES_DESC_SOFT_RESERVED		= 8,
+	IORES_DESC_KPMEM_DEV			= 9,
 };

 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d..2b2a94c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -45,6 +45,10 @@ extern int sysctl_page_lock_unfairness;

 void init_mm_internals(void);

+#ifdef CONFIG_KUP_PMEM_MEMORY
+extern struct resource pmem_res;
+#endif
+
 #ifndef CONFIG_NEED_MULTIPLE_NODES	/* Don't use mapnrs, do it properly */
 extern unsigned long max_mapnr;

diff --git a/lib/Kconfig b/lib/Kconfig
index b46a9fd..ff5677c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -689,3 +689,9 @@ config GENERIC_LIB_UCMPDI2
 config PLDMFW
 	bool
 	default n
+
+config KUP_PMEM_MEMORY
+	bool "reserve memory for kup pmem to store image"
+	default y
+	help
+	  Say y here to enable this feature
--
2.9.5
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
