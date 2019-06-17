Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 478EA490DD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 22:08:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A5CA02129DB8E;
	Mon, 17 Jun 2019 13:08:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=207.54.116.67; helo=ale.deltatee.com;
 envelope-from=logang@deltatee.com; receiver=linux-nvdimm@lists.01.org 
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 26F4321959CB2
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 13:08:18 -0700 (PDT)
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.89)
 (envelope-from <logang@deltatee.com>)
 id 1hcxvM-0004o2-QE; Mon, 17 Jun 2019 14:08:17 -0600
To: Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
References: <20190617122733.22432-1-hch@lst.de>
 <20190617122733.22432-9-hch@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d68c5e4c-b2de-95c3-0b75-1f2391b25a34@deltatee.com>
Date: Mon, 17 Jun 2019 14:08:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617122733.22432-9-hch@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvdimm@lists.01.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-mm@kvack.org, bskeggs@redhat.com,
 jgg@mellanox.com, jglisse@redhat.com, dan.j.williams@intel.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
 GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 08/25] memremap: move dev_pagemap callbacks into a
 separate structure
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



On 2019-06-17 6:27 a.m., Christoph Hellwig wrote:
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index a98126ad9c3a..e083567d26ef 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -100,7 +100,7 @@ static void pci_p2pdma_percpu_cleanup(struct percpu_ref *ref)
>  	struct p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(ref);
>  
>  	wait_for_completion(&p2p_pgmap->ref_done);
> -	percpu_ref_exit(&p2p_pgmap->ref);
> +	percpu_ref_exit(ref);
>  }
>  
>  static void pci_p2pdma_release(void *data)
> @@ -152,6 +152,11 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
>  	return error;
>  }
>  
> +static const struct dev_pagemap_ops pci_p2pdma_pagemap_ops = {
> +	.kill		= pci_p2pdma_percpu_kill,
> +	.cleanup	= pci_p2pdma_percpu_cleanup,
> +};
> +
>  /**
>   * pci_p2pdma_add_resource - add memory for use as p2p memory
>   * @pdev: the device to add the memory to
> @@ -207,8 +212,6 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
>  	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
>  		pci_resource_start(pdev, bar);
> -	pgmap->kill = pci_p2pdma_percpu_kill;
> -	pgmap->cleanup = pci_p2pdma_percpu_cleanup;

I just noticed this is missing a line to set pgmap->ops to
pci_p2pdma_pagemap_ops. I must have gotten confused by the other users
in my original review. Though I'm not sure how this compiles as the new
struct is static and unused. However, it is rendered moot in Patch 16
when this is all removed.

Logan
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
