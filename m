Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B38575E2B8
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 13:17:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BECA8212ACEBA;
	Wed,  3 Jul 2019 04:17:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 780E7212ACEB4
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 04:17:44 -0700 (PDT)
Received: by mail-ot1-f66.google.com with SMTP id x21so1901369otq.12
 for <linux-nvdimm@lists.01.org>; Wed, 03 Jul 2019 04:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6p7Ml1taBfw1pgfwjcyxPi4qSjAjlKpEhQ7dgExagw8=;
 b=JS9kpuaDR63lbYRm7TuczG/NICb2dAeKgvZkBYu+xqoW8yzGRB4Q1v8NVSSnjU2yvY
 P6VC93MJBpHh9OtaT8fd4JzsHvf3TUP/s+OOy7f1WcTvBYz+kKZZrnhQwzgDE2V5Ux1r
 93IVT1oScrhAlKucAk1ATOhMbfhpH1+zQbGsptiSe74Xva3UQ67jdsYJ7ZOvbEpq/9yG
 Dzd7Litus5jUA1aRgvJw79uaORUKH3kiuSH3fkquerL5UyuaQ2IcHJyB6UXq2sFIEABE
 G8LmIZ4fEqiWiMwRJ4n/kXkQ5Bjb0DPDMtg6CkIuYInXLLmUdC37b/UQTKJbuZgh90/Y
 8y9g==
X-Gm-Message-State: APjAAAXikusrzabtvCRXzMoJ7dikBVw8d2ZkAG6jSrq4FgX+DMz/S3cp
 8+LIkGWRl4AJ27KS56eWXTJe9z3F5UUNZIYzrGk=
X-Google-Smtp-Source: APXvYqxaKpjJ5SbDkRCszXzemDFcQ5qrdoVchVV8t7MJfau/DDMWDTbG36vuyffe6H1hjkVc1tNkbmzNYVGWE1RmrUg=
X-Received: by 2002:a05:6830:1516:: with SMTP id
 k22mr8620913otp.189.1562152663517; 
 Wed, 03 Jul 2019 04:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156140042634.2951909.15878153818360710942.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156140042634.2951909.15878153818360710942.stgit@dwillia2-desk3.amr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jul 2019 13:17:32 +0200
Message-ID: <CAJZ5v0gm3QD+qnFvuhdCi9Fa9NR2YLptKU8JEDuC9EH5k2oOyQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] acpi/numa/hmat: Register "specific purpose"
 memory as an "hmem" device
