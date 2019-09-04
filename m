Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A728A7AA7
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 07:18:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DEB692021DD3B;
	Tue,  3 Sep 2019 22:19:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 251C82021B71E
 for <linux-nvdimm@lists.01.org>; Tue,  3 Sep 2019 22:19:10 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x845GsBd087573; Wed, 4 Sep 2019 01:18:00 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ut0m60x8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Sep 2019 01:18:00 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x845FJW7026362;
 Wed, 4 Sep 2019 05:17:59 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma02dal.us.ibm.com with ESMTP id 2uqgh74rbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Sep 2019 05:17:59 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x845HwFQ61473036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Sep 2019 05:17:58 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50FE36A04D;
 Wed,  4 Sep 2019 05:17:58 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 353A26A04F;
 Wed,  4 Sep 2019 05:17:57 +0000 (GMT)
Received: from [9.199.33.228] (unknown [9.199.33.228])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  4 Sep 2019 05:17:56 +0000 (GMT)
Subject: Re: [PATCH v6 7/7] libnvdimm/dax: Pick the right alignment default
 when creating dax devices
To: Dan Williams <dan.j.williams@intel.com>
References: <20190819133451.19737-1-aneesh.kumar@linux.ibm.com>
 <20190819133451.19737-8-aneesh.kumar@linux.ibm.com>
 <CAPcyv4gzb73mUCz7yJV8cxArVydBFHAHJqJ3jV2JRhVNFyvyWA@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <ae11dcb0-beaf-a6cf-9456-ac6a7ec84743@linux.ibm.com>
Date: Wed, 4 Sep 2019 10:47:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gzb73mUCz7yJV8cxArVydBFHAHJqJ3jV2JRhVNFyvyWA@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-04_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040055
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/4/19 5:48 AM, Dan Williams wrote:
> Hi Aneesh,
> 
> Patches 1 through 6 look ok, but I feel compelled to point out that
> the patches deploy a different indentation style than the surrounding
> code. I rely on the vim "=" operator to indent 2 tabs when for
> multi-line if statements, i.e. this:
> 
>          if (!nd_supported_alignment(align) &&
>                          !memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN)) {
>                  dev_err(&nd_pfn->dev, "init failed, alignment mismatch: "
>                                  "%ld:%ld\n", nd_pfn->align, align);
>                  return -EOPNOTSUPP;
>          }
> 
> ...instead of this:
> 
>          if (!nd_supported_alignment(align) &&
>              !memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN)) {
>                  dev_err(&nd_pfn->dev, "init failed, alignment mismatch: "
>                          "%ld:%ld\n", nd_pfn->align, align);
>                  return -EOPNOTSUPP;
>          }
> 
> Could you reflow / resend for v7 after addressing the below comments?
> To be clear I don't mind the lined up style, but mixed style within
> the same file is distracting.
>


I sent a v7 and then realized there are more feedback below. Let me 
reply here and then possibly send only this patch updated if needed

> On Mon, Aug 19, 2019 at 6:35 AM Aneesh Kumar K.V
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
> 
> Why is fsdax disabled? It's fine for the fsdax case to fall back to
> smaller faults. Or, this running into the case where the stored page
> size is larger than the currently running PAGE_SIZE?
> 
>>      "map":"mem",
>>      "size":5368709120,
>>      "uuid":"a4bdf81a-f2ee-4bc6-91db-7b87eddd0484",
>>      "state":"disabled"
>>    }
>> ]
>>


That is how ndctl print the output. It is actually the devdax namespace 
which is marked disabled. That is why I added this as a comment next to 
that "mode": line


>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/libnvdimm.h |  9 ++++++++
>>   arch/powerpc/mm/Makefile             |  1 +
>>   arch/powerpc/mm/nvdimm.c             | 34 ++++++++++++++++++++++++++++
>>   arch/x86/include/asm/libnvdimm.h     | 19 ++++++++++++++++
>>   drivers/nvdimm/nd.h                  |  6 -----
>>   drivers/nvdimm/pfn_devs.c            | 32 +++++++++++++++++++++++++-
>>   include/linux/huge_mm.h              |  7 +++++-
>>   7 files changed, 100 insertions(+), 8 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/libnvdimm.h
>>   create mode 100644 arch/powerpc/mm/nvdimm.c
>>   create mode 100644 arch/x86/include/asm/libnvdimm.h
>>
>> diff --git a/arch/powerpc/include/asm/libnvdimm.h b/arch/powerpc/include/asm/libnvdimm.h
>> new file mode 100644
>> index 000000000000..d35fd7f48603
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/libnvdimm.h
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_POWERPC_LIBNVDIMM_H
>> +#define _ASM_POWERPC_LIBNVDIMM_H
>> +
>> +#define nd_pfn_supported_alignments nd_pfn_supported_alignments
>> +extern unsigned long *nd_pfn_supported_alignments(void);
>> +extern unsigned long nd_pfn_default_alignment(void);
>> +
>> +#endif
>> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
>> index 0f499db315d6..42e4a399ba5d 100644
>> --- a/arch/powerpc/mm/Makefile
>> +++ b/arch/powerpc/mm/Makefile
>> @@ -20,3 +20,4 @@ obj-$(CONFIG_HIGHMEM)         += highmem.o
>>   obj-$(CONFIG_PPC_COPRO_BASE)   += copro_fault.o
>>   obj-$(CONFIG_PPC_PTDUMP)       += ptdump/
>>   obj-$(CONFIG_KASAN)            += kasan/
>> +obj-$(CONFIG_NVDIMM_PFN)               += nvdimm.o
>> diff --git a/arch/powerpc/mm/nvdimm.c b/arch/powerpc/mm/nvdimm.c
>> new file mode 100644
>> index 000000000000..a29a4510715e
>> --- /dev/null
>> +++ b/arch/powerpc/mm/nvdimm.c
>> @@ -0,0 +1,34 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <asm/pgtable.h>
>> +#include <asm/page.h>
>> +
>> +#include <linux/mm.h>
>> +/*
>> + * We support only pte and pmd mappings for now.
>> + */
>> +const unsigned long *nd_pfn_supported_alignments(void)
>> +{
>> +       static unsigned long supported_alignments[3];
>> +
>> +       supported_alignments[0] = PAGE_SIZE;
>> +
>> +       if (has_transparent_hugepage())
>> +               supported_alignments[1] = HPAGE_PMD_SIZE;
>> +       else
>> +               supported_alignments[1] = 0;
>> +
>> +       supported_alignments[2] = 0;
>> +       return supported_alignments;
>> +}
> 
> I'd prefer to not create a powerpc specific object file especially
> because nothing in the above looks powerpc specific. Anything that
> prevents just making this the common implementation?
> 


