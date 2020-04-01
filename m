Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F5C19A7BA
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 10:49:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 550EE10FC3BAE;
	Wed,  1 Apr 2020 01:50:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 65E0310FC3BAD
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 01:50:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a43so28680573edf.6
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHe1e/PC2z37detN1WQKWhENlwvS1+8e4Z52I+6QrPI=;
        b=kLE+aEwcdBdp4prVWbr9R8fJ2ZzRMy5+F1Ca6z4r+7CzfVe6RxQ00SoxWbDNsoD0Cy
         fV1yu7SwsOeaWGVWZh46H+MtDeqae2qVQkKe4WWeeYkZnviQNIdUSKf8Lh3SjqVNz6se
         YSV3dRb/umlg6z5c2M2QZnchxfa40SgZm56m7gvallcRODKH/eyWB9HwxqycTbXwnrTe
         Y7dmdqtVkiMAJ+LAArUaYX9RSx33PVlLwdSLUYf4zesHgSZUS1vf///WXbRQqoEuXBs+
         67JWd8tnzIGSNbauwMZgZO2HXvHeGapmN5qVoMtz+G0FP7DOFOvTfM9qmiMh/UEvPsb/
         ePGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHe1e/PC2z37detN1WQKWhENlwvS1+8e4Z52I+6QrPI=;
        b=OOaQsBx5WS6qlHZGahHNk3OgdYA0WKL6K/EN4CqfPIa4If7FvjTUbK5odL9BE35GD5
         ouNc3t7cS0cEg3PaF5jgIWHiUzJY3zhX4cJ8EiFE+cO5zIaWmx1IE+sL4wmRsX6ceQ9I
         qudYPSEfWz3GN4V44YomY8/tDJIq4fdhcxqwO0JbmBdiEhTbTj+j/qglHQ5p4UoYT1Kx
         PTntDR2bGTSRdGU0YzAuf0h9FlyrpMMr4ZLA6tfvkGrb5/N60BGbdTuI8VDLity7dzrA
         603/rBazxImrYeWUKoMRDL8wYhdMNrcyNRjBrtAshplf4Fj2EhkVhT0RxdvTA0XogLL9
         bjjg==
X-Gm-Message-State: ANhLgQ3Sxz/Z0AgvhPqoFrekgXSETNICWIvS7hYWoIv8+7TF/M33LQhZ
	bdQ2/fM33lJd4uyWrpGHwSflFWYcq9bGVXhPpskh+g==
X-Google-Smtp-Source: ADFU+vuD7X7woQG83wztP9MaJVXOOkR2dKZNHdzkuewDZ1eAHCWISkaX44mK03UXD+Yvj6aUPY6FlPTcybndxfLUP5U=
X-Received: by 2002:aa7:c609:: with SMTP id h9mr19214445edq.93.1585730956083;
 Wed, 01 Apr 2020 01:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-6-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-6-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 01:49:04 -0700
Message-ID: <CAPcyv4jd2mjiTo7NSm_Q=SbCB6EmPvqvDN4u85j2ufUZ0meGig@mail.gmail.com>
Subject: Re: [PATCH v4 05/25] ocxl: Address kernel doc errors & warnings
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: GWRPZDRONKSRKFCXRVFFPGW3INFZ5HXP
X-Message-ID-Hash: GWRPZDRONKSRKFCXRVFFPGW3INFZ5HXP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GWRPZDRONKSRKFCXRVFFPGW3INFZ5HXP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> This patch addresses warnings and errors from the kernel doc scripts for
> the OpenCAPI driver.
>
> It also makes minor tweaks to make the docs more consistent.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  drivers/misc/ocxl/config.c        | 24 ++++----
>  drivers/misc/ocxl/ocxl_internal.h |  9 +--
>  include/misc/ocxl.h               | 96 ++++++++++++-------------------
>  3 files changed, 55 insertions(+), 74 deletions(-)

Looks good.


