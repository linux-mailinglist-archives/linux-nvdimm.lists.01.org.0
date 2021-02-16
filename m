Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB9F31CE47
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Feb 2021 17:43:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56A98100EB33F;
	Tue, 16 Feb 2021 08:43:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0775D100EB33A
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 08:43:07 -0800 (PST)
IronPort-SDR: CQMWof7sB09giWHK+e5JCS431CcSMa6giuRF9MGkFU5iPY3pQ0LV3qY104XhVeZV5iX7HUvjJi
 egHRh/tG4lfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="162710550"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400";
   d="scan'208";a="162710550"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:43:05 -0800
IronPort-SDR: sxmxh1AV4WqujGRGj8B2/dpHipdHGfluBVXbEcBJjasuWhdeKkKv07M0pmzXZMKRfJ1k3MauA5
 zM/zAlOF6dZQ==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400";
   d="scan'208";a="377613190"
Received: from dlbingha-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.134.31])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:43:05 -0800
Date: Tue, 16 Feb 2021 08:43:03 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 2/9] cxl/mem: Find device capabilities
Message-ID: <20210216164303.qq7nefpn4u3mv4co@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
 <20210216014538.268106-3-ben.widawsky@intel.com>
 <20210216145148.00003c49@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210216145148.00003c49@Huawei.com>
