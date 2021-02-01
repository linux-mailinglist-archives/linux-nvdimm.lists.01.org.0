Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790D430B2EF
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 23:50:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B7DC4100EA924;
	Mon,  1 Feb 2021 14:50:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4FFB7100EA919
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 14:50:55 -0800 (PST)
IronPort-SDR: Z73jpDtuW5dTVdzyfDv8Dj/TCeAfyW1Rwkk077DzW0Xo4y4S678nu390xVbqp/70YAgzdFnHPN
 bmtiVgBtIaSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="159931961"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="159931961"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 14:50:54 -0800
IronPort-SDR: oHhKkHh06bdvRvwNm4jSmHYo4PebBn4mdxQpmKigtdPMjAR5Owzp9NEOOAlwauFaaJNwXsXR65
 iOJnaFfVq0DA==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="371722457"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 14:50:53 -0800
Date: Mon, 1 Feb 2021 14:50:52 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210201225052.vrrvuxrsgmddjzbb@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
 <20210201165352.wi7tzpnd4ymxlms4@intel.com>
 <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
 <20210201215857.ud5cpg7hbxj2j5bx@intel.com>
 <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com>
 <20210201222859.lzw3gvxuqebukvr6@intel.com>
 <20210201223314.qh24uxd7ajdppgfl@intel.com>
 <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com>
Message-ID-Hash: EXUZQNIHWDXIWQK3HH7GTJNLQSPTHU4V
X-Message-ID-Hash: EXUZQNIHWDXIWQK3HH7GTJNLQSPTHU4V
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EXUZQNIHWDXIWQK3HH7GTJNLQSPTHU4V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-01 14:45:00, David Rientjes wrote:
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
> 
> > > > > > > > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > > > > > > > +{
> > > > > > > > > +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > > > > > > > +
> > > > > > > > > +	cxlm->mbox.payload_size =
> > > > > > > > > +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > > > > > > > +
> > > > > > > > > +	/* 8.2.8.4.3 */
> > > > > > > > > +	if (cxlm->mbox.payload_size < 256) {
> > > > > > > > > +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > > > > > > > > +			cxlm->mbox.payload_size);
> > > > > > > > > +		return -ENXIO;
> > > > > > > > > +	}
> > > > > > > > 
> > > > > > > > Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and 
> > > > > > > > return ENXIO if true?
> > > > > > > 
> > > > > > > If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
> > > > > > > driver not allow it?
> > > > > > > 
> > > > > > 
> > > > > > Because the spec disallows it :)
> > > > > 
> > > > > I don't see it being the driver's responsibility to enforce spec correctness
> > > > > though. In certain cases, I need to use the spec, like I have to pick /some/
> > > > > mailbox timeout. For other cases... 
> > > > > 
> > > > > I'm not too familiar with what other similar drivers may or may not do in
> > > > > situations like this. The current 256 limit is mostly a reflection of that being
> > > > > too small to even support advertised mandatory commands. So things can't work in
> > > > > that scenario, but things can work if they have a larger register size (so long
> > > > > as the BAR advertises enough space).
> > > > > 
> > > > 
> > > > I don't think things can work above 1MB, either, though.  Section 
> > > > 8.2.8.4.5 specifies 20 bits to define the payload length, if this is 
> > > > larger than cxlm->mbox.payload_size it would venture into the reserved 
> > > > bits of the command register.
> > > > 
> > > > So is the idea to allow cxl_mem_setup_mailbox() to succeed with a payload 
> > > > size > 1MB and then only check 20 bits for the command register?
> > > 
> > > So it's probably a spec bug, but actually the payload size is 21 bits... I'll
> > > check if that was a mistake.
> > 
> > Well I guess they wanted to be able to specify 1M exactly... Spec should
> > probably say you can't go over 1M
> > 
> 
> I think that's what 8.2.8.4.3 says, no?  And then 8.2.8.4.5 says you 
> can use up to Payload Size.  That's why my recommendation was to enforce 
> this in cxl_mem_setup_mailbox() up front.

Yeah. I asked our spec people to update 8.2.8.4.5 to make it clearer. I'd argue
the intent is how you describe it, but the implementation isn't.

My argument was silly anyway because if you specify greater than 1M as your
payload, you will get EINVAL at the ioctl.

The value of how it works today is the driver will at least bind and allow you
to interact with it.

How strongly do you feel about this?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
