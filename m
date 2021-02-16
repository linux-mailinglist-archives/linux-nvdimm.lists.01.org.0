Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C88F31C502
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Feb 2021 02:46:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED9B5100EBB90;
	Mon, 15 Feb 2021 17:45:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B76BE100EBBCE
	for <linux-nvdimm@lists.01.org>; Mon, 15 Feb 2021 17:45:56 -0800 (PST)
IronPort-SDR: G40PdhSfWOp+2XOzF88HcsIIKFZqouDMWn7TUR6Pa4si88FJxrYecuTt/NxEjCjzsvjj1aigq6
 ExYAHJ6OCmBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="246852868"
X-IronPort-AV: E=Sophos;i="5.81,182,1610438400";
   d="scan'208";a="246852868"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 17:45:53 -0800
IronPort-SDR: UCMC6sgbeFRxqlyLF8DHDy40XSOx6uYIv3ZNYOsqQEkg0sih396U5gX9K2OskaQ+O6PJ4EFBzA
 XQYH1ynm4LLw==
X-IronPort-AV: E=Sophos;i="5.81,182,1610438400";
   d="scan'208";a="399296066"
Received: from dlbingha-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.31])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 17:45:54 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v4 2/9] cxl/mem: Find device capabilities
Date: Mon, 15 Feb 2021 17:45:31 -0800
Message-Id: <20210216014538.268106-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210216014538.268106-1-ben.widawsky@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: QHUFNOANY6DNHDGUAQCXLCRTOYMDAURW
X-Message-ID-Hash: QHUFNOANY6DNHDGUAQCXLCRTOYMDAURW
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QHUFNOANY6DNHDGUAQCXLCRTOYMDAURW/>
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)
---
 drivers/cxl/cxl.h |  88 ++++++++
 drivers/cxl/mem.c | 543 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/pci.h |  14 ++
 3 files changed, 643 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/cxl.h

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
new file mode 100644
index 000000000000..0806e6bb8a90
--- /dev/null
+++ b/drivers/cxl/cxl.h
@@ -0,0 +1,88 @@
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
+#define   CXLDEV_CAP_ARRAY_ID_MASK GENMASK_ULL(15, 0)
+#define   CXLDEV_CAP_ARRAY_COUNT_MASK GENMASK_ULL(47, 32)
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
+#define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
+#define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK_ULL(36, 16)
+#define CXLDEV_MBOX_STATUS_OFFSET 0x10
+#define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK_ULL(47, 32)
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
+	struct range pmem_range;
+	struct range ram_range;
+};
+
+#endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index ce33c5ee77c9..b86cda2d299a 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -3,7 +3,458 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
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
+ * Command Register section of the CXL 2.0 8.2.8.4.5. @payload_in and
+ * @payload_out are written to, and read from the Command Payload Registers
+ * defined in CXL 2.0 8.2.8.4.8.
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
+}
+
+/**
+ * __cxl_mem_mbox_send_cmd() - Execute a mailbox command
+ * @cxlm: The CXL memory device to communicate with.
+ * @mbox_cmd: Command to send to the memory device.
+ *
+ * Context: Any context. Expects mbox_mutex to be held.
+ * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
+ *         Caller should check the return code in @mbox_cmd to make sure it
+ *         succeeded.
+ *
+ * This is a generic form of the CXL mailbox send command thus only using the
+ * registers defined by the mailbox capability ID - CXL 2.0 8.2.8.4. Memory
+ * devices, and perhaps other types of CXL devices may have further information
+ * available upon error conditions. Driver facilities wishing to send mailbox
+ * commands should use the wrapper command.
+ *
+ * The CXL spec allows for up to two mailboxes. The intention is for the primary
+ * mailbox to be OS controlled and the secondary mailbox to be used by system
+ * firmware. This allows the OS and firmware to communicate with the device and
+ * not need to coordinate with each other. The driver only uses the primary
+ * mailbox.
+ */
+static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
+				   struct mbox_cmd *mbox_cmd)
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
+	if (out_len && mbox_cmd->payload_out) {
+		size_t n = min_t(size_t, cxlm->payload_size, out_len);
+
+		memcpy_fromio(mbox_cmd->payload_out, payload, n);
+		mbox_cmd->size_out = n;
+	} else {
+		mbox_cmd->size_out = 0;
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_mem_mbox_get() - Acquire exclusive access to the mailbox.
+ * @cxlm: The memory device to gain access to.
+ *
+ * Context: Any context. Takes the mbox_mutex.
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
+		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
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
+ * Context: Any context. Expects mbox_mutex to be held.
+ */
+static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
+{
+	mutex_unlock(&cxlm->mbox_mutex);
+}
+
+/**
+ * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
+ * @cxlm: The CXL memory device to communicate with.
+ * @opcode: Opcode for the mailbox command.
+ * @in: The input payload for the mailbox command.
+ * @in_size: The length of the input payload
+ * @out: Caller allocated buffer for the output.
+ * @out_min_size: Minimum expected size of output.
+ *
+ * Context: Any context. Will acquire and release mbox_mutex.
+ * Return:
+ *  * %>=0	- Number of bytes returned in @out.
+ *  * %-E2BIG	- Payload is too large for hardware.
+ *  * %-EBUSY	- Couldn't acquire exclusive mailbox access.
+ *  * %-EFAULT	- Hardware error occurred.
+ *  * %-ENXIO	- Command completed, but device reported an error.
+ *  * %-ENODATA	- Not enough payload data returned by hardware.
+ *
+ * Mailbox commands may execute successfully yet the device itself reported an
+ * error. While this distinction can be useful for commands from userspace, the
+ * kernel will only be able to use results when both are successful.
+ *
+ * See __cxl_mem_mbox_send_cmd()
+ */
+static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode, void *in,
+				 size_t in_size, void *out, size_t out_min_size)
+{
+	struct mbox_cmd mbox_cmd = {
+		.opcode = opcode,
+		.payload_in = in,
+		.size_in = in_size,
+		.payload_out = out,
+	};
+	int rc;
+
+	if (out_min_size > cxlm->payload_size)
+		return -E2BIG;
+
+	rc = cxl_mem_mbox_get(cxlm);
+	if (rc)
+		return rc;
+
+	rc = __cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
+	cxl_mem_mbox_put(cxlm);
+	if (rc)
+		return rc;
+
+	/* TODO: Map return code to proper kernel style errno */
+	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
+		return -ENXIO;
+
+	if (mbox_cmd.size_out < out_min_size)
+		return -ENODATA;
+
+	return mbox_cmd.size_out;
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
+	if (rc) {
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
@@ -28,10 +479,65 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
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
+	int rc;
+
+	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
+				   sizeof(id));
+	if (rc < 0)
+		return rc;
+
+	/*
+	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
+	 * For now, only the capacity is exported in sysfs
+	 */
+	cxlm->ram_range.start = 0;
+	cxlm->ram_range.end = le64_to_cpu(id.volatile_capacity) - 1;
+
+	cxlm->pmem_range.start = 0;
+	cxlm->pmem_range.end = le64_to_cpu(id.persistent_capacity) - 1;
+
+	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
+
+	return 0;
+}
+
 static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
-	int regloc;
+	struct cxl_mem *cxlm = NULL;
+	int rc, regloc, i;
+	u32 regloc_size;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
 
 	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
 	if (!regloc) {
@@ -39,7 +545,40 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENXIO;
 	}
 
-	return 0;
+	/* Get the size of the Register Locator DVSEC */
+	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
+	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
+
+	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
+
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
+			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
+			break;
+		}
+	}
+
+	if (!cxlm)
+		return -ENODEV;
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
index e464bea3f4d3..af3ec078cf6c 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -9,9 +9,23 @@
  * See section 8.1 Configuration Space Registers in the CXL 2.0
  * Specification
  */
+#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
 #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
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
-- 
2.30.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
