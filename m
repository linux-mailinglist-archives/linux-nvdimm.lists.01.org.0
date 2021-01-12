Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD0A2F3C3E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 23:20:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67B4C100ED4AB;
	Tue, 12 Jan 2021 14:20:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D87D100ED49F
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 14:20:51 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n26so219644eju.6
        for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 14:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTIoaNVkYWwgsEp9LMpgcyP45XmLf/k0fgDnsh1vc7Q=;
        b=OixaNP0KdqpjiYzt/2c0kRVvoc3YdMlU0G7M1jrAHP+WZLnsjLBn2HI2a4KD49XU8k
         QOksFhFZvPS61lNudfnotINI5/cED2AEfo/wlKhLUj45QyiV9pMKxNRMNo/5EuhDU4j8
         EPbnWKZ/3CdJIIUTRFjW/ZcaC6of0+NgM8eBCYsOhdMFQdiDdlNFsUvrib8myhSkD5hh
         MswOsS5zCgxRwd2dIJPjTXvxwv7PmuV9u48+GD+XLG9Zc1m6IZNtxZFD3yickfaAsUgo
         dg/vxNFR2H+MEZuwdoll7yOfU8nPSmp4m9DB+yASQzXhOC5Hg8KcoG0rXJHqK/awpiL/
         MN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTIoaNVkYWwgsEp9LMpgcyP45XmLf/k0fgDnsh1vc7Q=;
        b=GMTRrnwbfStvpnmGKp6nETkjx3Mz1iUp05ePTpFdIJytvF1V4GNKUn/FgG0ij1LYgA
         RIHUBai7Yjve/U4HsTTFrTyJ/iIBjkoeUsys1LoFRuNySzXTdNRxQfTiUI4wV0aT6LCb
         p67lFAU2javalNz35fdbS08oEAEBEFKdhiJqGy0mtZEECwTLiqljWDymqRCEvfbvYMS3
         28HxJNOQXXFVRRffsXiqVFs/lFOwVMQo8QhDWBelorzGPYVvBUdWAzd2Lltu81IYd3X+
         QPIHBcctQEn+AvETwpMQk0wKP/G2jF3vmOmM7BdQ3fhBvCG1/93hQPAAb+PIrS3zFeV8
         ZnqA==
X-Gm-Message-State: AOAM531OaWccokL8a0Gt34VnEc1hMFXJG8IFyZE2aUlTeep2JYIUH4/E
	COM22L+VvnDZwt2kBw0wGKoIaDON9xxL+9BnsaV63g==
X-Google-Smtp-Source: ABdhPJw+Gi32iWw2zRGAmyQWdcoaZTNn+kztXT/ZCK7VAyrtTePrZuY+wMdQpD/H7tRkOKeEi/FfHmD3PDqzCNyOS5A=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr647229ejz.45.1610490049654;
 Tue, 12 Jan 2021 14:20:49 -0800 (PST)
MIME-Version: 1.0
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044408728.1482714.9086710868634042303.stgit@dwillia2-desk3.amr.corp.intel.com>
 <0586c562-787c-4872-4132-18a49c3ffc8e@redhat.com>
In-Reply-To: <0586c562-787c-4872-4132-18a49c3ffc8e@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 12 Jan 2021 14:20:40 -0800
Message-ID: <CAPcyv4hd_Bt-krepaV2rVaKLQEKEWK+gGvk_ZbeD-_tk2+hn8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: Teach pfn_to_online_page() to consider
 subsection validity
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: 4YVOVWE5754ORKBZWO7HAZYHOIESJGIP
X-Message-ID-Hash: 4YVOVWE5754ORKBZWO7HAZYHOIESJGIP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4YVOVWE5754ORKBZWO7HAZYHOIESJGIP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 12, 2021 at 1:53 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 12.01.21 10:34, Dan Williams wrote:
> > pfn_section_valid() determines pfn validity on subsection granularity.
> >
> > pfn_valid_within() internally uses pfn_section_valid(), but gates it
> > with early_section() to preserve the traditional behavior of pfn_valid()
> > before subsection support was added.
> >
> > pfn_to_online_page() wants the explicit precision that pfn_valid() does
> > not offer, so use pfn_section_valid() directly. Since
> > pfn_to_online_page() already open codes the validity of the section
> > number vs NR_MEM_SECTIONS, there's not much value to using
> > pfn_valid_within(), just use pfn_section_valid(). This loses the
> > valid_section() check that pfn_valid_within() was performing, but that
> > was already redundant with the online check.
> >
> > Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
> > Cc: Qian Cai <cai@lca.pw>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Reported-by: David Hildenbrand <david@redhat.com>
> > ---
> >  mm/memory_hotplug.c |   16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 55a69d4396e7..a845b3979bc0 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -308,11 +308,19 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
> >  struct page *pfn_to_online_page(unsigned long pfn)
> >  {
> >       unsigned long nr = pfn_to_section_nr(pfn);
> > +     struct mem_section *ms;
> > +
> > +     if (nr >= NR_MEM_SECTIONS)
> > +             return NULL;
> > +
> > +     ms = __nr_to_section(nr);
> > +     if (!online_section(ms))
> > +             return NULL;
> > +
> > +     if (!pfn_section_valid(ms, pfn))
> > +             return NULL;
>
> That's not sufficient for alternative implementations of pfn_valid().
>
> You still need some kind of pfn_valid(pfn) for alternative versions of
> pfn_valid(). Consider arm64 memory holes in the memmap. See their
> current (yet to be fixed/reworked) pfn_valid() implementation.
> (pfn_valid_within() is implicitly active on arm64)
>
> Actually, I think we should add something like the following, to make
> this clearer (pfn_valid_within() is confusing)
>
> #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>         /* We might have to check for holes inside the memmap. */
>         if (!pfn_valid())
>                 return NULL;
> #endif

Looks good to me, I'll take Oscar's version that uses IS_ENABLED().

Skipping the call to pfn_valid() saves 16-bytes of code text on x86_64.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
