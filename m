Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D1FA982E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 03:57:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CA31E21962301;
	Wed,  4 Sep 2019 18:58:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 151EE20260CF5
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 18:58:04 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x851qIt1057489; Wed, 4 Sep 2019 21:56:59 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2utkrvjkpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Sep 2019 21:56:59 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x851t3J0026844;
 Thu, 5 Sep 2019 01:56:57 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma02wdc.us.ibm.com with ESMTP id 2uqgh75gu0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Sep 2019 01:56:57 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x851uvrr50200966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Sep 2019 01:56:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59557B205F;
 Thu,  5 Sep 2019 01:56:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D259B2065;
 Thu,  5 Sep 2019 01:56:56 +0000 (GMT)
Received: from [9.199.35.243] (unknown [9.199.35.243])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  5 Sep 2019 01:56:55 +0000 (GMT)
Subject: Re: [PATCH v8] libnvdimm/dax: Pick the right alignment default when
 creating dax devices
To: Dan Williams <dan.j.williams@intel.com>
References: <20190904065320.6005-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hD8SAFNNAWBP9q55wdPf-HYTEjpS4m+rT0VPoGodZULw@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <33b377ac-86ea-b195-fd83-90c01df604cc@linux.ibm.com>
Date: Thu, 5 Sep 2019 07:26:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hD8SAFNNAWBP9q55wdPf-HYTEjpS4m+rT0VPoGodZULw@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-05_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050018
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
Cc: Linux MM <linux-mm@kvack.org>, "Kirill A . Shutemov" <kirill@shutemov.name>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/5/19 3:41 AM, Dan Williams wrote:
> On Tue, Sep 3, 2019 at 11:53 PM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> Allow arch to provide the supported alignments and use hugepage alignment only
>> if we support hugepage. Right now we depend on compile time configs whereas this
>> patch switch this to runtime discovery.
>>
>> Architectures like ppc64 can have THP enabled in code, but then can have
>> hugepage size disabled by the hypervisor. This allows us to create dax devices
>> with PAGE_SIZE alignment in this case.
>>
>> Existing dax namespace with alignment larger than PAGE_SIZE will fail to
>> initialize in this specific case. We still allow fsdax namespace initialization.
>>
>> With respect to identifying whether to enable hugepage fault for a dax device,
>> if THP is enabled during compile, we default to taking hugepage fault and in dax
>> fault handler if we find the fault size > alignment we retry with PAGE_SIZE
>> fault size.
>>
>> This also addresses the below failure scenario on ppc64
>>
>> ndctl create-namespace --mode=devdax  | grep align
>>   "align":16777216,
>>   "align":16777216
>>
>> cat /sys/devices/ndbus0/region0/dax0.0/supported_alignments
>>   65536 16777216
>>
>> daxio.static-debug  -z -o /dev/dax0.0
>>    Bus error (core dumped)
>>
>>    $ dmesg | tail
>>     lpar: Failed hash pte insert with error -4
>>     hash-mmu: mm: Hashing failure ! EA=0x7fff17000000 access=0x8000000000000006 current=daxio
>>     hash-mmu:     trap=0x300 vsid=0x22cb7a3 ssize=1 base psize=2 psize 10 pte=0xc000000501002b86
>>     daxio[3860]: bus error (7) at 7fff17000000 nip 7fff973c007c lr 7fff973bff34 code 2 in libpmem.so.1.0.0[7fff973b0000+20000]
>>     daxio[3860]: code: 792945e4 7d494b78 e95f0098 7d494b78 f93f00a0 4800012c e93f0088 f93f0120
>>     daxio[3860]: code: e93f00a0 f93f0128 e93f0120 e95f0128 <f9490000> e93f0088 39290008 f93f0110
>>
>> The failure was due to guest kernel using wrong page size.
>>
>> The namespaces created with 16M alignment will appear as below on a config with
>> 16M page size disabled.
>>
>> $ ndctl list -Ni
>> [
>>    {
>>      "dev":"namespace0.1",
>>      "mode":"fsdax",
>>      "map":"dev",
>>      "size":5351931904,
>>      "uuid":"fc6e9667-461a-4718-82b4-69b24570bddb",
>>      "align":16777216,
>>      "blockdev":"pmem0.1",
>>      "supported_alignments":[
>>        65536
>>      ]
>>    },
>>    {
>>      "dev":"namespace0.0",
>>      "mode":"fsdax",    <==== devdax 16M alignment marked disabled.
>>      "map":"mem",
>>      "size":5368709120,
>>      "uuid":"a4bdf81a-f2ee-4bc6-91db-7b87eddd0484",
>>      "state":"disabled"
>>    }
>> ]
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   drivers/nvdimm/nd.h       |  6 ----
>>   drivers/nvdimm/pfn_devs.c | 69 +++++++++++++++++++++++++++++----------
>>   include/linux/huge_mm.h   |  8 ++++-
>>   3 files changed, 59 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
>> index e89af4b2d8e9..401a78b02116 100644
>> --- a/drivers/nvdimm/nd.h
>> +++ b/drivers/nvdimm/nd.h
>> @@ -289,12 +289,6 @@ static inline struct device *nd_btt_create(struct nd_region *nd_region)
>>   struct nd_pfn *to_nd_pfn(struct device *dev);
>>   #if IS_ENABLED(CONFIG_NVDIMM_PFN)
>>
>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -#define PFN_DEFAULT_ALIGNMENT HPAGE_PMD_SIZE
>> -#else
>> -#define PFN_DEFAULT_ALIGNMENT PAGE_SIZE
>> -#endif
>> -
>>   int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns);
>>   bool is_nd_pfn(struct device *dev);
>>   struct device *nd_pfn_create(struct nd_region *nd_region);
>> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
>> index ce9ef18282dd..4cb240b3d5b0 100644
>> --- a/drivers/nvdimm/pfn_devs.c
>> +++ b/drivers/nvdimm/pfn_devs.c
>> @@ -103,27 +103,36 @@ static ssize_t align_show(struct device *dev,
>>          return sprintf(buf, "%ld\n", nd_pfn->align);
>>   }
>>
>> -static const unsigned long *nd_pfn_supported_alignments(void)
>> +const unsigned long *nd_pfn_defining a supported_alignments(void)
> 
> Keep this 'static' there's no usage of this routine outside of pfn_devs.c
> 
>>   {
>> -       /*
>> -        * This needs to be a non-static variable because the *_SIZE
>> -        * macros aren't always constants.
>> -        */
>> -       const unsigned long supported_alignments[] = {
>> -               PAGE_SIZE,
>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -               HPAGE_PMD_SIZE,
>> +       static unsigned long supported_alignments[3];
> 
> Why is marked static? It's being dynamically populated each invocation
> so static is just wasting space in the .data section.
> 

The return of that function is address and that would require me to use 
a global variable. I could add a check

/* Check if initialized */
  if (supported_alignment[1])
	return supported_alignment;

in the function to updating that array every time called.

>> +
>> +       supported_alignments[0] = PAGE_SIZE;
>> +
>> +       if (has_transparent_hugepage()) {
>> +
>> +               supported_alignments[1] = HPAGE_PMD_SIZE;
>> +
>>   #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>> -               HPAGE_PUD_SIZE,
>> -#endif
>> +               supported_alignments[2] = HPAGE_PUD_SIZE;
>>   #endif
> 
> This ifdef could be hidden in by:
> 
> if IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> 
> ...or otherwise moving this to header file with something like
> NVDIMM_PUD_SIZE that is optionally 0 or HPAGE_PUD_SIZE depending on
> the config


I can switch to if IS_ENABLED but i am not sure that make it any 
different in the current code. So I will keep it same?

NVDIMM_PUD_SIZE is an indirection I find confusing.



> 
>> -               0,
>> -       };
>> -       static unsigned long data[ARRAY_SIZE(supported_alignments)];
>> +       } else {
>> +               supported_alignments[1] = 0;
>> +               supported_alignments[2] = 0;
>> +       }
>>
>> -       memcpy(data, supported_alignments, sizeof(data));
>> +       return supported_alignments;
>> +}
>> +
>> +/*
>> + * Use pmd mapping if supported as default alignment
>> + */
>> +unsigned long nd_pfn_default_alignment(void)
>> +{
>>
>> -       return data;
>> +       if (has_transparent_hugepage())
>> +               return HPAGE_PMD_SIZE;
>> +       return PAGE_SIZE;
>>   }
>>
>>   static ssize_t align_store(struct device *dev,
>> @@ -302,7 +311,7 @@ struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
>>                  return NULL;
>>
>>          nd_pfn->mode = PFN_MODE_NONE;
>> -       nd_pfn->align = PFN_DEFAULT_ALIGNMENT;
>> +       nd_pfn->align = nd_pfn_default_alignment();
>>          dev = &nd_pfn->dev;
>>          device_initialize(&nd_pfn->dev);
>>          if (ndns && !__nd_attach_ndns(&nd_pfn->dev, ndns, &nd_pfn->ndns)) {
>> @@ -412,6 +421,20 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
>>          return 0;
>>   }
>>
>> +static bool nd_supported_alignment(unsigned long align)
>> +{
>> +       int i;
>> +       const unsigned long *supported = nd_pfn_supported_alignments();
>> +
>> +       if (align == 0)
>> +               return false;
>> +
>> +       for (i = 0; supported[i]; i++)
>> +               if (align == supported[i])
>> +                       return true;
>> +       return false;
>> +}
>> +
>>   /**
>>    * nd_pfn_validate - read and validate info-block
>>    * @nd_pfn: fsdax namespace runtime state / properties
>> @@ -496,6 +519,18 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>>                  return -EOPNOTSUPP;
>>          }
>>
>> +       /*
>> +        * Check whether the we support the alignment. For Dax if the
>> +        * superblock alignment is not matching, we won't initialize
>> +        * the device.
>> +        */
>> +       if (!nd_supported_alignment(align) &&
>> +                       !memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN)) {
>> +               dev_err(&nd_pfn->dev, "init failed, alignment mismatch: "
>> +                               "%ld:%ld\n", nd_pfn->align, align);
>> +               return -EOPNOTSUPP;
>> +       }
>> +
>>          if (!nd_pfn->uuid) {
>>                  /*
>>                   * When probing a namepace via nd_pfn_probe() the uuid
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 45ede62aa85b..36708c43ef8e 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -108,7 +108,13 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>>
>>          if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>>                  return true;
>> -
>> +       /*
>> +        * For dax let's try to do hugepage fault always. If the kernel doesn't
>> +        * support hugepages, namespaces with hugepage alignment will not be
>> +        * enabled. For namespace with PAGE_SIZE alignment, we try to handle
>> +        * hugepage fault but will fallback to PAGE_SIZE via the check in
>> +        * __dev_dax_pmd_fault
> 
> Ok, this is better, but I think it can be clarified further.
> 
> "For dax vmas, try to always use hugepage mappings. If the kernel does
> not support hugepages, fsdax mappings will fallback to PAGE_SIZE
> mappings, and device-dax namespaces, that try to guarantee a given
> mapping size, will fail to enable."
> 
> The last sentence about PAGE_SIZE namespaces is not relevant to
> __transparent_hugepage_enabled(), it's an internal implementation
> detail of the device-dax driver.
> 

I will use the above update.

-aneesh


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
