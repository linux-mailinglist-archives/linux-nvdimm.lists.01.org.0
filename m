Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F1919A7B7
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 10:49:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3CF4910FC3BBA;
	Wed,  1 Apr 2020 01:49:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6221310FC3BAB
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 01:49:52 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id cw6so27956335edb.9
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jG4wOYVYC+k6uIDCHQ8wcXaTiCDZtncKRBQcnse1vfY=;
        b=Nox6OXWGA798Cr52xBMr6YHpFOgZ7GP4CUrcEL/TAjbaMmfb/e8Zq882nUJlst3xBC
         lRz42jYj7FddMpixYXtQgSC96iREDWwS/FzvP3U4+2OMv3r9/9omUEZ8lHaLCPchiKOQ
         QPvUwGlYZT0Xon0Q/LupecuVEt+A1WIAhR6LeV/v1+xa4/C9wpYDQUb4Fv+rb9x00T9h
         ED5TXU8f8rgLSSIXyzx2rP22L7pZXROOGddOLANi4qfl6m48TCJTIzm/F0kJ1jhGQZKu
         oW5Tpq7m5kP0iB3iChoW//Mw34MO1wRRyqjxvkSy5ucVyDc2vYNXewxaxLLT1YUg7VkA
         /78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jG4wOYVYC+k6uIDCHQ8wcXaTiCDZtncKRBQcnse1vfY=;
        b=U5nDAikX0bF2+wIsGLc/FbIGxzp3HW4LN7zlV3ycnRcBon0knTJhXB64wYFtJbTwwy
         DoDQjHqynms5rcutdqapQRENF0qWUwoxgC2Tit527qthAtv3c6aUkwldFq3rW9p5IwQC
         gm7wU4XsmPg+Ckp9I1/tA8ivBRvSTc6W+5mM7uhUxX+9dTi2BQ/Q+5KSimm6IAB+eUbG
         JVGmCKZm4GgFylamAfBbk4T/GbjJcde0leVAYLaqkaxaQIMifMQ2oUjU4KKD0SUdzyrC
         Pq7BRP5I/ZQNFI0oQlrdLnk03/N3QTm3toylx1Hxh433l3Ie5efyonEnxTTfqc6vIAdt
         Kc4A==
X-Gm-Message-State: ANhLgQ3KCXTmzsBEdgXIUzxj99xFw4AJ4LGY6FGYNMH6Ed+1YhyVmmW2
	dSmkq9muFGthmQSlr5IMXIfG+PB3GfJFxFFOryBwbw==
X-Google-Smtp-Source: ADFU+vtYDJ13Duz6ckwhGdZm21tZ+Kg6VHjBFgfaPtTtPJACd+l6/VGlHTLDhLEcu8EYuwx1H1IWNeYptubQg4xr5hI=
X-Received: by 2002:a05:6402:22b7:: with SMTP id cx23mr19203222edb.383.1585730941065;
 Wed, 01 Apr 2020 01:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-7-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-7-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 01:48:50 -0700
Message-ID: <CAPcyv4jyFQa5BDPCSQ6kmFY8CvWgbydePcn8B4M_Zyc1c7MGpg@mail.gmail.com>
Subject: Re: [PATCH v4 06/25] ocxl: Tally up the LPC memory on a link & allow
 it to be mapped
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: MF7S6LQWII275ZKJWPAXBPRXHBZVUA7O
X-Message-ID-Hash: MF7S6LQWII275ZKJWPAXBPRXHBZVUA7O
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MF7S6LQWII275ZKJWPAXBPRXHBZVUA7O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:53 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> OpenCAPI LPC memory is allocated per link, but each link supports
> multiple AFUs, and each AFU can have LPC memory assigned to it.

Is there an OpenCAPI primer to decode these objects and their
associations that I can reference?


