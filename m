Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A035A39C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 18:41:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3785A100EBBC0;
	Fri,  9 Apr 2021 09:41:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0CEA7100EC1D4
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 09:41:46 -0700 (PDT)
IronPort-SDR: cfY/1qEpBV6op7AJ3ABn1Fbz7wWw2LJyEcHhw4aohKHbU5xNOz77p3BwyhV092xBozS6lRI/0t
 +JlGXUzkt+QQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="279074063"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400";
   d="scan'208";a="279074063"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 09:41:46 -0700
IronPort-SDR: ln9tRBqUAzx6WVFVR2aPszLeA8Rhu1kRmICVOKiGFRXQ7IH47CsInbY28hob42C65D310519oS
 gpLb6l0pGjtg==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400";
   d="scan'208";a="416332651"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 09:41:46 -0700
Date: Fri, 9 Apr 2021 09:41:45 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: wangyingjie55@126.com
Subject: Re: [PATCH v1] libnvdimm, dax: Fix a missing check in nd_dax_probe()
Message-ID: <20210409164145.GQ3014244@iweiny-DESK2.sc.intel.com>
References: <1617933506-13684-1-git-send-email-wangyingjie55@126.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1617933506-13684-1-git-send-email-wangyingjie55@126.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: QJ446WHWIMRSWH3HDFLESM66FIKMX6MB
X-Message-ID-Hash: QJ446WHWIMRSWH3HDFLESM66FIKMX6MB
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QJ446WHWIMRSWH3HDFLESM66FIKMX6MB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 08, 2021 at 06:58:26PM -0700, wangyingjie55@126.com wrote:
> From: Yingjie Wang <wangyingjie55@126.com>
> 
> In nd_dax_probe(), 'nd_dax' is allocated by nd_dax_alloc().
> nd_dax_alloc() may fail and return NULL, so we should better check

Avoid the use of 'we'.

> it's return value to avoid a NULL pointer dereference
> a bit later in the code.

How about:

"nd_dax_alloc() may fail and return NULL.  Check for NULL before attempting to
use nd_dax to avoid a NULL pointer dereference."

> 
> Fixes: c5ed9268643c ("libnvdimm, dax: autodetect support")
> Signed-off-by: Yingjie Wang <wangyingjie55@126.com>

The code looks good though.

Ira

> ---
>  drivers/nvdimm/dax_devs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
> index 99965077bac4..b1426ac03f01 100644
> --- a/drivers/nvdimm/dax_devs.c
> +++ b/drivers/nvdimm/dax_devs.c
> @@ -106,6 +106,8 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
>  
>  	nvdimm_bus_lock(&ndns->dev);
>  	nd_dax = nd_dax_alloc(nd_region);
> +	if (!nd_dax)
> +		return -ENOMEM;
>  	nd_pfn = &nd_dax->nd_pfn;
>  	dax_dev = nd_pfn_devinit(nd_pfn, ndns);
>  	nvdimm_bus_unlock(&ndns->dev);
> -- 
> 2.7.4
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
