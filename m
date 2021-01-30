Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6943090E6
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 Jan 2021 01:24:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C8A5100EB34E;
	Fri, 29 Jan 2021 16:24:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A441A100ED4A7
	for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 16:24:46 -0800 (PST)
IronPort-SDR: 88SK42ULwnHbFMI2bleGgXCVUrH7uF1A6UdD+TLcGF2b7QzURmb/6vamOhD+wPPxEAA2KpNP6+
 LPkB/aS8fkTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="265333127"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="265333127"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:46 -0800
IronPort-SDR: CqRdBbsp55b6+sSNXhG3wGGUB2/578PfuTqvbSayjqJApMWWI+5ryRenXObkNHyZXkWhJhHCX2
 PyYqjWy56nvg==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="370591645"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:45 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH 01/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
Date: Fri, 29 Jan 2021 16:24:25 -0800
Message-Id: <20210130002438.1872527-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002438.1872527-1-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: VHKF3CJMLREJ2IURDTSOLH3MWGTN7KO6
X-Message-ID-Hash: VHKF3CJMLREJ2IURDTSOLH3MWGTN7KO6
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jonathan Corbet <corbet@lwn.net>, Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VHKF3CJMLREJ2IURDTSOLH3MWGTN7KO6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Dan Williams <dan.j.williams@intel.com>

The CXL.mem protocol allows a device to act as a provider of "System
RAM" and/or "Persistent Memory" that is fully coherent as if the memory
was attached to the typical CPU memory controller.

With the CXL-2.0 specification a PCI endpoint can implement a "Type-3"
device interface and give the operating system control over "Host
Managed Device Memory". See section 2.3 Type 3 CXL Device.

The memory range exported by the device may optionally be described by
the platform firmware memory map, or by infrastructure like LIBNVDIMM to
provision persistent memory capacity from one, or more, CXL.mem devices.

A pre-requisite for Linux-managed memory-capacity provisioning is this
cxl_mem driver that can speak the mailbox protocol defined in section
8.2.8.4 Mailbox Registers.

For now just land the initial driver boiler-plate and Documentation/
infrastructure.

Link: https://www.computeexpresslink.org/download-the-specification
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/driver-api/cxl/index.rst        | 12 ++++
 .../driver-api/cxl/memory-devices.rst         | 29 +++++++++
 Documentation/driver-api/index.rst            |  1 +
 drivers/Kconfig                               |  1 +
 drivers/Makefile                              |  1 +
 drivers/cxl/Kconfig                           | 35 +++++++++++
 drivers/cxl/Makefile                          |  4 ++
 drivers/cxl/mem.c                             | 61 +++++++++++++++++++
 drivers/cxl/pci.h                             | 20 ++++++
 9 files changed, 164 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/index.rst
 create mode 100644 Documentation/driver-api/cxl/memory-devices.rst
 create mode 100644 drivers/cxl/Kconfig
 create mode 100644 drivers/cxl/Makefile
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/pci.h

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
new file mode 100644
index 000000000000..036e49553542
--- /dev/null
+++ b/Documentation/driver-api/cxl/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Compute Express Link
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   memory-devices
+
+.. only::  subproject and html
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
new file mode 100644
index 000000000000..43177e700d62
--- /dev/null
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===================================
+Compute Express Link Memory Devices
+===================================
+
+A Compute Express Link Memory Device is a CXL component that implements the
+CXL.mem protocol. It contains some amount of volatile memory, persistent memory,
+or both. It is enumerated as a PCI device for configuration and passing
+messages over an MMIO mailbox. Its contribution to the System Physical
+Address space is handled via HDM (Host Managed Device Memory) decoders
+that optionally define a device's contribution to an interleaved address
+range across multiple devices underneath a host-bridge or interleaved
+across host-bridges.
+
+Driver Infrastructure
+=====================
+
+This section covers the driver infrastructure for a CXL memory device.
+
+CXL Memory Device
+-----------------
+
+.. kernel-doc:: drivers/cxl/mem.c
+   :doc: cxl mem
+
+.. kernel-doc:: drivers/cxl/mem.c
+   :internal:
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 2456d0a97ed8..d246a18fd78f 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -35,6 +35,7 @@ available subsections can be seen below.
    usb/index
    firewire
    pci/index
+   cxl/index
    spi
    i2c
    ipmb
diff --git a/drivers/Kconfig b/drivers/Kconfig
index dcecc9f6e33f..62c753a73651 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -6,6 +6,7 @@ menu "Device Drivers"
 source "drivers/amba/Kconfig"
 source "drivers/eisa/Kconfig"
 source "drivers/pci/Kconfig"
