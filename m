Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1993D31C504
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Feb 2021 02:46:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43AA1100EB854;
	Mon, 15 Feb 2021 17:46:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D0688100EBBCE
	for <linux-nvdimm@lists.01.org>; Mon, 15 Feb 2021 17:45:56 -0800 (PST)
IronPort-SDR: O0/JZnheAVMqJO6AI8uzbMqTmF3jnAwIWFZM4GwlbumaWLOucUJzEmFCnfQD/RwVnNcdNh0tiJ
 ZHRvm7Jaqp5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="246852877"
X-IronPort-AV: E=Sophos;i="5.81,182,1610438400";
   d="scan'208";a="246852877"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 17:45:55 -0800
IronPort-SDR: EWHRNwxv44uJIjvl9u/ajqryiVFAIfTeNvyVEO7kib6UHmmqL5+/VhNCr83LL2Ig/7crjnimpG
 YgITVggtz7MA==
X-IronPort-AV: E=Sophos;i="5.81,182,1610438400";
   d="scan'208";a="399296084"
Received: from dlbingha-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.31])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 17:45:55 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v4 4/9] cxl/mem: Add basic IOCTL interface
Date: Mon, 15 Feb 2021 17:45:33 -0800
Message-Id: <20210216014538.268106-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210216014538.268106-1-ben.widawsky@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: GNXU565MBOUB5DX4KURXDJ3NNRI44M2R
X-Message-ID-Hash: GNXU565MBOUB5DX4KURXDJ3NNRI44M2R
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GNXU565MBOUB5DX4KURXDJ3NNRI44M2R/>
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

Memory device commands first appear in the CXL 2.0 specification. They
are submitted through a mailbox mechanism specified in the CXL 2.0
specification.

The send command allows userspace to issue mailbox commands directly to
the hardware. The list of available commands to send are the output of
the query command. The driver verifies basic properties of the command
and possibly inspect the input (or output) payload to determine whether
or not the command is allowed (or might taint the kernel).

