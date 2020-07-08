Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260AD218034
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 09:04:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 85E25110BDB37;
	Wed,  8 Jul 2020 00:04:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C351110BDB36
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 00:04:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w6so49234583ejq.6
        for <linux-nvdimm@lists.01.org>; Wed, 08 Jul 2020 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8DJkdquRNNePQZNFg7Hkhjp0N1sn7vgJTtn21OuChM=;
        b=SACF4faTk3zv/4UtH39KJpY1EyVX+rh7ao155Gc/PXjG8TrgshGBUjBtrUqQ+9gs7i
         L5vmTlibESrKgbfMTCGhiWtgPrAMhhcnkOHRM2Ia2Y8Jc9V+3LCyG/yJumUkViP3L7Pb
         a2I7dIXDDdaZ0Cuyka9u74Vv9AS609TdrAwDEKA4Wo08zzzHJdpen+IvOXLWzV+1McID
         uEfP5IZ8K/A1vsTLrUkqSpWu6J8+YyNaxkI3zkQBXIxOdEJ349cAM/R1VYOnd962N5Or
         Sr3whbUU5C6EZxDmca1o0Y6BVT+YPiq8mhQFC+bo3h9VIMzxObom+Gcbl8Fv4uHNxRxt
         MfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8DJkdquRNNePQZNFg7Hkhjp0N1sn7vgJTtn21OuChM=;
        b=oiLxTv8a0GTysIJkesjnd+74DQ4Sd5EcFitVYoGtuevV9HJ6IOKrvoP6RyhcgafuCn
         JTWqK9UHIq3E6RjU4I5G1imhQ/NN+MEqNqtbNJ4AO16ZIn3hny2Q5fxufKDS3Gd7yU/1
         bB5inQKbszVs8T7wuqHTzInuOHYWmnHXcXHRR4QGk2CnRFlqEH41Cs4fjGkeEciOcF3E
         YKd02Sjh5S0+ghl+R3UatPo7cIsOkgOFdtig4/XbPMhGWevvvagEJnAW3pLXYEDMLppy
         1pTIVWwPfobV1tojByF0ez/dPptVsPFapbHX8KQNcHG+Gy3dzZDiPbjn70UJCD0VPyn3
         cOmA==
X-Gm-Message-State: AOAM531qkLzO4wiPwyh5qKMj76psk/1KHlOmjRxee3zxSSJLT2Lsdd6u
	rFlOfdIyvtQmfuwczoGRs4vBvwdDqe0te1O7Dz48vg==
X-Google-Smtp-Source: ABdhPJyRGR0MQswLR49lOWdnIujwwLeu+bZjq5kGBbvha0J5qEn/N4WpOBb/iGUCPM+O4K8cgy9DfyN1wDvRoKcTF84=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr50016102ejb.124.1594191857256;
 Wed, 08 Jul 2020 00:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
 <AM6PR08MB4069D0D1FD8FB31B6A56DDB5F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ivyJsyzcbkBWcqBYZMx3VdJF7+VPCNs177DU2rYqtz_A@mail.gmail.com>
 <20200708062217.GE386073@linux.ibm.com> <c4ee0a94-c980-80ca-c43d-15729e1a3663@redhat.com>
In-Reply-To: <c4ee0a94-c980-80ca-c43d-15729e1a3663@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 8 Jul 2020 00:04:06 -0700
Message-ID: <CAPcyv4inaZgmv=S36_DofA9prKhWg4KBNPkTvzSALO6Vtb9ddw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: TQM3VI6ZPDUSJKZJUNQ6FSC3A3CRH75D
X-Message-ID-Hash: TQM3VI6ZPDUSJKZJUNQ6FSC3A3CRH75D
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mike Rapoport <rppt@linux.ibm.com>, Justin He <Justin.He@arm.com>, Michal Hocko <mhocko@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TQM3VI6ZPDUSJKZJUNQ6FSC3A3CRH75D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 7, 2020 at 11:59 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.07.20 08:22, Mike Rapoport wrote:
> > On Tue, Jul 07, 2020 at 09:27:43PM -0700, Dan Williams wrote:
> >> On Tue, Jul 7, 2020 at 9:08 PM Justin He <Justin.He@arm.com> wrote:
> >> [..]
> >>>> Especially for architectures that use memblock info for numa info
> >>>> (which seems to be everyone except x86) why not implement a generic
> >>>> memory_add_physaddr_to_nid() that does:
> >>>>
> >>>> int memory_add_physaddr_to_nid(u64 addr)
> >>>> {
> >>>>         unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
> >>>>         int nid;
> >>>>
> >>>>         for_each_online_node(nid) {
> >>>>                 get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> >>>>                 if (pfn >= start_pfn && pfn <= end_pfn)
> >>>>                         return nid;
> >>>>         }
> >>>>         return NUMA_NO_NODE;
> >>>> }
> >>>
> >>> Thanks for your suggestion,
> >>> Could I wrap the codes and let memory_add_physaddr_to_nid simply invoke
> >>> phys_to_target_node()?
> >>
> >> I think it needs to be the reverse. phys_to_target_node() should call
> >> memory_add_physaddr_to_nid() by default, but fall back to searching
> >> reserved memory address ranges in memblock. See phys_to_target_node()
> >> in arch/x86/mm/numa.c. That one uses numa_meminfo instead of memblock,
> >> but the principle is the same i.e. that a target node may not be
> >> represented in memblock.memory, but memblock.reserved. I'm working on
> >> a patch to provide a function similar to get_pfn_range_for_nid() that
> >> operates on reserved memory.
> >
> > Do we really need yet another memblock iterator?
> > I think only x86 has memory that is not in memblock.memory but only in
> > memblock.reserved.
>
> Reading about abusing the memblock allcoator once again in memory
> hotplug paths makes me shiver.

Technical reasoning please?

arm64 numa information is established from memblock data. It seems
counterproductive to ignore that fact if we're already touching
memory_add_physaddr_to_nid() and have a use case for a driver to call
it.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
