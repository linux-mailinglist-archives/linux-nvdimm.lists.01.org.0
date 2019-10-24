Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0884E2CCF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Oct 2019 11:07:12 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84D96100EEB95;
	Thu, 24 Oct 2019 02:08:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3BD17100EEB94
	for <linux-nvdimm@lists.01.org>; Thu, 24 Oct 2019 02:08:30 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9O92Uto135178;
	Thu, 24 Oct 2019 05:07:05 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2vu848a6xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2019 05:07:04 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9O972xu002365;
	Thu, 24 Oct 2019 09:07:04 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by ppma04wdc.us.ibm.com with ESMTP id 2vqt47yhf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2019 09:07:04 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9O973EO47972814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2019 09:07:03 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 700547805C;
	Thu, 24 Oct 2019 09:07:03 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 950327805E;
	Thu, 24 Oct 2019 09:07:02 +0000 (GMT)
Received: from [9.124.35.127] (unknown [9.124.35.127])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2019 09:07:02 +0000 (GMT)
Subject: Re: [PATCH v3] libnvdimm/nsio: differentiate between probe mapping
 and runtime mapping
To: Dan Williams <dan.j.williams@intel.com>
References: <20191017073308.32645-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4ix9Ld6NgN=6u3yBJc1A81U-nkY3EFHjBUTMNoxAxth1g@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <49c98556-5c57-b8fc-ef50-fa0ed679e094@linux.ibm.com>
Date: Thu, 24 Oct 2019 14:37:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ix9Ld6NgN=6u3yBJc1A81U-nkY3EFHjBUTMNoxAxth1g@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240088
Message-ID-Hash: O3TWTURA6CJR5YA7JUFHYEILY4OPVTZC
X-Message-ID-Hash: O3TWTURA6CJR5YA7JUFHYEILY4OPVTZC
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O3TWTURA6CJR5YA7JUFHYEILY4OPVTZC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 10/24/19 7:36 AM, Dan Williams wrote:
> On Thu, Oct 17, 2019 at 12:33 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> nvdimm core currently maps the full namespace to an ioremap range
>> while probing the namespace mode. This can result in probe failures
>> on architectures that have limited ioremap space.
>>
>> For example, with a large btt namespace that consumes most of I/O remap
>> range, depending on the sequence of namespace initialization, the user can find
>> a pfn namespace initialization failure due to unavailable I/O remap space
>> which nvdimm core uses for temporary mapping.
>>
>> nvdimm core can avoid this failure by only mapping the reserver block area to
> 
> s/reserver/reserved/

Will fix


> 
>> check for pfn superblock type and map the full namespace resource only before
>> using the namespace.
> 
> Are you going to follow up with the BTT patch that uses this new facility?
> 

I am not yet sure about that. ioremap/vmap area is the way we get a 
kernel mapping without struct page backing. What we are suggesting hee 
is the ability to have a direct mapped mapping without struct page. I 
need to look at closely about what that imply.

