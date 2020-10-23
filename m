Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F4A2975C4
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Oct 2020 19:29:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2AAEB1632F9F2;
	Fri, 23 Oct 2020 10:29:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.64; helo=hqnvemgate25.nvidia.com; envelope-from=rcampbell@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com [216.228.121.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DFF701632F9F1
	for <linux-nvdimm@lists.01.org>; Fri, 23 Oct 2020 10:29:46 -0700 (PDT)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5f9313100000>; Fri, 23 Oct 2020 10:29:52 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Oct
 2020 17:29:36 +0000
Subject: Re: [PATCH] mm/mremap_pages: Fix static key devmap_managed_key
 updates
To: Christoph Hellwig <hch@infradead.org>
References: <20201022060753.21173-1-aneesh.kumar@linux.ibm.com>
 <20201022154124.GA537138@iweiny-DESK2.sc.intel.com>
 <d7540264-48f1-9fdc-0769-de68fdfc1c7b@nvidia.com>
 <20201023064610.GA22405@infradead.org>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <c08980a1-db70-d37d-9ab4-4fd2ebd5f4aa@nvidia.com>
Date: Fri, 23 Oct 2020 10:29:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201023064610.GA22405@infradead.org>
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1603474192; bh=YyKQoCN1wnU7okhj6LDaueejqYWF4Ww+dZnQEYDI7FU=;
	h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
	 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	b=i4hqGAM3uBnsXS2G1O8qT7iA6eQW47llgBWKgIEDDQWpPNJvsHh9/qJPPQIUbO4lt
	 Ob3BUjLwnu6G6MuyKQJYl8nABl1hrGBRGFrD7+JoF4D4UI3MaB754PfSKa2N2ftVFn
	 /2N8C8SdJTQ5GdDrUEf+Qd2xmyf4uaaQB7esRXfJWgV20Gpe8CF9UOMdxG4bS5O02t
	 S9PS317sSp1CxG4nYIWLduoLmm/2XKvppjFg1iBRvIORzh3cmWpabZVxXeQNV6WlV4
	 88L75tlC7jUaQtlj2YLaV+54zPJE5p7pleBEfs5LyZRaEepJiCSySBz6pTLyYYcRrO
	 Q6CnBm7NNUwcw==
Message-ID-Hash: KWWTDG24O3MYEFWVQAIMQK5WDYSLVTED
X-Message-ID-Hash: KWWTDG24O3MYEFWVQAIMQK5WDYSLVTED
X-MailFrom: rcampbell@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linux-mm@kvack.org, akpm@linux-foundation.org, Sachin@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KWWTDG24O3MYEFWVQAIMQK5WDYSLVTED/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit


On 10/22/20 11:46 PM, Christoph Hellwig wrote:
> On Thu, Oct 22, 2020 at 11:19:43AM -0700, Ralph Campbell wrote:
>>
>> On 10/22/20 8:41 AM, Ira Weiny wrote:
>>> On Thu, Oct 22, 2020 at 11:37:53AM +0530, Aneesh Kumar K.V wrote:
>>>> commit 6f42193fd86e ("memremap: don't use a separate devm action for
>>>> devmap_managed_enable_get") changed the static key updates such that we
>>>> now call devmap_managed_enable_put() without doing the equivalent
>>>> devmap_managed_enable_get().
>>>>
>>>> devmap_managed_enable_get() is only called for MEMORY_DEVICE_PRIVATE and
>>>> MEMORY_DEVICE_FS_DAX, But memunmap_pages() get called for other pgmap
>>>> types too. This results in the below warning when switching between
>>>> system-ram and devdax mode for devdax namespace.
>>>>
>>>>    jump label: negative count!
>>>>    WARNING: CPU: 52 PID: 1335 at kernel/jump_label.c:235 static_key_slow_try_dec+0x88/0xa0
>>>>    Modules linked in:
>>>>    ....
>>>>
>>>>    NIP [c000000000433318] static_key_slow_try_dec+0x88/0xa0
>>>>    LR [c000000000433314] static_key_slow_try_dec+0x84/0xa0
>>>>    Call Trace:
>>>>    [c000000025c1f660] [c000000000433314] static_key_slow_try_dec+0x84/0xa0 (unreliable)
>>>>    [c000000025c1f6d0] [c000000000433664] __static_key_slow_dec_cpuslocked+0x34/0xd0
>>>>    [c000000025c1f700] [c0000000004337a4] static_key_slow_dec+0x54/0xf0
>>>>    [c000000025c1f770] [c00000000059c49c] memunmap_pages+0x36c/0x500
>>>>    [c000000025c1f820] [c000000000d91d10] devm_action_release+0x30/0x50
>>>>    [c000000025c1f840] [c000000000d92e34] release_nodes+0x2f4/0x3e0
>>>>    [c000000025c1f8f0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
>>>>    [c000000025c1f930] [c000000000d883a4] bus_remove_device+0x124/0x210
>>>>    [c000000025c1f9b0] [c000000000d80ef4] device_del+0x1d4/0x530
>>>>    [c000000025c1fa70] [c000000000e341e8] unregister_dev_dax+0x48/0xe0
>>>>    [c000000025c1fae0] [c000000000d91d10] devm_action_release+0x30/0x50
>>>>    [c000000025c1fb00] [c000000000d92e34] release_nodes+0x2f4/0x3e0
>>>>    [c000000025c1fbb0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
>>>>    [c000000025c1fbf0] [c000000000d87000] unbind_store+0x130/0x170
>>>>    [c000000025c1fc30] [c000000000d862a0] drv_attr_store+0x40/0x60
>>>>    [c000000025c1fc50] [c0000000006d316c] sysfs_kf_write+0x6c/0xb0
>>>>    [c000000025c1fc90] [c0000000006d2328] kernfs_fop_write+0x118/0x280
>>>>    [c000000025c1fce0] [c0000000005a79f8] vfs_write+0xe8/0x2a0
>>>>    [c000000025c1fd30] [c0000000005a7d94] ksys_write+0x84/0x140
>>>>    [c000000025c1fd80] [c00000000003a430] system_call_exception+0x120/0x270
>>>>    [c000000025c1fe20] [c00000000000c540] system_call_common+0xf0/0x27c
>>>>
>>>> Cc: Christoph Hellwig <hch@infradead.org>
>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>> Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>
>>>> Cc: linux-nvdimm@lists.01.org
>>>> Cc: Ira Weiny <ira.weiny@intel.com>
>>>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>    mm/memremap.c | 19 +++++++++++++++----
>>>>    1 file changed, 15 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/memremap.c b/mm/memremap.c
>>>> index 73a206d0f645..d4402ff3e467 100644
>>>> --- a/mm/memremap.c
>>>> +++ b/mm/memremap.c
>>>> @@ -158,6 +158,16 @@ void memunmap_pages(struct dev_pagemap *pgmap)
>>>>    {
>>>>    	unsigned long pfn;
>>>>    	int i;
>>>> +	bool need_devmap_managed = false;
>>>> +
>>>> +	switch (pgmap->type) {
>>>> +	case MEMORY_DEVICE_PRIVATE:
>>>> +	case MEMORY_DEVICE_FS_DAX:
>>>> +		need_devmap_managed = true;
>>>> +		break;
>>>> +	default:
>>>> +		break;
>>>> +	}
>>>
>>> Is it overkill to avoid duplicating this switch logic in
>>> page_is_devmap_managed() by creating another call which can be used here?
>>
>> Perhaps. I can imagine a helper defined in include/linux/mm.h which
>> page_is_devmap_managed() could also call but that would impact a lot of
>> places that include mm.h. Since memremap.c already has to have intimate
>> knowledge of the pgmap->type, I think limiting the change to just what
>> is needed is better for now. So the patch looks OK to me.
>>
>> Looking at this some more, I would suggest changing devmap_managed_enable_get()
>> and devmap_managed_enable_put() to do the special case checking instead of
>> doing it in memremap_pages() and memunmap_pages().
>> Then devmap_managed_enable_get() doesn't need to return an error if
>> CONFIG_DEV_PAGEMAP_OPS isn't defined. I have only compile tested the
>> following.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> 
> This looks ok as well.  Can you submit it as a proper standalone patch?
> 

Yes. I was just about to ask whether I should do that and you beat me to it.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
