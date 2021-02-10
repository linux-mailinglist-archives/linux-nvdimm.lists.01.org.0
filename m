Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB012315A7D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 01:03:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB730100EAB01;
	Tue,  9 Feb 2021 16:03:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 48F2B100EAAEA
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 16:03:26 -0800 (PST)
IronPort-SDR: dwfXYyVCWEHoErCGzGFXY5O7MsWxSGEBceKIGTaxsrsh84gJ/KwUH2LfS6WRTmUqZH0CiocMF/
 Qk7ydGiDVQJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="201079154"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400";
   d="scan'208";a="201079154"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:03:14 -0800
IronPort-SDR: 2sW/Vb3iUa7kz9nKjHtNOtV/mljsggCkL4aHrbLrZALow2vIXhBFJNVLwe8otAT7k0JuaxmP04
 aJ3gohwRTyKQ==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400";
   d="scan'208";a="419865848"
Received: from sitira7x-mobl1.gar.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:03:13 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
Date: Tue,  9 Feb 2021 16:02:55 -0800
Message-Id: <20210210000259.635748-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210000259.635748-1-ben.widawsky@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 3MSLSBUJ2GP3ZBLKOYOPNO7TGNTCSPGV
X-Message-ID-Hash: 3MSLSBUJ2GP3ZBLKOYOPNO7TGNTCSPGV
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>, Dan Williams <dan.j.willams@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3MSLSBUJ2GP3ZBLKOYOPNO7TGNTCSPGV/>
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
are submitted through a mailbox mechanism specified also originally
specified in the CXL 2.0 specification.

The send command allows userspace to issue mailbox commands directly to
the hardware. The list of available commands to send are the output of
the query command. The driver verifies basic properties of the command
and possibly inspect the input (or output) payload to determine whether
or not the command is allowed (or might taint the kernel).

