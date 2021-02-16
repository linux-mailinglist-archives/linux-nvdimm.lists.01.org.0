Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA44931CC6F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Feb 2021 15:53:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1A69C100EB332;
	Tue, 16 Feb 2021 06:53:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A7A67100EB32D
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 06:53:04 -0800 (PST)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dg3l55g2Kz67pxN;
	Tue, 16 Feb 2021 22:49:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 16 Feb 2021 15:52:55 +0100
Received: from localhost (10.47.75.223) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 16 Feb
 2021 14:52:54 +0000
Date: Tue, 16 Feb 2021 14:51:48 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v4 2/9] cxl/mem: Find device capabilities
Message-ID: <20210216145148.00003c49@Huawei.com>
In-Reply-To: <20210216014538.268106-3-ben.widawsky@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
	<20210216014538.268106-3-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.75.223]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: XLL5R2NZMCK543S7QYLXBE5PCEV6BZZJ
X-Message-ID-Hash: XLL5R2NZMCK543S7QYLXBE5PCEV6BZZJ
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Chris Browy  <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>,  Dan Williams  <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>, "Jon Masters  <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XLL5R2NZMCK543S7QYLXBE5PCEV6BZZJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 15 Feb 2021 17:45:31 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Provide enough functionality to utilize the mailbox of a memory device.
> The mailbox is used to interact with the firmware running on the memory
> device. The flow is proven with one implemented command, "identify".
> Because the class code has already told the driver this is a memory
> device and the identify command is mandatory.
> 
> CXL devices contain an array of capabilities that describe the
> interactions software can have with the device or firmware running on
> the device. A CXL compliant device must implement the device status and
> the mailbox capability. Additionally, a CXL compliant memory device must
> implement the memory device capability. Each of the capabilities can
> [will] provide an offset within the MMIO region for interacting with the
> CXL device.
> 
> The capabilities tell the driver how to find and map the register space
> for CXL Memory Devices. The registers are required to utilize the CXL
> spec defined mailbox interface. The spec outlines two mailboxes, primary
> and secondary. The secondary mailbox is earmarked for system firmware,
> and not handled in this driver.
> 
> Primary mailboxes are capable of generating an interrupt when submitting
> a background command. That implementation is saved for a later time.
> 
> Link: https://www.computeexpresslink.org/download-the-specification
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)

Looks like an off by one error in the register locator iteration.

The potential buffer overrun from memcpy_fromio is still there as well
as far as I can see.

If the software provides storage for a payload of size n and the hardware
reports a size of n + d, code will happily write beyond the end of the
storage provided.

Obviously, this shouldn't happen, but I'm not that trusting of both
hardware and software never having bugs.

Jonathan

> ---
>  drivers/cxl/cxl.h |  88 ++++++++
>  drivers/cxl/mem.c | 543 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/pci.h |  14 ++
>  3 files changed, 643 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cxl/cxl.h
> 
...

> +
> +#endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index ce33c5ee77c9..b86cda2d299a 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -3,7 +3,458 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include "pci.h"
> +#include "cxl.h"
> +
> +#define cxl_doorbell_busy(cxlm)                                                \
> +	(readl((cxlm)->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET) &                  \
> +	 CXLDEV_MBOX_CTRL_DOORBELL)
> +
> +/* CXL 2.0 - 8.2.8.4 */
> +#define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
> +
> +enum opcode {
> +	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> +	CXL_MBOX_OP_MAX			= 0x10000
> +};
> +
> +/**
> + * struct mbox_cmd - A command to be submitted to hardware.
> + * @opcode: (input) The command set and command submitted to hardware.
> + * @payload_in: (input) Pointer to the input payload.
> + * @payload_out: (output) Pointer to the output payload. Must be allocated by
> + *		 the caller.
> + * @size_in: (input) Number of bytes to load from @payload.
> + * @size_out: (output) Number of bytes loaded into @payload.
> + * @return_code: (output) Error code returned from hardware.
> + *
> + * This is the primary mechanism used to send commands to the hardware.
> + * All the fields except @payload_* correspond exactly to the fields described in
> + * Command Register section of the CXL 2.0 8.2.8.4.5. @payload_in and
> + * @payload_out are written to, and read from the Command Payload Registers
> + * defined in CXL 2.0 8.2.8.4.8.
> + */
> +struct mbox_cmd {
> +	u16 opcode;
> +	void *payload_in;
> +	void *payload_out;
> +	size_t size_in;
> +	size_t size_out;
> +	u16 return_code;
> +#define CXL_MBOX_SUCCESS 0
> +};


