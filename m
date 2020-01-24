Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B42D14785E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jan 2020 06:57:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B62CE10097DFC;
	Thu, 23 Jan 2020 22:00:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7BEDC10097DE3
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jan 2020 22:00:42 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 77so618203oty.6
        for <linux-nvdimm@lists.01.org>; Thu, 23 Jan 2020 21:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoTxk9bqG1PpdgFpg7GVeHpI9w14fs1olgczjLVo6N8=;
        b=YfwL2Tz5UpDlR4dEbr3CSv8neZxuCjM6heImLL4SduSvZgCwmv3YjlR2NQpJxaXFDe
         q2sjnxV2zDwSmO50fjk8Y/GdqeNOcdtIHe/3WNhymHf1NHmzXPZ/c7W0q4H4cqkO0BJH
         9R78RNlBvwts93mUVLgnlbGId8+YJprpRhZNL4EMgqRPR4xAvSgwLzP8xNacZCURLVAi
         rRWsC/ZZUsxYPwRsB8xQASRTMVh9fhOGtHsnbO1+N/ef3BttOlCcZzbCQerWhARPYCcU
         CSWDmNL9JvCl+m5p5rgc+MBsU+eRyA5gASdWS0s2fGIrSe5eyRXH/ucfHP51nYign5lw
         rc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoTxk9bqG1PpdgFpg7GVeHpI9w14fs1olgczjLVo6N8=;
        b=jEdRi1o0u25tQRLZU033X7+TmOno04gjaWLOTbj9x9e1cvSS/9QBfcZ/n4YXOEqxWc
         vnMVExzcRUDJlZxJ6b29CKdr3tzEGosBA9GDHpSXYI3Y0CxO9uMKgpNylCn5Czyt6Vq3
         waanM5qTGym3VY1/R8rB24A55nxJsqZAR+/A8EnhyLv+SF6zxskk2B0QQkenm7oW915s
         NhmUVG7PPkpBxs79xlc+qJbNjLFv0NJLx/Oz+HKmtlTaCnujVX3gNVu/uH15rWEn335q
         hoU+7txX47TmFebhJY89RzWteOHYz+dwUb0bi9vJ6wHXfFX/sN0XsrkVPpTuseqatuIF
         hzDA==
X-Gm-Message-State: APjAAAXWD4dZp35ep4mKAZriWEmS0PpTigmwWemEQ4NmJtftpn0MsVFE
	r+AwaQHimrDjTpWwwwa3iULn5OYuwbxinbu5CB9doQ==
X-Google-Smtp-Source: APXvYqwcTqbmNU+/yZEycO98WyVQMSRsSO4U5t/sNX+uiZmWTXXop4IuoIJqP6eO1je7y8Q0rJdviV/k5ku/gPX8Yfg=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr1467530oto.207.1579845443232;
 Thu, 23 Jan 2020 21:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com> <20200120140749.69549-2-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200120140749.69549-2-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 23 Jan 2020 21:57:12 -0800
Message-ID: <CAPcyv4jcZhQcKr=0OGWc1aZb0OQ1ws2edd-LZMR-EJ_Z2174Sg@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: OEJET62C3TIE4YEI2CRTPNFIEBEMJAQQ
X-Message-ID-Hash: OEJET62C3TIE4YEI2CRTPNFIEBEMJAQQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OEJET62C3TIE4YEI2CRTPNFIEBEMJAQQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 20, 2020 at 6:08 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> The page size used to map the namespace is arch dependent. For example
> architectures like ppc64 use 16MB page size for direct-mapping. If the namespace
> size is not aligned to the mapping page size, users can observe kernel crash
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
> Kernel should also ensure that namespace size is also mulitple of subsection size.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/arm64/mm/flush.c     | 6 ++++++
>  arch/powerpc/lib/pmem.c   | 9 +++++++++
>  arch/x86/mm/pageattr.c    | 7 +++++++
>  include/linux/libnvdimm.h | 1 +
>  4 files changed, 23 insertions(+)
>
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index ac485163a4a7..95cb5538bc6e 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -91,4 +91,10 @@ void arch_invalidate_pmem(void *addr, size_t size)
>         __inval_dcache_area(addr, size);
>  }
>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> +
> +unsigned long arch_namespace_map_size(void)
> +{
> +       return PAGE_SIZE;
> +}
> +EXPORT_SYMBOL_GPL(arch_namespace_map_size);
>  #endif
> diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
> index 0666a8d29596..63dca24e4a18 100644
> --- a/arch/powerpc/lib/pmem.c
> +++ b/arch/powerpc/lib/pmem.c
> @@ -26,6 +26,15 @@ void arch_invalidate_pmem(void *addr, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
>
> +unsigned long arch_namespace_map_size(void)
> +{
> +       if (radix_enabled())
> +               return PAGE_SIZE;
> +       return (1UL << mmu_psize_defs[mmu_linear_psize].shift);
> +
> +}
> +EXPORT_SYMBOL_GPL(arch_namespace_map_size);
> +
>  /*
>   * CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE symbols
>   */
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index 1b99ad05b117..d78b5082f376 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -310,6 +310,13 @@ void arch_invalidate_pmem(void *addr, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
>
> +unsigned long arch_namespace_map_size(void)
> +{
> +       return PAGE_SIZE;
> +}
> +EXPORT_SYMBOL_GPL(arch_namespace_map_size);
> +
> +
>  static void __cpa_flush_all(void *arg)
>  {
>         unsigned long cache = (unsigned long)arg;
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 9df091bd30ba..a3476dbd2656 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -284,4 +284,5 @@ static inline void arch_invalidate_pmem(void *addr, size_t size)
>  }
>  #endif
>
> +unsigned long arch_namespace_map_size(void);

This property is more generic than the nvdimm namespace mapping size,
it's more the fundamental remap granularity that the architecture
supports. So I would expect this to be defined in core header files.
Something like:

diff --git a/include/linux/io.h b/include/linux/io.h
index a59834bc0a11..58b3b2091dbb 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -155,6 +155,13 @@ enum {
 void *memremap(resource_size_t offset, size_t size, unsigned long flags);
 void memunmap(void *addr);

+#ifndef memremap_min_align
+static inline unsigned int memremap_min_align(void)
+{
+       return PAGE_SIZE;
+}
+#endif
+
 /*
  * On x86 PAT systems we have memory tracking that keeps track of
  * the allowed mappings on memory ranges. This tracking works for

...and then have a definition is asm/io.h like this:

unsigned int memremap_min_align(void);
#define memremap_min_align memremap_min_align

That way only architectures that want to opt out of the default need
to define something in their local header.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
