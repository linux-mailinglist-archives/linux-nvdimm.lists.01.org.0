Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDCD30F63F
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Feb 2021 16:29:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B28F100EB831;
	Thu,  4 Feb 2021 07:29:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BE253100EBBD6
	for <linux-nvdimm@lists.01.org>; Thu,  4 Feb 2021 07:29:06 -0800 (PST)
IronPort-SDR: MJcEaV+HVAAnLYfqIQ+WSOUvFy2rhwESWfabpYvbu0N0odvtEtT8FMn/WZANhmc26EH2Cry+MT
 Y27/+lEQYAfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181411613"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400";
   d="scan'208";a="181411613"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 07:29:05 -0800
IronPort-SDR: e/5p4pSuQmOb/MbMZ2Wp1tEb+Ne2uaNCe7q0PWUrRotDCKEL57esF7lmORz7DWpIeTm1AgiK/R
 1fiQGYbuvEGA==
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400";
   d="scan'208";a="415207885"
Received: from jguillor-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.14])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 07:29:03 -0800
Date: Thu, 4 Feb 2021 07:29:01 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210204152901.pzjnyr64xlvo6yup@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <20210202181016.GD3708021@infradead.org>
 <20210202182418.3wyxnm6rqeoeclu2@intel.com>
 <20210203171534.GB4104698@infradead.org>
 <20210203172342.fpn5vm4xj2xwh6fq@intel.com>
 <CAPcyv4hvFjs=QqmUYqPipuaLoFiZ-dr6qVhqbDupWuKTw3QDkg@mail.gmail.com>
 <20210204071646.GA122880@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210204071646.GA122880@infradead.org>
Message-ID-Hash: 5ANQ2MQYVN3432W7PHMORHLFE6R5X3W3
X-Message-ID-Hash: 5ANQ2MQYVN3432W7PHMORHLFE6R5X3W3
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5ANQ2MQYVN3432W7PHMORHLFE6R5X3W3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-04 07:16:46, Christoph Hellwig wrote:
> On Wed, Feb 03, 2021 at 01:23:31PM -0800, Dan Williams wrote:
> > > I'd prefer to keep the helpers for now as I do find them helpful, and so far
> > > nobody else who has touched the code has complained. If you feel strongly, I
> > > will change it.
> > 
> > After seeing the options, I think I'd prefer to not have to worry what
> > extra magic is happening with cxl_read_mbox_reg32()
> > 
> > cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > 
> > readl(cxlm->mbox_regs + CXLDEV_MB_CAPS_OFFSET);
> > 
> > The latter is both shorter and more idiomatic.
> 
> Same here.  That being said I know some driver maintainers like
> wrappers, my real main irk was the macro magic to generate them.

I think the wrapper is often used as a means of trying to have cross OS
compatibility to some degree. Just to be clear, that was *not* the purpose here.

Stating I disagree for posterity, I'll begin reworking this code and it will be
changed for v2.

Thanks.
Ben
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
