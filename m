Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7F10FB79
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 11:13:16 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B0435101134EA;
	Tue,  3 Dec 2019 02:16:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 583D7101134E9
	for <linux-nvdimm@lists.01.org>; Tue,  3 Dec 2019 02:16:34 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3ACpDe101328;
	Tue, 3 Dec 2019 05:13:08 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2wkrj5fw2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2019 05:13:04 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB3AAk1m002096;
	Tue, 3 Dec 2019 10:12:31 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by ppma04wdc.us.ibm.com with ESMTP id 2wkg26jxv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2019 10:12:31 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB3ACUCA30408980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2019 10:12:30 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E684AE05C;
	Tue,  3 Dec 2019 10:12:30 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 724D2AE05F;
	Tue,  3 Dec 2019 10:12:29 +0000 (GMT)
Received: from [9.124.35.21] (unknown [9.124.35.21])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2019 10:12:29 +0000 (GMT)
Subject: Re: [PATCH v6] mm/pgmap: Use correct alignment when looking at first
 pfn from a region
To: Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190917153129.12905-1-aneesh.kumar@linux.ibm.com>
 <20190919122501.df660f0d23806a3f46d11b61@linux-foundation.org>
 <8736glowyh.fsf@linux.ibm.com>
 <20191130151317.26c69ef711dba28ff642cca3@linux-foundation.org>
 <CAPcyv4i_ZsSKpYADbT46_9ab3GuRf=z3DzVCjkSdswF8PgG4dg@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <f7a1b3f7-bfbb-e13c-7e8b-c76316bae8e4@linux.ibm.com>
Date: Tue, 3 Dec 2019 15:42:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i_ZsSKpYADbT46_9ab3GuRf=z3DzVCjkSdswF8PgG4dg@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_02:2019-11-29,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030082
Message-ID-Hash: BYV5S5KYO2T2IJLKDYFPB7FVD6TRGNH2
X-Message-ID-Hash: BYV5S5KYO2T2IJLKDYFPB7FVD6TRGNH2
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BYV5S5KYO2T2IJLKDYFPB7FVD6TRGNH2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/3/19 6:20 AM, Dan Williams wrote:
> On Sat, Nov 30, 2019 at 3:13 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Wed, 25 Sep 2019 09:21:02 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>>
>>> Andrew Morton <akpm@linux-foundation.org> writes:
>>>
>>>> On Tue, 17 Sep 2019 21:01:29 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>>>>
>>>>> vmem_altmap_offset() adjust the section aligned base_pfn offset.
>>>>> So we need to make sure we account for the same when computing base_pfn.
>>>>>
>>>>> ie, for altmap_valid case, our pfn_first should be:
>>>>>
>>>>> pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);
>>>>
>>>> What are the user-visible runtime effects of this change?
>>>
>>> This was found by code inspection. If the pmem region is not correctly
>>> section aligned we can skip pfns while iterating device pfn using
>>>        for_each_device_pfn(pfn, pgmap)
>>>
>>>
>>> I still would want Dan to ack the change though.
>>>
>>
>> Dan?
>>
>>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
>> Subject: mm/pgmap: use correct alignment when looking at first pfn from a region
>>
>> vmem_altmap_offset() adjusts the section aligned base_pfn offset.  So we
>> need to make sure we account for the same when computing base_pfn.
>>
>> ie, for altmap_valid case, our pfn_first should be:
>>
>> pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);
>>
>> This was found by code inspection. If the pmem region is not correctly
>> section aligned we can skip pfns while iterating device pfn using
>>
>>          for_each_device_pfn(pfn, pgmap)
>>
>> [akpm@linux-foundation.org: coding style fixes]
>> Link: http://lkml.kernel.org/r/20190917153129.12905-1-aneesh.kumar@linux.ibm.com
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>   mm/memremap.c |   12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> --- a/mm/memremap.c~mm-pgmap-use-correct-alignment-when-looking-at-first-pfn-from-a-region
>> +++ a/mm/memremap.c
>> @@ -55,8 +55,16 @@ static void pgmap_array_delete(struct re
>>
>>   static unsigned long pfn_first(struct dev_pagemap *pgmap)
>>   {
>> -       return PHYS_PFN(pgmap->res.start) +
>> -               vmem_altmap_offset(pgmap_altmap(pgmap));
>> +       const struct resource *res = &pgmap->res;
>> +       struct vmem_altmap *altmap = pgmap_altmap(pgmap);
>> +       unsigned long pfn;
>> +
>> +       if (altmap)
>> +               pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
>> +       else
>> +               pfn = PHYS_PFN(res->start);
> 
> This would only be a problem if res->start is not subsection aligned.

Kernel is not enforcing this right? ie, If i create multiple namespace
as below

ndctl create-namespace -s 16908288 --align 64K

I can get base_pfn different from res->start PHYS_PFN

Yes that results in other error as below with the current upstream.

[   17.491097] memory add fail, invalid altmap



> Is that bug triggering in your case, or is this just inspection. Now
> that the subsections can be assumed as the minimum mapping granularity
> I'd rather see a cleanup  I'd rather cleanup the implementation to
> eliminate altmap->base_pfn or at least assert that
> PHYS_PFN(res->start) and altmap->base_pfn are always identical.
> 
> Otherwise ->base_pfn is supposed to be just a convenient way to recall
> the bounds of the memory hotplug operation deeper in the vmemmap
> setup.
> 

Is the right fix to ensure that we always make sure res->start is 
subsection aligned ? If so we may need the patch series
https://patchwork.kernel.org/project/linux-nvdimm/list/?series=209373

And enforce that to be multiple of subsection size?

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
