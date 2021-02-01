Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA230B01D
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 20:13:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65452100EBB82;
	Mon,  1 Feb 2021 11:13:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 44EEB100ED4A6
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 11:13:20 -0800 (PST)
IronPort-SDR: bd540/aXEvkYsj1Gw3IIv0MIduLVTtDnXlOrr/7Xf0fmpbevC2+oZ/pPPUmoGGrVNKuYQFXC2V
 1/e1JNXBSWyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="160504505"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="160504505"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 11:13:18 -0800
IronPort-SDR: bdV3ff9QBU2QuDtP0Cn/Tgx3L20CoxDNGsfdJPPcYKd+C+9vL4a0BY4ha7QB0smxjq4i+bL8cu
 hiIpTc6883Ww==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="506968510"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 11:13:17 -0800
Date: Mon, 1 Feb 2021 11:13:16 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
Message-ID: <20210201191316.e3kkkwqbx5fujp6y@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-5-ben.widawsky@intel.com>
 <20210201175400.GG197521@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201175400.GG197521@fedora>
Message-ID-Hash: MD4IAMBTHBN5KSY3IEF4K7WXVPXXDBN4
X-Message-ID-Hash: MD4IAMBTHBN5KSY3IEF4K7WXVPXXDBN4
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MD4IAMBTHBN5KSY3IEF4K7WXVPXXDBN4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-01 12:54:00, Konrad Rzeszutek Wilk wrote:
> > +#define cxl_doorbell_busy(cxlm)                                                \
> > +	(cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET) &                    \
> > +	 CXLDEV_MB_CTRL_DOORBELL)
> > +
> > +#define CXL_MAILBOX_TIMEOUT_US 2000
> 
> You been using the spec for the values. Is that number also from it ?
> 

Yes it is. I'll add a comment with the spec reference.

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
> > + * Command Register section of the CXL 2.0 spec (8.2.8.4.5). @payload_in and
> > + * @payload_out are written to, and read from the Command Payload Registers
> > + * defined in (8.2.8.4.8).
> > + */
> > +struct mbox_cmd {
> > +	u16 opcode;
> > +	void *payload_in;
> > +	void *payload_out;
> 
> On a 32-bit OS (not that we use those that more, but lets assume
> someone really wants to), the void is 4-bytes, while on 64-bit it is
> 8-bytes.
> 
> `pahole` is your friend as I think there is a gap between opcode and
> payload_in in the structure.
> 
> > +	size_t size_in;
> > +	size_t size_out;
> 
> And those can also change depending on 32-bit/64-bit.
> 
> > +	u16 return_code;
> > +#define CXL_MBOX_SUCCESS 0
> > +};
> 
> Do you want to use __packed to match with the spec?
> 
> Ah, reading later you don't care about it.
> 
> In that case may I recommend you move 'return_code' (or perhaps just
> call it rc?) to be right after opcode? Less of gaps in that structure.
> 

I guess I hadn't realized we're supposed to try to fully pack structs by
default.

