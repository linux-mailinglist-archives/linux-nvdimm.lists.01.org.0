Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E124D24A191
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 16:19:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 92A621342F38D;
	Wed, 19 Aug 2020 07:19:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A56C01342F38A
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 07:19:45 -0700 (PDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 33BCF64983AB2B898E66;
	Wed, 19 Aug 2020 22:19:41 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 22:19:36 +0800
Subject: Re: [PATCH v2 1/4] libnvdimm: fix memmory leaks in of_pmem.c
To: Oliver O'Halloran <oohall@gmail.com>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <20200819020503.3079-2-thunder.leizhen@huawei.com>
 <CAOSf1CGvtX6FjYXy-mGxoEx4B6ZQ-LUZDMi-503JtECLu93faw@mail.gmail.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d22e87df-0602-91fa-2ecd-6f641b734fbb@huawei.com>
Date: Wed, 19 Aug 2020 22:19:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOSf1CGvtX6FjYXy-mGxoEx4B6ZQ-LUZDMi-503JtECLu93faw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: NF4SF5NQMKMV7A5B73VHSJI2TFPA7X4F
X-Message-ID-Hash: NF4SF5NQMKMV7A5B73VHSJI2TFPA7X4F
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Markus Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NF4SF5NQMKMV7A5B73VHSJI2TFPA7X4F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 8/19/2020 9:37 PM, Oliver O'Halloran wrote:
> On Wed, Aug 19, 2020 at 12:05 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> The memory priv->bus_desc.provider_name allocated by kstrdup() is not
>> freed correctly.
>>
>> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Yep, that's a bug.
> 
> Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

Thanks for your review.

> 
>> ---
>>  drivers/nvdimm/of_pmem.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
>> index 10dbdcdfb9ce913..1292ffca7b2ecc0 100644
>> --- a/drivers/nvdimm/of_pmem.c
>> +++ b/drivers/nvdimm/of_pmem.c
>> @@ -36,6 +36,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>>
>>         priv->bus = bus = nvdimm_bus_register(&pdev->dev, &priv->bus_desc);
>>         if (!bus) {
>> +               kfree(priv->bus_desc.provider_name);
>>                 kfree(priv);
>>                 return -ENODEV;
>>         }
>> @@ -83,6 +84,7 @@ static int of_pmem_region_remove(struct platform_device *pdev)
>>         struct of_pmem_private *priv = platform_get_drvdata(pdev);
>>
>>         nvdimm_bus_unregister(priv->bus);
>> +       kfree(priv->bus_desc.provider_name);
>>         kfree(priv);
>>
>>         return 0;
>> --
>> 1.8.3
>>
>>
> 
> .
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
