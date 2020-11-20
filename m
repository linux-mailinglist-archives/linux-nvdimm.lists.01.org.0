Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 942FE2BA0B2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 04:01:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C669A100ED4BC;
	Thu, 19 Nov 2020 19:01:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=liuzhiqiang26@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A0C71100EF261
	for <linux-nvdimm@lists.01.org>; Thu, 19 Nov 2020 19:01:35 -0800 (PST)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CchC01WFgz15PQb
	for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 11:01:16 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Nov 2020
 11:01:22 +0800
Subject: Re: [ndctl PATCH 0/8] fix serverl issues reported by Coverity
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "Scargall, Steve"
	<steve.scargall@intel.com>
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
 <5a9465d5-b933-3b74-bd74-7e18e48a7467@huawei.com>
 <d79aa3a155fb2373e96f00b7b796d3d7ab5022b5.camel@intel.com>
From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <a2a55e5b-e615-86e4-4424-2c200e330db9@huawei.com>
Date: Fri, 20 Nov 2020 11:01:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d79aa3a155fb2373e96f00b7b796d3d7ab5022b5.camel@intel.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Message-ID-Hash: NBMSJXY7NIEQO5ONBDG5IGJMPILAAFE3
X-Message-ID-Hash: NBMSJXY7NIEQO5ONBDG5IGJMPILAAFE3
X-MailFrom: liuzhiqiang26@huawei.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linfeilong@huawei.com" <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NBMSJXY7NIEQO5ONBDG5IGJMPILAAFE3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 2020/11/20 10:47, Verma, Vishal L wrote:
> On Fri, 2020-11-20 at 10:45 +0800, Zhiqiang Liu wrote:
>> Friendly ping...
>>
>> I just wonder if this kind of patches will not be reviewed
>> and processed.
>>
>> I`d be very happy to receive any feedback.
> 
> Hi Zhiqiang,
> 
> These are definitely on my list to look at, I've just not had the time
> to do so yet. I'm hoping to clear up my ndctl backlog in the next couple
> of weeks though and get a v71 release out.
> 
> Thanks for the patience!
> 
> -Vishal
> 

Thanks for your reply.
Looking forward to the new release.

Thank you again.

-Zhiqiang Liu

>>
>> On 2020/11/6 17:23, Zhiqiang Liu wrote:
>>> Recently, we use Coverity to analysis the ndctl package.
>>> Several issues should be resolved to make Coverity happy.
>>>
>>> lihaotian9 (8):
>>>   namespace: check whether pfn|dax|btt is NULL in setup_namespace
>>>   lib/libndctl: fix memory leakage problem in add_bus
>>>   libdaxctl: fix memory leakage in add_dax_region()
>>>   dimm: fix potential fd leakage in dimm_action()
>>>   util/help: check whether strdup returns NULL in exec_man_konqueror
>>>   lib/inject: check whether cmd is created successfully
>>>   libndctl: check whether ndctl_btt_get_namespace returns NULL in
>>>     callers
>>>   namespace: check whether seed is NULL in validate_namespace_options
>>>
>>>  daxctl/lib/libdaxctl.c |  3 +++
>>>  ndctl/dimm.c           | 12 +++++++-----
>>>  ndctl/lib/inject.c     |  8 ++++++++
>>>  ndctl/lib/libndctl.c   |  1 +
>>>  ndctl/namespace.c      | 23 ++++++++++++++++++-----
>>>  test/libndctl.c        | 16 +++++++++++-----
>>>  test/parent-uuid.c     |  2 +-
>>>  util/help.c            |  8 +++++++-
>>>  util/json.c            |  3 +++
>>>  9 files changed, 59 insertions(+), 17 deletions(-)
>>>
>> _______________________________________________
>> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
>> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> 
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> 
> .
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
