Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2962464F9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 18:50:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8745D2129EBA8;
	Fri, 14 Jun 2019 09:50:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 790062129EB85
 for <linux-nvdimm@lists.01.org>; Fri, 14 Jun 2019 09:50:40 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5EGlaaa048336
 for <linux-nvdimm@lists.01.org>; Fri, 14 Jun 2019 12:50:40 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t4easb3t8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Fri, 14 Jun 2019 12:50:39 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 14 Jun 2019 17:50:38 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Jun 2019 17:50:34 +0100
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5EGoX7q29753776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2019 16:50:33 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ABC36E050;
 Fri, 14 Jun 2019 16:50:33 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1493E6E04C;
 Fri, 14 Jun 2019 16:50:30 +0000 (GMT)
Received: from [9.199.60.77] (unknown [9.199.60.77])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jun 2019 16:50:30 +0000 (GMT)
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To: Dan Williams <dan.j.williams@intel.com>
References: <1560366952-10660-1-git-send-email-cai@lca.pw>
 <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
 <1560376072.5154.6.camel@lca.pw> <87lfy4ilvj.fsf@linux.ibm.com>
 <20190614153535.GA9900@linux>
 <c3f2c05d-e42f-c942-1385-664f646ddd33@linux.ibm.com>
 <CAPcyv4j_QQB8SrhTqL2mnEEHGYCg4H7kYanChiww35k0fwNv8Q@mail.gmail.com>
 <24fcb721-5d50-2c34-f44b-69281c8dd760@linux.ibm.com>
 <CAPcyv4ixq6aRQLdiMAUzQ-eDoA-hGbJQ6+_-K-nZzhXX70m1+g@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Fri, 14 Jun 2019 22:20:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ixq6aRQLdiMAUzQ-eDoA-hGbJQ6+_-K-nZzhXX70m1+g@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19061416-0012-0000-0000-000017444A92
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011261; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01217923; UDB=6.00640496; IPR=6.00999044; 
 MB=3.00027312; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-14 16:50:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061416-0013-0000-0000-000057B1CDDD
