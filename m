Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CA83090EC
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 Jan 2021 01:25:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5838A100EAB18;
	Fri, 29 Jan 2021 16:24:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6DC9F100EB33B
	for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 16:24:49 -0800 (PST)
IronPort-SDR: CmpVFHS+vET7uby4KVkA5maeGdYSC2/jDtZ81E81wGhh65b/LdV8MVj8AD5vZIJ1uOMFVlAkUp
 mj5CI9KQuQkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="265333146"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="265333146"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:49 -0800
IronPort-SDR: VOBcOt1l54DxNAotpSMWk8CHiB+5zPh+jPg2DmJfKBiOepFTqkMIDXSeROM+ZXZJh+Y2zU5Vun
 wXHu8ircr5+w==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="370591678"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:48 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH 07/14] cxl/mem: Add send command
Date: Fri, 29 Jan 2021 16:24:31 -0800
Message-Id: <20210130002438.1872527-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002438.1872527-1-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 2L5Y6YD3OJAGCXXXA2SQXLCYFDUCE7U5
X-Message-ID-Hash: 2L5Y6YD3OJAGCXXXA2SQXLCYFDUCE7U5
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2L5Y6YD3OJAGCXXXA2SQXLCYFDUCE7U5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The send command allows userspace to issue mailbox commands directly to
the hardware. The driver will verify basic properties of the command and
possible inspect the input (or output) payload to determine whether or
not the command is allowed (or might taint the kernel).

The list of allowed commands and their properties can be determined by
using the QUERY IOCTL for CXL memory devices.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c            | 201 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/cxl_mem.h |  45 ++++++++
 2 files changed, 244 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 3c3ff45f01c0..c646f0a1cf66 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -126,8 +126,8 @@ struct cxl_mem_command {
 			.size_in = sin,                                        \
 			.size_out = sout,                                      \
 		},                                                             \
-		.flags = CXL_CMD_INTERNAL_FLAG_##f,                            \
-		.opcode = CXL_MBOX_OP_##_id,                                   \
+	.flags = CXL_CMD_INTERNAL_FLAG_##f,                                    \
+	.opcode = CXL_MBOX_OP_##_id,                                           \
 	}
 
 /*
@@ -427,6 +427,174 @@ static int cxl_mem_count_commands(void)
 	}
 
 	return n;
+};
+
+/**
+ * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
+ * @cxlmd: The CXL memory device to communicate with.
+ * @cmd: The validated command.
+ * @in_payload: Pointer to userspace's input payload.
+ * @out_payload: Pointer to userspace's output payload.
+ * @u: The command submitted by userspace. Has output fields.
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
+					struct cxl_send_command __user *u)
+{
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct mbox_cmd mbox_cmd = {
+		.opcode = cmd->opcode,
+		.payload_in = NULL, /* Populated with copy_from_user() */
+		.payload_out = NULL, /* Read out by copy_to_user() */
+		.size_in = cmd->info.size_in,
+	};
+	s32 user_size_out;
+	int rc;
+
+	if (get_user(user_size_out, &u->size_out))
+		return -EFAULT;
+
+	if (cmd->info.size_out > 0) /* fixed size command */
+		mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
+	else if (cmd->info.size_out < 0) /* variable */
+		mbox_cmd.payload_out =
+			kvzalloc(cxlm->mbox.payload_size, GFP_KERNEL);
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
+	dev_dbg(&cxlmd->dev,
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
+	rc = put_user(mbox_cmd.return_code, &u->retval);
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
+	rc = put_user(mbox_cmd.size_out, &u->size_out);
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
+	if (send_cmd->size_in > cxlm->mbox.payload_size)
+		return -EINVAL;
+
+	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
+		return -EINVAL;
+
+	if (send_cmd->rsvd)
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
+	if (info->size_in >= 0 && info->size_in != send_cmd->size_in)
+		return -ENOMEM;
+
+	/* Check the output buffer is at least large enough */
+	if (info->size_out >= 0 && send_cmd->size_out < info->size_out)
+		return -ENOMEM;
+
+	/* Setting a few const fields here... */
+	memcpy(out_cmd, c, sizeof(*c));
+	*(s32 *)&out_cmd->info.size_in = send_cmd->size_in;
+	*(s32 *)&out_cmd->info.size_out = send_cmd->size_out;
+
+	return 0;
 }
 
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
@@ -469,6 +637,35 @@ static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 		}
 
 		return 0;
+	} else if (cmd == CXL_MEM_SEND_COMMAND) {
+		struct cxl_send_command send, __user *u = (void __user *)arg;
+		struct cxl_mem_command c;
+		int rc;
+
+		dev_dbg(dev, "Send IOCTL\n");
+
+		if (copy_from_user(&send, u, sizeof(send)))
+			return -EFAULT;
+
+		rc = device_lock_interruptible(dev);
+		if (rc)
+			return rc;
+
+		if (!get_live_device(dev)) {
+			device_unlock(dev);
+			return -ENXIO;
+		}
+
+		rc = cxl_validate_cmd_from_user(cxlmd->cxlm, &send, &c);
+		if (!rc)
+			rc = handle_mailbox_cmd_from_user(cxlmd, &c,
+							  send.in_payload,
+							  send.out_payload, u);
+
+		put_device(dev);
+		device_unlock(dev);
+
+		return rc;
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 70e3ba2fa008..9d865794a420 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -28,6 +28,7 @@ extern "C" {
  */
 
 #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
+#define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
 
 #define CXL_CMDS                                                          \
 	___C(INVALID, "Invalid Command"),                                 \
@@ -37,6 +38,11 @@ extern "C" {
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
 enum { CXL_CMDS };
 
+#undef ___C
+#define ___C(a, b) { b }
+static const struct {
+	const char *name;
+} cxl_command_names[] = { CXL_CMDS };
 #undef ___C
 
 /**
@@ -71,6 +77,7 @@ struct cxl_command_info {
 #define CXL_MEM_COMMAND_FLAG_NONE 0
 #define CXL_MEM_COMMAND_FLAG_KERNEL BIT(0)
 #define CXL_MEM_COMMAND_FLAG_MUTEX BIT(1)
+#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(1, 0)
 
 	__s32 size_in;
 	__s32 size_out;
@@ -112,6 +119,44 @@ struct cxl_mem_query_commands {
 	struct cxl_command_info __user commands[]; /* out: supported commands */
 };
 
+/**
+ * struct cxl_send_command - Send a command to a memory device.
+ * @id: The command to send to the memory device. This must be one of the
+ *	commands returned by the query command.
+ * @flags: Flags for the command (input).
+ * @rsvd: Must be zero.
+ * @retval: Return value from the memory device (output).
+ * @size_in: Size of the payload to provide to the device (input).
+ * @size_out: Size of the payload received from the device (input/output). This
+ *	      field is filled in by userspace to let the driver know how much
+ *	      space was allocated for output. It is populated by the driver to
+ *	      let userspace know how large the output payload actually was.
+ * @in_payload: Pointer to memory for payload input (little endian order).
+ * @out_payload: Pointer to memory for payload output (little endian order).
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
+		__s32 size_in;
+		__u64 in_payload;
+	};
+
+	struct {
+		__s32 size_out;
+		__u64 out_payload;
+	};
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
