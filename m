Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C17B1951C9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 27 Mar 2020 08:12:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA68F10FC3BCA;
	Fri, 27 Mar 2020 00:13:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id 6B4CE10FC3614
	for <linux-nvdimm@lists.01.org>; Fri, 27 Mar 2020 00:13:12 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id AE1BE2DC682B;
	Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585293141;
	bh=wz/42EdWYu+4cxF4TVIz60iDaZdQN/2nycuXkQuthlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4h29DRhjvN8N3XO0FtfABSCnVYfNMjo6BubHZ31RTohvOub6kanPQvJzFi5EIv/5
	 AE/6Mqi81qb6pGsJCAuY1XqXjYTUSdekKFVIbBZ7PBc42TC1aCQOVGKrqhQsGus/jE
	 oq3I39fAuWJn+kXL/kdJYqHtJHiK0UBSHC2Fudu10FHe5/b9dR68M2qUDuzvGq3fU+
	 +lffHLLHf/GZxbGuPd+6DvrD//6aGGd2Dukuo5C4aBLOgj1TvyYe3/G9izTcynMEvM
	 syYwM88/QXyNWjHangopg8qZwH5VrhxPaVGkLqPRNw8K0UjaY7e9L+jci94ovAhHpw
	 yd4ubXwNXbW65Q4+wAipn1dqfISbfuzKc5qzY0K6M53u7qEBuU7MLHe9gemcSl/798
	 cGmtU1MHUqqp7CaVkc5y/FuES2PzU6GPKlD93l8FpMy57ROLLp285y5Hej/3Hxbpu5
	 RuTgabj+Qg9KLE1xYGWUrUDaAMg/bqhhQ3D7WS2NbkpVbzyIUtfhpuXnkmNWFk4qBw
	 6YVtf4jpdztL56DZFZNdrSGkmKMi64dTjZaRYKvY14TWCvb1aBsYxcVIKqpSzMULGJ
	 t1hJsHyYdzzhWDrBQWv/gSBNOW/2HyB6l2Hp3GdiCYR4zRq0rejFhnr56V66GylcyE
	 BwVscwQ9Oh0gX8sDpWdx2DaQ=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Aj045934;
	Fri, 27 Mar 2020 18:12:16 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 10/25] nvdimm: Add driver for OpenCAPI Persistent Memory
Date: Fri, 27 Mar 2020 18:11:47 +1100
Message-Id: <20200327071202.2159885-11-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:16 +1100 (AEDT)
Message-ID-Hash: YUEMGLIZ772HBRPGQK2QE5RNCWYKVZPS
X-Message-ID-Hash: YUEMGLIZ772HBRPGQK2QE5RNCWYKVZPS
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YUEMGLIZ772HBRPGQK2QE5RNCWYKVZPS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This driver exposes LPC memory on OpenCAPI pmem cards
as an NVDIMM, allowing the existing nvram infrastructure
to be used.

Namespace metadata is stored on the media itself, so
scm_reserve_metadata() maps 1 section's worth of PMEM storage
at the start to hold this. The rest of the PMEM range is registered
with libnvdimm as an nvdimm. ndctl_config_read/write/size() provide
callbacks to libnvdimm to access the metadata.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/Kconfig         |   2 +
 drivers/nvdimm/Makefile        |   1 +
 drivers/nvdimm/ocxl/Kconfig    |  15 ++
 drivers/nvdimm/ocxl/Makefile   |   7 +
 drivers/nvdimm/ocxl/main.c     | 476 +++++++++++++++++++++++++++++++++
 drivers/nvdimm/ocxl/ocxlpmem.h |  23 ++
 6 files changed, 524 insertions(+)
 create mode 100644 drivers/nvdimm/ocxl/Kconfig
 create mode 100644 drivers/nvdimm/ocxl/Makefile
 create mode 100644 drivers/nvdimm/ocxl/main.c
 create mode 100644 drivers/nvdimm/ocxl/ocxlpmem.h

diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index b7d1eb38b27d..368328637182 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -131,4 +131,6 @@ config NVDIMM_TEST_BUILD
 	  core devm_memremap_pages() implementation and other
 	  infrastructure.
 
