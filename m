Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A2F19A7B6
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 10:48:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 232F310FC3BB8;
	Wed,  1 Apr 2020 01:49:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4769010FC3BB1
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 01:49:45 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a43so28679568edf.6
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 01:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nO7NvYL5YbGkypKxGoWuwxxFk6qjRVPvgK2ifgde8ys=;
        b=nKT1PI4lZjRkGXA0qoVt39rD6dCkioi4T1wOtFKczerqB7xR37+SXrexLXVaxyRoRZ
         P/MQ9KkylbCIRFpuT/z2h482ouR713/nq6B9H5/rP7dskLnqLtnramvo665NSX0DmbN8
         77xpnQ9Sm/oZOinLBRsbN0Aq/CY0nAN421P4ND2RoGjW6GiHNbw4u7zITADs4vFdTR7w
         mr9q4JNLEUMY3rKgONFt7/nL5sDfFJp+oXDZsgjhTLd41jLz9ChU3YKFsf9/4GiELmlO
         DUygUUNqRx08PsUj63TKvtq0MTZCMgb+awXdTOjVXo/0Y7HZa/5sHB1KmL2ZXuKtyS1S
         oDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nO7NvYL5YbGkypKxGoWuwxxFk6qjRVPvgK2ifgde8ys=;
        b=hw5xZaal0ljaPxl2keZdZuFxqifLuY61oCO6PHHCrV/yqvl0pJLf4/SIhnOjX8nVz/
         LVUHcRM40TqPeS4W0LgROyI2eORMYnXW0YTsB+rzpUoEUfJE0s+pznCQ3D2B9cJd2Rkv
         /c0/SXDhpwLZ7dI+8dV+dgUTXXIZgcihMsIcOem1LakHj0Rpy3kNEEBKvnfggrsoGRtx
         IxJjQ2S1E0uEW/vuJW0pyaCAPrtTAie4tpqebQaYk2FkkhciZSlnOC+SYUWT86Fi0XWe
         xQEyq1KJiekQBBxP5nzINfvhx7p9uA0o6lguOxih573ZE7ar1/NzDdME5itVJ361xnQW
         R5Gg==
X-Gm-Message-State: ANhLgQ0jp7PhTq+vNCYF/9jpNiPgVpnPLxE6dsLvct+9qUei5GMvI3H0
	SmsxEbGRUSAjgt+ui4egS32b5yKYiHcvh3cU7M+HmQ==
X-Google-Smtp-Source: ADFU+vufccZcs61ZBlmuOm7ukHfWC6ZhrwNFAphauzXSa/puB0SAYGjCUbhdXtkYuKjFSx5h5oNBplH8yyO/gpHPw6E=
X-Received: by 2002:a17:906:4bc4:: with SMTP id x4mr14096929ejv.201.1585730934033;
 Wed, 01 Apr 2020 01:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-5-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-5-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 01:48:42 -0700
Message-ID: <CAPcyv4hs=4-0UF+bvFFuJb=n-VeMV62-DM_=3LUgMkro6nh2=w@mail.gmail.com>
Subject: Re: [PATCH v4 04/25] ocxl: Remove unnecessary externs
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: XO2LPVN5OLYRQQR2H3OL5LTEHLQ6NRHL
X-Message-ID-Hash: XO2LPVN5OLYRQQR2H3OL5LTEHLQ6NRHL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XO2LPVN5OLYRQQR2H3OL5LTEHLQ6NRHL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> Function declarations don't need externs, remove the existing ones
> so they are consistent with newer code
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>

Looks good.


> ---
>  arch/powerpc/include/asm/pnv-ocxl.h | 40 ++++++++++++++---------------
>  include/misc/ocxl.h                 |  6 ++---
>  2 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> index 560a19bb71b7..205efc41a33c 100644
> --- a/arch/powerpc/include/asm/pnv-ocxl.h
> +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> @@ -9,29 +9,27 @@
>  #define PNV_OCXL_TL_BITS_PER_RATE       4
>  #define PNV_OCXL_TL_RATE_BUF_SIZE       ((PNV_OCXL_TL_MAX_TEMPLATE+1) * PNV_OCXL_TL_BITS_PER_RATE / 8)
>
> -extern int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled,
> -                       u16 *supported);
> -extern int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count);
> +int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled, u16 *supported);
> +int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count);
>
> -extern int pnv_ocxl_get_tl_cap(struct pci_dev *dev, long *cap,
> +int pnv_ocxl_get_tl_cap(struct pci_dev *dev, long *cap,
>                         char *rate_buf, int rate_buf_size);
> -extern int pnv_ocxl_set_tl_conf(struct pci_dev *dev, long cap,
> -                       uint64_t rate_buf_phys, int rate_buf_size);
> -
> -extern int pnv_ocxl_get_xsl_irq(struct pci_dev *dev, int *hwirq);
> -extern void pnv_ocxl_unmap_xsl_regs(void __iomem *dsisr, void __iomem *dar,
> -                               void __iomem *tfc, void __iomem *pe_handle);
> -extern int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
> -                               void __iomem **dar, void __iomem **tfc,
> -                               void __iomem **pe_handle);
> -
> -extern int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask,
> -                       void **platform_data);
> -extern void pnv_ocxl_spa_release(void *platform_data);
> -extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle);
> -
> -extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
> -extern void pnv_ocxl_free_xive_irq(u32 irq);
> +int pnv_ocxl_set_tl_conf(struct pci_dev *dev, long cap,
> +                        uint64_t rate_buf_phys, int rate_buf_size);
> +
> +int pnv_ocxl_get_xsl_irq(struct pci_dev *dev, int *hwirq);
> +void pnv_ocxl_unmap_xsl_regs(void __iomem *dsisr, void __iomem *dar,
> +                            void __iomem *tfc, void __iomem *pe_handle);
> +int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
> +                         void __iomem **dar, void __iomem **tfc,
> +                         void __iomem **pe_handle);
> +
> +int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask, void **platform_data);
> +void pnv_ocxl_spa_release(void *platform_data);
> +int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle);
> +
> +int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
> +void pnv_ocxl_free_xive_irq(u32 irq);
>  u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size);
>  void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
>
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 06dd5839e438..0a762e387418 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -173,7 +173,7 @@ int ocxl_context_detach(struct ocxl_context *ctx);
>   *
>   * Returns 0 on success, negative on failure
>   */
> -extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
> +int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
>
>  /**
>   * Frees an IRQ associated with an AFU context
> @@ -182,7 +182,7 @@ extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
>   *
>   * Returns 0 on success, negative on failure
>   */
> -extern int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
> +int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
>
>  /**
>   * Gets the address of the trigger page for an IRQ
> @@ -193,7 +193,7 @@ extern int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
>   *
>   * returns the trigger page address, or 0 if the IRQ is not valid
>   */
> -extern u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
> +u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
>
>  /**
>   * Provide a callback to be called when an IRQ is triggered
> --
> 2.24.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
