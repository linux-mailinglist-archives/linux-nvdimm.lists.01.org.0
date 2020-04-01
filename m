Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0FC19A7BD
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 10:49:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7EBEA10FC3BC1;
	Wed,  1 Apr 2020 01:50:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5924A10FC3BB4
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 01:50:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i7so23743272edq.3
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UN+wHZJTrcu6c2DZIJ8HGRDVBKCDEPMCRCE7ZQEQTH8=;
        b=hTimd5IY+hTrOkh1p7KqZ0axrIUJgA8aekcpldRM6K9XQupypeq6MkUu+ggRqryYZL
         x3rcZjrA+Y0jKfVyqzmVLjKEqr3O6iCBN8GDPJzQJi0cEQ/7ObMmXUtXR9XRnlRU8ZiF
         QkYVKtMu4mENT5W/pzpOUStrq0OytQ5oulJ0UhL1avGRyOevi9/UwPw4Ykxv3wnZ/OwP
         HyQu22Ie3HIn0/IIyicOfJJ+SkzyBj7Hq8Ljhf/QIcUeGPjXdPcMfFQIvRwGIm43aWdr
         ui6jSj1L0yFrnNz0X3pBByQOSEhf24bDK4BDfm5vSnLWL82Bjny7/+HfR7ecl+iDeNj+
         l41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UN+wHZJTrcu6c2DZIJ8HGRDVBKCDEPMCRCE7ZQEQTH8=;
        b=Hfzv6/mPoOlXllFXAW/OXxmCAq0kvCRejeLe0THDNcsJbCtFhMtEqrhCrDQXL7GBw2
         R9TtxE2A6qa8GhxynyLFUxGr64Ae92bKdyrI3j81DNoCrQdKSA6o/a6XIW0z7rY9Vn58
         OHx8/Wcd/99GARigctzEN7DaPl6+EzFT7CVgTg/9f+JSgXgJJ56Ymr4b0gxxX2NXjvj7
         rKzbVhFUQJMKrvknfti42yOHPsNE3qRUPqa8fh8ZWZr/EFj2CfVC9+vjIATaC/saJfGe
         rcFMI53pHXrkatFzzBKa+xrvBBRTcal5QJEnfBuMy/vP0juGzOPvDm+oW1FYGxlaldCC
         j4hw==
X-Gm-Message-State: ANhLgQ1wWR0vIRcd8Y9ml/D+I8p+bu96D+JMBT1vPeHy00/CDdk81Ovp
	21c88rLDPcsOjPziLfvArvAAeTnP+aT4d2vfWXBF7A==
X-Google-Smtp-Source: ADFU+vuTuxIfbgq1b9JfG+WohU6wvy4jaujfdFzqOb3NMAMPXWIOfeafCvEeGwbQtVd/xByPDwh7XT1QdUOquEPXjL8=
X-Received: by 2002:a05:6402:3044:: with SMTP id bu4mr20560123edb.123.1585730971200;
 Wed, 01 Apr 2020 01:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-8-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-8-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 01:49:19 -0700
Message-ID: <CAPcyv4gUU4PbQK1YJLfOToLDmFWsWWLySwkqHuoqGDvKZJGQvg@mail.gmail.com>
Subject: Re: [PATCH v4 07/25] ocxl: Add functions to map/unmap LPC memory
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: KPVWLGAXXE5Z4CNKCUAV2Q6MRMDFUFGS
X-Message-ID-Hash: KPVWLGAXXE5Z4CNKCUAV2Q6MRMDFUFGS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KPVWLGAXXE5Z4CNKCUAV2Q6MRMDFUFGS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> Add functions to map/unmap LPC memory
>

"map memory" is an overloaded term. I'm guessing this patch has
nothing to do with mapping memory in the MMU. Is it updating hardware
resource decoders to start claiming address space that was allocated
previously?

> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>  drivers/misc/ocxl/core.c          | 51 +++++++++++++++++++++++++++++++
>  drivers/misc/ocxl/ocxl_internal.h |  3 ++
>  include/misc/ocxl.h               | 21 +++++++++++++
>  3 files changed, 75 insertions(+)
>
> diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
> index 2531c6cf19a0..75ff14e3882a 100644
> --- a/drivers/misc/ocxl/core.c
> +++ b/drivers/misc/ocxl/core.c
> @@ -210,6 +210,56 @@ static void unmap_mmio_areas(struct ocxl_afu *afu)
>         release_fn_bar(afu->fn, afu->config.global_mmio_bar);
>  }
>
> +int ocxl_afu_map_lpc_mem(struct ocxl_afu *afu)
> +{
> +       struct pci_dev *dev = to_pci_dev(afu->fn->dev.parent);
> +
> +       if ((afu->config.lpc_mem_size + afu->config.special_purpose_mem_size) == 0)
> +               return 0;
> +
> +       afu->lpc_base_addr = ocxl_link_lpc_map(afu->fn->link, dev);
> +       if (afu->lpc_base_addr == 0)
> +               return -EINVAL;
> +
> +       if (afu->config.lpc_mem_size > 0) {
> +               afu->lpc_res.start = afu->lpc_base_addr + afu->config.lpc_mem_offset;
> +               afu->lpc_res.end = afu->lpc_res.start + afu->config.lpc_mem_size - 1;
> +       }
> +
> +       if (afu->config.special_purpose_mem_size > 0) {
> +               afu->special_purpose_res.start = afu->lpc_base_addr +
> +                                                afu->config.special_purpose_mem_offset;
> +               afu->special_purpose_res.end = afu->special_purpose_res.start +
> +                                              afu->config.special_purpose_mem_size - 1;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_afu_map_lpc_mem);
> +
> +struct resource *ocxl_afu_lpc_mem(struct ocxl_afu *afu)
> +{
> +       return &afu->lpc_res;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_afu_lpc_mem);
> +
> +static void unmap_lpc_mem(struct ocxl_afu *afu)
> +{
> +       struct pci_dev *dev = to_pci_dev(afu->fn->dev.parent);
> +
> +       if (afu->lpc_res.start || afu->special_purpose_res.start) {
> +               void *link = afu->fn->link;
> +
> +               // only release the link when the the last consumer calls release
> +               ocxl_link_lpc_release(link, dev);
> +
> +               afu->lpc_res.start = 0;
> +               afu->lpc_res.end = 0;
> +               afu->special_purpose_res.start = 0;
> +               afu->special_purpose_res.end = 0;
> +       }
> +}
> +
>  static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
>  {
>         int rc;
> @@ -251,6 +301,7 @@ static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
>
>  static void deconfigure_afu(struct ocxl_afu *afu)
>  {
> +       unmap_lpc_mem(afu);
>         unmap_mmio_areas(afu);
>         reclaim_afu_pasid(afu);
>         reclaim_afu_actag(afu);
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 2d7575225bd7..7b975a89db7b 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -52,6 +52,9 @@ struct ocxl_afu {
>         void __iomem *global_mmio_ptr;
>         u64 pp_mmio_start;
>         void *private;
> +       u64 lpc_base_addr; /* Covers both LPC & special purpose memory */
> +       struct resource lpc_res;
> +       struct resource special_purpose_res;
>  };
>
>  enum ocxl_context_status {
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 357ef1aadbc0..d8b0b4d46bfb 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -203,6 +203,27 @@ int ocxl_irq_set_handler(struct ocxl_context *ctx, int irq_id,
>
>  // AFU Metadata
>
> +/**
> + * ocxl_afu_map_lpc_mem() - Map the LPC system & special purpose memory for an AFU
> + * Do not call this during device discovery, as there may me multiple

s/me/be/


> + * devices on a link, and the memory is mapped for the whole link, not
> + * just one device. It should only be called after all devices have
> + * registered their memory on the link.
> + *
> + * @afu: The AFU that has the LPC memory to map
> + *
> + * Returns 0 on success, negative on failure
> + */
> +int ocxl_afu_map_lpc_mem(struct ocxl_afu *afu);
> +
> +/**
> + * ocxl_afu_lpc_mem() - Get the physical address range of LPC memory for an AFU
> + * @afu: The AFU associated with the LPC memory
> + *
> + * Returns a pointer to the resource struct for the physical address range
> + */
> +struct resource *ocxl_afu_lpc_mem(struct ocxl_afu *afu);
> +
>  /**
>   * ocxl_afu_config() - Get a pointer to the config for an AFU
>   * @afu: a pointer to the AFU to get the config for
> --
> 2.24.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
