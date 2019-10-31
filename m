Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD92EA9D2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 05:10:59 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 396B6100EA55B;
	Wed, 30 Oct 2019 21:11:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 19A61100EA554
	for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 21:11:25 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V47Cf5034282;
	Thu, 31 Oct 2019 00:10:52 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2vypg8u20g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2019 00:10:52 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
	by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9V4A5SE011295;
	Thu, 31 Oct 2019 04:10:51 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by ppma05wdc.us.ibm.com with ESMTP id 2vxwh63v23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2019 04:10:51 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9V4AoGO35193322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2019 04:10:50 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE620C605A;
	Thu, 31 Oct 2019 04:10:50 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F30E7C6057;
	Thu, 31 Oct 2019 04:10:49 +0000 (GMT)
Received: from [9.199.35.193] (unknown [9.199.35.193])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu, 31 Oct 2019 04:10:49 +0000 (GMT)
Subject: Re: [PATCH v3] libnvdimm/nsio: differentiate between probe mapping
 and runtime mapping
To: Dan Williams <dan.j.williams@intel.com>
References: <20191017073308.32645-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4ix9Ld6NgN=6u3yBJc1A81U-nkY3EFHjBUTMNoxAxth1g@mail.gmail.com>
 <49c98556-5c57-b8fc-ef50-fa0ed679e094@linux.ibm.com>
 <CAPcyv4i9SsPH-auGrS3qWPYEXzkDKtR7CjxN1eeocrwiWYcCxw@mail.gmail.com>
 <CAPcyv4g9bU+E6JuOT34gUjQGP4LBYg7w6Y+5ei5pxD3frFXcaw@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <f24ff341-95bf-4840-535a-d558b4f084f9@linux.ibm.com>
