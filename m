Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C25226E22D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 19:20:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4F03F1482E71F;
	Thu, 17 Sep 2020 10:20:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE7201482E709
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 10:20:43 -0700 (PDT)
IronPort-SDR: 2VJw2/Ya5/vfkQqOsbUOjfknm2+lCJ/9SN8tyvOA/Q5jAqqmEKbwCFB0DdwA/6msf4xMW/yD+x
 bSa2beS7yxLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="221301960"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400";
   d="scan'208";a="221301960"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 10:20:41 -0700
IronPort-SDR: jDqLwJR4tfGkIeVZYhis5sk9Di2M3mxg8vhq53Hn6J7aLdvJ8SFj0VRPwb54EHsAO8Q675SphU
 s/d4D/hszNuA==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400";
   d="scan'208";a="507820401"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 10:20:40 -0700
Date: Thu, 17 Sep 2020 10:20:40 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH] device-dax: make dev_dax_kmem_probe() static
Message-ID: <20200917172040.GA2541163@iweiny-DESK2.sc.intel.com>
References: <20200912033901.143382-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200912033901.143382-1-yanaijie@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: HVD4CUURH4OGK5ZPM2RRZKUW2T2APWLW
X-Message-ID-Hash: HVD4CUURH4OGK5ZPM2RRZKUW2T2APWLW
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: akpm@linux-foundation.org, sfr@canb.auug.org.au, linux-nvdimm@lists.01.org, Hulk Robot <hulkci@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HVD4CUURH4OGK5ZPM2RRZKUW2T2APWLW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Sep 12, 2020 at 11:39:01AM +0800, Jason Yan wrote:
> This eliminates the following sparse warning:
> 
> drivers/dax/kmem.c:38:5: warning: symbol 'dev_dax_kmem_probe' was not
> declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/dax/kmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 7dcb2902e9b1..e79afbadd4e0 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -35,7 +35,7 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
>  	return 0;
>  }
>  
> -int dev_dax_kmem_probe(struct dev_dax *dev_dax)
> +static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  {
>  	int numa_node = dev_dax->target_node;
>  	struct device *dev = &dev_dax->dev;
> -- 
> 2.25.4
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
