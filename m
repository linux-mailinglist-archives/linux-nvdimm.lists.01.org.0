Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0F573B2
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 23:36:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1CDBE21962301;
	Wed, 26 Jun 2019 14:36:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5C1E421962301
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 14:36:21 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jun 2019 14:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; d="scan'208";a="360890792"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2019 14:36:21 -0700
Date: Wed, 26 Jun 2019 14:36:21 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 23/25] mm: sort out the DEVICE_PRIVATE Kconfig mess
Message-ID: <20190626213620.GA8399@iweiny-DESK2.sc.intel.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-24-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190626122724.13313-24-hch@lst.de>
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
Cc: linux-nvdimm@lists.01.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 26, 2019 at 02:27:22PM +0200, Christoph Hellwig wrote:
> The ZONE_DEVICE support doesn't depend on anything HMM related, just on
> various bits of arch support as indicated by the architecture.  Also
> don't select the option from nouveau as it isn't present in many setups,
> and depend on it instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/gpu/drm/nouveau/Kconfig | 2 +-
>  mm/Kconfig                      | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index dba2613f7180..6303d203ab1d 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -85,10 +85,10 @@ config DRM_NOUVEAU_BACKLIGHT
>  config DRM_NOUVEAU_SVM
>  	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
>  	depends on ARCH_HAS_HMM
> +	depends on DEVICE_PRIVATE
>  	depends on DRM_NOUVEAU
>  	depends on STAGING
>  	select HMM_MIRROR
> -	select DEVICE_PRIVATE
>  	default n
>  	help
>  	  Say Y here if you want to enable experimental support for
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 6f35b85b3052..eecf037a54b3 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -677,13 +677,13 @@ config ARCH_HAS_HMM_MIRROR
>  
>  config ARCH_HAS_HMM
>  	bool
> -	default y
>  	depends on (X86_64 || PPC64)
>  	depends on ZONE_DEVICE
>  	depends on MMU && 64BIT
>  	depends on MEMORY_HOTPLUG
>  	depends on MEMORY_HOTREMOVE
>  	depends on SPARSEMEM_VMEMMAP
> +	default y
>  
>  config MIGRATE_VMA_HELPER
>  	bool
> @@ -709,8 +709,7 @@ config HMM_MIRROR
>  
>  config DEVICE_PRIVATE
>  	bool "Unaddressable device memory (GPU memory, ...)"
> -	depends on ARCH_HAS_HMM
> -	select HMM
> +	depends on ZONE_DEVICE
>  	select DEV_PAGEMAP_OPS
>  
>  	help
> -- 
> 2.20.1
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
