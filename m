Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 250C330E0DB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Feb 2021 18:23:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 72726100EAAE5;
	Wed,  3 Feb 2021 09:23:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 40965100EAAE1
	for <linux-nvdimm@lists.01.org>; Wed,  3 Feb 2021 09:23:47 -0800 (PST)
IronPort-SDR: ornK51jVTAV9Nsz9zDTo6cWJZVMF2MVSqHLvoB/0xXq9V7PICZI3JUZnw6O5yiHxRVJq5qQuXy
 ZZnj3mWyZUnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160247006"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400";
   d="scan'208";a="160247006"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 09:23:45 -0800
IronPort-SDR: eoyrVjsX4rqNoiZy6o86DFQrNPEjyMd5g6aueSivQ6uFYh8+HGno9GbS5JUUfd+hCKDlQz19au
 3qJFF6Bm/8pw==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400";
   d="scan'208";a="371558214"
Received: from lrenaud-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.131.246])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 09:23:43 -0800
Date: Wed, 3 Feb 2021 09:23:42 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210203172342.fpn5vm4xj2xwh6fq@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <20210202181016.GD3708021@infradead.org>
 <20210202182418.3wyxnm6rqeoeclu2@intel.com>
 <20210203171534.GB4104698@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210203171534.GB4104698@infradead.org>
Message-ID-Hash: QTX7HF4R43BVKVQE7FX4ODDG622B7VIL
X-Message-ID-Hash: QTX7HF4R43BVKVQE7FX4ODDG622B7VIL
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QTX7HF4R43BVKVQE7FX4ODDG622B7VIL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-03 17:15:34, Christoph Hellwig wrote:
> On Tue, Feb 02, 2021 at 10:24:18AM -0800, Ben Widawsky wrote:
> > > > +	/* Cap 4000h - CXL_CAP_CAP_ID_MEMDEV */
> > > > +	struct {
> > > > +		void __iomem *regs;
> > > > +	} mem;
> > > 
> > > This style looks massively obsfucated.  For one the comments look like
> > > absolute gibberish, but also what is the point of all these anonymous
> > > structures?
> > 
> > They're not anonymous, and their names are for the below register functions. The
> > comments are connected spec reference 'Cap XXXXh' to definitions in cxl.h. I can
> > articulate that if it helps.
> 
> But why no simply a
> 
> 	void __iomem *mem_regs;
> 
> field vs the extra struct?
> 
> > The register space for CXL devices is a bit weird since it's all subdivided
> > under 1 BAR for now. To clearly distinguish over the different subregions, these
> > helpers exist. It's really easy to mess this up as the developer and I actually
> > would disagree that it makes debugging quite a bit easier. It also gets more
> > convoluted when you add the other 2 BARs which also each have their own
> > subregions.
> > 
> > For example. if my mailbox function does:
> > cxl_read_status_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > 
> > instead of:
> > cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > 
> > It's easier to spot than:
> > readl(cxlm->regs + cxlm->status_offset + CXLDEV_MB_CAPS_OFFSET)
> 
> Well, what I think would be the most obvious is:
> 
> readl(cxlm->status_regs + CXLDEV_MB_CAPS_OFFSET);
> 

Right, so you wrote the buggy version. Should be.
readl(cxlm->mbox_regs + CXLDEV_MB_CAPS_OFFSET);

Admittedly, "MB" for mailbox isn't super obvious. I think you've convinced me to
rename these register definitions
s/MB/MBOX.

I'd prefer to keep the helpers for now as I do find them helpful, and so far
nobody else who has touched the code has complained. If you feel strongly, I
will change it.

> > > > +	/* 8.2.8.4.3 */
> > > 
> > > ????
> > > 
> > 
> > I had been trying to be consistent with 'CXL2.0 - ' in front of all spec
> > reference. I obviously missed this one.
> 
> FYI, I generally find section names much easier to find than section
> numbers.  Especially as the numbers change very frequently, some times
> even for very minor updates to the spec.  E.g. in NVMe the numbers might
> even change from NVMe 1.X to NVMe 1.Xa because an errata had to add
> a clarification as its own section.

Why not both?

I ran into this in fact going from version 0.7 to 1.0 of the spec. I did call
out the spec version to address this, but you're right. Section names can change
too in theory.

/*
 * CXL 2.0 8.2.8.4.3
 * Mailbox Capabilities Register
 */

Too much?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
