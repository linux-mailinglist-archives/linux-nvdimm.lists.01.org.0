Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC630B3E5
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 01:11:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84E2A100EA922;
	Mon,  1 Feb 2021 16:11:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 16CB6100EB33F
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 16:11:27 -0800 (PST)
IronPort-SDR: 7oDYGtLlC35m+aoK0TuxsN+YVCP+pZiLoNtGktdF93D5mNNzAZpYd8jayJ/I+Hmdppf9nD+jg+
 MIc+SfbAIBLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="159939746"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="159939746"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:11:26 -0800
IronPort-SDR: VzCZkMjvd6oUv7MNieUe2e7I+dES0FyqOvVWnfelSzqiIeNsGRdJQJu2QgfUS1x1onWe/SB/dx
 QzU9THSVHXcg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="405945596"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:11:25 -0800
Date: Mon, 1 Feb 2021 16:11:20 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210202001120.vr6mos7ylnbqytxh@intel.com>
References: <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
 <20210201215857.ud5cpg7hbxj2j5bx@intel.com>
 <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com>
 <20210201222859.lzw3gvxuqebukvr6@intel.com>
 <20210201223314.qh24uxd7ajdppgfl@intel.com>
 <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com>
 <20210201225052.vrrvuxrsgmddjzbb@intel.com>
 <79b98f60-151b-6c80-65c3-91a37699d121@google.com>
 <20210201231718.2hwaqgn2f7kc7usw@intel.com>
 <a789317e-2ac2-10a1-dedd-1851972e3d6b@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a789317e-2ac2-10a1-dedd-1851972e3d6b@google.com>
Message-ID-Hash: GNR5E3V2XBF5V3VF6XKLWWWIHO4MUN4B
X-Message-ID-Hash: GNR5E3V2XBF5V3VF6XKLWWWIHO4MUN4B
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GNR5E3V2XBF5V3VF6XKLWWWIHO4MUN4B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-01 15:58:09, David Rientjes wrote:
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
> 
> > > I haven't seen the update to 8.2.8.4.5 to know yet :)
> > > 
> > > You make a good point of at least being able to interact with the driver.  
> > > I think you could argue that if the driver binds, then the payload size is 
> > > accepted, in which case it would be strange to get an EINVAL when using 
> > > the ioctl with anything >1MB.
> > > 
> > > Concern was that if we mask off the reserved bits from the command 
> > > register that we could be masking part of the payload size that is being 
> > > passed if the accepted max is >1MB.  Idea was to avoid any possibility of 
> > > this inconsistency.  If this is being checked for ioctl, seems like it's 
> > > checking reserved bits.
> > > 
> > > But maybe I should just wait for the spec update.
> > 
> > Well, I wouldn't hold your breath (it would be an errata in this case anyway).
> > My preference would be to just allow allow mailbox payload size to be 2^31 and
> > not deal with this.
> > 
> > My question was how strongly do you feel it's an error that should prevent
> > binding.
> > 
> 
> I don't have an objection to binding, but doesn't this require that the 
> check in cxl_validate_cmd_from_user() guarantees send_cmd->size_in cannot 
> be greater than 1MB?

You're correct. I'd need to add:
cxlm->mbox.payload_size =
    min_t(size_t, 1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE), 1<<20)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
