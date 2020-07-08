Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F57217DCB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 05:56:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AC14D110BA971;
	Tue,  7 Jul 2020 20:56:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3D384110B96A5
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 20:56:49 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b15so40449619edy.7
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jul 2020 20:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTn2jvAGhNEebX/31coeKRgrATf42VwRs1IekEU/wXY=;
        b=IvrsAU1XjAgKBxDdSMgPJ+oYemeR6oDH6pX66ZmNmiZU44vQoOWODIYN2eHWUIyLXe
         UuVyPRljljj0LRyhYbgQt1WN/QXw7EsZMi1Jk1hFbg4BvfiGXKD9fAaMW/zC07paErB5
         S9jvB+SYSzWCQRqViLX58i/kNbTyi9kFaozTSWMRD+Lfz0vBJCuaqApnYldg5SEk7aE9
         ErmtS2BuhfpxZOaNbMAZ9U+3n2opU/xUPnebTc7qaecBFIRC820qr/uNOU6kewfpctqc
         bNpaH4SoMJxAfRnDHXeifKcni3JNtLlTflaLn/r9LxxJsFq23VujziihbTvG3BhyHixZ
         0BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTn2jvAGhNEebX/31coeKRgrATf42VwRs1IekEU/wXY=;
        b=YhnYOsj2S27zpktYH9v1FgR56zv9ouoteEh3hUnw3Hh7ef2ex83VxjsA9fc41ad1RL
         UGckaZG0Yrc9Cbw6PYiJb8q6ZRHmJala02h+m4bADUfl/9j2yr3tgiXCUlJyFIN1aF9F
         CPOvrxGrruLtT8fHnIYlRQ3pzToNNSPNdPV1ORaZ0JtS+nq8hTVI4mkOmdO24/wdqWMz
         ZoBkTYUrBeSUXoEo34UiyNOaMSUxT5ancV0/vBgYxsnTSIqT7OFbAA/S9sbTFj28iuXD
         sPJMHA6IavwaftB64KGDbWZwdReY7On9RydmcZ/VLtzfUyYpU59RCVBYNPeNJhfEnlxJ
         ncUA==
X-Gm-Message-State: AOAM53123tDJ0QWVr9TNP0PtpD+kmhMZUd1UNOMRAeu8iSur8IXI45CW
	8bo6G9aA85S/vKcr8iv2utIU1JlBeCDUySKDfszM4g==
X-Google-Smtp-Source: ABdhPJz9cJ6Qq3Vxkoam4dKJq6AdNY7Fw9Oa6InR0v2bOalI2tEHRvWbG4COa7ovxq4MW9UNDDuaSdNEj5xAhsCfVyk=
X-Received: by 2002:a50:a1e7:: with SMTP id 94mr63116438edk.165.1594180607875;
 Tue, 07 Jul 2020 20:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jul 2020 20:56:36 -0700
Message-ID: <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To: Justin He <Justin.He@arm.com>
Message-ID-Hash: GJURWMSKB7B5XVVIRCYXUPL5QSYODXAO
X-Message-ID-Hash: GJURWMSKB7B5XVVIRCYXUPL5QSYODXAO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GJURWMSKB7B5XVVIRCYXUPL5QSYODXAO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 7, 2020 at 7:20 PM Justin He <Justin.He@arm.com> wrote:
>
> Hi Michal and David
>
> > -----Original Message-----
> > From: Michal Hocko <mhocko@kernel.org>
> > Sent: Tuesday, July 7, 2020 7:55 PM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> > <will@kernel.org>; Dan Williams <dan.j.williams@intel.com>; Vishal Verma
> > <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Andrew
> > Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>;
> > Baoquan He <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>; linux-
> > arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > mm@kvack.org; linux-nvdimm@lists.01.org; Kaly Xin <Kaly.Xin@arm.com>
> > Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid
> > as EXPORT_SYMBOL_GPL
> >
> > On Tue 07-07-20 13:59:15, Jia He wrote:
> > > This exports memory_add_physaddr_to_nid() for module driver to use.
> > >
> > > memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> > > NUMA_NO_NID is detected.
> > >
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Jia He <justin.he@arm.com>
> > > ---
> > >  arch/arm64/mm/numa.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > > index aafcee3e3f7e..7eeb31740248 100644
> > > --- a/arch/arm64/mm/numa.c
> > > +++ b/arch/arm64/mm/numa.c
> > > @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> > >
> > >  /*
> > >   * We hope that we will be hotplugging memory on nodes we already know
> > about,
> > > - * such that acpi_get_node() succeeds and we never fall back to this...
> > > + * such that acpi_get_node() succeeds. But when SRAT is not present,
> > the node
> > > + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback
> > option.
> > >   */
> > >  int memory_add_physaddr_to_nid(u64 addr)
> > >  {
> > > -   pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n",
> > addr);
> > >     return 0;
> > >  }
> > > +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >
> > Does it make sense to export a noop function? Wouldn't make more sense
> > to simply make it static inline somewhere in a header? I haven't checked
> > whether there is an easy way to do that sanely bu this just hit my eyes.
>
> Okay, I can make a change in memory_hotplug.h, sth like:
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -149,13 +149,13 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>               struct mhp_params *params);
>  #endif /* ARCH_HAS_ADD_PAGES */
>
> -#ifdef CONFIG_NUMA
> -extern int memory_add_physaddr_to_nid(u64 start);
> -#else
> +#if !defined(CONFIG_NUMA) || !defined(memory_add_physaddr_to_nid)
>  static inline int memory_add_physaddr_to_nid(u64 start)
>  {
>         return 0;
>  }
> +#else
> +extern int memory_add_physaddr_to_nid(u64 start);
>  #endif
>
> And then check the memory_add_physaddr_to_nid() helper on all arches,
> if it is noop(return 0), I can simply remove it.
> if it is not noop, after the helper,
> #define memory_add_physaddr_to_nid
>
> What do you think of this proposal?

Especially for architectures that use memblock info for numa info
(which seems to be everyone except x86) why not implement a generic
memory_add_physaddr_to_nid() that does:

int memory_add_physaddr_to_nid(u64 addr)
{
        unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
        int nid;

        for_each_online_node(nid) {
                get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
                if (pfn >= start_pfn && pfn <= end_pfn)
                        return nid;
        }
        return NUMA_NO_NODE;
}
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
