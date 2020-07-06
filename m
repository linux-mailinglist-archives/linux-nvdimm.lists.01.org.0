Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8681215B21
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 Jul 2020 17:48:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 247F411068196;
	Mon,  6 Jul 2020 08:48:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9E75711068195
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 08:48:44 -0700 (PDT)
IronPort-SDR: QZ7PDkSxIuiBk45xynn1MCFnQ7OkZF4sx2BAhmGgyOrd7S54xADHF0P6VlVS6NNTIkusz3zsZH
 QBbGz1ueVV2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="165501169"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800";
   d="scan'208";a="165501169"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 08:48:43 -0700
IronPort-SDR: mWtp9jT1oxvVNrM8s4daFQ6nnPj+gYN2ssBS7Syix2KbmUM20xaxbsrT/kOeHfi4jicS3LFxaE
 clCawcSTm4Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800";
   d="scan'208";a="323244256"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2020 08:48:42 -0700
Date: Mon, 6 Jul 2020 08:48:42 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 13/17] Documentation/driver-api: nvdimm: drop doubled word
Message-ID: <20200706154842.GC1123188@iweiny-DESK2.sc.intel.com>
References: <20200704034502.17199-1-rdunlap@infradead.org>
 <20200704034502.17199-14-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200704034502.17199-14-rdunlap@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: S3BCV6G4VX7XBSWB5GSVV7ISWO3BJSFR
X-Message-ID-Hash: S3BCV6G4VX7XBSWB5GSVV7ISWO3BJSFR
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S3BCV6G4VX7XBSWB5GSVV7ISWO3BJSFR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 03, 2020 at 08:44:58PM -0700, Randy Dunlap wrote:
> Drop the doubled word "to".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Acked-by: Ira Weiny <ira.weiny@intel.com>

> Cc: linux-nvdimm@lists.01.org
> ---
>  Documentation/driver-api/nvdimm/nvdimm.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/driver-api/nvdimm/nvdimm.rst
> +++ linux-next-20200701/Documentation/driver-api/nvdimm/nvdimm.rst
> @@ -73,7 +73,7 @@ DAX:
>    process address space.
>  
>  DSM:
> -  Device Specific Method: ACPI method to to control specific
> +  Device Specific Method: ACPI method to control specific
>    device - in this case the firmware.
>  
>  DCR:
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
