Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E88F3090ED
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 Jan 2021 01:25:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9E252100EAB1C;
	Fri, 29 Jan 2021 16:24:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7A64F100EB333
	for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 16:24:50 -0800 (PST)
IronPort-SDR: v9z/gOTvuNS76gzfVGL2ZAmaioh8+vwSmIpSiHc/TBbIO5edD0sgRE3ORkgz2n+yP5yCp6x9zF
 XS0balXq0h/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="265333152"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="265333152"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:50 -0800
IronPort-SDR: A9HGS754vvABaaZIIWeuOLDVOBjoOAw903l6VTB2PDpiL6D47P9QfC9F/4zd528n38qzlaRcGv
 rDJQm1dqz96w==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="370591688"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:49 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH 09/14] cxl/mem: Add a "RAW" send command
Date: Fri, 29 Jan 2021 16:24:33 -0800
Message-Id: <20210130002438.1872527-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002438.1872527-1-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: B5SXXXFEUGX3H373NEMPTGJ6X33UU4AX
X-Message-ID-Hash: B5SXXXFEUGX3H373NEMPTGJ6X33UU4AX
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B5SXXXFEUGX3H373NEMPTGJ6X33UU4AX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The CXL memory device send interface will have a number of supported
commands. The raw command is not such a command. Raw commands allow
userspace to send a specified opcode to the underlying hardware and
bypass all driver checks on the command. This is useful for a couple of
usecases, mainly:
1. Undocumented vendor specific hardware commands
2. Prototyping new hardware commands not yet supported by the driver

While this all sounds very powerful it comes with a couple of caveats:
1. Bug reports using raw commands will not get the same level of
   attention as bug reports using supported commands (via taint).
2. Supported commands will be rejected by the RAW command.

With this comes new debugfs knob to allow full access to your toes with
your weapon of choice.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/ABI/testing/debugfs-cxl |  10 ++
 drivers/cxl/mem.c                     | 130 ++++++++++++++++++++++++--
 include/uapi/linux/cxl_mem.h          |  12 ++-
 3 files changed, 142 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cxl

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
new file mode 100644
index 000000000000..37e89aaac296
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -0,0 +1,10 @@
+What:		/sys/kernel/debug/cxl/mbox/raw_allow_all
+Date:		January 2021
+KernelVersion:	5.12
+Description:
+		Permits "RAW" mailbox commands to be passed through to hardware
+		without driver intervention. Many such commands require
+		coordination and therefore should only be used for debugging or
+		testing.
+
+		Valid values are boolean.
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c646f0a1cf66..2942730dc967 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <uapi/linux/cxl_mem.h>
+#include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/cdev.h>
@@ -40,7 +41,14 @@
 
 enum opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
+#define CXL_MBOX_OP_RAW		CXL_MBOX_OP_INVALID
+	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
+	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
+	CXL_MBOX_OP_SET_LSA		= 0x4103,
+	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
+	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
+	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
@@ -90,6 +98,8 @@ struct cxl_memdev {
 
 static int cxl_mem_major;
 static DEFINE_IDA(cxl_memdev_ida);
+static struct dentry *cxl_debugfs;
+static bool raw_allow_all;
 
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
@@ -139,6 +149,47 @@ struct cxl_mem_command {
 static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(INVALID, KERNEL, 0, 0, HIDDEN),
 	CXL_CMD(IDENTIFY, NONE, 0, 0x43, MANDATORY),
+	CXL_CMD(RAW, NONE, ~0, ~0, MANDATORY),
+};
+
+/*
+ * Commands that RAW doesn't permit. The rationale for each:
+ *
+ * CXL_MBOX_OP_ACTIVATE_FW: Firmware activation requires adjustment /
+ * coordination of transaction timeout values at the root bridge level.
+ *
+ * CXL_MBOX_OP_SET_PARTITION_INFO: The device memory map may change live
+ * and needs to be coordinated with HDM updates.
+ *
+ * CXL_MBOX_OP_SET_LSA: The label storage area may be cached by the
+ * driver and any writes from userspace invalidates those contents.
+ *
+ * CXL_MBOX_OP_SET_SHUTDOWN_STATE: Set shutdown state assumes no writes
+ * to the device after it is marked clean, userspace can not make that
+ * assertion.
+ *
+ * CXL_MBOX_OP_[GET_]SCAN_MEDIA: The kernel provides a native error list that
+ * is kept up to date with patrol notifications and error management.
+ */
+static u16 disabled_raw_commands[] = {
+	CXL_MBOX_OP_ACTIVATE_FW,
+	CXL_MBOX_OP_SET_PARTITION_INFO,
+	CXL_MBOX_OP_SET_LSA,
+	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
+	CXL_MBOX_OP_SCAN_MEDIA,
+	CXL_MBOX_OP_GET_SCAN_MEDIA,
+};
+
+/*
+ * Command sets that RAW doesn't permit. All opcodes in this set are
+ * disabled because they pass plain text security payloads over the
+ * user/kernel boundary. This functionality is intended to be wrapped
+ * behind the keys ABI which allows for encrypted payloads in the UAPI
+ */
+static u8 security_command_sets[] = {
+	0x44, /* Sanitize */
+	0x45, /* Persistent Memory Data-at-rest Security */
+	0x46, /* Security Passthrough */
 };
 
 #define cxl_for_each_cmd(cmd)                                                  \
@@ -180,22 +231,30 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
 	return 0;
 }
 