> +
> +/**
> + * __cxl_mem_mbox_send_cmd() - Execute a mailbox command
> + * @cxlm: The CXL memory device to communicate with.
> + * @mbox_cmd: Command to send to the memory device.
> + *
> + * Context: Any context. Expects mbox_mutex to be held.
> + * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
> + *         Caller should check the return code in @mbox_cmd to make sure it
> + *         succeeded.
> + *
> + * This is a generic form of the CXL mailbox send command thus only using the
> + * registers defined by the mailbox capability ID - CXL 2.0 8.2.8.4. Memory
> + * devices, and perhaps other types of CXL devices may have further information
> + * available upon error conditions. Driver facilities wishing to send mailbox
> + * commands should use the wrapper command.
> + *
> + * The CXL spec allows for up to two mailboxes. The intention is for the primary
> + * mailbox to be OS controlled and the secondary mailbox to be used by system
> + * firmware. This allows the OS and firmware to communicate with the device and
> + * not need to coordinate with each other. The driver only uses the primary
> + * mailbox.
> + */
> +static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> +				   struct mbox_cmd *mbox_cmd)
> +{
> +	void __iomem *payload = cxlm->mbox_regs + CXLDEV_MBOX_PAYLOAD_OFFSET;
> +	u64 cmd_reg, status_reg;
> +	size_t out_len;
> +	int rc;
> +
> +	lockdep_assert_held(&cxlm->mbox_mutex);
> +
> +	/*
> +	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
> +	 *   1. Caller reads MB Control Register to verify doorbell is clear
> +	 *   2. Caller writes Command Register
> +	 *   3. Caller writes Command Payload Registers if input payload is non-empty
> +	 *   4. Caller writes MB Control Register to set doorbell
> +	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
> +	 *   6. Caller reads MB Status Register to fetch Return code
> +	 *   7. If command successful, Caller reads Command Register to get Payload Length
> +	 *   8. If output payload is non-empty, host reads Command Payload Registers
> +	 *
> +	 * Hardware is free to do whatever it wants before the doorbell is rung,
> +	 * and isn't allowed to change anything after it clears the doorbell. As
> +	 * such, steps 2 and 3 can happen in any order, and steps 6, 7, 8 can
> +	 * also happen in any order (though some orders might not make sense).
> +	 */
> +
> +	/* #1 */
> +	if (cxl_doorbell_busy(cxlm)) {
> +		dev_err_ratelimited(&cxlm->pdev->dev,
> +				    "Mailbox re-busy after acquiring\n");
> +		return -EBUSY;
> +	}
> +
> +	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
> +			     mbox_cmd->opcode);
> +	if (mbox_cmd->size_in) {
> +		if (WARN_ON(!mbox_cmd->payload_in))
> +			return -EINVAL;
> +
> +		cmd_reg |= FIELD_PREP(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK,
> +				      mbox_cmd->size_in);
> +		memcpy_toio(payload, mbox_cmd->payload_in, mbox_cmd->size_in);
> +	}
> +
> +	/* #2, #3 */
> +	writeq(cmd_reg, cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> +
> +	/* #4 */
> +	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
> +	writel(CXLDEV_MBOX_CTRL_DOORBELL,
> +	       cxlm->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET);
> +
> +	/* #5 */
> +	rc = cxl_mem_wait_for_doorbell(cxlm);
> +	if (rc == -ETIMEDOUT) {
> +		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
> +		return rc;
> +	}
> +
> +	/* #6 */
> +	status_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_STATUS_OFFSET);
> +	mbox_cmd->return_code =
> +		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> +
> +	if (mbox_cmd->return_code != 0) {
> +		dev_dbg(&cxlm->pdev->dev, "Mailbox operation had an error\n");
> +		return 0;
> +	}
> +
> +	/* #7 */
> +	cmd_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> +	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
> +
> +	/* #8 */
> +	if (out_len && mbox_cmd->payload_out) {
> +		size_t n = min_t(size_t, cxlm->payload_size, out_len);

This doesn't protect us from the case where the hardware
returns a larger payload than the caller is expecting.

i.e. payload_out is too small.  We need to pass in the size of that buffer as
well.   This currently clamps to the size of the source buffer but does not
check if there is enough space at the destination (mbox_cmd->payload_out).

> +
> +		memcpy_fromio(mbox_cmd->payload_out, payload, n);
> +		mbox_cmd->size_out = n;
> +	} else {
> +		mbox_cmd->size_out = 0;
> +	}
> +
> +	return 0;
> +}
> +

...

