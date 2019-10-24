Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7F2E27F9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Oct 2019 04:06:22 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 93C72100EEB8F;
	Wed, 23 Oct 2019 19:07:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1C5CA100EEB8E
	for <linux-nvdimm@lists.01.org>; Wed, 23 Oct 2019 19:07:42 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x3so19248893oig.2
        for <linux-nvdimm@lists.01.org>; Wed, 23 Oct 2019 19:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyQt9qS7x8UywZSRcIfVGbteAhYRxjBFqgoKMXx1aUg=;
        b=QUFVlXswZJtKDJ98hP42sQ/G4KgR8pSJILG8Ky81YwZ0Gv5zRw0Gy1STlQaiHqdCOj
         XX13Ehrt6Qk+dnsTHpKyLyoqZldwQjGVdTUtJbfxN29M+7CGm8d/FNbdZA+67zDD3pqI
         kQjcP86eS4oZaSn+vgrKnZL6lf/9iAxHJJwmKtU2Mbwkn9yYbK43R+auuqfG9QYE+tus
         qUmvrIIn6ANWBmgkGrm/oXqNseG0vsJs2YXiikTiHqHhQh9QvsTg8m/ezgl1+l9RhGwg
         yC/CP3AvJucoNb30O8dRFYbiXC9d4Qojcyh5qcwnJaI9x7AiC5EyIThvc8YPcdYXA1hB
         0J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyQt9qS7x8UywZSRcIfVGbteAhYRxjBFqgoKMXx1aUg=;
        b=NW24dQ/E7GkemTpArxymo3dE4PmPuY53JhQICIpBHKyV3aQ/MABmhrEYYPaKXYVyZ6
         31ij+hcwRiI0zzwZhlKfz7kbmPBK54yfIwxWppKBCCEPtPcIyGDaDK0PPLrl5stY6gJG
         bV86fBpmfpcieezFmkvrTCCIiyOdqpbbGIoS5TJBHof9or+6ZT92x9G9EA2ra0jb+GeO
         5vab5OO6B8Mbr+pbOs73Fgg3C82+gaVrlYGFZkRHZCdsqg/QYl4QGPuJVN+6mjKwNx4i
         5CI3YZ9PS+Z0i6JLxRl1mtWxfdUur6yvNsIKZGmRl5y1vVj7kAiT4F+6NI9hQuaFDLj8
         QASg==
X-Gm-Message-State: APjAAAUnJ+a5JNggBUtrMAy4NZ3l+v2H+AajmR7OtHXayEIQrLxz65nR
	a7gNbaaM/LJIyLV8Wsk1J9Z9QwiB12vGHFDK0xIfbp6zqvE=
X-Google-Smtp-Source: APXvYqySHm/Vr4qxp3lZimn8xtzB/Zr3NTsS77jVPkCEm84IfsPTfICePF+dAIMNC7VeM+3H/Y5wxxSokTNN6mXEFvw=
X-Received: by 2002:aca:620a:: with SMTP id w10mr2683806oib.0.1571882776521;
 Wed, 23 Oct 2019 19:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191017073308.32645-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20191017073308.32645-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 23 Oct 2019 19:06:05 -0700
Message-ID: <CAPcyv4ix9Ld6NgN=6u3yBJc1A81U-nkY3EFHjBUTMNoxAxth1g@mail.gmail.com>
Subject: Re: [PATCH v3] libnvdimm/nsio: differentiate between probe mapping
 and runtime mapping
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: RPO7257Y5LLOKSXSLDCXPBZAKKZGHGUM
X-Message-ID-Hash: RPO7257Y5LLOKSXSLDCXPBZAKKZGHGUM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RPO7257Y5LLOKSXSLDCXPBZAKKZGHGUM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 17, 2019 at 12:33 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> nvdimm core currently maps the full namespace to an ioremap range
> while probing the namespace mode. This can result in probe failures
> on architectures that have limited ioremap space.
>
> For example, with a large btt namespace that consumes most of I/O remap
> range, depending on the sequence of namespace initialization, the user can find
> a pfn namespace initialization failure due to unavailable I/O remap space
> which nvdimm core uses for temporary mapping.
>
> nvdimm core can avoid this failure by only mapping the reserver block area to

s/reserver/reserved/

> check for pfn superblock type and map the full namespace resource only before
> using the namespace.

Are you going to follow up with the BTT patch that uses this new facility?