>
> This patch tallys the memory for all AFUs on a link, allowing it
> to be mapped in a single operation after the AFUs have been
> enumerated.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/misc/ocxl/core.c          | 10 ++++++
>  drivers/misc/ocxl/link.c          | 60 +++++++++++++++++++++++++++++++
>  drivers/misc/ocxl/ocxl_internal.h | 33 +++++++++++++++++
>  3 files changed, 103 insertions(+)
>
> diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
> index b7a09b21ab36..2531c6cf19a0 100644
> --- a/drivers/misc/ocxl/core.c
> +++ b/drivers/misc/ocxl/core.c
> @@ -230,8 +230,18 @@ static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
>         if (rc)
>                 goto err_free_pasid;
>
> +       if (afu->config.lpc_mem_size || afu->config.special_purpose_mem_size) {
> +               rc = ocxl_link_add_lpc_mem(afu->fn->link, afu->config.lpc_mem_offset,
> +                                          afu->config.lpc_mem_size +
> +                                          afu->config.special_purpose_mem_size);
> +               if (rc)
> +                       goto err_free_mmio;
> +       }
> +
>         return 0;
>
> +err_free_mmio:
> +       unmap_mmio_areas(afu);
>  err_free_pasid:
>         reclaim_afu_pasid(afu);
>  err_free_actag:
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index 58d111afd9f6..af119d3ef79a 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -84,6 +84,11 @@ struct ocxl_link {
>         int dev;
>         atomic_t irq_available;
>         struct spa *spa;
> +       struct mutex lpc_mem_lock; /* protects lpc_mem & lpc_mem_sz */
> +       u64 lpc_mem_sz; /* Total amount of LPC memory presented on the link */
> +       u64 lpc_mem;
> +       int lpc_consumers;
> +
>         void *platform_data;
>  };
>  static struct list_head links_list = LIST_HEAD_INIT(links_list);
> @@ -396,6 +401,8 @@ static int alloc_link(struct pci_dev *dev, int PE_mask, struct ocxl_link **out_l
>         if (rc)
>                 goto err_spa;
>
> +       mutex_init(&link->lpc_mem_lock);
> +
>         /* platform specific hook */
>         rc = pnv_ocxl_spa_setup(dev, link->spa->spa_mem, PE_mask,
>                                 &link->platform_data);
> @@ -711,3 +718,56 @@ void ocxl_link_free_irq(void *link_handle, int hw_irq)
>         atomic_inc(&link->irq_available);
>  }
>  EXPORT_SYMBOL_GPL(ocxl_link_free_irq);
> +
> +int ocxl_link_add_lpc_mem(void *link_handle, u64 offset, u64 size)
> +{
> +       struct ocxl_link *link = (struct ocxl_link *)link_handle;
> +
> +       // Check for overflow
> +       if (offset > (offset + size))
> +               return -EINVAL;
> +
> +       mutex_lock(&link->lpc_mem_lock);
> +       link->lpc_mem_sz = max(link->lpc_mem_sz, offset + size);
> +
> +       mutex_unlock(&link->lpc_mem_lock);
> +
> +       return 0;
> +}
> +
> +u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev)
> +{
> +       struct ocxl_link *link = (struct ocxl_link *)link_handle;
> +
> +       mutex_lock(&link->lpc_mem_lock);
> +
> +       if (!link->lpc_mem)
> +               link->lpc_mem = pnv_ocxl_platform_lpc_setup(pdev, link->lpc_mem_sz);
> +
> +       if (link->lpc_mem)
> +               link->lpc_consumers++;
> +       mutex_unlock(&link->lpc_mem_lock);
> +
> +       return link->lpc_mem;
> +}
> +
> +void ocxl_link_lpc_release(void *link_handle, struct pci_dev *pdev)
> +{
> +       struct ocxl_link *link = (struct ocxl_link *)link_handle;
> +
> +       mutex_lock(&link->lpc_mem_lock);
> +
> +       if (!link->lpc_mem) {
> +               mutex_unlock(&link->lpc_mem_lock);
> +               return;
> +       }
> +
> +       WARN_ON(--link->lpc_consumers < 0);
> +
> +       if (link->lpc_consumers == 0) {
> +               pnv_ocxl_platform_lpc_release(pdev);
> +               link->lpc_mem = 0;
> +       }
> +
> +       mutex_unlock(&link->lpc_mem_lock);
> +}
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 198e4e4bc51d..2d7575225bd7 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -142,4 +142,37 @@ int ocxl_irq_offset_to_id(struct ocxl_context *ctx, u64 offset);
>  u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id);
>  void ocxl_afu_irq_free_all(struct ocxl_context *ctx);
>
> +/**
> + * ocxl_link_add_lpc_mem() - Increment the amount of memory required by an OpenCAPI link
> + *
> + * @link_handle: The OpenCAPI link handle
> + * @offset: The offset of the memory to add
> + * @size: The number of bytes to increment memory on the link by
> + *
> + * Returns 0 on success, -EINVAL on overflow
> + */
> +int ocxl_link_add_lpc_mem(void *link_handle, u64 offset, u64 size);
> +
> +/**
> + * ocxl_link_lpc_map() - Map the LPC memory for an OpenCAPI device
> + * Since LPC memory belongs to a link, the whole LPC memory available
> + * on the link must be mapped in order to make it accessible to a device.
> + * @link_handle: The OpenCAPI link handle
> + * @pdev: A device that is on the link
> + *
> + * Returns the address of the mapped LPC memory, or 0 on error
> + */
> +u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev);
> +
> +/**
> + * ocxl_link_lpc_release() - Release the LPC memory device for an OpenCAPI device
> + *
> + * Offlines LPC memory on an OpenCAPI link for a device. If this is the
> + * last device on the link to release the memory, unmap it from the link.
> + *
> + * @link_handle: The OpenCAPI link handle
> + * @pdev: A device that is on the link
> + */
> +void ocxl_link_lpc_release(void *link_handle, struct pci_dev *pdev);
> +
>  #endif /* _OCXL_INTERNAL_H_ */
> --
> 2.24.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
