Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8044B959DA
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 10:41:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF01C2020F932;
	Tue, 20 Aug 2019 01:42:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=oohall@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D524D21A1349F
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 01:42:41 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id j5so10472503ioj.8
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zdfPVCpQKbOB6BWB1KnP3j6I+X4+4oR2rukvo6YVs7E=;
 b=Fud3MqWVJzIcbSDdvAgLseOwaSEiZ/+3odadDhcdApXZYMppL8Um2VXLTEjaJ43tZO
 tfS2PDfXZXBYMGxRgz0ar6cY7E1yUB6Jx19ULyNsKy3msVQ+iE4YBtKBid7wlE7L7Dtq
 IYXZwUHZ/csV2+2m6xIsLdoFfjImUWiBLB0NnlAIJWSRmoOYg0y6uBlh0AttsBvnlRTj
 of27H2vEXrYOi+Z0YIWb9U1RK5coV7o09yVMehIXJQfEMS5CsDDTKcIYK4cdsoBR1i2O
 AvDzaTgeVwTu01n8zgfJZkNsFyLXhmGfIavBU5+Skq3rU+HwSpF5e2S1UPJlxDhdAI/h
 q6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zdfPVCpQKbOB6BWB1KnP3j6I+X4+4oR2rukvo6YVs7E=;
 b=b+QJHMZX3FnVXzeFU2KTyagdYogquMiIrZ4ZCylRiEUPO/SdYgfI56yu7/8DlhoVmB
 OQZ1qR4HJVW10krldhHt+sCfbw9E4DaxDHqdmHeL3C5bectpFf+9aY12eaTFAK40HSnJ
 HIaYMtUI9NrBIOml/AKL3FjDHKhuypF23+FN6AXfmEBvmGE+GKIYhZ6RIjitvFVSCh1y
 VCXLrh9oJPFNZSY/MnuOla7L33mAIXIz9BMp4tD7CF6n3Y4HAgM73pUz06FrS35IR96U
 3FEl8R9WnQqaluftklm/avloLTgxe2JLIFNoCwAPW1030VhVf3EfQ3tdmV4UGYZaM5M8
 u3Ig==
X-Gm-Message-State: APjAAAXFOMP5T4IeqYiUxx83u6fO/bYjIYpl1vXttfOwCSyluN6xh5lB
 MBmQi1GRd4+Bo8lBtzPoBULGVNrfAf5+af+oIGM=
X-Google-Smtp-Source: APXvYqzRaJ7XDDJD1NW0/Nvdeg4AhNIo8VinQ7yGHcODmufB0O9qxvneOP6SzcAbn8IEqU8+L2jfE4gUjBfvokmzFgY=
X-Received: by 2002:a6b:fb10:: with SMTP id h16mr29478708iog.195.1566290479829; 
 Tue, 20 Aug 2019 01:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190820023030.18232-1-santosh@fossix.org>
 <20190820023030.18232-3-santosh@fossix.org>
In-Reply-To: <20190820023030.18232-3-santosh@fossix.org>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Tue, 20 Aug 2019 18:41:08 +1000
Message-ID: <CAOSf1CEYqY5O2RUmvh-nJwouhVZP0A3EW+_kQcz6h9d7cM8UYg@mail.gmail.com>
Subject: Re: [PATCH 2/3] of_pmem: Add memory ranges which took a mce to bad
 range
To: Santosh Sivaraj <santosh@fossix.org>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>,
 Chandan Rajendra <chandan@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 20, 2019 at 12:30 PM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> Subscribe to the MCE notification and add the physical address which
> generated a memory error to nvdimm bad range.

Uh... I should have looked a bit closer at this on v1.

a) of_pmem.c isn't part of the powerpc tree. You should have CCed this
to the nvdimm list since you'll need an Ack from Dan Williams.
b) of_pmem isn't powerpc specific. Adding a pile of powerpc specific
machine check parsing means it's not going to compile on other DT
platforms.
c) all this appears to be copied and pasted from the papr_scm version of this.

