Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119C530C9D7
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 19:33:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C1970100EA2C9;
	Tue,  2 Feb 2021 10:33:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1F2E8100EAB46
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 10:33:29 -0800 (PST)
IronPort-SDR: 8SRGcIiFHivwT46E564xIroEZ26wDop2l9YhVpQlXMoiw1XmhPoD0vQ/67g8OAHOr0VPQVJvDw
 b+xscdWDD5Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="242421455"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="242421455"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:33:28 -0800
IronPort-SDR: o0BhQQsQFexfvQyPOkPHDvxmcu9hxi3ywGSD4mrPrneLs4gP1togqGK+AONy7stmmIWpDROh81
 OpG9MSEPKy+Q==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="582136028"
Received: from joship1x-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.131.202])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:33:26 -0800
Date: Tue, 2 Feb 2021 10:33:25 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 06/14] cxl/mem: Add basic IOCTL interface
Message-ID: <20210202183325.ls7o54zza4obw6df@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-7-ben.widawsky@intel.com>
 <20210202181505.GF3708021@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210202181505.GF3708021@infradead.org>
Message-ID-Hash: KCPDQKF66CVJZBBS5J62Z627QMF2QGC5
X-Message-ID-Hash: KCPDQKF66CVJZBBS5J62Z627QMF2QGC5
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KCPDQKF66CVJZBBS5J62Z627QMF2QGC5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-02 18:15:05, Christoph Hellwig wrote:
> > +#if defined(__cplusplus)
> > +extern "C" {
> > +#endif
> 
> This has no business in a kernel header.

This was copypasta from DRM headers (which as you're probably aware wasn't
always part of the kernel)... It's my mistake and I will get rid of it.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