Support for PUD size alignment. The alignment details of what can be 
supported is largely a arch specific details. We could do that with

#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
		HPAGE_PUD_SIZE,
#endif

But I was looking at arch specific functions rather than having all 
those #ifdef there.

>> +
>> +/*
>> + * Use pmd mapping if supported as default alignment
>> + */
>> +unsigned long nd_pfn_default_alignment(void)
>> +{
>> +
>> +       if (has_transparent_hugepage())
>> +               return HPAGE_PMD_SIZE;
>> +       return PAGE_SIZE;
>> +}
>> diff --git a/arch/x86/include/asm/libnvdimm.h b/arch/x86/include/asm/libnvdimm.h
>> new file mode 100644
>> index 000000000000..3d5361db9164
>> --- /dev/null
>> +++ b/arch/x86/include/asm/libnvdimm.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_X86_LIBNVDIMM_H
>> +#define _ASM_X86_LIBNVDIMM_H
>> +
>> +static inline unsigned long nd_pfn_default_alignment(void)
>> +{
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +       return HPAGE_PMD_SIZE;
>> +#else
>> +       return PAGE_SIZE;
>> +#endif
>> +}
>> +
>> +static inline unsigned long nd_altmap_align_size(unsigned long nd_align)
>> +{
>> +       return PMD_SIZE;
>> +}
>> +
>> +#endif
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
>> index 22db77ac3d0e..7dc0b5da4c6b 100644
>> --- a/drivers/nvdimm/pfn_devs.c
>> +++ b/drivers/nvdimm/pfn_devs.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/fs.h>
>>   #include <linux/mm.h>
>> +#include <asm/libnvdimm.h>
>>   #include "nd-core.h"
>>   #include "pfn.h"
>>   #include "nd.h"
>> @@ -103,6 +104,8 @@ static ssize_t align_show(struct device *dev,
>>          return sprintf(buf, "%ld\n", nd_pfn->align);
>>   }
>>
>> +#ifndef nd_pfn_supported_alignments
>> +#define nd_pfn_supported_alignments nd_pfn_supported_alignments
>>   static const unsigned long *nd_pfn_supported_alignments(void)
>>   {
>>          /*
>> @@ -125,6 +128,7 @@ static const unsigned long *nd_pfn_supported_alignments(void)
>>
>>          return data;
>>   }
>> +#endif
>>
>>   static ssize_t align_store(struct device *dev,
>>                  struct device_attribute *attr, const char *buf, size_t len)
>> @@ -302,7 +306,7 @@ struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
>>                  return NULL;
>>
>>          nd_pfn->mode = PFN_MODE_NONE;
>> -       nd_pfn->align = PFN_DEFAULT_ALIGNMENT;
>> +       nd_pfn->align = nd_pfn_default_alignment();
>>          dev = &nd_pfn->dev;
>>          device_initialize(&nd_pfn->dev);
>>          if (ndns && !__nd_attach_ndns(&nd_pfn->dev, ndns, &nd_pfn->ndns)) {
>> @@ -412,6 +416,20 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
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
>> @@ -496,6 +514,18 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>>                  return -EOPNOTSUPP;
>>          }
>>
>> +       /*
>> +        * Check whether the we support the alignment. For Dax if the
>> +        * superblock alignment is not matching, we won't initialize
>> +        * the device.
>> +        */
>> +       if (!nd_supported_alignment(align) &&
>> +           !memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN)) {
> 
> ^^^ more indentation reflow.
> 

Both .clang-format and earlier emacs customization recommendation used 
the above style. I sent a  v7 with this fixup alone.


>> +               dev_err(&nd_pfn->dev, "init failed, alignment mismatch: "
>> +                       "%ld:%ld\n", nd_pfn->align, align);
>> +               return -EOPNOTSUPP;
>> +       }
>> +
>>          if (!nd_pfn->uuid) {
>>                  /*
>>                   * When probing a namepace via nd_pfn_probe() the uuid
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 45ede62aa85b..4fa91f9bd0da 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -108,7 +108,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>>
>>          if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>>                  return true;
>> -
>> +       /*
>> +        * For dax let's try to do hugepage fault always. If we don't support
>> +        * hugepages we will not have enabled namespaces with hugepage alignment.
>> +        * This also means we try to handle hugepage fault on device with
>> +        * smaller alignment. But for then we will return with VM_FAULT_FALLBACK
>> +        */
> 
> Please fix this comment up to not use the word "we". This should also
> get an ack from linux-mm folks. "We" in the above alternately means
> "we: the runtime/compile-tims platform setting", or "we: the kernel
> implementation".
> 

I can update the comment to indicate runtime part.

-aneesh
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
