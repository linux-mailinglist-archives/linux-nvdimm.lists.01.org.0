Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28762181C4
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 09:51:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1589F110CC330;
	Wed,  8 Jul 2020 00:51:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 086B9110CC32D
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 00:51:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a1so49326370ejg.12
        for <linux-nvdimm@lists.01.org>; Wed, 08 Jul 2020 00:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdB28ZI7SOp5ABXL8AmMn/U84IJpt8dmXOT5xybidAg=;
        b=BjxvWffeCf5PXDrtXE8h3palNn15R0do8NHLaSbPbHUjDpkYUrELgy20BbtGeIABPY
         kl9r3qxcaeeKpc/+mhEPQm4ZduJNNKXZWHHvwBa26w0t8WYctuN7VAYiJLhk1MqFlafV
         psBUb4xEwyOw7YLosN48f65Tp3XhspKy0p/EpmpfNNvGv/7XMvCW5s3lDNJP1twiGQlV
         WbSDFhrSwAxSg+uBGqUTCJTgNTnbmTTFF/xcL6KmEy4Cc3G2bSuqS7P/kpoBvd0XoVIM
         Nv7LE1Gh7MM5YF2rK4XBfn+ObjhbOoZLlzb1LUAk4vnLCV6tFyI31aA+LEn5JNI5zgxf
         ipUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdB28ZI7SOp5ABXL8AmMn/U84IJpt8dmXOT5xybidAg=;
        b=PXJDeF112/QtIY3rLhWsJvifLoSdMMP8/r404RGsRyXg621DMsoEji399iDbPL1pJL
         rfK6g5OX0G1gGj8ulWQ3z+3A6KCi4uxEO6lJki2xEtg08Pg6Kr8pKMLCT/xH3uqlzp4B
         VdapkCJRLz3DMWkYb13iXqGLlJPGjz1/RdO0gH1YKLDWwVWvGexaw8pC+zDIyTwF+iIo
         MVAe7GfZQBvvaHa7fxG+HIt8nXO/N73qZcJPeNPYjcJ4/3LmHmIs3MdV6S/96dcvfB6X
         c1zcoBYQN6SDEcUvTP92QSswckppHTBqhnljmho2H2KCOlwNsEcVK71ALWxD3vCje6IC
         ukhg==
X-Gm-Message-State: AOAM533Blqg6Gv7abxDm+ayBzj5sM5pQ2UOGZ1I721Pt5rrQLaVtS6ud
	riLMWLsniWCIoQ99WX7af5l5U+xGrK/27Qm6zlk+Yg==
X-Google-Smtp-Source: ABdhPJxTO+TBaGOUp0dajU8scS3zSaoUWnLpzKeEDNORKl5f+9ig/G7GMHAS4653XxC7hyczsTzT0ufohb1efEgi1JM=
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr49837175ejf.455.1594194661844;
 Wed, 08 Jul 2020 00:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <20200707121302.GB9411@linux.ibm.com>
 <474f93e7-c709-1a13-5418-29f1777f614c@redhat.com> <20200707180043.GA386073@linux.ibm.com>
 <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
 <20200708052626.GB386073@linux.ibm.com> <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
In-Reply-To: <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 8 Jul 2020 00:50:50 -0700
Message-ID: <CAPcyv4jyk_tkDRewTVvRAv0g4LwemEyKYQyuJBXkF4VuYrBdrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: NGDTOEPRXVNDHHRPZIJRMJ63EEJDEX4P
X-Message-ID-Hash: NGDTOEPRXVNDHHRPZIJRMJ63EEJDEX4P
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mike Rapoport <rppt@linux.ibm.com>, Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NGDTOEPRXVNDHHRPZIJRMJ63EEJDEX4P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 8, 2020 at 12:22 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.07.20 07:27, Mike Rapoport wrote:
> > On Tue, Jul 07, 2020 at 03:05:48PM -0700, Dan Williams wrote:
> >> On Tue, Jul 7, 2020 at 11:01 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >>>
> >>> On Tue, Jul 07, 2020 at 02:26:08PM +0200, David Hildenbrand wrote:
> >>>> On 07.07.20 14:13, Mike Rapoport wrote:
> >>>>> On Tue, Jul 07, 2020 at 01:54:54PM +0200, Michal Hocko wrote:
> >>>>>> On Tue 07-07-20 13:59:15, Jia He wrote:
> >>>>>>> This exports memory_add_physaddr_to_nid() for module driver to use.
> >>>>>>>
> >>>>>>> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> >>>>>>> NUMA_NO_NID is detected.
> >>>>>>>
> >>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>>>>>> Signed-off-by: Jia He <justin.he@arm.com>
> >>>>>>> ---
> >>>>>>>  arch/arm64/mm/numa.c | 5 +++--
> >>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> >>>>>>> index aafcee3e3f7e..7eeb31740248 100644
> >>>>>>> --- a/arch/arm64/mm/numa.c
> >>>>>>> +++ b/arch/arm64/mm/numa.c
> >>>>>>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> >>>>>>>
> >>>>>>>  /*
> >>>>>>>   * We hope that we will be hotplugging memory on nodes we already know about,
> >>>>>>> - * such that acpi_get_node() succeeds and we never fall back to this...
> >>>>>>> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> >>>>>>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
> >>>>>>>   */
> >>>>>>>  int memory_add_physaddr_to_nid(u64 addr)
> >>>>>>>  {
> >>>>>>> - pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> >>>>>>>   return 0;
> >>>>>>>  }
> >>>>>>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >>>>>>
> >>>>>> Does it make sense to export a noop function? Wouldn't make more sense
> >>>>>> to simply make it static inline somewhere in a header? I haven't checked
> >>>>>> whether there is an easy way to do that sanely bu this just hit my eyes.
> >>>>>
> >>>>> We'll need to either add a CONFIG_ option or arch specific callback to
> >>>>> make both non-empty (x86, powerpc, ia64) and empty (arm64, sh)
> >>>>> implementations coexist ...
> >>>>
> >>>> Note: I have a similar dummy (return 0) patch for s390x lying around here.
> >>>
> >>> Then we'll call it a tie - 3:3 ;-)
> >>
> >> So I'd be happy to jump on the train of people wanting to export the
> >> ARM stub for this (and add a new ARM stub for phys_to_target_node()),
> >> but Will did have a plausibly better idea that I have been meaning to
> >> circle back to:
> >>
> >> http://lore.kernel.org/r/20200325111039.GA32109@willie-the-truck
> >>
> >> ...i.e. iterate over node data to do the lookup. This would seem to
> >> work generically for multiple archs unless I am missing something?
>
> IIRC, only memory assigned to/onlined to a ZONE is represented in the
> pgdat node span. E.g., not offline memory blocks.

So this dovetails somewhat with Will's idea. What if we populated
node_data for "offline" ranges? I started there, but then saw
ARCH_KEEP_MEMBLOCK and thought it would be safer to just teach
phys_to_target_node() to use that rather than update other code paths
to expect node_data might not always reflect online data.

> Esp., when hotplugging + onlining consecutive memory, there won't really
> be any intersections in most cases if I am not wrong. It would not be
> "intersection" but rather "closest fit".
>
> With overlapping nodes it's even more unclear. Which one to pick?

In the overlap case you get what you get. Some signal is better than
the noise of a dummy function. The consequences of picking the wrong
node might be that the kernel can't properly associate a memory range
to its performance data tables in firmware, but then again firmware
messed up with an overlapping node definition in the first instance.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