Date: Thu, 31 Oct 2019 09:40:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g9bU+E6JuOT34gUjQGP4LBYg7w6Y+5ei5pxD3frFXcaw@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310039
Message-ID-Hash: SU2PSWM2TOPHOPZOYIQ6IJVQKRB5JQKX
X-Message-ID-Hash: SU2PSWM2TOPHOPZOYIQ6IJVQKRB5JQKX
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SU2PSWM2TOPHOPZOYIQ6IJVQKRB5JQKX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 10/31/19 9:25 AM, Dan Williams wrote:
> On Wed, Oct 30, 2019 at 4:33 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> On Thu, Oct 24, 2019 at 2:07 AM Aneesh Kumar K.V
>> <aneesh.kumar@linux.ibm.com> wrote:
>>>
>>> On 10/24/19 7:36 AM, Dan Williams wrote:
>>>> On Thu, Oct 17, 2019 at 12:33 AM Aneesh Kumar K.V
>>>> <aneesh.kumar@linux.ibm.com> wrote:
>>>>>
>>>>> nvdimm core currently maps the full namespace to an ioremap range
>>>>> while probing the namespace mode. This can result in probe failures
>>>>> on architectures that have limited ioremap space.
>>>>>
>>>>> For example, with a large btt namespace that consumes most of I/O remap
>>>>> range, depending on the sequence of namespace initialization, the user can find
>>>>> a pfn namespace initialization failure due to unavailable I/O remap space
>>>>> which nvdimm core uses for temporary mapping.
>>>>>
>>>>> nvdimm core can avoid this failure by only mapping the reserver block area to
>>>>
>>>> s/reserver/reserved/
>>>
>>> Will fix
>>>
>>>
>>>>
>>>>> check for pfn superblock type and map the full namespace resource only before
>>>>> using the namespace.
>>>>
>>>> Are you going to follow up with the BTT patch that uses this new facility?
>>>>
>>>
>>> I am not yet sure about that. ioremap/vmap area is the way we get a
>>> kernel mapping without struct page backing. What we are suggesting hee
>>> is the ability to have a direct mapped mapping without struct page. I
>>> need to look at closely about what that imply.
>>>
>>>>>
>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>> ---
>>>>> Changes from v2:
>>>>> * update changelog
>>>>>
>>>>> Changes from V1:
>>>>> * update changelog
>>>>> * update patch based on review feedback.
>>>>>
>>>>>    drivers/dax/pmem/core.c   |  2 +-
>>>>>    drivers/nvdimm/claim.c    |  7 +++----
>>>>>    drivers/nvdimm/nd.h       |  4 ++--
>>>>>    drivers/nvdimm/pfn.h      |  6 ++++++
>>>>>    drivers/nvdimm/pfn_devs.c |  5 -----
>>>>>    drivers/nvdimm/pmem.c     | 15 ++++++++++++---
>>>>>    6 files changed, 24 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
>>>>> index 6eb6dfdf19bf..f174dbfbe1c4 100644
>>>>> --- a/drivers/dax/pmem/core.c
>>>>> +++ b/drivers/dax/pmem/core.c
>>>>> @@ -28,7 +28,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
>>>>>           nsio = to_nd_namespace_io(&ndns->dev);
>>>>>
>>>>>           /* parse the 'pfn' info block via ->rw_bytes */
>>>>> -       rc = devm_nsio_enable(dev, nsio);
>>>>> +       rc = devm_nsio_enable(dev, nsio, info_block_reserve());
>>>>>           if (rc)
>>>>>                   return ERR_PTR(rc);
>>>>>           rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
>>>>> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
>>>>> index 2985ca949912..d89d2c039e25 100644
>>>>> --- a/drivers/nvdimm/claim.c
>>>>> +++ b/drivers/nvdimm/claim.c
>>>>> @@ -300,12 +300,12 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
>>>>>           return rc;
>>>>>    }
>>>>>
>>>>> -int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
>>>>> +int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio, unsigned long size)
>>>>>    {
>>>>>           struct resource *res = &nsio->res;
>>>>>           struct nd_namespace_common *ndns = &nsio->common;
>>>>>
>>>>> -       nsio->size = resource_size(res);
>>>>> +       nsio->size = size;
>>>>
>>>> This needs a:
>>>>
>>>> if (nsio->size)
>>>>      devm_memunmap(dev, nsio->addr);
>>>
>>>
>>> Why ? we should not be calling devm_nsio_enable twice now.
>>>
>>>>
>>>>
>>>>>           if (!devm_request_mem_region(dev, res->start, resource_size(res),
>>>>>                                   dev_name(&ndns->dev))) {
>>>>
>>>> Also don't repeat the devm_request_mem_region() if one was already done.
>>>>
>>>> Another thing to check is if nsio->size gets cleared when the
>>>> namespace is disabled, if not that well need to be added in the
>>>> shutdown path.
>>>>
>>>
>>>
>>> Not sure I understand that. So with this patch when we probe we always
>>> use info_block_reserve() size irrespective of the device. This probe
>>> will result in us adding a btt/pfn/dax device and we return -ENXIO after
>>> this probe. This return value will cause us to destroy the I/O remap
>>> mmapping we did with info_block_reserve() size. Also the nsio data
>>> structure is also freed.
>>>
>>> nd_pmem_probe is then again called with btt device type and in that case
>>> we do  devm_memremap again.
>>>
>>> if (btt)
>>>       remap the full namespace size.
>>> else
>>>      remap the info_block_reserve_size.
>>>
>>>
>>> This infor block reserve mapping is unmapped in pmem_attach_disk()
>>>
>>>
>>> Anything i am missing in the above flow?
>>
>> Oh no, you're right, this does make the implementation only call
>> devm_nsio_enable() once. However, now that I look I want to suggest
>> some small reorganizations of where devm_nsio_enable() is called. I'll
>> take a stab at folding some changes on top of your patch.
> 
> This change is causing the "pfn-meta-errors.sh" test to fail. It is
> due to the fact the info_block_reserve() is not a sufficient
> reservation for errors in the page metadata area.
> 

Can you share the call stack? we clear bad blocks on write isn't? and we 
do only read while probing?

We are still working on enabling `ndctl test` to run on POWER. Hence was 
not able capture these issues. Will try to get that resolved soon.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
