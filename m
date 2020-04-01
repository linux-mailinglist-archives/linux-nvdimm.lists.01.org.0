Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB019A7B0
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 10:48:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08D5D10FC3BB1;
	Wed,  1 Apr 2020 01:49:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3C26010FC3BB1
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 01:49:35 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id z65so28729841ede.0
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFnQtMAv52vc67tP5TFOUo3bRsY9ihV28ROS9W2huxg=;
        b=UGfBm0OG6dm/aY2vbCbLWqdatsFbxQNSssJ6VGYhMiDq/OZ3CcwFMRXjdJP0AXYK7D
         qh0ra8EMgQmGzX4Fxxcv2zpRpA6bvmpNcGy3vpPXv3wvgBL5g1kIy0ijObNxfTpeqLe8
         zJQlvRgzdUnUwCw9a3vVQyhTkhOj1bGwFPHvgJUavxqHY6EN1biqXsQJEuRb2ZAx1+la
         bIBqqpPryQe7pXTndun8sNc9rg9fyRYz2RGUeOFAXiGwD9NEgCHUS1mhusff7WG/rzRe
         rFzKfqWGnLyr5HwxUXqFoo2mpn0Y5mBOQNJqTToIbYTuOKzCLXGk0bf6ytMk5SVA0IRX
         r6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFnQtMAv52vc67tP5TFOUo3bRsY9ihV28ROS9W2huxg=;
        b=brguheckv6m8BOlRb190jsYrIx71Qz+M/5NTNss3+WqsHm/LKejtWG4HWs8H8I8TnY
         rZHLS1CPv2xum3ddLvAKFqY80KP3Npt0XYjiEcbJWY44eSjqtUi5qBBPP05MhWCD6noC
         Lr9pWbptR23VxQ5lSPKjFobyJfQ9NY9+W1XXWGuwikQVutejOZJaTb8OL0skL3vZpKo+
         gaFPJSlCpc2zsADr6Al7uglvZHtj5dOmswWbRJKPPqhE4dB2QLYo5n0q9/QMs03jOJFv
         ihkriNfdRiZyb7gRg2zTS8qj1OL39PXc/fO0HQIElVriVrkZ2phwZL5ZnKJS6sMm5xrz
         hhcw==
X-Gm-Message-State: ANhLgQ0bXkHlZN6/q5yg9pukdGBp8Uw0gYVMlUTQSTXWN63JD/PrTDJH
	6G+TNyp9Zt66U/diRKIabmCeI+CRBovxkTqdAcWHxA==
X-Google-Smtp-Source: ADFU+vudGlnJtN5ZeSeIRWxrez165WdBj7a1Bu0ZFHM+ccZlxf9ge6aKX/I8+gF5fOEuZLiG5EzKhnaDmM289WwDWgA=
X-Received: by 2002:a50:d847:: with SMTP id v7mr19478119edj.154.1585730924056;
 Wed, 01 Apr 2020 01:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-4-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-4-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 01:48:32 -0700
Message-ID: <CAPcyv4iGEHJpZctEm+Do1-kOZBUDeKKcREr=BqcK4kCvLWhAQQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/25] powerpc/powernv: Map & release OpenCAPI LPC memory
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: NVGWIU4YCCIN2KEEBIRWR2NSHVN3SZLO
X-Message-ID-Hash: NVGWIU4YCCIN2KEEBIRWR2NSHVN3SZLO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NVGWIU4YCCIN2KEEBIRWR2NSHVN3SZLO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> This patch adds OPAL calls to powernv so that the OpenCAPI
> driver can map & release LPC (Lowest Point of Coherency)  memory.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/pnv-ocxl.h   |  2 ++
>  arch/powerpc/platforms/powernv/ocxl.c | 43 +++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> index 7de82647e761..560a19bb71b7 100644
> --- a/arch/powerpc/include/asm/pnv-ocxl.h
> +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> @@ -32,5 +32,7 @@ extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
>
>  extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
>  extern void pnv_ocxl_free_xive_irq(u32 irq);
> +u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size);
> +void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
>
>  #endif /* _ASM_PNV_OCXL_H */
> diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
> index 8c65aacda9c8..f13119a7c026 100644
> --- a/arch/powerpc/platforms/powernv/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/ocxl.c
> @@ -475,6 +475,49 @@ void pnv_ocxl_spa_release(void *platform_data)
>  }
>  EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
>
> +u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size)
> +{
> +       struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +       struct pnv_phb *phb = hose->private_data;

Is calling the local variable 'hose' instead of 'host' on purpose?

> +       u32 bdfn = pci_dev_id(pdev);
> +       __be64 base_addr_be64;
> +       u64 base_addr;
> +       int rc;
> +
> +       rc = opal_npu_mem_alloc(phb->opal_id, bdfn, size, &base_addr_be64);
> +       if (rc) {
> +               dev_warn(&pdev->dev,
> +                        "OPAL could not allocate LPC memory, rc=%d\n", rc);
> +               return 0;
> +       }
> +
> +       base_addr = be64_to_cpu(base_addr_be64);
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE

With the proposed cleanup in patch2 the ifdef can be elided here.

> +       rc = check_hotplug_memory_addressable(base_addr >> PAGE_SHIFT,
> +                                             size >> PAGE_SHIFT);
> +       if (rc)
> +               return 0;

Is this an error worth logging if someone is wondering why their
device is not showing up?


> +#endif
> +
> +       return base_addr;
> +}
> +EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_setup);
> +
> +void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev)
> +{
> +       struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +       struct pnv_phb *phb = hose->private_data;
> +       u32 bdfn = pci_dev_id(pdev);
> +       int rc;
> +
> +       rc = opal_npu_mem_release(phb->opal_id, bdfn);
> +       if (rc)
> +               dev_warn(&pdev->dev,
> +                        "OPAL reported rc=%d when releasing LPC memory\n", rc);
> +}
> +EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_release);
> +
>  int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
>  {
>         struct spa_data *data = (struct spa_data *) platform_data;
> --
> 2.24.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