To: Dan Williams <dan.j.williams@intel.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 24, 2019 at 8:34 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Memory that has been tagged EFI_MEMORY_SP, and has performance
> properties described by the ACPI HMAT is expected to have an application
> specific consumer.
>
> Those consumers may want 100% of the memory capacity to be reserved from
> any usage by the kernel. By default, with this enabling, a platform
> device is created to represent this differentiated resource.
>
> The device-dax "hmem" driver claims these devices by default and
> provides an mmap interface for the target application.  If the
> administrator prefers, the hmem resource range can be made available to
> the core-mm via the device-dax hotplug facility, kmem, to online the
> memory with its own numa node.
>
> This was tested with an emulated HMAT produced by qemu (with the pending
> HMAT enabling patches), and "efi_fake_mem=8G@9G:0x40000" on the kernel
> command line to mark the memory ranges associated with node2 and node3
> as EFI_MEMORY_SP.
>
> qemu numa configuration options:
>
> -numa node,mem=4G,cpus=0-19,nodeid=0
> -numa node,mem=4G,cpus=20-39,nodeid=1
> -numa node,mem=4G,nodeid=2
> -numa node,mem=4G,nodeid=3
> -numa dist,src=0,dst=0,val=10
> -numa dist,src=0,dst=1,val=21
> -numa dist,src=0,dst=2,val=21
> -numa dist,src=0,dst=3,val=21
> -numa dist,src=1,dst=0,val=21
> -numa dist,src=1,dst=1,val=10
> -numa dist,src=1,dst=2,val=21
> -numa dist,src=1,dst=3,val=21
> -numa dist,src=2,dst=0,val=21
> -numa dist,src=2,dst=1,val=21
> -numa dist,src=2,dst=2,val=10
> -numa dist,src=2,dst=3,val=21
> -numa dist,src=3,dst=0,val=21
> -numa dist,src=3,dst=1,val=21
> -numa dist,src=3,dst=2,val=21
> -numa dist,src=3,dst=3,val=10
> -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,base-lat=10,latency=5
> -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
> -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,latency=10
> -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10
> -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-latency,base-lat=10,latency=15
> -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=15
> -numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-latency,base-lat=10,latency=20
> -numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=20
> -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-latency,base-lat=10,latency=10
> -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10
> -numa hmat-lb,initiator=1,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,latency=5
> -numa hmat-lb,initiator=1,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
> -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-latency,base-lat=10,latency=15
> -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=15
> -numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-latency,base-lat=10,latency=20
> -numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=20
>
> Result:
>
> # daxctl list -RDu
> [
>   {
>     "path":"\/platform\/hmem.1",
>     "id":1,
>     "size":"4.00 GiB (4.29 GB)",
>     "align":2097152,
>     "devices":[
>       {
>         "chardev":"dax1.0",
>         "size":"4.00 GiB (4.29 GB)"
>       }
>     ]
>   },
>   {
>     "path":"\/platform\/hmem.0",
>     "id":0,
>     "size":"4.00 GiB (4.29 GB)",
>     "align":2097152,
>     "devices":[
>       {
>         "chardev":"dax0.0",
>         "size":"4.00 GiB (4.29 GB)"
>       }
>     ]
>   }
> ]
>
> # cat /proc/iomem
> [..]
> 240000000-43fffffff : Application Reserved
>   240000000-33fffffff : hmem.0
>     240000000-33fffffff : dax0.0
>   340000000-43fffffff : hmem.1
>     340000000-43fffffff : dax1.0
>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/numa/Kconfig |    1
>  drivers/acpi/numa/hmat.c  |  132 +++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 122 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index d14582387ed0..c1be746e111a 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -8,6 +8,7 @@ config ACPI_HMAT
>         bool "ACPI Heterogeneous Memory Attribute Table Support"
>         depends on ACPI_NUMA
>         select HMEM_REPORTING
> +       select MEMREGION
>         help
>          If set, this option has the kernel parse and report the
>          platform's ACPI HMAT (Heterogeneous Memory Attributes Table),
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 1d329c4af3bf..622c5feb3aa0 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -8,11 +8,16 @@
>   * the applicable attributes with the node's interfaces.
>   */
>
> +#define pr_fmt(fmt) "acpi/hmat: " fmt
> +#define dev_fmt(fmt) "acpi/hmat: " fmt
> +
>  #include <linux/acpi.h>
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
>  #include <linux/list_sort.h>
>  #include <linux/node.h>
>  #include <linux/sysfs.h>
> @@ -40,6 +45,7 @@ struct memory_target {
>         struct list_head node;
>         unsigned int memory_pxm;
>         unsigned int processor_pxm;
> +       struct resource memregions;
>         struct node_hmem_attrs hmem_attrs;
>  };
>
> @@ -92,21 +98,35 @@ static __init void alloc_memory_initiator(unsigned int cpu_pxm)
>         list_add_tail(&initiator->node, &initiators);
>  }
>
> -static __init void alloc_memory_target(unsigned int mem_pxm)
> +static __init void alloc_memory_target(unsigned int mem_pxm,
> +               resource_size_t start, resource_size_t len)
>  {
>         struct memory_target *target;
>
>         target = find_mem_target(mem_pxm);
> -       if (target)
> -               return;
> -
> -       target = kzalloc(sizeof(*target), GFP_KERNEL);
> -       if (!target)
> -               return;
> +       if (!target) {
> +               target = kzalloc(sizeof(*target), GFP_KERNEL);
> +               if (!target)
> +                       return;
> +               target->memory_pxm = mem_pxm;
> +               target->processor_pxm = PXM_INVAL;
> +               target->memregions = (struct resource) {
> +                       .name   = "ACPI mem",
> +                       .start  = 0,
> +                       .end    = -1,
> +                       .flags  = IORESOURCE_MEM,
> +               };
> +               list_add_tail(&target->node, &targets);
> +       }
>
> -       target->memory_pxm = mem_pxm;
> -       target->processor_pxm = PXM_INVAL;
> -       list_add_tail(&target->node, &targets);
> +       /*
> +        * There are potentially multiple ranges per PXM, so record each
> +        * in the per-target memregions resource tree.
> +        */
> +       if (!__request_region(&target->memregions, start, len, "memory target",
> +                               IORESOURCE_MEM))
> +               pr_warn("failed to reserve %#llx - %#llx in pxm: %d\n",
> +                               start, start + len, mem_pxm);
>  }
>
>  static __init const char *hmat_data_type(u8 type)
> @@ -428,7 +448,7 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
>                 return -EINVAL;
>         if (!(ma->flags & ACPI_SRAT_MEM_ENABLED))
>                 return 0;
> -       alloc_memory_target(ma->proximity_domain);
> +       alloc_memory_target(ma->proximity_domain, ma->base_address, ma->length);
>         return 0;
>  }
>
> @@ -580,6 +600,81 @@ static __init void hmat_register_target_perf(struct memory_target *target)
>         node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
>  }
>
> +static __init void hmat_register_target_device(struct memory_target *target,
> +               struct resource *r)
> +{
> +       /* define a clean / non-busy resource for the platform device */
> +       struct resource res = {
> +               .start = r->start,
> +               .end = r->end,
> +               .flags = IORESOURCE_MEM,
> +       };
> +       struct platform_device *pdev;
> +       struct memregion_info info;
> +       int rc, id;
> +
> +       rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
> +                       IORES_DESC_APPLICATION_RESERVED);
> +       if (rc != REGION_INTERSECTS)
> +               return;
> +
> +       id = memregion_alloc(GFP_KERNEL);
> +       if (id < 0) {
> +               pr_err("memregion allocation failure for %pr\n", &res);
> +               return;
> +       }
> +
> +       pdev = platform_device_alloc("hmem", id);
> +       if (!pdev) {
> +               pr_err("hmem device allocation failure for %pr\n", &res);
> +               goto out_pdev;
> +       }
> +
> +       pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
> +       info = (struct memregion_info) {
> +               .target_node = acpi_map_pxm_to_node(target->memory_pxm),
> +       };
> +       rc = platform_device_add_data(pdev, &info, sizeof(info));
> +       if (rc < 0) {
> +               pr_err("hmem memregion_info allocation failure for %pr\n", &res);
> +               goto out_pdev;
> +       }
> +
> +       rc = platform_device_add_resources(pdev, &res, 1);
> +       if (rc < 0) {
> +               pr_err("hmem resource allocation failure for %pr\n", &res);
> +               goto out_resource;
> +       }
> +
> +       rc = platform_device_add(pdev);
> +       if (rc < 0) {
> +               dev_err(&pdev->dev, "device add failed for %pr\n", &res);
> +               goto out_resource;
> +       }
> +
> +       return;
> +
> +out_resource:
> +       put_device(&pdev->dev);
> +out_pdev:
> +       memregion_free(id);
> +}
> +
> +static __init void hmat_register_target_devices(struct memory_target *target)
> +{
> +       struct resource *res;
> +
> +       /*
> +        * Do not bother creating devices if no driver is available to
> +        * consume them.
> +        */
> +       if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
> +               return;
> +
> +       for (res = target->memregions.child; res; res = res->sibling)
> +               hmat_register_target_device(target, res);
> +}
> +
>  static __init void hmat_register_targets(void)
>  {
>         struct memory_target *target;
> @@ -587,6 +682,12 @@ static __init void hmat_register_targets(void)
>         list_for_each_entry(target, &targets, node) {
>                 int nid = pxm_to_node(target->memory_pxm);
>
> +               /*
> +                * Devices may belong to either an offline or online
> +                * node, so unconditionally add them.
> +                */
> +               hmat_register_target_devices(target);
> +
>                 /*
>                  * Skip offline nodes. This can happen when memory
>                  * marked EFI_MEMORY_SP, "specific purpose", is applied
> @@ -608,7 +709,16 @@ static __init void hmat_free_structures(void)
>         struct memory_initiator *initiator, *inext;
>
>         list_for_each_entry_safe(target, tnext, &targets, node) {
> +               struct resource *res, *res_next;
> +
>                 list_del(&target->node);
> +               res = target->memregions.child;
> +               while (res) {
> +                       res_next = res->sibling;
> +                       __release_region(&target->memregions, res->start,
> +                                       resource_size(res));
> +                       res = res_next;
> +               }
>                 kfree(target);
>         }
>
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
