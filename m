Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F80821801E
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 09:00:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 339B6110BDB38;
	Wed,  8 Jul 2020 00:00:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E2BF1110BC281
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1594191625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P+pB41ag935VHpya9CnswAR3Lx824tdMEksUnjGyp0g=;
	b=UzGrW7W1x/bnd+Kpi2F8eIIuOdQOS1Fp1LK3jRQvGJ0lkoyQCOMVLBhBq7uX9r2WywCMf9
	heivPjPaUV8hh4wL9Epm4P/k5WvPOQmASZuO657bbrnDEfRLG/yFWOEsChUb3l25N/+fEi
	C2e1Au/+vRHSeUw5RdSrrWT6bu2wRrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-kHPJQVmwPieWykhIljztNQ-1; Wed, 08 Jul 2020 03:00:22 -0400
X-MC-Unique: kHPJQVmwPieWykhIljztNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFF412CCC;
	Wed,  8 Jul 2020 07:00:19 +0000 (UTC)
Received: from [10.36.113.117] (ovpn-113-117.ams2.redhat.com [10.36.113.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B7D53619C4;
	Wed,  8 Jul 2020 07:00:16 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
To: Justin He <Justin.He@arm.com>, Dan Williams <dan.j.williams@intel.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
 <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
 <20200708053239.GC386073@linux.ibm.com>
 <CAPcyv4i2gnrugO5n715WsDoj+gxV9Mjt-49zNnv+ROMLYy79LQ@mail.gmail.com>
 <AM6PR08MB4069AC46B435AB32BE9E2834F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <e7bba217-bade-f9c1-8e44-f6b5ca378832@redhat.com>
Date: Wed, 8 Jul 2020 09:00:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <AM6PR08MB4069AC46B435AB32BE9E2834F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: FIQYEDX5PG2QPAWE6HL33LP5V73GFKUP
X-Message-ID-Hash: FIQYEDX5PG2QPAWE6HL33LP5V73GFKUP
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>, Mike Rapoport <rppt@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FIQYEDX5PG2QPAWE6HL33LP5V73GFKUP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08.07.20 08:56, Justin He wrote:
> Hi Dan
> 
>> -----Original Message-----
>> From: Dan Williams <dan.j.williams@intel.com>
>> Sent: Wednesday, July 8, 2020 1:48 PM
>> To: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Justin He <Justin.He@arm.com>; Michal Hocko <mhocko@kernel.org>; David
>> Hildenbrand <david@redhat.com>; Catalin Marinas <Catalin.Marinas@arm.com>;
>> Will Deacon <will@kernel.org>; Vishal Verma <vishal.l.verma@intel.com>;
>> Dave Jiang <dave.jiang@intel.com>; Andrew Morton <akpm@linux-
>> foundation.org>; Baoquan He <bhe@redhat.com>; Chuhong Yuan
>> <hslester96@gmail.com>; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; linux-mm@kvack.org; linux-nvdimm@lists.01.org;
>> Kaly Xin <Kaly.Xin@arm.com>
>> Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid
>> as EXPORT_SYMBOL_GPL
>>
>> On Tue, Jul 7, 2020 at 10:33 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>>>
>>> On Tue, Jul 07, 2020 at 08:56:36PM -0700, Dan Williams wrote:
>>>> On Tue, Jul 7, 2020 at 7:20 PM Justin He <Justin.He@arm.com> wrote:
>>>>>
>>>>> Hi Michal and David
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Michal Hocko <mhocko@kernel.org>
>>>>>> Sent: Tuesday, July 7, 2020 7:55 PM
>>>>>> To: Justin He <Justin.He@arm.com>
>>>>>> Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
>>>>>> <will@kernel.org>; Dan Williams <dan.j.williams@intel.com>; Vishal
>> Verma
>>>>>> <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>;
>> Andrew
>>>>>> Morton <akpm@linux-foundation.org>; Mike Rapoport
>> <rppt@linux.ibm.com>;
>>>>>> Baoquan He <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>;
>> linux-
>>>>>> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> linux-
>>>>>> mm@kvack.org; linux-nvdimm@lists.01.org; Kaly Xin
>> <Kaly.Xin@arm.com>
>>>>>> Subject: Re: [PATCH v2 1/3] arm64/numa: export
>> memory_add_physaddr_to_nid
>>>>>> as EXPORT_SYMBOL_GPL
>>>>>>
>>>>>> On Tue 07-07-20 13:59:15, Jia He wrote:
>>>>>>> This exports memory_add_physaddr_to_nid() for module driver to
>> use.
>>>>>>>
>>>>>>> memory_add_physaddr_to_nid() is a fallback option to get the nid
>> in case
>>>>>>> NUMA_NO_NID is detected.
>>>>>>>
>>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>>>> Signed-off-by: Jia He <justin.he@arm.com>
>>>>>>> ---
>>>>>>>  arch/arm64/mm/numa.c | 5 +++--
>>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>>>>>>> index aafcee3e3f7e..7eeb31740248 100644
>>>>>>> --- a/arch/arm64/mm/numa.c
>>>>>>> +++ b/arch/arm64/mm/numa.c
>>>>>>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
>>>>>>>
>>>>>>>  /*
>>>>>>>   * We hope that we will be hotplugging memory on nodes we
>> already know
>>>>>> about,
>>>>>>> - * such that acpi_get_node() succeeds and we never fall back to
>> this...
>>>>>>> + * such that acpi_get_node() succeeds. But when SRAT is not
>> present,
>>>>>> the node
>>>>>>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a
>> fallback
>>>>>> option.
>>>>>>>   */
>>>>>>>  int memory_add_physaddr_to_nid(u64 addr)
>>>>>>>  {
>>>>>>> -   pr_warn("Unknown node for memory at 0x%llx, assuming node
>> 0\n",
>>>>>> addr);
>>>>>>>     return 0;
>>>>>>>  }
>>>>>>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>>>>>>
>>>>>> Does it make sense to export a noop function? Wouldn't make more
>> sense
>>>>>> to simply make it static inline somewhere in a header? I haven't
>> checked
>>>>>> whether there is an easy way to do that sanely bu this just hit my
>> eyes.
>>>>>
>>>>> Okay, I can make a change in memory_hotplug.h, sth like:
>>>>> --- a/include/linux/memory_hotplug.h
>>>>> +++ b/include/linux/memory_hotplug.h
>>>>> @@ -149,13 +149,13 @@ int add_pages(int nid, unsigned long start_pfn,
>> unsigned long nr_pages,
>>>>>               struct mhp_params *params);
>>>>>  #endif /* ARCH_HAS_ADD_PAGES */
>>>>>
>>>>> -#ifdef CONFIG_NUMA
>>>>> -extern int memory_add_physaddr_to_nid(u64 start);
>>>>> -#else
>>>>> +#if !defined(CONFIG_NUMA) || !defined(memory_add_physaddr_to_nid)
>>>>>  static inline int memory_add_physaddr_to_nid(u64 start)
>>>>>  {
>>>>>         return 0;
>>>>>  }
>>>>> +#else
>>>>> +extern int memory_add_physaddr_to_nid(u64 start);
>>>>>  #endif
>>>>>
>>>>> And then check the memory_add_physaddr_to_nid() helper on all arches,
>>>>> if it is noop(return 0), I can simply remove it.
>>>>> if it is not noop, after the helper,
>>>>> #define memory_add_physaddr_to_nid
>>>>>
>>>>> What do you think of this proposal?
>>>>
>>>> Especially for architectures that use memblock info for numa info
>>>> (which seems to be everyone except x86) why not implement a generic
>>>> memory_add_physaddr_to_nid() that does:
>>>
>>> That would be only arm64.
>>>
>>
>> Darn, I saw ARCH_KEEP_MEMBLOCK and had delusions of grandeur that it
>> could solve my numa api woes. At least for x86 the problem is already
>> solved with reserved numa_meminfo, but now I'm trying to write generic
>> drivers that use those apis and finding these gaps on other archs.
> 
> Even on arm64, there is a dependency issue in dax_pmem kmem case.
> If dax pmem uses memory_add_physaddr_to_nid() to decide which node that
> memblock should add into, get_pfn_range_for_nid() might not have
> the correct memblock info at that time. That is, get_pfn_range_for_nid()
> can't get the correct memblock info before add_memory()
> 
> So IMO, memory_add_physaddr_to_nid() still have to implement as noop on
> arm64 (return 0) together with sh,s390x? Powerpc, x86,ia64 can use their
> own implementation. And phys_to_target_node() can use your suggested(
> for_each_online_node() ...)
> 
> What do you think of it? Thanks

You are trying to fix the "we only have one dummy node" AFAIU, so what
you propose here is certainly good enough for now.

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
