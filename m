Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B863090EF
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 Jan 2021 01:25:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF621100EA908;
	Fri, 29 Jan 2021 16:24:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F3966100EAB6C
	for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 16:24:52 -0800 (PST)
IronPort-SDR: 2FWjxygWohuMx8Qt4C/2VF0gcay6QVoS35WO1K+zOEM2B24k0GIOpPB675HxzcGoqIPcC4ZT5t
 C+6qFglt4Mew==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="265333162"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="265333162"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:52 -0800
IronPort-SDR: m+agbHkW8fs1dKBpQYdREFMgvu8mFAaICCta1fOva6qKbPPaVFm0kZrmUqu/xkqWVffKml3PeO
 Q3p52NBxHCig==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="370591698"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:50 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH 11/14] cxl/mem: Use CEL for enabling commands
Date: Fri, 29 Jan 2021 16:24:35 -0800
Message-Id: <20210130002438.1872527-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002438.1872527-1-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: UDOHHBHD7R6APEKLJDHO5A7TFWVJFH4D
X-Message-ID-Hash: UDOHHBHD7R6APEKLJDHO5A7TFWVJFH4D
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UDOHHBHD7R6APEKLJDHO5A7TFWVJFH4D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Command Effects Log (CEL) is specified in the CXL 2.0 specification.
The CEL is one of two types of logs, the other being vendor specific.
They are distinguished in hardware/spec via UUID. The CEL is immediately
useful for 2 things:
1. Determine which optional commands are supported by the CXL device.
2. Enumerate any vendor specific commands

The CEL can be used by the driver to determine which commands are
available in the hardware (though it isn't, yet). That set of commands
might itself be a subset of commands which are available to be used via
CXL_MEM_SEND_COMMAND IOCTL.

Prior to this, all commands that the driver exposed were explicitly
enabled. After this, only those commands that are found in the CEL are
enabled.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c            | 186 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/cxl_mem.h |   1 +
 2 files changed, 182 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index d01c6ee32a6b..787417c4d5dc 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -43,6 +43,8 @@ enum opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 #define CXL_MBOX_OP_RAW		CXL_MBOX_OP_INVALID
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
+	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
+	CXL_MBOX_OP_GET_LOG		= 0x0401,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
 	CXL_MBOX_OP_SET_LSA		= 0x4103,
@@ -101,6 +103,18 @@ static DEFINE_IDA(cxl_memdev_ida);
 static struct dentry *cxl_debugfs;
 static bool raw_allow_all;
 
+enum {
+	CEL_UUID,
+	DEBUG_UUID
+};
+
+static const uuid_t log_uuid[] = {
+	[CEL_UUID] = UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96,
+			       0xb1, 0x62, 0x3b, 0x3f, 0x17),
+	[DEBUG_UUID] = UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6,
+				 0x07, 0x19, 0x40, 0x3d, 0x86)
+};
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
@@ -153,6 +167,7 @@ static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(INVALID, KERNEL, 0, 0, HIDDEN),
 	CXL_CMD(IDENTIFY, NONE, 0, 0x43, MANDATORY),
 	CXL_CMD(RAW, NONE, ~0, ~0, PSEUDO),
+	CXL_CMD(GET_SUPPORTED_LOGS, NONE, 0, ~0, MANDATORY),
 };
 
 /*
@@ -1168,6 +1183,101 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	return rc;
 }
 
+struct cxl_mbox_get_supported_logs {
+	__le16 entries;
+	u8 rsvd[6];
+	struct gsl_entry {
+		uuid_t uuid;
+		__le32 size;
+	} __packed entry[2];
+} __packed;
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
+		u32 xfer_size = min_t(u32, remaining, cxlm->mbox.payload_size);
+		struct mbox_cmd mbox_cmd;
+		int rc;
+		struct cxl_mbox_get_log log = {
+			.uuid = *uuid,
+			.offset = cpu_to_le32(offset),
+			.length = cpu_to_le32(xfer_size)
+		};
+
+		mbox_cmd = (struct mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_LOG,
+			.payload_in = &log,
+			.payload_out = out,
+			.size_in = sizeof(log),
+		};
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
+static void cxl_enable_cmd(struct cxl_mem *cxlm,
+			   const struct cxl_mem_command *cmd)
+{
+	if (test_and_set_bit(cmd->info.id, cxlm->enabled_cmds))
+		dev_warn(&cxlm->pdev->dev, "Command enabled twice\n");
+
+	dev_info(&cxlm->pdev->dev, "%s enabled",
+		 cxl_command_names[cmd->info.id].name);
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
 /**
  * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
  * @cxlm: The device.
@@ -1180,19 +1290,85 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
  */
 static int cxl_mem_enumerate_cmds(struct cxl_mem *cxlm)
 {
-	struct cxl_mem_command *c;
+	struct cxl_mbox_get_supported_logs gsl;
+	const struct cxl_mem_command *c;
+	struct mbox_cmd mbox_cmd;
+	int i, rc;
 
 	BUILD_BUG_ON(ARRAY_SIZE(mem_commands) >= CXL_MAX_COMMANDS);
 
-	/* All commands are considered enabled for now (except INVALID). */
+	/* Pseudo commands are always enabled */
 	cxl_for_each_cmd(c) {
-		if (c->flags & CXL_CMD_INTERNAL_FLAG_HIDDEN)
+		if (c->flags & CXL_CMD_INTERNAL_FLAG_PSEUDO)
+			cxl_enable_cmd(cxlm, c);
+	}
+
+	mbox_cmd = (struct mbox_cmd){
+		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
+		.payload_out = &gsl,
+		.size_in = 0,
+	};
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
+		dev_warn(&cxlm->pdev->dev, "%zu excess logs\n",
+			 (mbox_cmd.size_out - sizeof(gsl)) /
+				 sizeof(struct gsl_entry));
+	}
+
+	for (i = 0; i < le16_to_cpu(gsl.entries); i++) {
+		u32 size = le32_to_cpu(gsl.entry[i].size);
+		uuid_t uuid = gsl.entry[i].uuid;
+		u8 *log;
+
+		dev_dbg(&cxlm->pdev->dev, "Found LOG type %pU of size %d",
+			&uuid, size);
+
+		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
 			continue;
 
-		set_bit(c->info.id, cxlm->enabled_cmds);
+		/*
+		 * It's a hardware bug if the log size is less than the input
+		 * payload size because there are many mandatory commands.
+		 */
+		if (sizeof(struct cxl_mbox_get_log) > size) {
+			dev_err(&cxlm->pdev->dev,
+				"CEL log size reported was too small (%d)",
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
+		if (rc)
+			goto out;
+
+		cxl_walk_cel(cxlm, size, log);
+
+		kvfree(log);
 	}
 
-	return 0;
+out:
+	cxl_mem_mbox_put(cxlm);
+	return rc;
 }
 
 /**
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 25bfcb071c1f..64cb9753a077 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -34,6 +34,7 @@ extern "C" {
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
