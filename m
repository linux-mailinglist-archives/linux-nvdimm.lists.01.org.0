Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC4031D3CE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 02:36:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8A5C9100F225C;
	Tue, 16 Feb 2021 17:36:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9BF3A100F2256
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 17:36:17 -0800 (PST)
IronPort-SDR: qsgNurlAKW5N+66UpbO15wJ6111Z/lgXa0blCQx77marscTfHuOMQURN+Qv+cwj65chWDPfZAp
 PKLwBdmFinMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="247039945"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400";
   d="scan'208";a="247039945"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 10:22:33 -0800
IronPort-SDR: 4edsNo68YZJHh5PbP7eS+pmfhYoJhfnup3fnRT5m214M7FcmcRemf2FXr8iSGFMYVKd2nnJfKt
 v5TeoRfQeaWA==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400";
   d="scan'208";a="399610160"
Received: from dlbingha-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.134.31])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 10:22:33 -0800
Date: Tue, 16 Feb 2021 10:22:32 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 4/9] cxl/mem: Add basic IOCTL interface
Message-ID: <20210216182232.mmo5pwchongpmrau@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
 <20210216014538.268106-5-ben.widawsky@intel.com>
 <YCwK9SblYCh/1lZS@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YCwK9SblYCh/1lZS@zeniv-ca.linux.org.uk>
Message-ID-Hash: VHRCJG5CWEXHLTUWAFL2VQT7CC43XIYG
X-Message-ID-Hash: VHRCJG5CWEXHLTUWAFL2VQT7CC43XIYG
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VHRCJG5CWEXHLTUWAFL2VQT7CC43XIYG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-16 18:12:05, Al Viro wrote:
> On Mon, Feb 15, 2021 at 05:45:33PM -0800, Ben Widawsky wrote:
> > +	if (cmd->info.size_in) {
> > +		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
> > +		if (!mbox_cmd.payload_in) {
> > +			rc = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		if (copy_from_user(mbox_cmd.payload_in,
> > +				   u64_to_user_ptr(in_payload),
> > +				   cmd->info.size_in)) {
> > +			rc = -EFAULT;
> > +			goto out;
> > +		}
> 
> Umm...  Do you need to open-code vmemdup_user()?  The only difference is
> GFP_KERNEL allocation instead of GFP_USER one, and the latter is arguably
> saner here...  Zeroing is definitely pointless - you either overwrite
> the entire buffer with copy_from_user(), or you fail and free the damn
> thing.

mea culpa. In fact it was previously memdup_user and Dan suggested I switch to
vmemdup_user.
https://lore.kernel.org/linux-cxl/CAPcyv4j+ixVgEo5q2OhV4kdkBZbnohZj3KDovReQJjPBsREugw@mail.gmail.com/


Will fix for the next version.

Thanks.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
