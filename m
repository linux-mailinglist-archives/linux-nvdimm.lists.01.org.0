Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21455315A7F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 01:03:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18C32100EAB0B;
	Tue,  9 Feb 2021 16:03:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CBA39100EAAEA
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 16:03:26 -0800 (PST)
IronPort-SDR: BDTQyqkfFcSaeZg3cQtv3YP+b1QwHEEbRn3DHqf19txKCaZ+Zv5rqqPk5i8EdCZQG69XB4UG3L
 9gKOcii+HjQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="201079163"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400";
   d="scan'208";a="201079163"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:03:17 -0800
IronPort-SDR: fhshPE+MeNmVPGxUjdXV1SeXW74hPIuK9oLyVunDDH2cgNKJBB4duS4+DnWMFXgvI6klh7cDM2
 RP8nzgFf239Q==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400";
   d="scan'208";a="419865858"
Received: from sitira7x-mobl1.gar.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:03:16 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v2 6/8] cxl/mem: Enable commands via CEL
Date: Tue,  9 Feb 2021 16:02:57 -0800
Message-Id: <20210210000259.635748-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210000259.635748-1-ben.widawsky@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: HCMOSJJ2IX47DASFNDQ44DF3DGKLUQFQ
X-Message-ID-Hash: HCMOSJJ2IX47DASFNDQ44DF3DGKLUQFQ
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HCMOSJJ2IX47DASFNDQ44DF3DGKLUQFQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

CXL devices identified by the memory-device class code must implement
the Device Command Interface (described in 8.2.9 of the CXL 2.0 spec).
While the driver already maintains a list of commands it supports, there
is still a need to be able to distinguish between commands that the
driver knows about from commands that are optionally supported by the
hardware.

The Command Effects Log (CEL) is specified in the CXL 2.0 specification.
The CEL is one of two types of logs, the other being vendor specific.
They are distinguished in hardware/spec via UUID. The CEL is useful for
2 things:
1. Determine which optional commands are supported by the CXL device.
2. Enumerate any vendor specific commands

The CEL is used by the driver to determine which commands are available
in the hardware and therefore which commands userspace is allowed to
execute. The set of enabled commands might be a subset of commands which
are advertised in UAPI via CXL_MEM_SEND_COMMAND IOCTL.

The implementation leaves the statically defined table of commands and
supplements it with a bitmap to determine commands that are enabled.
This organization was chosen for the following reasons:
- Smaller memory footprint. Doesn't need a table per device.
- Reduce memory allocation complexity.
- Fixed command IDs to opcode mapping for all devices makes development
  and debugging easier.
- Certain helpers are easily achievable, like cxl_for_each_cmd().

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h            |   2 +
 drivers/cxl/mem.c            | 216 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |   1 +
 3 files changed, 219 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b3c56fa6e126..9a5e595abfa4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -68,6 +68,7 @@ struct cxl_memdev;
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
  * @mbox_mutex: Mutex to synchronize mailbox access.
  * @firmware_version: Firmware version for the memory device.
+ * @enabled_commands: Hardware commands found enabled in CEL.
  * @pmem: Persistent memory capacity information.
  * @ram: Volatile memory capacity information.
  */
@@ -83,6 +84,7 @@ struct cxl_mem {
 	size_t payload_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
+	unsigned long *enabled_cmds;
 
 	struct {
 		struct range range;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6d766a994dce..e9aa6ca18d99 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,6 +45,8 @@ enum opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
+	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
+	CXL_MBOX_OP_GET_LOG		= 0x0401,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
 	CXL_MBOX_OP_SET_LSA		= 0x4103,
@@ -103,6 +105,19 @@ static DEFINE_IDA(cxl_memdev_ida);
 static struct dentry *cxl_debugfs;
 static bool raw_allow_all;
 
+enum {
+	CEL_UUID,
+	VENDOR_DEBUG_UUID
+};
+
+/* See CXL 2.0 Table 170. Get Log Input Payload */
+static const uuid_t log_uuid[] = {
+	[CEL_UUID] = UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96,
+			       0xb1, 0x62, 0x3b, 0x3f, 0x17),
+	[VENDOR_DEBUG_UUID] = UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f,
+					0xd6, 0x07, 0x19, 0x40, 0x3d, 0x86)
+};
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
@@ -111,6 +126,8 @@ static bool raw_allow_all;
  *
  *  * %CXL_CMD_FLAG_MANDATORY: Hardware must support this command. This flag is
  *    only used internally by the driver for sanity checking.
