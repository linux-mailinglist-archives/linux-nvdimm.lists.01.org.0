Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40818573C4
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 23:38:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A1DBB21962301;
	Wed, 26 Jun 2019 14:38:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E1038212A36F6
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 14:38:23 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jun 2019 14:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; d="scan'208";a="360456463"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2019 14:38:23 -0700
Date: Wed, 26 Jun 2019 14:38:23 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 24/25] mm: remove the HMM config option
Message-ID: <20190626213822.GB8399@iweiny-DESK2.sc.intel.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-25-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190626122724.13313-25-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 26, 2019 at 02:27:23PM +0200, Christoph Hellwig wrote:
> All the mm/hmm.c code is better keyed off HMM_MIRROR.  Also let nouveau
> depend on it instead of the mix of a dummy dependency symbol plus the
> actually selected one.  Drop various odd dependencies, as the code is
> pretty portable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems reasonable to me.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/gpu/drm/nouveau/Kconfig |  3 +--
>  include/linux/hmm.h             |  5 +----
>  include/linux/mm_types.h        |  2 +-
>  mm/Kconfig                      | 27 ++++-----------------------
>  mm/Makefile                     |  2 +-
>  mm/hmm.c                        |  2 --
>  6 files changed, 8 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index 6303d203ab1d..66c839d8e9d1 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -84,11 +84,10 @@ config DRM_NOUVEAU_BACKLIGHT
>  
>  config DRM_NOUVEAU_SVM
>  	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
> -	depends on ARCH_HAS_HMM
>  	depends on DEVICE_PRIVATE
>  	depends on DRM_NOUVEAU
> +	depends on HMM_MIRROR
>  	depends on STAGING
> -	select HMM_MIRROR
>  	default n
>  	help
>  	  Say Y here if you want to enable experimental support for
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 3d00e9550e77..b697496e85ba 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -62,7 +62,7 @@
>  #include <linux/kconfig.h>
>  #include <asm/pgtable.h>
>  
> -#if IS_ENABLED(CONFIG_HMM)
> +#ifdef CONFIG_HMM_MIRROR
>  
>  #include <linux/device.h>
>  #include <linux/migrate.h>
> @@ -332,9 +332,6 @@ static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
>  	return hmm_device_entry_from_pfn(range, pfn);
>  }
>  
> -
> -
> -#if IS_ENABLED(CONFIG_HMM_MIRROR)
>  /*
>   * Mirroring: how to synchronize device page table with CPU page table.
>   *
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index f33a1289c101..8d37182f8dbe 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -501,7 +501,7 @@ struct mm_struct {
>  #endif
>  		struct work_struct async_put_work;
>  
> -#if IS_ENABLED(CONFIG_HMM)
> +#ifdef CONFIG_HMM_MIRROR
>  		/* HMM needs to track a few things per mm */
>  		struct hmm *hmm;
>  #endif
> diff --git a/mm/Kconfig b/mm/Kconfig
> index eecf037a54b3..1e426c26b1d6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -669,37 +669,18 @@ config ZONE_DEVICE
>  
>  	  If FS_DAX is enabled, then say Y.
>  
> -config ARCH_HAS_HMM_MIRROR
> -	bool
> -	default y
> -	depends on (X86_64 || PPC64)
> -	depends on MMU && 64BIT
> -
> -config ARCH_HAS_HMM
> -	bool
> -	depends on (X86_64 || PPC64)
> -	depends on ZONE_DEVICE
> -	depends on MMU && 64BIT
> -	depends on MEMORY_HOTPLUG
> -	depends on MEMORY_HOTREMOVE
> -	depends on SPARSEMEM_VMEMMAP
> -	default y
> -
>  config MIGRATE_VMA_HELPER
>  	bool
>  
>  config DEV_PAGEMAP_OPS
>  	bool
>  
> -config HMM
> -	bool
> -	select MMU_NOTIFIER
> -	select MIGRATE_VMA_HELPER
> -
>  config HMM_MIRROR
>  	bool "HMM mirror CPU page table into a device page table"
> -	depends on ARCH_HAS_HMM
> -	select HMM
> +	depends on (X86_64 || PPC64)
> +	depends on MMU && 64BIT
> +	select MMU_NOTIFIER
> +	select MIGRATE_VMA_HELPER
>  	help
>  	  Select HMM_MIRROR if you want to mirror range of the CPU page table of a
>  	  process into a device page table. Here, mirror means "keep synchronized".
> diff --git a/mm/Makefile b/mm/Makefile
> index ac5e5ba78874..91c99040065c 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -102,5 +102,5 @@ obj-$(CONFIG_FRAME_VECTOR) += frame_vector.o
>  obj-$(CONFIG_DEBUG_PAGE_REF) += debug_page_ref.o
>  obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
>  obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
> -obj-$(CONFIG_HMM) += hmm.o
> +obj-$(CONFIG_HMM_MIRROR) += hmm.o
>  obj-$(CONFIG_MEMFD_CREATE) += memfd.o
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 90ca0cdab9db..d62ce64d6bca 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -25,7 +25,6 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/memory_hotplug.h>
>  
> -#if IS_ENABLED(CONFIG_HMM_MIRROR)
>  static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
>  
>  static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
> @@ -1326,4 +1325,3 @@ long hmm_range_dma_unmap(struct hmm_range *range,
>  	return cpages;
>  }
>  EXPORT_SYMBOL(hmm_range_dma_unmap);
> -#endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
> -- 
> 2.20.1
> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
