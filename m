Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5C3218354
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 11:15:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 968D9110BC286;
	Wed,  8 Jul 2020 02:15:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1559E110BA974
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 02:15:31 -0700 (PDT)
Received: from kernel.org (unknown [87.71.40.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AE9292063A;
	Wed,  8 Jul 2020 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594199730;
	bh=1P3BCibtQ27BJR4HH94/+rxqEdbIvNz2+VLbK4bFC5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpMvnDS0sU0t8bLM4FA3w1+3DXw2v19WPhpIaJ+Bh+QhCuRE6GcLUPwkSeMR3lL9x
	 u9T7XOCbfiKI5mq0gZkFjKcECE7YizAF2NyOleKpCYCoUKL+sjFQZ3pkzkBfDwuzyG
	 vnZkmXHB5LWE6FOFDo5ku6TGgB1ggCmXDLKbZoJU=
Date: Wed, 8 Jul 2020 12:15:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200708091520.GE128651@kernel.org>
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cdb0510e-4271-1c97-4305-5fd52da282dc@redhat.com>
Message-ID-Hash: LKWMH6XHHECE7OLHNH6EAFDFGP5RZIMW
X-Message-ID-Hash: LKWMH6XHHECE7OLHNH6EAFDFGP5RZIMW
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@linux.ibm.com>, Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LKWMH6XHHECE7OLHNH6EAFDFGP5RZIMW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 08, 2020 at 10:45:17AM +0200, David Hildenbrand wrote:
> On 08.07.20 10:39, Mike Rapoport wrote:
> > On Wed, Jul 08, 2020 at 10:26:41AM +0200, David Hildenbrand wrote:
> >> On 08.07.20 09:50, Dan Williams wrote:
> >>> On Wed, Jul 8, 2020 at 12:22 AM David Hildenbrand <david@redhat.com> wrote:
> >>>>
> >>>>>>>>>> On Tue 07-07-20 13:59:15, Jia He wrote:
> >>>>>>>>>>> This exports memory_add_physaddr_to_nid() for module driver to use.
> >>>>>>>>>>>
> >>>>>>>>>>> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> >>>>>>>>>>> NUMA_NO_NID is detected.
> >>>>>>>>>>>
> >>>>>>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>>>>>>>>>> Signed-off-by: Jia He <justin.he@arm.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>  arch/arm64/mm/numa.c | 5 +++--
> >>>>>>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> >>>>>>>>>>> index aafcee3e3f7e..7eeb31740248 100644
> >>>>>>>>>>> --- a/arch/arm64/mm/numa.c
> >>>>>>>>>>> +++ b/arch/arm64/mm/numa.c
> >>>>>>>>>>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> >>>>>>>>>>>
> >>>>>>>>>>>  /*
> >>>>>>>>>>>   * We hope that we will be hotplugging memory on nodes we already know about,
> >>>>>>>>>>> - * such that acpi_get_node() succeeds and we never fall back to this...
> >>>>>>>>>>> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> >>>>>>>>>>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
> >>>>>>>>>>>   */
> >>>>>>>>>>>  int memory_add_physaddr_to_nid(u64 addr)
> >>>>>>>>>>>  {
> >>>>>>>>>>> - pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> >>>>>>>>>>>   return 0;
> >>>>>>>>>>>  }
> >>>>>>>>>>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >>>>>>>>>>
> >>>>>>>>>> Does it make sense to export a noop function? Wouldn't make more sense
> >>>>>>>>>> to simply make it static inline somewhere in a header? I haven't checked
> >>>>>>>>>> whether there is an easy way to do that sanely bu this just hit my eyes.
> > 
> >> I'd be curious if what we are trying to optimize here is actually worth
> >> optimizing. IOW, is there a well-known scenario where the dummy value on
> >> arm64 would be problematic and is worth the effort?
> > 
> > Well, it started with Michal's comment above that EXPORT_SYMBOL_GPL()
> > for a stub might be an overkill.
> > 
> > I think Jia's suggestion [1] with addition of a comment that explains
> > why and when the stub will be used, can work for both
> > memory_add_physaddr_to_nid() and phys_to_target_node().
> 
> Agreed.
> 
> > 
> > But on more theoretical/fundmanetal level, I think we lack a generic
> > abstraction similar to e.g. x86 'struct numa_meminfo' that serves as
> > translaton of firmware supplied information into data that can be used
> > by the generic mm without need to reimplement it for each and every
> > arch.
> 
> Right. As I expressed, I am not a friend of using memblock for that, and
> the pgdat node span is tricky.
>
> Maybe abstracting that x86 concept is possible in some way (and we could
> restrict the information to boot-time properties, so we don't have to
> mess with memory hot(un)plug - just as done for numa_meminfo AFAIKS).

I agree with pgdat part and disagree about memblock. It already has
non-init physmap, why won't we add memblock.memory to the mix? ;-)

Now, seriously, memblock already has all the necessary information about
the coldplug memory for several architectures. x86 being an exception
because for some reason the reserved memory is not considered memory
there. The infrastructure for quiering and iterating memory regions is
already there. We just need to leave out the irrelevant parts, like
memblock.reserved and allocation funcions.

Otherwise we'll add yet another 'struct { start, end }', a horde of
covnersion and re-initialization functions that will do more or less the
same things as current memblock APIs.

> -- 
> Thanks,
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