+ *  * %CXL_CMD_INTERNAL_FLAG_PSEUDO: This is a pseudo command which doesn't have
+ *    a direct mapping to hardware. They are implicitly always enabled.
  *
  * The cxl_mem_command is the driver's internal representation of commands that
  * are supported by the driver. Some of these commands may not be supported by
@@ -146,6 +163,7 @@ static struct cxl_mem_command mem_commands[] = {
 #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
 	CXL_CMD(RAW, NONE, ~0, ~0),
 #endif
+	CXL_CMD(GET_SUPPORTED_LOGS, NONE, 0, ~0),
 };
 
 /*
@@ -627,6 +645,10 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
 	c = &mem_commands[send_cmd->id];
 	info = &c->info;
 
+	/* Check that the command is enabled for hardware */
+	if (!test_bit(info->id, cxlm->enabled_cmds))
+		return -ENOTTY;
+
 	if (info->flags & CXL_MEM_COMMAND_FLAG_KERNEL)
 		return -EPERM;
 
@@ -869,6 +891,14 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 	mutex_init(&cxlm->mbox_mutex);
 	cxlm->pdev = pdev;
 	cxlm->regs = regs + offset;
+	cxlm->enabled_cmds =
+		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
+				   sizeof(unsigned long),
+				   GFP_KERNEL | __GFP_ZERO);
+	if (!cxlm->enabled_cmds) {
+		dev_err(dev, "No memory available for bitmap\n");
+		return NULL;
+	}
 
 	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
 	return cxlm;
@@ -1088,6 +1118,188 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	return rc;
 }
 
