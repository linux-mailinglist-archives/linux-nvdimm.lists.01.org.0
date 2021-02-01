Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2FE30AE65
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 18:50:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A49A3100EB84E;
	Mon,  1 Feb 2021 09:50:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1E563100EB84C
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 09:50:45 -0800 (PST)
IronPort-SDR: 2J0sW0o1awQmHZvpH0eVX9yg3eQOjAxrTbMHLl1l+UOYfBNuN1MVvxtMyFxSYFzpCYDmqpgvz0
 Bh18d0FEYfQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="199625054"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="199625054"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:50:43 -0800
IronPort-SDR: vwkcuvc/K6/0HYC/dswoUfGzMUtTJ5RCPPD/dQMvTDarAcRp8pDLdNzcYlXlojKNViGybtDGXQ
 /w90aWaQLK/g==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="371637150"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:50:42 -0800
Date: Mon, 1 Feb 2021 09:50:41 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210201175041.qs56jk5tdbgn2zia@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <20210201174136.GF197521@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201174136.GF197521@fedora>
Message-ID-Hash: MIIL4G7AYRSHEYPP3CZIEPSTJ5SFJ2YL
X-Message-ID-Hash: MIIL4G7AYRSHEYPP3CZIEPSTJ5SFJ2YL
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MIIL4G7AYRSHEYPP3CZIEPSTJ5SFJ2YL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-01 12:41:36, Konrad Rzeszutek Wilk wrote:
> > +static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> > +{
> > +	struct device *dev = &cxlm->pdev->dev;
> > +	int cap, cap_count;
> > +	u64 cap_array;
> > +
> > +	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
> > +	if (CXL_GET_FIELD(cap_array, CXLDEV_CAP_ARRAY_ID) != CXLDEV_CAP_ARRAY_CAP_ID)
> > +		return -ENODEV;
> > +
> > +	cap_count = CXL_GET_FIELD(cap_array, CXLDEV_CAP_ARRAY_COUNT);
> > +
> > +	for (cap = 1; cap <= cap_count; cap++) {
> > +		void __iomem *register_block;
> > +		u32 offset;
> > +		u16 cap_id;
> > +
> > +		cap_id = readl(cxlm->regs + cap * 0x10) & 0xffff;
> > +		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
> > +		register_block = cxlm->regs + offset;
> > +
> > +		switch (cap_id) {
> > +		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
> > +			dev_dbg(dev, "found Status capability (0x%x)\n",
> > +				offset);
> 
> That 80 character limit is no longer a requirement. Can you just make
> this one line? And perhaps change 'found' to 'Found' ?
> 

Funny that.
https://lore.kernel.org/linux-cxl/20201111073449.GA16235@infradead.org/

> > +			cxlm->status.regs = register_block;
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
> > +			dev_dbg(dev, "found Mailbox capability (0x%x)\n",
> > +				offset);
> > +			cxlm->mbox.regs = register_block;
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
> > +			dev_dbg(dev,
> > +				"found Secondary Mailbox capability (0x%x)\n",
> > +				offset);
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_MEMDEV:
> > +			dev_dbg(dev, "found Memory Device capability (0x%x)\n",
> > +				offset);
> > +			cxlm->mem.regs = register_block;
> > +			break;
> > +		default:
> > +			dev_warn(dev, "Unknown cap ID: %d (0x%x)\n", cap_id,
> > +				 offset);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!cxlm->status.regs || !cxlm->mbox.regs || !cxlm->mem.regs) {
> > +		dev_err(dev, "registers not found: %s%s%s\n",
> > +			!cxlm->status.regs ? "status " : "",
> > +			!cxlm->mbox.regs ? "mbox " : "",
> > +			!cxlm->mem.regs ? "mem" : "");
> > +		return -ENXIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > +{
> > +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > +
> > +	cxlm->mbox.payload_size =
> > +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > +
> 
> I think the static analyzers are not going to be happy that you are not
> checking the value of `cap` before using it.
> 
> Perhaps you should check that first before doing the manipulations?
> 

I'm not following the request. CXL_GET_FIELD is just doing the shift and mask on
cap.

Can you explain what you're hoping to see?

> > +	/* 8.2.8.4.3 */
> > +	if (cxlm->mbox.payload_size < 256) {
> 
> #define for 256?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
