Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059DC316D03
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 18:42:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 21688100EA90D;
	Wed, 10 Feb 2021 09:42:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9079100EA90C
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 09:42:11 -0800 (PST)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbRjv1YlDz67mTF;
	Thu, 11 Feb 2021 01:35:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 10 Feb 2021 18:42:06 +0100
Received: from localhost (10.47.67.2) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Feb
 2021 17:42:05 +0000
Date: Wed, 10 Feb 2021 17:41:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v2 2/8] cxl/mem: Find device capabilities
Message-ID: <20210210174104.0000710a@Huawei.com>
In-Reply-To: <20210210000259.635748-3-ben.widawsky@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
	<20210210000259.635748-3-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.67.2]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: LPVNGGMABPV6AGJ4LMRV3JK3QF4AKLTJ
X-Message-ID-Hash: LPVNGGMABPV6AGJ4LMRV3JK3QF4AKLTJ
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Chris Browy  <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>,  Dan Williams  <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>, "Jon Masters  <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LPVNGGMABPV6AGJ4LMRV3JK3QF4AKLTJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 9 Feb 2021 16:02:53 -0800
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
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

A few more comments inline (proper review whereas my other reply was a
bug chase).

Jonathan

> ---
>  drivers/cxl/Kconfig           |  14 +
>  drivers/cxl/cxl.h             |  93 +++++++
>  drivers/cxl/mem.c             | 511 +++++++++++++++++++++++++++++++++-
>  drivers/cxl/pci.h             |  13 +
>  include/uapi/linux/pci_regs.h |   1 +
>  5 files changed, 630 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cxl/cxl.h
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 9e80b311e928..c4ba3aa0a05d 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -32,4 +32,18 @@ config CXL_MEM
>  	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
>  
>  	  If unsure say 'm'.
> +
> +config CXL_MEM_INSECURE_DEBUG
> +	bool "CXL.mem debugging"

As mentioned below, this makes me a tiny bit uncomfortable.

> +	depends on CXL_MEM
> +	help
> +	  Enable debug of all CXL command payloads.
> +
> +	  Some CXL devices and controllers support encryption and other
> +	  security features. The payloads for the commands that enable
> +	  those features may contain sensitive clear-text security
> +	  material. Disable debug of those command payloads by default.
> +	  If you are a kernel developer actively working on CXL
> +	  security enabling say Y, otherwise say N.
> +
>  endif
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> new file mode 100644
> index 000000000000..745f5e0bfce3
> --- /dev/null
> +++ b/drivers/cxl/cxl.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. */
> +
> +#ifndef __CXL_H__
> +#define __CXL_H__
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +
> +/* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
> +#define CXLDEV_CAP_ARRAY_OFFSET 0x0
> +#define   CXLDEV_CAP_ARRAY_CAP_ID 0
> +#define   CXLDEV_CAP_ARRAY_ID_MASK GENMASK(15, 0)
> +#define   CXLDEV_CAP_ARRAY_COUNT_MASK GENMASK(47, 32)
> +/* CXL 2.0 8.2.8.2.1 CXL Device Capabilities */
> +#define CXLDEV_CAP_CAP_ID_DEVICE_STATUS 0x1
> +#define CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX 0x2
> +#define CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX 0x3
> +#define CXLDEV_CAP_CAP_ID_MEMDEV 0x4000
> +
> +/* CXL 2.0 8.2.8.4 Mailbox Registers */
> +#define CXLDEV_MBOX_CAPS_OFFSET 0x00
> +#define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> +#define CXLDEV_MBOX_CTRL_OFFSET 0x04
> +#define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
> +#define CXLDEV_MBOX_CMD_OFFSET 0x08
> +#define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK(15, 0)
> +#define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK(36, 16)
> +#define CXLDEV_MBOX_STATUS_OFFSET 0x10
> +#define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK(47, 32)
> +#define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
> +#define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
> +
> +/* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> +#define CXLMDEV_STATUS_OFFSET 0x0
> +#define   CXLMDEV_DEV_FATAL BIT(0)
> +#define   CXLMDEV_FW_HALT BIT(1)
> +#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
> +#define     CXLMDEV_MS_NOT_READY 0
> +#define     CXLMDEV_MS_READY 1
> +#define     CXLMDEV_MS_ERROR 2
> +#define     CXLMDEV_MS_DISABLED 3
> +#define CXLMDEV_READY(status)                                                  \
> +	(FIELD_GET(CXLMDEV_STATUS_MEDIA_STATUS_MASK, status) ==                \
> +	 CXLMDEV_MS_READY)
> +#define   CXLMDEV_MBOX_IF_READY BIT(4)
> +#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
> +#define     CXLMDEV_RESET_NEEDED_NOT 0
> +#define     CXLMDEV_RESET_NEEDED_COLD 1
> +#define     CXLMDEV_RESET_NEEDED_WARM 2
> +#define     CXLMDEV_RESET_NEEDED_HOT 3
> +#define     CXLMDEV_RESET_NEEDED_CXL 4
> +#define CXLMDEV_RESET_NEEDED(status)                                           \
> +	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
> +	 CXLMDEV_RESET_NEEDED_NOT)
> +
> +/**
> + * struct cxl_mem - A CXL memory device
> + * @pdev: The PCI device associated with this CXL device.
> + * @regs: IO mappings to the device's MMIO
> + * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
> + * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
> + * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
> + * @payload_size: Size of space for payload
> + *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
> + * @mbox_mutex: Mutex to synchronize mailbox access.
> + * @firmware_version: Firmware version for the memory device.
> + * @pmem: Persistent memory capacity information.
> + * @ram: Volatile memory capacity information.
> + */
> +struct cxl_mem {
> +	struct pci_dev *pdev;
> +	void __iomem *regs;
> +
> +	void __iomem *status_regs;
> +	void __iomem *mbox_regs;
> +	void __iomem *memdev_regs;
> +
> +	size_t payload_size;
> +	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> +	char firmware_version[0x10];
> +
> +	struct {
> +		struct range range;
> +	} pmem;

Christoph raised this in v1, and I agree with him that his would me more compact
and readable as

	struct range pmem_range;
	struct range ram_range;

The discussion seemed to get lost without getting resolved that I can see.

> +
> +	struct {
> +		struct range range;
> +	} ram;

> +};
> +
> +#endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 99a6571508df..0a868a15badc 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c


