Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D883098F4
	for <lists+linux-nvdimm@lfdr.de>; Sun, 31 Jan 2021 00:52:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B825100EBBB1;
	Sat, 30 Jan 2021 15:52:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=rientjes@google.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1BD6C100EBBB1
	for <linux-nvdimm@lists.01.org>; Sat, 30 Jan 2021 15:52:00 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l18so8788705pji.3
        for <linux-nvdimm@lists.01.org>; Sat, 30 Jan 2021 15:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4tJA9R1tXRY55+u/RzNRnqnTk/+08aiPW2+YkT7/BQE=;
        b=SyqOehVDl8kg6o0TLe9LqJJjok6c4VmuYoxOSSv2LlEg4WrqWob7Fn0CzCgxJUFWGT
         UgQ7ihf138smdfiWTRzkA5Eu/TSQ8qAXb1kNyjD0X7/GnsrbN+fkcW8Rk1YBBYlAnDjP
         n35R0V3kg670nIMl31XK3ygFAsctH1HxTJAVblP3y/g4PTRJh5Xp0MdeI1Jmj0HDwIA7
         fZgLTK9VXFUX69+Oo4Ooycgblmx1QDBSL1S2G7N0fbaVd5ipbHRNhq3L+kA94uyX0/sY
         3ECPaHP2/EFUli9LD1K9j4AO2tDu953LCuNUxirlUDm72jAq5xcT+V2zkTpSV/8ioqfC
         yKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4tJA9R1tXRY55+u/RzNRnqnTk/+08aiPW2+YkT7/BQE=;
        b=GQzfTHkMmLSP8HNQhXtu5FiE3PmCA8ZO0nI+CWo3RiXyegjs4z0ZE1UOZ2+7CbTRhU
         UFl1iJ7vrthDsv+8rofqMrOuVXKCz+f4Qvl1b043V5ZzooqbU+oSKZAv+4POkay0V/1D
         3PuBsN4Z7HP9FWmwfQCDwWOEYAiVSHg4OtlBB9HaFAQ+vFhauku2F1DozHIku9Wwr0CS
         RPjm98FeUakO1UD1CsmkvZdMnW0fd3EW1xhEwE3r9W2gTtugo3PYrgyYY0jpFR9MVZ11
         w+kboETY8PG9lqsEPyBKiFQ/mTcHzSibjQAgiAsKMI1kGKFY6aI2v7/62FlrtnSk5Y/M
         s11w==
X-Gm-Message-State: AOAM533RBRgqV93P4VVRRQjALSh4EmPcqF3LBKgL1+NyQvX+iPigGnBC
	YrxqBBVzDhNoO6liBkdmTB2JMA==
X-Google-Smtp-Source: ABdhPJzbeH1cpnWrFXvI5e/1pIcj58Q56rCTn6UaXTnWQSOP/5uJVGre/wiqwtdwcPE755m+JuBUKw==
X-Received: by 2002:a17:902:eec4:b029:de:aa86:5269 with SMTP id h4-20020a170902eec4b02900deaa865269mr11757591plb.66.1612050719350;
        Sat, 30 Jan 2021 15:51:59 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id t6sm12638941pfc.64.2021.01.30.15.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:51:58 -0800 (PST)
Date: Sat, 30 Jan 2021 15:51:57 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
In-Reply-To: <20210130002438.1872527-5-ben.widawsky@intel.com>
Message-ID: <5986abe5-1248-30b2-5f53-fa7013baafad@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-5-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: D5DMYKATYRGMUMO4LLP23BGJIPNTHLFJ
X-Message-ID-Hash: D5DMYKATYRGMUMO4LLP23BGJIPNTHLFJ
X-MailFrom: rientjes@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D5DMYKATYRGMUMO4LLP23BGJIPNTHLFJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> Provide enough functionality to utilize the mailbox of a memory device.
> The mailbox is used to interact with the firmware running on the memory
> device.
> 
> The CXL specification defines separate capabilities for the mailbox and
> the memory device. The mailbox interface has a doorbell to indicate
> ready to accept commands and the memory device has a capability register
> that indicates the mailbox interface is ready. The expectation is that
> the doorbell-ready is always later than the memory-device-indication
> that the mailbox is ready.
> 
> Create a function to handle sending a command, optionally with a
> payload, to the memory device, polling on a result, and then optionally
> copying out the payload. The algorithm for doing this comes straight out
> of the CXL 2.0 specification.
> 
> Primary mailboxes are capable of generating an interrupt when submitting
> a command in the background. That implementation is saved for a later
> time.
> 
> Secondary mailboxes aren't implemented at this time.
> 
> The flow is proven with one implemented command, "identify". Because the
> class code has already told the driver this is a memory device and the
> identify command is mandatory.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/Kconfig |  14 ++
>  drivers/cxl/cxl.h   |  39 +++++
>  drivers/cxl/mem.c   | 342 +++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 394 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 3b66b46af8a0..fe591f74af96 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -32,4 +32,18 @@ config CXL_MEM
>  	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
>  
>  	  If unsure say 'm'.
> +
> +config CXL_MEM_INSECURE_DEBUG
> +	bool "CXL.mem debugging"
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

