Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3C12F241C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 01:34:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2685C100EB820;
	Mon, 11 Jan 2021 16:34:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 68C3B100EB826
	for <linux-nvdimm@lists.01.org>; Mon, 11 Jan 2021 16:34:24 -0800 (PST)
IronPort-SDR: sI002unct1Fe72d54Oik17HIQ6zJly+4f5bkgqxujPwbGzMrwcnYNjHlU+Sr6mD/P2yXUFvudB
 VWJdqoK0l18w==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177185575"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400";
   d="scan'208";a="177185575"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:24 -0800
IronPort-SDR: j+p7L06grOxtB9DIFzB3+6iFUk2Grf6Vhgilvmh4ZvVagYD/AP74Ipz/B4GT5PYTjETi1HvfE+
 rKqBrnjjzitg==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400";
   d="scan'208";a="381212099"
Received: from ecbackus-mobl1.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.212.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:23 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl RFC PATCH 3/5] libcxl: add support for command query and submission
Date: Mon, 11 Jan 2021 17:34:01 -0700
Message-Id: <20210112003403.2944568-4-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112003403.2944568-1-vishal.l.verma@intel.com>
References: <20210112003403.2944568-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: OPIALPZ22ENIEUYGBSEKOWCQTHZX2E6U
X-Message-ID-Hash: OPIALPZ22ENIEUYGBSEKOWCQTHZX2E6U
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OPIALPZ22ENIEUYGBSEKOWCQTHZX2E6U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a set of APIs around 'cxl_cmd' for querying the kernel for supported
commands, allocating and validating command structures against the
supported set, and submitting the commands.

'Query Commands' and 'Send Command' are implemented as IOCTLs in the
kernel. 'Query Commands' returns information about each supported
command, such as flags governing its use, or input and output payload
sizes. This information is used to validate command support, as well as
set up input and output buffers for the actual command submission.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/lib/private.h  |  40 ++++++
 cxl/lib/libcxl.c   | 352 +++++++++++++++++++++++++++++++++++++++++++++
 cxl/libcxl.h       |  11 ++
 cxl/lib/libcxl.sym |  12 ++
 4 files changed, 415 insertions(+)

diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index f787512..c7ebfcb 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -4,6 +4,9 @@
 #define _LIBCXL_PRIVATE_H_
 
 #include <libkmod.h>
+#include <cxl_mem.h>
+#include <ccan/endian/endian.h>
+#include <ccan/short_types/short_types.h>
 
 #define CXL_EXPORT __attribute__ ((visibility("default")))
 
@@ -20,6 +23,43 @@ struct cxl_memdev {
 	struct kmod_module *module;
 };
 
+#undef C
+#define C(a, b) { b }
+static struct {
+	const char *name;
+} command_names[] = { CMDS };
+#undef C
+
+enum cxl_cmd_query_status {
+	CXL_CMD_QUERY_NOT_RUN = 0,
+	CXL_CMD_QUERY_OK,
+	CXL_CMD_QUERY_UNSUPPORTED,
+};
+
+/**
+ * struct cxl_cmd - CXL memdev command
+ * @memdev: the memory device to which the command is being sent
+ * @query_cmd: structure for the Linux 'Query commands' ioctl
+ * @send_cmd: structure for the Linux 'Send command' ioctl
+ * @input_payload: buffer for any input payload
+ * @output_payload: buffer for any output payload
+ * @refcount: reference for passing command buffer around
+ * @query_status: status from query_commands
+ * @query_status: status from query_commands
+ * @status: command return status from the device
+ */
+struct cxl_cmd {
+	struct cxl_memdev *memdev;
+	struct cxl_mem_query_commands *query_cmd;
+	struct cxl_send_command *send_cmd;
+	void *input_payload;
+	void *output_payload;
+	int refcount;
+	int query_status;
+	int query_idx;
+	int status;
+};
+
 static inline int check_kmod(struct kmod_ctx *kmod_ctx)
 {
 	return kmod_ctx ? 0 : -ENXIO;
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index c864208..02bc316 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -9,13 +9,16 @@
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/ioctl.h>
 #include <sys/sysmacros.h>
 #include <uuid/uuid.h>
 #include <ccan/list/list.h>
 #include <ccan/array_size/array_size.h>
 
+#include <cxl_mem.h>
 #include <util/log.h>
 #include <util/sysfs.h>
+#include <util/bitmap.h>
 #include <cxl/libcxl.h>
 #include "private.h"
 
@@ -316,3 +319,352 @@ CXL_EXPORT unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev)
 {
 	return memdev->ram_size;
 }
