Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8BB315A80
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 01:03:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 438FF100EAB14;
	Tue,  9 Feb 2021 16:03:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F2BCD100F2250
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 16:03:26 -0800 (PST)
IronPort-SDR: CR6lP8PVyRpvSBX3PrdfxL0OYFgjp1Sr9SGXAIkpTtapyMaEDZ/3fGb4VFHkyc4tdNUjNZcqUj
 uzGRU+qBVnjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="201079166"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400";
   d="scan'208";a="201079166"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:03:18 -0800
IronPort-SDR: dg037NpmuxtOgicN3cVT5R7H2KEoYJuj2CUmzkz1Lbrd1MtOySRNFfbj0lIrDPZ2Su0tDp6DGW
 UFcLtdC9KFAg==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400";
   d="scan'208";a="419865872"
Received: from sitira7x-mobl1.gar.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:03:17 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v2 7/8] cxl/mem: Add set of informational commands
Date: Tue,  9 Feb 2021 16:02:58 -0800
Message-Id: <20210210000259.635748-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210000259.635748-1-ben.widawsky@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: CDUXPU5TG5SIUIOTBS5T62INMELJEWMI
X-Message-ID-Hash: CDUXPU5TG5SIUIOTBS5T62INMELJEWMI
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CDUXPU5TG5SIUIOTBS5T62INMELJEWMI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add initial set of formal commands beyond basic identify and command
enumeration.

Of special note is the Get Log Command which is only specified to return
2 log types, CEL and VENDOR_DEBUG. Given that VENDOR_DEBUG is already a
large catch all for vendor specific information there is no known reason
for devices to be implementing other log types. Unknown log types are
included in the "vendor passthrough shenanigans" safety regime like raw
commands and blocked by default.

Up to this point there has been no reason to inspect payload data.
Given the need to check the log type add a new "validate_payload"
operation to define a generic mechanism to restrict / filter commands.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c            | 55 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/cxl_mem.h |  5 ++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index e9aa6ca18d99..e8cc076b9f1b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -44,12 +44,16 @@
 enum opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
+	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
+	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
+	CXL_MBOX_OP_GET_LSA		= 0x4102,
 	CXL_MBOX_OP_SET_LSA		= 0x4103,
+	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
 	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
@@ -118,6 +122,9 @@ static const uuid_t log_uuid[] = {
 					0xd6, 0x07, 0x19, 0x40, 0x3d, 0x86)
 };
 
+static int validate_log_uuid(struct cxl_mem *cxlm, void __user *payload,
+			     size_t size);
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
@@ -129,6 +136,10 @@ static const uuid_t log_uuid[] = {
  *  * %CXL_CMD_INTERNAL_FLAG_PSEUDO: This is a pseudo command which doesn't have
  *    a direct mapping to hardware. They are implicitly always enabled.
  *
+ * @validate_payload: A function called after the command is validated but
+ * before it's sent to the hardware. The primary purpose is to validate, or
+ * fixup the actual payload.
+ *
  * The cxl_mem_command is the driver's internal representation of commands that
  * are supported by the driver. Some of these commands may not be supported by
  * the hardware. The driver will use @info to validate the fields passed in by
@@ -139,9 +150,12 @@ static const uuid_t log_uuid[] = {
 struct cxl_mem_command {
 	struct cxl_command_info info;
 	enum opcode opcode;
+
+	int (*validate_payload)(struct cxl_mem *cxlm, void __user *payload,
+				size_t size);
 };
 
-#define CXL_CMD(_id, _flags, sin, sout)                                        \
+#define CXL_CMD_VALIDATE(_id, _flags, sin, sout, v)                            \
 	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
 	.info =	{                                                              \
 			.id = CXL_MEM_COMMAND_ID_##_id,                        \
@@ -150,8 +164,12 @@ struct cxl_mem_command {
 			.size_out = sout,                                      \
 		},                                                             \
 	.opcode = CXL_MBOX_OP_##_id,                                           \
+	.validate_payload = v,                                                 \
 	}
 
+#define CXL_CMD(_id, _flags, sin, sout)                                        \
+	CXL_CMD_VALIDATE(_id, _flags, sin, sout, NULL)
+
 /*
  * This table defines the supported mailbox commands for the driver. This table
  * is made up of a UAPI structure. Non-negative values as parameters in the
@@ -164,6 +182,11 @@ static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(RAW, NONE, ~0, ~0),
 #endif
 	CXL_CMD(GET_SUPPORTED_LOGS, NONE, 0, ~0),
+	CXL_CMD(GET_FW_INFO, NONE, 0, 0x50),
+	CXL_CMD(GET_PARTITION_INFO, NONE, 0, 0x20),
+	CXL_CMD(GET_LSA, NONE, 0x8, ~0),
+	CXL_CMD(GET_HEALTH_INFO, NONE, 0, 0x12),
+	CXL_CMD_VALIDATE(GET_LOG, NONE, 0x18, ~0, validate_log_uuid),
 };
 
 /*
@@ -492,6 +515,14 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
 		mbox_cmd.payload_out = kvzalloc(cxlm->payload_size, GFP_KERNEL);
 
 	if (cmd->info.size_in) {
+		if (cmd->validate_payload) {
+			rc = cmd->validate_payload(cxlm,
+						   u64_to_user_ptr(in_payload),
+						   cmd->info.size_in);
+			if (rc)
+				goto out;
+		}
+
 		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
 		if (!mbox_cmd.payload_in) {
 			rc = -ENOMEM;
@@ -1124,6 +1155,28 @@ struct cxl_mbox_get_log {
 	__le32 length;
 } __packed;
 
+static int validate_log_uuid(struct cxl_mem *cxlm, void __user *input,
+			     size_t size)
+{
+	struct cxl_mbox_get_log __user *get_log = input;
+	uuid_t payload_uuid;
+
+	if (copy_from_user(&payload_uuid, &get_log->uuid, sizeof(uuid_t)))
+		return -EFAULT;
+
+	if (uuid_equal(&payload_uuid, &log_uuid[CEL_UUID]))
+		return 0;
+	if (uuid_equal(&payload_uuid, &log_uuid[VENDOR_DEBUG_UUID]))
+		return 0;
+
+	/* All unspec'd logs shall taint */
+	if (WARN_ONCE(!cxl_mem_raw_command_allowed(CXL_MBOX_OP_RAW),
+		      "Unknown log UUID %pU used\n", &payload_uuid))
+		return -EPERM;
+
+	return 0;
+}
+
 static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size, u8 *out)
 {
 	u32 remaining = size;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c5e75b9dad9d..ba4d3b4d6b7d 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -24,6 +24,11 @@
 	___C(IDENTIFY, "Identify Command"),                               \
 	___C(RAW, "Raw device command"),                                  \
 	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
+	___C(GET_FW_INFO, "Get FW Info"),                                 \
+	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
+	___C(GET_LSA, "Get Label Storage Area"),                          \
+	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
+	___C(GET_LOG, "Get Log"),                                         \
 	___C(MAX, "Last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