Not specific to this patch, but the reference to encryption made me 
curious about integrity: are all CXL.mem devices compatible with DIMP? 
Some?  None?

> +
>  endif
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a3da7f8050c4..df3d97154b63 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -31,9 +31,36 @@
>  #define CXLDEV_MB_CAPS_OFFSET 0x00
>  #define   CXLDEV_MB_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
>  #define CXLDEV_MB_CTRL_OFFSET 0x04
> +#define   CXLDEV_MB_CTRL_DOORBELL BIT(0)
>  #define CXLDEV_MB_CMD_OFFSET 0x08
> +#define   CXLDEV_MB_CMD_COMMAND_OPCODE_MASK GENMASK(15, 0)
> +#define   CXLDEV_MB_CMD_PAYLOAD_LENGTH_MASK GENMASK(36, 16)
>  #define CXLDEV_MB_STATUS_OFFSET 0x10
> +#define   CXLDEV_MB_STATUS_RET_CODE_MASK GENMASK(47, 32)
>  #define CXLDEV_MB_BG_CMD_STATUS_OFFSET 0x18
> +#define CXLDEV_MB_PAYLOAD_OFFSET 0x20
> +
> +/* Memory Device (CXL 2.0 - 8.2.8.5.1.1) */
> +#define CXLMDEV_STATUS_OFFSET 0x0
> +#define   CXLMDEV_DEV_FATAL BIT(0)
> +#define   CXLMDEV_FW_HALT BIT(1)
> +#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
> +#define     CXLMDEV_MS_NOT_READY 0
> +#define     CXLMDEV_MS_READY 1
> +#define     CXLMDEV_MS_ERROR 2
> +#define     CXLMDEV_MS_DISABLED 3
> +#define   CXLMDEV_READY(status) \
> +		(CXL_GET_FIELD(status, CXLMDEV_STATUS_MEDIA_STATUS) == CXLMDEV_MS_READY)
> +#define   CXLMDEV_MBOX_IF_READY BIT(4)
> +#define   CXLMDEV_RESET_NEEDED_SHIFT 5
> +#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
> +#define     CXLMDEV_RESET_NEEDED_NOT 0
> +#define     CXLMDEV_RESET_NEEDED_COLD 1
> +#define     CXLMDEV_RESET_NEEDED_WARM 2
> +#define     CXLMDEV_RESET_NEEDED_HOT 3
> +#define     CXLMDEV_RESET_NEEDED_CXL 4
> +#define   CXLMDEV_RESET_NEEDED(status) \
> +		(CXL_GET_FIELD(status, CXLMDEV_RESET_NEEDED) != CXLMDEV_RESET_NEEDED_NOT)
>  
>  /**
>   * struct cxl_mem - A CXL memory device
> @@ -44,6 +71,16 @@ struct cxl_mem {
>  	struct pci_dev *pdev;
>  	void __iomem *regs;
>  
> +	struct {
> +		struct range range;
> +	} pmem;
> +
> +	struct {
> +		struct range range;
> +	} ram;
> +
> +	char firmware_version[0x10];
> +
>  	/* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
>  	struct {
>  		void __iomem *regs;
> @@ -51,6 +88,7 @@ struct cxl_mem {
>  
>  	/* Cap 0002h - CXL_CAP_CAP_ID_PRIMARY_MAILBOX */
>  	struct {
> +		struct mutex mutex; /* Protects device mailbox and firmware */
>  		void __iomem *regs;
>  		size_t payload_size;
>  	} mbox;
> @@ -89,5 +127,6 @@ struct cxl_mem {
>  
>  cxl_reg(status);
>  cxl_reg(mbox);
> +cxl_reg(mem);
>  
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fa14d51243ee..69ed15bfa5d4 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -6,6 +6,270 @@
>  #include "pci.h"
>  #include "cxl.h"
>  
> +#define cxl_doorbell_busy(cxlm)                                                \
> +	(cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET) &                    \
> +	 CXLDEV_MB_CTRL_DOORBELL)
> +
> +#define CXL_MAILBOX_TIMEOUT_US 2000