+static bool is_security_command(u16 opcode)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(security_command_sets); i++)
+		if (security_command_sets[i] == (opcode >> 8))
+			return true;
+	return false;
+}
+
 static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
 				 struct mbox_cmd *mbox_cmd)
 {
-	dev_warn(&cxlm->pdev->dev, "Mailbox command timed out\n");
-	dev_info(&cxlm->pdev->dev,
-		 "\topcode: 0x%04x\n"
-		 "\tpayload size: %zub\n",
-		 mbox_cmd->opcode, mbox_cmd->size_in);
+	struct device *dev = &cxlm->pdev->dev;
+
+	dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
+		mbox_cmd->opcode, mbox_cmd->size_in);
 
-	if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
+	if (!is_security_command(mbox_cmd->opcode) ||
+	    IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
 		print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
 				     mbox_cmd->payload_in, mbox_cmd->size_in,
 				     true);
 	}
-
-	/* Here's a good place to figure out if a device reset is needed */
 }
 
 /**
@@ -458,6 +517,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
 					struct cxl_send_command __user *u)
 {
 	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct device *dev = &cxlmd->dev;
 	struct mbox_cmd mbox_cmd = {
 		.opcode = cmd->opcode,
 		.payload_in = NULL, /* Populated with copy_from_user() */
@@ -495,13 +555,17 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
 	if (rc)
 		goto out;
 
-	dev_dbg(&cxlmd->dev,
+	dev_dbg(dev,
 		"Submitting %s command for user\n"
 		"\topcode: %x\n"
 		"\tsize: %ub\n",
 		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
 		cmd->info.size_in);
 
+	WARN_TAINT_ONCE(cmd->info.id == CXL_MEM_COMMAND_ID_RAW,
+			TAINT_RAW_PASSTHROUGH, "%s %s: raw command path used\n",
+			dev_driver_string(dev), dev_name(dev));
+
 	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
 	cxl_mem_mbox_put(cxlm);
 	if (rc)
@@ -532,6 +596,23 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
 	return rc;
 }
 
+static bool cxl_mem_raw_command_allowed(u16 opcode)
+{
+	int i;
+
+	if (raw_allow_all)
+		return true;
+
+	if (is_security_command(opcode))
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(disabled_raw_commands); i++)
+		if (disabled_raw_commands[i] == opcode)
+			return false;
+
+	return true;
+}
+
 /**
  * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
  * @cxlm: &struct cxl_mem device whose mailbox will be used.
@@ -568,6 +649,30 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
 	if (send_cmd->size_in > cxlm->mbox.payload_size)
 		return -EINVAL;
 
+	/* Checks are bypassed for raw commands but along comes the taint! */
+	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW) {
+		const struct cxl_mem_command temp = {
+			.info = {
+				.id = CXL_MEM_COMMAND_ID_RAW,
+				.flags = CXL_MEM_COMMAND_FLAG_NONE,
+				.size_in = send_cmd->size_in,
+				.size_out = send_cmd->size_out,
+			},
+			.flags = 0,
+			.opcode = send_cmd->raw.opcode
+		};
+
+		if (send_cmd->raw.rsvd)
+			return -EINVAL;
+
+		if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
+			return -EPERM;
+
+		memcpy(out_cmd, &temp, sizeof(temp));
+
+		return 0;
+	}
+
 	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
 		return -EINVAL;
 
@@ -1200,6 +1305,7 @@ static __init int cxl_mem_init(void)
 {
 	int rc;
 	dev_t devt;
+	struct dentry *mbox_debugfs;
 
 	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
 	if (rc)
@@ -1214,11 +1320,17 @@ static __init int cxl_mem_init(void)
 		return rc;
 	}
 
+	cxl_debugfs = debugfs_create_dir("cxl", NULL);
+	mbox_debugfs = debugfs_create_dir("mbox", cxl_debugfs);
+	debugfs_create_bool("raw_allow_all", 0600, mbox_debugfs,
+			    &raw_allow_all);
+
 	return 0;
 }
 
 static __exit void cxl_mem_exit(void)
 {
+	debugfs_remove_recursive(cxl_debugfs);
 	pci_unregister_driver(&cxl_mem_driver);
 	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
 }
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 9d865794a420..25bfcb071c1f 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -33,6 +33,7 @@ extern "C" {
 #define CXL_CMDS                                                          \
 	___C(INVALID, "Invalid Command"),                                 \
 	___C(IDENTIFY, "Identify Command"),                               \
+	___C(RAW, "Raw device command"),                                  \
 	___C(MAX, "Last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
@@ -124,6 +125,9 @@ struct cxl_mem_query_commands {
  * @id: The command to send to the memory device. This must be one of the
  *	commands returned by the query command.
  * @flags: Flags for the command (input).
+ * @raw: Special fields for raw commands
+ * @raw.opcode: Opcode passed to hardware when using the RAW command.
+ * @raw.rsvd: Must be zero.
  * @rsvd: Must be zero.
  * @retval: Return value from the memory device (output).
  * @size_in: Size of the payload to provide to the device (input).
@@ -143,7 +147,13 @@ struct cxl_mem_query_commands {
 struct cxl_send_command {
 	__u32 id;
 	__u32 flags;
-	__u32 rsvd;
+	union {
+		struct {
+			__u16 opcode;
+			__u16 rsvd;
+		} raw;
+		__u32 rsvd;
+	};
 	__u32 retval;
 
 	struct {
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
