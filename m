Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CA318946
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 12:20:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A8C9100EA93D;
	Thu, 11 Feb 2021 03:20:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A2561100EA938
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 03:20:29 -0800 (PST)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbvGN3HQ6z67nD6;
	Thu, 11 Feb 2021 19:16:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 11 Feb 2021 12:20:26 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 11:20:25 +0000
Date: Thu, 11 Feb 2021 11:19:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Message-ID: <20210211111924.000019a5@Huawei.com>
In-Reply-To: <20210210000259.635748-6-ben.widawsky@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
	<20210210000259.635748-6-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: 3UCXZYKSKQHGVPGVGFC52ZBUH4R524AQ
X-Message-ID-Hash: 3UCXZYKSKQHGVPGVGFC52ZBUH4R524AQ
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Chris Browy  <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>,  Dan Williams  <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>, "Jon Masters  <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, Ariel Sibley <Ariel.Sibley@microchip.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3UCXZYKSKQHGVPGVGFC52ZBUH4R524AQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 9 Feb 2021 16:02:56 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The CXL memory device send interface will have a number of supported
> commands. The raw command is not such a command. Raw commands allow
> userspace to send a specified opcode to the underlying hardware and
> bypass all driver checks on the command. This is useful for a couple of
> usecases, mainly:
> 1. Undocumented vendor specific hardware commands

This one I get.  There are things we'd love to standardize but often they
need proving in a generation of hardware before the data is available to
justify taking it to a standards body.  Stuff like performance stats.
This stuff will all sit in the vendor defined range.  Maybe there is an
argument for in driver hooks to allow proper support even for these
(Ben mentioned this in the other branch of the thread).

> 2. Prototyping new hardware commands not yet supported by the driver

For 2, could just have a convenient place to enable this by one line patch.
Some subsystems (SPI comes to mind) do this for their equivalent of raw
commands.  The code is all there to enable it but you need to hook it
up if you want to use it.  Avoids chance of a distro shipping it.

> 
> While this all sounds very powerful it comes with a couple of caveats:
> 1. Bug reports using raw commands will not get the same level of
>    attention as bug reports using supported commands (via taint).
> 2. Supported commands will be rejected by the RAW command.

Perhaps I'm missing reading this point 2 (not sure the code actually does it!)

As stated what worries me as it means when we add support for a new
bit of the spec we just broke the userspace ABI.

> 
> With this comes new debugfs knob to allow full access to your toes with
> your weapon of choice.

A few trivial things inline,

Jonathan