+source "drivers/cxl/Kconfig"
 source "drivers/pcmcia/Kconfig"
 source "drivers/rapidio/Kconfig"
 
diff --git a/drivers/Makefile b/drivers/Makefile
index fd11b9ac4cc3..678ea810410f 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_NVM)		+= lightnvm/
 obj-y				+= base/ block/ misc/ mfd/ nfc/
 obj-$(CONFIG_LIBNVDIMM)		+= nvdimm/
 obj-$(CONFIG_DAX)		+= dax/
+obj-$(CONFIG_CXL_BUS)		+= cxl/
 obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-y				+= macintosh/
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
new file mode 100644
index 000000000000..3b66b46af8a0
--- /dev/null
+++ b/drivers/cxl/Kconfig
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menuconfig CXL_BUS
+	tristate "CXL (Compute Express Link) Devices Support"
+	depends on PCI
+	help
+	  CXL is a bus that is electrically compatible with PCI Express, but
+	  layers three protocols on that signalling (CXL.io, CXL.cache, and
+	  CXL.mem). The CXL.cache protocol allows devices to hold cachelines
+	  locally, the CXL.mem protocol allows devices to be fully coherent
+	  memory targets, the CXL.io protocol is equivalent to PCI Express.
+	  Say 'y' to enable support for the configuration and management of
+	  devices supporting these protocols.
+
+if CXL_BUS
+
+config CXL_MEM
+	tristate "CXL.mem: Endpoint Support"
+	help
+	  The CXL.mem protocol allows a device to act as a provider of
+	  "System RAM" and/or "Persistent Memory" that is fully coherent
+	  as if the memory was attached to the typical CPU memory
+	  controller.
+
+	  Say 'y/m' to enable a driver (named "cxl_mem.ko" when built as
+	  a module) that will attach to CXL.mem devices for
+	  configuration, provisioning, and health monitoring. This
+	  driver is required for dynamic provisioning of CXL.mem
+	  attached memory which is a prerequisite for persistent memory
+	  support. Typically volatile memory is mapped by platform
+	  firmware and included in the platform memory map, but in some
+	  cases the OS is responsible for mapping that memory. See
+	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
+
+	  If unsure say 'm'.
+endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
new file mode 100644
index 000000000000..4a30f7c3fc4a
--- /dev/null
+++ b/drivers/cxl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+
+cxl_mem-y := mem.o
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
new file mode 100644
index 000000000000..f4ee9a507ac9
--- /dev/null
+++ b/drivers/cxl/mem.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include "pci.h"
+
+static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
+{
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
+	if (!pos)
+		return 0;
+
+	while (pos) {
+		u16 vendor, id;
+
+		pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_ID_OFFSET,
+				     &vendor);
+		pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
+		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
+			return pos;
+
+		pos = pci_find_next_ext_capability(pdev, pos,
+						   PCI_EXT_CAP_ID_DVSEC);
+	}
+
+	return 0;
+}
+
+static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	int regloc;
+
+	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
+	if (!regloc) {
+		dev_err(dev, "register location dvsec not found\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static const struct pci_device_id cxl_mem_pci_tbl[] = {
+	/* PCI class code for CXL.mem Type-3 Devices */
+	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_MEMORY_CXL, 0xffffff, 0 },
+	{ /* terminate list */ },
+};
+MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
+
+static struct pci_driver cxl_mem_driver = {
+	.name			= KBUILD_MODNAME,
+	.id_table		= cxl_mem_pci_tbl,
+	.probe			= cxl_mem_probe,
+};
+
+MODULE_LICENSE("GPL v2");
+module_pci_driver(cxl_mem_driver);
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
new file mode 100644
index 000000000000..a8a9935fa90b
--- /dev/null
+++ b/drivers/cxl/pci.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#ifndef __CXL_PCI_H__
+#define __CXL_PCI_H__
+
+#define PCI_CLASS_MEMORY_CXL	0x050210
+
+/*
+ * See section 8.1 Configuration Space Registers in the CXL 2.0
+ * Specification
+ */
+#define PCI_EXT_CAP_ID_DVSEC		0x23
+#define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
+#define PCI_DVSEC_VENDOR_ID_OFFSET	0x4
+#define PCI_DVSEC_ID_CXL		0x0
+#define PCI_DVSEC_ID_OFFSET		0x8
+
+#define PCI_DVSEC_ID_CXL_REGLOC		0x8
+
+#endif /* __CXL_PCI_H__ */
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
