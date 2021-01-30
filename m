Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C643090E7
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 Jan 2021 01:24:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D83E100EB333;
	Fri, 29 Jan 2021 16:24:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C8C48100ED4A7
	for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 16:24:46 -0800 (PST)
IronPort-SDR: SFrdrGxpqAzasv2v7TwZXRfo+uWuJS0MVc1dkzzapAzumgnta2n4Goq1VVXPB98fV/5BUHhnVn
 HXJNpMKoFCaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="265333130"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="265333130"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:46 -0800
IronPort-SDR: T5bT+znXC5VaRxWXLhS5ug7h/Z36z95lcPBf2nsIxYawb5Kws660bUtct6fJkWMxcSVmOPZB8D
 h/Td/Sb/azwg==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="370591648"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:45 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH 02/14] cxl/mem: Map memory device registers
Date: Fri, 29 Jan 2021 16:24:26 -0800
Message-Id: <20210130002438.1872527-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002438.1872527-1-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: IDIV7M6IROIN2ZGQ4QZIY7OVSL7AEL3V
X-Message-ID-Hash: IDIV7M6IROIN2ZGQ4QZIY7OVSL7AEL3V
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IDIV7M6IROIN2ZGQ4QZIY7OVSL7AEL3V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

All the necessary bits are initialized in order to find and map the
register space for CXL Memory Devices. This is accomplished by using the
Register Locator DVSEC (CXL 2.0 - 8.1.9.1) to determine which PCI BAR to
use, and how much of an offset from that BAR should be added.

If the memory device registers are found and mapped a new internal data
structure tracking device state is allocated.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h | 17 ++++++++++
 drivers/cxl/mem.c | 83 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/pci.h | 14 ++++++++
 3 files changed, 112 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/cxl.h

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
new file mode 100644
index 000000000000..d81d0ba4617c
--- /dev/null
+++ b/drivers/cxl/cxl.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. */
+
+#ifndef __CXL_H__
+#define __CXL_H__
+
+/**
+ * struct cxl_mem - A CXL memory device
+ * @pdev: The PCI device associated with this CXL device.
+ * @regs: IO mappings to the device's MMIO
+ */
+struct cxl_mem {
+	struct pci_dev *pdev;
+	void __iomem *regs;
+};
+
+#endif
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index f4ee9a507ac9..a869c8dc24cc 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -4,6 +4,58 @@
 #include <linux/pci.h>
 #include <linux/io.h>
 #include "pci.h"
+#include "cxl.h"
+
+/**
+ * cxl_mem_create() - Create a new &struct cxl_mem.
+ * @pdev: The pci device associated with the new &struct cxl_mem.
+ * @reg_lo: Lower 32b of the register locator
+ * @reg_hi: Upper 32b of the register locator.
+ *
+ * Return: The new &struct cxl_mem on success, NULL on failure.
+ *
+ * Map the BAR for a CXL memory device. This BAR has the memory device's
+ * registers for the device as specified in CXL specification.
+ */
+static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
+				      u32 reg_hi)
+{
+	struct device *dev = &pdev->dev;
+	struct cxl_mem *cxlm;
+	void __iomem *regs;
+	u64 offset;
+	u8 bar;
+	int rc;
+
+	offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
+	bar = (reg_lo >> CXL_REGLOC_BIR_SHIFT) & CXL_REGLOC_BIR_MASK;
+
+	/* Basic sanity check that BAR is big enough */
+	if (pci_resource_len(pdev, bar) < offset) {
+		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
+			&pdev->resource[bar], (unsigned long long)offset);
+		return NULL;
+	}
+
+	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
+	if (rc != 0) {
+		dev_err(dev, "failed to map registers\n");
+		return NULL;
+	}
+
+	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
+	if (!cxlm) {
+		dev_err(dev, "No memory available\n");
+		return NULL;
+	}
+
+	regs = pcim_iomap_table(pdev)[bar];
+	cxlm->pdev = pdev;
+	cxlm->regs = regs + offset;
+
+	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
+	return cxlm;
+}
 
 static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 {
@@ -32,15 +84,42 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
-	int regloc;
+	struct cxl_mem *cxlm;
+	int rc, regloc, i;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
 
 	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
 	if (!regloc) {
 		dev_err(dev, "register location dvsec not found\n");
 		return -ENXIO;
 	}
+	regloc += 0xc; /* Skip DVSEC + reserved fields */
 
-	return 0;
+	rc = -ENXIO;
+	for (i = regloc; i < regloc + 0x24; i += 8) {
+		u32 reg_lo, reg_hi;
+		u8 reg_type;
+
+		/* "register low and high" contain other bits */
+		pci_read_config_dword(pdev, i, &reg_lo);
+		pci_read_config_dword(pdev, i + 4, &reg_hi);
+
+		reg_type =
+			(reg_lo >> CXL_REGLOC_RBI_SHIFT) & CXL_REGLOC_RBI_MASK;
+
+		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
+			rc = 0;
+			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
+			if (!cxlm)
+				rc = -ENODEV;
+			break;
+		}
+	}
+
+	return rc;
 }
 
 static const struct pci_device_id cxl_mem_pci_tbl[] = {
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index a8a9935fa90b..df222edb6ac3 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -17,4 +17,18 @@
 
 #define PCI_DVSEC_ID_CXL_REGLOC		0x8
 
+/* BAR Indicator Register (BIR) */
+#define CXL_REGLOC_BIR_SHIFT 0
+#define CXL_REGLOC_BIR_MASK 0x7
+
+/* Register Block Identifier (RBI) */
+#define CXL_REGLOC_RBI_SHIFT 8
+#define CXL_REGLOC_RBI_MASK 0xff
+#define CXL_REGLOC_RBI_EMPTY 0
+#define CXL_REGLOC_RBI_COMPONENT 1
+#define CXL_REGLOC_RBI_VIRT 2
+#define CXL_REGLOC_RBI_MEMDEV 3
+
+#define CXL_REGLOC_ADDR_MASK 0xffff0000
+
 #endif /* __CXL_PCI_H__ */
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
