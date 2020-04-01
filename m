Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A119A7AD
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 10:48:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF71D10FC3BAC;
	Wed,  1 Apr 2020 01:49:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4810510FC3BAA
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 01:49:18 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cf14so28670123edb.13
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=feZj/1ocB6XIjJoDVsEEUrA2KaXFHt0B9wSHktP2ddQ=;
        b=Bh1JR39j+h1CpltTDW6HGFEOaXTLaNjNFTs/HHcXupyutEFcwNSNmspuDLCGf1ngc3
         3JpOjmwFyMJKqlOxTzogrVowaOb1QIi3j8ZxAAP5+dTIDs2wrDYNiFzAC1pNenb81J4x
         Y0o8J2WvYge0HdtQtAaBdaJuC6fhVWSw5yAjGewymen6zoiqepG1Pu2f2Syh3qjkbnM9
         63NpYqgZavpVqDdE02NRa8sgSS+1zoZJSGdCFyiEDE6u1Wuo2Qc2ha1yyqNmK6L2A0tu
         +GaivKSH2OYfiaNQXJyXBJPXwLpUUs6miQI82ISI/kufkqup77wKyM4fD8QUJdtlbmOJ
         Hi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=feZj/1ocB6XIjJoDVsEEUrA2KaXFHt0B9wSHktP2ddQ=;
        b=VsKauORKbCWtjKTj1mXNODpykYvJLq975jFFvso4PxfiE9U31mYM4iebpj0x6B4bYx
         cHPOSjqXu1em1Tc8Ku6VqgmySRfMlMvK8+gN9Dx88PBHkvWT/6AFHsIHTasHAnJ3CTzO
         QbGkrBu0ZxjCB3U0a6R03rzxFfpsCt2e9m6FbRa4GtWPdOkxN6xVcODK09AcotOyqc1A
         OErcljCpAbQfuk5c6FVam6IazdhtqWwLXV76I7B1pJIVIH2CaVXmSzUduRjpQVp4s+tz
         pkP+LdXDEHiJDPwnFFy4dWgc9R1NAcRscDGR5d/9q++aDWoQGeHJubd7k6e4Hb/nB0mc
         PTKA==
X-Gm-Message-State: ANhLgQ1oC+PieV5IjJc7Eh2CmYyCH9AHhhF00cjgzQq4sp3u9bGhcYa4
	Iqtwh461O0m7yTfNM2iOYqCZiS/I+BEc7OGO/5eI+A==
X-Google-Smtp-Source: ADFU+vuVdufBykICW7DqF15W3KALGotPW1gMa6p2yo6taAqlQuWcuvysMS1tCXsRtLbaLnYvh0bX4T16tZYwkhRj3fU=
X-Received: by 2002:a05:6402:b17:: with SMTP id bm23mr19586972edb.165.1585730907196;
 Wed, 01 Apr 2020 01:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-3-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-3-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 01:48:16 -0700
Message-ID: <CAPcyv4h9uDxHDb0iN+zwhPB=By8Ps8cwTyipf6b64v+ruzhchg@mail.gmail.com>
Subject: Re: [PATCH v4 02/25] mm/memory_hotplug: Allow check_hotplug_memory_addressable
 to be called from drivers
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: KFIEKKY67XUEM7VEONODYMLZPLOYBKI5
X-Message-ID-Hash: KFIEKKY67XUEM7VEONODYMLZPLOYBKI5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KFIEKKY67XUEM7VEONODYMLZPLOYBKI5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> When setting up OpenCAPI connected persistent memory, the range check may
> not be performed until quite late (or perhaps not at all, if the user does
> not establish a DAX device).
>
> This patch makes the range check callable so we can perform the check while
> probing the OpenCAPI Persistent Memory device.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  include/linux/memory_hotplug.h | 5 +++++
>  mm/memory_hotplug.c            | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f4d59155f3d4..9a19ae0d7e31 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -337,6 +337,11 @@ static inline void __remove_memory(int nid, u64 start, u64 size) {}
>  extern void set_zone_contiguous(struct zone *zone);
>  extern void clear_zone_contiguous(struct zone *zone);
>
> +#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> +int check_hotplug_memory_addressable(unsigned long pfn,
> +                                    unsigned long nr_pages);
> +#endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */

Let's move this to include/linux/memory.h with the other
CONFIG_MEMORY_HOTPLUG_SPARSE declarations, and add a dummy
implementation for the CONFIG_MEMORY_HOTPLUG_SPARSE=n case.

Also, this patch can be squashed with the next one, no need for it to
be stand alone.


> +
>  extern void __ref free_area_init_core_hotplug(int nid);
>  extern int __add_memory(int nid, u64 start, u64 size);
>  extern int add_memory(int nid, u64 start, u64 size);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0a54ffac8c68..14945f033594 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -276,8 +276,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>         return 0;
>  }
>
> -static int check_hotplug_memory_addressable(unsigned long pfn,
> -                                           unsigned long nr_pages)
> +int check_hotplug_memory_addressable(unsigned long pfn,
> +                                    unsigned long nr_pages)
>  {
>         const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
>
> --
> 2.24.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
