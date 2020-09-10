Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CECA2642E6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Sep 2020 11:53:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 33E5213C5DDC5;
	Thu, 10 Sep 2020 02:53:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 91983139F163B
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 02:53:19 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z25so6349710iol.10
        for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXhFARB7iWozLIle7rA/3dcPZ4H06GlQ94RnYK663hI=;
        b=RaAWdlZ2lNl7nXfiYHOzYx+GfQrIjOUeMopaIK9ZBs0wDY4n9MuS2XiRV1Y/YXkmLn
         pJuxxyIoxZUP+VIh+mMq5fznWJVa2G/6K4TBuF6L09rpsivWa9At4G4GDPd4IG0pQnzj
         TeAWq6VScWqV2pdBEmEZOJjchvKO1LlaqoLXIJxDrMoPoi3BVXKxeIQMgw4nvf8/fYyp
         HF3hT6ZzvVaGa1OATUDBMc8cXDdO4P4B7MbL6j6WMNFEMNtHGJXzBCDYlCO4v2DXT3vr
         noCvIYUFB8wvMPozut1JpXMO+4tRhnMrBpC3exgA4QHs5wNRvmdnYK2/e5bJc3A/K3Jw
         41Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXhFARB7iWozLIle7rA/3dcPZ4H06GlQ94RnYK663hI=;
        b=ZabeguNnMOvChV+oDZCgzlka6yrv1Avt0Ll/wuhqASr53NBgHbTc5oCN5eN9aJ/0Wa
         scImkyrzTkaq+Cxdcr5VK0bliLOimocV6QM++JAbqTav1jiHMW/Bfsk7b49USL+dBQps
         33B+CRwHPbSMsczVWUOJopP7I3KY53W1tPVGX5y+jGCfRNDg74mdGvlGVLhaFFQfwn4v
         qZHbrf+kPvYNUvjV1mgYsWo7/WTOabkpHmA7cgk1IZ93sbL+B8oHpd93ftZ+VsO6WzuQ
         6ykPq91rAuHiX0fopMYtAKuCHSZR2WFZ5zsDexV2xLPoU7tfM5a1+zzYpKli+Te2SZrO
         0lpQ==
X-Gm-Message-State: AOAM532MQxgPt61qi6pCkOcuyRlURyaBo4gFB5mQ8w78JPC+1UbvdaHB
	ASUifDdjSCcBVMmyZU1/nxCaCnL1wx++6euoNXw=
X-Google-Smtp-Source: ABdhPJxNu1IaH8bsVzGF36h3AxQcPj3XlD1+MCBc09C/TrTSOY0getsz2Hf3tGADGGHG07rp20HjQE3K915KSmBE84o=
X-Received: by 2002:a02:6623:: with SMTP id k35mr7996256jac.105.1599731597724;
 Thu, 10 Sep 2020 02:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200910091340.8654-1-david@redhat.com> <20200910091340.8654-4-david@redhat.com>
In-Reply-To: <20200910091340.8654-4-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 10 Sep 2020 11:53:06 +0200
Message-ID: <CAM9Jb+gpSKtQbyTZrecNQNXO+oLahuwZ9JkE+TWe4BvB1nZy3w@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm/memory_hotplug: prepare passing flags to
 add_memory() and friends
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: TGQTN6SSJMSLSAJZDUZJJSNKS4SUNGNT
X-Message-ID-Hash: TGQTN6SSJMSLSAJZDUZJJSNKS4SUNGNT
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Juergen Gross <jgross@suse.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
 , Jason Wang <jasowang@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, Pingfan Liu <kernelfans@gmail.com>, Nathan Lynch <nathanl@linux.ibm.com>, Libor Pechacek <lpechacek@suse.cz>, Anton Blanchard <anton@ozlabs.org>, Leonardo Bras <leobras.c@gmail.com>, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TGQTN6SSJMSLSAJZDUZJJSNKS4SUNGNT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> We soon want to pass flags, e.g., to mark added System RAM resources.
