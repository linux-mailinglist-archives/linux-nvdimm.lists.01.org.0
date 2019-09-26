Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02217BF3DA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Sep 2019 15:15:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EBA4221967BC5;
	Thu, 26 Sep 2019 06:17:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7914C21967BC5
 for <linux-nvdimm@lists.01.org>; Thu, 26 Sep 2019 06:17:34 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8QDCZ4S136347; Thu, 26 Sep 2019 09:15:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v8wr7hb54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 09:15:24 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8QDDjeK001776;
 Thu, 26 Sep 2019 09:15:23 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v8wr7hb3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 09:15:23 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8QDFC6d004612;
 Thu, 26 Sep 2019 13:15:22 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma05wdc.us.ibm.com with ESMTP id 2v5bg7qaj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 13:15:22 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8QDFM8953805350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2019 13:15:22 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 259682805A;
 Thu, 26 Sep 2019 13:15:22 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E80928058;
 Thu, 26 Sep 2019 13:15:20 +0000 (GMT)
Received: from [9.199.34.158] (unknown [9.199.34.158])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 26 Sep 2019 13:15:20 +0000 (GMT)
Subject: Re: [PATCH 1/2] mm/memunmap: Use the correct start and end pfn when
 removing pages from zone
To: David Hildenbrand <david@redhat.com>, dan.j.williams@intel.com,
 akpm@linux-foundation.org
References: <20190830091428.18399-1-david@redhat.com>
 <20190926122552.17905-1-aneesh.kumar@linux.ibm.com>
 <a9aaf327-2e36-618b-9ded-9800f3e6b73f@redhat.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <fcf2e9ee-c93b-8239-f165-0e92138faff0@linux.ibm.com>
Date: Thu, 26 Sep 2019 18:45:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a9aaf327-2e36-618b-9ded-9800f3e6b73f@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-26_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260123
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-mm@kvack.org, linux-nvdimm@lists.01.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/26/19 6:13 PM, David Hildenbrand wrote:
> On 26.09.19 14:25, Aneesh Kumar K.V wrote:
>> With altmap, all the resource pfns are not initialized. While initializing
>> pfn, altmap reserve space is skipped. Hence when removing pfn from zone skip
>> pfns that were never initialized.
>>
>> Update memunmap_pages to calculate start and end pfn based on altmap
>> values. This fixes a kernel crash that is observed when destroying namespace.
>>
>> [   74.745056] BUG: Unable to handle kernel data access at 0xc00c000001400000
>> [   74.745256] Faulting instruction address: 0xc0000000000b58b0
>> cpu 0x2: Vector: 300 (Data Access) at [c00000026ea93580]
>>      pc: c0000000000b58b0: memset+0x68/0x104
>>      lr: c0000000003eb008: page_init_poison+0x38/0x50
>>      ...
>>    current = 0xc000000271c67d80
>>    paca    = 0xc00000003fffd680   irqmask: 0x03   irq_happened: 0x01
>>      pid   = 3665, comm = ndctl
>> [link register   ] c0000000003eb008 page_init_poison+0x38/0x50
>> [c00000026ea93830] c0000000004754d4 remove_pfn_range_from_zone+0x64/0x3e0
>> [c00000026ea938a0] c0000000004b8a60 memunmap_pages+0x300/0x400
>> [c00000026ea93930] c0000000009e32a0 devm_action_release+0x30/0x50
>> ...
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   mm/memremap.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index 390bb3544589..76b98110031e 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -113,7 +113,8 @@ static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
>>   void memunmap_pages(struct dev_pagemap *pgmap)
>>   {
>>   	struct resource *res = &pgmap->res;
>> -	unsigned long pfn = PHYS_PFN(res->start);
>> +	unsigned long start_pfn, end_pfn;
>> +	unsigned long pfn, nr_pages;
>>   	int nid;
>>   
>>   	dev_pagemap_kill(pgmap);
>> @@ -121,14 +122,18 @@ void memunmap_pages(struct dev_pagemap *pgmap)
>>   		put_page(pfn_to_page(pfn));
>>   	dev_pagemap_cleanup(pgmap);
>>   
>> +	start_pfn = pfn_first(pgmap);
>> +	end_pfn = pfn_end(pgmap);
>> +	nr_pages = end_pfn - start_pfn;
>> +
>>   	/* pages are dead and unused, undo the arch mapping */
>> -	nid = page_to_nid(pfn_to_page(pfn));
>> +	nid = page_to_nid(pfn_to_page(start_pfn));
>>   
>>   	mem_hotplug_begin();
>> -	remove_pfn_range_from_zone(page_zone(pfn_to_page(pfn)), pfn,
>> -				   PHYS_PFN(resource_size(res)));
>> +	remove_pfn_range_from_zone(page_zone(pfn_to_page(start_pfn)),
>> +				   start_pfn, nr_pages);
>>   	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
>> -		__remove_pages(pfn, PHYS_PFN(resource_size(res)), NULL);
>> +		__remove_pages(start_pfn, nr_pages, NULL);
>>   	} else {
>>   		arch_remove_memory(nid, res->start, resource_size(res),
>>   				pgmap_altmap(pgmap));
>>
> 
> Just to make sure, my patches did not break that, right (IOW, broken
> upstream)?
> 

That is correct. Your patches helped to remove other usages of wrong 
pfns. The last few left got fixed in this patch.

-aneesh
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
