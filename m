Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1A72DDE69
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 07:09:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56EAF100EB32B;
	Thu, 17 Dec 2020 22:09:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 13B4C100EB327
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 22:09:21 -0800 (PST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cxz236Fl7zksDZ;
	Fri, 18 Dec 2020 14:08:27 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Fri, 18 Dec 2020
 14:09:16 +0800
Subject: Re: [PATCH 1/1] device-dax: avoid an unnecessary check in
 alloc_dev_dax_range()
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, linux-nvdimm
	<linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20201120092251.2197-1-thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <55970773-35ff-1afb-940b-8342b09aea9a@huawei.com>
Date: Fri, 18 Dec 2020 14:09:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201120092251.2197-1-thunder.leizhen@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Message-ID-Hash: X7ICA6NXPWZ5LZAIPZ4IUE6E22N5RPPU
X-Message-ID-Hash: X7ICA6NXPWZ5LZAIPZ4IUE6E22N5RPPU
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X7ICA6NXPWZ5LZAIPZ4IUE6E22N5RPPU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 2020/11/20 17:22, Zhen Lei wrote:
> Swap the calling sequence of krealloc() and __request_region(), call the
> latter first. In this way, the value of dev_dax->nr_range does not need to
> be considered when __request_region() failed.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/dax/bus.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 27513d311242..1efae11d947a 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -763,23 +763,15 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
>  		return 0;
>  	}
>  
> -	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
> -			* (dev_dax->nr_range + 1), GFP_KERNEL);
> -	if (!ranges)
> -		return -ENOMEM;
> -
>  	alloc = __request_region(res, start, size, dev_name(dev), 0);
> -	if (!alloc) {
> -		/*
> -		 * If this was an empty set of ranges nothing else
> -		 * will release @ranges, so do it now.
> -		 */
> -		if (!dev_dax->nr_range) {
> -			kfree(ranges);
> -			ranges = NULL;
> -		}
> -		dev_dax->ranges = ranges;
> +	if (!alloc)
>  		return -ENOMEM;
> +
> +	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
> +			* (dev_dax->nr_range + 1), GFP_KERNEL);
> +	if (!ranges) {
> +		rc = -ENOMEM;
> +		goto err;

Hi, Dan Williams:
In fact, after adding the new helper dev_dax_trim_range(), we can
directly call __release_region() and return error code at here. Replace goto.

>  	}
>  
>  	for (i = 0; i < dev_dax->nr_range; i++)
> @@ -808,11 +800,14 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
>  		dev_dbg(dev, "delete range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
>  				&alloc->start, &alloc->end);
>  		dev_dax->nr_range--;
> -		__release_region(res, alloc->start, resource_size(alloc));
> -		return rc;
> +		goto err;
>  	}
>  
>  	return 0;
> +
> +err:
> +	__release_region(res, alloc->start, resource_size(alloc));
> +	return rc;
>  }
>  
>  static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, resource_size_t size)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
