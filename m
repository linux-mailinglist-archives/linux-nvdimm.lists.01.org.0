Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76032573D9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 23:47:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E175121962301;
	Wed, 26 Jun 2019 14:47:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AD990212AAB85
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 14:47:51 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jun 2019 14:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; d="scan'208";a="162409132"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga008.fm.intel.com with ESMTP; 26 Jun 2019 14:47:50 -0700
Date: Wed, 26 Jun 2019 14:47:50 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 15/25] memremap: provide an optional internal refcount in
 struct dev_pagemap
Message-ID: <20190626214750.GC8399@iweiny-DESK2.sc.intel.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-16-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190626122724.13313-16-hch@lst.de>
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

On Wed, Jun 26, 2019 at 02:27:14PM +0200, Christoph Hellwig wrote:
> Provide an internal refcounting logic if no ->ref field is provided
> in the pagemap passed into devm_memremap_pages so that callers don't
> have to reinvent it poorly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/memremap.h          |  4 ++
>  kernel/memremap.c                 | 64 ++++++++++++++++++++++++-------
>  tools/testing/nvdimm/test/iomap.c | 58 ++++++++++++++++++++++------
>  3 files changed, 101 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index e25685b878e9..f8a5b2a19945 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -95,6 +95,8 @@ struct dev_pagemap_ops {
>   * @altmap: pre-allocated/reserved memory for vmemmap allocations
>   * @res: physical address range covered by @ref
>   * @ref: reference count that pins the devm_memremap_pages() mapping
> + * @internal_ref: internal reference if @ref is not provided by the caller
> + * @done: completion for @internal_ref
>   * @dev: host device of the mapping for debug
>   * @data: private data pointer for page_free()
>   * @type: memory type: see MEMORY_* in memory_hotplug.h
> @@ -105,6 +107,8 @@ struct dev_pagemap {
>  	struct vmem_altmap altmap;
>  	struct resource res;
>  	struct percpu_ref *ref;
> +	struct percpu_ref internal_ref;
> +	struct completion done;
>  	struct device *dev;
>  	enum memory_type type;
>  	unsigned int flags;
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index eee490e7d7e1..bea6f887adad 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -29,7 +29,7 @@ static void devmap_managed_enable_put(void *data)
>  
>  static int devmap_managed_enable_get(struct device *dev, struct dev_pagemap *pgmap)
>  {
> -	if (!pgmap->ops->page_free) {
> +	if (!pgmap->ops || !pgmap->ops->page_free) {
>  		WARN(1, "Missing page_free method\n");
>  		return -EINVAL;
>  	}
> @@ -75,6 +75,24 @@ static unsigned long pfn_next(unsigned long pfn)
>  #define for_each_device_pfn(pfn, map) \
>  	for (pfn = pfn_first(map); pfn < pfn_end(map); pfn = pfn_next(pfn))
>  
> +static void dev_pagemap_kill(struct dev_pagemap *pgmap)
> +{
> +	if (pgmap->ops && pgmap->ops->kill)
> +		pgmap->ops->kill(pgmap);
> +	else
> +		percpu_ref_kill(pgmap->ref);
> +}
> +
> +static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
> +{
> +	if (pgmap->ops && pgmap->ops->cleanup) {
> +		pgmap->ops->cleanup(pgmap);
> +	} else {
> +		wait_for_completion(&pgmap->done);
> +		percpu_ref_exit(pgmap->ref);
> +	}
> +}
> +
>  static void devm_memremap_pages_release(void *data)
>  {
>  	struct dev_pagemap *pgmap = data;
> @@ -84,10 +102,10 @@ static void devm_memremap_pages_release(void *data)
>  	unsigned long pfn;
>  	int nid;
>  
> -	pgmap->ops->kill(pgmap);
> +	dev_pagemap_kill(pgmap);
>  	for_each_device_pfn(pfn, pgmap)
>  		put_page(pfn_to_page(pfn));
> -	pgmap->ops->cleanup(pgmap);
> +	dev_pagemap_cleanup(pgmap);
>  
>  	/* pages are dead and unused, undo the arch mapping */
>  	align_start = res->start & ~(SECTION_SIZE - 1);
> @@ -114,20 +132,29 @@ static void devm_memremap_pages_release(void *data)
>  		      "%s: failed to free all reserved pages\n", __func__);
>  }
>  
> +static void dev_pagemap_percpu_release(struct percpu_ref *ref)
> +{
> +	struct dev_pagemap *pgmap =
> +		container_of(ref, struct dev_pagemap, internal_ref);
> +
> +	complete(&pgmap->done);
> +}
> +
>  /**
>   * devm_memremap_pages - remap and provide memmap backing for the given resource
>   * @dev: hosting device for @res
>   * @pgmap: pointer to a struct dev_pagemap
>   *
>   * Notes:
> - * 1/ At a minimum the res, ref and type and ops members of @pgmap must be
> - *    initialized by the caller before passing it to this function
> + * 1/ At a minimum the res and type members of @pgmap must be initialized
> + *    by the caller before passing it to this function
>   *
>   * 2/ The altmap field may optionally be initialized, in which case
>   *    PGMAP_ALTMAP_VALID must be set in pgmap->flags.
>   *
> - * 3/ pgmap->ref must be 'live' on entry and will be killed and reaped
> - *    at devm_memremap_pages_release() time, or if this routine fails.
> + * 3/ The ref field may optionally be provided, in which pgmap->ref must be
> + *    'live' on entry and will be killed and reaped at
> + *    devm_memremap_pages_release() time, or if this routine fails.
>   *
>   * 4/ res is expected to be a host memory range that could feasibly be
>   *    treated as a "System RAM" range, i.e. not a device mmio range, but
> @@ -175,10 +202,21 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
>  		break;
>  	}
>  
> -	if (!pgmap->ref || !pgmap->ops || !pgmap->ops->kill ||
> -	    !pgmap->ops->cleanup) {
> -		WARN(1, "Missing reference count teardown definition\n");
> -		return ERR_PTR(-EINVAL);
> +	if (!pgmap->ref) {
> +		if (pgmap->ops && (pgmap->ops->kill || pgmap->ops->cleanup))
> +			return ERR_PTR(-EINVAL);
> +
> +		init_completion(&pgmap->done);
> +		error = percpu_ref_init(&pgmap->internal_ref,
> +				dev_pagemap_percpu_release, 0, GFP_KERNEL);
> +		if (error)
> +			return ERR_PTR(error);
> +		pgmap->ref = &pgmap->internal_ref;
> +	} else {
> +		if (!pgmap->ops || !pgmap->ops->kill || !pgmap->ops->cleanup) {
> +			WARN(1, "Missing reference count teardown definition\n");
> +			return ERR_PTR(-EINVAL);
> +		}

After this series are there any users who continue to supply their own
reference object and these callbacks?

As it stands:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>  	}
>  
>  	if (need_devmap_managed) {
> @@ -296,8 +334,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
>   err_pfn_remap:
>  	pgmap_array_delete(res);
>   err_array:
> -	pgmap->ops->kill(pgmap);
> -	pgmap->ops->cleanup(pgmap);
> +	dev_pagemap_kill(pgmap);
> +	dev_pagemap_cleanup(pgmap);
>  	return ERR_PTR(error);
>  }
>  EXPORT_SYMBOL_GPL(devm_memremap_pages);
> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
> index 82f901569e06..cd040b5abffe 100644
> --- a/tools/testing/nvdimm/test/iomap.c
> +++ b/tools/testing/nvdimm/test/iomap.c
> @@ -100,26 +100,60 @@ static void nfit_test_kill(void *_pgmap)
>  {
>  	struct dev_pagemap *pgmap = _pgmap;
>  
> -	WARN_ON(!pgmap || !pgmap->ref || !pgmap->ops || !pgmap->ops->kill ||
> -		!pgmap->ops->cleanup);
> -	pgmap->ops->kill(pgmap);
> -	pgmap->ops->cleanup(pgmap);
> +	WARN_ON(!pgmap || !pgmap->ref);
> +
> +	if (pgmap->ops && pgmap->ops->kill)
> +		pgmap->ops->kill(pgmap);
> +	else
> +		percpu_ref_kill(pgmap->ref);
> +
> +	if (pgmap->ops && pgmap->ops->cleanup) {
> +		pgmap->ops->cleanup(pgmap);
> +	} else {
> +		wait_for_completion(&pgmap->done);
> +		percpu_ref_exit(pgmap->ref);
> +	}
> +}
> +
> +static void dev_pagemap_percpu_release(struct percpu_ref *ref)
> +{
> +	struct dev_pagemap *pgmap =
> +		container_of(ref, struct dev_pagemap, internal_ref);
> +
> +	complete(&pgmap->done);
>  }
>  
>  void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
>  {
> +	int error;
>  	resource_size_t offset = pgmap->res.start;
>  	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
>  
> -	if (nfit_res) {
> -		int rc;
> -
> -		rc = devm_add_action_or_reset(dev, nfit_test_kill, pgmap);
> -		if (rc)
> -			return ERR_PTR(rc);
> -		return nfit_res->buf + offset - nfit_res->res.start;
> +	if (!nfit_res)
> +		return devm_memremap_pages(dev, pgmap);
> +
> +	pgmap->dev = dev;
> +	if (!pgmap->ref) {
> +		if (pgmap->ops && (pgmap->ops->kill || pgmap->ops->cleanup))
> +			return ERR_PTR(-EINVAL);
> +
> +		init_completion(&pgmap->done);
> +		error = percpu_ref_init(&pgmap->internal_ref,
> +				dev_pagemap_percpu_release, 0, GFP_KERNEL);
> +		if (error)
> +			return ERR_PTR(error);
> +		pgmap->ref = &pgmap->internal_ref;
> +	} else {
> +		if (!pgmap->ops || !pgmap->ops->kill || !pgmap->ops->cleanup) {
> +			WARN(1, "Missing reference count teardown definition\n");
> +			return ERR_PTR(-EINVAL);
> +		}
>  	}
> -	return devm_memremap_pages(dev, pgmap);
> +
> +	error = devm_add_action_or_reset(dev, nfit_test_kill, pgmap);
> +	if (error)
> +		return ERR_PTR(error);
> +	return nfit_res->buf + offset - nfit_res->res.start;
>  }
>  EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
>  
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