>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> Changes from v2:
> * update changelog
>
> Changes from V1:
> * update changelog
> * update patch based on review feedback.
>
>  drivers/dax/pmem/core.c   |  2 +-
>  drivers/nvdimm/claim.c    |  7 +++----
>  drivers/nvdimm/nd.h       |  4 ++--
>  drivers/nvdimm/pfn.h      |  6 ++++++
>  drivers/nvdimm/pfn_devs.c |  5 -----
>  drivers/nvdimm/pmem.c     | 15 ++++++++++++---
>  6 files changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
> index 6eb6dfdf19bf..f174dbfbe1c4 100644
> --- a/drivers/dax/pmem/core.c
> +++ b/drivers/dax/pmem/core.c
> @@ -28,7 +28,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
>         nsio = to_nd_namespace_io(&ndns->dev);
>
>         /* parse the 'pfn' info block via ->rw_bytes */
> -       rc = devm_nsio_enable(dev, nsio);
> +       rc = devm_nsio_enable(dev, nsio, info_block_reserve());
>         if (rc)
>                 return ERR_PTR(rc);
>         rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> index 2985ca949912..d89d2c039e25 100644
> --- a/drivers/nvdimm/claim.c
> +++ b/drivers/nvdimm/claim.c
> @@ -300,12 +300,12 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
>         return rc;
>  }
>
> -int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
> +int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio, unsigned long size)
>  {
>         struct resource *res = &nsio->res;
>         struct nd_namespace_common *ndns = &nsio->common;
>
> -       nsio->size = resource_size(res);
> +       nsio->size = size;

This needs a:

if (nsio->size)
   devm_memunmap(dev, nsio->addr);


>         if (!devm_request_mem_region(dev, res->start, resource_size(res),
>                                 dev_name(&ndns->dev))) {

Also don't repeat the devm_request_mem_region() if one was already done.

Another thing to check is if nsio->size gets cleared when the
namespace is disabled, if not that well need to be added in the
shutdown path.


>                 dev_warn(dev, "could not reserve region %pR\n", res);
> @@ -318,8 +318,7 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
>         nvdimm_badblocks_populate(to_nd_region(ndns->dev.parent), &nsio->bb,
>                         &nsio->res);
>
> -       nsio->addr = devm_memremap(dev, res->start, resource_size(res),
> -                       ARCH_MEMREMAP_PMEM);
> +       nsio->addr = devm_memremap(dev, res->start, size, ARCH_MEMREMAP_PMEM);
>
>         return PTR_ERR_OR_ZERO(nsio->addr);
>  }
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index ee5c04070ef9..93d3c760c0f3 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -376,7 +376,7 @@ void nvdimm_badblocks_populate(struct nd_region *nd_region,
>  #define MAX_STRUCT_PAGE_SIZE 64
>
>  int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
> -int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio);
> +int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio, unsigned long size);
>  void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio);
>  #else
>  static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
> @@ -385,7 +385,7 @@ static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
>         return -ENXIO;
>  }
>  static inline int devm_nsio_enable(struct device *dev,
> -               struct nd_namespace_io *nsio)
> +               struct nd_namespace_io *nsio, unsigned long size)
>  {
>         return -ENXIO;
>  }
> diff --git a/drivers/nvdimm/pfn.h b/drivers/nvdimm/pfn.h
> index acb19517f678..f4856c87d01c 100644
> --- a/drivers/nvdimm/pfn.h
> +++ b/drivers/nvdimm/pfn.h
> @@ -36,4 +36,10 @@ struct nd_pfn_sb {
>         __le64 checksum;
>  };
>
> +static inline u32 info_block_reserve(void)
> +{
> +       return ALIGN(SZ_8K, PAGE_SIZE);
> +}
> +
> +
>  #endif /* __NVDIMM_PFN_H */
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 60d81fae06ee..e49aa9a0fd04 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -635,11 +635,6 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
>  }
>  EXPORT_SYMBOL(nd_pfn_probe);
>
> -static u32 info_block_reserve(void)
> -{
> -       return ALIGN(SZ_8K, PAGE_SIZE);
> -}
> -
>  /*
>   * We hotplug memory at sub-section granularity, pad the reserved area
>   * from the previous section base to the namespace base address.
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index f9f76f6ba07b..3c188ffeff11 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -491,17 +491,26 @@ static int pmem_attach_disk(struct device *dev,
>  static int nd_pmem_probe(struct device *dev)
>  {
>         int ret;
> +       struct nd_namespace_io *nsio;
>         struct nd_namespace_common *ndns;
>
>         ndns = nvdimm_namespace_common_probe(dev);
>         if (IS_ERR(ndns))
>                 return PTR_ERR(ndns);
>
> -       if (devm_nsio_enable(dev, to_nd_namespace_io(&ndns->dev)))
> -               return -ENXIO;
> +       nsio = to_nd_namespace_io(&ndns->dev);
>
> -       if (is_nd_btt(dev))
> +       if (is_nd_btt(dev)) {
> +               /*
> +                * Map with resource size
> +                */
> +               if (devm_nsio_enable(dev, nsio, resource_size(&nsio->res)))
> +                       return -ENXIO;
>                 return nvdimm_namespace_attach_btt(ndns);
> +       }
> +
> +       if (devm_nsio_enable(dev, nsio, info_block_reserve()))
> +               return -ENXIO;
>
>         if (is_nd_pfn(dev))
>                 return pmem_attach_disk(dev, ndns);
> --
> 2.21.0
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
