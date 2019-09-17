Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041DAB57D6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Sep 2019 23:57:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2EA2021A07A82;
	Tue, 17 Sep 2019 14:57:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=216.228.121.143; helo=hqemgate14.nvidia.com;
 envelope-from=rcampbell@nvidia.com; receiver=linux-nvdimm@lists.01.org 
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BF5B32020F93E
 for <linux-nvdimm@lists.01.org>; Tue, 17 Sep 2019 14:57:07 -0700 (PDT)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d8156dd0001>; Tue, 17 Sep 2019 14:57:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 17 Sep 2019 14:57:47 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 17 Sep 2019 14:57:47 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Sep
 2019 21:57:47 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Tue, 17 Sep 2019 21:57:47 +0000
Subject: Re: [PATCH v6] mm/pgmap: Use correct alignment when looking at first
 pfn from a region
To: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>, <dan.j.williams@intel.com>, 
 <akpm@linux-foundation.org>
References: <20190917153129.12905-1-aneesh.kumar@linux.ibm.com>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <c7a444fd-d000-27f1-1e03-8ca969ee794b@nvidia.com>
Date: Tue, 17 Sep 2019 14:57:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190917153129.12905-1-aneesh.kumar@linux.ibm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1568757469; bh=NRd/KLsUXIk95j9cFf8vqfZYjuyqqW4KmVN38ZaghQ8=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=eXGoqnFpfPiV2hoNjp/Aeyq0v6cu5e26GQ9/Dr/yAljB21hnXxIo3Uf//tJuMLMXy
 7nSqkHx2OeceNbY8cLfb65Qi7QUzbJ3rCevwoPyiyQ4R9xaffwoSvR1VBm1fq5z+a+
 31t9jxYqaG3CaQ5O/NZE0a79ha7H3PWSiKcnF/OKjOCZs0mxDOcDG+FBW4HFLHE3+n
 RBp55VlR5weLuuGfsWgk1n5otZyXOhM/cJG4BETQUj6ANoduZfi2MjkjX9UY2ABSfS
 baw5ye3xWTbJhDb6X/6eFtjwdIJMrX+NKtcUCOyqQEqVOB58D/U5WJEnmir+cfT+9K
 R9ZmBuXUrpMWA==
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
Cc: linux-mm@kvack.org, linux-nvdimm@lists.01.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


On 9/17/19 8:31 AM, Aneesh Kumar K.V wrote:
> vmem_altmap_offset() adjust the section aligned base_pfn offset.
> So we need to make sure we account for the same when computing base_pfn.
> 
> ie, for altmap_valid case, our pfn_first should be:
> 
> pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> * changes from v5
> * update commit subject and use linux-mm for merge
> 
>   mm/memremap.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index ed70c4e8e52a..233908d7df75 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -54,8 +54,16 @@ static void pgmap_array_delete(struct resource *res)
>   
>   static unsigned long pfn_first(struct dev_pagemap *pgmap)
>   {
> -	return PHYS_PFN(pgmap->res.start) +
> -		vmem_altmap_offset(pgmap_altmap(pgmap));
> +	const struct resource *res = &pgmap->res;
> +	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
> +	unsigned long pfn;
> +
> +	if (altmap) {
> +		pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
> +	} else

A nit: you don't need the '{}'s

> +		pfn = PHYS_PFN(res->start);
> +
> +	return pfn;
>   }
>   
>   static unsigned long pfn_end(struct dev_pagemap *pgmap)
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
