Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C158F18EA6C
	for <lists+linux-nvdimm@lfdr.de>; Sun, 22 Mar 2020 17:29:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB36C10FC378D;
	Sun, 22 Mar 2020 09:29:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 895BB10FC3602
	for <linux-nvdimm@lists.01.org>; Sun, 22 Mar 2020 09:29:55 -0700 (PDT)
IronPort-SDR: jN6OZsLKO5rLfU1XhoO6dTOipPhdCekIpsqLLDZnM9DQkEKC2q+A6UAyZGzPgC0fuYrpRFoI7E
 2f0oCs9YdtVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:29:04 -0700
IronPort-SDR: hy334qU9gf7XAtxMeIChPaVru7f5WDXBOOEXmmF/GOf+dFYHqfZwnEYJD7N6C6bPuXCZkTzNcY
 6XKBj8EfOaWA==
X-IronPort-AV: E=Sophos;i="5.72,293,1580803200";
   d="scan'208";a="325353273"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:29:04 -0700
Subject: [PATCH v2 6/6] ACPI: HMAT: Attach a device for each soft-reserved
 range
From: Dan Williams <dan.j.williams@intel.com>
To: linux-acpi@vger.kernel.org
Date: Sun, 22 Mar 2020 09:12:58 -0700
Message-ID: <158489357825.1457606.17352509511987748598.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: CWPXX74F5GSLFVB2VXH5BZQO5BPHJDKC
X-Message-ID-Hash: CWPXX74F5GSLFVB2VXH5BZQO5BPHJDKC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Brice Goglin <Brice.Goglin@inria.fr>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, peterz@infradead.org, dave.hansen@linux.intel.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, x86@kernel.org, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CWPXX74F5GSLFVB2VXH5BZQO5BPHJDKC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The hmem enabling in commit 'cf8741ac57ed ("ACPI: NUMA: HMAT: Register
"soft reserved" memory as an "hmem" device")' only registered ranges to
the hmem driver for each soft-reservation that also appeared in the
HMAT. While this is meant to encourage platform firmware to "do the
right thing" and publish an HMAT, the corollary is that platforms that
fail to publish an accurate HMAT will strand memory from Linux usage.
Additionally, the "efi_fake_mem" kernel command line option enabling
will strand memory by default without an HMAT.

Arrange for "soft reserved" memory that goes unclaimed by HMAT entries
to be published as raw resource ranges for the hmem driver to consume.

Include a module parameter to disable either this fallback behavior, or
the hmat enabling from creating hmem devices. The module parameter
requires the hmem device enabling to have unique name in the module
namespace: "device_hmem".

Rather than mark this x86-only, include an interim phys_to_target_node()
implementation for arm64.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/arm64/mm/numa.c      |   13 +++++++++++++
 drivers/dax/Kconfig       |    1 +
 drivers/dax/hmem/Makefile |    3 ++-
 drivers/dax/hmem/device.c |   33 +++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 4decf1659700..00fba21eaec0 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -468,3 +468,16 @@ int memory_add_physaddr_to_nid(u64 addr)
 	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
 	return 0;
 }
+
+/*
+ * device-dax instance registrations want a valid target-node in case
+ * they are ever onlined as memory (see hmem_register_device()).
+ *
+ * TODO: consult cached numa info
+ */
+int phys_to_target_node(phys_addr_t addr)
+{
+	pr_warn_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
+			addr);
+	return 0;
+}
diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index a229f45d34aa..163edde6ba41 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -50,6 +50,7 @@ config DEV_DAX_HMEM
 
 config DEV_DAX_HMEM_DEVICES
 	depends on DEV_DAX_HMEM
+	select NUMA_KEEP_MEMINFO if NUMA
 	def_bool y
 
 config DEV_DAX_KMEM
diff --git a/drivers/dax/hmem/Makefile b/drivers/dax/hmem/Makefile
index a9d353d0c9ed..57377b4c3d47 100644
--- a/drivers/dax/hmem/Makefile
+++ b/drivers/dax/hmem/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
-obj-$(CONFIG_DEV_DAX_HMEM_DEVICES) += device.o
+obj-$(CONFIG_DEV_DAX_HMEM_DEVICES) += device_hmem.o
 
+device_hmem-y := device.o
 dax_hmem-y := hmem.o
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index 99bc15a8b031..f9c5fa8b1880 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -4,6 +4,9 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 
+static bool nohmem;
+module_param_named(disable, nohmem, bool, 0444);
+
 void hmem_register_device(int target_nid, struct resource *r)
 {
 	/* define a clean / non-busy resource for the platform device */
@@ -16,6 +19,9 @@ void hmem_register_device(int target_nid, struct resource *r)
 	struct memregion_info info;
 	int rc, id;
 
+	if (nohmem)
+		return;
+
 	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
 			IORES_DESC_SOFT_RESERVED);
 	if (rc != REGION_INTERSECTS)
@@ -62,3 +68,30 @@ void hmem_register_device(int target_nid, struct resource *r)
 out_pdev:
 	memregion_free(id);
 }
+
+static __init int hmem_register_one(struct resource *res, void *data)
+{
+	/*
+	 * If the resource is not a top-level resource it was already
+	 * assigned to a device by the HMAT parsing.
+	 */
+	if (res->parent != &iomem_resource)
+		return 0;
+
+	hmem_register_device(phys_to_target_node(res->start), res);
+
+	return 0;
+}
+
+static __init int hmem_init(void)
+{
+	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
+			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
+	return 0;
+}
+
+/*
+ * As this is a fallback for address ranges unclaimed by the ACPI HMAT
+ * parsing it must be at an initcall level greater than hmat_init().
+ */
+late_initcall(hmem_init);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
