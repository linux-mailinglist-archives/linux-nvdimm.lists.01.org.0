Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB0218C42
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 17:50:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7BBFA110BDB36;
	Wed,  8 Jul 2020 08:50:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F3C111107E168
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 08:50:16 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n26so37162068ejx.0
        for <linux-nvdimm@lists.01.org>; Wed, 08 Jul 2020 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EiYlSj53kAa10Re22X7U17L3JibixRtXdcfzQAF4RI=;
        b=eNptn699SYep16X4CoHPkgiGM5zR/mQnI3Mzfc9eEIY75pcRdSypj0pJntEDR4CHvS
         AogyjaLxg5b7iP5tvNUzz/jAPzLjWzHgZoJOeYZCaJYfJsP54+JncPgdDwCXaNdf5kDH
         K1mIGvj60uqPjUQAobqbGoJIlXdqdUK/+fD1DMteEv5JNXCo5U65YhxhYzb+IlmrLu27
         E3IX7kZcsTEMvjr4RRH6V4KWQ0rfrgXmeEmYl93SiTjzlboiF4oiFV3u04EJoo9Su1be
         U4kIpVOKeOQn52xh78cieCUwmNTeMkzDU3sr3r03UQCxfqxMjQyf2Q76ItzqDLCVZDbq
         Bqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EiYlSj53kAa10Re22X7U17L3JibixRtXdcfzQAF4RI=;
        b=uXzXvQC68R7eZ0YXzRiYW2PG/3ibKgkMFF7O9Lc763zpDdyB0BefrS+OkMIlrWI4EP
         7Ul3+Pj1DOXrxIntGVrdqlKKAMiIS24n+B4ZTR+D/K9xbu8YaUL6JVcTJGYYqGwHV8DY
         JrsKjHJVGvud9abnW2b5XNeUkfNXHfsD/HwZWCZxBP092bISB/f4d9X59kgfrYTbOo/w
         /osDcZ1QeGHNvlaEYKk43Tp8AxDkmYvX26fsFaogCZ6xDqbPzQLdj9d/+S415l83h1Eq
         imxwRFxspL5kMR85wP4BbLlJqUxvxMZYMkXI5KJuKDxdB4eBEIzeGAHFTPWBKtblzRQG
         B91w==
X-Gm-Message-State: AOAM5300cn7yvh04jg/U5ZpDVfnDcUuFtwuZJUyTQ3ZFxHv0Juvyb34+
	mkL3aByS+sSFf5r8i3gYqXiMYz8nwmRx8YgpOXtWWQ==
X-Google-Smtp-Source: ABdhPJw/8Kbx1/bdnv7iOEbWdknY8BbvvUvThRPw7aqvnIeHYlAeIqwGVHirPg4m6UtNvCENnXVgYQiwBwoexLKostU=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr51820947ejb.124.1594223414714;
 Wed, 08 Jul 2020 08:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200707180043.GA386073@linux.ibm.com> <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
 <20200708052626.GB386073@linux.ibm.com> <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
 <CAPcyv4jyk_tkDRewTVvRAv0g4LwemEyKYQyuJBXkF4VuYrBdrw@mail.gmail.com>
 <999ea296-4695-1219-6a4d-a027718f61e5@redhat.com> <20200708083951.GH386073@linux.ibm.com>
 <cdb0510e-4271-1c97-4305-5fd52da282dc@redhat.com> <20200708091520.GE128651@kernel.org>
 <df0e5f64-10bc-4c3c-a515-288a6f501065@redhat.com> <20200708094549.GA781326@linux.ibm.com>
 <98166184-3aaf-479e-bfb3-fc737f4ac98d@redhat.com>
In-Reply-To: <98166184-3aaf-479e-bfb3-fc737f4ac98d@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 8 Jul 2020 08:50:03 -0700
Message-ID: <CAPcyv4guv2wjLDNJ4VN+4ZKiSC-FDvxoRxy5_OvUJ5C1tJsAGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: WOFHQSB24RVPL5IQ3YQBTD3ZZ67V5EAM
X-Message-ID-Hash: WOFHQSB24RVPL5IQ3YQBTD3ZZ67V5EAM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WOFHQSB24RVPL5IQ3YQBTD3ZZ67V5EAM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 8, 2020 at 3:04 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.07.20 11:45, Mike Rapoport wrote:
> > On Wed, Jul 08, 2020 at 11:25:36AM +0200, David Hildenbrand wrote:
> >> On 08.07.20 11:15, Mike Rapoport wrote:
> >>>>>>>>
> >>>>> But on more theoretical/fundmanetal level, I think we lack a generic
> >>>>> abstraction similar to e.g. x86 'struct numa_meminfo' that serves as
> >>>>> translaton of firmware supplied information into data that can be used
> >>>>> by the generic mm without need to reimplement it for each and every
> >>>>> arch.
> >>>>
> >>>> Right. As I expressed, I am not a friend of using memblock for that, and
> >>>> the pgdat node span is tricky.
> >>>>
> >>>> Maybe abstracting that x86 concept is possible in some way (and we could
> >>>> restrict the information to boot-time properties, so we don't have to
> >>>> mess with memory hot(un)plug - just as done for numa_meminfo AFAIKS).
> >>>
> >>> I agree with pgdat part and disagree about memblock. It already has
> >>> non-init physmap, why won't we add memblock.memory to the mix? ;-)
> >>
> >> Can we generalize and tweak physmap to contain node info? That's all we
> >> need, no? (the special mem= parameter handling should not matter for our
> >> use case, where "physmap" and "memory" would differ)
> >
> > TBH, I have only random vague thoughts at the moment. This might be an
> > option. But then we need to enable physmap on !s390, right?
>
> Yes, looks like it.
>
> >
> >>> Now, seriously, memblock already has all the necessary information about
> >>> the coldplug memory for several architectures. x86 being an exception
> >>> because for some reason the reserved memory is not considered memory
> >>> there. The infrastructure for quiering and iterating memory regions is
> >>> already there. We just need to leave out the irrelevant parts, like
> >>> memblock.reserved and allocation funcions.
> >>
> >> I *really* don't want to mess with memblocks on memory hot(un)plug on
> >> x86 and s390x (+other architectures in the future). I also thought about
> >> stopping to create memblocks for hotplugged memory on arm64, by tweaking
> >> pfn_valid() to query memblocks only for early sections.
> >>
> >> If "physmem" is not an option, can we at least introduce something like
> >> ARCH_UPDTAE_MEMBLOCK_ON_HOTPLUG to avoid doing that on x86 and s390x for
> >> now (and later maybe for others)?
> >
> > I have to do more memory hotplug howework to answer that ;-)
> >
> > My general point is that we don't have to reinvent the wheel to have
> > coldplug memory representation, it's already there. We just need a way
> > to use it properly.
>
> Yes, I tend to agree. Details to be clarified :)

I'm not quite understanding the concern, or requirement about
"updating memblock" in the hotplug path. The routines
memory_add_physaddr_to_nid() and phys_to_target_node() are helpers to
interrogate platform-firmware numa info through a common abstraction.
They place no burden on the memory hotplug code they're just used to
see if a hot-added range lies within an existing node span when
platform-firmware otherwise fails to communicate a node. x86 can
continue to back those helpers with numa_meminfo, arm64 can use a
generic memblock implementation and other archs can follow the arm64
example if they want better numa answers for drivers.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
