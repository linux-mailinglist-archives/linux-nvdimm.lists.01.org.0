Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E823E7CB9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Oct 2019 00:08:53 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 22356100EA520;
	Mon, 28 Oct 2019 16:09:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 823A3100EA63F
	for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 16:09:37 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id g81so7390167oib.8
        for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ya/hl3kSxLpkLPv5c7BeEGlhWkdu/wLTkTM0UC21b64=;
        b=h5sKvzwG18seVCu38EtLBa8XX3UEDh3zXJALKsSIPpKx30ctYy0LEmiydo2CnuPahe
         ELqGsk5TH8vpYL8/aVfVzYD3Zka2Qh9e9Wy1gkJOeRmzczxduc0z6kxJamVHrs/OQ8tw
         M3RzxVLGTwRdwd8jV9GYKb8zgU5btAT5XsEl6ODU2DqG0c3ipk+RsiDUTJdJLLQSfUjB
         eE3ieaJs7iLafKik9Mf8V54bP7Y/R/nW1OqhncnY5fHof16j1hFNmsAy3RAFj9gDFqd1
         N3MAuwhzsRdVqzZ6rrOh6cS759koUsN6YeIZRLMxGA/UNwI2oRtrmsLAudvydvULrHes
         /48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ya/hl3kSxLpkLPv5c7BeEGlhWkdu/wLTkTM0UC21b64=;
        b=IeOZVvs5UTWbNQlCbZPlqqhirC5jk1P1e+9wjlLiwCDm3TwK7M4gJNED0K3lfhJw3Y
         8qkmedZ8N0/Yl0x4jNifxvGn5k2FVouVi+DOaY2h76LNExjxJP62PrFHeNPFcDPzuI0L
         8eo3enGtgU2RWpscATydNkIxfYctCmlhSsRBsmLkUVGdWGv4FYdsScRFGhJbCLp3xv8Q
         YULUpaagK6oVxTwXVx3RCEZrWdJtlYfO+Z1JMtM8CdActfVsSyhvO69Ea3sPjswD18WH
         P5oVYNk2zCQ9bIDWPzrZITwj4u8ZPATK0Gw+j9k2W5e1n/qwdHYJnPcsi4GRTyCrscfG
         53yw==
X-Gm-Message-State: APjAAAWouhxBRUMMCJsd/nKlKkoB57R7Yq5h7lI0tS798FdDYd3yKk9O
	yj1MtU3etrw1y16tttCuo0CeGDOlPJ+TCIDhYhYIpQ==
X-Google-Smtp-Source: APXvYqzFqH80OPpGVmqK4MrGIOR9FzP/5Z5IS+6ciRSQLycC7zjZETQcpJ2/hgttcT47FsAAzUpRt6/OlgUss4UXiOU=
X-Received: by 2002:aca:620a:: with SMTP id w10mr1526488oib.0.1572304128418;
 Mon, 28 Oct 2019 16:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 28 Oct 2019 16:08:37 -0700
Message-ID: <CAPcyv4gZ=wKzwscu_nch8VUtNTHusKzjmMhYZWo+Se=BPO9q8g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: 3CYOXQJGVELWOAKYBIMRT47FH3V3O6D7
X-Message-ID-Hash: 3CYOXQJGVELWOAKYBIMRT47FH3V3O6D7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3CYOXQJGVELWOAKYBIMRT47FH3V3O6D7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 28, 2019 at 2:48 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> The page size used to map the namespace is arch dependent. For example
> architectures like ppc64 use 16MB page size for direct-mapping. If the namespace
> size is not aligned to the mapping page size, we can observe kernel crash
> during namespace init and destroy.
>
> This is due to kernel doing partial map/unmap of the resource range
>
> BUG: Unable to handle kernel data access at 0xc001000406000000
> Faulting instruction address: 0xc000000000090790
> NIP [c000000000090790] arch_add_memory+0xc0/0x130
> LR [c000000000090744] arch_add_memory+0x74/0x130
> Call Trace:
>  arch_add_memory+0x74/0x130 (unreliable)
>  memremap_pages+0x74c/0xa30
>  devm_memremap_pages+0x3c/0xa0
>  pmem_attach_disk+0x188/0x770
>  nvdimm_bus_probe+0xd8/0x470
>  really_probe+0x148/0x570
>  driver_probe_device+0x19c/0x1d0
>  device_driver_attach+0xcc/0x100
>  bind_store+0x134/0x1c0
>  drv_attr_store+0x44/0x60
>  sysfs_kf_write+0x74/0xc0
>  kernfs_fop_write+0x1b4/0x290
>  __vfs_write+0x3c/0x70
>  vfs_write+0xd0/0x260
>  ksys_write+0xdc/0x130
>  system_call+0x5c/0x68
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/arm64/mm/flush.c     | 11 +++++++++++
>  arch/powerpc/lib/pmem.c   | 21 +++++++++++++++++++--
>  arch/x86/mm/pageattr.c    | 12 ++++++++++++
>  include/linux/libnvdimm.h |  1 +
>  4 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index ac485163a4a7..90c54c600023 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -91,4 +91,15 @@ void arch_invalidate_pmem(void *addr, size_t size)
>         __inval_dcache_area(addr, size);
>  }
>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> +
> +unsigned long arch_validate_namespace_size(unsigned int ndr_mappings, unsigned long size)
> +{
> +       u32 remainder;
> +
> +       div_u64_rem(size, PAGE_SIZE * ndr_mappings, &remainder);
> +       if (remainder)
> +               return PAGE_SIZE * ndr_mappings;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(arch_validate_namespace_size);
>  #endif
> diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
> index 377712e85605..2e661a08dae5 100644
> --- a/arch/powerpc/lib/pmem.c
> +++ b/arch/powerpc/lib/pmem.c
> @@ -17,14 +17,31 @@ void arch_wb_cache_pmem(void *addr, size_t size)
>         unsigned long start = (unsigned long) addr;
>         flush_dcache_range(start, start + size);
>  }
> -EXPORT_SYMBOL(arch_wb_cache_pmem);
> +EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
>
>  void arch_invalidate_pmem(void *addr, size_t size)
>  {
>         unsigned long start = (unsigned long) addr;
>         flush_dcache_range(start, start + size);
>  }
> -EXPORT_SYMBOL(arch_invalidate_pmem);
> +EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> +
> +unsigned long arch_validate_namespace_size(unsigned int ndr_mappings, unsigned long size)
> +{
> +       u32 remainder;
> +       unsigned long linear_map_size;
> +
> +       if (radix_enabled())
> +               linear_map_size = PAGE_SIZE;
> +       else
> +               linear_map_size = (1UL << mmu_psize_defs[mmu_linear_psize].shift);

This seems more a "supported_alignments" problem, and less a namespace
size or PAGE_SIZE problem, because if the starting address is
misaligned this size validation can still succeed when it shouldn't.

One problem is that __size_store() does not validate the size against
the namespace alignment.

However, the next problem is that alignment is a property of the pfn
device, but not the raw namespace. I think this alignment constraint
should be captured by exposing "align" and "supported_alignments" at
the namespace level as the minimum alignment. The pfn level alignment
could then be an additional alignment constraint, but ndctl would
likely set them to the same value.

The "* ndr_mappings" constraint should be left out of the interface,
because that's a side effect of supporting namespace-type-blk aliasing
which no platform seems to do in practice. If for some strange reason
it's need in the future I'd rather expose the "aliasing" property
rather than fold it into the align / supported_aligns interface.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
