Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5372319234
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 19:27:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA00D100EA2B6;
	Thu, 11 Feb 2021 10:27:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 247DD100EBBB1
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 10:27:44 -0800 (PST)
IronPort-SDR: I1kw2rcZ+QaX85cooXEtLe0+kMTWKZrEVsCxurh5PaG1bfTgRYx3Gly2t+UW1ii0nYjd64k7Ds
 Frz+eeHpIzIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="169421174"
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400";
   d="scan'208";a="169421174"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 10:27:44 -0800
IronPort-SDR: elIk349DQyDh644AggX470YSysO1hkJJFZIpOHWMiAjHOmHsmKeibjlEjNzDOkq6fRqExZpyXq
 6+g2DxOLUkng==
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400";
   d="scan'208";a="380840785"
Received: from reknight-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.254])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 10:27:42 -0800
Date: Thu, 11 Feb 2021 10:27:41 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/8] cxl/mem: Find device capabilities
Message-ID: <20210211182741.yrojts2cdyoufsfl@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-3-ben.widawsky@intel.com>
 <20210210133252.000047af@Huawei.com>
 <20210210150759.00005684@Huawei.com>
 <20210210165557.7fuqbyr7e7zjoxaa@intel.com>
 <20210210181605.ecbl3m5ep4rszpqs@intel.com>
 <20210211095548.00000da7@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210211095548.00000da7@Huawei.com>
Message-ID-Hash: XM2Q6LVSZIWY7OWXPO6ZEEAQA6VLYACH
X-Message-ID-Hash: XM2Q6LVSZIWY7OWXPO6ZEEAQA6VLYACH
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XM2Q6LVSZIWY7OWXPO6ZEEAQA6VLYACH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-11 09:55:48, Jonathan Cameron wrote:
> On Wed, 10 Feb 2021 10:16:05 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > On 21-02-10 08:55:57, Ben Widawsky wrote:
> > > On 21-02-10 15:07:59, Jonathan Cameron wrote:  
> > > > On Wed, 10 Feb 2021 13:32:52 +0000
> > > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > > >   
> > > > > On Tue, 9 Feb 2021 16:02:53 -0800
> > > > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >   
> > > > > > Provide enough functionality to utilize the mailbox of a memory device.
> > > > > > The mailbox is used to interact with the firmware running on the memory
> > > > > > device. The flow is proven with one implemented command, "identify".
> > > > > > Because the class code has already told the driver this is a memory
> > > > > > device and the identify command is mandatory.
> > > > > > 
> > > > > > CXL devices contain an array of capabilities that describe the
> > > > > > interactions software can have with the device or firmware running on
> > > > > > the device. A CXL compliant device must implement the device status and
> > > > > > the mailbox capability. Additionally, a CXL compliant memory device must
> > > > > > implement the memory device capability. Each of the capabilities can
> > > > > > [will] provide an offset within the MMIO region for interacting with the
> > > > > > CXL device.
> > > > > > 
> > > > > > The capabilities tell the driver how to find and map the register space
> > > > > > for CXL Memory Devices. The registers are required to utilize the CXL
> > > > > > spec defined mailbox interface. The spec outlines two mailboxes, primary
> > > > > > and secondary. The secondary mailbox is earmarked for system firmware,
> > > > > > and not handled in this driver.
> > > > > > 
> > > > > > Primary mailboxes are capable of generating an interrupt when submitting
> > > > > > a background command. That implementation is saved for a later time.
> > > > > > 
> > > > > > Link: https://www.computeexpresslink.org/download-the-specification
> > > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>    
> > > > > 
> > > > > Hi Ben,
> > > > > 
> > > > >   
> > > > > > +/**
> > > > > > + * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> > > > > > + * @cxlm: The CXL memory device to communicate with.
> > > > > > + * @mbox_cmd: Command to send to the memory device.
> > > > > > + *
> > > > > > + * Context: Any context. Expects mbox_lock to be held.
> > > > > > + * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
> > > > > > + *         Caller should check the return code in @mbox_cmd to make sure it
> > > > > > + *         succeeded.    
> > > > > 
> > > > > cxl_xfer_log() doesn't check mbox_cmd->return_code and for my test it currently
> > > > > enters an infinite loop as a result.  
> > > 
> > > I meant to fix that.
> > >   
> > > > > 
> > > > > I haven't checked other paths, but to my mind it is not a good idea to require
> > > > > two levels of error checking - the example here proves how easy it is to forget
> > > > > one.  
> > > 
> > > Demonstrably, you're correct. I think it would be good to have a kernel only
> > > mbox command that does the error checking though. Let me type something up and
> > > see how it looks.  
> > 
> > Hi Jonathan. What do you think of this? The bit I'm on the fence about is if I
> > should validate output size too. I like the simplicity as it is, but it requires
> > every caller to possibly check output size, which is kind of the same problem
> > you're originally pointing out.
> 
> The simplicity is good and this is pretty much what I expected you would end up with
> (always reassuring)
> 
> For the output, perhaps just add another parameter to the wrapper for minimum
> output length expected?
> 
> Now you mention the length question.  It does rather feel like there should also
> be some protection on memcpy_fromio() copying too much data if the hardware
> happens to return an unexpectedly long length.  Should never happen, but
> the hardening is worth adding anyway given it's easy to do.
> 
> Jonathan
> 

I like it.

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2e199b05f686..58071a203212 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -293,7 +293,7 @@ static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
  * See __cxl_mem_mbox_send_cmd()
  */
 static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode, u8 *in,
