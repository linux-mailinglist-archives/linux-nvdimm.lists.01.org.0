Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D71315A7A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 01:03:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DCA3100EAAEF;
	Tue,  9 Feb 2021 16:03:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 98D29100F2250
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 16:03:25 -0800 (PST)
IronPort-SDR: 7ALR00BM114TgJnMHV3rtHicpPcrlCuDqHXH87NcjUk9c+a1k33GVXk4C0YgVwuaxZ598ecHYk
 NPfTPPAR5mTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="201079143"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400";
   d="scan'208";a="201079143"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:03:12 -0800
IronPort-SDR: qtxoClHuKkQ/LdGmLaddzGPdATaZMKFRzs8zsdrQc2g+0UPuY5SampN3yvK9DfZ4tVruDxSp3t
 5f5CokcNshXg==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400";
   d="scan'208";a="419865831"
Received: from sitira7x-mobl1.gar.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:03:10 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/8] cxl/mem: Find device capabilities
Date: Tue,  9 Feb 2021 16:02:53 -0800
Message-Id: <20210210000259.635748-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210000259.635748-1-ben.widawsky@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: MXDKRIOHGACVDDESD2HDVP5XPPNZNPQK
X-Message-ID-Hash: MXDKRIOHGACVDDESD2HDVP5XPPNZNPQK
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MXDKRIOHGACVDDESD2HDVP5XPPNZNPQK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Provide enough functionality to utilize the mailbox of a memory device.
The mailbox is used to interact with the firmware running on the memory
device. The flow is proven with one implemented command, "identify".
Because the class code has already told the driver this is a memory
device and the identify command is mandatory.

CXL devices contain an array of capabilities that describe the
interactions software can have with the device or firmware running on
the device. A CXL compliant device must implement the device status and
the mailbox capability. Additionally, a CXL compliant memory device must
implement the memory device capability. Each of the capabilities can
[will] provide an offset within the MMIO region for interacting with the
CXL device.

The capabilities tell the driver how to find and map the register space
for CXL Memory Devices. The registers are required to utilize the CXL
spec defined mailbox interface. The spec outlines two mailboxes, primary
and secondary. The secondary mailbox is earmarked for system firmware,
and not handled in this driver.

Primary mailboxes are capable of generating an interrupt when submitting
a background command. That implementation is saved for a later time.

Link: https://www.computeexpresslink.org/download-the-specification
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Kconfig           |  14 +
 drivers/cxl/cxl.h             |  93 +++++++
 drivers/cxl/mem.c             | 511 +++++++++++++++++++++++++++++++++-
 drivers/cxl/pci.h             |  13 +
 include/uapi/linux/pci_regs.h |   1 +
 5 files changed, 630 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/cxl.h

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 9e80b311e928..c4ba3aa0a05d 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -32,4 +32,18 @@ config CXL_MEM
 	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
 
 	  If unsure say 'm'.