> mergeable. Prepare for that.
>
> This patch is based on a similar patch by Oscar Salvador:
>
> https://lkml.kernel.org/r/20190625075227.15193-3-osalvador@suse.de
>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Juergen Gross <jgross@suse.com> # Xen related part
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Libor Pechacek <lpechacek@suse.cz>
> Cc: Anton Blanchard <anton@ozlabs.org>
> Cc: Leonardo Bras <leobras.c@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-hyperv@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/powernv/memtrace.c       |  2 +-
>  arch/powerpc/platforms/pseries/hotplug-memory.c |  2 +-
>  drivers/acpi/acpi_memhotplug.c                  |  3 ++-
>  drivers/base/memory.c                           |  3 ++-
>  drivers/dax/kmem.c                              |  2 +-
>  drivers/hv/hv_balloon.c                         |  2 +-
>  drivers/s390/char/sclp_cmd.c                    |  2 +-
>  drivers/virtio/virtio_mem.c                     |  2 +-
>  drivers/xen/balloon.c                           |  2 +-
>  include/linux/memory_hotplug.h                  | 16 ++++++++++++----
>  mm/memory_hotplug.c                             | 14 +++++++-------
>  11 files changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index 13b369d2cc454..6828108486f83 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -224,7 +224,7 @@ static int memtrace_online(void)
>                         ent->mem = 0;
>                 }
>
> -               if (add_memory(ent->nid, ent->start, ent->size)) {
> +               if (add_memory(ent->nid, ent->start, ent->size, MHP_NONE)) {
>                         pr_err("Failed to add trace memory to node %d\n",
>                                 ent->nid);
>                         ret += 1;
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 0ea976d1cac47..e1c9fa0d730f5 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -615,7 +615,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>         nid = memory_add_physaddr_to_nid(lmb->base_addr);
>
>         /* Add the memory */
> -       rc = __add_memory(nid, lmb->base_addr, block_sz);
> +       rc = __add_memory(nid, lmb->base_addr, block_sz, MHP_NONE);
>         if (rc) {
>                 invalidate_lmb_associativity_index(lmb);
>                 return rc;
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index e294f44a78504..2067c3bc55763 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -207,7 +207,8 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>                 if (node < 0)
>                         node = memory_add_physaddr_to_nid(info->start_addr);
>
> -               result = __add_memory(node, info->start_addr, info->length);
> +               result = __add_memory(node, info->start_addr, info->length,
> +                                     MHP_NONE);
>
>                 /*
>                  * If the memory block has been used by the kernel, add_memory()
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 4db3c660de831..b4c297dd04755 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -432,7 +432,8 @@ static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
>
>         nid = memory_add_physaddr_to_nid(phys_addr);
>         ret = __add_memory(nid, phys_addr,
> -                          MIN_MEMORY_BLOCK_SIZE * sections_per_block);
> +                          MIN_MEMORY_BLOCK_SIZE * sections_per_block,
> +                          MHP_NONE);
>
>         if (ret)
>                 goto out;
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 7dcb2902e9b1b..896cb9444e727 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -95,7 +95,7 @@ int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>                  * this as RAM automatically.
>                  */
>                 rc = add_memory_driver_managed(numa_node, range.start,
> -                               range_len(&range), kmem_name);
> +                               range_len(&range), kmem_name, MHP_NONE);
>
>                 res->flags |= IORESOURCE_BUSY;
>                 if (rc) {
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 32e3bc0aa665a..3c0d52e244520 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -726,7 +726,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>
>                 nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
>                 ret = add_memory(nid, PFN_PHYS((start_pfn)),
> -                               (HA_CHUNK << PAGE_SHIFT));
> +                               (HA_CHUNK << PAGE_SHIFT), MHP_NONE);
>
>                 if (ret) {
>                         pr_err("hot_add memory failed error is %d\n", ret);
> diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
> index a864b21af602a..f6e97f0830f64 100644
> --- a/drivers/s390/char/sclp_cmd.c
> +++ b/drivers/s390/char/sclp_cmd.c
> @@ -406,7 +406,7 @@ static void __init add_memory_merged(u16 rn)
>         if (!size)
>                 goto skip_add;
>         for (addr = start; addr < start + size; addr += block_size)
> -               add_memory(0, addr, block_size);
> +               add_memory(0, addr, block_size, MHP_NONE);
>  skip_add:
>         first_rn = rn;
>         num = 1;
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 834b7c13ef3dc..ed99e43354010 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -424,7 +424,7 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
>
>         dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
>         return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
> -                                        vm->resource_name);
> +                                        vm->resource_name, MHP_NONE);
>  }
>
>  /*
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index 51427c752b37b..9f40a294d398d 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -331,7 +331,7 @@ static enum bp_state reserve_additional_memory(void)
>         mutex_unlock(&balloon_mutex);
>         /* add_memory_resource() requires the device_hotplug lock */
>         lock_device_hotplug();
> -       rc = add_memory_resource(nid, resource);
> +       rc = add_memory_resource(nid, resource, MHP_NONE);
>         unlock_device_hotplug();
>         mutex_lock(&balloon_mutex);
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 51a877fec8da8..e53d1058f3443 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -57,6 +57,12 @@ enum {
>         MMOP_ONLINE_MOVABLE,
>  };
>
> +/* Flags for add_memory() and friends to specify memory hotplug details. */
> +typedef int __bitwise mhp_t;
> +
> +/* No special request */
> +#define MHP_NONE               ((__force mhp_t)0)
> +
>  /*
>   * Extended parameters for memory hotplug:
>   * altmap: alternative allocator for memmap array (optional)
> @@ -345,11 +351,13 @@ extern void set_zone_contiguous(struct zone *zone);
>  extern void clear_zone_contiguous(struct zone *zone);
>
>  extern void __ref free_area_init_core_hotplug(int nid);
> -extern int __add_memory(int nid, u64 start, u64 size);
> -extern int add_memory(int nid, u64 start, u64 size);
> -extern int add_memory_resource(int nid, struct resource *resource);
> +extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
> +extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
> +extern int add_memory_resource(int nid, struct resource *resource,
> +                              mhp_t mhp_flags);
>  extern int add_memory_driver_managed(int nid, u64 start, u64 size,
> -                                    const char *resource_name);
> +                                    const char *resource_name,
> +                                    mhp_t mhp_flags);
>  extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>                                    unsigned long nr_pages,
>                                    struct vmem_altmap *altmap, int migratetype);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e1cd18b5cf14..8f0bd7c9a63a5 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1039,7 +1039,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>   *
>   * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
>   */
> -int __ref add_memory_resource(int nid, struct resource *res)
> +int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  {
>         struct mhp_params params = { .pgprot = PAGE_KERNEL };
>         u64 start, size;
> @@ -1118,7 +1118,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
>  }
>
>  /* requires device_hotplug_lock, see add_memory_resource() */
> -int __ref __add_memory(int nid, u64 start, u64 size)
> +int __ref __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>  {
>         struct resource *res;
>         int ret;
> @@ -1127,18 +1127,18 @@ int __ref __add_memory(int nid, u64 start, u64 size)
>         if (IS_ERR(res))
>                 return PTR_ERR(res);
>
> -       ret = add_memory_resource(nid, res);
> +       ret = add_memory_resource(nid, res, mhp_flags);
>         if (ret < 0)
>                 release_memory_resource(res);
>         return ret;
>  }
>
> -int add_memory(int nid, u64 start, u64 size)
> +int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>  {
>         int rc;
>
>         lock_device_hotplug();
> -       rc = __add_memory(nid, start, size);
> +       rc = __add_memory(nid, start, size, mhp_flags);
>         unlock_device_hotplug();
>
>         return rc;
> @@ -1167,7 +1167,7 @@ EXPORT_SYMBOL_GPL(add_memory);
>   * "System RAM ($DRIVER)".
>   */
>  int add_memory_driver_managed(int nid, u64 start, u64 size,
> -                             const char *resource_name)
> +                             const char *resource_name, mhp_t mhp_flags)
>  {
>         struct resource *res;
>         int rc;
> @@ -1185,7 +1185,7 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
>                 goto out_unlock;
>         }
>
> -       rc = add_memory_resource(nid, res);
> +       rc = add_memory_resource(nid, res, mhp_flags);
>         if (rc < 0)
>                 release_memory_resource(res);
>
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.26.2
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
