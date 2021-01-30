Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F09E3090EB
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 Jan 2021 01:25:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2DF71100EAB16;
	Fri, 29 Jan 2021 16:24:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E2461100ED4A7
	for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 16:24:48 -0800 (PST)
IronPort-SDR: SE3TtXTccupUdJj3R9fmWw0PmB5UeI7e8fglC3jJbf31ttRLSdCaZUSn7yV6T0sTsRmqslAtAa
 gknK8r3ByfvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="265333143"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="265333143"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:48 -0800
IronPort-SDR: uddJezV4j4+/KYTSlrQGmcVKaRW0nX0miMzPqUrWk+tSlYehaPZAow6Xp4QNZ3em2SNgo1DdTJ
 tdumwq7kmeWw==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="370591672"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:48 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH 06/14] cxl/mem: Add basic IOCTL interface
Date: Fri, 29 Jan 2021 16:24:30 -0800
Message-Id: <20210130002438.1872527-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002438.1872527-1-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: G2BQNEYSE524KPCSZEN4BIQBJFRRQL5C
X-Message-ID-Hash: G2BQNEYSE524KPCSZEN4BIQBJFRRQL5C
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, kernel test robot <lkp@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G2BQNEYSE524KPCSZEN4BIQBJFRRQL5C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a straightforward IOCTL that provides a mechanism for userspace to
query the supported memory device commands. CXL commands as they appear
to userspace are described as part of the UAPI kerneldoc. The command
list returned via this IOCTL will contain the full set of commands that
the driver supports, however, some of those commands may not be
available for use by userspace.

Memory device commands are specified in 8.2.9 of the CXL 2.0
specification. They are submitted through a mailbox mechanism specified
in 8.2.8.4.

Reported-by: kernel test robot <lkp@intel.com> # bug in earlier revision
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .clang-format                                 |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/cxl/mem.c                             | 152 +++++++++++++++++-
 include/uapi/linux/cxl_mem.h                  | 119 ++++++++++++++
 4 files changed, 271 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/cxl_mem.h

diff --git a/.clang-format b/.clang-format
index 10dc5a9a61b3..3f11c8901b43 100644
--- a/.clang-format
+++ b/.clang-format
@@ -109,6 +109,7 @@ ForEachMacros:
   - 'css_for_each_child'
   - 'css_for_each_descendant_post'
   - 'css_for_each_descendant_pre'
+  - 'cxl_for_each_cmd'
   - 'device_for_each_child_node'
   - 'dma_fence_chain_for_each'
   - 'do_for_each_ftrace_op'
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a4c75a28c839..6eb8e634664d 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -352,6 +352,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:michael.klein@puffin.lb.shuttle.de>
 0xCC  00-0F  drivers/misc/ibmvmc.h                                   pseries VMC driver
 0xCD  01     linux/reiserfs_fs.h
