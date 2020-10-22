Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B1F29650F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Oct 2020 21:10:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7294015CD5719;
	Thu, 22 Oct 2020 12:10:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 65CAA15CD5714
	for <linux-nvdimm@lists.01.org>; Thu, 22 Oct 2020 12:10:30 -0700 (PDT)
IronPort-SDR: HJSphXQAWzmjtp+ept/D7NsL5tzqOjpTx54dD17bO0L/39688piGaHkROvZDueRVYhuyYK9jQs
 7zQ4t7AfNA5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="167676738"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400";
   d="scan'208";a="167676738"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 12:10:30 -0700
IronPort-SDR: 8YIEcJnE5c1CF+tQ5838Cm8J62sVxkalH37hppOxamiSexPixra54hQj2if1EsELx5ZR83TvEE
 tlWDakjrFbNQ==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400";
   d="scan'208";a="534087554"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 12:10:29 -0700
Date: Thu, 22 Oct 2020 12:10:29 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] mm/mremap_pages: Fix static key devmap_managed_key
 updates
Message-ID: <20201022191028.GA534324@iweiny-DESK2.sc.intel.com>
References: <20201022060753.21173-1-aneesh.kumar@linux.ibm.com>
 <20201022154124.GA537138@iweiny-DESK2.sc.intel.com>
 <d7540264-48f1-9fdc-0769-de68fdfc1c7b@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d7540264-48f1-9fdc-0769-de68fdfc1c7b@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: SJQAT7XBVCCHRHHODDF2WTCBL25OMZOX