> 
> Cc: Ariel Sibley <Ariel.Sibley@microchip.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/Kconfig          |  18 +++++
>  drivers/cxl/mem.c            | 125 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/cxl_mem.h |  12 +++-
>  3 files changed, 152 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index c4ba3aa0a05d..08eaa8e52083 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -33,6 +33,24 @@ config CXL_MEM
>  
>  	  If unsure say 'm'.
>  
> +config CXL_MEM_RAW_COMMANDS
> +	bool "RAW Command Interface for Memory Devices"
> +	depends on CXL_MEM
> +	help
> +	  Enable CXL RAW command interface.
> +
> +	  The CXL driver ioctl interface may assign a kernel ioctl command
> +	  number for each specification defined opcode. At any given point in
> +	  time the number of opcodes that the specification defines and a device
> +	  may implement may exceed the kernel's set of associated ioctl function
> +	  numbers. The mismatch is either by omission, specification is too new,
> +	  or by design. When prototyping new hardware, or developing / debugging
> +	  the driver it is useful to be able to submit any possible command to
> +	  the hardware, even commands that may crash the kernel due to their
> +	  potential impact to memory currently in use by the kernel.
> +
> +	  If developing CXL hardware or the driver say Y, otherwise say N.
> +
>  config CXL_MEM_INSECURE_DEBUG
>  	bool "CXL.mem debugging"
>  	depends on CXL_MEM
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index ce65630bb75e..6d766a994dce 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #include <uapi/linux/cxl_mem.h>
> +#include <linux/security.h>
> +#include <linux/debugfs.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/cdev.h>
> @@ -41,7 +43,14 @@
>  
>  enum opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
> +	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> +	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> +	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> +	CXL_MBOX_OP_SET_LSA		= 0x4103,
> +	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
> +	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
> +	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  
> @@ -91,6 +100,8 @@ struct cxl_memdev {
>  
>  static int cxl_mem_major;
>  static DEFINE_IDA(cxl_memdev_ida);
> +static struct dentry *cxl_debugfs;
> +static bool raw_allow_all;
>  
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
> @@ -132,6 +143,49 @@ struct cxl_mem_command {
>   */
>  static struct cxl_mem_command mem_commands[] = {
>  	CXL_CMD(IDENTIFY, NONE, 0, 0x43),
> +#ifdef CONFIG_CXL_MEM_RAW_COMMANDS
> +	CXL_CMD(RAW, NONE, ~0, ~0),
> +#endif
> +};
> +
> +/*
> + * Commands that RAW doesn't permit. The rationale for each:
> + *
> + * CXL_MBOX_OP_ACTIVATE_FW: Firmware activation requires adjustment /
> + * coordination of transaction timeout values at the root bridge level.
> + *
> + * CXL_MBOX_OP_SET_PARTITION_INFO: The device memory map may change live
> + * and needs to be coordinated with HDM updates.
> + *
> + * CXL_MBOX_OP_SET_LSA: The label storage area may be cached by the
> + * driver and any writes from userspace invalidates those contents.
> + *
> + * CXL_MBOX_OP_SET_SHUTDOWN_STATE: Set shutdown state assumes no writes
> + * to the device after it is marked clean, userspace can not make that
> + * assertion.
> + *
> + * CXL_MBOX_OP_[GET_]SCAN_MEDIA: The kernel provides a native error list that
> + * is kept up to date with patrol notifications and error management.
> + */
> +static u16 disabled_raw_commands[] = {
> +	CXL_MBOX_OP_ACTIVATE_FW,
> +	CXL_MBOX_OP_SET_PARTITION_INFO,
> +	CXL_MBOX_OP_SET_LSA,
> +	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
> +	CXL_MBOX_OP_SCAN_MEDIA,
> +	CXL_MBOX_OP_GET_SCAN_MEDIA,
> +};
> +
> +/*
> + * Command sets that RAW doesn't permit. All opcodes in this set are
> + * disabled because they pass plain text security payloads over the
> + * user/kernel boundary. This functionality is intended to be wrapped
> + * behind the keys ABI which allows for encrypted payloads in the UAPI
> + */
> +static u8 security_command_sets[] = {
> +	0x44, /* Sanitize */
> +	0x45, /* Persistent Memory Data-at-rest Security */
> +	0x46, /* Security Passthrough */
>  };
>  
>  #define cxl_for_each_cmd(cmd)                                                  \
> @@ -162,6 +216,16 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
>  	return 0;
>  }
>  
> +static bool is_security_command(u16 opcode)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(security_command_sets); i++)
> +		if (security_command_sets[i] == (opcode >> 8))
> +			return true;
> +	return false;
> +}
> +
>  static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
>  				 struct mbox_cmd *mbox_cmd)
>  {
> @@ -170,7 +234,8 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
>  	dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
>  		mbox_cmd->opcode, mbox_cmd->size_in);
>  
> -	if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
> +	if (!is_security_command(mbox_cmd->opcode) ||
> +	    IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
>  		print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
>  				     mbox_cmd->payload_in, mbox_cmd->size_in,
>  				     true);
> @@ -434,6 +499,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
>  		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
>  		cmd->info.size_in);
>  
> +	dev_WARN_ONCE(dev, cmd->info.id == CXL_MEM_COMMAND_ID_RAW,
> +		      "raw command path used\n");
> +
>  	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
>  	cxl_mem_mbox_put(cxlm);
>  	if (rc)
> @@ -464,6 +532,29 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
>  	return rc;
>  }
>  
> +static bool cxl_mem_raw_command_allowed(u16 opcode)
> +{
> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
> +		return false;
> +
> +	if (security_locked_down(LOCKDOWN_NONE))
> +		return false;
> +
> +	if (raw_allow_all)
> +		return true;
> +
> +	if (is_security_command(opcode))
Given we are mixing generic calls like security_locked_down()
and local cxl specific ones like this one, prefix the
local versions.

cxl_is_security_command()

I'd also have a slight preference to do it for cxl_disabled_raw_commands
and cxl_raw_allow_all though they are less important as more obviously
local by not being function calls.

> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(disabled_raw_commands); i++)
> +		if (disabled_raw_commands[i] == opcode)
> +			return false;
> +
> +	return true;
> +}
> +
>  /**
>   * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
>   * @cxlm: &struct cxl_mem device whose mailbox will be used.
> @@ -500,6 +591,29 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
>  	if (send_cmd->in.size > cxlm->payload_size)
>  		return -EINVAL;
>  
> +	/* Checks are bypassed for raw commands but along comes the taint! */
> +	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW) {
> +		const struct cxl_mem_command temp = {
> +			.info = {
> +				.id = CXL_MEM_COMMAND_ID_RAW,
> +				.flags = CXL_MEM_COMMAND_FLAG_NONE,
> +				.size_in = send_cmd->in.size,
> +				.size_out = send_cmd->out.size,
> +			},
> +			.opcode = send_cmd->raw.opcode
> +		};
> +
> +		if (send_cmd->raw.rsvd)
> +			return -EINVAL;
> +
> +		if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
> +			return -EPERM;
> +
> +		memcpy(out_cmd, &temp, sizeof(temp));
> +
> +		return 0;
> +	}
> +
>  	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
>  		return -EINVAL;
>  
> @@ -1123,8 +1237,9 @@ static struct pci_driver cxl_mem_driver = {
>  
>  static __init int cxl_mem_init(void)
>  {
> -	int rc;
> +	struct dentry *mbox_debugfs;
>  	dev_t devt;
> +	int rc;

Shuffle this back to the place it was introduced to reduce patch noise.

>  
>  	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
>  	if (rc)
> @@ -1139,11 +1254,17 @@ static __init int cxl_mem_init(void)
>  		return rc;
>  	}
>  
> +	cxl_debugfs = debugfs_create_dir("cxl", NULL);
> +	mbox_debugfs = debugfs_create_dir("mbox", cxl_debugfs);
> +	debugfs_create_bool("raw_allow_all", 0600, mbox_debugfs,
> +			    &raw_allow_all);
> +
>  	return 0;
>  }
>  
>  static __exit void cxl_mem_exit(void)
>  {
> +	debugfs_remove_recursive(cxl_debugfs);
>  	pci_unregister_driver(&cxl_mem_driver);
>  	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
>  }
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index f1f7e9f32ea5..72d1eb601a5d 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -22,6 +22,7 @@
>  #define CXL_CMDS                                                          \
>  	___C(INVALID, "Invalid Command"),                                 \
>  	___C(IDENTIFY, "Identify Command"),                               \
> +	___C(RAW, "Raw device command"),                                  \
>  	___C(MAX, "Last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> @@ -112,6 +113,9 @@ struct cxl_mem_query_commands {
>   * @id: The command to send to the memory device. This must be one of the
>   *	commands returned by the query command.
>   * @flags: Flags for the command (input).
> + * @raw: Special fields for raw commands
> + * @raw.opcode: Opcode passed to hardware when using the RAW command.
> + * @raw.rsvd: Must be zero.
>   * @rsvd: Must be zero.
>   * @retval: Return value from the memory device (output).
>   * @in.size: Size of the payload to provide to the device (input).
> @@ -133,7 +137,13 @@ struct cxl_mem_query_commands {
>  struct cxl_send_command {
>  	__u32 id;
>  	__u32 flags;
> -	__u32 rsvd;
> +	union {
> +		struct {
> +			__u16 opcode;
> +			__u16 rsvd;
> +		} raw;
> +		__u32 rsvd;
> +	};
>  	__u32 retval;
>  
>  	struct {
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