>
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index c8e19bfb5ef9..a62e3d7db2bf 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -273,16 +273,16 @@ static int read_afu_info(struct pci_dev *dev, struct ocxl_fn_config *fn,
>  }
>
>  /**
> - * Read the template version from the AFU
> - * dev: the device for the AFU
> - * fn: the AFU offsets
> - * len: outputs the template length
> - * version: outputs the major<<8,minor version
> + * read_template_version() - Read the template version from the AFU
> + * @dev: the device for the AFU
> + * @fn: the AFU offsets
> + * @len: outputs the template length
> + * @version: outputs the major<<8,minor version
>   *
>   * Returns 0 on success, negative on failure
>   */
>  static int read_template_version(struct pci_dev *dev, struct ocxl_fn_config *fn,
> -               u16 *len, u16 *version)
> +                                u16 *len, u16 *version)
>  {
>         u32 val32;
>         u8 major, minor;
> @@ -476,16 +476,16 @@ static int validate_afu(struct pci_dev *dev, struct ocxl_afu_config *afu)
>  }
>
>  /**
> - * Populate AFU metadata regarding LPC memory
> - * dev: the device for the AFU
> - * fn: the AFU offsets
> - * afu: the AFU struct to populate the LPC metadata into
> + * read_afu_lpc_memory_info() - Populate AFU metadata regarding LPC memory
> + * @dev: the device for the AFU
> + * @fn: the AFU offsets
> + * @afu: the AFU struct to populate the LPC metadata into
>   *
>   * Returns 0 on success, negative on failure
>   */
>  static int read_afu_lpc_memory_info(struct pci_dev *dev,
> -                               struct ocxl_fn_config *fn,
> -                               struct ocxl_afu_config *afu)
> +                                   struct ocxl_fn_config *fn,
> +                                   struct ocxl_afu_config *afu)
>  {
>         int rc;
>         u32 val32;
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 345bf843a38e..198e4e4bc51d 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -122,11 +122,12 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
>                                 struct ocxl_fn_config *fn, int afu_idx);
>
>  /**
> - * Update values within a Process Element
> + * ocxl_link_update_pe() - Update values within a Process Element
> + * @link_handle: the link handle associated with the process element
> + * @pasid: the PASID for the AFU context
> + * @tid: the new thread id for the process element
>   *
> - * link_handle: the link handle associated with the process element
> - * pasid: the PASID for the AFU context
> - * tid: the new thread id for the process element
> + * Returns 0 on success
>   */
>  int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
>
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 0a762e387418..357ef1aadbc0 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -62,8 +62,7 @@ struct ocxl_context;
>  // Device detection & initialisation
>
>  /**
> - * Open an OpenCAPI function on an OpenCAPI device
> - *
> + * ocxl_function_open() - Open an OpenCAPI function on an OpenCAPI device
>   * @dev: The PCI device that contains the function
>   *
>   * Returns an opaque pointer to the function, or an error pointer (check with IS_ERR)
> @@ -71,8 +70,7 @@ struct ocxl_context;
>  struct ocxl_fn *ocxl_function_open(struct pci_dev *dev);
>
>  /**
> - * Get the list of AFUs associated with a PCI function device
> - *
> + * ocxl_function_afu_list() - Get the list of AFUs associated with a PCI function device
>   * Returns a list of struct ocxl_afu *
>   *
>   * @fn: The OpenCAPI function containing the AFUs
> @@ -80,8 +78,7 @@ struct ocxl_fn *ocxl_function_open(struct pci_dev *dev);
>  struct list_head *ocxl_function_afu_list(struct ocxl_fn *fn);
>
>  /**
> - * Fetch an AFU instance from an OpenCAPI function
> - *
> + * ocxl_function_fetch_afu() - Fetch an AFU instance from an OpenCAPI function
>   * @fn: The OpenCAPI function to get the AFU from
>   * @afu_idx: The index of the AFU to get
>   *
> @@ -92,23 +89,20 @@ struct list_head *ocxl_function_afu_list(struct ocxl_fn *fn);
>  struct ocxl_afu *ocxl_function_fetch_afu(struct ocxl_fn *fn, u8 afu_idx);
>
>  /**
> - * Take a reference to an AFU
> - *
> + * ocxl_afu_get() - Take a reference to an AFU
>   * @afu: The AFU to increment the reference count on
>   */
>  void ocxl_afu_get(struct ocxl_afu *afu);
>
>  /**
> - * Release a reference to an AFU
> - *
> + * ocxl_afu_put() - Release a reference to an AFU
>   * @afu: The AFU to decrement the reference count on
>   */
>  void ocxl_afu_put(struct ocxl_afu *afu);
>
>
>  /**
> - * Get the configuration information for an OpenCAPI function
> - *
> + * ocxl_function_config() - Get the configuration information for an OpenCAPI function
>   * @fn: The OpenCAPI function to get the config for
>   *
>   * Returns the function config, or NULL on error
> @@ -116,8 +110,7 @@ void ocxl_afu_put(struct ocxl_afu *afu);
>  const struct ocxl_fn_config *ocxl_function_config(struct ocxl_fn *fn);
>
>  /**
> - * Close an OpenCAPI function
> - *
> + * ocxl_function_close() - Close an OpenCAPI function
>   * This will free any AFUs previously retrieved from the function, and
>   * detach and associated contexts. The contexts must by freed by the caller.
>   *
> @@ -129,8 +122,7 @@ void ocxl_function_close(struct ocxl_fn *fn);
>  // Context allocation
>
>  /**
> - * Allocate an OpenCAPI context
> - *
> + * ocxl_context_alloc() - Allocate an OpenCAPI context
>   * @context: The OpenCAPI context to allocate, must be freed with ocxl_context_free
>   * @afu: The AFU the context belongs to
>   * @mapping: The mapping to unmap when the context is closed (may be NULL)
> @@ -139,14 +131,13 @@ int ocxl_context_alloc(struct ocxl_context **context, struct ocxl_afu *afu,
>                         struct address_space *mapping);
>
>  /**
> - * Free an OpenCAPI context
> - *
> + * ocxl_context_free() - Free an OpenCAPI context
>   * @ctx: The OpenCAPI context to free
>   */
>  void ocxl_context_free(struct ocxl_context *ctx);
>
>  /**
> - * Grant access to an MM to an OpenCAPI context
> + * ocxl_context_attach() - Grant access to an MM to an OpenCAPI context
>   * @ctx: The OpenCAPI context to attach
>   * @amr: The value of the AMR register to restrict access
>   * @mm: The mm to attach to the context
> @@ -157,7 +148,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr,
>                                 struct mm_struct *mm);
>
>  /**
> - * Detach an MM from an OpenCAPI context
> + * ocxl_context_detach() - Detach an MM from an OpenCAPI context
>   * @ctx: The OpenCAPI context to attach
>   *
>   * Returns 0 on success, negative on failure
> @@ -167,7 +158,7 @@ int ocxl_context_detach(struct ocxl_context *ctx);
>  // AFU IRQs
>
>  /**
> - * Allocate an IRQ associated with an AFU context
> + * ocxl_afu_irq_alloc() - Allocate an IRQ associated with an AFU context
>   * @ctx: the AFU context
>   * @irq_id: out, the IRQ ID
>   *
> @@ -176,7 +167,7 @@ int ocxl_context_detach(struct ocxl_context *ctx);
>  int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
>
>  /**
> - * Frees an IRQ associated with an AFU context
> + * ocxl_afu_irq_free() - Frees an IRQ associated with an AFU context
>   * @ctx: the AFU context
>   * @irq_id: the IRQ ID
>   *
> @@ -185,7 +176,7 @@ int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
>  int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
>
>  /**
> - * Gets the address of the trigger page for an IRQ
> + * ocxl_afu_irq_get_addr() - Gets the address of the trigger page for an IRQ
>   * This can then be provided to an AFU which will write to that
>   * page to trigger the IRQ.
>   * @ctx: The AFU context that the IRQ is associated with
> @@ -196,7 +187,7 @@ int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
>  u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
>
>  /**
> - * Provide a callback to be called when an IRQ is triggered
> + * ocxl_irq_set_handler() - Provide a callback to be called when an IRQ is triggered
>   * @ctx: The AFU context that the IRQ is associated with
>   * @irq_id: The IRQ ID
>   * @handler: the callback to be called when the IRQ is triggered
> @@ -213,8 +204,7 @@ int ocxl_irq_set_handler(struct ocxl_context *ctx, int irq_id,
>  // AFU Metadata
>
>  /**
> - * Get a pointer to the config for an AFU
> - *
> + * ocxl_afu_config() - Get a pointer to the config for an AFU
>   * @afu: a pointer to the AFU to get the config for
>   *
>   * Returns a pointer to the AFU config
> @@ -222,27 +212,24 @@ int ocxl_irq_set_handler(struct ocxl_context *ctx, int irq_id,
>  struct ocxl_afu_config *ocxl_afu_config(struct ocxl_afu *afu);
>
>  /**
> - * Assign opaque hardware specific information to an OpenCAPI AFU.
> - *
> - * @dev: The PCI device associated with the OpenCAPI device
> + * ocxl_afu_set_private() - Assign opaque hardware specific information to an OpenCAPI AFU.
> + * @afu: The OpenCAPI AFU
>   * @private: the opaque hardware specific information to assign to the driver
>   */
>  void ocxl_afu_set_private(struct ocxl_afu *afu, void *private);
>
>  /**
> - * Fetch the hardware specific information associated with an external OpenCAPI
> - * AFU. This may be consumed by an external OpenCAPI driver.
> - *
> - * @afu: The AFU
> + * ocxl_afu_get_private() - Fetch the hardware specific information associated with
> + * an external OpenCAPI AFU. This may be consumed by an external OpenCAPI driver.
> + * @afu: The OpenCAPI AFU
>   *
>   * Returns the opaque pointer associated with the device, or NULL if not set
>   */
> -void *ocxl_afu_get_private(struct ocxl_afu *dev);
> +void *ocxl_afu_get_private(struct ocxl_afu *afu);
>
>  // Global MMIO
>  /**
> - * Read a 32 bit value from global MMIO
> - *
> + * ocxl_global_mmio_read32() - Read a 32 bit value from global MMIO
>   * @afu: The AFU
>   * @offset: The Offset from the start of MMIO
>   * @endian: the endianness that the MMIO data is in
> @@ -251,11 +238,10 @@ void *ocxl_afu_get_private(struct ocxl_afu *dev);
>   * Returns 0 for success, negative on error
>   */
>  int ocxl_global_mmio_read32(struct ocxl_afu *afu, size_t offset,
> -                               enum ocxl_endian endian, u32 *val);
> +                           enum ocxl_endian endian, u32 *val);
>
>  /**
> - * Read a 64 bit value from global MMIO
> - *
> + * ocxl_global_mmio_read64() - Read a 64 bit value from global MMIO
>   * @afu: The AFU
>   * @offset: The Offset from the start of MMIO
>   * @endian: the endianness that the MMIO data is in
> @@ -264,11 +250,10 @@ int ocxl_global_mmio_read32(struct ocxl_afu *afu, size_t offset,
>   * Returns 0 for success, negative on error
>   */
>  int ocxl_global_mmio_read64(struct ocxl_afu *afu, size_t offset,
> -                               enum ocxl_endian endian, u64 *val);
> +                           enum ocxl_endian endian, u64 *val);
>
>  /**
> - * Write a 32 bit value to global MMIO
> - *
> + * ocxl_global_mmio_write32() - Write a 32 bit value to global MMIO
>   * @afu: The AFU
>   * @offset: The Offset from the start of MMIO
>   * @endian: the endianness that the MMIO data is in
> @@ -277,11 +262,10 @@ int ocxl_global_mmio_read64(struct ocxl_afu *afu, size_t offset,
>   * Returns 0 for success, negative on error
>   */
>  int ocxl_global_mmio_write32(struct ocxl_afu *afu, size_t offset,
> -                               enum ocxl_endian endian, u32 val);
> +                            enum ocxl_endian endian, u32 val);
>
>  /**
> - * Write a 64 bit value to global MMIO
> - *
> + * ocxl_global_mmio_write64() - Write a 64 bit value to global MMIO
>   * @afu: The AFU
>   * @offset: The Offset from the start of MMIO
>   * @endian: the endianness that the MMIO data is in
> @@ -290,11 +274,10 @@ int ocxl_global_mmio_write32(struct ocxl_afu *afu, size_t offset,
>   * Returns 0 for success, negative on error
>   */
>  int ocxl_global_mmio_write64(struct ocxl_afu *afu, size_t offset,
> -                               enum ocxl_endian endian, u64 val);
> +                            enum ocxl_endian endian, u64 val);
>
>  /**
> - * Set bits in a 32 bit global MMIO register
> - *
> + * ocxl_global_mmio_set32() - Set bits in a 32 bit global MMIO register
>   * @afu: The AFU
>   * @offset: The Offset from the start of MMIO
>   * @endian: the endianness that the MMIO data is in
> @@ -303,11 +286,10 @@ int ocxl_global_mmio_write64(struct ocxl_afu *afu, size_t offset,
>   * Returns 0 for success, negative on error
>   */
>  int ocxl_global_mmio_set32(struct ocxl_afu *afu, size_t offset,
> -                               enum ocxl_endian endian, u32 mask);
> +                          enum ocxl_endian endian, u32 mask);
>
>  /**
> - * Set bits in a 64 bit global MMIO register
> - *
> + * ocxl_global_mmio_set64() - Set bits in a 64 bit global MMIO register
>   * @afu: The AFU
>   * @offset: The Offset from the start of MMIO
>   * @endian: the endianness that the MMIO data is in
> @@ -316,11 +298,10 @@ int ocxl_global_mmio_set32(struct ocxl_afu *afu, size_t offset,
>   * Returns 0 for success, negative on error
>   */
>  int ocxl_global_mmio_set64(struct ocxl_afu *afu, size_t offset,
> -                               enum ocxl_endian endian, u64 mask);
> +                          enum ocxl_endian endian, u64 mask);
>
>  /**
> - * Set bits in a 32 bit global MMIO register
> - *
> + * ocxl_global_mmio_clear32() - Set bits in a 32 bit global MMIO register
>   * @afu: The AFU
>   * @offset: The Offset from the start of MMIO
>   * @endian: the endianness that the MMIO data is in
> @@ -329,11 +310,10 @@ int ocxl_global_mmio_set64(struct ocxl_afu *afu, size_t offset,
>   * Returns 0 for success, negative on error
>   */
>  int ocxl_global_mmio_clear32(struct ocxl_afu *afu, size_t offset,
> -                               enum ocxl_endian endian, u32 mask);
> +                            enum ocxl_endian endian, u32 mask);
>
>  /**
> - * Set bits in a 64 bit global MMIO register
> - *
> + * ocxl_global_mmio_clear64() - Set bits in a 64 bit global MMIO register
>   * @afu: The AFU
>   * @offset: The Offset from the start of MMIO
>   * @endian: the endianness that the MMIO data is in
> @@ -342,7 +322,7 @@ int ocxl_global_mmio_clear32(struct ocxl_afu *afu, size_t offset,
>   * Returns 0 for success, negative on error
>   */
>  int ocxl_global_mmio_clear64(struct ocxl_afu *afu, size_t offset,
> -                               enum ocxl_endian endian, u64 mask);
> +                            enum ocxl_endian endian, u64 mask);
>
>  // Functions left here are for compatibility with the cxlflash driver
>
> --
> 2.24.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