Reported-by: kernel test robot <lkp@intel.com> # bug in earlier revision
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)
---
 .clang-format                                 |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/cxl/mem.c                             | 288 +++++++++++++++++-
 include/uapi/linux/cxl_mem.h                  | 154 ++++++++++
 4 files changed, 443 insertions(+), 1 deletion(-)
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
index 410adb1bdffc..a4298cb1182d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <uapi/linux/cxl_mem.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/cdev.h>
@@ -40,6 +41,7 @@
 #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
 
 enum opcode {
+	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
@@ -91,6 +93,49 @@ struct cxl_memdev {
 static int cxl_mem_major;
 static DEFINE_IDA(cxl_memdev_ida);
 
+/**
+ * struct cxl_mem_command - Driver representation of a memory device command
+ * @info: Command information as it exists for the UAPI
+ * @opcode: The actual bits used for the mailbox protocol
+ *
+ * The cxl_mem_command is the driver's internal representation of commands that
+ * are supported by the driver. Some of these commands may not be supported by
+ * the hardware. The driver will use @info to validate the fields passed in by
+ * the user then submit the @opcode to the hardware.
+ *
+ * See struct cxl_command_info.
+ */
+struct cxl_mem_command {
+	struct cxl_command_info info;
+	enum opcode opcode;
+};
+
+#define CXL_CMD(_id, sin, sout)                                                \
+	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
+	.info =	{                                                              \
+			.id = CXL_MEM_COMMAND_ID_##_id,                        \
+			.size_in = sin,                                        \
+			.size_out = sout,                                      \
+		},                                                             \
+	.opcode = CXL_MBOX_OP_##_id,                                           \
+	}
+
+/*
+ * This table defines the supported mailbox commands for the driver. This table
+ * is made up of a UAPI structure. Non-negative values as parameters in the
+ * table will be validated against the user's input. For example, if size_in is
+ * 0, and the user passed in 1, it is an error.
+ */
+static struct cxl_mem_command mem_commands[] = {
+	CXL_CMD(IDENTIFY, 0, 0x43),
+};
+
+#define cxl_for_each_cmd(cmd)                                                  \
+	for ((cmd) = &mem_commands[0];                                         \
+	     ((cmd) - mem_commands) < ARRAY_SIZE(mem_commands); (cmd)++)
+
+#define cxl_cmd_count ARRAY_SIZE(mem_commands)
+
 static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
 {
 	const unsigned long start = jiffies;
@@ -312,6 +357,247 @@ static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
 	mutex_unlock(&cxlm->mbox_mutex);
 }
 
+/**
+ * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
+ * @cxlm: The CXL memory device to communicate with.
+ * @cmd: The validated command.
+ * @in_payload: Pointer to userspace's input payload.
+ * @out_payload: Pointer to userspace's output payload.
+ * @size_out: (Input) Max payload size to copy out.
+ *            (Output) Payload size hardware generated.
+ * @retval: Hardware generated return code from the operation.
+ *
+ * Return:
+ *  * %0	- Mailbox transaction succeeded. This implies the mailbox
+ *  		  protocol completed successfully not that the operation itself
+ *  		  was successful.
+ *  * %-ENOMEM  - Couldn't allocate a bounce buffer.
+ *  * %-EFAULT	- Something happened with copy_to/from_user.
+ *  * %-EINTR	- Mailbox acquisition interrupted.
+ *  * %-*	- Transaction level failures.
+ *
+ * Creates the appropriate mailbox command and dispatches it on behalf of a
+ * userspace request. The input and output payloads are copied between
+ * userspace.
+ *
+ * See cxl_send_cmd().
+ */
+static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
+					const struct cxl_mem_command *cmd,
+					u64 in_payload, u64 out_payload,
+					s32 *size_out, u32 *retval)
+{
+	struct device *dev = &cxlm->pdev->dev;
+	struct mbox_cmd mbox_cmd = {
+		.opcode = cmd->opcode,
+		.size_in = cmd->info.size_in,
+	};
+	int rc;
+
+	if (cmd->info.size_out) {
+		mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
+		if (!mbox_cmd.payload_out)
+			return -ENOMEM;
+	}
+
+	if (cmd->info.size_in) {
+		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
+		if (!mbox_cmd.payload_in) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		if (copy_from_user(mbox_cmd.payload_in,
+				   u64_to_user_ptr(in_payload),
+				   cmd->info.size_in)) {
+			rc = -EFAULT;
+			goto out;
+		}
+	}
+
+	rc = cxl_mem_mbox_get(cxlm);
+	if (rc)
+		goto out;
+
+	dev_dbg(dev,
+		"Submitting %s command for user\n"
+		"\topcode: %x\n"
+		"\tsize: %ub\n",
+		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
+		cmd->info.size_in);
+
+	rc = __cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
+	cxl_mem_mbox_put(cxlm);
+	if (rc)
+		goto out;
+
+	/*
+	 * @size_out contains the max size that's allowed to be written back out
+	 * to userspace. While the payload may have written more output than
+	 * this it will have to be ignored.
+	 */
+	if (mbox_cmd.size_out) {
+		if (copy_to_user(u64_to_user_ptr(out_payload),
+				 mbox_cmd.payload_out, *size_out)) {
+			rc = -EFAULT;
+			goto out;
+		}
+	}
+
+	/*
+	 * Reporting the actual size, even if it was greater than @size_out
+	 * allows userspace to try the command again with a bigger buffer.
+	 */
+	*size_out = mbox_cmd.size_out;
+	*retval = mbox_cmd.return_code;
+
+out:
+	kvfree(mbox_cmd.payload_in);
+	kvfree(mbox_cmd.payload_out);
+	return rc;
+}
+
+/**
+ * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
+ * @cxlm: &struct cxl_mem device whose mailbox will be used.
+ * @send_cmd: &struct cxl_send_command copied in from userspace.
+ * @out_cmd: Sanitized and populated &struct cxl_mem_command.
+ *
+ * Return:
+ *  * %0	- @out_cmd is ready to send.
+ *  * %-ENOTTY	- Invalid command specified.
+ *  * %-EINVAL	- Reserved fields or invalid values were used.
+ *  * %-ENOMEM	- Input or output buffer wasn't sized properly.
+ *
+ * The result of this command is a fully validated command in @out_cmd that is
+ * safe to send to the hardware.
+ *
+ * See handle_mailbox_cmd_from_user()
+ */
+static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
+				      const struct cxl_send_command *send_cmd,
+				      struct cxl_mem_command *out_cmd)
+{
+	const struct cxl_command_info *info;
+	struct cxl_mem_command *c;
+
+	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
+		return -ENOTTY;
+
+	/*
+	 * The user can never specify an input payload larger than what hardware
+	 * supports, but output can be arbitrarily large (simply write out as
+	 * much data as the hardware provides).
+	 */
+	if (send_cmd->in.size > cxlm->payload_size)
+		return -EINVAL;
+
+	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
+		return -EINVAL;
+
+	if (send_cmd->rsvd)
+		return -EINVAL;
+
+	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
+		return -EINVAL;
+
+	/* Convert user's command into the internal representation */
+	c = &mem_commands[send_cmd->id];
+	info = &c->info;
+
+	/* Check the input buffer is the expected size */
+	if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
+		return -ENOMEM;
+
+	/* Check the output buffer is at least large enough */
+	if (info->size_out >= 0 && send_cmd->out.size < info->size_out)
+		return -ENOMEM;
+
+	memcpy(out_cmd, c, sizeof(*c));
+	out_cmd->info.size_in = send_cmd->in.size;
+	out_cmd->info.size_out = send_cmd->out.size;
+
+	return 0;
+}
+
+static int cxl_query_cmd(struct cxl_memdev *cxlmd,
+			 struct cxl_mem_query_commands __user *q)
+{
+	struct device *dev = &cxlmd->dev;
+	struct cxl_mem_command *cmd;
+	u32 n_commands;
+	int j = 0;
+
+	dev_dbg(dev, "Query IOCTL\n");
+
+	if (get_user(n_commands, &q->n_commands))
+		return -EFAULT;
+
+	/* returns the total number if 0 elements are requested. */
+	if (n_commands == 0)
+		return put_user(cxl_cmd_count, &q->n_commands);
+
+	/*
+	 * otherwise, return max(n_commands, total commands) cxl_command_info
+	 * structures.
+	 */
+	cxl_for_each_cmd(cmd) {
+		const struct cxl_command_info *info = &cmd->info;
+
+		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
+			return -EFAULT;
+
+		if (j == n_commands)
+			break;
+	}
+
+	return 0;
+}
+
+static int cxl_send_cmd(struct cxl_memdev *cxlmd,
+			struct cxl_send_command __user *s)
+{
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct device *dev = &cxlmd->dev;
+	struct cxl_send_command send;
+	struct cxl_mem_command c;
+	int rc;
+
+	dev_dbg(dev, "Send IOCTL\n");
+
+	if (copy_from_user(&send, s, sizeof(send)))
+		return -EFAULT;
+
+	rc = cxl_validate_cmd_from_user(cxlmd->cxlm, &send, &c);
+	if (rc)
+		return rc;
+
+	/* Prepare to handle a full payload for variable sized output */
+	if (c.info.size_out < 0)
+		c.info.size_out = cxlm->payload_size;
+
+	rc = handle_mailbox_cmd_from_user(cxlm, &c, send.in.payload,
+					  send.out.payload, &send.out.size,
+					  &send.retval);
+	if (rc)
+		return rc;
+
+	return copy_to_user(s, &send, sizeof(send));
+}
+
+static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
+			       unsigned long arg)
+{
+	switch (cmd) {
+	case CXL_MEM_QUERY_COMMANDS:
+		return cxl_query_cmd(cxlmd, (void __user *)arg);
+	case CXL_MEM_SEND_COMMAND:
+		return cxl_send_cmd(cxlmd, (void __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
 static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
@@ -325,7 +611,7 @@ static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
 	if (!percpu_ref_tryget_live(&cxlmd->ops_active))
 		return -ENXIO;
 
-	/* TODO: ioctl body */
+	rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
 
 	percpu_ref_put(&cxlmd->ops_active);
 
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
new file mode 100644
index 000000000000..18cea908ad0b
--- /dev/null
+++ b/include/uapi/linux/cxl_mem.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * CXL IOCTLs for Memory Devices
+ */
+
+#ifndef _UAPI_CXL_MEM_H_
+#define _UAPI_CXL_MEM_H_
+
+#include <linux/types.h>
+
+/**
+ * DOC: UAPI
+ *
+ * Not all of all commands that the driver supports are always available for use
+ * by userspace. Userspace must check the results from the QUERY command in
+ * order to determine the live set of commands.
+ */
+
+#define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
+#define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
+
+#define CXL_CMDS                                                          \
+	___C(INVALID, "Invalid Command"),                                 \
+	___C(IDENTIFY, "Identify Command"),                               \
+	___C(MAX, "invalid / last command")
+
+#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
+enum { CXL_CMDS };
+
+#undef ___C
+#define ___C(a, b) { b }
+static const struct {
+	const char *name;
+} cxl_command_names[] = { CXL_CMDS };
+
+/*
+ * Here's how this actually breaks out:
+ * cxl_command_names[] = {
+ *	[CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
+ *	[CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Command" },
+ *	...
+ *	[CXL_MEM_COMMAND_ID_MAX] = { "invalid / last command" },
+ * };
+ */
+
+#undef ___C
+
+/**
+ * struct cxl_command_info - Command information returned from a query.
+ * @id: ID number for the command.
+ * @flags: Flags that specify command behavior.
+ * @size_in: Expected input size, or -1 if variable length.
+ * @size_out: Expected output size, or -1 if variable length.
+ *
+ * Represents a single command that is supported by both the driver and the
+ * hardware. This is returned as part of an array from the query ioctl. The
+ * following would be a command that takes a variable length input and returns 0
+ * bytes of output.
+ *
+ *  - @id = 10
+ *  - @flags = 0
+ *  - @size_in = -1
+ *  - @size_out = 0
+ *
+ * See struct cxl_mem_query_commands.
+ */
+struct cxl_command_info {
+	__u32 id;
+
+	__u32 flags;
+#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(0, 0)
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
+/**
+ * struct cxl_send_command - Send a command to a memory device.
+ * @id: The command to send to the memory device. This must be one of the
+ *	commands returned by the query command.
+ * @flags: Flags for the command (input).
+ * @rsvd: Must be zero.
+ * @retval: Return value from the memory device (output).
+ * @in.size: Size of the payload to provide to the device (input).
+ * @in.rsvd: Must be zero.
+ * @in.payload: Pointer to memory for payload input, payload is little endian.
+ * @out.size: Size of the payload received from the device (input/output). This
+ *	      field is filled in by userspace to let the driver know how much
+ *	      space was allocated for output. It is populated by the driver to
+ *	      let userspace know how large the output payload actually was.
+ * @out.rsvd: Must be zero.
+ * @out.payload: Pointer to memory for payload output, payload is little endian.
+ *
+ * Mechanism for userspace to send a command to the hardware for processing. The
+ * driver will do basic validation on the command sizes. In some cases even the
+ * payload may be introspected. Userspace is required to allocate large enough
+ * buffers for size_out which can be variable length in certain situations.
+ */
+struct cxl_send_command {
+	__u32 id;
+	__u32 flags;
+	__u32 rsvd;
+	__u32 retval;
+
+	struct {
+		__s32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} in;
+
+	struct {
+		__s32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} out;
+};
+
+#endif
-- 
2.30.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