This should be _MS?

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
> + * Command Register section of the CXL 2.0 spec (8.2.8.4.5). @payload_in and
> + * @payload_out are written to, and read from the Command Payload Registers
> + * defined in (8.2.8.4.8).
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
> +static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> +{
> +	const int timeout = msecs_to_jiffies(CXL_MAILBOX_TIMEOUT_US);
> +	const unsigned long start = jiffies;
> +	unsigned long end = start;
> +
> +	while (cxl_doorbell_busy(cxlm)) {
> +		end = jiffies;
> +
> +		if (time_after(end, start + timeout)) {
> +			/* Check again in case preempted before timeout test */
> +			if (!cxl_doorbell_busy(cxlm))
> +				break;
> +			return -ETIMEDOUT;
> +		}
> +		cpu_relax();
> +	}
> +
> +	dev_dbg(&cxlm->pdev->dev, "Doorbell wait took %dms",
> +		jiffies_to_msecs(end) - jiffies_to_msecs(start));
> +	return 0;
> +}
> +
> +static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> +				 struct mbox_cmd *mbox_cmd)
> +{
> +	dev_warn(&cxlm->pdev->dev, "Mailbox command timed out\n");
> +	dev_info(&cxlm->pdev->dev,
> +		 "\topcode: 0x%04x\n"
> +		 "\tpayload size: %zub\n",
> +		 mbox_cmd->opcode, mbox_cmd->size_in);
> +
> +	if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
> +		print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
> +				     mbox_cmd->payload_in, mbox_cmd->size_in,
> +				     true);
> +	}
> +
> +	/* Here's a good place to figure out if a device reset is needed */

What are the implications if we don't do a reset, as this implementation 
does not?  IOW, does a timeout require a device to be recovered through a 
reset before it can receive additional commands, or is it safe to simply 
drop the command that timed out on the floor and proceed?

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
> +	void __iomem *payload = cxlm->mbox.regs + CXLDEV_MB_PAYLOAD_OFFSET;

Do you need to verify the payload is non-empty per 8.2.8.4?

> +	u64 cmd_reg, status_reg;
> +	size_t out_len;
> +	int rc;
> +
> +	lockdep_assert_held(&cxlm->mbox.mutex);
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
> +	 *   Hardware is free to do whatever it wants before the doorbell is
> +	 *   rung, and isn't allowed to change anything after it clears the
> +	 *   doorbell. As such, steps 2 and 3 can happen in any order, and steps
> +	 *   6, 7, 8 can also happen in any order (though some orders might not
> +	 *   make sense).

I'd remove the indent from this paragraph since it's not part of the spec, 
it's an inference based on the constraints imposed by the spec.

