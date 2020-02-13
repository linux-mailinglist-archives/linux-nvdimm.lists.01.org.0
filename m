Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78115CD1D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 22:20:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D88D510FC33F3;
	Thu, 13 Feb 2020 13:23:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42B5310FC33F1
	for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 13:23:21 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id p8so7022422oth.10
        for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 13:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdeMRXcHv3gdD6qpW26HbSbVWn9VbRyn5M5xWNM2dDM=;
        b=Hyyvv8vojMc3YBTypTl8uC2uiKKtwZNhOmrxbaeG1vuEwpYOBWtUCtYYg0lYEql4zN
         iQhsW++w/ZAYQx4DWEAHt6KFC1Osk7+fnv+N10orqg0hMBpJ5upOM9vYaC6HThBEWUo4
         x8lSTdVsID1n9sDXHKjdP0wZOyi3I5KgZohTPQEZ6SvZkK0KIraYfFXgJWT7EBHym7lD
         qHWVKcYmF/3JOR5hSfhX8LfGU7oXROkRyuZ7d8fCAITSP1r0DKZPxtU1HZtwQKrg56ck
         601ueLi8jx80f5FnP/FCE4wz5IyUxhpnFTQRgZhpic+9EvNZpOXw2+FeDBsFcyVW+NQO
         iecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdeMRXcHv3gdD6qpW26HbSbVWn9VbRyn5M5xWNM2dDM=;
        b=PNaPF9ox/zc/BSMn8VcjiBpH3IUlvSD9kksghwhXklkioYWYXRVvRUuUN4eCWFQI51
         MuXG8dj1q/3f9xC9c1vS/HAOz35rw1FxAc4DIezZtFx9KjUjbLDCnom2uKJ8yOJuml47
         dV8zLznadbXnD/xCyI+41XTxGUUuuHezde6Wn7lbCQsh5QweGF2NUVB4K8TJPqK47QN0
         3k7KhawrApq1/KEbvcAsfPz8Pk4POaJkeVGeDQ/5RTYd411dIAWaCtMJ+CT0EYIFsGkS
         SE7g182sNAvEh0n3WKvpP1RZQrYx6eQr7+1Mt9X6OBWyZ3Z9zgFSNZsyH1vKRb5/85ax
         KQEA==
X-Gm-Message-State: APjAAAX+pCBw+AEiHYyBfia5ADOSuF/H18lVHfYVyU5k/xpxOw2tYmiG
	qVTJi8isRtUaOpaCRF9MKFcazPZ0pmmTT03ZYOaNbA==
X-Google-Smtp-Source: APXvYqy/JTMiaK1YjeSUIRUgCDXzbRBoIVRbwxDW+6bmRuwC7016knDFFU+BtSvxGFlv/jMxkwnEe8Gedri67BtzpDA=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr14235067otm.247.1581628802976;
 Thu, 13 Feb 2020 13:20:02 -0800 (PST)
MIME-Version: 1.0
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200213093227.GA90266@gmail.com>
In-Reply-To: <20200213093227.GA90266@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 Feb 2020 13:19:51 -0800
Message-ID: <CAPcyv4hXpqrZ4jmgmjy9fH=3oHg0UDDU6xLGX2TVCgSS_xkq4w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] x86/mm: Introduce CONFIG_KEEP_NUMA
To: Ingo Molnar <mingo@kernel.org>
Message-ID-Hash: 7KKGI2WA4OWW2WNEE7DTMOHWFOGUWUOA
X-Message-ID-Hash: 7KKGI2WA4OWW2WNEE7DTMOHWFOGUWUOA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7KKGI2WA4OWW2WNEE7DTMOHWFOGUWUOA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 13, 2020 at 1:32 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Currently x86 numa_meminfo is marked __initdata in the
> > CONFIG_MEMORY_HOTPLUG=n case. In support of a new facility to allow
> > drivers to map reserved memory to a 'target_node'
> > (phys_to_target_node()), add support for removing the __initdata
> > designation for those users. Both memory hotplug and
> > phys_to_target_node() users select CONFIG_KEEP_NUMA to tell the arch to
> > maintain its physical address to numa mapping infrastructure post init.
> >
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: <x86@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/x86/mm/numa.c   |    6 +-----
> >  include/linux/numa.h |    6 ++++++
> >  mm/Kconfig           |    5 +++++
> >  3 files changed, 12 insertions(+), 5 deletions(-)
>
> The concept and the x86 portions look sane, just a few minor nits:
>
> >
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 99f7a68738f0..5289d9d6799a 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -25,11 +25,7 @@ nodemask_t numa_nodes_parsed __initdata;
> >  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> >  EXPORT_SYMBOL(node_data);
> >
> > -static struct numa_meminfo numa_meminfo
> > -#ifndef CONFIG_MEMORY_HOTPLUG
> > -__initdata
> > -#endif
> > -;
> > +static struct numa_meminfo numa_meminfo __initdata_numa;
> >
> >  static int numa_distance_cnt;
> >  static u8 *numa_distance;
> > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > index 20f4e44b186c..c005ed6b807b 100644
> > --- a/include/linux/numa.h
> > +++ b/include/linux/numa.h
> > @@ -13,6 +13,12 @@
> >
> >  #define      NUMA_NO_NODE    (-1)
> >
> > +#ifdef CONFIG_KEEP_NUMA
> > +#define __initdata_numa
> > +#else
> > +#define __initdata_numa __initdata
> > +#endif
> > +
> >  #ifdef CONFIG_NUMA
> >  int numa_map_to_online_node(int node);
> >  #else
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index ab80933be65f..001f1185eadf 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -139,6 +139,10 @@ config HAVE_FAST_GUP
> >  config ARCH_KEEP_MEMBLOCK
> >       bool
> >
> > +# Keep arch numa mapping infrastructure post-init.
>
> s/numa/NUMA
>
> Please also capitalize consistently in the rest of the series.
>
> > +config KEEP_NUMA
> > +     bool
>
>
> So most of our recent new NUMA options followed the naming pattern of:
>
>   CONFIG_NUMA_*
>
> Such as CONFIG_NUMA_BALANCING or CONFIG_NUMA_EMU.
>
> So I'd suggesting naming it to CONFIG_NUMA_KEEP, or, a bit more
> descriptively, such as CONFIG_NUMA_KEEP_MAPPING or such?
>
> 'Keeping NUMA' is kind of lame - of course we keep NUMA. ;-)

Ok, I settled on CONFIG_NUMA_KEEP_MEMINFO, and will fix up the
lowercase "numa" instances in the set.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
