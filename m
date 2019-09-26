Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B15F2BF41B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Sep 2019 15:35:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4FC4821967BC5;
	Thu, 26 Sep 2019 06:37:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C2C9B21967BC5
 for <linux-nvdimm@lists.01.org>; Thu, 26 Sep 2019 06:37:05 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C56A03082131;
 Thu, 26 Sep 2019 13:34:58 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B135AA210;
 Thu, 26 Sep 2019 13:34:58 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 858D34EE50;
 Thu, 26 Sep 2019 13:34:58 +0000 (UTC)
Date: Thu, 26 Sep 2019 09:34:58 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <327305557.3319542.1569504897998.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190926122552.17905-1-aneesh.kumar@linux.ibm.com>
References: <20190830091428.18399-1-david@redhat.com>
 <20190926122552.17905-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 1/2] mm/memunmap: Use the correct start and end pfn when
 removing pages from zone
MIME-Version: 1.0
X-Originating-IP: [10.67.117.36, 10.4.195.2]
Thread-Topic: mm/memunmap: Use the correct start and end pfn when removing
 pages from zone
Thread-Index: Ay8FhhcGaFIgIhiU5abdq26E4sJNGQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 26 Sep 2019 13:34:59 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linux-nvdimm@lists.01.org, akpm@linux-foundation.org,
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


> 
> With altmap, all the resource pfns are not initialized. While initializing
> pfn, altmap reserve space is skipped. Hence when removing pfn from zone skip
> pfns that were never initialized.
> 
> Update memunmap_pages to calculate start and end pfn based on altmap
> values. This fixes a kernel crash that is observed when destroying namespace.
> 
> [   74.745056] BUG: Unable to handle kernel data access at 0xc00c000001400000
> [   74.745256] Faulting instruction address: 0xc0000000000b58b0
> cpu 0x2: Vector: 300 (Data Access) at [c00000026ea93580]
>     pc: c0000000000b58b0: memset+0x68/0x104
>     lr: c0000000003eb008: page_init_poison+0x38/0x50
>     ...
>   current = 0xc000000271c67d80
>   paca    = 0xc00000003fffd680   irqmask: 0x03   irq_happened: 0x01
>     pid   = 3665, comm = ndctl
> [link register   ] c0000000003eb008 page_init_poison+0x38/0x50
> [c00000026ea93830] c0000000004754d4 remove_pfn_range_from_zone+0x64/0x3e0
> [c00000026ea938a0] c0000000004b8a60 memunmap_pages+0x300/0x400
> [c00000026ea93930] c0000000009e32a0 devm_action_release+0x30/0x50
> ...
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/memremap.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 390bb3544589..76b98110031e 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -113,7 +113,8 @@ static void dev_pagemap_cleanup(struct dev_pagemap
> *pgmap)
>  void memunmap_pages(struct dev_pagemap *pgmap)
>  {
>  	struct resource *res = &pgmap->res;
> -	unsigned long pfn = PHYS_PFN(res->start);
> +	unsigned long start_pfn, end_pfn;
> +	unsigned long pfn, nr_pages;
>  	int nid;
>  
>  	dev_pagemap_kill(pgmap);
> @@ -121,14 +122,18 @@ void memunmap_pages(struct dev_pagemap *pgmap)
>  		put_page(pfn_to_page(pfn));
>  	dev_pagemap_cleanup(pgmap);
>  
> +	start_pfn = pfn_first(pgmap);
> +	end_pfn = pfn_end(pgmap);
> +	nr_pages = end_pfn - start_pfn;
> +
>  	/* pages are dead and unused, undo the arch mapping */
> -	nid = page_to_nid(pfn_to_page(pfn));
> +	nid = page_to_nid(pfn_to_page(start_pfn));
>  
>  	mem_hotplug_begin();
> -	remove_pfn_range_from_zone(page_zone(pfn_to_page(pfn)), pfn,
> -				   PHYS_PFN(resource_size(res)));
> +	remove_pfn_range_from_zone(page_zone(pfn_to_page(start_pfn)),
> +				   start_pfn, nr_pages);
>  	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> -		__remove_pages(pfn, PHYS_PFN(resource_size(res)), NULL);
> +		__remove_pages(start_pfn, nr_pages, NULL);
>  	} else {
>  		arch_remove_memory(nid, res->start, resource_size(res),
>  				pgmap_altmap(pgmap));
> --
> 2.21.0

Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

> 
> 
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