+
+config CXL_MEM_INSECURE_DEBUG
+	bool "CXL.mem debugging"
+	depends on CXL_MEM
+	help
+	  Enable debug of all CXL command payloads.
+
+	  Some CXL devices and controllers support encryption and other
+	  security features. The payloads for the commands that enable
+	  those features may contain sensitive clear-text security
+	  material. Disable debug of those command payloads by default.
+	  If you are a kernel developer actively working on CXL
+	  security enabling say Y, otherwise say N.
+
 endif
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
new file mode 100644
index 000000000000..745f5e0bfce3
--- /dev/null
+++ b/drivers/cxl/cxl.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. */
+
+#ifndef __CXL_H__
+#define __CXL_H__
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+
+/* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
+#define CXLDEV_CAP_ARRAY_OFFSET 0x0
+#define   CXLDEV_CAP_ARRAY_CAP_ID 0
+#define   CXLDEV_CAP_ARRAY_ID_MASK GENMASK(15, 0)
+#define   CXLDEV_CAP_ARRAY_COUNT_MASK GENMASK(47, 32)
+/* CXL 2.0 8.2.8.2.1 CXL Device Capabilities */
+#define CXLDEV_CAP_CAP_ID_DEVICE_STATUS 0x1
+#define CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX 0x2
+#define CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX 0x3
+#define CXLDEV_CAP_CAP_ID_MEMDEV 0x4000
+
+/* CXL 2.0 8.2.8.4 Mailbox Registers */
+#define CXLDEV_MBOX_CAPS_OFFSET 0x00
+#define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
+#define CXLDEV_MBOX_CTRL_OFFSET 0x04
+#define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
+#define CXLDEV_MBOX_CMD_OFFSET 0x08
+#define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK(15, 0)
+#define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK(36, 16)
+#define CXLDEV_MBOX_STATUS_OFFSET 0x10
+#define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK(47, 32)
+#define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
+#define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
+
+/* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
+#define CXLMDEV_STATUS_OFFSET 0x0
+#define   CXLMDEV_DEV_FATAL BIT(0)
+#define   CXLMDEV_FW_HALT BIT(1)
+#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
+#define     CXLMDEV_MS_NOT_READY 0
+#define     CXLMDEV_MS_READY 1
+#define     CXLMDEV_MS_ERROR 2
+#define     CXLMDEV_MS_DISABLED 3
+#define CXLMDEV_READY(status)                                                  \
+	(FIELD_GET(CXLMDEV_STATUS_MEDIA_STATUS_MASK, status) ==                \
+	 CXLMDEV_MS_READY)
+#define   CXLMDEV_MBOX_IF_READY BIT(4)
+#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
+#define     CXLMDEV_RESET_NEEDED_NOT 0
+#define     CXLMDEV_RESET_NEEDED_COLD 1
+#define     CXLMDEV_RESET_NEEDED_WARM 2
+#define     CXLMDEV_RESET_NEEDED_HOT 3
+#define     CXLMDEV_RESET_NEEDED_CXL 4
+#define CXLMDEV_RESET_NEEDED(status)                                           \
+	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
+	 CXLMDEV_RESET_NEEDED_NOT)
+
+/**
+ * struct cxl_mem - A CXL memory device
+ * @pdev: The PCI device associated with this CXL device.
+ * @regs: IO mappings to the device's MMIO
+ * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
+ * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
+ * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
+ * @payload_size: Size of space for payload
+ *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
+ * @mbox_mutex: Mutex to synchronize mailbox access.
+ * @firmware_version: Firmware version for the memory device.
+ * @pmem: Persistent memory capacity information.
+ * @ram: Volatile memory capacity information.
+ */
+struct cxl_mem {
+	struct pci_dev *pdev;
+	void __iomem *regs;
+
+	void __iomem *status_regs;
+	void __iomem *mbox_regs;
+	void __iomem *memdev_regs;
+
+	size_t payload_size;
+	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
+	char firmware_version[0x10];
+
+	struct {
+		struct range range;
+	} pmem;
+
+	struct {
+		struct range range;
+	} ram;
+};
+
+#endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 99a6571508df..0a868a15badc 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -4,6 +4,401 @@
 #include <linux/pci.h>
 #include <linux/io.h>
 #include "pci.h"
