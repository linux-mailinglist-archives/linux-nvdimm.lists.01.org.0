Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE1B31D3B8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 02:17:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA6E4100F2248;
	Tue, 16 Feb 2021 17:17:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 93F17100F2244
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 17:17:07 -0800 (PST)
IronPort-SDR: VpIHQOwbaBzMfqUkS2BKKIAcTjysoOXZOOqp7AArqDihPa8h0C7nY6hYS5zPRUkKNBrjVRQsxT
 NSKX+wOmIA6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="170100835"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400";
   d="scan'208";a="170100835"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 10:03:44 -0800
IronPort-SDR: I+0jQvWTgVwWYWihxRoHjRAorf/u7YyCUpZ8v8aP0SZTjpOOpUyox42PjDK+YqA37NK+KV6LD5
 FZ+yNSxZ15nQ==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400";
   d="scan'208";a="580582893"
Received: from dlbingha-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.134.31])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 10:03:43 -0800
Date: Tue, 16 Feb 2021 10:03:42 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 5/9] cxl/mem: Add a "RAW" send command
Message-ID: <20210216180342.zh5sx65gee2izhxr@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
 <20210216014538.268106-6-ben.widawsky@intel.com>
 <20210216153026.00005e33@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210216153026.00005e33@Huawei.com>
Message-ID-Hash: RY3OIXGYYQXLDNSMAFWDDKV2JRFH5HPC
X-Message-ID-Hash: RY3OIXGYYQXLDNSMAFWDDKV2JRFH5HPC
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, Ariel Sibley <Ariel.Sibley@microchip.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RY3OIXGYYQXLDNSMAFWDDKV2JRFH5HPC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-16 15:30:26, Jonathan Cameron wrote:
> On Mon, 15 Feb 2021 17:45:34 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > The CXL memory device send interface will have a number of supported
> > commands. The raw command is not such a command. Raw commands allow
> > userspace to send a specified opcode to the underlying hardware and
> > bypass all driver checks on the command. The primary use for this
> > command is to [begrudgingly] allow undocumented vendor specific hardware
> > commands.
> > 
> > While not the main motivation, it also allows prototyping new hardware
> > commands without a driver patch and rebuild.
> > 
> > While this all sounds very powerful it comes with a couple of caveats:
> > 1. Bug reports using raw commands will not get the same level of
> >    attention as bug reports using supported commands (via taint).
> > 2. Supported commands will be rejected by the RAW command.
> > 
> > With this comes new debugfs knob to allow full access to your toes with
> > your weapon of choice.
> > 
> > Cc: Ariel Sibley <Ariel.Sibley@microchip.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)
> 
> Whilst I'm definitely dubious about introducing this interface
> so early in development, I haven't found any problems with 'how' it
> has been done.
> 

FWIW, it's already helpful for regression testing. ndctl/cxl(1) will make use of
it for validating driver internals and our QEMU emulation. I don't mean to imply
that's the only usage.

> I guess it's now just up to us to hassle our hardware colleagues into
> only using this facility when absolutely necessary...

