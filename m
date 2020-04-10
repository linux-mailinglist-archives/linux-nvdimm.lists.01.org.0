Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9061A41CA
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Apr 2020 06:24:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8922210113FDF;
	Thu,  9 Apr 2020 21:24:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=wubo40@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0910510113FDE
	for <linux-nvdimm@lists.01.org>; Thu,  9 Apr 2020 21:24:55 -0700 (PDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id D0505BCEA026FDAD5F11
	for <linux-nvdimm@lists.01.org>; Fri, 10 Apr 2020 12:24:00 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.252) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 12:23:53 +0800
Subject: Re: [PATCH] nvdimm: cleanup resources when the initialization fails
To: Dan Williams <dan.j.williams@intel.com>
References: <c9f9975c-b4ae-1234-56ed-dce4b052080d@huawei.com>
 <CAPcyv4hH7nO0_-pMckzWbKGckKy74KD7nWERB3q7TLrVTj+UXQ@mail.gmail.com>
From: Wu Bo <wubo40@huawei.com>
Message-ID: <01e9a9f8-f0fa-266d-1bd3-a3998280b4e8@huawei.com>
Date: Fri, 10 Apr 2020 12:23:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hH7nO0_-pMckzWbKGckKy74KD7nWERB3q7TLrVTj+UXQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.173.221.252]
X-CFilter-Loop: Reflected
Message-ID-Hash: JQLTJHLCVWP2KQQLTI76VACGNXGR2OQY
X-Message-ID-Hash: JQLTJHLCVWP2KQQLTI76VACGNXGR2OQY
X-MailFrom: wubo40@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, liuzhiqiang26@huawei.com, linfeilong@huawei.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JQLTJHLCVWP2KQQLTI76VACGNXGR2OQY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 2020/4/10 11:20, Dan Williams wrote:
> On Thu, Apr 9, 2020 at 8:16 PM Wu Bo <wubo40@huawei.com> wrote:
>>
>> From: Wu Bo <wubo40@huawei.com>
>>
>> When the initialization fails, add the cleanup resources
>> in pmem_attach_disk() function
> 
> Are you familiar with devm?
> 
> devm routines take care of this automatically on driver probe error conditions.
> 

Sorry, i did not pay attention to devm_add_action_or_reset() will 
automatically call clean up action on driver probe error conditions. 
Please ignore this patch.

thanks.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
