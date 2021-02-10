Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5487D316E44
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 19:16:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 92430100EAB06;
	Wed, 10 Feb 2021 10:16:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 76CD9100EBBCB
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 10:16:13 -0800 (PST)
IronPort-SDR: 2ct6nvhJ2a21vBlqb25JBHzRNZj/R3zBf8xpNhVPkIX9pvr+Z7mLZfMf/tV6BlGiU+L7vp4OIa
 xdayQOPzZl9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161272932"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400";
   d="scan'208";a="161272932"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 10:16:11 -0800
IronPort-SDR: 89YIahzzNcWM4MWq58gZa8q7jRv5w0QeXvYNtv2OQtPYLwWV1jmyuU4V42/1/mV38XgH88VOOr
 gwVqkEpXXGJQ==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400";
   d="scan'208";a="359654996"
Received: from lgrunes-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.135.4])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 10:16:07 -0800
Date: Wed, 10 Feb 2021 10:16:05 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/8] cxl/mem: Find device capabilities
Message-ID: <20210210181605.ecbl3m5ep4rszpqs@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-3-ben.widawsky@intel.com>
 <20210210133252.000047af@Huawei.com>
 <20210210150759.00005684@Huawei.com>
 <20210210165557.7fuqbyr7e7zjoxaa@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210210165557.7fuqbyr7e7zjoxaa@intel.com>
Message-ID-Hash: 4R7ZPBYSHAS6J7KPQ7ZYIZ53Q3BUVT6D
X-Message-ID-Hash: 4R7ZPBYSHAS6J7KPQ7ZYIZ53Q3BUVT6D
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4R7ZPBYSHAS6J7KPQ7ZYIZ53Q3BUVT6D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-10 08:55:57, Ben Widawsky wrote:
> On 21-02-10 15:07:59, Jonathan Cameron wrote:
> > On Wed, 10 Feb 2021 13:32:52 +0000
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > > On Tue, 9 Feb 2021 16:02:53 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > 
> > > > Provide enough functionality to utilize the mailbox of a memory device.
> > > > The mailbox is used to interact with the firmware running on the memory
> > > > device. The flow is proven with one implemented command, "identify".
> > > > Because the class code has already told the driver this is a memory
> > > > device and the identify command is mandatory.
> > > > 
> > > > CXL devices contain an array of capabilities that describe the
> > > > interactions software can have with the device or firmware running on
> > > > the device. A CXL compliant device must implement the device status and
> > > > the mailbox capability. Additionally, a CXL compliant memory device must
> > > > implement the memory device capability. Each of the capabilities can
> > > > [will] provide an offset within the MMIO region for interacting with the
> > > > CXL device.
> > > > 
> > > > The capabilities tell the driver how to find and map the register space
> > > > for CXL Memory Devices. The registers are required to utilize the CXL
> > > > spec defined mailbox interface. The spec outlines two mailboxes, primary
> > > > and secondary. The secondary mailbox is earmarked for system firmware,
> > > > and not handled in this driver.
> > > > 
> > > > Primary mailboxes are capable of generating an interrupt when submitting
> > > > a background command. That implementation is saved for a later time.
> > > > 
> > > > Link: https://www.computeexpresslink.org/download-the-specification
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>  
> > > 
> > > Hi Ben,
> > > 
> > > 
> > > > +/**
> > > > + * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> > > > + * @cxlm: The CXL memory device to communicate with.
> > > > + * @mbox_cmd: Command to send to the memory device.
> > > > + *
> > > > + * Context: Any context. Expects mbox_lock to be held.
> > > > + * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
> > > > + *         Caller should check the return code in @mbox_cmd to make sure it
> > > > + *         succeeded.  
> > > 
> > > cxl_xfer_log() doesn't check mbox_cmd->return_code and for my test it currently
> > > enters an infinite loop as a result.
> 
> I meant to fix that.
> 
> > > 
> > > I haven't checked other paths, but to my mind it is not a good idea to require
> > > two levels of error checking - the example here proves how easy it is to forget
> > > one.
> 
> Demonstrably, you're correct. I think it would be good to have a kernel only
> mbox command that does the error checking though. Let me type something up and
> see how it looks.

Hi Jonathan. What do you think of this? The bit I'm on the fence about is if I
should validate output size too. I like the simplicity as it is, but it requires
every caller to possibly check output size, which is kind of the same problem
you're originally pointing out.

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 55c5f5a6023f..ad7b2077ab28 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -284,7 +284,7 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
 }
 
 /**
- * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
+ * __cxl_mem_mbox_send_cmd() - Execute a mailbox command
  * @cxlm: The CXL memory device to communicate with.
  * @mbox_cmd: Command to send to the memory device.
  *
@@ -296,7 +296,8 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
  * This is a generic form of the CXL mailbox send command, thus the only I/O
  * operations used are cxl_read_mbox_reg(). Memory devices, and perhaps other
  * types of CXL devices may have further information available upon error
- * conditions.
+ * conditions. Driver facilities wishing to send mailbox commands should use the
+ * wrapper command.
  *
  * The CXL spec allows for up to two mailboxes. The intention is for the primary
  * mailbox to be OS controlled and the secondary mailbox to be used by system
@@ -304,8 +305,8 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
  * not need to coordinate with each other. The driver only uses the primary
  * mailbox.
  */
