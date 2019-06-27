Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCA558A32
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 20:50:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 41023212AB008;
	Thu, 27 Jun 2019 11:49:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=207.54.116.67; helo=ale.deltatee.com;
 envelope-from=logang@deltatee.com; receiver=linux-nvdimm@lists.01.org 
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 43406212966ED
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 11:49:57 -0700 (PDT)
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180]
 helo=[192.168.6.132])
 by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <logang@deltatee.com>)
 id 1hgZSz-0004rJ-D3; Thu, 27 Jun 2019 12:49:54 -0600
To: Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-18-hch@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <580609fd-5ef2-bae4-e8f8-adc1eb0314a1@deltatee.com>
Date: Thu, 27 Jun 2019 12:49:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190626122724.13313-18-hch@lst.de>
Content-Language: en-US
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: nouveau@lists.freedesktop.org, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvdimm@lists.01.org, bskeggs@redhat.com,
 jgg@mellanox.com, jglisse@redhat.com, dan.j.williams@intel.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
 GREYLIST_ISWHITE,MYRULES_FREE autolearn=ham autolearn_force=no
 version=3.4.2
Subject: Re: [PATCH 17/25] PCI/P2PDMA: use the dev_pagemap internal refcount
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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
 linux-mm@kvack.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>



On 2019-06-26 6:27 a.m., Christoph Hellwig wrote:
> The functionality is identical to the one currently open coded in
> p2pdma.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Also, for the P2PDMA changes in this series:

Tested-by: Logan Gunthorpe <logang@deltatee.com>

I've ran this series through my simple P2PDMA tests.

Logan

> ---
>  drivers/pci/p2pdma.c | 57 ++++----------------------------------------
>  1 file changed, 4 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index ebd8ce3bba2e..608f84df604a 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -24,12 +24,6 @@ struct pci_p2pdma {
>  	bool p2pmem_published;
>  };
>  
> -struct p2pdma_pagemap {
> -	struct dev_pagemap pgmap;
> -	struct percpu_ref ref;
> -	struct completion ref_done;
> -};
> -
>  static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
> @@ -78,32 +72,6 @@ static const struct attribute_group p2pmem_group = {
>  	.name = "p2pmem",
>  };
>  
> -static struct p2pdma_pagemap *to_p2p_pgmap(struct percpu_ref *ref)
> -{
> -	return container_of(ref, struct p2pdma_pagemap, ref);
> -}
> -
> -static void pci_p2pdma_percpu_release(struct percpu_ref *ref)
> -{
> -	struct p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(ref);
> -
> -	complete(&p2p_pgmap->ref_done);
> -}
> -
> -static void pci_p2pdma_percpu_kill(struct dev_pagemap *pgmap)
> -{
> -	percpu_ref_kill(pgmap->ref);
> -}
> -
> -static void pci_p2pdma_percpu_cleanup(struct dev_pagemap *pgmap)
> -{
> -	struct p2pdma_pagemap *p2p_pgmap =
> -		container_of(pgmap, struct p2pdma_pagemap, pgmap);
> -
> -	wait_for_completion(&p2p_pgmap->ref_done);
> -	percpu_ref_exit(&p2p_pgmap->ref);
> -}
> -
>  static void pci_p2pdma_release(void *data)
>  {
>  	struct pci_dev *pdev = data;
> @@ -153,11 +121,6 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
>  	return error;
>  }
>  
> -static const struct dev_pagemap_ops pci_p2pdma_pagemap_ops = {
> -	.kill		= pci_p2pdma_percpu_kill,
> -	.cleanup	= pci_p2pdma_percpu_cleanup,
> -};
> -
>  /**
>   * pci_p2pdma_add_resource - add memory for use as p2p memory
>   * @pdev: the device to add the memory to
> @@ -171,7 +134,6 @@ static const struct dev_pagemap_ops pci_p2pdma_pagemap_ops = {
>  int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  			    u64 offset)
>  {
> -	struct p2pdma_pagemap *p2p_pgmap;
>  	struct dev_pagemap *pgmap;
>  	void *addr;
>  	int error;
> @@ -194,26 +156,15 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  			return error;
>  	}
>  
> -	p2p_pgmap = devm_kzalloc(&pdev->dev, sizeof(*p2p_pgmap), GFP_KERNEL);
> -	if (!p2p_pgmap)
> +	pgmap = devm_kzalloc(&pdev->dev, sizeof(*pgmap), GFP_KERNEL);
> +	if (!pgmap)
>  		return -ENOMEM;
> -
> -	init_completion(&p2p_pgmap->ref_done);
> -	error = percpu_ref_init(&p2p_pgmap->ref,
> -			pci_p2pdma_percpu_release, 0, GFP_KERNEL);
> -	if (error)
> -		goto pgmap_free;
> -
> -	pgmap = &p2p_pgmap->pgmap;
> -
>  	pgmap->res.start = pci_resource_start(pdev, bar) + offset;
>  	pgmap->res.end = pgmap->res.start + size - 1;
>  	pgmap->res.flags = pci_resource_flags(pdev, bar);
> -	pgmap->ref = &p2p_pgmap->ref;
>  	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
>  	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
>  		pci_resource_start(pdev, bar);
> -	pgmap->ops = &pci_p2pdma_pagemap_ops;
>  
>  	addr = devm_memremap_pages(&pdev->dev, pgmap);
>  	if (IS_ERR(addr)) {
> @@ -224,7 +175,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  	error = gen_pool_add_owner(pdev->p2pdma->pool, (unsigned long)addr,
>  			pci_bus_address(pdev, bar) + offset,
>  			resource_size(&pgmap->res), dev_to_node(&pdev->dev),
> -			&p2p_pgmap->ref);
> +			pgmap->ref);
>  	if (error)
>  		goto pages_free;
>  
> @@ -236,7 +187,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  pages_free:
>  	devm_memunmap_pages(&pdev->dev, pgmap);
>  pgmap_free:
> -	devm_kfree(&pdev->dev, p2p_pgmap);
> +	devm_kfree(&pdev->dev, pgmap);
>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
