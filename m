Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A733D2645E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 May 2019 15:12:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A04C2127676B;
	Wed, 22 May 2019 06:12:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DF0ED21250479
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 06:12:30 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4MCw7Xl145212
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 09:12:28 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2sn5qekywg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 09:12:28 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 22 May 2019 14:12:26 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 22 May 2019 14:12:23 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4MDCMti56098848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 May 2019 13:12:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21C1A42041;
 Wed, 22 May 2019 13:12:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9F3D42045;
 Wed, 22 May 2019 13:12:20 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.57.94])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 22 May 2019 13:12:20 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Keith Busch <keith.busch@intel.com>
Subject: Re: [RFC PATCH] mm/nvdimm: Fix kernel crash on
 devm_mremap_pages_release
In-Reply-To: <b775d65b-30e3-aceb-f2f8-f2413b129f52@linux.ibm.com>
References: <20190514025354.9108-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hsTvyRnLGr3y4JB6zPzdxb7WGQgaWs=5vRqf=L1DYynQ@mail.gmail.com>
 <b775d65b-30e3-aceb-f2f8-f2413b129f52@linux.ibm.com>
Date: Wed, 22 May 2019 18:42:19 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19052213-4275-0000-0000-000003376C43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052213-4276-0000-0000-00003847052A
Message-Id: <875zq2k4zw.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-22_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220095
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
Cc: Linux MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> On 5/14/19 9:45 AM, Dan Williams wrote:
>> [ add Keith who was looking at something similar ]
>> 

...

>>
>> If it's reserved then we should not be accessing, even if the above
>> works in practice. Isn't the fix something more like this to fix up
>> the assumptions at release time?
>> 
>> diff --git a/kernel/memremap.c b/kernel/memremap.c
>> index a856cb5ff192..9074ba14572c 100644
>> --- a/kernel/memremap.c
>> +++ b/kernel/memremap.c
>> @@ -90,6 +90,7 @@ static void devm_memremap_pages_release(void *data)
>>    struct device *dev = pgmap->dev;
>>    struct resource *res = &pgmap->res;
>>    resource_size_t align_start, align_size;
>> + struct vmem_altmap *altmap = pgmap->altmap_valid ? &pgmap->altmap : NULL;
>>    unsigned long pfn;
>>    int nid;
>> 
>> @@ -102,7 +103,10 @@ static void devm_memremap_pages_release(void *data)
>>    align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
>>    - align_start;
>> 
>> - nid = page_to_nid(pfn_to_page(align_start >> PAGE_SHIFT));
>> + pfn = align_start >> PAGE_SHIFT;
>> + if (altmap)
>> + pfn += vmem_altmap_offset(altmap);
>> + nid = page_to_nid(pfn_to_page(pfn));
>> 
>>    mem_hotplug_begin();
>>    if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
>> @@ -110,8 +114,7 @@ static void devm_memremap_pages_release(void *data)
>>    __remove_pages(page_zone(pfn_to_page(pfn)), pfn,
>>    align_size >> PAGE_SHIFT, NULL);
>>    } else {
>> - arch_remove_memory(nid, align_start, align_size,
>> - pgmap->altmap_valid ? &pgmap->altmap : NULL);
>> + arch_remove_memory(nid, align_start, align_size, altmap);
>>    kasan_remove_zero_shadow(__va(align_start), align_size);
>>    }
>>    mem_hotplug_done();
>> 
> I did try that first. I was not sure about that. From the memory add vs 
> remove perspective.
>
> devm_memremap_pages:
>
> align_start = res->start & ~(SECTION_SIZE - 1);
> align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
> 		- align_start;
> align_end = align_start + align_size - 1;
>
> error = arch_add_memory(nid, align_start, align_size, altmap,
> 				false);
>
>
> devm_memremap_pages_release:
>
> /* pages are dead and unused, undo the arch mapping */
> align_start = res->start & ~(SECTION_SIZE - 1);
> align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
> 		- align_start;
>
> arch_remove_memory(nid, align_start, align_size,
> 		pgmap->altmap_valid ? &pgmap->altmap : NULL);
>
>
> Now if we are fixing the memremap_pages_release, shouldn't we adjust 
> alig_start w.r.t memremap_pages too? and I was not sure what that means 
> w.r.t add/remove alignment requirements.
>
> What is the intended usage of reserve area? I guess we want that part to 
> be added? if so shouldn't we remove them?

We need to intialize the struct page backing the reserve area too right?
Where should we do that?

-aneesh

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
