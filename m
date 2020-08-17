Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CEA247382
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Aug 2020 20:57:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AA7461342D1CC;
	Mon, 17 Aug 2020 11:57:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8F5221342D1BE
	for <linux-nvdimm@lists.01.org>; Mon, 17 Aug 2020 11:57:24 -0700 (PDT)
IronPort-SDR: mIm+t8FwNb2u0LnrlT2EaGYUS561HvRR8vvbfMmqC03iajKMnizrftZN9Tp0udflwYm5QJNkt1
 4jx3X8kVopJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154031619"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600";
   d="scan'208";a="154031619"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 11:57:23 -0700
IronPort-SDR: OWTwlNxMwxGWPKqFXHUAcdkBgerJCxoHGNyJTJ/1a6WyCsxrtCQC67a82jvVK2eJAyHzxYEEXi
 3tgbhviSz9jg==
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600";
   d="scan'208";a="471522610"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 11:57:23 -0700
Date: Mon, 17 Aug 2020 11:57:20 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] device-dax: fix mismatches of request_mem_region()
Message-ID: <20200817185720.GC3142014@iweiny-DESK2.sc.intel.com>
References: <20200817065926.2239-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200817065926.2239-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: IZFPWRDMF6NBMJF33IIL6CVGSPOMTWUF
X-Message-ID-Hash: IZFPWRDMF6NBMJF33IIL6CVGSPOMTWUF
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IZFPWRDMF6NBMJF33IIL6CVGSPOMTWUF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 17, 2020 at 02:59:26PM +0800, Zhen Lei wrote:
> The resources allocated by request_mem_region() is better to use
> release_mem_region() to free. These two functions are paired.

Does this fix a bug or some other issue?

It _looks_ ok but there is just enough complexity here that I wonder if it is
worth changing this without a good reason.

OTOH is there some way to make release_mem_region() more specific about which
resource is getting free'ed?

Ira

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/dax/kmem.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 275aa5f873991af..9e38f9c2b6d7f02 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -82,8 +82,7 @@ int dev_dax_kmem_probe(struct device *dev)
>  	rc = add_memory_driver_managed(numa_node, new_res->start,
>  				       resource_size(new_res), kmem_name);
>  	if (rc) {
> -		release_resource(new_res);
> -		kfree(new_res);
> +		release_mem_region(kmem_start, kmem_size);
>  		kfree(new_res_name);
>  		return rc;
>  	}
> @@ -118,8 +117,7 @@ static int dev_dax_kmem_remove(struct device *dev)
>  	}
>  
>  	/* Release and free dax resources */
> -	release_resource(res);
> -	kfree(res);
> +	release_mem_region(kmem_start, kmem_size);
>  	kfree(res_name);
>  	dev_dax->dax_kmem_res = NULL;
>  
> -- 
> 1.8.3
> 
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