+#include "cxl.h"
+
+#define cxl_doorbell_busy(cxlm)                                                \
+	(readl((cxlm)->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET) &                  \
+	 CXLDEV_MBOX_CTRL_DOORBELL)
+
+/* CXL 2.0 - 8.2.8.4 */
+#define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
+
+enum opcode {
+	CXL_MBOX_OP_IDENTIFY		= 0x4000,
+	CXL_MBOX_OP_MAX			= 0x10000
+};
+
+/**
+ * struct mbox_cmd - A command to be submitted to hardware.
+ * @opcode: (input) The command set and command submitted to hardware.
+ * @payload_in: (input) Pointer to the input payload.
+ * @payload_out: (output) Pointer to the output payload. Must be allocated by
+ *		 the caller.
+ * @size_in: (input) Number of bytes to load from @payload.
+ * @size_out: (output) Number of bytes loaded into @payload.
+ * @return_code: (output) Error code returned from hardware.
+ *
+ * This is the primary mechanism used to send commands to the hardware.
+ * All the fields except @payload_* correspond exactly to the fields described in
+ * Command Register section of the CXL 2.0 spec (8.2.8.4.5). @payload_in and
+ * @payload_out are written to, and read from the Command Payload Registers
+ * defined in (8.2.8.4.8).
+ */
+struct mbox_cmd {
+	u16 opcode;
+	void *payload_in;
+	void *payload_out;
+	size_t size_in;
+	size_t size_out;
+	u16 return_code;
+#define CXL_MBOX_SUCCESS 0
+};
+
+static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
+{
+	const unsigned long start = jiffies;
+	unsigned long end = start;
+
+	while (cxl_doorbell_busy(cxlm)) {
+		end = jiffies;
+
+		if (time_after(end, start + CXL_MAILBOX_TIMEOUT_MS)) {
+			/* Check again in case preempted before timeout test */
+			if (!cxl_doorbell_busy(cxlm))
+				break;
+			return -ETIMEDOUT;
+		}
+		cpu_relax();
+	}
+
+	dev_dbg(&cxlm->pdev->dev, "Doorbell wait took %dms",
+		jiffies_to_msecs(end) - jiffies_to_msecs(start));
+	return 0;
+}
+
+static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
+				 struct mbox_cmd *mbox_cmd)
+{
+	struct device *dev = &cxlm->pdev->dev;
+
+	dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
+		mbox_cmd->opcode, mbox_cmd->size_in);
+
+	if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
+		print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
+				     mbox_cmd->payload_in, mbox_cmd->size_in,
+				     true);
+	}
+}
+
+/**
+ * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
+ * @cxlm: The CXL memory device to communicate with.
+ * @mbox_cmd: Command to send to the memory device.
+ *
+ * Context: Any context. Expects mbox_lock to be held.
+ * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
+ *         Caller should check the return code in @mbox_cmd to make sure it
+ *         succeeded.
+ *
+ * This is a generic form of the CXL mailbox send command, thus the only I/O
+ * operations used are cxl_read_mbox_reg(). Memory devices, and perhaps other
+ * types of CXL devices may have further information available upon error
+ * conditions.
+ *
+ * The CXL spec allows for up to two mailboxes. The intention is for the primary
+ * mailbox to be OS controlled and the secondary mailbox to be used by system
+ * firmware. This allows the OS and firmware to communicate with the device and
+ * not need to coordinate with each other. The driver only uses the primary
+ * mailbox.
+ */
+static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
+				 struct mbox_cmd *mbox_cmd)
+{
+	void __iomem *payload = cxlm->mbox_regs + CXLDEV_MBOX_PAYLOAD_OFFSET;
+	u64 cmd_reg, status_reg;
+	size_t out_len;
+	int rc;
+
+	lockdep_assert_held(&cxlm->mbox_mutex);
+
+	/*
+	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
+	 *   1. Caller reads MB Control Register to verify doorbell is clear
+	 *   2. Caller writes Command Register
+	 *   3. Caller writes Command Payload Registers if input payload is non-empty
+	 *   4. Caller writes MB Control Register to set doorbell
+	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
+	 *   6. Caller reads MB Status Register to fetch Return code
+	 *   7. If command successful, Caller reads Command Register to get Payload Length
+	 *   8. If output payload is non-empty, host reads Command Payload Registers
+	 *
+	 * Hardware is free to do whatever it wants before the doorbell is rung,
+	 * and isn't allowed to change anything after it clears the doorbell. As
+	 * such, steps 2 and 3 can happen in any order, and steps 6, 7, 8 can
+	 * also happen in any order (though some orders might not make sense).
+	 */
+
+	/* #1 */
+	if (cxl_doorbell_busy(cxlm)) {
+		dev_err_ratelimited(&cxlm->pdev->dev,
+				    "Mailbox re-busy after acquiring\n");
+		return -EBUSY;
+	}
+
+	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
+			     mbox_cmd->opcode);
+	if (mbox_cmd->size_in) {
+		if (WARN_ON(!mbox_cmd->payload_in))
+			return -EINVAL;
+
+		cmd_reg |= FIELD_PREP(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK,
+				      mbox_cmd->size_in);
+		memcpy_toio(payload, mbox_cmd->payload_in, mbox_cmd->size_in);
+	}
+
+	/* #2, #3 */
+	writeq(cmd_reg, cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
+
+	/* #4 */
+	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
+	writel(CXLDEV_MBOX_CTRL_DOORBELL,
+	       cxlm->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET);
+
+	/* #5 */
+	rc = cxl_mem_wait_for_doorbell(cxlm);
+	if (rc == -ETIMEDOUT) {
+		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
+		return rc;
+	}
+
+	/* #6 */
+	status_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_STATUS_OFFSET);
+	mbox_cmd->return_code =
+		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
+
+	if (mbox_cmd->return_code != 0) {
+		dev_dbg(&cxlm->pdev->dev, "Mailbox operation had an error\n");
+		return 0;
+	}
+
+	/* #7 */
+	cmd_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
+	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
+
+	/* #8 */
+	if (out_len && mbox_cmd->payload_out)
+		memcpy_fromio(mbox_cmd->payload_out, payload, out_len);
+
+	mbox_cmd->size_out = out_len;
+
+	return 0;
+}
+
+/**
+ * cxl_mem_mbox_get() - Acquire exclusive access to the mailbox.
+ * @cxlm: The memory device to gain access to.
+ *
+ * Context: Any context. Takes the mbox_lock.
+ * Return: 0 if exclusive access was acquired.
+ */
+static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
+{
+	struct device *dev = &cxlm->pdev->dev;
+	int rc = -EBUSY;
+	u64 md_status;
+
+	mutex_lock_io(&cxlm->mbox_mutex);
+
+	/*
+	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
+	 * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
+	 * bit is to allow firmware running on the device to notify the driver
+	 * that it's ready to receive commands. It is unclear if the bit needs
+	 * to be read for each transaction mailbox, ie. the firmware can switch
+	 * it on and off as needed. Second, there is no defined timeout for
+	 * mailbox ready, like there is for the doorbell interface.
+	 *
+	 * Assumptions:
+	 * 1. The firmware might toggle the Mailbox Interface Ready bit, check
+	 *    it for every command.
+	 *
+	 * 2. If the doorbell is clear, the firmware should have first set the
+	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
+	 *    to be ready is sufficient.
+	 */
+	rc = cxl_mem_wait_for_doorbell(cxlm);
+	if (rc) {
+		dev_warn(dev, "Mailbox interface not ready\n");
+		goto out;
+	}
+
+	md_status = readq(cxlm->memdev_regs + CXLMDEV_STATUS_OFFSET);
+	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
+		dev_err(dev,
+			"mbox: reported doorbell ready, but not mbox ready\n");
+		goto out;
+	}
+
+	/*
+	 * Hardware shouldn't allow a ready status but also have failure bits
+	 * set. Spit out an error, this should be a bug report
+	 */
+	rc = -EFAULT;
+	if (md_status & CXLMDEV_DEV_FATAL) {
+		dev_err(dev, "mbox: reported ready, but fatal\n");
+		goto out;
+	}
+	if (md_status & CXLMDEV_FW_HALT) {
+		dev_err(dev, "mbox: reported ready, but halted\n");
+		goto out;
+	}
+	if (CXLMDEV_RESET_NEEDED(md_status)) {
+		dev_err(dev, "mbox: reported ready, but reset needed\n");
+		goto out;
+	}
+
+	/* with lock held */
+	return 0;
+
+out:
+	mutex_unlock(&cxlm->mbox_mutex);
+	return rc;
+}
+
+/**
+ * cxl_mem_mbox_put() - Release exclusive access to the mailbox.
+ * @cxlm: The CXL memory device to communicate with.
+ *
+ * Context: Any context. Expects mbox_lock to be held.
+ */
+static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
+{
+	mutex_unlock(&cxlm->mbox_mutex);
+}
+
+/**
+ * cxl_mem_setup_regs() - Setup necessary MMIO.
+ * @cxlm: The CXL memory device to communicate with.
+ *
+ * Return: 0 if all necessary registers mapped.
+ *
+ * A memory device is required by spec to implement a certain set of MMIO
+ * regions. The purpose of this function is to enumerate and map those
+ * registers.
+ */
+static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
+{
+	struct device *dev = &cxlm->pdev->dev;
+	int cap, cap_count;
+	u64 cap_array;
+
+	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
+	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
+	    CXLDEV_CAP_ARRAY_CAP_ID)
+		return -ENODEV;
+
+	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
+
+	for (cap = 1; cap <= cap_count; cap++) {
+		void __iomem *register_block;
+		u32 offset;
+		u16 cap_id;
+
+		cap_id = readl(cxlm->regs + cap * 0x10) & 0xffff;
+		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
+		register_block = cxlm->regs + offset;
+
+		switch (cap_id) {
+		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
+			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
+			cxlm->status_regs = register_block;
+			break;
+		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
+			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
+			cxlm->mbox_regs = register_block;
+			break;
+		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
+			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
+			break;
+		case CXLDEV_CAP_CAP_ID_MEMDEV:
+			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
+			cxlm->memdev_regs = register_block;
+			break;
+		default:
+			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
+			break;
+		}
+	}
+
+	if (!cxlm->status_regs || !cxlm->mbox_regs || !cxlm->memdev_regs) {
+		dev_err(dev, "registers not found: %s%s%s\n",
+			!cxlm->status_regs ? "status " : "",
+			!cxlm->mbox_regs ? "mbox " : "",
+			!cxlm->memdev_regs ? "memdev" : "");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
+{
+	const int cap = readl(cxlm->mbox_regs + CXLDEV_MBOX_CAPS_OFFSET);
+
+	cxlm->payload_size =
+		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
+
+	/*
+	 * CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register
+	 *
+	 * If the size is too small, mandatory commands will not work and so
+	 * there's no point in going forward. If the size is too large, there's
+	 * no harm is soft limiting it.
+	 */
+	cxlm->payload_size = min_t(size_t, cxlm->payload_size, SZ_1M);
+	if (cxlm->payload_size < 256) {
+		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
+			cxlm->payload_size);
+		return -ENXIO;
+	}
+
+	dev_dbg(&cxlm->pdev->dev, "Mailbox payload sized %zu",
+		cxlm->payload_size);
+
+	return 0;
+}
+
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
+	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
+	if (!cxlm) {
+		dev_err(dev, "No memory available\n");
+		return NULL;
+	}
+
+	offset = ((u64)reg_hi << 32) | FIELD_GET(CXL_REGLOC_ADDR_MASK, reg_lo);
+	bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
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
+	regs = pcim_iomap_table(pdev)[bar];
+
+	mutex_init(&cxlm->mbox_mutex);
+	cxlm->pdev = pdev;
+	cxlm->regs = regs + offset;
+
+	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
+	return cxlm;
+}
 
 static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 {
@@ -28,10 +423,85 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
+/**
+ * cxl_mem_identify() - Send the IDENTIFY command to the device.
+ * @cxlm: The device to identify.
+ *
+ * Return: 0 if identify was executed successfully.
+ *
+ * This will dispatch the identify command to the device and on success populate
+ * structures to be exported to sysfs.
+ */
+static int cxl_mem_identify(struct cxl_mem *cxlm)
+{
+	struct cxl_mbox_identify {
+		char fw_revision[0x10];
+		__le64 total_capacity;
+		__le64 volatile_capacity;
+		__le64 persistent_capacity;
+		__le64 partition_align;
+		__le16 info_event_log_size;
+		__le16 warning_event_log_size;
+		__le16 failure_event_log_size;
+		__le16 fatal_event_log_size;
+		__le32 lsa_size;
+		u8 poison_list_max_mer[3];
+		__le16 inject_poison_limit;
+		u8 poison_caps;
+		u8 qos_telemetry_caps;
+	} __packed id;
+	struct mbox_cmd mbox_cmd = {
+		.opcode = CXL_MBOX_OP_IDENTIFY,
+		.payload_out = &id,
+		.size_in = 0,
+	};
+	int rc;
+
+	/* Retrieve initial device memory map */
+	rc = cxl_mem_mbox_get(cxlm);
+	if (rc)
+		return rc;
+
+	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
+	cxl_mem_mbox_put(cxlm);
+	if (rc)
+		return rc;
+
+	/* TODO: Handle retry or reset responses from firmware. */
+	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS) {
+		dev_err(&cxlm->pdev->dev, "Mailbox command failed (%d)\n",
+			mbox_cmd.return_code);
+		return -ENXIO;
+	}
+
+	if (mbox_cmd.size_out != sizeof(id))
+		return -ENXIO;
+
+	/*
+	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
+	 * For now, only the capacity is exported in sysfs
+	 */
+	cxlm->ram.range.start = 0;
+	cxlm->ram.range.end = le64_to_cpu(id.volatile_capacity) - 1;
+
+	cxlm->pmem.range.start = 0;
+	cxlm->pmem.range.end = le64_to_cpu(id.persistent_capacity) - 1;
+
+	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
+
+	return rc;
+}
+
 static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