+0xCE  01-02  uapi/linux/cxl_mem.h                                    Compute Express Link Memory Devices
 0xCF  02     fs/cifs/ioctl.c
 0xDB  00-0F  drivers/char/mwave/mwavepub.h
 0xDD  00-3F                                                          ZFCP device driver see drivers/s390/scsi/
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index f1f5c765623f..3c3ff45f01c0 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <uapi/linux/cxl_mem.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/cdev.h>
@@ -38,6 +39,7 @@
 #define CXL_MAILBOX_TIMEOUT_US 2000
 
 enum opcode {
+	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
@@ -89,6 +91,72 @@ struct cxl_memdev {
 static int cxl_mem_major;
 static DEFINE_IDA(cxl_memdev_ida);
 
+/**
+ * struct cxl_mem_command - Driver representation of a memory device command
+ * @info: Command information as it exists for the UAPI
+ * @opcode: The actual bits used for the mailbox protocol
+ * @flags: Set of flags reflecting the state of the command.
+ *
+ *  * %CXL_CMD_INTERNAL_FLAG_HIDDEN: Command is hidden from userspace. This
+ *    would typically be used for deprecated commands.
+ *  * %CXL_CMD_FLAG_MANDATORY: Hardware must support this command. This flag is
+ *    only used internally by the driver for sanity checking.
+ *
+ * The cxl_mem_command is the driver's internal representation of commands that
+ * are supported by the driver. Some of these commands may not be supported by
+ * the hardware. The driver will use @info to validate the fields passed in by
+ * the user then submit the @opcode to the hardware.
+ *
+ * See struct cxl_command_info.
+ */
+struct cxl_mem_command {
+	const struct cxl_command_info info;
+	enum opcode opcode;
+	u32 flags;
+#define CXL_CMD_INTERNAL_FLAG_NONE 0
+#define CXL_CMD_INTERNAL_FLAG_HIDDEN BIT(0)
+#define CXL_CMD_INTERNAL_FLAG_MANDATORY BIT(1)
+};
+
+#define CXL_CMD(_id, _flags, sin, sout, f)                                     \
+	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
+	.info =	{                                                              \
+			.id = CXL_MEM_COMMAND_ID_##_id,                        \
+			.flags = CXL_MEM_COMMAND_FLAG_##_flags,                \
+			.size_in = sin,                                        \
+			.size_out = sout,                                      \
+		},                                                             \
+		.flags = CXL_CMD_INTERNAL_FLAG_##f,                            \
+		.opcode = CXL_MBOX_OP_##_id,                                   \
+	}
+
+/*
+ * This table defines the supported mailbox commands for the driver. This table
+ * is made up of a UAPI structure. Non-negative values as parameters in the
+ * table will be validated against the user's input. For example, if size_in is
+ * 0, and the user passed in 1, it is an error.
+ */
+static struct cxl_mem_command mem_commands[] = {
+	CXL_CMD(INVALID, KERNEL, 0, 0, HIDDEN),
+	CXL_CMD(IDENTIFY, NONE, 0, 0x43, MANDATORY),
+};
+
+#define cxl_for_each_cmd(cmd)                                                  \
+	for ((cmd) = &mem_commands[0];                                         \
+	     ((cmd) - mem_commands) < ARRAY_SIZE(mem_commands); (cmd)++)
+
+static inline struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
+{
+	struct cxl_mem_command *c;
+
+	cxl_for_each_cmd(c) {
+		if (c->opcode == opcode)
+			return c;
+	}
+
+	return NULL;
+}
+
 static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
 {
 	const int timeout = msecs_to_jiffies(CXL_MAILBOX_TIMEOUT_US);
@@ -155,6 +223,7 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 				 struct mbox_cmd *mbox_cmd)
 {
 	void __iomem *payload = cxlm->mbox.regs + CXLDEV_MB_PAYLOAD_OFFSET;
+	const struct cxl_mem_command *cmd;
 	u64 cmd_reg, status_reg;
 	size_t out_len;
 	int rc;
@@ -179,6 +248,13 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 	 *   make sense).
 	 */
 
+	cmd = cxl_mem_find_command(mbox_cmd->opcode);
+	if (!cmd) {
+		dev_info(&cxlm->pdev->dev,
+			 "Unknown opcode 0x%04x being sent to hardware\n",
+			 mbox_cmd->opcode);
+	}
+
 	/* #1 */
 	if (cxl_doorbell_busy(cxlm)) {
 		dev_err_ratelimited(&cxlm->pdev->dev,
@@ -225,6 +301,19 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 	cmd_reg = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET);
 	out_len = CXL_GET_FIELD(cmd_reg, CXLDEV_MB_CMD_PAYLOAD_LENGTH);
 
+	/*
+	 * If the command had a fixed size output, but the hardware did
+	 * something unexpected, just print an error and move on. It would be
+	 * worth sending a bug report.
+	 */
+	if (cmd && cmd->info.size_out >= 0 && out_len != cmd->info.size_out) {
+		bool too_big = out_len > cmd->info.size_out;
+
+		dev_err(&cxlm->pdev->dev,
+			"payload was %s than driver expectations\n",
+			too_big ? "larger" : "smaller");
+	}
+
 	/* #8 */
 	if (out_len && mbox_cmd->payload_out)
 		memcpy_fromio(mbox_cmd->payload_out, payload, out_len);
@@ -326,16 +415,75 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int cxl_mem_count_commands(void)
+{
+	struct cxl_mem_command *c;
+	int n = 0;
+
+	cxl_for_each_cmd(c) {
+		if (c->flags & CXL_CMD_INTERNAL_FLAG_HIDDEN)
+			continue;
+		n++;
+	}
+
+	return n;
+}
+
+static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
+			       unsigned long arg)
+{
+	struct device *dev = &cxlmd->dev;
+
+	if (cmd == CXL_MEM_QUERY_COMMANDS) {
+		struct cxl_mem_query_commands __user *q = (void __user *)arg;
+		struct cxl_mem_command *cmd;
+		u32 n_commands;
+		int j = 0;
+
+		dev_dbg(dev, "Query IOCTL\n");
+
+		if (get_user(n_commands, &q->n_commands))
+			return -EFAULT;
+
+		/* returns the total number if 0 elements are requested. */
+		if (n_commands == 0)
+			return put_user(cxl_mem_count_commands(),
+					&q->n_commands);
+
+		/*
+		 * otherwise, return max(n_commands, total commands)
+		 * cxl_command_info structures.
+		 */
+		cxl_for_each_cmd(cmd) {
+			const struct cxl_command_info *info = &cmd->info;
+
+			if (cmd->flags & CXL_CMD_INTERNAL_FLAG_HIDDEN)
+				continue;
+
+			if (copy_to_user(&q->commands[j++], info,
+					 sizeof(*info)))
+				return -EFAULT;
+
+			if (j == n_commands)
+				break;
+		}
+
+		return 0;
+	}
+
+	return -ENOTTY;
+}
+
 static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
 	struct cxl_memdev *cxlmd = file->private_data;
-	int rc = -ENOTTY;
+	int rc;
 
 	if (!percpu_ref_tryget_live(&cxlmd->ops_active))
 		return -ENXIO;
 
-	/* TODO: ioctl body */
+	rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
 
 	percpu_ref_put(&cxlmd->ops_active);
 
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
new file mode 100644
index 000000000000..70e3ba2fa008
--- /dev/null
+++ b/include/uapi/linux/cxl_mem.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * CXL IOCTLs for Memory Devices
+ */
+
+#ifndef _UAPI_CXL_MEM_H_
+#define _UAPI_CXL_MEM_H_
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#include <linux/types.h>
+
+/**
+ * DOC: UAPI
+ *
+ * CXL memory devices expose UAPI to have a standard user interface.
+ * Userspace can refer to these structure definitions and UAPI formats
+ * to communicate to driver. The commands themselves are somewhat obfuscated
+ * with macro magic. They have the form CXL_MEM_COMMAND_ID_<name>.
+ *
+ * For example "CXL_MEM_COMMAND_ID_INVALID"
+ *
+ * Not all of all commands that the driver supports are always available for use
+ * by userspace. Userspace must check the results from the QUERY command in
+ * order to determine the live set of commands.
+ */
+
+#define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
+
+#define CXL_CMDS                                                          \
+	___C(INVALID, "Invalid Command"),                                 \
+	___C(IDENTIFY, "Identify Command"),                               \
+	___C(MAX, "Last command")
+
+#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
+enum { CXL_CMDS };
+
+#undef ___C
+
+/**
+ * struct cxl_command_info - Command information returned from a query.
+ * @id: ID number for the command.
+ * @flags: Flags that specify command behavior.
+ *
+ *  * %CXL_MEM_COMMAND_FLAG_KERNEL: This command is reserved for exclusive
+ *    kernel use.
+ *  * %CXL_MEM_COMMAND_FLAG_MUTEX: This command may require coordination with
+ *    the kernel in order to complete successfully.
+ *
+ * @size_in: Expected input size, or -1 if variable length.
+ * @size_out: Expected output size, or -1 if variable length.
+ *
+ * Represents a single command that is supported by both the driver and the
+ * hardware. This is returned as part of an array from the query ioctl. The
+ * following would be a command named "foobar" that takes a variable length
+ * input and returns 0 bytes of output.
+ *
+ *  - @id = 10
+ *  - @flags = CXL_MEM_COMMAND_FLAG_MUTEX
+ *  - @size_in = -1
+ *  - @size_out = 0
+ *
+ * See struct cxl_mem_query_commands.
+ */
+struct cxl_command_info {
+	__u32 id;
+
+	__u32 flags;
+#define CXL_MEM_COMMAND_FLAG_NONE 0
+#define CXL_MEM_COMMAND_FLAG_KERNEL BIT(0)
+#define CXL_MEM_COMMAND_FLAG_MUTEX BIT(1)
+
+	__s32 size_in;
+	__s32 size_out;
+};
+
+/**
+ * struct cxl_mem_query_commands - Query supported commands.
+ * @n_commands: In/out parameter. When @n_commands is > 0, the driver will
+ *		return min(num_support_commands, n_commands). When @n_commands
+ *		is 0, driver will return the number of total supported commands.
+ * @rsvd: Reserved for future use.
+ * @commands: Output array of supported commands. This array must be allocated
+ *            by userspace to be at least min(num_support_commands, @n_commands)
+ *
+ * Allow userspace to query the available commands supported by both the driver,
+ * and the hardware. Commands that aren't supported by either the driver, or the
+ * hardware are not returned in the query.
+ *
+ * Examples:
+ *
+ *  - { .n_commands = 0 } // Get number of supported commands
+ *  - { .n_commands = 15, .commands = buf } // Return first 15 (or less)
+ *    supported commands
+ *
+ *  See struct cxl_command_info.
+ */
+struct cxl_mem_query_commands {
+	/*
+	 * Input: Number of commands to return (space allocated by user)
+	 * Output: Number of commands supported by the driver/hardware
+	 *
+	 * If n_commands is 0, kernel will only return number of commands and
+	 * not try to populate commands[], thus allowing userspace to know how
+	 * much space to allocate
+	 */
+	__u32 n_commands;
+	__u32 rsvd;
+
+	struct cxl_command_info __user commands[]; /* out: supported commands */
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
