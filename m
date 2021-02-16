Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C831CCD8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Feb 2021 16:23:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6FC27100EB84C;
	Tue, 16 Feb 2021 07:23:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8ADFB100EB844
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 07:23:34 -0800 (PST)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dg4Lr56rxz67p01;
	Tue, 16 Feb 2021 23:16:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 16 Feb 2021 16:23:30 +0100
Received: from localhost (10.47.75.223) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 16 Feb
 2021 15:23:29 +0000
Date: Tue, 16 Feb 2021 15:22:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v4 4/9] cxl/mem: Add basic IOCTL interface
Message-ID: <20210216152223.000009e8@Huawei.com>
In-Reply-To: <20210216014538.268106-5-ben.widawsky@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
	<20210216014538.268106-5-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.75.223]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: GQLDVU6EISDWAXI6UVCDSDAGNQF6MJNC
X-Message-ID-Hash: GQLDVU6EISDWAXI6UVCDSDAGNQF6MJNC
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Chris Browy  <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>,  Dan Williams  <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>, "Jon Masters  <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GQLDVU6EISDWAXI6UVCDSDAGNQF6MJNC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 15 Feb 2021 17:45:33 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Add a straightforward IOCTL that provides a mechanism for userspace to
> query the supported memory device commands. CXL commands as they appear
> to userspace are described as part of the UAPI kerneldoc. The command
> list returned via this IOCTL will contain the full set of commands that
> the driver supports, however, some of those commands may not be
> available for use by userspace.
> 
> Memory device commands first appear in the CXL 2.0 specification. They
> are submitted through a mailbox mechanism specified in the CXL 2.0
> specification.
> 
> The send command allows userspace to issue mailbox commands directly to
> the hardware. The list of available commands to send are the output of
> the query command. The driver verifies basic properties of the command
> and possibly inspect the input (or output) payload to determine whether
> or not the command is allowed (or might taint the kernel).
> 
> Reported-by: kernel test robot <lkp@intel.com> # bug in earlier revision
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)

I may be missreading this but I think the logic to ensure commands
using a variable sized buffer have enough space is broken.

Jonathan

