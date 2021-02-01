Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488D930ACE6
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 17:46:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C383100EB823;
	Mon,  1 Feb 2021 08:46:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 36278100EB822
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 08:46:29 -0800 (PST)
IronPort-SDR: iFPrF5iF6eHdpNpUxEgB0Ak56ePQqrQ3d76YyF/9EorsYwiKO+dEgdO/UTUp+R8zbkfq2hGL8/
 WVoP0Y8XP5XA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180791706"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400";
   d="scan'208";a="180791706"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:46:28 -0800
IronPort-SDR: M3GO0gtPpl4qrl6C556Eviq48tEr0nI9xeXenrjI9aOzDLzPk5EbXy2fLA3f1ny/gNUGsp94NG
 7a+Tjq+HYd3Q==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="577880723"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:46:26 -0800
Date: Mon, 1 Feb 2021 08:46:24 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 02/14] cxl/mem: Map memory device registers
Message-ID: <20210201164624.bhfufqfalogfazzi@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-3-ben.widawsky@intel.com>
 <792edaa-a11b-41c6-c2a1-2c72a3e4e815@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <792edaa-a11b-41c6-c2a1-2c72a3e4e815@google.com>
Message-ID-Hash: OZ7SKCBIDVLQUHZOKI5H3CB2EA4WKNXN
X-Message-ID-Hash: OZ7SKCBIDVLQUHZOKI5H3CB2EA4WKNXN
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OZ7SKCBIDVLQUHZOKI5H3CB2EA4WKNXN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-01-30 15:51:42, David Rientjes wrote:
> On Fri, 29 Jan 2021, Ben Widawsky wrote:
> 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > new file mode 100644
> > index 000000000000..d81d0ba4617c
> > --- /dev/null
> > +++ b/drivers/cxl/cxl.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright(c) 2020 Intel Corporation. */
> > +
> > +#ifndef __CXL_H__
> > +#define __CXL_H__
> > +
> > +/**
> > + * struct cxl_mem - A CXL memory device
> > + * @pdev: The PCI device associated with this CXL device.
> > + * @regs: IO mappings to the device's MMIO
> > + */
> > +struct cxl_mem {
> > +	struct pci_dev *pdev;
> > +	void __iomem *regs;
> > +};
> > +
> > +#endif
> 
> Stupid question: can there be more than one CXL.mem capable logical 
> device?  I only ask to determine if an ordinal is needed to enumerate 
> multiple LDs.

Not a stupid question at all. I admit, I haven't spent much time thinking about
MLDs. I don't have a solid answer to your question. As I understand it, the
devices in the virtual hierarchy will appear as individual CXL type 3 device
components (2.4 in the spec) and transparent to software. A few times I've
attempted to think about MLDs, get confused, and go do something else. The only
MLD specificity I know of is the MLD DVSEC (8.1.10), which seems not incredibly
interesting to me at present (basically, only supporting hot reset).

> 
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index f4ee9a507ac9..a869c8dc24cc 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -4,6 +4,58 @@
> >  #include <linux/pci.h>
> >  #include <linux/io.h>
> >  #include "pci.h"
> > +#include "cxl.h"
> > +
> > +/**
> > + * cxl_mem_create() - Create a new &struct cxl_mem.
> > + * @pdev: The pci device associated with the new &struct cxl_mem.
> > + * @reg_lo: Lower 32b of the register locator
> > + * @reg_hi: Upper 32b of the register locator.
> > + *
> > + * Return: The new &struct cxl_mem on success, NULL on failure.
> > + *
> > + * Map the BAR for a CXL memory device. This BAR has the memory device's
> > + * registers for the device as specified in CXL specification.
> > + */
> > +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> > +				      u32 reg_hi)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct cxl_mem *cxlm;
> > +	void __iomem *regs;
> > +	u64 offset;
> > +	u8 bar;
> > +	int rc;
> > +
> > +	offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> > +	bar = (reg_lo >> CXL_REGLOC_BIR_SHIFT) & CXL_REGLOC_BIR_MASK;
> > +
> > +	/* Basic sanity check that BAR is big enough */
> > +	if (pci_resource_len(pdev, bar) < offset) {
> > +		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> > +			&pdev->resource[bar], (unsigned long long)offset);
> > +		return NULL;
> > +	}
> > +
> > +	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> > +	if (rc != 0) {
> > +		dev_err(dev, "failed to map registers\n");
> > +		return NULL;
> > +	}
> > +
> > +	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> > +	if (!cxlm) {
> > +		dev_err(dev, "No memory available\n");
> > +		return NULL;
> > +	}
> > +
> > +	regs = pcim_iomap_table(pdev)[bar];
> > +	cxlm->pdev = pdev;
> > +	cxlm->regs = regs + offset;
> > +
> > +	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> > +	return cxlm;
> > +}
> >  
> >  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >  {
> > @@ -32,15 +84,42 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	int regloc;
> > +	struct cxl_mem *cxlm;
> > +	int rc, regloc, i;
> > +
> > +	rc = pcim_enable_device(pdev);
> > +	if (rc)
> > +		return rc;
> >  
> >  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
> >  	if (!regloc) {
> >  		dev_err(dev, "register location dvsec not found\n");
> >  		return -ENXIO;
> >  	}
> > +	regloc += 0xc; /* Skip DVSEC + reserved fields */
> 
> Assuming the DVSEC revision number is always 0x0 or there's no value in 
> storing this in struct cxl_mem for the future.

So this logic actually came from Dan originally, so don't take this necessarily
as the authoritative answer.

At some point revision id will need to be considered. However, the consortium
seems to be going to great lengths (kudos) to make all modifications backward
compatible. As such, we can consider this the driver for rev0 (the only such rev
in existence today), and when a new rev comes along, figure out how to best
handle it. However, the expectation is that this code will still work for revN.

> 
> Acked-by: David Rientjes <rientjes@google.com>

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