Message-ID-Hash: 43MQHEKJ2AESGSAEUPHRQ4VFZQAFYKFZ
X-Message-ID-Hash: 43MQHEKJ2AESGSAEUPHRQ4VFZQAFYKFZ
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/43MQHEKJ2AESGSAEUPHRQ4VFZQAFYKFZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-16 14:51:48, Jonathan Cameron wrote:
> On Mon, 15 Feb 2021 17:45:31 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > Provide enough functionality to utilize the mailbox of a memory device.
> > The mailbox is used to interact with the firmware running on the memory
> > device. The flow is proven with one implemented command, "identify".
> > Because the class code has already told the driver this is a memory
> > device and the identify command is mandatory.
> > 
> > CXL devices contain an array of capabilities that describe the
> > interactions software can have with the device or firmware running on
> > the device. A CXL compliant device must implement the device status and
> > the mailbox capability. Additionally, a CXL compliant memory device must
> > implement the memory device capability. Each of the capabilities can
> > [will] provide an offset within the MMIO region for interacting with the
> > CXL device.
> > 
> > The capabilities tell the driver how to find and map the register space
> > for CXL Memory Devices. The registers are required to utilize the CXL
> > spec defined mailbox interface. The spec outlines two mailboxes, primary
> > and secondary. The secondary mailbox is earmarked for system firmware,
> > and not handled in this driver.
> > 
> > Primary mailboxes are capable of generating an interrupt when submitting
> > a background command. That implementation is saved for a later time.
> > 
> > Link: https://www.computeexpresslink.org/download-the-specification
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)
> 
> Looks like an off by one error in the register locator iteration.
> 
> The potential buffer overrun from memcpy_fromio is still there as well
> as far as I can see.
> 
> If the software provides storage for a payload of size n and the hardware
> reports a size of n + d, code will happily write beyond the end of the
> storage provided.
> 
> Obviously, this shouldn't happen, but I'm not that trusting of both
> hardware and software never having bugs.
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/cxl.h |  88 ++++++++
> >  drivers/cxl/mem.c | 543 +++++++++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/pci.h |  14 ++
> >  3 files changed, 643 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/cxl/cxl.h
> > 
> ...
> 
> > +
> > +#endif /* __CXL_H__ */
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index ce33c5ee77c9..b86cda2d299a 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -3,7 +3,458 @@
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/io.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> >  #include "pci.h"
> > +#include "cxl.h"
> > +
> > +#define cxl_doorbell_busy(cxlm)                                                \
> > +	(readl((cxlm)->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET) &                  \
> > +	 CXLDEV_MBOX_CTRL_DOORBELL)
> > +
> > +/* CXL 2.0 - 8.2.8.4 */
> > +#define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
> > +
> > +enum opcode {
> > +	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> > +	CXL_MBOX_OP_MAX			= 0x10000
> > +};
> > +
> > +/**
> > + * struct mbox_cmd - A command to be submitted to hardware.
> > + * @opcode: (input) The command set and command submitted to hardware.
> > + * @payload_in: (input) Pointer to the input payload.
> > + * @payload_out: (output) Pointer to the output payload. Must be allocated by
> > + *		 the caller.
> > + * @size_in: (input) Number of bytes to load from @payload.
> > + * @size_out: (output) Number of bytes loaded into @payload.
> > + * @return_code: (output) Error code returned from hardware.
> > + *
> > + * This is the primary mechanism used to send commands to the hardware.
> > + * All the fields except @payload_* correspond exactly to the fields described in
> > + * Command Register section of the CXL 2.0 8.2.8.4.5. @payload_in and
> > + * @payload_out are written to, and read from the Command Payload Registers
> > + * defined in CXL 2.0 8.2.8.4.8.
> > + */
> > +struct mbox_cmd {
> > +	u16 opcode;
> > +	void *payload_in;
> > +	void *payload_out;
> > +	size_t size_in;
> > +	size_t size_out;
> > +	u16 return_code;
> > +#define CXL_MBOX_SUCCESS 0
> > +};
> 
> 
> > +
> > +/**
> > + * __cxl_mem_mbox_send_cmd() - Execute a mailbox command
> > + * @cxlm: The CXL memory device to communicate with.
> > + * @mbox_cmd: Command to send to the memory device.
> > + *
> > + * Context: Any context. Expects mbox_mutex to be held.
> > + * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
> > + *         Caller should check the return code in @mbox_cmd to make sure it
> > + *         succeeded.
> > + *
> > + * This is a generic form of the CXL mailbox send command thus only using the
> > + * registers defined by the mailbox capability ID - CXL 2.0 8.2.8.4. Memory
> > + * devices, and perhaps other types of CXL devices may have further information
> > + * available upon error conditions. Driver facilities wishing to send mailbox
> > + * commands should use the wrapper command.
> > + *
> > + * The CXL spec allows for up to two mailboxes. The intention is for the primary
> > + * mailbox to be OS controlled and the secondary mailbox to be used by system
> > + * firmware. This allows the OS and firmware to communicate with the device and
> > + * not need to coordinate with each other. The driver only uses the primary
> > + * mailbox.
> > + */
> > +static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> > +				   struct mbox_cmd *mbox_cmd)
> > +{
> > +	void __iomem *payload = cxlm->mbox_regs + CXLDEV_MBOX_PAYLOAD_OFFSET;
> > +	u64 cmd_reg, status_reg;
> > +	size_t out_len;
> > +	int rc;
> > +
> > +	lockdep_assert_held(&cxlm->mbox_mutex);
> > +
> > +	/*
> > +	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
> > +	 *   1. Caller reads MB Control Register to verify doorbell is clear
> > +	 *   2. Caller writes Command Register
> > +	 *   3. Caller writes Command Payload Registers if input payload is non-empty
> > +	 *   4. Caller writes MB Control Register to set doorbell
> > +	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
> > +	 *   6. Caller reads MB Status Register to fetch Return code
> > +	 *   7. If command successful, Caller reads Command Register to get Payload Length
> > +	 *   8. If output payload is non-empty, host reads Command Payload Registers
> > +	 *
> > +	 * Hardware is free to do whatever it wants before the doorbell is rung,
> > +	 * and isn't allowed to change anything after it clears the doorbell. As
> > +	 * such, steps 2 and 3 can happen in any order, and steps 6, 7, 8 can
> > +	 * also happen in any order (though some orders might not make sense).
> > +	 */
> > +
> > +	/* #1 */
> > +	if (cxl_doorbell_busy(cxlm)) {
> > +		dev_err_ratelimited(&cxlm->pdev->dev,
> > +				    "Mailbox re-busy after acquiring\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
> > +			     mbox_cmd->opcode);
> > +	if (mbox_cmd->size_in) {
> > +		if (WARN_ON(!mbox_cmd->payload_in))
> > +			return -EINVAL;
> > +
> > +		cmd_reg |= FIELD_PREP(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK,
> > +				      mbox_cmd->size_in);
> > +		memcpy_toio(payload, mbox_cmd->payload_in, mbox_cmd->size_in);
> > +	}
> > +
> > +	/* #2, #3 */
> > +	writeq(cmd_reg, cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> > +
> > +	/* #4 */
> > +	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
> > +	writel(CXLDEV_MBOX_CTRL_DOORBELL,
> > +	       cxlm->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET);
> > +
> > +	/* #5 */
> > +	rc = cxl_mem_wait_for_doorbell(cxlm);
> > +	if (rc == -ETIMEDOUT) {
> > +		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
> > +		return rc;
> > +	}
> > +
> > +	/* #6 */
> > +	status_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_STATUS_OFFSET);
> > +	mbox_cmd->return_code =
> > +		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> > +
> > +	if (mbox_cmd->return_code != 0) {
> > +		dev_dbg(&cxlm->pdev->dev, "Mailbox operation had an error\n");
> > +		return 0;
> > +	}
> > +
> > +	/* #7 */
> > +	cmd_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> > +	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
> > +
> > +	/* #8 */
> > +	if (out_len && mbox_cmd->payload_out) {
> > +		size_t n = min_t(size_t, cxlm->payload_size, out_len);
> 
> This doesn't protect us from the case where the hardware
> returns a larger payload than the caller is expecting.
> 
> i.e. payload_out is too small.  We need to pass in the size of that buffer as
> well.   This currently clamps to the size of the source buffer but does not
> check if there is enough space at the destination (mbox_cmd->payload_out).
> 

Let me articulate the issue a bit. The userspace call chain should be fine:
cxl_send_cmd() -> ioctl handlers
  cxl_validate_cmd_from_user -> converts to internal command
    handle_mailbox_cmd_from_user -> dispatches mbox command.

cxl_send_cmd():
  if (c.info.size_out < 0)
    c.info.size_out = cxlm->payload_size;

handle_mailbox_cmd_from_user():
  if (cmd->info.size_out) {
     mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);


The kernel call chain could have issues:
cxl_mem_identify/*() -> kernel caller allocates just enough space
  cxl_mem_mbox_send_cmd() -> internal wrapper we created for v3
    blows up in the spot you mention.

The driver allocates enough space on the stack for all these calls, but yes, if
hardware is out of spec it would be problematic. In previous versions of this
series, there has been a check there. However, the ability to have hardware
return more data than expected is I believe the correct functionality here.

So my proposal is for now, since no real hardware exists, and the command set
here is so benign, we leave fixing this as a TODO.

I can post a patch on top of this series to address this issue in a manner I
believe warrants discussing (kvzalloc max payload size buffers on open() and for
each driver instance).

> > +
> > +		memcpy_fromio(mbox_cmd->payload_out, payload, n);
> > +		mbox_cmd->size_out = n;
> > +	} else {
> > +		mbox_cmd->size_out = 0;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> ...
> 
> > +
> > +/**
> > + * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> > + * @cxlm: The CXL memory device to communicate with.
> > + * @opcode: Opcode for the mailbox command.
> > + * @in: The input payload for the mailbox command.
> > + * @in_size: The length of the input payload
> > + * @out: Caller allocated buffer for the output.
> > + * @out_min_size: Minimum expected size of output.
> > + *
> > + * Context: Any context. Will acquire and release mbox_mutex.
> > + * Return:
> > + *  * %>=0	- Number of bytes returned in @out.
> > + *  * %-E2BIG	- Payload is too large for hardware.
> > + *  * %-EBUSY	- Couldn't acquire exclusive mailbox access.
> > + *  * %-EFAULT	- Hardware error occurred.
> > + *  * %-ENXIO	- Command completed, but device reported an error.
> > + *  * %-ENODATA	- Not enough payload data returned by hardware.
> > + *
> > + * Mailbox commands may execute successfully yet the device itself reported an
> > + * error. While this distinction can be useful for commands from userspace, the
> > + * kernel will only be able to use results when both are successful.
> > + *
> > + * See __cxl_mem_mbox_send_cmd()
> > + */
> > +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode, void *in,
> > +				 size_t in_size, void *out, size_t out_min_size)
> > +{
> > +	struct mbox_cmd mbox_cmd = {
> > +		.opcode = opcode,
> > +		.payload_in = in,
> > +		.size_in = in_size,
> > +		.payload_out = out,
> > +	};
> > +	int rc;
> > +
> > +	if (out_min_size > cxlm->payload_size)
> > +		return -E2BIG;
> > +
> > +	rc = cxl_mem_mbox_get(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = __cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> > +	cxl_mem_mbox_put(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/* TODO: Map return code to proper kernel style errno */
> > +	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
> > +		return -ENXIO;
> > +
> > +	if (mbox_cmd.size_out < out_min_size)
> > +		return -ENODATA;
> > +
> > +	return mbox_cmd.size_out;
> > +}
> > +
> > +/**
> > + * cxl_mem_setup_regs() - Setup necessary MMIO.
> > + * @cxlm: The CXL memory device to communicate with.
> > + *
> > + * Return: 0 if all necessary registers mapped.
> > + *
> > + * A memory device is required by spec to implement a certain set of MMIO
> > + * regions. The purpose of this function is to enumerate and map those
> > + * registers.
> > + */
> > +static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> > +{
> > +	struct device *dev = &cxlm->pdev->dev;
> > +	int cap, cap_count;
> > +	u64 cap_array;
> > +
> > +	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
> > +	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
> > +	    CXLDEV_CAP_ARRAY_CAP_ID)
> > +		return -ENODEV;
> > +
> > +	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
> > +
> > +	for (cap = 1; cap <= cap_count; cap++) {
> > +		void __iomem *register_block;
> > +		u32 offset;
> > +		u16 cap_id;
> > +
> > +		cap_id = readl(cxlm->regs + cap * 0x10) & 0xffff;
> 
> Slight preference for FIELD_GET just for consistency.
> 
> > +		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
> > +		register_block = cxlm->regs + offset;
> > +
> > +		switch (cap_id) {
> > +		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
> > +			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
> > +			cxlm->status_regs = register_block;
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
> > +			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
> > +			cxlm->mbox_regs = register_block;
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
> > +			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_MEMDEV:
> > +			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
> > +			cxlm->memdev_regs = register_block;
> > +			break;
> > +		default:
> > +			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!cxlm->status_regs || !cxlm->mbox_regs || !cxlm->memdev_regs) {
> > +		dev_err(dev, "registers not found: %s%s%s\n",
> > +			!cxlm->status_regs ? "status " : "",
> > +			!cxlm->mbox_regs ? "mbox " : "",
> > +			!cxlm->memdev_regs ? "memdev" : "");
> > +		return -ENXIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> ...
> 
> > +
> > +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> > +				      u32 reg_hi)
> 
> I'm not really suggesting you change it at this point, but I'd have
> done the splitting of reg_lo up and the building of the offset at the call site
> rather than in here.  I think that would have been slightly easier to follow.
> 

Noted. In future patches this is going to get reworked somewhat to support more
flexibility with register blocks.

> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct cxl_mem *cxlm;
> > +	void __iomem *regs;
> > +	u64 offset;
> > +	u8 bar;
> > +	int rc;
> > +
> > +	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> > +	if (!cxlm) {
> > +		dev_err(dev, "No memory available\n");
> > +		return NULL;
> > +	}
> > +
> > +	offset = ((u64)reg_hi << 32) | FIELD_GET(CXL_REGLOC_ADDR_MASK, reg_lo);
> > +	bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> > +
> > +	/* Basic sanity check that BAR is big enough */
> > +	if (pci_resource_len(pdev, bar) < offset) {
> > +		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> > +			&pdev->resource[bar], (unsigned long long)offset);
> > +		return NULL;
> > +	}
> > +
> > +	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> > +	if (rc) {
> > +		dev_err(dev, "failed to map registers\n");
> > +		return NULL;
> > +	}
> > +	regs = pcim_iomap_table(pdev)[bar];
> > +
> > +	mutex_init(&cxlm->mbox_mutex);
> > +	cxlm->pdev = pdev;
> > +	cxlm->regs = regs + offset;
> > +
> > +	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> > +	return cxlm;
> > +}
> >  
> >  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >  {
> > @@ -28,10 +479,65 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * cxl_mem_identify() - Send the IDENTIFY command to the device.
> > + * @cxlm: The device to identify.
> > + *
> > + * Return: 0 if identify was executed successfully.
> > + *
> > + * This will dispatch the identify command to the device and on success populate
> > + * structures to be exported to sysfs.
> > + */
> > +static int cxl_mem_identify(struct cxl_mem *cxlm)
> > +{
> > +	struct cxl_mbox_identify {
> > +		char fw_revision[0x10];
> > +		__le64 total_capacity;
> > +		__le64 volatile_capacity;
> > +		__le64 persistent_capacity;
> > +		__le64 partition_align;
> > +		__le16 info_event_log_size;
> > +		__le16 warning_event_log_size;
> > +		__le16 failure_event_log_size;
> > +		__le16 fatal_event_log_size;
> > +		__le32 lsa_size;
> > +		u8 poison_list_max_mer[3];
> > +		__le16 inject_poison_limit;
> > +		u8 poison_caps;
> > +		u8 qos_telemetry_caps;
> > +	} __packed id;
> > +	int rc;
> > +
> > +	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
> > +				   sizeof(id));
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	/*
> > +	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
> > +	 * For now, only the capacity is exported in sysfs
> > +	 */
> > +	cxlm->ram_range.start = 0;
> > +	cxlm->ram_range.end = le64_to_cpu(id.volatile_capacity) - 1;
> > +
> > +	cxlm->pmem_range.start = 0;
> > +	cxlm->pmem_range.end = le64_to_cpu(id.persistent_capacity) - 1;
> > +
> > +	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	int regloc;
> > +	struct cxl_mem *cxlm = NULL;
> > +	int rc, regloc, i;
> > +	u32 regloc_size;
> > +
> > +	rc = pcim_enable_device(pdev);
> > +	if (rc)
> > +		return rc;
> >  
> >  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
> >  	if (!regloc) {
> > @@ -39,7 +545,40 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  		return -ENXIO;
> >  	}
> >  
> > -	return 0;
> > +	/* Get the size of the Register Locator DVSEC */
> > +	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> > +	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> 
> The size field here is the dvsec length..  Let's say we only have one register block
> entry at +0x0c and +0x10
> From PCI spec :
> 
> "DVSEC Length - This field indicates the number of bytes in the entire DVSEC structure, including the PCI
> Express Extended Capability Header, the DVSEC Header 1, DVSEC Header 2, and DVSEC vendor-specific
> registers."
> 
> So here it would be 0x14
> 
> > +
> > +	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> 
> We then shift regloc forward by +0xc
> 
> > +
> > +	for (i = regloc; i < regloc + regloc_size; i += 8) {
> 
> This loop will then index form
> i= +0xc to i < +0c + 0x14 (0x20)
> i = 0xc, 0x14 
> 
> So that's indexing one more entry than is actually present.
> Should be something like
> 
> 	for (i = regloc;
> 	     i < regloc + regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> 	     i++) 
> 
> which will mean the only iteration for this example is the one with i == +0xC
>

Good catch. I think this warrants rewriting a bit, let me know what you think?

regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;

for (i = 0; i < regblocks; i++, regloc+=8) {
	pci_read_config_dword(pdev, regloc, &reg_lo);
	pci_read_config_dword(pdev, regloc + 4, &reg_hi);

	...
}

> > +		u32 reg_lo, reg_hi;
> > +		u8 reg_type;
> > +
> > +		/* "register low and high" contain other bits */
> > +		pci_read_config_dword(pdev, i, &reg_lo);
> > +		pci_read_config_dword(pdev, i + 4, &reg_hi);
> > +
> > +		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> > +
> > +		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> > +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!cxlm)
> > +		return -ENODEV;
> > +
> > +	rc = cxl_mem_setup_regs(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_mem_setup_mailbox(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return cxl_mem_identify(cxlm);
> >  }
> >  
> >  static const struct pci_device_id cxl_mem_pci_tbl[] = {
> > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > index e464bea3f4d3..af3ec078cf6c 100644
> > --- a/drivers/cxl/pci.h
> > +++ b/drivers/cxl/pci.h
> > @@ -9,9 +9,23 @@
> >   * See section 8.1 Configuration Space Registers in the CXL 2.0
> >   * Specification
> >   */
> > +#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
> >  #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
> >  #define PCI_DVSEC_ID_CXL		0x0
> >  
> >  #define PCI_DVSEC_ID_CXL_REGLOC_OFFSET		0x8
> > +#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
> > +
> > +/* BAR Indicator Register (BIR) */
> > +#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
> > +
> > +/* Register Block Identifier (RBI) */
> > +#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
> > +#define CXL_REGLOC_RBI_EMPTY 0
> > +#define CXL_REGLOC_RBI_COMPONENT 1
> > +#define CXL_REGLOC_RBI_VIRT 2
> > +#define CXL_REGLOC_RBI_MEMDEV 3
> > +
> > +#define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
> >  
> >  #endif /* __CXL_PCI_H__ */
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
