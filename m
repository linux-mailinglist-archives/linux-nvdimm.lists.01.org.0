Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6EC30B33F
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 00:17:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B65BD100EA92C;
	Mon,  1 Feb 2021 15:17:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 84125100EA91D
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 15:17:21 -0800 (PST)
IronPort-SDR: jOlaWQ70nPhT+zX0dCbRao4Pa7Uix12yEKWKu3c1clIcMrQZIgCs/vPNnzVeuo+VPtbHmxVv16
 MMWiyAxpxUfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="168447766"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="168447766"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 15:17:20 -0800
IronPort-SDR: 8bdJnMFA0kHmvh7DoPbPCnHbnphnf3MPu4bPVWxPwJfsCqN+WEedY9p8s+2FeZLVcRrs3sUus2
 AQqkT0yDaSbg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="575281971"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 15:17:20 -0800
Date: Mon, 1 Feb 2021 15:17:18 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210201231718.2hwaqgn2f7kc7usw@intel.com>
References: <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
 <20210201165352.wi7tzpnd4ymxlms4@intel.com>
 <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
 <20210201215857.ud5cpg7hbxj2j5bx@intel.com>
 <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com>
 <20210201222859.lzw3gvxuqebukvr6@intel.com>
 <20210201223314.qh24uxd7ajdppgfl@intel.com>
 <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com>
 <20210201225052.vrrvuxrsgmddjzbb@intel.com>
 <79b98f60-151b-6c80-65c3-91a37699d121@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79b98f60-151b-6c80-65c3-91a37699d121@google.com>
Message-ID-Hash: VSIQDPSO4YATIZ57K7DVSMNSMCGNEHND
X-Message-ID-Hash: VSIQDPSO4YATIZ57K7DVSMNSMCGNEHND
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VSIQDPSO4YATIZ57K7DVSMNSMCGNEHND/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-01 15:09:45, David Rientjes wrote:
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
> 
> > > I think that's what 8.2.8.4.3 says, no?  And then 8.2.8.4.5 says you 
> > > can use up to Payload Size.  That's why my recommendation was to enforce 
> > > this in cxl_mem_setup_mailbox() up front.
> > 
> > Yeah. I asked our spec people to update 8.2.8.4.5 to make it clearer. I'd argue
> > the intent is how you describe it, but the implementation isn't.
> > 
> > My argument was silly anyway because if you specify greater than 1M as your
> > payload, you will get EINVAL at the ioctl.
> > 
> > The value of how it works today is the driver will at least bind and allow you
> > to interact with it.
> > 
> > How strongly do you feel about this?
> > 
> 
> I haven't seen the update to 8.2.8.4.5 to know yet :)
> 
> You make a good point of at least being able to interact with the driver.  
> I think you could argue that if the driver binds, then the payload size is 
> accepted, in which case it would be strange to get an EINVAL when using 
> the ioctl with anything >1MB.
> 
> Concern was that if we mask off the reserved bits from the command 
> register that we could be masking part of the payload size that is being 
> passed if the accepted max is >1MB.  Idea was to avoid any possibility of 
> this inconsistency.  If this is being checked for ioctl, seems like it's 
> checking reserved bits.
> 
> But maybe I should just wait for the spec update.

Well, I wouldn't hold your breath (it would be an errata in this case anyway).
My preference would be to just allow allow mailbox payload size to be 2^31 and
not deal with this.

My question was how strongly do you feel it's an error that should prevent
binding.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