+source "drivers/nvdimm/ocxl/Kconfig"
+
 endif
diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
index 29203f3d3069..bc02be11c794 100644
--- a/drivers/nvdimm/Makefile
+++ b/drivers/nvdimm/Makefile
@@ -33,3 +33,4 @@ libnvdimm-$(CONFIG_NVDIMM_KEYS) += security.o
 TOOLS := ../../tools
 TEST_SRC := $(TOOLS)/testing/nvdimm/test
 obj-$(CONFIG_NVDIMM_TEST_BUILD) += $(TEST_SRC)/iomap.o
+obj-$(CONFIG_LIBNVDIMM) += ocxl/
diff --git a/drivers/nvdimm/ocxl/Kconfig b/drivers/nvdimm/ocxl/Kconfig
new file mode 100644
index 000000000000..c5d927520920
--- /dev/null
+++ b/drivers/nvdimm/ocxl/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+if LIBNVDIMM
+
+config OCXL_PMEM
+	tristate "OpenCAPI Persistent Memory"
+	depends on LIBNVDIMM && PPC_POWERNV && PCI && EEH && ZONE_DEVICE && OCXL
+	help
+	  Exposes devices that implement the OpenCAPI Storage Class Memory
+	  specification as persistent memory regions. You may also want
+	  DEV_DAX, DEV_DAX_PMEM & FS_DAX if you plan on using DAX devices
+	  stacked on top of this driver.
+
+	  Select N if unsure.
+
+endif
diff --git a/drivers/nvdimm/ocxl/Makefile b/drivers/nvdimm/ocxl/Makefile
new file mode 100644
index 000000000000..e0e8ade1987a
--- /dev/null
+++ b/drivers/nvdimm/ocxl/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
+
+obj-$(CONFIG_OCXL_PMEM) += ocxlpmem.o
+
+ocxlpmem-y := main.o
\ No newline at end of file
diff --git a/drivers/nvdimm/ocxl/main.c b/drivers/nvdimm/ocxl/main.c
new file mode 100644
index 000000000000..c0066fedf9cc
--- /dev/null
+++ b/drivers/nvdimm/ocxl/main.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2020 IBM Corp.
+
+/*
+ * A driver for OpenCAPI devices that implement the Storage Class
+ * Memory specification.
+ */
+
+#include <linux/module.h>
+#include <misc/ocxl.h>
+#include <linux/ndctl.h>
+#include <linux/mm_types.h>
+#include <linux/memory_hotplug.h>
+#include "ocxlpmem.h"
+
+static const struct pci_device_id pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0625), },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, pci_tbl);
+
+#define NUM_MINORS 256 // Total to reserve
+
+static dev_t ocxlpmem_dev;
+static struct class *ocxlpmem_class;
+static struct mutex minors_idr_lock;
+static struct idr minors_idr;
+
+/**
+ * ndctl_config_write() - Handle a ND_CMD_SET_CONFIG_DATA command from ndctl
+ * @ocxlpmem: the device metadata
+ * @command: the incoming data to write
+ * Return: 0 on success, negative on failure
+ */
+static int ndctl_config_write(struct ocxlpmem *ocxlpmem,
+			      struct nd_cmd_set_config_hdr *command)
+{
+	if (command->in_offset + command->in_length > LABEL_AREA_SIZE)
+		return -EINVAL;
+
+	memcpy_flushcache(ocxlpmem->metadata_addr + command->in_offset,
+			  command->in_buf, command->in_length);
+
+	return 0;
+}
+
+/**
+ * ndctl_config_read() - Handle a ND_CMD_GET_CONFIG_DATA command from ndctl
+ * @ocxlpmem: the device metadata
+ * @command: the read request
+ * Return: 0 on success, negative on failure
+ */
+static int ndctl_config_read(struct ocxlpmem *ocxlpmem,
+			     struct nd_cmd_get_config_data_hdr *command)
+{
+	if (command->in_offset + command->in_length > LABEL_AREA_SIZE)
+		return -EINVAL;
+
+	memcpy_mcsafe(command->out_buf,
+		      ocxlpmem->metadata_addr + command->in_offset,
+		      command->in_length);
+
+	return 0;
+}
+
+/**
+ * ndctl_config_size() - Handle a ND_CMD_GET_CONFIG_SIZE command from ndctl
+ * @command: the read request
+ * Return: 0 on success, negative on failure
+ */
+static int ndctl_config_size(struct nd_cmd_get_config_size *command)
+{
+	command->status = 0;
+	command->config_size = LABEL_AREA_SIZE;
+	command->max_xfer = PAGE_SIZE;
+
+	return 0;
+}
+
+static int ndctl(struct nvdimm_bus_descriptor *nd_desc,
+		 struct nvdimm *nvdimm,
+		 unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
+{
+	struct ocxlpmem *ocxlpmem = container_of(nd_desc,
+						 struct ocxlpmem, bus_desc);
+
+	switch (cmd) {
+	case ND_CMD_GET_CONFIG_SIZE:
+		*cmd_rc = ndctl_config_size(buf);
+		return 0;
+
+	case ND_CMD_GET_CONFIG_DATA:
+		*cmd_rc = ndctl_config_read(ocxlpmem, buf);
+		return 0;
+
+	case ND_CMD_SET_CONFIG_DATA:
+		*cmd_rc = ndctl_config_write(ocxlpmem, buf);
+		return 0;
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+/**
+ * reserve_metadata() - Reserve space for nvdimm metadata
+ * @ocxlpmem: the device metadata
+ * @lpc_mem: The resource representing the LPC memory of the OpenCAPI device
+ */
+static int reserve_metadata(struct ocxlpmem *ocxlpmem,
+			    struct resource *lpc_mem)
+{
+	ocxlpmem->metadata_addr = devm_memremap(&ocxlpmem->dev, lpc_mem->start,
+						LABEL_AREA_SIZE, MEMREMAP_WB);
+	if (IS_ERR(ocxlpmem->metadata_addr))
+		return PTR_ERR(ocxlpmem->metadata_addr);
+
+	return 0;
+}
+
+/**
+ * register_lpc_mem() - Discover persistent memory on a device and register it with the NVDIMM subsystem
+ * @ocxlpmem: the device metadata
+ * Return: 0 on success
+ */
+static int register_lpc_mem(struct ocxlpmem *ocxlpmem)
+{
+	struct nd_region_desc region_desc;
+	struct nd_mapping_desc nd_mapping_desc;
+	struct resource *lpc_mem;
+	const struct ocxl_afu_config *config;
+	const struct ocxl_fn_config *fn_config;
+	int rc;
+	unsigned long nvdimm_cmd_mask = 0;
+	unsigned long nvdimm_flags = 0;
+	int target_node;
+	char serial[16 + 1];
+
+	// Set up the reserved metadata area
+	rc = ocxl_afu_map_lpc_mem(ocxlpmem->ocxl_afu);
+	if (rc < 0)
+		return rc;
+
+	lpc_mem = ocxl_afu_lpc_mem(ocxlpmem->ocxl_afu);
+	if (!lpc_mem || !lpc_mem->start)
+		return -EINVAL;
+
+	config = ocxl_afu_config(ocxlpmem->ocxl_afu);
+	fn_config = ocxl_function_config(ocxlpmem->ocxl_fn);
+
+	rc = reserve_metadata(ocxlpmem, lpc_mem);
+	if (rc)
+		return rc;
+
+	ocxlpmem->bus_desc.provider_name = "ocxlpmem";
+	ocxlpmem->bus_desc.ndctl = ndctl;
+	ocxlpmem->bus_desc.module = THIS_MODULE;
+
+	ocxlpmem->nvdimm_bus = nvdimm_bus_register(&ocxlpmem->dev,
+						   &ocxlpmem->bus_desc);
+	if (!ocxlpmem->nvdimm_bus)
+		return -EINVAL;
+
+	ocxlpmem->pmem_res.start = (u64)lpc_mem->start + LABEL_AREA_SIZE;
+	ocxlpmem->pmem_res.end = (u64)lpc_mem->start + config->lpc_mem_size - 1;
+	ocxlpmem->pmem_res.name = "OpenCAPI persistent memory";
+
+	set_bit(ND_CMD_GET_CONFIG_SIZE, &nvdimm_cmd_mask);
+	set_bit(ND_CMD_GET_CONFIG_DATA, &nvdimm_cmd_mask);
+	set_bit(ND_CMD_SET_CONFIG_DATA, &nvdimm_cmd_mask);
+
+	set_bit(NDD_ALIASING, &nvdimm_flags);
+
+	snprintf(serial, sizeof(serial), "%llx", fn_config->serial);
+	nd_mapping_desc.nvdimm = nvdimm_create(ocxlpmem->nvdimm_bus, ocxlpmem,
+					       NULL, nvdimm_flags,
+					       nvdimm_cmd_mask, 0, NULL);
+	if (!nd_mapping_desc.nvdimm)
+		return -ENOMEM;
+
+	if (nvdimm_bus_check_dimm_count(ocxlpmem->nvdimm_bus, 1))
+		return -EINVAL;
+
+	nd_mapping_desc.start = ocxlpmem->pmem_res.start;
+	nd_mapping_desc.size = resource_size(&ocxlpmem->pmem_res);
+	nd_mapping_desc.position = 0;
+
+	ocxlpmem->nd_set.cookie1 = fn_config->serial;
+	ocxlpmem->nd_set.cookie2 = fn_config->serial;
+
+	target_node = of_node_to_nid(ocxlpmem->pdev->dev.of_node);
+
+	memset(&region_desc, 0, sizeof(region_desc));
+	region_desc.res = &ocxlpmem->pmem_res;
+	region_desc.numa_node = NUMA_NO_NODE;
+	region_desc.target_node = target_node;
+	region_desc.num_mappings = 1;
+	region_desc.mapping = &nd_mapping_desc;
+	region_desc.nd_set = &ocxlpmem->nd_set;
+
+	set_bit(ND_REGION_PAGEMAP, &region_desc.flags);
+	/*
+	 * NB: libnvdimm copies the data from ndr_desc into it's own
+	 * structures so passing a stack pointer is fine.
+	 */
+	ocxlpmem->nd_region = nvdimm_pmem_region_create(ocxlpmem->nvdimm_bus,
+							&region_desc);
+	if (!ocxlpmem->nd_region)
+		return -EINVAL;
+
+	dev_info(&ocxlpmem->dev,
+		 "Onlining %lluMB of persistent memory\n",
+		 nd_mapping_desc.size / SZ_1M);
+
+	return 0;
+}
+
+/**
+ * allocate_minor() - Allocate a minor number to use for an OpenCAPI pmem device
+ * @ocxlpmem: the device metadata
+ * Return: the allocated minor number
+ */
+static int allocate_minor(struct ocxlpmem *ocxlpmem)
+{
+	int minor;
+
+	mutex_lock(&minors_idr_lock);
+	minor = idr_alloc(&minors_idr, ocxlpmem, 0, NUM_MINORS, GFP_KERNEL);
+	mutex_unlock(&minors_idr_lock);
+	return minor;
+}
+
+static void free_minor(struct ocxlpmem *ocxlpmem)
+{
+	mutex_lock(&minors_idr_lock);
+	idr_remove(&minors_idr, MINOR(ocxlpmem->dev.devt));
+	mutex_unlock(&minors_idr_lock);
+}
+
+/**
+ * free_ocxlpmem() - Free all members of an ocxlpmem struct
+ * @ocxlpmem: the device struct to clear
+ */
+static void free_ocxlpmem(struct ocxlpmem *ocxlpmem)
+{
+	int rc;
+
+	free_minor(ocxlpmem);
+
+	if (ocxlpmem->ocxl_context) {
+		rc = ocxl_context_detach(ocxlpmem->ocxl_context);
+		if (rc == -EBUSY)
+			dev_warn(&ocxlpmem->dev, "Timeout detaching ocxl context\n");
+		else
+			ocxl_context_free(ocxlpmem->ocxl_context);
+	}
+
+	if (ocxlpmem->ocxl_afu)
+		ocxl_afu_put(ocxlpmem->ocxl_afu);
+
+	if (ocxlpmem->ocxl_fn)
+		ocxl_function_close(ocxlpmem->ocxl_fn);
+
+	pci_dev_put(ocxlpmem->pdev);
+
+	kfree(ocxlpmem);
+}
+
+/**
+ * free_ocxlpmem_dev() - Free an OpenCAPI persistent memory device
+ * @dev: The device struct
+ */
+static void free_ocxlpmem_dev(struct device *dev)
+{
+	struct ocxlpmem *ocxlpmem = container_of(dev, struct ocxlpmem, dev);
+
+	free_ocxlpmem(ocxlpmem);
+}
+
+/**
+ * ocxlpmem_register() - Register an OpenCAPI pmem device with the kernel
+ * @ocxlpmem: the device metadata
+ * Return: 0 on success, negative on failure
+ */
+static int ocxlpmem_register(struct ocxlpmem *ocxlpmem)
+{
+	int rc;
+	int minor = allocate_minor(ocxlpmem);
+
+	if (minor < 0)
+		return minor;
+
+	ocxlpmem->dev.release = free_ocxlpmem_dev;
+	rc = dev_set_name(&ocxlpmem->dev, "ocxlpmem%d", minor);
+	if (rc < 0)
+		return rc;
+
+	ocxlpmem->dev.devt = MKDEV(MAJOR(ocxlpmem_dev), minor);
+	ocxlpmem->dev.class = ocxlpmem_class;
+	ocxlpmem->dev.parent = &ocxlpmem->pdev->dev;
+
+	return device_register(&ocxlpmem->dev);
+}
+
+/**
+ * ocxlpmem_remove() - Free an OpenCAPI persistent memory device
+ * @pdev: the PCI device information struct
+ */
+static void remove(struct pci_dev *pdev)
+{
+	if (PCI_FUNC(pdev->devfn) == 0) {
+		struct ocxl_fn *func0 = pci_get_drvdata(pdev);
+
+		if (func0)
+			ocxl_function_close(func0);
+	} else {
+		struct ocxlpmem *ocxlpmem = pci_get_drvdata(pdev);
+
+		if (!ocxlpmem)
+			return;
+
+		if (ocxlpmem->nvdimm_bus)
+			nvdimm_bus_unregister(ocxlpmem->nvdimm_bus);
+
+		device_unregister(&ocxlpmem->dev);
+	}
+}
+
+/**
+ * probe_function0() - Set up function 0 for an OpenCAPI persistent memory device
+ * This is important as it enables templates higher than 0 across all other
+ * functions, which in turn enables higher bandwidth accesses
+ * @pdev: the PCI device information struct
+ * Return: 0 on success, negative on failure
+ */
+static int probe_function0(struct pci_dev *pdev)
+{
+	struct ocxl_fn *fn;
+
+	fn = ocxl_function_open(pdev);
+	if (IS_ERR(fn)) {
+		dev_err(&pdev->dev, "failed to open OCXL function\n");
+		return PTR_ERR(fn);
+	}
+
+	pci_set_drvdata(pdev, fn);
+
+	return 0;
+}
+
+/**
+ * probe() - Init an OpenCAPI persistent memory device
+ * @pdev: the PCI device information struct
+ * @ent: The entry from ocxlpmem_pci_tbl
+ * Return: 0 on success, negative on failure
+ */
+static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct ocxlpmem *ocxlpmem;
+	int rc;
+
+	if (PCI_FUNC(pdev->devfn) == 0)
+		return probe_function0(pdev);
+	else if (PCI_FUNC(pdev->devfn) != 1)
+		return 0;
+
+	ocxlpmem = kzalloc(sizeof(*ocxlpmem), GFP_KERNEL);
+	if (!ocxlpmem) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	ocxlpmem->pdev = pci_dev_get(pdev);
+
+	pci_set_drvdata(pdev, ocxlpmem);
+
+	ocxlpmem->ocxl_fn = ocxl_function_open(pdev);
+	if (IS_ERR(ocxlpmem->ocxl_fn)) {
+		rc = PTR_ERR(ocxlpmem->ocxl_fn);
+		dev_err(&pdev->dev, "failed to open OCXL function\n");
+		goto err_unregistered;
+	}
+
+	ocxlpmem->ocxl_afu = ocxl_function_fetch_afu(ocxlpmem->ocxl_fn, 0);
+	if (!ocxlpmem->ocxl_afu) {
+		rc = -ENXIO;
+		dev_err(&pdev->dev, "Could not get OCXL AFU from function\n");
+		goto err_unregistered;
+	}
+
+	ocxl_afu_get(ocxlpmem->ocxl_afu);
+
+	// Resources allocated below here are cleaned up in the release handler
+
+	rc = ocxlpmem_register(ocxlpmem);
+	if (rc) {
+		dev_err(&pdev->dev,
+			"Could not register OpenCAPI persistent memory device with the kernel\n");
+		goto err;
+	}
+
+	rc = ocxl_context_alloc(&ocxlpmem->ocxl_context, ocxlpmem->ocxl_afu,
+				NULL);
+	if (rc) {
+		dev_err(&pdev->dev, "Could not allocate OCXL context\n");
+		goto err;
+	}
+
+	rc = ocxl_context_attach(ocxlpmem->ocxl_context, 0, NULL);
+	if (rc) {
+		dev_err(&pdev->dev, "Could not attach ocxl context\n");
+		goto err;
+	}
+
+	rc = register_lpc_mem(ocxlpmem);
+	if (rc) {
+		dev_err(&pdev->dev,
+			"Could not register OpenCAPI persistent memory with libnvdimm\n");
+		goto err;
+	}
+
+	return 0;
+
+err_unregistered:
+	if (!IS_ERR(ocxlpmem->ocxl_fn))
+		ocxl_function_close(ocxlpmem->ocxl_fn);
+	pci_dev_put(ocxlpmem->pdev);
+	kfree(ocxlpmem);
+	pci_set_drvdata(pdev, NULL);
+
+err:
+	/*
+	 * Further cleanup is done in the release handler via free_ocxlpmem()
+	 * This allows us to keep the character device live to handle IOCTLs to
+	 * investigate issues if the card has an error
+	 */
+
+	dev_err(&pdev->dev,
+		"Error detected, will not register OpenCAPI persistent memory\n");
+	return 0;
+}
+
+static struct pci_driver pci_driver = {
+	.name = "ocxlpmem",
+	.id_table = pci_tbl,
+	.probe = probe,
+	.remove = remove,
+	.shutdown = remove,
+};
+
+static int __init ocxlpmem_init(void)
+{
+	int rc;
+
+	mutex_init(&minors_idr_lock);
+	idr_init(&minors_idr);
+
+	rc = pci_register_driver(&pci_driver);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static void ocxlpmem_exit(void)
+{
+	pci_unregister_driver(&pci_driver);
+}
+
+module_init(ocxlpmem_init);
+module_exit(ocxlpmem_exit);
+
+MODULE_DESCRIPTION("OpenCAPI Persistent Memory");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Alastair D'Silva <alastair@d-silva.org>");
diff --git a/drivers/nvdimm/ocxl/ocxlpmem.h b/drivers/nvdimm/ocxl/ocxlpmem.h
new file mode 100644
index 000000000000..03fe7a264281
--- /dev/null
+++ b/drivers/nvdimm/ocxl/ocxlpmem.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2020 IBM Corp.
+
+#include <linux/pci.h>
+#include <misc/ocxl.h>
+#include <linux/libnvdimm.h>
+#include <linux/mm.h>
+
+#define LABEL_AREA_SIZE	BIT_ULL(PA_SECTION_SHIFT)
+
+struct ocxlpmem {
+	struct device dev;
+	struct pci_dev *pdev;
+	struct ocxl_fn *ocxl_fn;
+	struct nd_interleave_set nd_set;
+	struct nvdimm_bus_descriptor bus_desc;
+	struct nvdimm_bus *nvdimm_bus;
+	struct ocxl_afu *ocxl_afu;
+	struct ocxl_context *ocxl_context;
+	void *metadata_addr;
+	struct resource pmem_res;
+	struct nd_region *nd_region;
+};
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