+struct cxl_mbox_get_log {
+	uuid_t uuid;
+	__le32 offset;
+	__le32 length;
+} __packed;
+
+static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size, u8 *out)
+{
+	u32 remaining = size;
+	u32 offset = 0;
+
+	while (remaining) {
+		u32 xfer_size = min_t(u32, remaining, cxlm->payload_size);
+		struct cxl_mbox_get_log log = {
+			.uuid = *uuid,
+			.offset = cpu_to_le32(offset),
+			.length = cpu_to_le32(xfer_size)
+		};
+		struct mbox_cmd mbox_cmd = {
+			.opcode = CXL_MBOX_OP_GET_LOG,
+			.payload_in = &log,
+			.payload_out = out,
+			.size_in = sizeof(log),
+		};
+		int rc;
+
+		rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
+		if (rc)
+			return rc;
+
+		WARN_ON(mbox_cmd.size_out != xfer_size);
+
+		out += xfer_size;
+		remaining -= xfer_size;
+		offset += xfer_size;
+	}
+
+	return 0;
+}
+
+static inline struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
+{
+	struct cxl_mem_command *c;
+
+	cxl_for_each_cmd(c)
+		if (c->opcode == opcode)
+			return c;
+
+	return NULL;
+}
+
+static void cxl_enable_cmd(struct cxl_mem *cxlm,
+			   const struct cxl_mem_command *cmd)
+{
+	if (test_and_set_bit(cmd->info.id, cxlm->enabled_cmds))
+		dev_WARN_ONCE(&cxlm->pdev->dev, true, "cmd enabled twice\n");
+}
+
+/**
+ * cxl_walk_cel() - Walk through the Command Effects Log.
+ * @cxlm: Device.
+ * @size: Length of the Command Effects Log.
+ * @cel: CEL
+ *
+ * Iterate over each entry in the CEL and determine if the driver supports the
+ * command. If so, the command is enabled for the device and can be used later.
+ */
+static void cxl_walk_cel(struct cxl_mem *cxlm, size_t size, u8 *cel)
+{
+	struct cel_entry {
+		__le16 opcode;
+		__le16 effect;
+	} *cel_entry;
+	const int cel_entries = size / sizeof(*cel_entry);
+	int i;
+
+	cel_entry = (struct cel_entry *)cel;
+
+	for (i = 0; i < cel_entries; i++) {
+		const struct cel_entry *ce = &cel_entry[i];
+		const struct cxl_mem_command *cmd =
+			cxl_mem_find_command(le16_to_cpu(ce->opcode));
+
+		if (!cmd) {
+			dev_dbg(&cxlm->pdev->dev, "Unsupported opcode 0x%04x",
+				le16_to_cpu(ce->opcode));
+			continue;
+		}
+
+		cxl_enable_cmd(cxlm, cmd);
+	}
+}
+
+/**
+ * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
+ * @cxlm: The device.
+ *
+ * Returns 0 if enumerate completed successfully.
+ *
+ * CXL devices have optional support for certain commands. This function will
+ * determine the set of supported commands for the hardware and update the
+ * enabled_cmds bitmap in the @cxlm.
+ */
+static int cxl_mem_enumerate_cmds(struct cxl_mem *cxlm)
+{
+	struct device *dev = &cxlm->pdev->dev;
+	struct cxl_mbox_get_supported_logs {
+		__le16 entries;
+		u8 rsvd[6];
+		struct gsl_entry {
+			uuid_t uuid;
+			__le32 size;
+		} __packed entry[2];
+	} __packed gsl;
+	struct mbox_cmd mbox_cmd = {
+		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
+		.payload_out = &gsl,
+		.size_in = 0,
+	};
+	int i, rc;
+
+	rc = cxl_mem_mbox_get(cxlm);
+	if (rc)
+		return rc;
+
+	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
+	if (rc)
+		goto out;
+
+	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	if (mbox_cmd.size_out > sizeof(gsl)) {
+		dev_warn(dev, "%zu excess logs\n",
+			 (mbox_cmd.size_out - sizeof(gsl)) /
+				 sizeof(struct gsl_entry));
+	}
+
+	for (i = 0; i < le16_to_cpu(gsl.entries); i++) {
+		u32 size = le32_to_cpu(gsl.entry[i].size);
+		uuid_t uuid = gsl.entry[i].uuid;
+		u8 *log;
+
+		dev_dbg(dev, "Found LOG type %pU of size %d", &uuid, size);
+
+		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
+			continue;
+
+		/*
+		 * It's a hardware bug if the log size is less than the input
+		 * payload size because there are many mandatory commands.
+		 */
+		if (sizeof(struct cxl_mbox_get_log) > size) {
+			dev_err(dev, "CEL log size reported was too small (%d)",
+				size);
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		log = kvmalloc(size, GFP_KERNEL);
+		if (!log) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		rc = cxl_xfer_log(cxlm, &uuid, size, log);
+		if (rc) {
+			kvfree(log);
+			goto out;
+		}
+
+		cxl_walk_cel(cxlm, size, log);
+		kvfree(log);
+	}
+
+out:
+	cxl_mem_mbox_put(cxlm);
+	return rc;
+}
+
 /**
  * cxl_mem_identify() - Send the IDENTIFY command to the device.
  * @cxlm: The device to identify.
@@ -1211,6 +1423,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_mem_enumerate_cmds(cxlm);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_identify(cxlm);
 	if (rc)
 		return rc;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 72d1eb601a5d..c5e75b9dad9d 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -23,6 +23,7 @@
 	___C(INVALID, "Invalid Command"),                                 \
 	___C(IDENTIFY, "Identify Command"),                               \
 	___C(RAW, "Raw device command"),                                  \
+	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
 	___C(MAX, "Last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