> > +
> > +static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> > +{
> > +	const int timeout = msecs_to_jiffies(CXL_MAILBOX_TIMEOUT_US);
> > +	const unsigned long start = jiffies;
> > +	unsigned long end = start;
> > +
> > +	while (cxl_doorbell_busy(cxlm)) {
> > +		end = jiffies;
> > +
> > +		if (time_after(end, start + timeout)) {
> > +			/* Check again in case preempted before timeout test */
> > +			if (!cxl_doorbell_busy(cxlm))
> > +				break;
> > +			return -ETIMEDOUT;
> > +		}
> > +		cpu_relax();
> > +	}
> 
> Hm, that is not very scheduler friendly. I mean we are sitting here for
> 2000us (2 ms) - that is quite the amount of time spinning.
> 
> Should this perhaps be put in a workqueue?

So let me first point you to the friendlier version which was shot down:
https://lore.kernel.org/linux-cxl/20201111054356.793390-8-ben.widawsky@intel.com/

I'm not opposed to this being moved to a workqueue at some point, but I think
that's unnecessary complexity currently. The reality is that it's expected that
commands will finish way sooner than this or be implemented as background
commands. I've heard a person who makes a lot of the spec decisions say, "if
it's 2 seconds, nobody will use these things".

I think adding the summary of this back and forth as a comment to the existing
code makes a lot of sense.

> > +
> > +	dev_dbg(&cxlm->pdev->dev, "Doorbell wait took %dms",
> > +		jiffies_to_msecs(end) - jiffies_to_msecs(start));
> > +	return 0;
> > +}
> > +
> > +static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> > +				 struct mbox_cmd *mbox_cmd)
> > +{
> > +	dev_warn(&cxlm->pdev->dev, "Mailbox command timed out\n");
> > +	dev_info(&cxlm->pdev->dev,
> > +		 "\topcode: 0x%04x\n"
> > +		 "\tpayload size: %zub\n",
> > +		 mbox_cmd->opcode, mbox_cmd->size_in);
> > +
> > +	if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
> > +		print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
> > +				     mbox_cmd->payload_in, mbox_cmd->size_in,
> > +				     true);
> > +	}
> > +
> > +	/* Here's a good place to figure out if a device reset is needed */
> > +}
> > +
> > +/**
> > + * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> > + * @cxlm: The CXL memory device to communicate with.
> > + * @mbox_cmd: Command to send to the memory device.
> > + *
> > + * Context: Any context. Expects mbox_lock to be held.
> > + * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
> > + *         Caller should check the return code in @mbox_cmd to make sure it
> > + *         succeeded.
> > + *
> > + * This is a generic form of the CXL mailbox send command, thus the only I/O
> > + * operations used are cxl_read_mbox_reg(). Memory devices, and perhaps other
> > + * types of CXL devices may have further information available upon error
> > + * conditions.
> > + *
> > + * The CXL spec allows for up to two mailboxes. The intention is for the primary
> > + * mailbox to be OS controlled and the secondary mailbox to be used by system
> > + * firmware. This allows the OS and firmware to communicate with the device and
> > + * not need to coordinate with each other. The driver only uses the primary
> > + * mailbox.
> > + */
> > +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> > +				 struct mbox_cmd *mbox_cmd)
> > +{
> > +	void __iomem *payload = cxlm->mbox.regs + CXLDEV_MB_PAYLOAD_OFFSET;
> > +	u64 cmd_reg, status_reg;
> > +	size_t out_len;
> > +	int rc;
> > +
> > +	lockdep_assert_held(&cxlm->mbox.mutex);
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
> > +	 *   Hardware is free to do whatever it wants before the doorbell is
> > +	 *   rung, and isn't allowed to change anything after it clears the
> > +	 *   doorbell. As such, steps 2 and 3 can happen in any order, and steps
> > +	 *   6, 7, 8 can also happen in any order (though some orders might not
> > +	 *   make sense).
> > +	 */
> > +
> > +	/* #1 */
> > +	if (cxl_doorbell_busy(cxlm)) {
> > +		dev_err_ratelimited(&cxlm->pdev->dev,
> > +				    "Mailbox re-busy after acquiring\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	cmd_reg = CXL_SET_FIELD(mbox_cmd->opcode, CXLDEV_MB_CMD_COMMAND_OPCODE);
> > +	if (mbox_cmd->size_in) {
> > +		if (WARN_ON(!mbox_cmd->payload_in))
> > +			return -EINVAL;
> > +
> > +		cmd_reg |= CXL_SET_FIELD(mbox_cmd->size_in,
> > +					 CXLDEV_MB_CMD_PAYLOAD_LENGTH);
> > +		memcpy_toio(payload, mbox_cmd->payload_in, mbox_cmd->size_in);
> > +	}
> > +
> > +	/* #2, #3 */
> > +	cxl_write_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET, cmd_reg);
> > +
> > +	/* #4 */
> > +	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
> > +	cxl_write_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET,
> > +			     CXLDEV_MB_CTRL_DOORBELL);
> > +
> > +	/* #5 */
> > +	rc = cxl_mem_wait_for_doorbell(cxlm);
> > +	if (rc == -ETIMEDOUT) {
> > +		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
> > +		return rc;
> > +	}
> > +
> > +	/* #6 */
> > +	status_reg = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_STATUS_OFFSET);
> > +	mbox_cmd->return_code =
> > +		CXL_GET_FIELD(status_reg, CXLDEV_MB_STATUS_RET_CODE);
> > +
> > +	if (mbox_cmd->return_code != 0) {
> > +		dev_dbg(&cxlm->pdev->dev, "Mailbox operation had an error\n");
> > +		return 0;
> > +	}
> > +
> > +	/* #7 */
> > +	cmd_reg = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET);
> > +	out_len = CXL_GET_FIELD(cmd_reg, CXLDEV_MB_CMD_PAYLOAD_LENGTH);
> > +
> > +	/* #8 */
> > +	if (out_len && mbox_cmd->payload_out)
> > +		memcpy_fromio(mbox_cmd->payload_out, payload, out_len);
> > +
> > +	mbox_cmd->size_out = out_len;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * cxl_mem_mbox_get() - Acquire exclusive access to the mailbox.
> > + * @cxlm: The memory device to gain access to.
> > + *
> > + * Context: Any context. Takes the mbox_lock.
> > + * Return: 0 if exclusive access was acquired.
> > + */
> > +static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
> > +{
> > +	struct device *dev = &cxlm->pdev->dev;
> > +	int rc = -EBUSY;
> > +	u64 md_status;
> > +
> > +	mutex_lock_io(&cxlm->mbox.mutex);
> > +
> > +	/*
> > +	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> > +	 * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
> > +	 * bit is to allow firmware running on the device to notify the driver
> > +	 * that it's ready to receive commands. It is unclear if the bit needs
> > +	 * to be read for each transaction mailbox, ie. the firmware can switch
> > +	 * it on and off as needed. Second, there is no defined timeout for
> > +	 * mailbox ready, like there is for the doorbell interface.
> > +	 *
> > +	 * Assumptions:
> > +	 * 1. The firmware might toggle the Mailbox Interface Ready bit, check
> > +	 *    it for every command.
> > +	 *
> > +	 * 2. If the doorbell is clear, the firmware should have first set the
> > +	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> > +	 *    to be ready is sufficient.
> > +	 */
> > +	rc = cxl_mem_wait_for_doorbell(cxlm);
> > +	if (rc) {
> > +		dev_warn(dev, "Mailbox interface not ready\n");
> > +		goto out;
> > +	}
> > +
> > +	md_status = cxl_read_mem_reg64(cxlm, CXLMDEV_STATUS_OFFSET);
> > +	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> > +		dev_err(dev,
> > +			"mbox: reported doorbell ready, but not mbox ready\n");
> 
> You can make that oneline.
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * Hardware shouldn't allow a ready status but also have failure bits
> > +	 * set. Spit out an error, this should be a bug report
> > +	 */
> > +	rc = -EFAULT;
> 
> Should these include more details? As in a dump of other registers to
> help in the field to debug why the device is busted?
> 

We've discussed a bit, having kind of a general error state (my driver
background is in i915 where we did such a thing). I'm not opposed, but as the
error handling at this point is very minimal, I think it can wait until the next
round of patches for further enabling.