Message-Id: <6cbef0c5-1ce8-91ac-3396-902a9bf95716@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-14_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=27 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140136
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Qian Cai <cai@lca.pw>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 6/14/19 10:06 PM, Dan Williams wrote:
> On Fri, Jun 14, 2019 at 9:26 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 6/14/19 9:52 PM, Dan Williams wrote:
>>> On Fri, Jun 14, 2019 at 9:18 AM Aneesh Kumar K.V
>>> <aneesh.kumar@linux.ibm.com> wrote:
>>>>
>>>> On 6/14/19 9:05 PM, Oscar Salvador wrote:
>>>>> On Fri, Jun 14, 2019 at 02:28:40PM +0530, Aneesh Kumar K.V wrote:
>>>>>> Can you check with this change on ppc64.  I haven't reviewed this series yet.
>>>>>> I did limited testing with change . Before merging this I need to go
>>>>>> through the full series again. The vmemmap poplulate on ppc64 needs to
>>>>>> handle two translation mode (hash and radix). With respect to vmemap
>>>>>> hash doesn't setup a translation in the linux page table. Hence we need
>>>>>> to make sure we don't try to setup a mapping for a range which is
>>>>>> arleady convered by an existing mapping.
>>>>>>
>>>>>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>>>>>> index a4e17a979e45..15c342f0a543 100644
>>>>>> --- a/arch/powerpc/mm/init_64.c
>>>>>> +++ b/arch/powerpc/mm/init_64.c
>>>>>> @@ -88,16 +88,23 @@ static unsigned long __meminit vmemmap_section_start(unsigned long page)
>>>>>>      * which overlaps this vmemmap page is initialised then this page is
>>>>>>      * initialised already.
>>>>>>      */
>>>>>> -static int __meminit vmemmap_populated(unsigned long start, int page_size)
>>>>>> +static bool __meminit vmemmap_populated(unsigned long start, int page_size)
>>>>>>     {
>>>>>>        unsigned long end = start + page_size;
>>>>>>        start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
>>>>>>
>>>>>> -    for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
>>>>>> -            if (pfn_valid(page_to_pfn((struct page *)start)))
>>>>>> -                    return 1;
>>>>>> +    for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page))) {
>>>>>>
>>>>>> -    return 0;
>>>>>> +            struct mem_section *ms;
>>>>>> +            unsigned long pfn = page_to_pfn((struct page *)start);
>>>>>> +
>>>>>> +            if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>>>>>> +                    return 0;
>>>>>
>>>>> I might be missing something, but is this right?
>>>>> Having a section_nr above NR_MEM_SECTIONS is invalid, but if we return 0 here,
>>>>> vmemmap_populate will go on and populate it.
>>>>
>>>> I should drop that completely. We should not hit that condition at all.
>>>> I will send a final patch once I go through the full patch series making
>>>> sure we are not breaking any ppc64 details.
>>>>
>>>> Wondering why we did the below
>>>>
>>>> #if defined(ARCH_SUBSECTION_SHIFT)
>>>> #define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
>>>> #elif defined(PMD_SHIFT)
>>>> #define SUBSECTION_SHIFT (PMD_SHIFT)
>>>> #else
>>>> /*
>>>>     * Memory hotplug enabled platforms avoid this default because they
>>>>     * either define ARCH_SUBSECTION_SHIFT, or PMD_SHIFT is a constant, but
>>>>     * this is kept as a backstop to allow compilation on
>>>>     * !ARCH_ENABLE_MEMORY_HOTPLUG archs.
>>>>     */
>>>> #define SUBSECTION_SHIFT 21
>>>> #endif
>>>>
>>>> why not
>>>>
>>>> #if defined(ARCH_SUBSECTION_SHIFT)
>>>> #define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
>>>> #else
>>>> #define SUBSECTION_SHIFT  SECTION_SHIFT
>>
>> That should be SECTION_SIZE_SHIFT
>>
>>>> #endif
>>>>
>>>> ie, if SUBSECTION is not supported by arch we have one sub-section per
>>>> section?
>>>
>>> A couple comments:
>>>
>>> The only reason ARCH_SUBSECTION_SHIFT exists is because PMD_SHIFT on
>>> PowerPC was a non-constant value. However, I'm planning to remove the
>>> distinction in the next rev of the patches. Jeff rightly points out
>>> that having a variable subsection size per arch will lead to
>>> situations where persistent memory namespaces are not portable across
>>> archs. So I plan to just make SUBSECTION_SHIFT 21 everywhere.
>>>
>>
>>
>> persistent memory namespaces are not portable across archs because they
>> have PAGE_SIZE dependency.
> 
> We can fix that by reserving mem_map capacity assuming the smallest
> PAGE_SIZE across archs.
> 
>> Then we have dependencies like the page size
>> with which we map the vmemmap area.
> 
> How does that lead to cross-arch incompatibility? Even on a single
> arch the vmemmap area will be mapped with 2MB pages for 128MB aligned
> spans of pmem address space and 4K pages for subsections.

I am not sure I understood that details. On ppc64 vmemmap can be mapped 
by either 16M, 2M, 64K depending on the translation mode (hash or 
radix). Doesn't that imply our reserve area size will vary between these 
configs? I was thinking we should let the arch pick the largest value as 
alignment and align things based on that. Otherwise if you align the 
vmemmap/altmap area to 2M and we move to a platform that map the vmemmap 
area using 16MB pagesize we fail right? In other words if you want to 
build a portable pmem region, we have to configure these alignment 
correctly.

Also the label area storage is completely hidden in firmware right? So 
the portability will be limited to platforms that support same firmware?


> 
>> Why not let the arch
>> arch decide the SUBSECTION_SHIFT and default to one subsection per
>> section if arch is not enabled to work with subsection.
> 
> Because that keeps the implementation from ever reaching a point where
> a namespace might be able to be moved from one arch to another. If we
> can squash these arch differences then we can have a common tool to
> initialize namespaces outside of the kernel. The one wrinkle is
> device-dax that wants to enforce the mapping size, but I think we can
> have a module-option compatibility override for that case for the
> admin to say "yes, I know this namespace is defined for 2MB x86 pages,
> but I want to force enable it with 64K pages on PowerPC"

But then you can't say I want to enable this with 16M pages on PowerPC.
But I understood what you are suggesting here.

-aneesh


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