> +
> +/**
> + * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> + * @cxlm: The CXL memory device to communicate with.
> + * @opcode: Opcode for the mailbox command.
> + * @in: The input payload for the mailbox command.
> + * @in_size: The length of the input payload
> + * @out: Caller allocated buffer for the output.
> + * @out_min_size: Minimum expected size of output.
> + *
> + * Context: Any context. Will acquire and release mbox_mutex.
> + * Return:
> + *  * %>=0	- Number of bytes returned in @out.
> + *  * %-E2BIG	- Payload is too large for hardware.
> + *  * %-EBUSY	- Couldn't acquire exclusive mailbox access.
> + *  * %-EFAULT	- Hardware error occurred.
> + *  * %-ENXIO	- Command completed, but device reported an error.
> + *  * %-ENODATA	- Not enough payload data returned by hardware.
> + *
> + * Mailbox commands may execute successfully yet the device itself reported an
> + * error. While this distinction can be useful for commands from userspace, the
> + * kernel will only be able to use results when both are successful.
> + *
> + * See __cxl_mem_mbox_send_cmd()
> + */
> +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode, void *in,
> +				 size_t in_size, void *out, size_t out_min_size)
> +{
> +	struct mbox_cmd mbox_cmd = {
> +		.opcode = opcode,
> +		.payload_in = in,
> +		.size_in = in_size,
> +		.payload_out = out,
> +	};
> +	int rc;
> +
> +	if (out_min_size > cxlm->payload_size)
> +		return -E2BIG;
> +
> +	rc = cxl_mem_mbox_get(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	rc = __cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> +	cxl_mem_mbox_put(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	/* TODO: Map return code to proper kernel style errno */
> +	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
> +		return -ENXIO;
> +
> +	if (mbox_cmd.size_out < out_min_size)
> +		return -ENODATA;
> +
> +	return mbox_cmd.size_out;
> +}
> +
> +/**
> + * cxl_mem_setup_regs() - Setup necessary MMIO.
> + * @cxlm: The CXL memory device to communicate with.
> + *
> + * Return: 0 if all necessary registers mapped.
> + *
> + * A memory device is required by spec to implement a certain set of MMIO
> + * regions. The purpose of this function is to enumerate and map those
> + * registers.
> + */
> +static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> +{
> +	struct device *dev = &cxlm->pdev->dev;
> +	int cap, cap_count;
> +	u64 cap_array;
> +
> +	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
> +	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
> +	    CXLDEV_CAP_ARRAY_CAP_ID)
> +		return -ENODEV;
> +
> +	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
> +
> +	for (cap = 1; cap <= cap_count; cap++) {
> +		void __iomem *register_block;
> +		u32 offset;
> +		u16 cap_id;
> +
> +		cap_id = readl(cxlm->regs + cap * 0x10) & 0xffff;

Slight preference for FIELD_GET just for consistency.

> +		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
> +		register_block = cxlm->regs + offset;
> +
> +		switch (cap_id) {
> +		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
> +			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
> +			cxlm->status_regs = register_block;
> +			break;
> +		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
> +			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
> +			cxlm->mbox_regs = register_block;
> +			break;
> +		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
> +			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> +			break;
> +		case CXLDEV_CAP_CAP_ID_MEMDEV:
> +			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
> +			cxlm->memdev_regs = register_block;
> +			break;
> +		default:
> +			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
> +			break;
> +		}
> +	}
> +
> +	if (!cxlm->status_regs || !cxlm->mbox_regs || !cxlm->memdev_regs) {
> +		dev_err(dev, "registers not found: %s%s%s\n",
> +			!cxlm->status_regs ? "status " : "",
> +			!cxlm->mbox_regs ? "mbox " : "",
> +			!cxlm->memdev_regs ? "memdev" : "");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +

...

> +
> +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> +				      u32 reg_hi)

I'm not really suggesting you change it at this point, but I'd have
done the splitting of reg_lo up and the building of the offset at the call site
rather than in here.  I think that would have been slightly easier to follow.

> +{
> +	struct device *dev = &pdev->dev;
> +	struct cxl_mem *cxlm;
> +	void __iomem *regs;
> +	u64 offset;
> +	u8 bar;
> +	int rc;
> +
> +	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> +	if (!cxlm) {
> +		dev_err(dev, "No memory available\n");
> +		return NULL;
> +	}
> +
> +	offset = ((u64)reg_hi << 32) | FIELD_GET(CXL_REGLOC_ADDR_MASK, reg_lo);
> +	bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> +
> +	/* Basic sanity check that BAR is big enough */
> +	if (pci_resource_len(pdev, bar) < offset) {
> +		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> +			&pdev->resource[bar], (unsigned long long)offset);
> +		return NULL;
> +	}
> +
> +	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> +	if (rc) {
> +		dev_err(dev, "failed to map registers\n");
> +		return NULL;
> +	}
> +	regs = pcim_iomap_table(pdev)[bar];
> +
> +	mutex_init(&cxlm->mbox_mutex);
> +	cxlm->pdev = pdev;
> +	cxlm->regs = regs + offset;
> +
> +	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> +	return cxlm;
> +}
>  
>  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  {
> @@ -28,10 +479,65 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  	return 0;
>  }
>  
> +/**
> + * cxl_mem_identify() - Send the IDENTIFY command to the device.
> + * @cxlm: The device to identify.
> + *
> + * Return: 0 if identify was executed successfully.
> + *
> + * This will dispatch the identify command to the device and on success populate
> + * structures to be exported to sysfs.
> + */
> +static int cxl_mem_identify(struct cxl_mem *cxlm)
> +{
> +	struct cxl_mbox_identify {
> +		char fw_revision[0x10];
> +		__le64 total_capacity;
> +		__le64 volatile_capacity;
> +		__le64 persistent_capacity;
> +		__le64 partition_align;
> +		__le16 info_event_log_size;
> +		__le16 warning_event_log_size;
> +		__le16 failure_event_log_size;
> +		__le16 fatal_event_log_size;
> +		__le32 lsa_size;
> +		u8 poison_list_max_mer[3];
> +		__le16 inject_poison_limit;
> +		u8 poison_caps;
> +		u8 qos_telemetry_caps;
> +	} __packed id;
> +	int rc;
> +
> +	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
> +				   sizeof(id));
> +	if (rc < 0)
> +		return rc;
> +
> +	/*
> +	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
> +	 * For now, only the capacity is exported in sysfs
> +	 */
> +	cxlm->ram_range.start = 0;
> +	cxlm->ram_range.end = le64_to_cpu(id.volatile_capacity) - 1;
> +
> +	cxlm->pmem_range.start = 0;
> +	cxlm->pmem_range.end = le64_to_cpu(id.persistent_capacity) - 1;
> +
> +	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> +
> +	return 0;
> +}
> +
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct device *dev = &pdev->dev;
> -	int regloc;
> +	struct cxl_mem *cxlm = NULL;
> +	int rc, regloc, i;
> +	u32 regloc_size;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
>  
>  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
>  	if (!regloc) {
> @@ -39,7 +545,40 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return -ENXIO;
>  	}
>  
> -	return 0;
> +	/* Get the size of the Register Locator DVSEC */
> +	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> +	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);

