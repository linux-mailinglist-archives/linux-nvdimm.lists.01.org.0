Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BC29689C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Oct 2020 04:57:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94BE41624D94D;
	Thu, 22 Oct 2020 19:57:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 74B491624D94B
	for <linux-nvdimm@lists.01.org>; Thu, 22 Oct 2020 19:57:07 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09N2XeUk145984;
	Thu, 22 Oct 2020 22:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/doZufKKFxfFmqYtNj246dL1eI33VA0Vf6/u6Xshr+8=;
 b=atdrKOPStyCC7yvLQ9tzQ2PKq+aDUjg6ML+ru6fvuy7rASmveROQr513KjuEpnz1uCDk
 ZqVAXQOvM+rqP1hqNNcZ1HjYkI7Dvq9/ObxcoYFgtE1+QbkpopaaNR/59vcT1zi3RsLs
 W8uS1JHBZCbWGw19dKXvvSHZAg/rFsmIht89MfVbuSawpWoHWaoBKqa9SDu6bbj12K0Q
 9+p0JYaIKGc+Lp16X3pKynsi7GTT+h8UtuMeMcl8CNCoFh0Ktnys0sClsao05XSdY81P
 L89a43fIcqwaB8dZOwLLZ/JEROZmWlcFFDiVcRy9JD5QD+l1+foKieY6ckXWF0SfJ8va PA==
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 34b0vsew6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2020 22:56:59 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09N2mVmc000806;
	Fri, 23 Oct 2020 02:52:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma06ams.nl.ibm.com with ESMTP id 347qvhe3vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2020 02:52:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09N2q6qH27328886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2020 02:52:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABD264C04E;
	Fri, 23 Oct 2020 02:52:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85CDD4C040;
	Fri, 23 Oct 2020 02:52:04 +0000 (GMT)
Received: from [9.85.75.190] (unknown [9.85.75.190])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2020 02:52:04 +0000 (GMT)
Subject: Re: [PATCH] mm/mremap_pages: Fix static key devmap_managed_key
 updates
To: Ira Weiny <ira.weiny@intel.com>, Ralph Campbell <rcampbell@nvidia.com>
References: <20201022060753.21173-1-aneesh.kumar@linux.ibm.com>
 <20201022154124.GA537138@iweiny-DESK2.sc.intel.com>
 <d7540264-48f1-9fdc-0769-de68fdfc1c7b@nvidia.com>
 <20201022191028.GA534324@iweiny-DESK2.sc.intel.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <ea44b8e0-e8b7-3bcc-43f6-21966f037b24@linux.ibm.com>
Date: Fri, 23 Oct 2020 08:22:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022191028.GA534324@iweiny-DESK2.sc.intel.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_17:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230015
Message-ID-Hash: O32RDEIGS2YHCO6LIT6DP5EM5HKFK2OE
X-Message-ID-Hash: O32RDEIGS2YHCO6LIT6DP5EM5HKFK2OE
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, akpm@linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O32RDEIGS2YHCO6LIT6DP5EM5HKFK2OE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 10/23/20 12:40 AM, Ira Weiny wrote:
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
> 
> This looks cleaner to me.  Aneesh?
> 
> FWIW:
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
>

Yes. You can add

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>


-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