+
+CXL_EXPORT void cxl_cmd_unref(struct cxl_cmd *cmd)
+{
+	if (!cmd)
+		return;
+	if (--cmd->refcount == 0) {
+		free(cmd->query_cmd);
+		free(cmd->send_cmd);
+		free(cmd->input_payload);
+		free(cmd->output_payload);
+		free(cmd);
+	}
+}
+
+CXL_EXPORT void cxl_cmd_ref(struct cxl_cmd *cmd)
+{
+	cmd->refcount++;
+}
+
+static int cxl_cmd_alloc_query(struct cxl_cmd *cmd, int num_cmds)
+{
+	struct cxl_mem_query_commands *qcmd;
+	size_t size;
+
+	if (!cmd)
+		return -EINVAL;
+
+	if (cmd->query_cmd != NULL)
+		free(cmd->query_cmd);
+
+	size = sizeof(struct cxl_mem_query_commands) +
+			(num_cmds * sizeof(struct cxl_command_info));
+	cmd->query_cmd = calloc(1, size);
+	if (!cmd->query_cmd)
+		return -ENOMEM;
+
+	qcmd = cmd->query_cmd;
+	qcmd->n_commands = num_cmds;
+
+	return 0;
+}
+
+static struct cxl_cmd *cxl_cmd_new(struct cxl_memdev *memdev)
+{
+	struct cxl_cmd *cmd;
+	size_t size;
+
+	size = sizeof(*cmd);
+	cmd = calloc(1, size);
+	if (!cmd)
+		return NULL;
+
+	cxl_cmd_ref(cmd);
+	cmd->memdev = memdev;
+
+	return cmd;
+}
+
+static int __do_cmd(struct cxl_cmd *cmd, int ioctl_cmd, int fd)
+{
+	struct cxl_memdev *memdev = cmd->memdev;
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	const char *devname = cxl_memdev_get_devname(memdev);
+	char *cmd_name;
+	void *cmd_buf;
+	int rc;
+
+	switch (ioctl_cmd) {
+	case CXL_MEM_QUERY_COMMANDS:
+		cmd_buf = cmd->query_cmd;
+		cmd_name = "query";
+		break;
+	case CXL_MEM_SEND_COMMAND:
+		cmd_buf = cmd->send_cmd;
+		cmd_name = "send";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rc = ioctl(fd, ioctl_cmd, cmd_buf);
+	if (rc < 0)
+		rc = -errno;
+
+	info(ctx, "%s: cmd: %s, status: %s\n", devname,
+		cmd_name, (rc < 0) ? strerror(-rc) : "success");
+
+	return rc;
+}
+
+static int do_cmd(struct cxl_cmd *cmd, int ioctl_cmd)
+{
+	char path[20];
+	struct stat st;
+	unsigned int major, minor;
+	int rc = 0, fd, len = sizeof(path);
+	struct cxl_memdev *memdev = cmd->memdev;
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	const char *devname = cxl_memdev_get_devname(memdev);
+
+	major = cxl_memdev_get_major(memdev);
+	minor = cxl_memdev_get_minor(memdev);
+
+	if (snprintf(path, len, "/dev/cxl/%s", devname) >= len) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	fd = open(path, O_RDWR);
+	if (fd < 0) {
+		err(ctx, "failed to open %s: %s\n", path, strerror(errno));
+		rc = -errno;
+		goto out;
+	}
+
+	if (fstat(fd, &st) >= 0 && S_ISCHR(st.st_mode)
+			&& major(st.st_rdev) == major
+			&& minor(st.st_rdev) == minor) {
+		rc = __do_cmd(cmd, ioctl_cmd, fd);
+	} else {
+		err(ctx, "failed to validate %s as a CXL memdev node\n", path);
+		rc = -ENXIO;
+	}
+	close(fd);
+ out:
+	return rc;
+}
+
+static int alloc_do_query(struct cxl_cmd *cmd, int num_cmds)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(cmd->memdev);
+	int rc;
+
+	rc = cxl_cmd_alloc_query(cmd, num_cmds);
+	if (rc)
+		return rc;
+
+	rc = do_cmd(cmd, CXL_MEM_QUERY_COMMANDS);
+	if (rc < 0)
+		err(ctx, "%s: query commands failed: %s\n",
+			cxl_memdev_get_devname(cmd->memdev),
+			strerror(-rc));
+	return rc;
+}
+
+static int cxl_cmd_do_query(struct cxl_cmd *cmd)
+{
+	struct cxl_memdev *memdev = cmd->memdev;
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	const char *devname = cxl_memdev_get_devname(memdev);
+	int rc, n_commands;
+
+	switch (cmd->query_status) {
+	case CXL_CMD_QUERY_OK:
+		return 0;
+	case CXL_CMD_QUERY_UNSUPPORTED:
+		return -EOPNOTSUPP;
+	case CXL_CMD_QUERY_NOT_RUN:
+		break;
+	default:
+		err(ctx, "%s: Unknown query_status %d\n",
+			devname, cmd->query_status);
+		return -EINVAL;
+	}
+
+	rc = alloc_do_query(cmd, 0);
+	if (rc)
+		return rc;
+
+	n_commands = cmd->query_cmd->n_commands;
+	dbg(ctx, "%s: supports %d commands\n", devname, n_commands);
+
+	return alloc_do_query(cmd, n_commands);
+}
+
+static int cxl_cmd_validate(struct cxl_cmd *cmd, u32 cmd_id)
+{
+	struct cxl_memdev *memdev = cmd->memdev;
+	struct cxl_mem_query_commands *query = cmd->query_cmd;
+	const char *devname = cxl_memdev_get_devname(memdev);
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	u32 i;
+
+	for (i = 0; i < query->n_commands; i++) {
+		struct cxl_command_info *cinfo = &query->commands[i];
+		const char *cmd_name = command_names[cinfo->id].name;
+
+		if (cinfo->id != cmd_id)
+			continue;
+
+		dbg(ctx, "%s: %s: in: %d, out %d, flags: %#08x\n",
+			devname, cmd_name, cinfo->size_in,
+			cinfo->size_out, cinfo->flags);
+
+		if (cinfo->flags & CXL_MEM_COMMAND_FLAG_KERNEL) {
+			err(ctx, "%s: %s: reserved for kernel use\n",
+				devname, cmd_name);
+			return -EPERM;
+		}
+		cmd->query_idx = i;
+		cmd->query_status = CXL_CMD_QUERY_OK;
+		return 0;
+	}
+	cmd->query_status = CXL_CMD_QUERY_UNSUPPORTED;
+	return -EOPNOTSUPP;
+}
+
+CXL_EXPORT int cxl_cmd_attach_payloads(struct cxl_cmd *cmd,
+		void *in, int size_in,
+		void *out, int size_out)
+{
+	struct cxl_memdev *memdev = cmd->memdev;
+
+	if (size_in > memdev->payload_max || size_out > memdev->payload_max)
+		return -EINVAL;
+
+	if (size_in > 0) {
+		cmd->send_cmd->in_payload = (u64)in;
+		cmd->send_cmd->size_in = size_in;
+	}
+	if (size_out > 0) {
+		cmd->send_cmd->out_payload = (u64)out;
+		cmd->send_cmd->size_out = size_out;
+	}
+
+	return 0;
+}
+
+static int cxl_cmd_alloc_send(struct cxl_cmd *cmd, u32 cmd_id)
+{
+	struct cxl_mem_query_commands *query = cmd->query_cmd;
+	struct cxl_command_info *cinfo = &query->commands[cmd->query_idx];
+	size_t size;
+
+	if (!query)
+		return -EINVAL;
+
+	size = sizeof(struct cxl_send_command);
+	cmd->send_cmd = calloc(1, size);
+	if (!cmd->send_cmd)
+		return -ENOMEM;
+
+	if (cinfo->id != cmd_id)
+		return -EINVAL;
+
+	cmd->send_cmd->id = cmd_id;
+
+	if (cinfo->size_in > 0) {
+		cmd->input_payload = calloc(1, cinfo->size_in);
+		if (!cmd->input_payload)
+			return -ENOMEM;
+	}
+	if (cinfo->size_out > 0) {
+		cmd->output_payload = calloc(1, cinfo->size_out);
+		if (!cmd->output_payload)
+			return -ENOMEM;
+	}
+	cxl_cmd_attach_payloads(cmd, cmd->input_payload, cinfo->size_in,
+			cmd->output_payload, cinfo->size_out);
+
+	return 0;
+}
+
+static struct cxl_cmd *cxl_cmd_new_generic(struct cxl_memdev *memdev,
+		u32 cmd_id)
+{
+	const char *devname = cxl_memdev_get_devname(memdev);
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	struct cxl_cmd *cmd;
+	int rc;
+
+	cmd = cxl_cmd_new(memdev);
+	if (!cmd)
+		return NULL;
+
+	rc = cxl_cmd_do_query(cmd);
+	if (rc) {
+		err(ctx, "%s: query returned: %s\n", devname, strerror(-rc));
+		goto fail;
+	}
+
+	rc = cxl_cmd_validate(cmd, cmd_id);
+	if (rc) {
+		errno = -rc;
+		goto fail;
+	}
+
+	rc = cxl_cmd_alloc_send(cmd, cmd_id);
+	if (rc) {
+		errno = -rc;
+		goto fail;
+	}
+
+	return cmd;
+
+fail:
+	cxl_cmd_unref(cmd);
+	return NULL;
+}
+
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev)
+{
+	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_IDENTIFY);
+}
+
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev)
+{
+	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_RAW);
+}
+
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_get_supported_logs(
+		struct cxl_memdev *memdev)
+{
+	return cxl_cmd_new_generic(memdev,
+			CXL_MEM_COMMAND_ID_GET_SUPPORTED_LOGS);
+}
+
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_get_log(struct cxl_memdev *memdev)
+{
+	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_GET_LOG);
+}
+
+CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
+{
+	struct cxl_memdev *memdev = cmd->memdev;
+	const char *devname = cxl_memdev_get_devname(memdev);
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	int rc;
+
+	switch (cmd->query_status) {
+	case CXL_CMD_QUERY_OK:
+		break;
+	case CXL_CMD_QUERY_UNSUPPORTED:
+		return -EOPNOTSUPP;
+	case CXL_CMD_QUERY_NOT_RUN:
+		return -EINVAL;
+	default:
+		err(ctx, "%s: Unknown query_status %d\n",
+			devname, cmd->query_status);
+		return -EINVAL;
+	}
+
+	rc = do_cmd(cmd, CXL_MEM_SEND_COMMAND);
+	if (rc < 0)
+		err(ctx, "%s: send command failed: %s\n",
+			devname, strerror(-rc));
+	cmd->status = cmd->send_cmd->retval;
+	return rc;
+}
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 8ee6873..83888bc 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -45,6 +45,17 @@ unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
              memdev != NULL; \
              memdev = cxl_memdev_get_next(memdev))
 
+struct cxl_cmd;
+struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev);
+struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev);
+struct cxl_cmd *cxl_cmd_new_get_supported_logs(struct cxl_memdev *memdev);
+struct cxl_cmd *cxl_cmd_new_get_log(struct cxl_memdev *memdev);
+int cxl_cmd_attach_payloads(struct cxl_cmd *cmd,
+		void *in, int size_in, void *out, int size_out);
+void cxl_cmd_ref(struct cxl_cmd *cmd);
+void cxl_cmd_unref(struct cxl_cmd *cmd);
+int cxl_cmd_submit(struct cxl_cmd *cmd);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 9bbbeb4..3583bab 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -24,3 +24,15 @@ global:
 	cxl_memdev_get_pmem_size;
 	cxl_memdev_get_ram_size;
 } LIBCXL_1;
+
+LIBCXL_3 {
+global:
+	cxl_cmd_new_identify;
+	cxl_cmd_new_raw;
+	cxl_cmd_new_get_supported_logs;
+	cxl_cmd_new_get_log;
+	cxl_cmd_attach_payloads;
+	cxl_cmd_ref;
+	cxl_cmd_unref;
+	cxl_cmd_submit;
+} LIBCXL_2;
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