> ---
>  .clang-format                                 |   1 +
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  drivers/cxl/mem.c                             | 288 +++++++++++++++++-
>  include/uapi/linux/cxl_mem.h                  | 154 ++++++++++
>  4 files changed, 443 insertions(+), 1 deletion(-)
>  create mode 100644 include/uapi/linux/cxl_mem.h
> 
> diff --git a/.clang-format b/.clang-format
> index 10dc5a9a61b3..3f11c8901b43 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -109,6 +109,7 @@ ForEachMacros:
>    - 'css_for_each_child'
>    - 'css_for_each_descendant_post'
>    - 'css_for_each_descendant_pre'
> +  - 'cxl_for_each_cmd'
>    - 'device_for_each_child_node'
>    - 'dma_fence_chain_for_each'
>    - 'do_for_each_ftrace_op'
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a4c75a28c839..6eb8e634664d 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -352,6 +352,7 @@ Code  Seq#    Include File                                           Comments
>                                                                       <mailto:michael.klein@puffin.lb.shuttle.de>
>  0xCC  00-0F  drivers/misc/ibmvmc.h                                   pseries VMC driver
>  0xCD  01     linux/reiserfs_fs.h
> +0xCE  01-02  uapi/linux/cxl_mem.h                                    Compute Express Link Memory Devices
>  0xCF  02     fs/cifs/ioctl.c
>  0xDB  00-0F  drivers/char/mwave/mwavepub.h
>  0xDD  00-3F                                                          ZFCP device driver see drivers/s390/scsi/
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 410adb1bdffc..a4298cb1182d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <uapi/linux/cxl_mem.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/cdev.h>
> @@ -40,6 +41,7 @@
>  #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
>  
>  enum opcode {
> +	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
> @@ -91,6 +93,49 @@ struct cxl_memdev {
>  static int cxl_mem_major;
>  static DEFINE_IDA(cxl_memdev_ida);
>  
> +/**
> + * struct cxl_mem_command - Driver representation of a memory device command
> + * @info: Command information as it exists for the UAPI
> + * @opcode: The actual bits used for the mailbox protocol
> + *
> + * The cxl_mem_command is the driver's internal representation of commands that
> + * are supported by the driver. Some of these commands may not be supported by
> + * the hardware. The driver will use @info to validate the fields passed in by
> + * the user then submit the @opcode to the hardware.
> + *
> + * See struct cxl_command_info.
> + */
> +struct cxl_mem_command {
> +	struct cxl_command_info info;
> +	enum opcode opcode;
> +};
> +
> +#define CXL_CMD(_id, sin, sout)                                                \
> +	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
> +	.info =	{                                                              \
> +			.id = CXL_MEM_COMMAND_ID_##_id,                        \
> +			.size_in = sin,                                        \
> +			.size_out = sout,                                      \
> +		},                                                             \
> +	.opcode = CXL_MBOX_OP_##_id,                                           \
> +	}
> +
> +/*
> + * This table defines the supported mailbox commands for the driver. This table
> + * is made up of a UAPI structure. Non-negative values as parameters in the
> + * table will be validated against the user's input. For example, if size_in is
> + * 0, and the user passed in 1, it is an error.
> + */
> +static struct cxl_mem_command mem_commands[] = {
> +	CXL_CMD(IDENTIFY, 0, 0x43),
> +};
> +
> +#define cxl_for_each_cmd(cmd)                                                  \
> +	for ((cmd) = &mem_commands[0];                                         \
> +	     ((cmd) - mem_commands) < ARRAY_SIZE(mem_commands); (cmd)++)
> +
> +#define cxl_cmd_count ARRAY_SIZE(mem_commands)
> +
>  static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
>  {
>  	const unsigned long start = jiffies;
> @@ -312,6 +357,247 @@ static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
>  	mutex_unlock(&cxlm->mbox_mutex);
>  }
>  
> +/**
> + * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
> + * @cxlm: The CXL memory device to communicate with.
> + * @cmd: The validated command.
> + * @in_payload: Pointer to userspace's input payload.
> + * @out_payload: Pointer to userspace's output payload.
> + * @size_out: (Input) Max payload size to copy out.
> + *            (Output) Payload size hardware generated.
> + * @retval: Hardware generated return code from the operation.
> + *
> + * Return:
> + *  * %0	- Mailbox transaction succeeded. This implies the mailbox
> + *  		  protocol completed successfully not that the operation itself
> + *  		  was successful.
> + *  * %-ENOMEM  - Couldn't allocate a bounce buffer.
> + *  * %-EFAULT	- Something happened with copy_to/from_user.
> + *  * %-EINTR	- Mailbox acquisition interrupted.
> + *  * %-*	- Transaction level failures.
> + *
> + * Creates the appropriate mailbox command and dispatches it on behalf of a
> + * userspace request. The input and output payloads are copied between
> + * userspace.
> + *
> + * See cxl_send_cmd().
> + */
> +static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
> +					const struct cxl_mem_command *cmd,
> +					u64 in_payload, u64 out_payload,
> +					s32 *size_out, u32 *retval)
> +{
> +	struct device *dev = &cxlm->pdev->dev;
> +	struct mbox_cmd mbox_cmd = {
> +		.opcode = cmd->opcode,
> +		.size_in = cmd->info.size_in,
> +	};
> +	int rc;
> +
> +	if (cmd->info.size_out) {
> +		mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
> +		if (!mbox_cmd.payload_out)
> +			return -ENOMEM;
> +	}
> +
> +	if (cmd->info.size_in) {
> +		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
> +		if (!mbox_cmd.payload_in) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +
> +		if (copy_from_user(mbox_cmd.payload_in,
> +				   u64_to_user_ptr(in_payload),
> +				   cmd->info.size_in)) {
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +	}
> +
> +	rc = cxl_mem_mbox_get(cxlm);
> +	if (rc)
> +		goto out;
> +
> +	dev_dbg(dev,
> +		"Submitting %s command for user\n"
> +		"\topcode: %x\n"
> +		"\tsize: %ub\n",
> +		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
> +		cmd->info.size_in);
> +
> +	rc = __cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> +	cxl_mem_mbox_put(cxlm);
> +	if (rc)
> +		goto out;
> +
> +	/*
> +	 * @size_out contains the max size that's allowed to be written back out
> +	 * to userspace. While the payload may have written more output than
> +	 * this it will have to be ignored.
> +	 */

See below for why I don't think this works. The size of mbox_cmd.payload_out
seems to always be the size userspace specified, never the 1MB this code
is assuming.  So if the hardware returns more than userspace asks for you
have a buffer overrun.


> +	if (mbox_cmd.size_out) {
> +		if (copy_to_user(u64_to_user_ptr(out_payload),
> +				 mbox_cmd.payload_out, *size_out)) {
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +	}
> +
> +	/*
> +	 * Reporting the actual size, even if it was greater than @size_out
> +	 * allows userspace to try the command again with a bigger buffer.
> +	 */
> +	*size_out = mbox_cmd.size_out;
> +	*retval = mbox_cmd.return_code;
> +
> +out:
> +	kvfree(mbox_cmd.payload_in);
> +	kvfree(mbox_cmd.payload_out);
> +	return rc;
> +}
> +
> +/**
> + * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
> + * @cxlm: &struct cxl_mem device whose mailbox will be used.
> + * @send_cmd: &struct cxl_send_command copied in from userspace.
> + * @out_cmd: Sanitized and populated &struct cxl_mem_command.
> + *
> + * Return:
> + *  * %0	- @out_cmd is ready to send.
> + *  * %-ENOTTY	- Invalid command specified.
> + *  * %-EINVAL	- Reserved fields or invalid values were used.
> + *  * %-ENOMEM	- Input or output buffer wasn't sized properly.
> + *
> + * The result of this command is a fully validated command in @out_cmd that is
> + * safe to send to the hardware.
> + *
> + * See handle_mailbox_cmd_from_user()
> + */
> +static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
> +				      const struct cxl_send_command *send_cmd,
> +				      struct cxl_mem_command *out_cmd)
> +{
> +	const struct cxl_command_info *info;
> +	struct cxl_mem_command *c;
> +
> +	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
> +		return -ENOTTY;
> +
> +	/*
> +	 * The user can never specify an input payload larger than what hardware
> +	 * supports, but output can be arbitrarily large (simply write out as
> +	 * much data as the hardware provides).
> +	 */
> +	if (send_cmd->in.size > cxlm->payload_size)
> +		return -EINVAL;
> +
> +	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
> +		return -EINVAL;
> +
> +	if (send_cmd->rsvd)
> +		return -EINVAL;
> +
> +	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
> +		return -EINVAL;
> +
> +	/* Convert user's command into the internal representation */
> +	c = &mem_commands[send_cmd->id];
> +	info = &c->info;
> +
> +	/* Check the input buffer is the expected size */
> +	if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
> +		return -ENOMEM;
> +
> +	/* Check the output buffer is at least large enough */
> +	if (info->size_out >= 0 && send_cmd->out.size < info->size_out)
> +		return -ENOMEM;
> +
> +	memcpy(out_cmd, c, sizeof(*c));
> +	out_cmd->info.size_in = send_cmd->in.size;
> +	out_cmd->info.size_out = send_cmd->out.size;
> +
> +	return 0;
> +}
> +
> +static int cxl_query_cmd(struct cxl_memdev *cxlmd,
> +			 struct cxl_mem_query_commands __user *q)
> +{
> +	struct device *dev = &cxlmd->dev;
> +	struct cxl_mem_command *cmd;
> +	u32 n_commands;
> +	int j = 0;
> +
> +	dev_dbg(dev, "Query IOCTL\n");
> +
> +	if (get_user(n_commands, &q->n_commands))
> +		return -EFAULT;
> +
> +	/* returns the total number if 0 elements are requested. */
> +	if (n_commands == 0)
> +		return put_user(cxl_cmd_count, &q->n_commands);
> +
> +	/*
> +	 * otherwise, return max(n_commands, total commands) cxl_command_info
> +	 * structures.
> +	 */
> +	cxl_for_each_cmd(cmd) {
> +		const struct cxl_command_info *info = &cmd->info;
> +
> +		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> +			return -EFAULT;
> +
> +		if (j == n_commands)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_send_cmd(struct cxl_memdev *cxlmd,
> +			struct cxl_send_command __user *s)
> +{
> +	struct cxl_mem *cxlm = cxlmd->cxlm;
> +	struct device *dev = &cxlmd->dev;
> +	struct cxl_send_command send;
> +	struct cxl_mem_command c;
> +	int rc;
> +
> +	dev_dbg(dev, "Send IOCTL\n");
> +
> +	if (copy_from_user(&send, s, sizeof(send)))
> +		return -EFAULT;
> +
> +	rc = cxl_validate_cmd_from_user(cxlmd->cxlm, &send, &c);
> +	if (rc)
> +		return rc;

Userspace will pass in send.out set to the size of it's available buffer.
Then cxl_validate_cmd_from_user() will fill
c.info.size_out with send.out.size

> +
> +	/* Prepare to handle a full payload for variable sized output */
> +	if (c.info.size_out < 0)

So this check only works if userspace set the command to have variable size.
That's not what the docs below suggest should happen.

> +		c.info.size_out = cxlm->payload_size;
> +
> +	rc = handle_mailbox_cmd_from_user(cxlm, &c, send.in.payload,
> +					  send.out.payload, &send.out.size,
> +					  &send.retval);
> +	if (rc)
> +		return rc;
> +
> +	return copy_to_user(s, &send, sizeof(send));
> +}
> +
> +static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
> +			       unsigned long arg)
> +{
> +	switch (cmd) {
> +	case CXL_MEM_QUERY_COMMANDS:
> +		return cxl_query_cmd(cxlmd, (void __user *)arg);
> +	case CXL_MEM_SEND_COMMAND:
> +		return cxl_send_cmd(cxlmd, (void __user *)arg);
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
>  static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
>  			     unsigned long arg)
>  {
> @@ -325,7 +611,7 @@ static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
>  	if (!percpu_ref_tryget_live(&cxlmd->ops_active))
>  		return -ENXIO;
>  
> -	/* TODO: ioctl body */
> +	rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
>  
>  	percpu_ref_put(&cxlmd->ops_active);
>  
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> new file mode 100644
> index 000000000000..18cea908ad0b
> --- /dev/null
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -0,0 +1,154 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * CXL IOCTLs for Memory Devices
> + */
> +
> +#ifndef _UAPI_CXL_MEM_H_
> +#define _UAPI_CXL_MEM_H_
> +
> +#include <linux/types.h>
> +
> +/**
> + * DOC: UAPI
> + *
> + * Not all of all commands that the driver supports are always available for use
> + * by userspace. Userspace must check the results from the QUERY command in
> + * order to determine the live set of commands.
> + */
> +
> +#define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
> +#define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
> +
> +#define CXL_CMDS                                                          \
> +	___C(INVALID, "Invalid Command"),                                 \
> +	___C(IDENTIFY, "Identify Command"),                               \
> +	___C(MAX, "invalid / last command")
> +
> +#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> +enum { CXL_CMDS };
> +
> +#undef ___C
> +#define ___C(a, b) { b }
> +static const struct {
> +	const char *name;
> +} cxl_command_names[] = { CXL_CMDS };
> +
> +/*
> + * Here's how this actually breaks out:
> + * cxl_command_names[] = {
> + *	[CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
> + *	[CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Command" },
> + *	...
> + *	[CXL_MEM_COMMAND_ID_MAX] = { "invalid / last command" },
> + * };
> + */

Thanks, this is great.

> +
> +#undef ___C
> +
> +/**
> + * struct cxl_command_info - Command information returned from a query.
> + * @id: ID number for the command.
> + * @flags: Flags that specify command behavior.
> + * @size_in: Expected input size, or -1 if variable length.
> + * @size_out: Expected output size, or -1 if variable length.
> + *
> + * Represents a single command that is supported by both the driver and the
> + * hardware. This is returned as part of an array from the query ioctl. The
> + * following would be a command that takes a variable length input and returns 0
> + * bytes of output.
> + *
> + *  - @id = 10
> + *  - @flags = 0
> + *  - @size_in = -1
> + *  - @size_out = 0
> + *
> + * See struct cxl_mem_query_commands.
> + */
> +struct cxl_command_info {
> +	__u32 id;
> +
> +	__u32 flags;
> +#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(0, 0)
> +
> +	__s32 size_in;
> +	__s32 size_out;
> +};
> +
> +/**
> + * struct cxl_mem_query_commands - Query supported commands.
> + * @n_commands: In/out parameter. When @n_commands is > 0, the driver will
> + *		return min(num_support_commands, n_commands). When @n_commands
> + *		is 0, driver will return the number of total supported commands.
> + * @rsvd: Reserved for future use.
> + * @commands: Output array of supported commands. This array must be allocated
> + *            by userspace to be at least min(num_support_commands, @n_commands)
> + *
> + * Allow userspace to query the available commands supported by both the driver,
> + * and the hardware. Commands that aren't supported by either the driver, or the
> + * hardware are not returned in the query.
> + *
> + * Examples:
> + *
> + *  - { .n_commands = 0 } // Get number of supported commands
> + *  - { .n_commands = 15, .commands = buf } // Return first 15 (or less)
> + *    supported commands
> + *
> + *  See struct cxl_command_info.
> + */
> +struct cxl_mem_query_commands {
> +	/*
> +	 * Input: Number of commands to return (space allocated by user)
> +	 * Output: Number of commands supported by the driver/hardware
> +	 *
> +	 * If n_commands is 0, kernel will only return number of commands and
> +	 * not try to populate commands[], thus allowing userspace to know how
> +	 * much space to allocate
> +	 */

This is fairly well described in the docs above the structure.
Perhaps combine the two.

> +	__u32 n_commands;
> +	__u32 rsvd;
> +
> +	struct cxl_command_info __user commands[]; /* out: supported commands */
> +};
> +
> +/**
> + * struct cxl_send_command - Send a command to a memory device.
> + * @id: The command to send to the memory device. This must be one of the
> + *	commands returned by the query command.
> + * @flags: Flags for the command (input).
> + * @rsvd: Must be zero.
> + * @retval: Return value from the memory device (output).
> + * @in.size: Size of the payload to provide to the device (input).
> + * @in.rsvd: Must be zero.
> + * @in.payload: Pointer to memory for payload input, payload is little endian.
> + * @out.size: Size of the payload received from the device (input/output). This
> + *	      field is filled in by userspace to let the driver know how much
> + *	      space was allocated for output. It is populated by the driver to
> + *	      let userspace know how large the output payload actually was.
> + * @out.rsvd: Must be zero.
> + * @out.payload: Pointer to memory for payload output, payload is little endian.
> + *
> + * Mechanism for userspace to send a command to the hardware for processing. The
> + * driver will do basic validation on the command sizes. In some cases even the
> + * payload may be introspected. Userspace is required to allocate large enough
> + * buffers for size_out which can be variable length in certain situations.
> + */
> +struct cxl_send_command {
> +	__u32 id;
> +	__u32 flags;
> +	__u32 rsvd;
> +	__u32 retval;
> +
> +	struct {
> +		__s32 size;
> +		__u32 rsvd;
> +		__u64 payload;
> +	} in;
> +
> +	struct {
> +		__s32 size;
> +		__u32 rsvd;
> +		__u64 payload;
> +	} out;
> +};
> +
> +#endif
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
