Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA62B159259
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Feb 2020 15:56:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE54A1007A82E;
	Tue, 11 Feb 2020 06:59:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 30A8B1007A82C
	for <linux-nvdimm@lists.01.org>; Tue, 11 Feb 2020 06:59:55 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BEnW4j189416
	for <linux-nvdimm@lists.01.org>; Tue, 11 Feb 2020 09:56:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y1uckc582-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 11 Feb 2020 09:56:36 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
	Tue, 11 Feb 2020 14:56:06 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 11 Feb 2020 14:56:05 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01BEt9nI42467612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2020 14:55:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E460852059;
	Tue, 11 Feb 2020 14:56:03 +0000 (GMT)
Received: from [9.199.40.165] (unknown [9.199.40.165])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9E28E52054;
	Tue, 11 Feb 2020 14:55:53 +0000 (GMT)
Subject: Re: [PATCH v2] libnvdimm: Update persistence domain value for of_pmem
 and papr_scm device
To: Dan Williams <dan.j.williams@intel.com>
References: <20200205052056.74604-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hBAk-dwO4=AT7cQm5YUwCBg0AECsZsiCjRJ_ZGWvWUAw@mail.gmail.com>
 <87y2ta8qy7.fsf@linux.ibm.com>
 <CAPcyv4hNV88FJybgoRyM=JuKgrwYaf+CLWfFWt5X3yFMrecU=Q@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 11 Feb 2020 20:25:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hNV88FJybgoRyM=JuKgrwYaf+CLWfFWt5X3yFMrecU=Q@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20021114-0008-0000-0000-00000351E8F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021114-0009-0000-0000-00004A728A8E
Message-Id: <25eabdd9-410f-e4c3-6b0e-41a5e6daba10@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_04:2020-02-10,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110111
Message-ID-Hash: VTZGOECZWNGAVPAJMXIR7EGJTZEAQYRF
X-Message-ID-Hash: VTZGOECZWNGAVPAJMXIR7EGJTZEAQYRF
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VTZGOECZWNGAVPAJMXIR7EGJTZEAQYRF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 2/10/20 11:48 PM, Dan Williams wrote:
> On Mon, Feb 10, 2020 at 6:20 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>>> On Tue, Feb 4, 2020 at 9:21 PM Aneesh Kumar K.V
>>> <aneesh.kumar@linux.ibm.com> wrote:
>>>>
>>>> Currently, kernel shows the below values
>>>>          "persistence_domain":"cpu_cache"
>>>>          "persistence_domain":"memory_controller"
>>>>          "persistence_domain":"unknown"
>>>>
>>>> "cpu_cache" indicates no extra instructions is needed to ensure the persistence
>>>> of data in the pmem media on power failure.
>>>>
>>>> "memory_controller" indicates platform provided instructions need to be issued
>>>
>>> No, it does not. The only requirement implied by "memory_controller"
>>> is global visibility outside the cpu cache. If there are special
>>> instructions beyond that then it isn't persistent memory, at least not
>>> pmem that is safe for dax. virtio-pmem is an example of pmem-like
>>> memory that is not enabled for userspace flushing (MAP_SYNC disabled).
>>>
>>
>> Can you explain this more? The way I was expecting the application to
>> interpret the value was, a regular store instruction doesn't guarantee
>> persistence if you find the "memory_controller" value for
>> persistence_domain. Instead, we need to make sure we flush data to the
>> controller at which point the platform will take care of the persistence in
>> case of power loss. How we flush data to the controller will also be
>> defined by the platform.
> 
> If the platform requires any flush mechanism outside of the base cpu
> ISA of cache flushes and memory barriers then MAP_SYNC needs to be
> explicitly disabled to force the application to call fsync()/msync().
> Then those platform specific mechanisms need to be triggered through a
> platform-aware driver.
> 


Agreed. I was thinking we mark the persistence_domain: "Unknown" in that 
case. virtio-pmem mark it that way.


