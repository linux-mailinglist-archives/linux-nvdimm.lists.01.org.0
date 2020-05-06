Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8B1C723B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 May 2020 15:55:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C4C301162F7BD;
	Wed,  6 May 2020 06:53:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B5A961162F7BB
	for <linux-nvdimm@lists.01.org>; Wed,  6 May 2020 06:53:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so2774584wma.4
        for <linux-nvdimm@lists.01.org>; Wed, 06 May 2020 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3oAtPFs43ESjLsbZr3Dpn642+6yy2HyqbhMQ/uWkgQ=;
        b=QBtT3US2wB0+P6qkUKEHcf+qSYLvrcyiOywAusoUhWPzr+yVeCq3cKgKK1janaInDI
         dfja6C/g2al0FlC939i/E6rMEXPK6b+QAxogY2/5mxCX8F8zNn0l+X7vS9+K+4Ul93Sx
         K9NBGbnft+iPVBlXY5Scy5cJ6o3XdgR2f2OYVh+Yj9vGvLm0CqyshvS9n7SSAsj71eLs
         wILnnLs1o3F5G1sqJwlCOjJTjcU2fcuP38XwFTRBf0inWlXKgCq/uICcR3YtO+vFNDtm
         O+Iq4NvrvxUoMyQufUEU6bYrHeMt46/YA8wSAVLZSBtZFdTe26OjpYFEmGnfWJdSlSQ9
         uNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3oAtPFs43ESjLsbZr3Dpn642+6yy2HyqbhMQ/uWkgQ=;
        b=IhqXfZhaE1NDP7NoCI4ncarWuayL4VEbM8tKv3wHgGwkyNniziSeHbbJW1KRQFVdNh
         xgSqRY/0AeWPznfKt0D0CU6zQxIvGYY1K4EJ4gDGqy0KDct7r4Hkljs29HWE+qpI90Mn
         bC7wb9lZ8jRXnLEkNbmDAOQ+DaEIcUYdKCirXkhuKexDHJ5CLdoGiRUJo0/Wtoiz/lrc
         Ctd9sftoS/MZZXxp0fq5FXVpCSywZymFtjOSZSYDOLu6cHbYogoiDMHb12vTbVLfhFHc
         lQkpR+MM8PCgF9dYkk41Jl1CxGaGFC6YScGMb4VBSKFJ2uNBvwU5kV2IS4mBmGoRZ6iE
         NXWg==
X-Gm-Message-State: AGi0PubJGGEylUcH6O2D06+ixPXBk6iZphfediA+6XiO19+u2lXBmxzX
	lL4ipRUC8MLQqjJSrTujgR3PBzchmNzZmTjCN10=
X-Google-Smtp-Source: APiQypJOGE3rBsb/5sZNtnJekxBb8v8ckBwOqmMu2T2KcXkbgMCt9aqXpQAg4pdJ9tFju7ov96os4f3GqWLY0f4F8LQ=
X-Received: by 2002:a1c:7f91:: with SMTP id a139mr4338753wmd.164.1588773340849;
 Wed, 06 May 2020 06:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200504190227.18269-1-david@redhat.com> <20200504190227.18269-4-david@redhat.com>