> > +	if (md_status & CXLMDEV_DEV_FATAL) {
> > +		dev_err(dev, "mbox: reported ready, but fatal\n");
> > +		goto out;
> > +	}
> > +	if (md_status & CXLMDEV_FW_HALT) {
> > +		dev_err(dev, "mbox: reported ready, but halted\n");
> > +		goto out;
> > +	}
> > +	if (CXLMDEV_RESET_NEEDED(md_status)) {
> > +		dev_err(dev, "mbox: reported ready, but reset needed\n");
> > +		goto out;
> > +	}
> > +
> > +	/* with lock held */
> > +	return 0;
> > +
> > +out:
> > +	mutex_unlock(&cxlm->mbox.mutex);
> > +	return rc;
> > +}
> > +
> > +/**
> > + * cxl_mem_mbox_put() - Release exclusive access to the mailbox.
> > + * @cxlm: The CXL memory device to communicate with.
> > + *
> > + * Context: Any context. Expects mbox_lock to be held.
> > + */
> > +static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
> > +{
> > +	mutex_unlock(&cxlm->mbox.mutex);
> > +}
> > +
> >  /**
> >   * cxl_mem_setup_regs() - Setup necessary MMIO.
> >   * @cxlm: The CXL memory device to communicate with.
> > @@ -142,6 +406,8 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> >  		return NULL;
> >  	}
> >  
> > +	mutex_init(&cxlm->mbox.mutex);
> > +
> >  	regs = pcim_iomap_table(pdev)[bar];
> >  	cxlm->pdev = pdev;
> >  	cxlm->regs = regs + offset;
> > @@ -174,6 +440,76 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
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
> > +	struct mbox_cmd mbox_cmd;
> > +	int rc;
> > +
> > +	/* Retrieve initial device memory map */
> > +	rc = cxl_mem_mbox_get(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	mbox_cmd = (struct mbox_cmd){
> > +		.opcode = CXL_MBOX_OP_IDENTIFY,
> > +		.payload_out = &id,
> > +		.size_in = 0,
> > +	};
> > +	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> > +	cxl_mem_mbox_put(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/* TODO: Handle retry or reset responses from firmware. */
> > +	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS) {
> > +		dev_err(&cxlm->pdev->dev, "Mailbox command failed (%d)\n",
> > +			mbox_cmd.return_code);
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (mbox_cmd.size_out != sizeof(id))
> > +		return -ENXIO;
> > +
> > +	/*
> > +	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
> 
> ??? Not sure I understand.
> 

The current code is showing two aliased/overlapping ranges.
[0, id.volatile_capacity)
[0, id.persistent_capacity)

This is not allowed by spec.

> > +	 * For now, only the capacity is exported in sysfs
> > +	 */
> > +	cxlm->ram.range.start = 0;
> > +	cxlm->ram.range.end = le64_to_cpu(id.volatile_capacity) - 1;
> > +
> > +	cxlm->pmem.range.start = 0;
> > +	cxlm->pmem.range.end = le64_to_cpu(id.persistent_capacity) - 1;
> > +
> > +	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> > +
> > +	return rc;
> > +}
> > +
> >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -219,7 +555,11 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > -	return cxl_mem_setup_mailbox(cxlm);
> > +	rc = cxl_mem_setup_mailbox(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return cxl_mem_identify(cxlm);
> >  }
> >  
> >  static const struct pci_device_id cxl_mem_pci_tbl[] = {
> > -- 
> > 2.30.0
> > 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