>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>> Changes from v2:
>> * update changelog
>>
>> Changes from V1:
>> * update changelog
>> * update patch based on review feedback.
>>
>>   drivers/dax/pmem/core.c   |  2 +-
>>   drivers/nvdimm/claim.c    |  7 +++----
>>   drivers/nvdimm/nd.h       |  4 ++--
>>   drivers/nvdimm/pfn.h      |  6 ++++++
>>   drivers/nvdimm/pfn_devs.c |  5 -----
>>   drivers/nvdimm/pmem.c     | 15 ++++++++++++---
>>   6 files changed, 24 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
>> index 6eb6dfdf19bf..f174dbfbe1c4 100644
>> --- a/drivers/dax/pmem/core.c
>> +++ b/drivers/dax/pmem/core.c
>> @@ -28,7 +28,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
>>          nsio = to_nd_namespace_io(&ndns->dev);
>>
>>          /* parse the 'pfn' info block via ->rw_bytes */
>> -       rc = devm_nsio_enable(dev, nsio);
>> +       rc = devm_nsio_enable(dev, nsio, info_block_reserve());
>>          if (rc)
>>                  return ERR_PTR(rc);
>>          rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
>> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
>> index 2985ca949912..d89d2c039e25 100644
>> --- a/drivers/nvdimm/claim.c
>> +++ b/drivers/nvdimm/claim.c
>> @@ -300,12 +300,12 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
>>          return rc;
>>   }
>>
>> -int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
>> +int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio, unsigned long size)
>>   {
>>          struct resource *res = &nsio->res;
>>          struct nd_namespace_common *ndns = &nsio->common;
>>
>> -       nsio->size = resource_size(res);
>> +       nsio->size = size;
> 
> This needs a:
> 
> if (nsio->size)
>     devm_memunmap(dev, nsio->addr);


Why ? we should not be calling devm_nsio_enable twice now.

> 
> 
>>          if (!devm_request_mem_region(dev, res->start, resource_size(res),
>>                                  dev_name(&ndns->dev))) {
> 
> Also don't repeat the devm_request_mem_region() if one was already done.
> 
> Another thing to check is if nsio->size gets cleared when the
> namespace is disabled, if not that well need to be added in the
> shutdown path.
> 


Not sure I understand that. So with this patch when we probe we always 
use info_block_reserve() size irrespective of the device. This probe 
will result in us adding a btt/pfn/dax device and we return -ENXIO after 
this probe. This return value will cause us to destroy the I/O remap 
mmapping we did with info_block_reserve() size. Also the nsio data 
structure is also freed.

nd_pmem_probe is then again called with btt device type and in that case 
we do  devm_memremap again.

if (btt)
     remap the full namespace size.
else
    remap the info_block_reserve_size.


This infor block reserve mapping is unmapped in pmem_attach_disk()


Anything i am missing in the above flow?



> 
>>                  dev_warn(dev, "could not reserve region %pR\n", res);
>> @@ -318,8 +318,7 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
>>          nvdimm_badblocks_populate(to_nd_region(ndns->dev.parent), &nsio->bb,
>>                          &nsio->res);
>>
>> -       nsio->addr = devm_memremap(dev, res->start, resource_size(res),
>> -                       ARCH_MEMREMAP_PMEM);
>> +       nsio->addr = devm_memremap(dev, res->start, size, ARCH_MEMREMAP_PMEM);
>>
>>          return PTR_ERR_OR_ZERO(nsio->addr);
>>   }
>> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
>> index ee5c04070ef9..93d3c760c0f3 100644
>> --- a/drivers/nvdimm/nd.h
>> +++ b/drivers/nvdimm/nd.h
>> @@ -376,7 +376,7 @@ void nvdimm_badblocks_populate(struct nd_region *nd_region,
>>   #define MAX_STRUCT_PAGE_SIZE 64
>>
>>   int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
>> -int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio);
>> +int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio, unsigned long size);
>>   void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio);
>>   #else
>>   static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
>> @@ -385,7 +385,7 @@ static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
>>          return -ENXIO;
>>   }
>>   static inline int devm_nsio_enable(struct device *dev,
>> -               struct nd_namespace_io *nsio)
>> +               struct nd_namespace_io *nsio, unsigned long size)
>>   {
>>          return -ENXIO;
>>   }
>> diff --git a/drivers/nvdimm/pfn.h b/drivers/nvdimm/pfn.h
>> index acb19517f678..f4856c87d01c 100644
>> --- a/drivers/nvdimm/pfn.h
>> +++ b/drivers/nvdimm/pfn.h
>> @@ -36,4 +36,10 @@ struct nd_pfn_sb {
>>          __le64 checksum;
>>   };
>>
>> +static inline u32 info_block_reserve(void)
>> +{
>> +       return ALIGN(SZ_8K, PAGE_SIZE);
>> +}
>> +
>> +
>>   #endif /* __NVDIMM_PFN_H */
>> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
>> index 60d81fae06ee..e49aa9a0fd04 100644
>> --- a/drivers/nvdimm/pfn_devs.c
>> +++ b/drivers/nvdimm/pfn_devs.c
>> @@ -635,11 +635,6 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
>>   }
>>   EXPORT_SYMBOL(nd_pfn_probe);
>>
>> -static u32 info_block_reserve(void)
>> -{
>> -       return ALIGN(SZ_8K, PAGE_SIZE);
>> -}
>> -
>>   /*
>>    * We hotplug memory at sub-section granularity, pad the reserved area
>>    * from the previous section base to the namespace base address.
>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>> index f9f76f6ba07b..3c188ffeff11 100644
>> --- a/drivers/nvdimm/pmem.c
>> +++ b/drivers/nvdimm/pmem.c
>> @@ -491,17 +491,26 @@ static int pmem_attach_disk(struct device *dev,
>>   static int nd_pmem_probe(struct device *dev)
>>   {
>>          int ret;
>> +       struct nd_namespace_io *nsio;
>>          struct nd_namespace_common *ndns;
>>
>>          ndns = nvdimm_namespace_common_probe(dev);
>>          if (IS_ERR(ndns))
>>                  return PTR_ERR(ndns);
>>
>> -       if (devm_nsio_enable(dev, to_nd_namespace_io(&ndns->dev)))
>> -               return -ENXIO;
>> +       nsio = to_nd_namespace_io(&ndns->dev);
>>
>> -       if (is_nd_btt(dev))
>> +       if (is_nd_btt(dev)) {
>> +               /*
>> +                * Map with resource size
>> +                */
>> +               if (devm_nsio_enable(dev, nsio, resource_size(&nsio->res)))
>> +                       return -ENXIO;
>>                  return nvdimm_namespace_attach_btt(ndns);
>> +       }
>> +
>> +       if (devm_nsio_enable(dev, nsio, info_block_reserve()))
>> +               return -ENXIO;
>>
>>          if (is_nd_pfn(dev))
>>                  return pmem_attach_disk(dev, ndns);
>> --
>> 2.21.0
>>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