X-Message-ID-Hash: SJQAT7XBVCCHRHHODDF2WTCBL25OMZOX
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SJQAT7XBVCCHRHHODDF2WTCBL25OMZOX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 22, 2020 at 11:19:43AM -0700, Ralph Campbell wrote:
> 
> On 10/22/20 8:41 AM, Ira Weiny wrote:
> > On Thu, Oct 22, 2020 at 11:37:53AM +0530, Aneesh Kumar K.V wrote:
> > > commit 6f42193fd86e ("memremap: don't use a separate devm action for
> > > devmap_managed_enable_get") changed the static key updates such that we
> > > now call devmap_managed_enable_put() without doing the equivalent
> > > devmap_managed_enable_get().
> > > 
> > > devmap_managed_enable_get() is only called for MEMORY_DEVICE_PRIVATE and
> > > MEMORY_DEVICE_FS_DAX, But memunmap_pages() get called for other pgmap
> > > types too. This results in the below warning when switching between
> > > system-ram and devdax mode for devdax namespace.
> > > 
> > >   jump label: negative count!
> > >   WARNING: CPU: 52 PID: 1335 at kernel/jump_label.c:235 static_key_slow_try_dec+0x88/0xa0
> > >   Modules linked in:
> > >   ....
> > > 
> > >   NIP [c000000000433318] static_key_slow_try_dec+0x88/0xa0
> > >   LR [c000000000433314] static_key_slow_try_dec+0x84/0xa0
> > >   Call Trace:
> > >   [c000000025c1f660] [c000000000433314] static_key_slow_try_dec+0x84/0xa0 (unreliable)
> > >   [c000000025c1f6d0] [c000000000433664] __static_key_slow_dec_cpuslocked+0x34/0xd0
> > >   [c000000025c1f700] [c0000000004337a4] static_key_slow_dec+0x54/0xf0
> > >   [c000000025c1f770] [c00000000059c49c] memunmap_pages+0x36c/0x500
> > >   [c000000025c1f820] [c000000000d91d10] devm_action_release+0x30/0x50
> > >   [c000000025c1f840] [c000000000d92e34] release_nodes+0x2f4/0x3e0
> > >   [c000000025c1f8f0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
> > >   [c000000025c1f930] [c000000000d883a4] bus_remove_device+0x124/0x210
> > >   [c000000025c1f9b0] [c000000000d80ef4] device_del+0x1d4/0x530
> > >   [c000000025c1fa70] [c000000000e341e8] unregister_dev_dax+0x48/0xe0
> > >   [c000000025c1fae0] [c000000000d91d10] devm_action_release+0x30/0x50
> > >   [c000000025c1fb00] [c000000000d92e34] release_nodes+0x2f4/0x3e0
> > >   [c000000025c1fbb0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
> > >   [c000000025c1fbf0] [c000000000d87000] unbind_store+0x130/0x170
> > >   [c000000025c1fc30] [c000000000d862a0] drv_attr_store+0x40/0x60
> > >   [c000000025c1fc50] [c0000000006d316c] sysfs_kf_write+0x6c/0xb0
> > >   [c000000025c1fc90] [c0000000006d2328] kernfs_fop_write+0x118/0x280
> > >   [c000000025c1fce0] [c0000000005a79f8] vfs_write+0xe8/0x2a0
> > >   [c000000025c1fd30] [c0000000005a7d94] ksys_write+0x84/0x140
> > >   [c000000025c1fd80] [c00000000003a430] system_call_exception+0x120/0x270
> > >   [c000000025c1fe20] [c00000000000c540] system_call_common+0xf0/0x27c
> > > 
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > > Cc: linux-nvdimm@lists.01.org
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > ---
> > >   mm/memremap.c | 19 +++++++++++++++----
> > >   1 file changed, 15 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/memremap.c b/mm/memremap.c
> > > index 73a206d0f645..d4402ff3e467 100644
> > > --- a/mm/memremap.c
> > > +++ b/mm/memremap.c
> > > @@ -158,6 +158,16 @@ void memunmap_pages(struct dev_pagemap *pgmap)
> > >   {
> > >   	unsigned long pfn;
> > >   	int i;
> > > +	bool need_devmap_managed = false;
> > > +
> > > +	switch (pgmap->type) {
> > > +	case MEMORY_DEVICE_PRIVATE:
> > > +	case MEMORY_DEVICE_FS_DAX:
> > > +		need_devmap_managed = true;
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > 
> > Is it overkill to avoid duplicating this switch logic in
> > page_is_devmap_managed() by creating another call which can be used here?
> 
> Perhaps. I can imagine a helper defined in include/linux/mm.h which
> page_is_devmap_managed() could also call but that would impact a lot of
> places that include mm.h. Since memremap.c already has to have intimate
> knowledge of the pgmap->type, I think limiting the change to just what
> is needed is better for now. So the patch looks OK to me.
> 
> Looking at this some more, I would suggest changing devmap_managed_enable_get()
> and devmap_managed_enable_put() to do the special case checking instead of
> doing it in memremap_pages() and memunmap_pages().
> Then devmap_managed_enable_get() doesn't need to return an error if
> CONFIG_DEV_PAGEMAP_OPS isn't defined. I have only compile tested the
> following.

This looks cleaner to me.  Aneesh?

FWIW:
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Ira

> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  mm/memremap.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 73a206d0f645..16b2fb482da1 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -41,28 +41,24 @@ EXPORT_SYMBOL_GPL(memremap_compat_align);
>  DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
>  EXPORT_SYMBOL(devmap_managed_key);
> -static void devmap_managed_enable_put(void)
> +static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
>  {
> -	static_branch_dec(&devmap_managed_key);
> +	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
> +	    pgmap->type == MEMORY_DEVICE_FS_DAX)
> +		static_branch_dec(&devmap_managed_key);
>  }
> -static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
> +static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
>  {
> -	if (pgmap->type == MEMORY_DEVICE_PRIVATE &&
> -	    (!pgmap->ops || !pgmap->ops->page_free)) {
> -		WARN(1, "Missing page_free method\n");
> -		return -EINVAL;
> -	}
> -
> -	static_branch_inc(&devmap_managed_key);
> -	return 0;
> +	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
> +	    pgmap->type == MEMORY_DEVICE_FS_DAX)
> +		static_branch_inc(&devmap_managed_key);
>  }
>  #else
> -static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
> +static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
>  {
> -	return -EINVAL;
>  }
> -static void devmap_managed_enable_put(void)
> +static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
>  {
>  }
>  #endif /* CONFIG_DEV_PAGEMAP_OPS */
> @@ -169,7 +165,7 @@ void memunmap_pages(struct dev_pagemap *pgmap)
>  		pageunmap_range(pgmap, i);
>  	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
> -	devmap_managed_enable_put();
> +	devmap_managed_enable_put(pgmap);
>  }
>  EXPORT_SYMBOL_GPL(memunmap_pages);
> @@ -307,7 +303,6 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>  		.pgprot = PAGE_KERNEL,
>  	};
>  	const int nr_range = pgmap->nr_range;
> -	bool need_devmap_managed = true;
>  	int error, i;
>  	if (WARN_ONCE(!nr_range, "nr_range must be specified\n"))
> @@ -323,6 +318,10 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>  			WARN(1, "Missing migrate_to_ram method\n");
>  			return ERR_PTR(-EINVAL);
>  		}
> +		if (!pgmap->ops->page_free) {
> +			WARN(1, "Missing page_free method\n");
> +			return ERR_PTR(-EINVAL);
> +		}
>  		if (!pgmap->owner) {
>  			WARN(1, "Missing owner\n");
>  			return ERR_PTR(-EINVAL);
> @@ -336,11 +335,9 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>  		}
>  		break;
>  	case MEMORY_DEVICE_GENERIC:
> -		need_devmap_managed = false;
>  		break;
>  	case MEMORY_DEVICE_PCI_P2PDMA:
>  		params.pgprot = pgprot_noncached(params.pgprot);
> -		need_devmap_managed = false;
>  		break;
>  	default:
>  		WARN(1, "Invalid pgmap type %d\n", pgmap->type);
> @@ -364,11 +361,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>  		}
>  	}
> -	if (need_devmap_managed) {
> -		error = devmap_managed_enable_get(pgmap);
> -		if (error)
> -			return ERR_PTR(error);
> -	}
> +	devmap_managed_enable_get(pgmap);
>  	/*
>  	 * Clear the pgmap nr_range as it will be incremented for each
> -- 
> 2.20.1
> 
> > >   	dev_pagemap_kill(pgmap);
> > >   	for (i = 0; i < pgmap->nr_range; i++)
> > > @@ -169,7 +179,8 @@ void memunmap_pages(struct dev_pagemap *pgmap)
> > >   		pageunmap_range(pgmap, i);
> > >   	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
> > > -	devmap_managed_enable_put();
> > > +	if (need_devmap_managed)
> > > +		devmap_managed_enable_put();
> > >   }
> > >   EXPORT_SYMBOL_GPL(memunmap_pages);
> > > @@ -307,7 +318,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
> > >   		.pgprot = PAGE_KERNEL,
> > >   	};
> > >   	const int nr_range = pgmap->nr_range;
> > > -	bool need_devmap_managed = true;
> > > +	bool need_devmap_managed = false;
> > 
> > I'm CC'ing Ralph Campbell because I think some of his work has proposed this
> > same change.
> > 
> > Ira
> 
> This part of the patch isn't strictly needed, it just reverses the default value of
> need_devmap_managed.
> 
> > >   	int error, i;
> > >   	if (WARN_ONCE(!nr_range, "nr_range must be specified\n"))
> > > @@ -327,6 +338,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
> > >   			WARN(1, "Missing owner\n");
> > >   			return ERR_PTR(-EINVAL);
> > >   		}
> > > +		need_devmap_managed = true;
> > >   		break;
> > >   	case MEMORY_DEVICE_FS_DAX:
> > >   		if (!IS_ENABLED(CONFIG_ZONE_DEVICE) ||
> > > @@ -334,13 +346,12 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
> > >   			WARN(1, "File system DAX not supported\n");
> > >   			return ERR_PTR(-EINVAL);
> > >   		}
> > > +		need_devmap_managed = true;
> > >   		break;
> > >   	case MEMORY_DEVICE_GENERIC:
> > > -		need_devmap_managed = false;
> > >   		break;
> > >   	case MEMORY_DEVICE_PCI_P2PDMA:
> > >   		params.pgprot = pgprot_noncached(params.pgprot);
> > > -		need_devmap_managed = false;
> > >   		break;
> > >   	default:
> > >   		WARN(1, "Invalid pgmap type %d\n", pgmap->type);
> > > -- 
> > > 2.26.2
> > > 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
