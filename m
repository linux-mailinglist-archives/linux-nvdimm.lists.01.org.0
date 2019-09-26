Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE46BF42D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Sep 2019 15:38:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 993C821967BC5;
	Thu, 26 Sep 2019 06:40:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BD6892010BCA5
 for <linux-nvdimm@lists.01.org>; Thu, 26 Sep 2019 06:40:30 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0613C10DCC82;
 Thu, 26 Sep 2019 13:38:24 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEB4960933;
 Thu, 26 Sep 2019 13:38:23 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id E098C18089C8;
 Thu, 26 Sep 2019 13:38:23 +0000 (UTC)
Date: Thu, 26 Sep 2019 09:38:23 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <193523014.3320073.1569505103872.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190926122552.17905-2-aneesh.kumar@linux.ibm.com>
References: <20190830091428.18399-1-david@redhat.com>
 <20190926122552.17905-1-aneesh.kumar@linux.ibm.com>
 <20190926122552.17905-2-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 2/2] mm/memmap_init: Update variable name in
 memmap_init_zone
MIME-Version: 1.0
X-Originating-IP: [10.67.117.36, 10.4.195.4]
Thread-Topic: mm/memmap_init: Update variable name in memmap_init_zone
Thread-Index: y3EnjbYa8cm00jnkkNb2efXWw9841Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 26 Sep 2019 13:38:24 +0000 (UTC)
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
> The third argument is actually number of pages. Changes the variable name
> from size to nr_pages to indicate this better.
> 
> No functional change in this patch.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/page_alloc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3334a769eb91..df9e09a5359f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5914,10 +5914,10 @@ void __meminit memmap_init_zone(unsigned long size,
> int nid, unsigned long zone,
>  #ifdef CONFIG_ZONE_DEVICE
>  void __ref memmap_init_zone_device(struct zone *zone,
>  				   unsigned long start_pfn,
> -				   unsigned long size,
> +				   unsigned long nr_pages,
>  				   struct dev_pagemap *pgmap)
>  {
> -	unsigned long pfn, end_pfn = start_pfn + size;
> +	unsigned long pfn, end_pfn = start_pfn + nr_pages;
>  	struct pglist_data *pgdat = zone->zone_pgdat;
>  	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
>  	unsigned long zone_idx = zone_idx(zone);
> @@ -5934,7 +5934,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  	 */
>  	if (altmap) {
>  		start_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
> -		size = end_pfn - start_pfn;
> +		nr_pages = end_pfn - start_pfn;
>  	}
>  
>  	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> @@ -5981,7 +5981,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  	}
>  
>  	pr_info("%s initialised %lu pages in %ums\n", __func__,
> -		size, jiffies_to_msecs(jiffies - start));
> +		nr_pages, jiffies_to_msecs(jiffies - start));
>  }
>  
>  #endif
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
