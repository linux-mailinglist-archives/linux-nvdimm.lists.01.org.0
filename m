Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 128F5169BD2
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 02:30:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 52AEA10FC337D;
	Sun, 23 Feb 2020 17:31:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::142; helo=mail-il1-x142.google.com; envelope-from=oohall@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 415271007A84A
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 17:31:23 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id p8so6353521iln.12
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 17:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpjCEzvJa3mYN+s9rlLxDJnrunIgm+5HNYu1VzHukUU=;
        b=FIu4P22El7eNwYCcFGhhFF4W0gT/3uXEPg/SjIKun9Y9IjQuif1w3RKpXODNfU5KHq
         j+FXRJROFzzDi+vFVNNUSRy3edizBx/KRJPpuWAEWHo+EKuXab3EA1TQrgI8bgqUeX3a
         GWXEu4eK7L050LCSwstEXdH41YgTDxSOZkskMjftzpUe/Yf9KoKqM6rcdaad++QBhH4g
         UUYisqv+pjAUIGCL6bEehVpm13sniJMkblimcNKwCx5RJ1iSvgmfpF0NhflwifX0m5A3
         2QD+PxyNCw15FI0Fy+irGrr9w0LJqHSdRjlpiVPk/lq12vP/5cKgO/AGnNP7poGeIAFj
         bCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpjCEzvJa3mYN+s9rlLxDJnrunIgm+5HNYu1VzHukUU=;
        b=WoP26mbhZO7GUODQ1ENEt1ZDazsu36Xk7qTrvCvfQ3O/Nk6PXFgBAoBGwU0Vxjiv1F
         wNel1x4S1jV/xGWORnXw1ob5etoDFixHJUCj/BoeQnkNTPhPg7kyTDylRy4Isk3ktxmZ
         ZClXKIBAR5s9m6CrhKqFkldmcL+8z48HWz5lSU6+OhslOq40VJ40oV57BRi6t11gBGdT
         CcgXVe8K16Qapx/RAepDP59cMQ/zO485NFvE4nVOMgAz43a6H7hCDWBj+vkLbheOFEFh
         pgMwXF6f0pB4Zk/lrxlSavVkn2j7rphE8TNuN9YB+JTLr96JVKSKZjRExTXwjnD/seLH
         S2lA==
X-Gm-Message-State: APjAAAUqGF4ecjKeyo3aiaLlg9Trh/yBmEpWg1vcweofGpquwyvppreg
	p58TsZ2qqdh2nh4mPiwo0ubEs9ZRYf/FX3X2Ipo=
X-Google-Smtp-Source: APXvYqx986xHbMXQkYKGgmbvLTm2zVMEwdNkZBqR0v7GJ9D4/63fbl5fSNJ1vI599Huyw4OTdryOUO3/YcN07YtuvZU=
X-Received: by 2002:a92:914a:: with SMTP id t71mr56519689ild.293.1582507830358;
 Sun, 23 Feb 2020 17:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20200222183010.197844-1-adelva@google.com>