Reported-by: kernel test robot <lkp@intel.com> # bug in earlier revision
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.willams@intel.com>
---
 .clang-format                                 |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/cxl/mem.c                             | 291 +++++++++++++++++-
 include/uapi/linux/cxl_mem.h                  | 152 +++++++++
 4 files changed, 443 insertions(+), 2 deletions(-)
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
index 8bbd2495e237..ce65630bb75e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <uapi/linux/cxl_mem.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/cdev.h>
@@ -39,6 +40,7 @@
 #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
 
 enum opcode {
+	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
@@ -90,9 +92,57 @@ struct cxl_memdev {
 static int cxl_mem_major;
 static DEFINE_IDA(cxl_memdev_ida);
 
+/**
+ * struct cxl_mem_command - Driver representation of a memory device command
+ * @info: Command information as it exists for the UAPI
+ * @opcode: The actual bits used for the mailbox protocol
+ * @flags: Set of flags reflecting the state of the command.
+ *
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
+	struct cxl_command_info info;
+	enum opcode opcode;
+};
+
+#define CXL_CMD(_id, _flags, sin, sout)                                        \
+	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
+	.info =	{                                                              \
+			.id = CXL_MEM_COMMAND_ID_##_id,                        \
+			.flags = CXL_MEM_COMMAND_FLAG_##_flags,                \
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
+	CXL_CMD(IDENTIFY, NONE, 0, 0x43),
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
-	const unsigned long start = jiffies;
+	unsigned long start = jiffies;
 	unsigned long end = start;
 
 	while (cxl_doorbell_busy(cxlm)) {
@@ -313,6 +363,243 @@ static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
 	mutex_unlock(&cxlm->mbox_mutex);
 }
 
+/**
+ * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
+ * @cxlmd: The CXL memory device to communicate with.
+ * @cmd: The validated command.
+ * @in_payload: Pointer to userspace's input payload.
+ * @out_payload: Pointer to userspace's output payload.
+ * @s: The command submitted by userspace. Has output fields.
+ *
+ * Return:
+ *  * %0	- Mailbox transaction succeeded.
+ *  * %-EFAULT	- Something happened with copy_to/from_user.
+ *  * %-ENOMEM  - Couldn't allocate a bounce buffer.
+ *  * %-EINTR	- Mailbox acquisition interrupted.
+ *  * %-E2BIG   - Output payload would overrun user's buffer.
+ *
+ * Creates the appropriate mailbox command on behalf of a userspace request.
+ * Return value, size, and output payload are all copied out to @u. The
+ * parameters for the command must be validated before calling this function.
+ *
+ * A 0 return code indicates the command executed successfully, not that it was
+ * itself successful. IOW, the cmd->retval should always be checked if wanting
+ * to determine the actual result.
+ */
+static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
+					const struct cxl_mem_command *cmd,
+					u64 in_payload, u64 out_payload,
+					struct cxl_send_command __user *s)
+{
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct device *dev = &cxlmd->dev;
+	struct mbox_cmd mbox_cmd = {
+		.opcode = cmd->opcode,
+		.size_in = cmd->info.size_in,
+	};
+	s32 user_size_out;
+	int rc;
+
+	if (get_user(user_size_out, &s->out.size))
+		return -EFAULT;
+
+	if (cmd->info.size_out > 0) /* fixed size command */
+		mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
+	else if (cmd->info.size_out < 0) /* variable */
+		mbox_cmd.payload_out = kvzalloc(cxlm->payload_size, GFP_KERNEL);
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
+	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
+	cxl_mem_mbox_put(cxlm);
+	if (rc)
+		goto out;
+
+	rc = put_user(mbox_cmd.return_code, &s->retval);
+	if (rc)
+		goto out;
+
+	if (user_size_out < mbox_cmd.size_out) {
+		rc = -E2BIG;
+		goto out;
+	}
+
+	if (mbox_cmd.size_out) {
+		if (copy_to_user(u64_to_user_ptr(out_payload),
+				 mbox_cmd.payload_out, mbox_cmd.size_out)) {
+			rc = -EFAULT;
+			goto out;
+		}
+	}
+
+	rc = put_user(mbox_cmd.size_out, &s->out.size);
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
+ *  * %-EPERM	- Attempted to use a protected command.
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
+	 * The user can never specify an input payload larger than
+	 * hardware supports, but output can be arbitrarily large,
+	 * simply write out as much data as the hardware provides.
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
+	if (info->flags & CXL_MEM_COMMAND_FLAG_KERNEL)
+		return -EPERM;
+
+	/* Check the input buffer is the expected size */
+	if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
+		return -ENOMEM;
+
+	/* Check the output buffer is at least large enough */
+	if (info->size_out >= 0 && send_cmd->out.size < info->size_out)
+		return -ENOMEM;
+
+	/* Setting a few const fields here... */
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
+	return handle_mailbox_cmd_from_user(cxlmd, &c, send.in.payload,
+					    send.out.payload, s);
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
@@ -326,7 +613,7 @@ static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
 	if (!percpu_ref_tryget_live(&cxlmd->ops_active))
 		return -ENXIO;
 
-	/* TODO: ioctl body */
+	rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
 
 	percpu_ref_put(&cxlmd->ops_active);
 
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
new file mode 100644
index 000000000000..f1f7e9f32ea5
--- /dev/null
+++ b/include/uapi/linux/cxl_mem.h
@@ -0,0 +1,152 @@
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
+	___C(MAX, "Last command")
+
+#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
+enum { CXL_CMDS };
+
+#undef ___C
+#define ___C(a, b) { b }
+static const struct {
+	const char *name;
+} cxl_command_names[] = { CXL_CMDS };
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
+#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(1, 0)
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
+ * @in.payload: Pointer to memory for payload input (little endian order).
+ * @out.size: Size of the payload received from the device (input/output). This
+ *	      field is filled in by userspace to let the driver know how much
+ *	      space was allocated for output. It is populated by the driver to
+ *	      let userspace know how large the output payload actually was.
+ * @out.rsvd: Must be zero.
+ * @out.payload: Pointer to memory for payload output (little endian order).
+ *
+ * Mechanism for userspace to send a command to the hardware for processing. The
+ * driver will do basic validation on the command sizes. In some cases even the
+ * payload may be introspected. Userspace is required to allocate large
+ * enough buffers for size_out which can be variable length in certain
+ * situations.
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
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