>>
>>
>>>> as per documented sequence to make sure data get flushed so that it is
>>>> guaranteed to be on pmem media in case of system power loss.
>>>>
>>>> Based on the above use memory_controller for non volatile regions on ppc64.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>   arch/powerpc/platforms/pseries/papr_scm.c | 7 ++++++-
>>>>   drivers/nvdimm/of_pmem.c                  | 4 +++-
>>>>   include/linux/libnvdimm.h                 | 1 -
>>>>   3 files changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>>>> index 7525635a8536..ffcd0d7a867c 100644
>>>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>>>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>>>> @@ -359,8 +359,13 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>>>
>>>>          if (p->is_volatile)
>>>>                  p->region = nvdimm_volatile_region_create(p->bus, &ndr_desc);
>>>> -       else
>>>> +       else {
>>>> +               /*
>>>> +                * We need to flush things correctly to guarantee persistance
>>>> +                */
>>>
>>> There are never guarantees. If you're going to comment what does
>>> software need to flush, and how?
>>
>> Can you explain why you say there are never guarantees? If you follow the platform
>> recommended instruction sequence to flush data, we can be sure of data
>> persistence in the pmem media.
> 
> Because storage can always fail. You can reduce risk, but never
> eliminate it. This is similar to SSDs that use latent capacitance to
> flush their write caches on driver power loss. Even if the application
> successfully flushes its writes to buffers that are protected by that
> capacitance that power source can still (and in practice does) fail.
> 

ok guarantee is not the right term there. Can we say

/* We need to flush tings correctly to ensure persistence */


What I was trying to understand/clarify was the detail an application 
can infer looking at the value of persistence_domain ?

Do you agree that below can be inferred from the "memory_controller" 
value of persistence_domain

1) Application needs to use cache flush instructions and that ensures 
data is persistent across power failure.


Or are you suggesting that application should not infer any of those 
details looking at persistence_domain value? If so what is the purpose 
of exporting that attribute?


>>
>>
>>>
>>>> +               set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
>>>>                  p->region = nvdimm_pmem_region_create(p->bus, &ndr_desc);
>>>> +       }
>>>>          if (!p->region) {
>>>>                  dev_err(dev, "Error registering region %pR from %pOF\n",
>>>>                                  ndr_desc.res, p->dn);
>>>> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
>>>> index 8224d1431ea9..6826a274a1f1 100644
>>>> --- a/drivers/nvdimm/of_pmem.c
>>>> +++ b/drivers/nvdimm/of_pmem.c
>>>> @@ -62,8 +62,10 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>>>>
>>>>                  if (is_volatile)
>>>>                          region = nvdimm_volatile_region_create(bus, &ndr_desc);
>>>> -               else
>>>> +               else {
>>>> +                       set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
>>>>                          region = nvdimm_pmem_region_create(bus, &ndr_desc);
>>>> +               }
>>>>
>>>>                  if (!region)
>>>>                          dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
>>>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>>>> index 0f366706b0aa..771d888a5ed7 100644
>>>> --- a/include/linux/libnvdimm.h
>>>> +++ b/include/linux/libnvdimm.h
>>>> @@ -54,7 +54,6 @@ enum {
>>>>          /*
>>>>           * Platform provides mechanisms to automatically flush outstanding
>>>>           * write data from memory controler to pmem on system power loss.
>>>> -        * (ADR)
>>>
>>> I'd rather not delete critical terminology for a developer / platform
>>> owner to be able to consult documentation, or their vendor. Can you
>>> instead add the PowerPC equivalent term for this capability? I.e. list
>>> (x86: ADR PowerPC: foo ...).
>>
>> Power ISA doesn't clearly call out what mechanism will be used to ensure
>> that a load following power loss will return the previously flushed
>> data. Hence there is no description of details like Asynchronous DRAM
>> Refresh. Only details specified is with respect to flush sequence that ensures
>> that a load following power loss will return the value stored.
> 
> What is this "flush sequence"?
> 

cpu cache flush instructions "dcbf; hwsync"

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
