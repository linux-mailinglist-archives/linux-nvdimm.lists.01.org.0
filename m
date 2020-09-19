Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A14B270DA2
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Sep 2020 13:38:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 848B513F73F7E;
	Sat, 19 Sep 2020 04:38:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3AF0C13DDB55D
	for <linux-nvdimm@lists.01.org>; Sat, 19 Sep 2020 04:38:37 -0700 (PDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id B9315B2D9BF5EBC1C457;
	Sat, 19 Sep 2020 19:38:34 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 19:38:34 +0800
Subject: Re: [PATCH v4 1/1] libnvdimm: fix memory leaks in of_pmem.c
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Markus
 Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20200901081450.1969-1-thunder.leizhen@huawei.com>
 <20200901081450.1969-2-thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6bba2182-5229-627e-11e4-347e12c21bd1@huawei.com>
Date: Sat, 19 Sep 2020 19:38:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200901081450.1969-2-thunder.leizhen@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: E7XOJATWFCKW3IJSTFBGXU2QPWQIE6UO
X-Message-ID-Hash: E7XOJATWFCKW3IJSTFBGXU2QPWQIE6UO
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E7XOJATWFCKW3IJSTFBGXU2QPWQIE6UO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, all:
  Is this patch acceptable?


On 2020/9/1 16:14, Zhen Lei wrote:
> Currently, in the last error path of of_pmem_region_probe() and in
> of_pmem_region_remove(), free the memory allocated by kstrdup() is
> missing. Add kfree(priv->bus_desc.provider_name) to fix it.
> 
> In addition, add a sanity check to kstrdup() to prevent a
> NULL-pointer dereference.
> 
> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  drivers/nvdimm/of_pmem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 10dbdcdfb9ce913..13c4c274ca6ea88 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -31,11 +31,17 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
> +	if (!priv->bus_desc.provider_name) {
> +		kfree(priv);
> +		return -ENOMEM;
> +	}
> +
>  	priv->bus_desc.module = THIS_MODULE;
>  	priv->bus_desc.of_node = np;
>  
>  	priv->bus = bus = nvdimm_bus_register(&pdev->dev, &priv->bus_desc);
>  	if (!bus) {
> +		kfree(priv->bus_desc.provider_name);
>  		kfree(priv);
>  		return -ENODEV;
>  	}
> @@ -83,6 +89,7 @@ static int of_pmem_region_remove(struct platform_device *pdev)
>  	struct of_pmem_private *priv = platform_get_drvdata(pdev);
>  
>  	nvdimm_bus_unregister(priv->bus);
> +	kfree(priv->bus_desc.provider_name);
>  	kfree(priv);
>  
>  	return 0;
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
