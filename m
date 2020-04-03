Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 133D819CF15
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 06:24:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D8E2810FC4FEF;
	Thu,  2 Apr 2020 21:25:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2EA5E10112D5A
	for <linux-nvdimm@lists.01.org>; Thu,  2 Apr 2020 21:25:42 -0700 (PDT)
IronPort-SDR: 6/okhJ6jaGNqb7QQmh0hECIQ5FxKRCFZU0qlcHsTwHjotv/XnisprC5gITpWwFVsF7+kyZcwic
 WbPQo+4AGGyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 21:24:52 -0700
IronPort-SDR: AGYrPuq1yRzHy5Pzo7AwLAK4mqA2VvkXfpwYsUpRgprpWXuQx+dchm5FtkbzuCf1Hj2hghw/t9
 ng/9umHoPojg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,338,1580803200";
   d="scan'208";a="449890244"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 02 Apr 2020 21:24:52 -0700
Date: Thu, 2 Apr 2020 21:24:52 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH] tools/testing/nvdimm: make __nfit_test_ioremap() static
Message-ID: <20200403042451.GB82123@iweiny-DESK2.sc.intel.com>
References: <20200403012148.41941-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200403012148.41941-1-yanaijie@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 7U6UYA53BHCOMHGWLDLSENEIPPTA6PFI
X-Message-ID-Hash: 7U6UYA53BHCOMHGWLDLSENEIPPTA6PFI
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, jgg@ziepe.ca
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7U6UYA53BHCOMHGWLDLSENEIPPTA6PFI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 03, 2020 at 09:21:48AM +0800, Jason Yan wrote:
> Fix the following sparse warning:
> 
> drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:65:14: warning:
> symbol '__nfit_test_ioremap' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Seems reasonable

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  tools/testing/nvdimm/test/iomap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
> index 03e40b3b0106..9fd157e31ab4 100644
> --- a/tools/testing/nvdimm/test/iomap.c
> +++ b/tools/testing/nvdimm/test/iomap.c
> @@ -62,7 +62,7 @@ struct nfit_test_resource *get_nfit_res(resource_size_t resource)
>  }
>  EXPORT_SYMBOL(get_nfit_res);
>  
> -void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
> +static void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
>  		void __iomem *(*fallback_fn)(resource_size_t, unsigned long))
>  {
>  	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
> -- 
> 2.17.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
