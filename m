Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F87365311
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 09:19:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 30DD2100EBBBB;
	Tue, 20 Apr 2021 00:19:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zou_wei@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D5D87100EF27B
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 00:19:20 -0700 (PDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPZjY5HcwzpZCx;
	Tue, 20 Apr 2021 15:16:17 +0800 (CST)
Received: from [10.174.178.100] (10.174.178.100) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 15:19:15 +0800
Subject: Re: [PATCH -next] tools/testing/nvdimm: Make symbol
 '__nfit_test_ioremap' static
To: Santosh Sivaraj <santosh@fossix.org>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <ira.weiny@intel.com>
References: <1617779451-81730-1-git-send-email-zou_wei@huawei.com>
 <87h7k1zco0.fsf@fossix.org>
From: Samuel Zou <zou_wei@huawei.com>
Message-ID: <066633f6-e624-54ef-0de0-5589305fdbe3@huawei.com>
Date: Tue, 20 Apr 2021 15:19:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87h7k1zco0.fsf@fossix.org>
Content-Language: en-US
X-Originating-IP: [10.174.178.100]
X-CFilter-Loop: Reflected
Message-ID-Hash: JRHOXBKJTYARZOAX3HZGC3W2OZ2ZRFFZ
X-Message-ID-Hash: JRHOXBKJTYARZOAX3HZGC3W2OZ2ZRFFZ
X-MailFrom: zou_wei@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JRHOXBKJTYARZOAX3HZGC3W2OZ2ZRFFZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi Santosh,

Thanks for your review, and sorry for my mistake. I will send the v2 soon.

On 2021/4/20 14:35, Santosh Sivaraj wrote:
> 
> Hi Zou,
> 
> Zou Wei <zou_wei@huawei.com> writes:
> 
>> The sparse tool complains as follows:
>>
>> tools/testing/nvdimm/test/iomap.c:65:14: warning:
>>   symbol '__nfit_test_ioremap' was not declared. Should it be static?
>>
>> This symbol is not used outside of security.c, so this
> 
> s/security.c/iomap.c/
> 
> Thanks,
> Santosh
> 
>> commit marks it static.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>> ---
>>   tools/testing/nvdimm/test/iomap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
>> index c62d372..ed563bd 100644
>> --- a/tools/testing/nvdimm/test/iomap.c
>> +++ b/tools/testing/nvdimm/test/iomap.c
>> @@ -62,7 +62,7 @@ struct nfit_test_resource *get_nfit_res(resource_size_t resource)
>>   }
>>   EXPORT_SYMBOL(get_nfit_res);
>>   
>> -void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
>> +static void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
>>   		void __iomem *(*fallback_fn)(resource_size_t, unsigned long))
>>   {
>>   	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
>> -- 
>> 2.6.2
>> _______________________________________________
>> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
>> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> .
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