The size field here is the dvsec length..  Let's say we only have one register block
entry at +0x0c and +0x10
From PCI spec :

"DVSEC Length - This field indicates the number of bytes in the entire DVSEC structure, including the PCI
Express Extended Capability Header, the DVSEC Header 1, DVSEC Header 2, and DVSEC vendor-specific
registers."

So here it would be 0x14

> +
> +	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;

We then shift regloc forward by +0xc

> +
> +	for (i = regloc; i < regloc + regloc_size; i += 8) {

This loop will then index form
i= +0xc to i < +0c + 0x14 (0x20)
i = 0xc, 0x14 

So that's indexing one more entry than is actually present.
Should be something like

	for (i = regloc;
	     i < regloc + regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
	     i++) 

which will mean the only iteration for this example is the one with i == +0xC

> +		u32 reg_lo, reg_hi;
> +		u8 reg_type;
> +
> +		/* "register low and high" contain other bits */
> +		pci_read_config_dword(pdev, i, &reg_lo);
> +		pci_read_config_dword(pdev, i + 4, &reg_hi);
> +
> +		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> +
> +		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> +			break;
> +		}
> +	}
> +
> +	if (!cxlm)
> +		return -ENODEV;
> +
> +	rc = cxl_mem_setup_regs(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_mem_setup_mailbox(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_mem_identify(cxlm);
>  }
>  
>  static const struct pci_device_id cxl_mem_pci_tbl[] = {
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index e464bea3f4d3..af3ec078cf6c 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -9,9 +9,23 @@
>   * See section 8.1 Configuration Space Registers in the CXL 2.0
>   * Specification
>   */
> +#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>  #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
>  #define PCI_DVSEC_ID_CXL		0x0
>  
>  #define PCI_DVSEC_ID_CXL_REGLOC_OFFSET		0x8
> +#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
> +
> +/* BAR Indicator Register (BIR) */
> +#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
> +
> +/* Register Block Identifier (RBI) */
> +#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
> +#define CXL_REGLOC_RBI_EMPTY 0
> +#define CXL_REGLOC_RBI_COMPONENT 1
> +#define CXL_REGLOC_RBI_VIRT 2
> +#define CXL_REGLOC_RBI_MEMDEV 3
> +
> +#define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
>  
>  #endif /* __CXL_PCI_H__ */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
