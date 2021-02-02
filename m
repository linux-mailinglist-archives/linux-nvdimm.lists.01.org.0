Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 582FD30C9D5
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 19:32:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7ED90100EA2C7;
	Tue,  2 Feb 2021 10:32:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8640A100EA2C6
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 10:32:02 -0800 (PST)
IronPort-SDR: C60ye27IOu0STq2+6R93sY7zG6zX1DewFE+7UhGHMC0nM+fkYvrk735tHtg1Em/TpWmsr4Km48
 aLXgRBU7ESuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="178346691"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="178346691"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:31:59 -0800
IronPort-SDR: Lb8WyJ3EBTlCkfAzdn8o0ZDcIwM2VGbNL4/5mCrYT0bo92LlqD2tsPvRKRk2ya41RqW1n2nOyQ
 Giaz8SfgDgSA==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="582135589"
Received: from joship1x-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.131.202])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:31:53 -0800
Date: Tue, 2 Feb 2021 10:31:51 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/14] cxl/mem: Map memory device registers
Message-ID: <20210202183151.7kwruvip7nshqsc4@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-3-ben.widawsky@intel.com>
 <20210202180441.GC3708021@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210202180441.GC3708021@infradead.org>
Message-ID-Hash: 7R7UXP4ZDAQTZW7V33QQBH7NLKRV2HQS
X-Message-ID-Hash: 7R7UXP4ZDAQTZW7V33QQBH7NLKRV2HQS
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7R7UXP4ZDAQTZW7V33QQBH7NLKRV2HQS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-02 18:04:41, Christoph Hellwig wrote:
> Any reason not to merge a bunch of patches?  Both this one and
> the previous one are rather useless on their own, making review
> harder than necessary.
> 

As this is an initial driver, there's obviously no functional/regression testing
value in separating the patches.

This was the way we brought up the driver and how we verified functionality
incrementally. I see value in both capturing that in the history, as well as
making review a bit easier (which apparently failed for you).

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
> 
> A lot of text with almost no value over just reading the function.
> What's that fetish with kerneldoc comments for trivial static functions?
> 
> > +		reg_type =
> > +			(reg_lo >> CXL_REGLOC_RBI_SHIFT) & CXL_REGLOC_RBI_MASK;
> 
> OTOH this screams for a helper that would make the code a lot more
> self documenting.
> 

I agree, I'll change this.

> > +		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> > +			rc = 0;
> > +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > +			if (!cxlm)
> > +				rc = -ENODEV;
> > +			break;
> 
> And given that we're going to grow more types eventually, why not start
> out with a switch here?  Also why return the structure when nothing
> uses it?

 We've (Intel) already started working on the libnvdimm integration which does
 change this around a bit. In order to go with what's best tested though, I've
 chosen to use this as is for merge. Many different people not just in Intel
 have tested these codepaths. The resulting code moves the check on register
 type out of this function entirely.

 If you'd like me to make it a switch, I can, but it's going to be extracted
 later anyway.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