In-Reply-To: <20200222183010.197844-1-adelva@google.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Mon, 24 Feb 2020 12:30:19 +1100
Message-ID: <CAOSf1CHVWV-ku9ajCpdw4cONdpSO-8vm=oMLvCo+F1xF-xCL6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libnvdimm/of_pmem: handle memory-region in DT
To: Alistair Delva <adelva@google.com>
Message-ID-Hash: MZIKRGA6RH62CP7SPVWETRTMX2RNUACJ
X-Message-ID-Hash: MZIKRGA6RH62CP7SPVWETRTMX2RNUACJ
X-MailFrom: oohall@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, Device Tree <devicetree@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MZIKRGA6RH62CP7SPVWETRTMX2RNUACJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Feb 23, 2020 at 5:30 AM Alistair Delva <adelva@google.com> wrote:
>
> From: Kenny Root <kroot@google.com>
>
> Add support for parsing the 'memory-region' DT property in addition to
> the 'reg' DT property. This enables use cases where the pmem region is
> not in I/O address space or dedicated memory (e.g. a bootloader
> carveout).
>
> Signed-off-by: Kenny Root <kroot@google.com>
> Signed-off-by: Alistair Delva <adelva@google.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> Cc: kernel-team@android.com
> ---
>  drivers/nvdimm/of_pmem.c | 75 ++++++++++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 8224d1431ea9..a68e44fb0041 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -14,13 +14,47 @@ struct of_pmem_private {
>         struct nvdimm_bus *bus;
>  };
>
> +static void of_pmem_register_region(struct platform_device *pdev,
> +                                   struct nvdimm_bus *bus,
> +                                   struct device_node *np,
> +                                   struct resource *res, bool is_volatile)
> +{
> +       struct nd_region_desc ndr_desc;
> +       struct nd_region *region;
> +
> +       /*
> +        * NB: libnvdimm copies the data from ndr_desc into it's own
> +        * structures so passing a stack pointer is fine.
> +        */
> +       memset(&ndr_desc, 0, sizeof(ndr_desc));
> +       ndr_desc.numa_node = dev_to_node(&pdev->dev);
> +       ndr_desc.target_node = ndr_desc.numa_node;
> +       ndr_desc.res = res;
> +       ndr_desc.of_node = np;
> +       set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> +
> +       if (is_volatile)
> +               region = nvdimm_volatile_region_create(bus, &ndr_desc);
> +       else
> +               region = nvdimm_pmem_region_create(bus, &ndr_desc);
> +
> +       if (!region)
> +               dev_warn(&pdev->dev,
> +                        "Unable to register region %pR from %pOF\n",
> +                        ndr_desc.res, np);
> +       else
> +               dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> +                       ndr_desc.res, np);
> +}
> +
>  static int of_pmem_region_probe(struct platform_device *pdev)
>  {
>         struct of_pmem_private *priv;
> -       struct device_node *np;
> +       struct device_node *mrp, *np;
>         struct nvdimm_bus *bus;
> +       struct resource res;
>         bool is_volatile;
> -       int i;
> +       int i, ret;
>
>         np = dev_of_node(&pdev->dev);
>         if (!np)
> @@ -46,31 +80,22 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>                         is_volatile ? "volatile" : "non-volatile",  np);
>
>         for (i = 0; i < pdev->num_resources; i++) {
> -               struct nd_region_desc ndr_desc;
> -               struct nd_region *region;
> -
> -               /*
> -                * NB: libnvdimm copies the data from ndr_desc into it's own
> -                * structures so passing a stack pointer is fine.
> -                */
> -               memset(&ndr_desc, 0, sizeof(ndr_desc));
> -               ndr_desc.numa_node = dev_to_node(&pdev->dev);
> -               ndr_desc.target_node = ndr_desc.numa_node;
> -               ndr_desc.res = &pdev->resource[i];
> -               ndr_desc.of_node = np;
> -               set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> -
> -               if (is_volatile)
> -                       region = nvdimm_volatile_region_create(bus, &ndr_desc);
> -               else
> -                       region = nvdimm_pmem_region_create(bus, &ndr_desc);
> +               of_pmem_register_region(pdev, bus, np, &pdev->resource[i],
> +                                       is_volatile);
> +       }
>
> -               if (!region)
> -                       dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
> -                                       ndr_desc.res, np);
> +       i = 0;
> +       while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {

Doesn't compile since the the iteration variable is declared above as
"mrp" rather than "mr_np". The patch looks fine otherwise and seems to
work ok, so:

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

> +               ret = of_address_to_resource(mr_np, 0, &res);
> +               if (ret)
> +                       dev_warn(
> +                               &pdev->dev,
> +                               "Unable to acquire memory-region from %pOF: %d\n",
> +                               mr_np, ret);
>                 else
> -                       dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> -                                       ndr_desc.res, np);
> +                       of_pmem_register_region(pdev, bus, np, &res,
> +                                               is_volatile)

Now days I think it's cleaner to use braces around multi-line blocks
even if it's a single statement, up to you though.

> +               of_node_put(mr_np);
>         }
>
>         return 0;
> --
> 2.25.0.265.gbab2e86ba0-goog
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