Yes. I think having distros not enable the Kconfig option is going to be the
best path in the early days so they don't get used to having it available.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/Kconfig          |  18 +++++
> >  drivers/cxl/mem.c            | 132 +++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/cxl_mem.h |  12 +++-
> >  3 files changed, 161 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 9e80b311e928..97dc4d751651 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -32,4 +32,22 @@ config CXL_MEM
> >  	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
> >  
> >  	  If unsure say 'm'.
> > +
> > +config CXL_MEM_RAW_COMMANDS
> > +	bool "RAW Command Interface for Memory Devices"
> > +	depends on CXL_MEM
> > +	help
> > +	  Enable CXL RAW command interface.
> > +
> > +	  The CXL driver ioctl interface may assign a kernel ioctl command
> > +	  number for each specification defined opcode. At any given point in
> > +	  time the number of opcodes that the specification defines and a device
> > +	  may implement may exceed the kernel's set of associated ioctl function
> > +	  numbers. The mismatch is either by omission, specification is too new,
> > +	  or by design. When prototyping new hardware, or developing / debugging
> > +	  the driver it is useful to be able to submit any possible command to
> > +	  the hardware, even commands that may crash the kernel due to their
> > +	  potential impact to memory currently in use by the kernel.
> > +
> > +	  If developing CXL hardware or the driver say Y, otherwise say N.
> >  endif
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index a4298cb1182d..6b4feb0ce47d 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -1,6 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> >  #include <uapi/linux/cxl_mem.h>
> > +#include <linux/security.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/cdev.h>
> > @@ -42,7 +44,14 @@
> >  
> >  enum opcode {
> >  	CXL_MBOX_OP_INVALID		= 0x0000,
> > +	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> > +	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> >  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> > +	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> > +	CXL_MBOX_OP_SET_LSA		= 0x4103,
> > +	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
> > +	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
> > +	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> >  	CXL_MBOX_OP_MAX			= 0x10000
> >  };
> >  
> > @@ -92,6 +101,8 @@ struct cxl_memdev {
> >  
> >  static int cxl_mem_major;
> >  static DEFINE_IDA(cxl_memdev_ida);
> > +static struct dentry *cxl_debugfs;
> > +static bool cxl_raw_allow_all;
> >  
> >  /**
> >   * struct cxl_mem_command - Driver representation of a memory device command
> > @@ -128,6 +139,49 @@ struct cxl_mem_command {
> >   */
> >  static struct cxl_mem_command mem_commands[] = {
> >  	CXL_CMD(IDENTIFY, 0, 0x43),
> > +#ifdef CONFIG_CXL_MEM_RAW_COMMANDS
> > +	CXL_CMD(RAW, ~0, ~0),
> > +#endif
> > +};
> > +
> > +/*
> > + * Commands that RAW doesn't permit. The rationale for each:
> > + *
> > + * CXL_MBOX_OP_ACTIVATE_FW: Firmware activation requires adjustment /
> > + * coordination of transaction timeout values at the root bridge level.
> > + *
> > + * CXL_MBOX_OP_SET_PARTITION_INFO: The device memory map may change live
> > + * and needs to be coordinated with HDM updates.
> > + *
> > + * CXL_MBOX_OP_SET_LSA: The label storage area may be cached by the
> > + * driver and any writes from userspace invalidates those contents.
> > + *
> > + * CXL_MBOX_OP_SET_SHUTDOWN_STATE: Set shutdown state assumes no writes
> > + * to the device after it is marked clean, userspace can not make that
> > + * assertion.
> > + *
> > + * CXL_MBOX_OP_[GET_]SCAN_MEDIA: The kernel provides a native error list that
> > + * is kept up to date with patrol notifications and error management.
> > + */
> > +static u16 cxl_disabled_raw_commands[] = {
> > +	CXL_MBOX_OP_ACTIVATE_FW,
> > +	CXL_MBOX_OP_SET_PARTITION_INFO,
> > +	CXL_MBOX_OP_SET_LSA,
> > +	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
> > +	CXL_MBOX_OP_SCAN_MEDIA,
> > +	CXL_MBOX_OP_GET_SCAN_MEDIA,
> > +};
> > +
> > +/*
> > + * Command sets that RAW doesn't permit. All opcodes in this set are
> > + * disabled because they pass plain text security payloads over the
> > + * user/kernel boundary. This functionality is intended to be wrapped
> > + * behind the keys ABI which allows for encrypted payloads in the UAPI
> > + */
> > +static u8 security_command_sets[] = {
> > +	0x44, /* Sanitize */
> > +	0x45, /* Persistent Memory Data-at-rest Security */
> > +	0x46, /* Security Passthrough */
> >  };
> >  
> >  #define cxl_for_each_cmd(cmd)                                                  \
> > @@ -158,6 +212,16 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> >  	return 0;
> >  }
> >  
> > +static bool cxl_is_security_command(u16 opcode)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(security_command_sets); i++)
> > +		if (security_command_sets[i] == (opcode >> 8))
> > +			return true;
> > +	return false;
> > +}
> > +
> >  static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> >  				 struct mbox_cmd *mbox_cmd)
> >  {
> > @@ -426,6 +490,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
> >  		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
> >  		cmd->info.size_in);
> >  
> > +	dev_WARN_ONCE(dev, cmd->info.id == CXL_MEM_COMMAND_ID_RAW,
> > +		      "raw command path used\n");
> > +
> >  	rc = __cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> >  	cxl_mem_mbox_put(cxlm);
> >  	if (rc)
> > @@ -457,6 +524,29 @@ static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
> >  	return rc;
> >  }
> >  
> > +static bool cxl_mem_raw_command_allowed(u16 opcode)
> > +{
> > +	int i;
> > +
> > +	if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
> > +		return false;
> > +
> > +	if (security_locked_down(LOCKDOWN_NONE))
> > +		return false;
> > +
> > +	if (cxl_raw_allow_all)
> > +		return true;
> > +
> > +	if (cxl_is_security_command(opcode))
> > +		return false;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(cxl_disabled_raw_commands); i++)
> > +		if (cxl_disabled_raw_commands[i] == opcode)
> > +			return false;
> > +
> > +	return true;
> > +}
> > +
> >  /**
> >   * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
> >   * @cxlm: &struct cxl_mem device whose mailbox will be used.
> > @@ -468,6 +558,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
> >   *  * %-ENOTTY	- Invalid command specified.
> >   *  * %-EINVAL	- Reserved fields or invalid values were used.
> >   *  * %-ENOMEM	- Input or output buffer wasn't sized properly.
> > + *  * %-EPERM	- Attempted to use a protected command.
> >   *
> >   * The result of this command is a fully validated command in @out_cmd that is
> >   * safe to send to the hardware.
> > @@ -492,6 +583,40 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
> >  	if (send_cmd->in.size > cxlm->payload_size)
> >  		return -EINVAL;
> >  
> > +	/*
> > +	 * Checks are bypassed for raw commands but a WARN/taint will occur
> > +	 * later in the callchain
> > +	 */
> > +	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW) {
> > +		const struct cxl_mem_command temp = {
> > +			.info = {
> > +				.id = CXL_MEM_COMMAND_ID_RAW,
> > +				.flags = 0,
> > +				.size_in = send_cmd->in.size,
> > +				.size_out = send_cmd->out.size,
> > +			},
> > +			.opcode = send_cmd->raw.opcode
> > +		};
> > +
> > +		if (send_cmd->raw.rsvd)
> > +			return -EINVAL;
> > +
> > +		/*
> > +		 * Unlike supported commands, the output size of RAW commands
> > +		 * gets passed along without further checking, so it must be
> > +		 * validated here.
> > +		 */
> > +		if (send_cmd->out.size > cxlm->payload_size)
> > +			return -EINVAL;
> > +
> > +		if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
> > +			return -EPERM;
> > +
> > +		memcpy(out_cmd, &temp, sizeof(temp));
> > +
> > +		return 0;
> > +	}
> > +
> >  	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
> >  		return -EINVAL;
> >  
> > @@ -1153,6 +1278,7 @@ static struct pci_driver cxl_mem_driver = {
> >  
> >  static __init int cxl_mem_init(void)
> >  {
> > +	struct dentry *mbox_debugfs;
> >  	dev_t devt;
> >  	int rc;
> >  
> > @@ -1169,11 +1295,17 @@ static __init int cxl_mem_init(void)
> >  		return rc;
> >  	}
> >  
> > +	cxl_debugfs = debugfs_create_dir("cxl", NULL);
> > +	mbox_debugfs = debugfs_create_dir("mbox", cxl_debugfs);
> > +	debugfs_create_bool("raw_allow_all", 0600, mbox_debugfs,
> > +			    &cxl_raw_allow_all);
> > +
> >  	return 0;
> >  }
> >  
> >  static __exit void cxl_mem_exit(void)
> >  {
> > +	debugfs_remove_recursive(cxl_debugfs);
> >  	pci_unregister_driver(&cxl_mem_driver);
> >  	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
> >  }
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index 18cea908ad0b..8eb669150ecb 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -22,6 +22,7 @@
> >  #define CXL_CMDS                                                          \
> >  	___C(INVALID, "Invalid Command"),                                 \
> >  	___C(IDENTIFY, "Identify Command"),                               \
> > +	___C(RAW, "Raw device command"),                                  \
> >  	___C(MAX, "invalid / last command")
> >  
> >  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > @@ -115,6 +116,9 @@ struct cxl_mem_query_commands {
> >   * @id: The command to send to the memory device. This must be one of the
> >   *	commands returned by the query command.
> >   * @flags: Flags for the command (input).
> > + * @raw: Special fields for raw commands
> > + * @raw.opcode: Opcode passed to hardware when using the RAW command.
> > + * @raw.rsvd: Must be zero.
> >   * @rsvd: Must be zero.
> >   * @retval: Return value from the memory device (output).
> >   * @in.size: Size of the payload to provide to the device (input).
> > @@ -135,7 +139,13 @@ struct cxl_mem_query_commands {
> >  struct cxl_send_command {
> >  	__u32 id;
> >  	__u32 flags;
> > -	__u32 rsvd;
> > +	union {
> > +		struct {
> > +			__u16 opcode;
> > +			__u16 rsvd;
> > +		} raw;
> > +		__u32 rsvd;
> > +	};
> >  	__u32 retval;
> >  
> >  	struct {
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