-static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
-				 struct mbox_cmd *mbox_cmd)
+static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
+				   struct mbox_cmd *mbox_cmd)
 {
 	void __iomem *payload = cxlm->mbox_regs + CXLDEV_MBOX_PAYLOAD_OFFSET;
 	u64 cmd_reg, status_reg;
@@ -469,6 +470,54 @@ static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
 	mutex_unlock(&cxlm->mbox_mutex);
 }
 
+/**
+ * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
+ * @cxlm: The CXL memory device to communicate with.
+ * @opcode: Opcode for the mailbox command.
+ * @in: The input payload for the mailbox command.
+ * @in_size: The length of the input payload
+ * @out: Caller allocated buffer for the output.
+ *
+ * Context: Any context. Will acquire and release mbox_mutex.
+ * Return:
+ *  * %>=0	- Number of bytes returned in @out.
+ *  * %-EBUSY	- Couldn't acquire exclusive mailbox access.
+ *  * %-EFAULT	- Hardware error occurred.
+ *  * %-ENXIO	- Command completed, but device reported an error.
+ *
+ * Mailbox commands may execute successfully yet the device itself reported an
+ * error. While this distinction can be useful for commands from userspace, the
+ * kernel will often only care when both are successful.
+ *
+ * See __cxl_mem_mbox_send_cmd()
+ */
+static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode, u8 *in,
+				 size_t in_size, u8 *out)
+{
+	struct mbox_cmd mbox_cmd = {
+		.opcode = opcode,
+		.payload_in = in,
+		.size_in = in_size,
+		.payload_out = out,
+	};
+	int rc;
+
+	rc = cxl_mem_mbox_get(cxlm);
+	if (rc)
+		return rc;
+
+	rc = __cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
+	cxl_mem_mbox_put(cxlm);
+	if (rc)
+		return rc;
+
+	/* TODO: Map return code to proper kernel style errno */
+	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
+		return -ENXIO;
+
+	return mbox_cmd.size_out;
+}
+
 /**
  * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
  * @cxlmd: The CXL memory device to communicate with.
@@ -1380,33 +1429,18 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 		u8 poison_caps;
 		u8 qos_telemetry_caps;
 	} __packed id;
-	struct mbox_cmd mbox_cmd = {
-		.opcode = CXL_MBOX_OP_IDENTIFY,
-		.payload_out = &id,
-		.size_in = 0,
-	};
 	int rc;
 
-	/* Retrieve initial device memory map */
-	rc = cxl_mem_mbox_get(cxlm);
-	if (rc)
-		return rc;
-
-	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
-	cxl_mem_mbox_put(cxlm);
-	if (rc)
+	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_IDENTIFY, NULL, 0,
+				   (u8 *)&id);
+	if (rc < 0)
 		return rc;
 
-	/* TODO: Handle retry or reset responses from firmware. */
-	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS) {
-		dev_err(&cxlm->pdev->dev, "Mailbox command failed (%d)\n",
-			mbox_cmd.return_code);
+	if (rc < sizeof(id)) {
+		dev_err(&cxlm->pdev->dev, "Short identify data\n",
 		return -ENXIO;
 	}
 
-	if (mbox_cmd.size_out != sizeof(id))
-		return -ENXIO;
-
 	/*
 	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
 	 * For now, only the capacity is exported in sysfs


[snip]
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
