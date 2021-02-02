Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1468230CF57
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 23:50:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3EC29100EB35A;
	Tue,  2 Feb 2021 14:50:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E43B3100EBB72
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 14:50:04 -0800 (PST)
IronPort-SDR: DVKVkoPs0QCMSVvIgJqu+gpWRc+MrM76kvAZwfBxhHx15Itsf5MXPSKWvy5YofYUzb1QSJIL2L
 4g2CLoYc3wJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160112464"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="160112464"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 14:50:04 -0800
IronPort-SDR: EtegBuP+CZTsw6EElKMgS1btKjGjw5XViFBdsBaf35t1H+QRu8YiUxA5MWiNlkXSKxdt+SiD/P
 22BjzP3Qndjw==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="370992203"
Received: from aisallax-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.131.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 14:50:02 -0800
Date: Tue, 2 Feb 2021 14:50:01 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
Message-ID: <20210202225001.qgzwz53b2uhkseto@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-5-ben.widawsky@intel.com>
 <5986abe5-1248-30b2-5f53-fa7013baafad@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5986abe5-1248-30b2-5f53-fa7013baafad@google.com>
Message-ID-Hash: 4OPDZ2OODSHEOKLCKA6PPQULFPRW6AQE
X-Message-ID-Hash: 4OPDZ2OODSHEOKLCKA6PPQULFPRW6AQE
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4OPDZ2OODSHEOKLCKA6PPQULFPRW6AQE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-01-30 15:51:57, David Rientjes wrote:
> On Fri, 29 Jan 2021, Ben Widawsky wrote:
> 

[snip]

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
> 
> Do you need to verify the payload is non-empty per 8.2.8.4?
> 

What do you mean exactly? Emptiness or lack thereof is what determines the size
parameter of the mailbox interface (if we want to input data, we need to write
size, if we got output data, we have to read size bytes out of the payload
registers).

Perhaps I miss the point though, could you elaborate?

[snip]
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
