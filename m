Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1E2B89E5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Nov 2020 02:56:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A01B2100EBB79;
	Wed, 18 Nov 2020 17:56:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 196DF100EBB78
	for <linux-nvdimm@lists.01.org>; Wed, 18 Nov 2020 17:56:01 -0800 (PST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cc2nl1fXzzLq1y;
	Thu, 19 Nov 2020 09:55:39 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.144) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 19 Nov 2020
 09:55:51 +0800
Subject: Re: [PATCH 1/1] ACPI/nfit: correct the badrange to be reported in
 nfit_handle_mce()
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "Jiang, Dave" <dave.jiang@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "Weiny, Ira" <ira.weiny@intel.com>
References: <20201118084117.1937-1-thunder.leizhen@huawei.com>
 <1fa493113c74a0618d34f0e5d88e4402abe3e69c.camel@intel.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b8396b38-ef3e-18d9-b9a7-d6e836d546e9@huawei.com>
Date: Thu, 19 Nov 2020 09:55:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1fa493113c74a0618d34f0e5d88e4402abe3e69c.camel@intel.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.144]
X-CFilter-Loop: Reflected
Message-ID-Hash: NWVDV4SGP7P7KGKSDY2J5FPHDZRC6AR3
X-Message-ID-Hash: NWVDV4SGP7P7KGKSDY2J5FPHDZRC6AR3
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NWVDV4SGP7P7KGKSDY2J5FPHDZRC6AR3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 2020/11/19 4:50, Verma, Vishal L wrote:
> On Wed, 2020-11-18 at 16:41 +0800, Zhen Lei wrote:
>> The badrange to be reported should always cover mce->addr.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/acpi/nfit/mce.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Ah good find, agreed with Dan that this is stable material.
> Minor nit, I'd recommend rewording the subject line to something like:
> 
> "acpi/nfit: fix badrange insertion in nfit_handle_mce()"

OK, I will send v2.

> 
> Otherwise, looks good to me.
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> 
>>
>> diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
>> index ee8d9973f60b..053e719c7bea 100644
>> --- a/drivers/acpi/nfit/mce.c
>> +++ b/drivers/acpi/nfit/mce.c
>> @@ -63,7 +63,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
>>  
>>  		/* If this fails due to an -ENOMEM, there is little we can do */
>>  		nvdimm_bus_add_badrange(acpi_desc->nvdimm_bus,
>> -				ALIGN(mce->addr, L1_CACHE_BYTES),
>> +				ALIGN_DOWN(mce->addr, L1_CACHE_BYTES),
>>  				L1_CACHE_BYTES);
>>  		nvdimm_region_notify(nfit_spa->nd_region,
>>  				NVDIMM_REVALIDATE_POISON);
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
