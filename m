Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF24C046E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 27 Sep 2019 13:35:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2958B21967BC5;
	Fri, 27 Sep 2019 04:37:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A36572010B7E4
 for <linux-nvdimm@lists.01.org>; Fri, 27 Sep 2019 04:37:27 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8RBWJ2m076943; Fri, 27 Sep 2019 07:35:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v9gjfa8cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2019 07:35:22 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8RBWL1k077146;
 Fri, 27 Sep 2019 07:35:22 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v9gjfa8cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2019 07:35:21 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8RBYPGd026387;
 Fri, 27 Sep 2019 11:35:21 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02dal.us.ibm.com with ESMTP id 2v5bg8dfxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2019 11:35:21 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8RBZK4n47841602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2019 11:35:20 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60124AE05C;
 Fri, 27 Sep 2019 11:35:20 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A203AE05F;
 Fri, 27 Sep 2019 11:35:18 +0000 (GMT)
Received: from [9.199.46.246] (unknown [9.199.46.246])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 27 Sep 2019 11:35:18 +0000 (GMT)
Subject: Re: [PATCH 1/2] mm/memunmap: Use the correct start and end pfn when
 removing pages from zone
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20190830091428.18399-1-david@redhat.com>
 <20190926122552.17905-1-aneesh.kumar@linux.ibm.com>
 <20190926154508.3dba3dc398b7bb9a40ba15da@linux-foundation.org>
 <894daaaf-ce64-c2d8-d246-5d4c5f42579d@linux.ibm.com>
 <e3217688-0f58-f922-01d4-f19001bb23ad@redhat.com>
 <dbaec657-db02-d721-0288-c8b8b727153d@linux.ibm.com>
 <59f15b2c-752b-68b1-30bd-f25386737a59@redhat.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <28ef81f4-13dc-db4c-f911-c4eb8be575cb@linux.ibm.com>
Date: Fri, 27 Sep 2019 17:05:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <59f15b2c-752b-68b1-30bd-f25386737a59@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-27_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270109
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

On 9/27/19 4:10 PM, David Hildenbrand wrote:
> On 27.09.19 12:36, Aneesh Kumar K.V wrote:
>> On 9/27/19 1:16 PM, David Hildenbrand wrote:
>>> On 27.09.19 03:51, Aneesh Kumar K.V wrote:
>>>> On 9/27/19 4:15 AM, Andrew Morton wrote:
>>>>> On Thu, 26 Sep 2019 17:55:51 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>>>>>
>>>>>> With altmap, all the resource pfns are not initialized. While initializing
>>>>>> pfn, altmap reserve space is skipped. Hence when removing pfn from zone skip
>>>>>> pfns that were never initialized.
>>>>>>
>>>>>> Update memunmap_pages to calculate start and end pfn based on altmap
>>>>>> values. This fixes a kernel crash that is observed when destroying namespace.
>>>>>>
>>>>>> [   74.745056] BUG: Unable to handle kernel data access at 0xc00c000001400000
>>>>>> [   74.745256] Faulting instruction address: 0xc0000000000b58b0
>>>>>> cpu 0x2: Vector: 300 (Data Access) at [c00000026ea93580]
>>>>>>        pc: c0000000000b58b0: memset+0x68/0x104
>>>>>>        lr: c0000000003eb008: page_init_poison+0x38/0x50
>>>>>>        ...
>>>>>>      current = 0xc000000271c67d80
>>>>>>      paca    = 0xc00000003fffd680   irqmask: 0x03   irq_happened: 0x01
>>>>>>        pid   = 3665, comm = ndctl
>>>>>> [link register   ] c0000000003eb008 page_init_poison+0x38/0x50
>>>>>> [c00000026ea93830] c0000000004754d4 remove_pfn_range_from_zone+0x64/0x3e0
>>>>>> [c00000026ea938a0] c0000000004b8a60 memunmap_pages+0x300/0x400
>>>>>> [c00000026ea93930] c0000000009e32a0 devm_action_release+0x30/0x50
>>>>>
>>>>> Doesn't apply to mainline or -next.  Which tree is this against?
>>>>>
>>>>
>>>> After applying the patches from David on mainline. That is the reason I
>>>> replied to this thread. I should have mentioned in the email that it is
>>>> based on patch series "[PATCH v4 0/8] mm/memory_hotplug: Shrink zones
>>>> before removing memory"
>>>
>>> So if I am not wrong, my patch "[PATCH v4 4/8] mm/memory_hotplug: Poison
>>> memmap in remove_pfn_range_from_zone()" makes it show up that we
>>> actually call _remove_pages() with wrong parameters, right?
>>>
>>> If so, I guess it would be better for you to fix it before my series and
>>> I will rebase my series on top of that.
>>>
>>
>> I posted a patch that can be applied to mainline. I sent that as a reply
>> to this email. Can you include that and PATCH 2 as first two patches in
>> your series?  That should help to locate the full patch series needed
>> for fixing the kernel crash.
> 
> I can drag these along, unless Andrew wants to pick them up right away
> (or we're waiting for more feedback).

Considering this patch alone won't fix the issue, It would be nice if we 
could club them with rest of the changes.

> 
> Is there a Fixes: Tag we can add to the first patch?
> 

IIUC this was always broken.

-aneesh
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
