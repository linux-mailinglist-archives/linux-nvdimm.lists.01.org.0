Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 354E8B4B53
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Sep 2019 11:55:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CE40B21962301;
	Tue, 17 Sep 2019 02:54:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6B1572020D32E
 for <linux-nvdimm@lists.01.org>; Tue, 17 Sep 2019 02:54:29 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8H9lUj4050362; Tue, 17 Sep 2019 05:55:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v2tmvp9s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2019 05:54:42 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8H9m2Gs052568;
 Tue, 17 Sep 2019 05:54:42 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v2tmvp9rf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2019 05:54:41 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8H9ntAG011103;
 Tue, 17 Sep 2019 09:54:40 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04dal.us.ibm.com with ESMTP id 2v0swhwfpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2019 09:54:40 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8H9sdFQ59834718
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 09:54:39 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09D03C605A;
 Tue, 17 Sep 2019 09:54:39 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D1D6C6057;
 Tue, 17 Sep 2019 09:54:37 +0000 (GMT)
Received: from [9.124.35.113] (unknown [9.124.35.113])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 17 Sep 2019 09:54:37 +0000 (GMT)
Subject: Re: [PATCH 2/2] powerpc/nvdimm: Update vmemmap_populated to check
 sub-section range
To: Dan Williams <dan.j.williams@intel.com>
References: <20190910062826.10041-1-aneesh.kumar@linux.ibm.com>
 <20190910062826.10041-2-aneesh.kumar@linux.ibm.com>
 <CAPcyv4ia0_GUu+=j-ecCuJkqaE5dVENNQxK_S-mO_KBmuA=9hw@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <cc1e080a-eb95-dab7-a77b-a05e12624578@linux.ibm.com>
Date: Tue, 17 Sep 2019 15:24:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ia0_GUu+=j-ecCuJkqaE5dVENNQxK_S-mO_KBmuA=9hw@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170100
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
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/16/19 11:16 PM, Dan Williams wrote:
> On Mon, Sep 9, 2019 at 11:29 PM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> With commit: 7cc7867fb061 ("mm/devm_memremap_pages: enable sub-section remap")
>> pmem namespaces are remapped in 2M chunks. On architectures like ppc64 we
>> can map the memmap area using 16MB hugepage size and that can cover
>> a memory range of 16G.
>>
>> While enabling new pmem namespaces, since memory is added in sub-section chunks,
>> before creating a new memmap mapping, kernel should check whether there is an
>> existing memmap mapping covering the new pmem namespace. Currently, this is
>> validated by checking whether the section covering the range is already
>> initialized or not. Considering there can be multiple namespaces in the same
>> section this can result in wrong validation. Update this to check for
>> sub-sections in the range. This is done by checking for all pfns in the range we
>> are mapping.
>>
>> We could optimize this by checking only just one pfn in each sub-section. But
>> since this is not fast-path we keep this simple.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   arch/powerpc/mm/init_64.c | 45 ++++++++++++++++++++-------------------
>>   1 file changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index 4e08246acd79..7710ccdc19a2 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -70,30 +70,24 @@ EXPORT_SYMBOL_GPL(kernstart_addr);
>>
>>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
>>   /*
>> - * Given an address within the vmemmap, determine the pfn of the page that
>> - * represents the start of the section it is within.  Note that we have to
>> - * do this by hand as the proffered address may not be correctly aligned.
>> - * Subtraction of non-aligned pointers produces undefined results.
>> - */
>> -static unsigned long __meminit vmemmap_section_start(unsigned long page)
>> -{
>> -       unsigned long offset = page - ((unsigned long)(vmemmap));
>> -
>> -       /* Return the pfn of the start of the section. */
>> -       return (offset / sizeof(struct page)) & PAGE_SECTION_MASK;
>> -}
>> -
>> -/*
>> - * Check if this vmemmap page is already initialised.  If any section
>> + * Check if this vmemmap page is already initialised.  If any sub section
>>    * which overlaps this vmemmap page is initialised then this page is
>>    * initialised already.
>>    */
>> -static int __meminit vmemmap_populated(unsigned long start, int page_size)
>> +
>> +static int __meminit vmemmap_populated(unsigned long start, int size)
>>   {
>> -       unsigned long end = start + page_size;
>> -       start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
>> +       unsigned long end = start + size;
>>
>> -       for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
>> +       /* start is size aligned and it is always > sizeof(struct page) */
>> +       VM_BUG_ON(start & sizeof(struct page));
> 
> If start is size aligned why not include that assumption in the VM_BUG_ON()?
> 
> Otherwise it seems this patch could be reduced simply by:
> 
> s/PAGE_SECTION_MASK/PAGE_SUBSECTION_MASK/
> s/PAGES_PER_SECTION/PAGES_PER_SUBSECTION/
> 
> ...and leave the vmemmap_section_start() function in place? In other
> words this path used to guarantee that 'start' was aligned to the
> minimum mem-hotplug granularity, the change looks ok on the surface,
> but it seems a subtle change in semantics.
> 


How about this?

/*
  * Given an address within the vmemmap, determine the page that
  * represents the start of the subsection it is within.  Note that we 
have to
  * do this by hand as the proffered address may not be correctly aligned.
  * Subtraction of non-aligned pointers produces undefined results.
  */
static struct page * __meminit vmemmap_subsection_start(unsigned long 
vmemmap_addr)
{
	unsigned long start_pfn;
	unsigned long offset = vmemmap_addr - ((unsigned long)(vmemmap));

	/* Return the pfn of the start of the section. */
	start_pfn = (offset / sizeof(struct page)) & PAGE_SUBSECTION_MASK;
	return pfn_to_page(start_pfn);
}

/*
  * Since memory is added in sub-section chunks, before creating a new 
vmemmap
  * mapping, the kernel should check whether there is an existing memmap 
mapping
  * covering the new subsection added. This is needed because kernel can map
  * vmemmap area using 16MB pages which will cover a memory range of 
16G. Such
  * a range covers multiple subsections (2M)
  *
  * If any subsection in the 16G range mapped by vmemmap is valid we 
consider the
  * vmemmap populated (There is a page table entry already present). We 
can't do
  * a page table lookup here because with the hash translation we don't keep
  * vmemmap details in linux page table.
  */
static int __meminit vmemmap_populated(unsigned long vmemmap_addr, int 
vmemmap_map_size)
{
	struct page *start;
	unsigned long vmemmap_end = vmemmap_addr + vmemmap_map_size;
	start = vmemmap_subsection_start(vmemmap_addr);

	for (; (unsigned long)start < vmemmap_end; start += PAGES_PER_SUBSECTION)
		/*
		 * pfn valid check here is intended to really check
		 * whether we have any subsection already initialized
		 * in this range.
		 */
		if (pfn_valid(page_to_pfn(start)))
			return 1;

	return 0;
}




> Can you get an ack from a powerpc maintainer, or maybe this patch
> should route through the powerpc tree?
> 

I guess this can go via powerpc tree. I will send an update V2 patch for 
this alone and work with Michael to pick that up.

> I'll take patch1 through the nvdimm tree.
> 

Thanks.

-aneesh



_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