> +	 */
> +
> +	/* #1 */
> +	if (cxl_doorbell_busy(cxlm)) {
> +		dev_err_ratelimited(&cxlm->pdev->dev,
> +				    "Mailbox re-busy after acquiring\n");
> +		return -EBUSY;
> +	}
> +
> +	cmd_reg = CXL_SET_FIELD(mbox_cmd->opcode, CXLDEV_MB_CMD_COMMAND_OPCODE);
> +	if (mbox_cmd->size_in) {
> +		if (WARN_ON(!mbox_cmd->payload_in))
> +			return -EINVAL;
> +
> +		cmd_reg |= CXL_SET_FIELD(mbox_cmd->size_in,
> +					 CXLDEV_MB_CMD_PAYLOAD_LENGTH);
> +		memcpy_toio(payload, mbox_cmd->payload_in, mbox_cmd->size_in);
> +	}
> +
> +	/* #2, #3 */
> +	cxl_write_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET, cmd_reg);
> +
> +	/* #4 */
> +	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
> +	cxl_write_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET,
> +			     CXLDEV_MB_CTRL_DOORBELL);
> +
> +	/* #5 */
> +	rc = cxl_mem_wait_for_doorbell(cxlm);
> +	if (rc == -ETIMEDOUT) {
> +		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
> +		return rc;
> +	}
> +
> +	/* #6 */
> +	status_reg = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_STATUS_OFFSET);
> +	mbox_cmd->return_code =
> +		CXL_GET_FIELD(status_reg, CXLDEV_MB_STATUS_RET_CODE);
> +
> +	if (mbox_cmd->return_code != 0) {
> +		dev_dbg(&cxlm->pdev->dev, "Mailbox operation had an error\n");
> +		return 0;
> +	}
> +
> +	/* #7 */
> +	cmd_reg = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET);
> +	out_len = CXL_GET_FIELD(cmd_reg, CXLDEV_MB_CMD_PAYLOAD_LENGTH);
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
> +/**
> + * cxl_mem_mbox_get() - Acquire exclusive access to the mailbox.
> + * @cxlm: The memory device to gain access to.
> + *
> + * Context: Any context. Takes the mbox_lock.
> + * Return: 0 if exclusive access was acquired.
> + */
> +static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
> +{
> +	struct device *dev = &cxlm->pdev->dev;
> +	int rc = -EBUSY;
> +	u64 md_status;
> +
> +	mutex_lock_io(&cxlm->mbox.mutex);
> +
> +	/*
> +	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> +	 * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
> +	 * bit is to allow firmware running on the device to notify the driver
> +	 * that it's ready to receive commands. It is unclear if the bit needs
> +	 * to be read for each transaction mailbox, ie. the firmware can switch
> +	 * it on and off as needed. Second, there is no defined timeout for
> +	 * mailbox ready, like there is for the doorbell interface.
> +	 *
> +	 * Assumptions:
> +	 * 1. The firmware might toggle the Mailbox Interface Ready bit, check
> +	 *    it for every command.
> +	 *
> +	 * 2. If the doorbell is clear, the firmware should have first set the
> +	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> +	 *    to be ready is sufficient.
> +	 */
> +	rc = cxl_mem_wait_for_doorbell(cxlm);
> +	if (rc) {
> +		dev_warn(dev, "Mailbox interface not ready\n");
> +		goto out;
> +	}
> +
> +	md_status = cxl_read_mem_reg64(cxlm, CXLMDEV_STATUS_OFFSET);
> +	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> +		dev_err(dev,
> +			"mbox: reported doorbell ready, but not mbox ready\n");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Hardware shouldn't allow a ready status but also have failure bits
> +	 * set. Spit out an error, this should be a bug report
> +	 */
> +	rc = -EFAULT;
> +	if (md_status & CXLMDEV_DEV_FATAL) {
> +		dev_err(dev, "mbox: reported ready, but fatal\n");
> +		goto out;
> +	}
> +	if (md_status & CXLMDEV_FW_HALT) {
> +		dev_err(dev, "mbox: reported ready, but halted\n");
> +		goto out;
> +	}
> +	if (CXLMDEV_RESET_NEEDED(md_status)) {
> +		dev_err(dev, "mbox: reported ready, but reset needed\n");
> +		goto out;
> +	}
> +
> +	/* with lock held */
> +	return 0;
> +
> +out:
> +	mutex_unlock(&cxlm->mbox.mutex);
> +	return rc;
> +}
> +
> +/**
> + * cxl_mem_mbox_put() - Release exclusive access to the mailbox.
> + * @cxlm: The CXL memory device to communicate with.
> + *
> + * Context: Any context. Expects mbox_lock to be held.
> + */
> +static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
> +{
> +	mutex_unlock(&cxlm->mbox.mutex);
> +}
> +
>  /**
>   * cxl_mem_setup_regs() - Setup necessary MMIO.
>   * @cxlm: The CXL memory device to communicate with.
> @@ -142,6 +406,8 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>  		return NULL;
>  	}
>  
> +	mutex_init(&cxlm->mbox.mutex);
> +
>  	regs = pcim_iomap_table(pdev)[bar];
>  	cxlm->pdev = pdev;
>  	cxlm->regs = regs + offset;
> @@ -174,6 +440,76 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
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
> +	struct mbox_cmd mbox_cmd;

Just initialize mbox_cmd here?

> +	int rc;
> +
> +	/* Retrieve initial device memory map */
> +	rc = cxl_mem_mbox_get(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	mbox_cmd = (struct mbox_cmd){
> +		.opcode = CXL_MBOX_OP_IDENTIFY,
> +		.payload_out = &id,
> +		.size_in = 0,
> +	};
> +	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> +	cxl_mem_mbox_put(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	/* TODO: Handle retry or reset responses from firmware. */
> +	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS) {
> +		dev_err(&cxlm->pdev->dev, "Mailbox command failed (%d)\n",
> +			mbox_cmd.return_code);
> +		return -ENXIO;
> +	}
> +
> +	if (mbox_cmd.size_out != sizeof(id))
> +		return -ENXIO;
> +
> +	/*
> +	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
> +	 * For now, only the capacity is exported in sysfs
> +	 */
> +	cxlm->ram.range.start = 0;
> +	cxlm->ram.range.end = le64_to_cpu(id.volatile_capacity) - 1;
> +
> +	cxlm->pmem.range.start = 0;
> +	cxlm->pmem.range.end = le64_to_cpu(id.persistent_capacity) - 1;
> +
> +	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> +
> +	return rc;
> +}
> +
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -219,7 +555,11 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	return cxl_mem_setup_mailbox(cxlm);
> +	rc = cxl_mem_setup_mailbox(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_mem_identify(cxlm);
>  }
>  
>  static const struct pci_device_id cxl_mem_pci_tbl[] = {
> -- 
> 2.30.0
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
