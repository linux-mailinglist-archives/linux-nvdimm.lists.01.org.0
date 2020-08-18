Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD2B247C1A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Aug 2020 04:21:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ADCEE1315BECB;
	Mon, 17 Aug 2020 19:21:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8E1171315BEC9
	for <linux-nvdimm@lists.01.org>; Mon, 17 Aug 2020 19:20:57 -0700 (PDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 7770B5D6BAFE23369845;
	Tue, 18 Aug 2020 10:20:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 10:20:49 +0800
Subject: Re: [PATCH 1/1] device-dax: fix mismatches of request_mem_region()
To: Ira Weiny <ira.weiny@intel.com>
References: <20200817065926.2239-1-thunder.leizhen@huawei.com>
 <20200817185720.GC3142014@iweiny-DESK2.sc.intel.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <bdbd8e66-e9fd-3436-95e3-9a871de81f8b@huawei.com>
Date: Tue, 18 Aug 2020 10:20:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200817185720.GC3142014@iweiny-DESK2.sc.intel.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: ZKJMJRLFRWFC5627MZCZ2OFH5AGKGEI2
X-Message-ID-Hash: ZKJMJRLFRWFC5627MZCZ2OFH5AGKGEI2
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZKJMJRLFRWFC5627MZCZ2OFH5AGKGEI2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 8/18/2020 2:57 AM, Ira Weiny wrote:
> On Mon, Aug 17, 2020 at 02:59:26PM +0800, Zhen Lei wrote:
>> The resources allocated by request_mem_region() is better to use
>> release_mem_region() to free. These two functions are paired.
> 
> Does this fix a bug or some other issue?
> 
> It _looks_ ok but there is just enough complexity here that I wonder if it is
> worth changing this without a good reason.
It's just that everyone uses it in this way. In fact, there's a similar patch:
b88aa8509828b56 mfd: sm501: Fix mismatches of request_mem_region

I used the subject directly. And we can found some examples in other places:
vi drivers/acpi/acpi_extlog.c +283 	in extlog_init()


> 
> OTOH is there some way to make release_mem_region() more specific about which
> resource is getting free'ed?

* __release_region - release a previously reserved resource region

As long as we pass the parameters correctly, it will work well.

> 
> Ira
> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/dax/kmem.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>> index 275aa5f873991af..9e38f9c2b6d7f02 100644
>> --- a/drivers/dax/kmem.c
>> +++ b/drivers/dax/kmem.c
>> @@ -82,8 +82,7 @@ int dev_dax_kmem_probe(struct device *dev)
>>  	rc = add_memory_driver_managed(numa_node, new_res->start,
>>  				       resource_size(new_res), kmem_name);
>>  	if (rc) {
>> -		release_resource(new_res);
>> -		kfree(new_res);
>> +		release_mem_region(kmem_start, kmem_size);
>>  		kfree(new_res_name);
>>  		return rc;
>>  	}
>> @@ -118,8 +117,7 @@ static int dev_dax_kmem_remove(struct device *dev)
>>  	}
>>  
>>  	/* Release and free dax resources */
>> -	release_resource(res);
>> -	kfree(res);
>> +	release_mem_region(kmem_start, kmem_size);
>>  	kfree(res_name);
>>  	dev_dax->dax_kmem_res = NULL;
>>  
>> -- 
>> 1.8.3
>>
>> _______________________________________________
>> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
>> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> 
> .
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