In-Reply-To: <20200504190227.18269-4-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 6 May 2020 15:55:29 +0200
Message-ID: <CAM9Jb+h0VKOU5dSZ7ChzW_Z=tG+UGq-cY7ePPRQpFS1-GHZOgg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] device-dax: Add memory via add_memory_driver_managed()
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: 3UI63FU6BDCOCBPEWYHIB7LANN3PLPGS
X-Message-ID-Hash: 3UI63FU6BDCOCBPEWYHIB7LANN3PLPGS
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, Pavel Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eric Biederman <ebiederm@xmission.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3UI63FU6BDCOCBPEWYHIB7LANN3PLPGS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Currently, when adding memory, we create entries in /sys/firmware/memmap/
> as "System RAM". This will lead to kexec-tools to add that memory to the
> fixed-up initial memmap for a kexec kernel (loaded via kexec_load()). The
> memory will be considered initial System RAM by the kexec'd kernel and
> can no longer be reconfigured. This is not what happens during a real
> reboot.
>
> Let's add our memory via add_memory_driver_managed() now, so we won't
> create entries in /sys/firmware/memmap/ and indicate the memory as
> "System RAM (kmem)" in /proc/iomem. This allows everybody (especially
> kexec-tools) to identify that this memory is special and has to be treated
> differently than ordinary (hotplugged) System RAM.
>
> Before configuring the namespace:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-33fffffff : namespace0.0
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> After configuring the namespace:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           148200000-33fffffff : dax0.0
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> After loading kmem before this change:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           150000000-33fffffff : dax0.0
>             150000000-33fffffff : System RAM
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> After loading kmem after this change:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           150000000-33fffffff : dax0.0
>             150000000-33fffffff : System RAM (kmem)
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> After a proper reboot:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           148200000-33fffffff : dax0.0
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> Within the kexec kernel before this change:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           150000000-33fffffff : System RAM
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> Within the kexec kernel after this change:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           148200000-33fffffff : dax0.0
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> /sys/firmware/memmap/ before this change:
>         0000000000000000-000000000009fc00 (System RAM)
>         000000000009fc00-00000000000a0000 (Reserved)
>         00000000000f0000-0000000000100000 (Reserved)
>         0000000000100000-00000000bffdf000 (System RAM)
>         00000000bffdf000-00000000c0000000 (Reserved)
>         00000000feffc000-00000000ff000000 (Reserved)
>         00000000fffc0000-0000000100000000 (Reserved)
>         0000000100000000-0000000140000000 (System RAM)
>         0000000150000000-0000000340000000 (System RAM)
>
> /sys/firmware/memmap/ after a proper reboot:
>         0000000000000000-000000000009fc00 (System RAM)
>         000000000009fc00-00000000000a0000 (Reserved)
>         00000000000f0000-0000000000100000 (Reserved)
>         0000000000100000-00000000bffdf000 (System RAM)
>         00000000bffdf000-00000000c0000000 (Reserved)
>         00000000feffc000-00000000ff000000 (Reserved)
>         00000000fffc0000-0000000100000000 (Reserved)
>         0000000100000000-0000000140000000 (System RAM)
>
> /sys/firmware/memmap/ after this change:
>         0000000000000000-000000000009fc00 (System RAM)
>         000000000009fc00-00000000000a0000 (Reserved)
>         00000000000f0000-0000000000100000 (Reserved)
>         0000000000100000-00000000bffdf000 (System RAM)
>         00000000bffdf000-00000000c0000000 (Reserved)
>         00000000feffc000-00000000ff000000 (Reserved)
>         00000000fffc0000-0000000100000000 (Reserved)
>         0000000100000000-0000000140000000 (System RAM)
>
> kexec-tools already seem to basically ignore any System RAM that's not
> on top level when searching for areas to place kexec images - but also
> for determining crash areas to dump via kdump. Changing the resource name
> won't have an impact.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/dax/kmem.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 3d0a7e702c94..5a645a24e359 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -65,7 +65,13 @@ int dev_dax_kmem_probe(struct device *dev)
>         new_res->flags = IORESOURCE_SYSTEM_RAM;
>         new_res->name = dev_name(dev);
>
> -       rc = add_memory(numa_node, new_res->start, resource_size(new_res));
> +       /*
> +        * Ensure that future kexec'd kernels will not treat this as RAM
> +        * automatically.
> +        */
> +       rc = add_memory_driver_managed(numa_node, new_res->start,
> +                                      resource_size(new_res),
> +                                      "System RAM (kmem)");
>         if (rc) {
>                 release_resource(new_res);
>                 kfree(new_res);
> --

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.25.3
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
