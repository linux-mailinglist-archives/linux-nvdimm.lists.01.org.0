Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3457D218385
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 11:25:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67EDF110CED28;
	Wed,  8 Jul 2020 02:25:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C3C0F110BDB38
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1594200344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F2zdLTOyw0Dh6i9QOdd5/7QLp6E2NGclJ6QAnMCnhwI=;
	b=X9fSxOtcFV+ii1ifZb2GwU7PB5fmqHSKcPfy/YZfTalel+YazijBXHxzrwZE3FBk/O+MHy
	PJQc/ZSMP3fYXDuOhHLZMwS0VJ4fvmzwMK/QdnaTBp8tDYzicPltFOnSZTUiIO+uWIahwu
	XUv6fqyZs2U0O2+zhfdP8fODLeGnA48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-yV_7e81RNu25j-cL5sQXSQ-1; Wed, 08 Jul 2020 05:25:42 -0400
X-MC-Unique: yV_7e81RNu25j-cL5sQXSQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90CAA80040B;
	Wed,  8 Jul 2020 09:25:40 +0000 (UTC)
Received: from [10.36.113.117] (ovpn-113-117.ams2.redhat.com [10.36.113.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 31D717FE8B;
	Wed,  8 Jul 2020 09:25:36 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
To: Mike Rapoport <rppt@kernel.org>
References: <20200707121302.GB9411@linux.ibm.com>
 <474f93e7-c709-1a13-5418-29f1777f614c@redhat.com>
 <20200707180043.GA386073@linux.ibm.com>
 <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
 <20200708052626.GB386073@linux.ibm.com>
 <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
 <CAPcyv4jyk_tkDRewTVvRAv0g4LwemEyKYQyuJBXkF4VuYrBdrw@mail.gmail.com>
 <999ea296-4695-1219-6a4d-a027718f61e5@redhat.com>
 <20200708083951.GH386073@linux.ibm.com>
 <cdb0510e-4271-1c97-4305-5fd52da282dc@redhat.com>
 <20200708091520.GE128651@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <df0e5f64-10bc-4c3c-a515-288a6f501065@redhat.com>
Date: Wed, 8 Jul 2020 11:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708091520.GE128651@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: 57TZECUWFE2LJY7UPOZEY2VGWYQ3DY7X
X-Message-ID-Hash: 57TZECUWFE2LJY7UPOZEY2VGWYQ3DY7X
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@linux.ibm.com>, Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/57TZECUWFE2LJY7UPOZEY2VGWYQ3DY7X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08.07.20 11:15, Mike Rapoport wrote:
> On Wed, Jul 08, 2020 at 10:45:17AM +0200, David Hildenbrand wrote:
>> On 08.07.20 10:39, Mike Rapoport wrote:
>>> On Wed, Jul 08, 2020 at 10:26:41AM +0200, David Hildenbrand wrote:
>>>> On 08.07.20 09:50, Dan Williams wrote:
>>>>> On Wed, Jul 8, 2020 at 12:22 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>>>>>>>> On Tue 07-07-20 13:59:15, Jia He wrote:
>>>>>>>>>>>>> This exports memory_add_physaddr_to_nid() for module driver to use.
>>>>>>>>>>>>>
>>>>>>>>>>>>> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
>>>>>>>>>>>>> NUMA_NO_NID is detected.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>>>>>>>>>> Signed-off-by: Jia He <justin.he@arm.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>  arch/arm64/mm/numa.c | 5 +++--
>>>>>>>>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>>>>>>>>>>>>> index aafcee3e3f7e..7eeb31740248 100644
>>>>>>>>>>>>> --- a/arch/arm64/mm/numa.c
>>>>>>>>>>>>> +++ b/arch/arm64/mm/numa.c
>>>>>>>>>>>>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
>>>>>>>>>>>>>
>>>>>>>>>>>>>  /*
>>>>>>>>>>>>>   * We hope that we will be hotplugging memory on nodes we already know about,
>>>>>>>>>>>>> - * such that acpi_get_node() succeeds and we never fall back to this...
>>>>>>>>>>>>> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
>>>>>>>>>>>>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
>>>>>>>>>>>>>   */
>>>>>>>>>>>>>  int memory_add_physaddr_to_nid(u64 addr)
>>>>>>>>>>>>>  {
>>>>>>>>>>>>> - pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
>>>>>>>>>>>>>   return 0;
>>>>>>>>>>>>>  }
>>>>>>>>>>>>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>>>>>>>>>>>>
>>>>>>>>>>>> Does it make sense to export a noop function? Wouldn't make more sense
>>>>>>>>>>>> to simply make it static inline somewhere in a header? I haven't checked
>>>>>>>>>>>> whether there is an easy way to do that sanely bu this just hit my eyes.
>>>
>>>> I'd be curious if what we are trying to optimize here is actually worth
>>>> optimizing. IOW, is there a well-known scenario where the dummy value on
>>>> arm64 would be problematic and is worth the effort?
>>>
>>> Well, it started with Michal's comment above that EXPORT_SYMBOL_GPL()
>>> for a stub might be an overkill.
>>>
>>> I think Jia's suggestion [1] with addition of a comment that explains
>>> why and when the stub will be used, can work for both
>>> memory_add_physaddr_to_nid() and phys_to_target_node().
>>
>> Agreed.
>>
>>>
>>> But on more theoretical/fundmanetal level, I think we lack a generic
>>> abstraction similar to e.g. x86 'struct numa_meminfo' that serves as
>>> translaton of firmware supplied information into data that can be used
>>> by the generic mm without need to reimplement it for each and every
>>> arch.
>>
>> Right. As I expressed, I am not a friend of using memblock for that, and
>> the pgdat node span is tricky.
>>
>> Maybe abstracting that x86 concept is possible in some way (and we could
>> restrict the information to boot-time properties, so we don't have to
>> mess with memory hot(un)plug - just as done for numa_meminfo AFAIKS).
> 
> I agree with pgdat part and disagree about memblock. It already has
> non-init physmap, why won't we add memblock.memory to the mix? ;-)

Can we generalize and tweak physmap to contain node info? That's all we
need, no? (the special mem= parameter handling should not matter for our
use case, where "physmap" and "memory" would differ)

> 
> Now, seriously, memblock already has all the necessary information about
> the coldplug memory for several architectures. x86 being an exception
> because for some reason the reserved memory is not considered memory
> there. The infrastructure for quiering and iterating memory regions is
> already there. We just need to leave out the irrelevant parts, like
> memblock.reserved and allocation funcions.

I *really* don't want to mess with memblocks on memory hot(un)plug on
x86 and s390x (+other architectures in the future). I also thought about
stopping to create memblocks for hotplugged memory on arm64, by tweaking
pfn_valid() to query memblocks only for early sections.

If "physmem" is not an option, can we at least introduce something like
ARCH_UPDTAE_MEMBLOCK_ON_HOTPLUG to avoid doing that on x86 and s390x for
now (and later maybe for others)?

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