-	int regloc;
+	struct cxl_mem *cxlm;
+	int rc, regloc, i;
+	u32 regloc_size;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
 
 	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
 	if (!regloc) {
@@ -39,7 +509,44 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENXIO;
 	}
 
-	return 0;
+	/* Get the size of the Register Locator DVSEC */
+	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
+	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
+
+	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
+
+	rc = -ENXIO;
+	for (i = regloc; i < regloc + regloc_size; i += 8) {
+		u32 reg_lo, reg_hi;
+		u8 reg_type;
+
+		/* "register low and high" contain other bits */
+		pci_read_config_dword(pdev, i, &reg_lo);
+		pci_read_config_dword(pdev, i + 4, &reg_hi);
+
+		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
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
+	if (rc)
+		return rc;
+
+	rc = cxl_mem_setup_regs(cxlm);
+	if (rc)
+		return rc;
+
+	rc = cxl_mem_setup_mailbox(cxlm);
+	if (rc)
+		return rc;
+
+	return cxl_mem_identify(cxlm);
 }
 
 static const struct pci_device_id cxl_mem_pci_tbl[] = {
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index f135b9f7bb21..ffcbc13d7b5b 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -14,5 +14,18 @@
 #define PCI_DVSEC_ID_CXL		0x0
 
 #define PCI_DVSEC_ID_CXL_REGLOC_OFFSET		0x8
+#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
+
+/* BAR Indicator Register (BIR) */
+#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
+
+/* Register Block Identifier (RBI) */
+#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
+#define CXL_REGLOC_RBI_EMPTY 0
+#define CXL_REGLOC_RBI_COMPONENT 1
+#define CXL_REGLOC_RBI_VIRT 2
+#define CXL_REGLOC_RBI_MEMDEV 3
+
+#define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
 
 #endif /* __CXL_PCI_H__ */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e709ae8235e7..6267ca9ae683 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1080,6 +1080,7 @@
 
 /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
 #define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-Specific Header1 */
+#define PCI_DVSEC_HEADER1_LENGTH_MASK	0xFFF00000
 #define PCI_DVSEC_HEADER2		0x8 /* Designated Vendor-Specific Header2 */
 
 /* Data Link Feature */
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
