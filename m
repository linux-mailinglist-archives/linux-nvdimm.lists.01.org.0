Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8C13221DA
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 22:55:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1D5AD100EB323;
	Mon, 22 Feb 2021 13:55:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 58A7E100EB322
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 13:55:42 -0800 (PST)
IronPort-SDR: nLOzR5eMEWOBYg/MzPjWuhllUse751GgoMjEv2aQ50G+N7X4EK37gKq94+RJBisag342jxXkya
 qTSZmHMS6lCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="181161492"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400";
   d="scan'208";a="181161492"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 13:55:41 -0800
IronPort-SDR: PZmPVAKBb/BFWXbc7WRcymoH2IqpK063iN+qi4oAc3/3c4qu74FUsd9UJ8L5s/Z2V7qsJzjVe5
 f09Bj1wLzPeg==
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400";
   d="scan'208";a="390038610"
Received: from hlgebhar-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 13:55:41 -0800
Date: Mon, 22 Feb 2021 13:55:39 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH v2 03/13] libcxl: add support for command query and
 submission
Message-ID: <20210222215539.s3n6yj5lgmdohypt@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
 <20210219020331.725687-4-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210219020331.725687-4-vishal.l.verma@intel.com>
Message-ID-Hash: P3G23JJW4M7WC534DNTZLZOF22QH3DXC
X-Message-ID-Hash: P3G23JJW4M7WC534DNTZLZOF22QH3DXC
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P3G23JJW4M7WC534DNTZLZOF22QH3DXC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-18 19:03:21, Vishal Verma wrote:
> Add a set of APIs around 'cxl_cmd' for querying the kernel for supported
> commands, allocating and validating command structures against the
> supported set, and submitting the commands.
> 
> 'Query Commands' and 'Send Command' are implemented as IOCTLs in the
> kernel. 'Query Commands' returns information about each supported
> command, such as flags governing its use, or input and output payload
> sizes. This information is used to validate command support, as well as
> set up input and output buffers for command submission.
> 
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  cxl/lib/private.h  |  33 ++++
>  cxl/lib/libcxl.c   | 393 +++++++++++++++++++++++++++++++++++++++++++++
>  cxl/libcxl.h       |  11 ++
>  cxl/lib/libcxl.sym |  13 ++
>  4 files changed, 450 insertions(+)
> 
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> index fc88fa1..87ca17e 100644
> --- a/cxl/lib/private.h
> +++ b/cxl/lib/private.h
> @@ -4,6 +4,9 @@
>  #define _LIBCXL_PRIVATE_H_
>  
>  #include <libkmod.h>
> +#include <cxl/cxl_mem.h>
> +#include <ccan/endian/endian.h>
> +#include <ccan/short_types/short_types.h>
>  
>  #define CXL_EXPORT __attribute__ ((visibility("default")))
>  
> @@ -21,6 +24,36 @@ struct cxl_memdev {
>  	struct kmod_module *module;
>  };
>  
> +enum cxl_cmd_query_status {
> +	CXL_CMD_QUERY_NOT_RUN = 0,
> +	CXL_CMD_QUERY_OK,
> +	CXL_CMD_QUERY_UNSUPPORTED,
> +};
> +
> +/**
> + * struct cxl_cmd - CXL memdev command
> + * @memdev: the memory device to which the command is being sent
> + * @query_cmd: structure for the Linux 'Query commands' ioctl
> + * @send_cmd: structure for the Linux 'Send command' ioctl
> + * @input_payload: buffer for input payload managed by libcxl
> + * @output_payload: buffer for output payload managed by libcxl
> + * @refcount: reference for passing command buffer around
> + * @query_status: status from query_commands
> + * @query_idx: index of 'this' command in the query_commands array
> + * @status: command return status from the device
> + */
> +struct cxl_cmd {
> +	struct cxl_memdev *memdev;
> +	struct cxl_mem_query_commands *query_cmd;
> +	struct cxl_send_command *send_cmd;
> +	void *input_payload;
> +	void *output_payload;
> +	int refcount;
> +	int query_status;
> +	int query_idx;
> +	int status;
> +};
> +
>  static inline int check_kmod(struct kmod_ctx *kmod_ctx)
>  {
>  	return kmod_ctx ? 0 : -ENXIO;
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index d34e7d0..f1155a1 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -9,6 +9,7 @@
>  #include <unistd.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
> +#include <sys/ioctl.h>
>  #include <sys/sysmacros.h>
>  #include <uuid/uuid.h>
>  #include <ccan/list/list.h>
> @@ -17,6 +18,7 @@
>  #include <util/log.h>
>  #include <util/sysfs.h>
>  #include <util/bitmap.h>
> +#include <cxl/cxl_mem.h>
>  #include <cxl/libcxl.h>
>  #include "private.h"
>  
> @@ -343,3 +345,394 @@ CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev
>  {
>  	return memdev->firmware_version;
>  }
> +
> +CXL_EXPORT void cxl_cmd_unref(struct cxl_cmd *cmd)
> +{
> +	if (!cmd)
> +		return;
> +	if (--cmd->refcount == 0) {
> +		free(cmd->query_cmd);
> +		free(cmd->send_cmd);
> +		free(cmd->input_payload);
> +		free(cmd->output_payload);
> +		free(cmd);
> +	}
> +}
> +
> +CXL_EXPORT void cxl_cmd_ref(struct cxl_cmd *cmd)
> +{
> +	cmd->refcount++;
> +}
> +
> +static int cxl_cmd_alloc_query(struct cxl_cmd *cmd, int num_cmds)
> +{
> +	size_t size;
> +
> +	if (!cmd)
> +		return -EINVAL;
> +
> +	if (cmd->query_cmd != NULL)
> +		free(cmd->query_cmd);
> +
> +	size = sizeof(struct cxl_mem_query_commands) +
> +			(num_cmds * sizeof(struct cxl_command_info));
> +	cmd->query_cmd = calloc(1, size);
> +	if (!cmd->query_cmd)
> +		return -ENOMEM;
> +
> +	cmd->query_cmd->n_commands = num_cmds;
> +
> +	return 0;
> +}
> +
> +static struct cxl_cmd *cxl_cmd_new(struct cxl_memdev *memdev)
> +{
> +	struct cxl_cmd *cmd;
> +	size_t size;
> +
> +	size = sizeof(*cmd);
> +	cmd = calloc(1, size);
> +	if (!cmd)
> +		return NULL;
> +
> +	cxl_cmd_ref(cmd);
> +	cmd->memdev = memdev;
> +
> +	return cmd;
> +}
> +
> +static int __do_cmd(struct cxl_cmd *cmd, int ioctl_cmd, int fd)
> +{
> +	void *cmd_buf;
> +	int rc;
> +
> +	switch (ioctl_cmd) {
> +	case CXL_MEM_QUERY_COMMANDS:
> +		cmd_buf = cmd->query_cmd;
> +		break;
> +	case CXL_MEM_SEND_COMMAND:
> +		cmd_buf = cmd->send_cmd;
> +		break;
> +	default:
> +		return -EINVAL;

__builtin_unreachable? I don't see other uses in this project, so perhaps no..

> +	}
> +
> +	rc = ioctl(fd, ioctl_cmd, cmd_buf);
> +	if (rc < 0)
> +		rc = -errno;
> +
> +	return rc;
> +}
> +
> +static int do_cmd(struct cxl_cmd *cmd, int ioctl_cmd)
> +{
> +	char *path;
> +	struct stat st;
> +	unsigned int major, minor;
> +	int rc = 0, fd;
> +	struct cxl_memdev *memdev = cmd->memdev;
> +	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +	const char *devname = cxl_memdev_get_devname(memdev);
> +
> +	major = cxl_memdev_get_major(memdev);
> +	minor = cxl_memdev_get_minor(memdev);
> +
> +	if (asprintf(&path, "/dev/cxl/%s", devname) < 0)
> +		return -ENOMEM;
> +
> +	fd = open(path, O_RDWR);
> +	if (fd < 0) {
> +		err(ctx, "failed to open %s: %s\n", path, strerror(errno));
> +		rc = -errno;
> +		goto out;
> +	}
> +
> +	if (fstat(fd, &st) >= 0 && S_ISCHR(st.st_mode)
> +			&& major(st.st_rdev) == major
> +			&& minor(st.st_rdev) == minor) {
> +		rc = __do_cmd(cmd, ioctl_cmd, fd);

I don't see anything wrong with this, but could you explain a case where
major/minor would not be the right thing? Is this just like super paranoid
guarding?

I mean, if you ended up with the wrong device types, your IOCTLs will fail
anyway.

> +	} else {
> +		err(ctx, "failed to validate %s as a CXL memdev node\n", path);
> +		rc = -ENXIO;
> +	}
> +	close(fd);
> +out:
> +	free(path);
> +	return rc;
> +}
> +
> +static int alloc_do_query(struct cxl_cmd *cmd, int num_cmds)
> +{
> +	struct cxl_ctx *ctx = cxl_memdev_get_ctx(cmd->memdev);
> +	int rc;
> +
> +	rc = cxl_cmd_alloc_query(cmd, num_cmds);
> +	if (rc)
> +		return rc;
> +
> +	rc = do_cmd(cmd, CXL_MEM_QUERY_COMMANDS);
> +	if (rc < 0)
> +		err(ctx, "%s: query commands failed: %s\n",
> +			cxl_memdev_get_devname(cmd->memdev),
> +			strerror(-rc));
> +	return rc;
> +}
> +
> +static int cxl_cmd_do_query(struct cxl_cmd *cmd)
> +{
> +	struct cxl_memdev *memdev = cmd->memdev;
> +	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +	const char *devname = cxl_memdev_get_devname(memdev);
> +	int rc, n_commands;
> +
> +	switch (cmd->query_status) {
> +	case CXL_CMD_QUERY_OK:
> +		return 0;
> +	case CXL_CMD_QUERY_UNSUPPORTED:
> +		return -EOPNOTSUPP;

This makes me a little bit nervous. I've been leaving open the possibility that
command support might be transient. For instance, perhaps at boot a command is
not supported, but you change some device state and then it later becomes
supported. Or perhaps you have a command available and you go into some sort of
degraded performance mode which removes a set of commands.

Thoughts?

> +	case CXL_CMD_QUERY_NOT_RUN:
> +		break;
> +	default:
> +		err(ctx, "%s: Unknown query_status %d\n",
> +			devname, cmd->query_status);
> +		return -EINVAL;

Same about unreachable...

> +	}
> +
> +	rc = alloc_do_query(cmd, 0);
> +	if (rc)
> +		return rc;
> +
> +	n_commands = cmd->query_cmd->n_commands;
> +	dbg(ctx, "%s: supports %d commands\n", devname, n_commands);
> +
> +	return alloc_do_query(cmd, n_commands);
> +}
> +
> +static int cxl_cmd_validate(struct cxl_cmd *cmd, u32 cmd_id)
> +{
> +	struct cxl_memdev *memdev = cmd->memdev;
> +	struct cxl_mem_query_commands *query = cmd->query_cmd;
> +	const char *devname = cxl_memdev_get_devname(memdev);
> +	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +	u32 i;
> +
> +	for (i = 0; i < query->n_commands; i++) {
> +		struct cxl_command_info *cinfo = &query->commands[i];
> +		const char *cmd_name = cxl_command_names[cinfo->id].name;
> +
> +		if (cinfo->id != cmd_id)
> +			continue;
> +
> +		dbg(ctx, "%s: %s: in: %d, out %d, flags: %#08x\n",
> +			devname, cmd_name, cinfo->size_in,
> +			cinfo->size_out, cinfo->flags);
> +
> +		if (cinfo->flags & CXL_MEM_COMMAND_FLAG_KERNEL) {
> +			err(ctx, "%s: %s: reserved for kernel use\n",
> +				devname, cmd_name);
> +			return -EPERM;
> +		}
> +		cmd->query_idx = i;
> +		cmd->query_status = CXL_CMD_QUERY_OK;
> +		return 0;
> +	}
> +	cmd->query_status = CXL_CMD_QUERY_UNSUPPORTED;
> +	return -EOPNOTSUPP;
> +}
> +
> +CXL_EXPORT int cxl_cmd_set_input_payload(struct cxl_cmd *cmd, void *buf,
> +		int size)
> +{
> +	struct cxl_memdev *memdev = cmd->memdev;
> +
> +	if (size > memdev->payload_max || size < 0)
> +		return -EINVAL;
> +
> +	if (!buf) {
> +
> +		/* If the user didn't supply a buffer, allocate it */
> +		cmd->input_payload = calloc(1, size);
> +		if (!cmd->input_payload)
> +			return -ENOMEM;
> +		cmd->send_cmd->in.payload = (u64)cmd->input_payload;
> +	} else {
> +		/*
> +		 * Use user-buffer as is. If an automatic allocation was
> +		 * previously made (based on a fixed size from query),
> +		 * it will get freed during unref.
> +		 */
> +		cmd->send_cmd->in.payload = (u64)buf;
> +	}
> +	cmd->send_cmd->in.size = size;
> +
> +	return 0;
> +}
> +
> +CXL_EXPORT int cxl_cmd_set_output_payload(struct cxl_cmd *cmd, void *buf,
> +		int size)
> +{
> +	struct cxl_memdev *memdev = cmd->memdev;
> +
> +	if (size > memdev->payload_max || size < 0)
> +		return -EINVAL;
> +
> +	if (!buf) {
> +
> +		/* If the user didn't supply a buffer, allocate it */
> +		cmd->output_payload = calloc(1, size);
> +		if (!cmd->output_payload)
> +			return -ENOMEM;
> +		cmd->send_cmd->out.payload = (u64)cmd->output_payload;
> +	} else {
> +		/*
> +		 * Use user-buffer as is. If an automatic allocation was
> +		 * previously made (based on a fixed size from query),
> +		 * it will get freed during unref.
> +		 */
> +		cmd->send_cmd->out.payload = (u64)buf;
> +	}
> +	cmd->send_cmd->out.size = size;
> +
> +	return 0;
> +}
> +
> +static int cxl_cmd_alloc_send(struct cxl_cmd *cmd, u32 cmd_id)
> +{
> +	struct cxl_mem_query_commands *query = cmd->query_cmd;
> +	struct cxl_command_info *cinfo = &query->commands[cmd->query_idx];
> +	size_t size;
> +
> +	if (!query)
> +		return -EINVAL;
> +
> +	size = sizeof(struct cxl_send_command);
> +	cmd->send_cmd = calloc(1, size);
> +	if (!cmd->send_cmd)
> +		return -ENOMEM;
> +
> +	if (cinfo->id != cmd_id)
> +		return -EINVAL;
> +
> +	cmd->send_cmd->id = cmd_id;
> +
> +	if (cinfo->size_in > 0) {
> +		cmd->input_payload = calloc(1, cinfo->size_in);
> +		if (!cmd->input_payload)
> +			return -ENOMEM;
> +		cmd->send_cmd->in.payload = (u64)cmd->input_payload;
> +		cmd->send_cmd->in.size = cinfo->size_in;
> +	}
> +	if (cinfo->size_out > 0) {
> +		cmd->output_payload = calloc(1, cinfo->size_out);
> +		if (!cmd->output_payload)
> +			return -ENOMEM;
> +		cmd->send_cmd->out.payload = (u64)cmd->output_payload;
> +		cmd->send_cmd->out.size = cinfo->size_out;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct cxl_cmd *cxl_cmd_new_generic(struct cxl_memdev *memdev,
> +		u32 cmd_id)
> +{
> +	const char *devname = cxl_memdev_get_devname(memdev);
> +	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +	struct cxl_cmd *cmd;
> +	int rc;
> +
> +	cmd = cxl_cmd_new(memdev);
> +	if (!cmd)
> +		return NULL;
> +
> +	rc = cxl_cmd_do_query(cmd);
> +	if (rc) {
> +		err(ctx, "%s: query returned: %s\n", devname, strerror(-rc));
> +		goto fail;
> +	}
> +
> +	rc = cxl_cmd_validate(cmd, cmd_id);
> +	if (rc) {
> +		errno = -rc;
> +		goto fail;
> +	}
> +
> +	rc = cxl_cmd_alloc_send(cmd, cmd_id);
> +	if (rc) {
> +		errno = -rc;
> +		goto fail;
> +	}
> +
> +	return cmd;
> +
> +fail:
> +	cxl_cmd_unref(cmd);
> +	return NULL;
> +}
> +
> +CXL_EXPORT const char *cxl_cmd_get_devname(struct cxl_cmd *cmd)
> +{
> +	return cxl_memdev_get_devname(cmd->memdev);
> +}
> +
> +CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev,
> +		int opcode)
> +{
> +	struct cxl_cmd *cmd;
> +
> +	/* opcode '0' is reserved */
> +	if (opcode <= 0) {
> +		errno = EINVAL;
> +		return NULL;
> +	}
> +
> +	cmd = cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_RAW);
> +	if (!cmd)
> +		return NULL;
> +
> +	cmd->send_cmd->raw.opcode = opcode;
> +	return cmd;
> +}
> +
> +CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
> +{
> +	struct cxl_memdev *memdev = cmd->memdev;
> +	const char *devname = cxl_memdev_get_devname(memdev);
> +	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +	int rc;
> +
> +	switch (cmd->query_status) {
> +	case CXL_CMD_QUERY_OK:
> +		break;
> +	case CXL_CMD_QUERY_UNSUPPORTED:
> +		return -EOPNOTSUPP;
> +	case CXL_CMD_QUERY_NOT_RUN:
> +		return -EINVAL;
> +	default:
> +		err(ctx, "%s: Unknown query_status %d\n",
> +			devname, cmd->query_status);
> +		return -EINVAL;
> +	}
> +
> +	dbg(ctx, "%s: submitting SEND cmd: in: %d, out: %d\n", devname,
> +		cmd->send_cmd->in.size, cmd->send_cmd->out.size);
> +	rc = do_cmd(cmd, CXL_MEM_SEND_COMMAND);
> +	if (rc < 0)
> +		err(ctx, "%s: send command failed: %s\n",
> +			devname, strerror(-rc));
> +	cmd->status = cmd->send_cmd->retval;
> +	dbg(ctx, "%s: got SEND cmd: in: %d, out: %d, retval: %d\n", devname,
> +		cmd->send_cmd->in.size, cmd->send_cmd->out.size, cmd->status);
> +
> +	return rc;
> +}
> +
> +CXL_EXPORT int cxl_cmd_get_mbox_status(struct cxl_cmd *cmd)
> +{
> +	return cmd->status;
> +}
> +
> +CXL_EXPORT int cxl_cmd_get_out_size(struct cxl_cmd *cmd)
> +{
> +	return cmd->send_cmd->out.size;
> +}
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index fd06790..6e87b80 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -48,6 +48,17 @@ const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
>               memdev != NULL; \
>               memdev = cxl_memdev_get_next(memdev))
>  
> +struct cxl_cmd;
> +const char *cxl_cmd_get_devname(struct cxl_cmd *cmd);
> +struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev, int opcode);
> +int cxl_cmd_set_input_payload(struct cxl_cmd *cmd, void *in, int size);
> +int cxl_cmd_set_output_payload(struct cxl_cmd *cmd, void *out, int size);
> +void cxl_cmd_ref(struct cxl_cmd *cmd);
> +void cxl_cmd_unref(struct cxl_cmd *cmd);
> +int cxl_cmd_submit(struct cxl_cmd *cmd);
> +int cxl_cmd_get_mbox_status(struct cxl_cmd *cmd);
> +int cxl_cmd_get_out_size(struct cxl_cmd *cmd);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 0f6ecad..493429c 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -27,3 +27,16 @@ global:
>  	cxl_memdev_get_ram_size;
>  	cxl_memdev_get_firmware_verison;
>  } LIBCXL_1;
> +
> +LIBCXL_3 {
> +global:
> +	cxl_cmd_get_devname;
> +	cxl_cmd_new_raw;
> +	cxl_cmd_set_input_payload;
> +	cxl_cmd_set_output_payload;
> +	cxl_cmd_ref;
> +	cxl_cmd_unref;
> +	cxl_cmd_submit;
> +	cxl_cmd_get_mbox_status;
> +	cxl_cmd_get_out_size;
> +} LIBCXL_2;
> -- 
> 2.29.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