-				 size_t in_size, u8 *out)
+				 size_t in_size, u8 *out, size_t out_min_size)
 {
 	struct mbox_cmd mbox_cmd = {
 		.opcode = opcode,
@@ -303,6 +303,9 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode, u8 *in,
 	};
 	int rc;
 
+	if (out_min_size > cxlm->payload_size)
+		return -E2BIG;
+
 	rc = cxl_mem_mbox_get(cxlm);
 	if (rc)
 		return rc;
@@ -316,6 +319,9 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode, u8 *in,
 	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
 		return -ENXIO;
 
+	if (mbox_cmd.size_out < out_min_size)
+		return -ENODATA;
+
 	return mbox_cmd.size_out;
 }
 
@@ -505,15 +511,10 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 	int rc;
 
 	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_IDENTIFY, NULL, 0,
-				   (u8 *)&id);
+				   (u8 *)&id, sizeof(id));
 	if (rc < 0)
 		return rc;
 
-	if (rc < sizeof(id)) {
-		dev_err(&cxlm->pdev->dev, "Short identify data\n");
-		return -ENXIO;
-	}
-
 	/*
 	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
 	 * For now, only the capacity is exported in sysfs


> 
> > 
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 55c5f5a6023f..ad7b2077ab28 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -284,7 +284,7 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> >  }
> >  
> >  /**
> > - * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> > + * __cxl_mem_mbox_send_cmd() - Execute a mailbox command
> >   * @cxlm: The CXL memory device to communicate with.
> >   * @mbox_cmd: Command to send to the memory device.
> >   *
> > @@ -296,7 +296,8 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> >   * This is a generic form of the CXL mailbox send command, thus the only I/O
> >   * operations used are cxl_read_mbox_reg(). Memory devices, and perhaps other
> >   * types of CXL devices may have further information available upon error
> > - * conditions.
> > + * conditions. Driver facilities wishing to send mailbox commands should use the
> > + * wrapper command.
> >   *
> >   * The CXL spec allows for up to two mailboxes. The intention is for the primary
> >   * mailbox to be OS controlled and the secondary mailbox to be used by system
> > @@ -304,8 +305,8 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> >   * not need to coordinate with each other. The driver only uses the primary
> >   * mailbox.
> >   */
> > -static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> > -				 struct mbox_cmd *mbox_cmd)
> > +static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> > +				   struct mbox_cmd *mbox_cmd)
> >  {
> >  	void __iomem *payload = cxlm->mbox_regs + CXLDEV_MBOX_PAYLOAD_OFFSET;
> >  	u64 cmd_reg, status_reg;
> > @@ -469,6 +470,54 @@ static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
> >  	mutex_unlock(&cxlm->mbox_mutex);
> >  }
> >  
> > +/**
> > + * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> > + * @cxlm: The CXL memory device to communicate with.
> > + * @opcode: Opcode for the mailbox command.
> > + * @in: The input payload for the mailbox command.
> > + * @in_size: The length of the input payload
> > + * @out: Caller allocated buffer for the output.
> > + *
> > + * Context: Any context. Will acquire and release mbox_mutex.
> > + * Return:
> > + *  * %>=0	- Number of bytes returned in @out.
> > + *  * %-EBUSY	- Couldn't acquire exclusive mailbox access.
> > + *  * %-EFAULT	- Hardware error occurred.
> > + *  * %-ENXIO	- Command completed, but device reported an error.
> > + *
> > + * Mailbox commands may execute successfully yet the device itself reported an
> > + * error. While this distinction can be useful for commands from userspace, the
> > + * kernel will often only care when both are successful.
> > + *
> > + * See __cxl_mem_mbox_send_cmd()
> > + */
> > +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode, u8 *in,
> > +				 size_t in_size, u8 *out)
> > +{
> > +	struct mbox_cmd mbox_cmd = {
> > +		.opcode = opcode,
> > +		.payload_in = in,
> > +		.size_in = in_size,
> > +		.payload_out = out,
> > +	};
> > +	int rc;
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
> > +	return mbox_cmd.size_out;
> > +}
> > +
> >  /**
> >   * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
> >   * @cxlmd: The CXL memory device to communicate with.
> > @@ -1380,33 +1429,18 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
> >  		u8 poison_caps;
> >  		u8 qos_telemetry_caps;
> >  	} __packed id;
> > -	struct mbox_cmd mbox_cmd = {
> > -		.opcode = CXL_MBOX_OP_IDENTIFY,
> > -		.payload_out = &id,
> > -		.size_in = 0,
> > -	};
> >  	int rc;
> >  
> > -	/* Retrieve initial device memory map */
> > -	rc = cxl_mem_mbox_get(cxlm);
> > -	if (rc)
> > -		return rc;
> > -
> > -	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> > -	cxl_mem_mbox_put(cxlm);
> > -	if (rc)
> > +	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_IDENTIFY, NULL, 0,
> > +				   (u8 *)&id);
> > +	if (rc < 0)
> >  		return rc;
> >  
> > -	/* TODO: Handle retry or reset responses from firmware. */
> > -	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS) {
> > -		dev_err(&cxlm->pdev->dev, "Mailbox command failed (%d)\n",
> > -			mbox_cmd.return_code);
> > +	if (rc < sizeof(id)) {
> > +		dev_err(&cxlm->pdev->dev, "Short identify data\n",
> >  		return -ENXIO;
> >  	}
> >  
> > -	if (mbox_cmd.size_out != sizeof(id))
> > -		return -ENXIO;
> > -
> >  	/*
> >  	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
> >  	 * For now, only the capacity is exported in sysfs
> > 
> > 
> > [snip]
> > 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