...

> +static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> +				 struct mbox_cmd *mbox_cmd)
> +{
> +	struct device *dev = &cxlm->pdev->dev;
> +
> +	dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
> +		mbox_cmd->opcode, mbox_cmd->size_in);
> +
> +	if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {

Hmm.  Whilst I can see the advantage of this for debug, I'm not sure we want
it upstream even under a rather evil looking CONFIG variable.

Is there a bigger lock we can use to avoid chance of accidental enablement?


> +		print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
> +				     mbox_cmd->payload_in, mbox_cmd->size_in,
> +				     true);
> +	}
> +}
> +
> +/**
> + * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> + * @cxlm: The CXL memory device to communicate with.
> + * @mbox_cmd: Command to send to the memory device.
> + *
> + * Context: Any context. Expects mbox_lock to be held.
> + * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
> + *         Caller should check the return code in @mbox_cmd to make sure it
> + *         succeeded.
> + *
> + * This is a generic form of the CXL mailbox send command, thus the only I/O
> + * operations used are cxl_read_mbox_reg(). Memory devices, and perhaps other
> + * types of CXL devices may have further information available upon error
> + * conditions.
> + *
> + * The CXL spec allows for up to two mailboxes. The intention is for the primary
> + * mailbox to be OS controlled and the secondary mailbox to be used by system
> + * firmware. This allows the OS and firmware to communicate with the device and
> + * not need to coordinate with each other. The driver only uses the primary
> + * mailbox.
> + */
> +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> +				 struct mbox_cmd *mbox_cmd)
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

See earlier diversion whilst I was chasing my bug (another branch of this
thread)

> +	}
> +
> +	/* #7 */
> +	cmd_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> +	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
> +
> +	/* #8 */
> +	if (out_len && mbox_cmd->payload_out)
> +		memcpy_fromio(mbox_cmd->payload_out, payload, out_len);
> +
> +	mbox_cmd->size_out = out_len;
> +
> +	return 0;
> +}
> +


...

> +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> +				      u32 reg_hi)
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
> +	if (rc != 0) {

if (rc) 

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

...

>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct device *dev = &pdev->dev;
> -	int regloc;
> +	struct cxl_mem *cxlm;
> +	int rc, regloc, i;
> +	u32 regloc_size;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
>  
>  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
>  	if (!regloc) {
> @@ -39,7 +509,44 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return -ENXIO;
>  	}
>  
> -	return 0;
> +	/* Get the size of the Register Locator DVSEC */
> +	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> +	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> +
> +	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> +
> +	rc = -ENXIO;
> +	for (i = regloc; i < regloc + regloc_size; i += 8) {
> +		u32 reg_lo, reg_hi;
> +		u8 reg_type;
> +
> +		/* "register low and high" contain other bits */

high doesn't contain any other bits so that's a tiny bit misleading.

> +		pci_read_config_dword(pdev, i, &reg_lo);
> +		pci_read_config_dword(pdev, i + 4, &reg_hi);
> +
> +		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> +
> +		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> +			rc = 0;

I sort of assumed this unusual structure was to allow for some future
change, but checked end result and it still looks like this.
So, drop the rc assignment here and...

> +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> +			if (!cxlm)
> +				rc = -ENODEV;

return -ENODEV;

> +			break;
> +		}
> +	}
> +
> +	if (rc)
> +		return rc;

With above direct return, only get here if rc = -ENXIO.
Could just as easily check if i >= regloc + regloc_size then it's
obvious this is kind of canonical form of 'not found'.


Alternative would be to treat the above as a 'find' loop then
have the clxm = cxl_mem_create() outside of the loop.


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
> index f135b9f7bb21..ffcbc13d7b5b 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -14,5 +14,18 @@
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

CXL_REGLOCL_ADDR_LOW_MASK perhaps for clarity?

>  
>  #endif /* __CXL_PCI_H__ */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e709ae8235e7..6267ca9ae683 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1080,6 +1080,7 @@
>  
>  /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
>  #define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-Specific Header1 */
> +#define PCI_DVSEC_HEADER1_LENGTH_MASK	0xFFF00000

Seems sensible to add the revision mask as well.
The vendor id currently read using a word read rather than dword, but perhaps
neater to add that as well for completeness?

Having said that, given Bjorn's comment on clashes and the fact he'd rather see
this stuff defined in drivers and combined later (see review patch 1 and follow
the link) perhaps this series should not touch this header at all.
 
>  #define PCI_DVSEC_HEADER2		0x8 /* Designated Vendor-Specific Header2 */
>  
>  /* Data Link Feature */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
