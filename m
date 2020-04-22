Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3721B4B5A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Apr 2020 19:10:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E844B10106322;
	Wed, 22 Apr 2020 10:10:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 645C1100DCB94
	for <linux-nvdimm@lists.01.org>; Wed, 22 Apr 2020 10:10:21 -0700 (PDT)
IronPort-SDR: djjRaw3VAJqlK8JSsDTA0ZT8mmDgV2jypt1nxmw4M1Dyv4qxVe7JzmazPxpFYjAz5cLHHC0oO1
 Wl/FijFic6RA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 10:10:23 -0700
IronPort-SDR: AF8/0AWTFcOrp900P7OZzVez2XyTM/6lT4LorikQdWrttxAAwM+/XQOBEsU9XUdvAPa/Wsvk/u
 Uf52+csFhLeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400";
   d="scan'208";a="292010059"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2020 10:10:23 -0700
Date: Wed, 22 Apr 2020 10:10:23 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] libnvdimm: Replace guid_copy() with import_guid()
 where it makes sense
Message-ID: <20200422171023.GJ3372712@iweiny-DESK2.sc.intel.com>
References: <20200422130539.45636-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200422130539.45636-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 4HMVTAADRMQNAVV5STTVBHASQUNHHTTO
X-Message-ID-Hash: 4HMVTAADRMQNAVV5STTVBHASQUNHHTTO
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4HMVTAADRMQNAVV5STTVBHASQUNHHTTO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 22, 2020 at 04:05:39PM +0300, Andy Shevchenko wrote:
> There is a specific API to treat raw data as GUID, i.e. import_guid().
> Use it instead of guid_copy() with explicit casting.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index fa4500f9cfd13..7c138a4edc03e 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2293,7 +2293,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
>  	nd_set = devm_kzalloc(dev, sizeof(*nd_set), GFP_KERNEL);
>  	if (!nd_set)
>  		return -ENOMEM;
> -	guid_copy(&nd_set->type_guid, (guid_t *) spa->range_guid);
> +	import_guid(&nd_set->type_guid, spa->range_guid);
>  
>  	info = devm_kzalloc(dev, sizeof_nfit_set_info(nr), GFP_KERNEL);
>  	if (!info)
> -- 
> 2.26.1
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