Considering this is pretty similar in spirit to what's done on x86
today (drivers/acpi/nfit/mce.c) I think you would get more milage out
of moving the address matching into libnvdimm itself. Machine check
handling is always going to be arch specific, but memory errors could
be re-emitted by the arch code into a more generic notifier chain that
libnvdimm use. There's probably other uses in mm/ for such a chain
too.

Oliver


> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  drivers/nvdimm/of_pmem.c | 151 +++++++++++++++++++++++++++++++++------
>  1 file changed, 131 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index a0c8dcfa0bf9..155e56862fdf 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -8,6 +8,9 @@
>  #include <linux/module.h>
>  #include <linux/ioport.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/nd.h>
> +#include <asm/mce.h>
>
>  static const struct attribute_group *region_attr_groups[] = {
>         &nd_region_attribute_group,
> @@ -25,11 +28,77 @@ struct of_pmem_private {
>         struct nvdimm_bus *bus;
>  };
>
> +struct of_pmem_region {
> +       struct of_pmem_private *priv;
> +       struct nd_region_desc *region_desc;
> +       struct nd_region *region;
> +       struct list_head region_list;
> +};
> +
> +LIST_HEAD(pmem_regions);
> +DEFINE_MUTEX(pmem_region_lock);
> +
> +static int handle_mce_ue(struct notifier_block *nb, unsigned long val,
> +                        void *data)
> +{
> +       struct machine_check_event *evt = data;
> +       struct of_pmem_region *pmem_region;
> +       u64 aligned_addr, phys_addr;
> +       bool found = false;
> +
> +       if (evt->error_type != MCE_ERROR_TYPE_UE)
> +               return NOTIFY_DONE;
> +
> +       if (list_empty(&pmem_regions))
> +               return NOTIFY_DONE;
> +
> +       phys_addr = evt->u.ue_error.physical_address +
> +               (evt->u.ue_error.effective_address & ~PAGE_MASK);
> +
> +       if (!evt->u.ue_error.physical_address_provided ||
> +           !is_zone_device_page(pfn_to_page(phys_addr >> PAGE_SHIFT)))
> +               return NOTIFY_DONE;
> +
> +       mutex_lock(&pmem_region_lock);
> +       list_for_each_entry(pmem_region, &pmem_regions, region_list) {
> +               struct resource *res = pmem_region->region_desc->res;
> +
> +               if (phys_addr >= res->start && phys_addr <= res->end) {
> +                       found = true;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&pmem_region_lock);
> +
> +       if (!found)
> +               return NOTIFY_DONE;
> +
> +       aligned_addr = ALIGN_DOWN(phys_addr, L1_CACHE_BYTES);
> +
> +       if (nvdimm_bus_add_badrange(pmem_region->priv->bus, aligned_addr,
> +                                   L1_CACHE_BYTES))
> +               return NOTIFY_DONE;
> +
> +       pr_debug("Add memory range (0x%llx -- 0x%llx) as bad range\n",
> +                aligned_addr, aligned_addr + L1_CACHE_BYTES);
> +
> +
> +       nvdimm_region_notify(pmem_region->region, NVDIMM_REVALIDATE_POISON);
> +
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block mce_ue_nb = {
> +       .notifier_call = handle_mce_ue
> +};
> +
>  static int of_pmem_region_probe(struct platform_device *pdev)
>  {
>         struct of_pmem_private *priv;
>         struct device_node *np;
>         struct nvdimm_bus *bus;
> +       struct of_pmem_region *pmem_region;
> +       struct nd_region_desc *ndr_desc;
>         bool is_volatile;
>         int i;
>
> @@ -58,32 +127,49 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>                         is_volatile ? "volatile" : "non-volatile",  np);
>
>         for (i = 0; i < pdev->num_resources; i++) {
> -               struct nd_region_desc ndr_desc;
>                 struct nd_region *region;
>
> -               /*
> -                * NB: libnvdimm copies the data from ndr_desc into it's own
> -                * structures so passing a stack pointer is fine.
> -                */
> -               memset(&ndr_desc, 0, sizeof(ndr_desc));
> -               ndr_desc.attr_groups = region_attr_groups;
> -               ndr_desc.numa_node = dev_to_node(&pdev->dev);
> -               ndr_desc.target_node = ndr_desc.numa_node;
> -               ndr_desc.res = &pdev->resource[i];
> -               ndr_desc.of_node = np;
> -               set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> +               ndr_desc = kzalloc(sizeof(struct nd_region_desc), GFP_KERNEL);
> +               if (!ndr_desc) {
> +                       nvdimm_bus_unregister(priv->bus);
> +                       kfree(priv);
> +                       return -ENOMEM;
> +               }
> +
> +               ndr_desc->attr_groups = region_attr_groups;
> +               ndr_desc->numa_node = dev_to_node(&pdev->dev);
> +               ndr_desc->target_node = ndr_desc->numa_node;
> +               ndr_desc->res = &pdev->resource[i];
> +               ndr_desc->of_node = np;
> +               set_bit(ND_REGION_PAGEMAP, &ndr_desc->flags);
>
>                 if (is_volatile)
> -                       region = nvdimm_volatile_region_create(bus, &ndr_desc);
> +                       region = nvdimm_volatile_region_create(bus, ndr_desc);
>                 else
> -                       region = nvdimm_pmem_region_create(bus, &ndr_desc);
> +                       region = nvdimm_pmem_region_create(bus, ndr_desc);
>
> -               if (!region)
> +               if (!region) {
>                         dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
> -                                       ndr_desc.res, np);
> -               else
> -                       dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> -                                       ndr_desc.res, np);
> +                                       ndr_desc->res, np);
> +                       continue;
> +               }
> +
> +               dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> +                       ndr_desc->res, np);
> +
> +               pmem_region = kzalloc(sizeof(struct of_pmem_region),
> +                                     GFP_KERNEL);
> +               if (!pmem_region)
> +                       continue;
> +
> +               pmem_region->region_desc = ndr_desc;
> +               pmem_region->region = region;
> +               pmem_region->priv = priv;
> +
> +               /* Save regions registered for use by the notification code */
> +               mutex_lock(&pmem_region_lock);
> +               list_add_tail(&pmem_region->region_list, &pmem_regions);
> +               mutex_unlock(&pmem_region_lock);
>         }
>
>         return 0;
> @@ -92,6 +178,13 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  static int of_pmem_region_remove(struct platform_device *pdev)
>  {
>         struct of_pmem_private *priv = platform_get_drvdata(pdev);
> +       struct of_pmem_region *r, *t;
> +
> +       list_for_each_entry_safe(r, t, &pmem_regions, region_list) {
> +               list_del(&(r->region_list));
> +               kfree(r->region_desc);
> +               kfree(r);
> +       }
>
>         nvdimm_bus_unregister(priv->bus);
>         kfree(priv);
> @@ -113,7 +206,25 @@ static struct platform_driver of_pmem_region_driver = {
>         },
>  };
>
> -module_platform_driver(of_pmem_region_driver);
> +static int __init of_pmem_init(void)
> +{
> +       int ret;
> +
> +       ret = platform_driver_register(&of_pmem_region_driver);
> +       if (!ret)
> +               mce_register_notifier(&mce_ue_nb);
> +
> +       return ret;
> +}
> +module_init(of_pmem_init);
> +
> +static void __exit of_pmem_exit(void)
> +{
> +       mce_unregister_notifier(&mce_ue_nb);
> +       platform_driver_unregister(&of_pmem_region_driver);
> +}
> +module_exit(of_pmem_exit);
> +
>  MODULE_DEVICE_TABLE(of, of_pmem_region_match);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("IBM Corporation");
> --
> 2.21.0
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
