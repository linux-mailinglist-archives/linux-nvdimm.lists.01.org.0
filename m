Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F18E2DCC68
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 07:19:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E843F100EB820;
	Wed, 16 Dec 2020 22:19:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=liuzhiqiang26@huawei.com; receiver=<UNKNOWN> 
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3C724100EBB9F
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 22:19:51 -0800 (PST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CxMJf4L0TzM5cg
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 14:18:58 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Thu, 17 Dec 2020
 14:19:39 +0800
Subject: Re: [ndctl PATCH 6/8] lib/inject: check whether cmd is created
 successfully
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
 <8e8a88ee-a792-dc86-0fa7-b2609588fc88@huawei.com>
 <a75b781d2d838242930633f9f3c70c67df248849.camel@intel.com>
From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <57407095-029d-0631-51cb-9970007e6b0c@huawei.com>
Date: Thu, 17 Dec 2020 14:19:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a75b781d2d838242930633f9f3c70c67df248849.camel@intel.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Message-ID-Hash: AA6MWZ6EOUSMGOWQX4NYECJV6II5QNLO
X-Message-ID-Hash: AA6MWZ6EOUSMGOWQX4NYECJV6II5QNLO
X-MailFrom: liuzhiqiang26@huawei.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linfeilong@huawei.com" <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AA6MWZ6EOUSMGOWQX4NYECJV6II5QNLO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2020/12/17 11:33, Verma, Vishal L wrote:
> On Fri, 2020-11-06 at 17:27 +0800, Zhiqiang Liu wrote:
>> ndctl_bus_cmd_new_ars_cp() is called to create cmd,
>> which may return NULL. We need to check whether it
>> is NULL in callers, such as ndctl_namespace_get_clear_uint
>> and ndctl_namespace_injection_status.
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> ---
>>  ndctl/lib/inject.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/ndctl/lib/inject.c b/ndctl/lib/inject.c
>> index 815f254..b543fc7 100644
>> --- a/ndctl/lib/inject.c
>> +++ b/ndctl/lib/inject.c
>> @@ -114,6 +114,10 @@ static int ndctl_namespace_get_clear_unit(struct ndctl_namespace *ndns)
>>  	if (rc)
>>  		return rc;
>>  	cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
>> +	if (!cmd) {
>> +		err(ctx, "bus: %s failed to create cmd\n", ndctl_bus_get_provider(bus));
>> +		return -ENOTTY;
>> +	}
>>  	rc = ndctl_cmd_submit(cmd);
>>  	if (rc < 0) {
>>  		dbg(ctx, "Error submitting ars_cap: %d\n", rc);
>> @@ -457,6 +461,10 @@ NDCTL_EXPORT int ndctl_namespace_injection_status(struct ndctl_namespace *ndns)
>>  			return rc;
>>
>>  		cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
>> +		if (!cmd) {
>> +			err(ctx, "bus: %s failed to create cmd\n", ndctl_bus_get_provider(bus));
>> +			return -ENOTTY;
>> +		}
>>  		rc = ndctl_cmd_submit(cmd);
>>  		if (rc < 0) {
>>  			dbg(ctx, "Error submitting ars_cap: %d\n", rc);
> 
> This looks good in general, but I made some small fixups while applying.
> Printing the bus provider here isn't as useful - I replaced it with
> printing the namespace 'devname':
> 
> -               err(ctx, "bus: %s failed to create cmd\n", ndctl_bus_get_provider(bus));
> +               err(ctx, "%s: failed to create cmd\n",
> +                       ndctl_namespace_get_devname(ndns));
> 
> Also fixed up a couple of typos in commit messages, but otherwise the
> series looks good and I've applied it for v71.
> 

Thanks again.

Regards
Zhiqiang Liu

> Thanks,
> -Vishal
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
