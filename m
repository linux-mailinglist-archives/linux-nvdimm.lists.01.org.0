Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2A8AE57E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Sep 2019 10:29:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6127D202BB9AE;
	Tue, 10 Sep 2019 01:29:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=santosh@fossix.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E16C8202BB9A8
 for <linux-nvdimm@lists.01.org>; Tue, 10 Sep 2019 01:29:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 205so11117609pfw.2
 for <linux-nvdimm@lists.01.org>; Tue, 10 Sep 2019 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=mLjEuW2Nfe5M00nuxF1LNdaVqZ9k8/Je2qswevi0EW4=;
 b=bBkOZ4Wuij13PimJIRNVLEV0kdvIAL6TE5nScVPy5nEN62KQN76m6e6E/sa0aeeKM1
 bsjaSFuwP7u/wC1latqV29lp8kZvzxIrxht/E67FDKMT601YGKAxVaJUPhVxwk6l+Rwx
 9O/5VHkgBfE60/iGufwSK3Yn/Ys43L0gqO9ApYRAAXoU63X0sZVpQeBzO7vWAJJEJ1Gv
 IKcl48rez87gbHpcu4dKViF/DmX+0YKWxQtE77Uh5m7vHmkJTFVfQz7XBuf8NMOGXUsC
 sU9Mffj6jSobuBEBUeCIHwx2qMkMmPOCQCRRa4NFA2B23mi/ySqmcxhTZhGzqHRaiztx
 dSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=mLjEuW2Nfe5M00nuxF1LNdaVqZ9k8/Je2qswevi0EW4=;
 b=oxUKgmj3BzpWwZvkDiDB7XBhX2kxvI35LRiKCzy9ZJ7fKH0tqdZem5BHpeTIzjTub6
 Evyd6H5xB38Z5pHJYVmQRjMYxZsYkGZgS8+Jxu/cwhYsghgGE7/bYaWyVUbTEp0xgn91
 RCp/4qAYWGXO1PQmGFbIPN7pSb5ZwlELvAx37z7WaVQe2eJEWnMzaY6EpCxa3Dr0kVwG
 0A143aEhso6cf5SgqxiElZqZS4N8jjC0whFeLjVUuvc7Ka9/7T8g75wdma0pJjTDFs7P
 yq/EHUgKUnOa2eClEqurskEqSe8jHP2mvbt5/lXTIDLmmR5/JP3EP2pHvGbo0t64xVym
 vMUw==
X-Gm-Message-State: APjAAAXzjD75D64mKffs8JQL8ZaqhJX3oRVrINXjXTWDt7Ejfkcqgcol
 Ta02pP5+lRCWvsxn1R9UOp2n/Q==
X-Google-Smtp-Source: APXvYqxKqKTmSLEQ4QjDAM7KhARdv6YijVfDU0UrJB0oi+3fq4WAvje49dU61ihMh20Wm7m4yItS4A==
X-Received: by 2002:a63:5a4d:: with SMTP id k13mr25947291pgm.174.1568104174113; 
 Tue, 10 Sep 2019 01:29:34 -0700 (PDT)
Received: from localhost ([129.41.84.64])
 by smtp.gmail.com with ESMTPSA id d10sm19818230pfh.8.2019.09.10.01.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:29:33 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, dan.j.williams@intel.com,
 mpe@ellerman.id.au, oohall@gmail.com
Subject: Re: [PATCH 1/2] libnvdimm/altmap: Track namespace boundaries in altmap
In-Reply-To: <20190910062826.10041-1-aneesh.kumar@linux.ibm.com>
References: <20190910062826.10041-1-aneesh.kumar@linux.ibm.com>
Date: Tue, 10 Sep 2019 13:59:31 +0530
Message-ID: <87lfuwa710.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> With PFN_MODE_PMEM namespace, the memmap area is allocated from the device
> area. Some architectures map the memmap area with large page size. On
> architectures like ppc64, 16MB page for memap mapping can map 262144 pfns.
> This maps a namespace size of 16G.
>
> When populating memmap region with 16MB page from the device area,
> make sure the allocated space is not used to map resources outside this
> namespace. Such usage of device area will prevent a namespace destroy.
>
> Add resource end pnf in altmap and use that to check if the memmap area
> allocation can map pfn outside the namespace. On ppc64 in such case we fallback
> to allocation from memory.
>
> This fix kernel crash reported below:
>
> [  132.034989] WARNING: CPU: 13 PID: 13719 at mm/memremap.c:133 devm_memremap_pages_release+0x2d8/0x2e0
> [  133.464754] BUG: Unable to handle kernel data access at 0xc00c00010b204000
> [  133.464760] Faulting instruction address: 0xc00000000007580c
> [  133.464766] Oops: Kernel access of bad area, sig: 11 [#1]
> [  133.464771] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
> .....
> [  133.464901] NIP [c00000000007580c] vmemmap_free+0x2ac/0x3d0
> [  133.464906] LR [c0000000000757f8] vmemmap_free+0x298/0x3d0
> [  133.464910] Call Trace:
> [  133.464914] [c000007cbfd0f7b0] [c0000000000757f8] vmemmap_free+0x298/0x3d0 (unreliable)
> [  133.464921] [c000007cbfd0f8d0] [c000000000370a44] section_deactivate+0x1a4/0x240
> [  133.464928] [c000007cbfd0f980] [c000000000386270] __remove_pages+0x3a0/0x590
> [  133.464935] [c000007cbfd0fa50] [c000000000074158] arch_remove_memory+0x88/0x160
> [  133.464942] [c000007cbfd0fae0] [c0000000003be8c0] devm_memremap_pages_release+0x150/0x2e0
> [  133.464949] [c000007cbfd0fb70] [c000000000738ea0] devm_action_release+0x30/0x50
> [  133.464955] [c000007cbfd0fb90] [c00000000073a5a4] release_nodes+0x344/0x400
> [  133.464961] [c000007cbfd0fc40] [c00000000073378c] device_release_driver_internal+0x15c/0x250
> [  133.464968] [c000007cbfd0fc80] [c00000000072fd14] unbind_store+0x104/0x110
> [  133.464973] [c000007cbfd0fcd0] [c00000000072ee24] drv_attr_store+0x44/0x70
> [  133.464981] [c000007cbfd0fcf0] [c0000000004a32bc] sysfs_kf_write+0x6c/0xa0
> [  133.464987] [c000007cbfd0fd10] [c0000000004a1dfc] kernfs_fop_write+0x17c/0x250
> [  133.464993] [c000007cbfd0fd60] [c0000000003c348c] __vfs_write+0x3c/0x70
> [  133.464999] [c000007cbfd0fd80] [c0000000003c75d0] vfs_write+0xd0/0x250
>
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/mm/init_64.c | 17 ++++++++++++++++-
>  drivers/nvdimm/pfn_devs.c |  2 ++
>  include/linux/memremap.h  |  1 +
>  3 files changed, 19 insertions(+), 1 deletion(-)

Tested-by: Santosh Sivaraj <santosh@fossix.org>

>
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index a44f6281ca3a..4e08246acd79 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -172,6 +172,21 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
>  	vmemmap_list = vmem_back;
>  }
>  
> +static bool altmap_cross_boundary(struct vmem_altmap *altmap, unsigned long start,
> +				unsigned long page_size)
> +{
> +	unsigned long nr_pfn = page_size / sizeof(struct page);
> +	unsigned long start_pfn = page_to_pfn((struct page *)start);
> +
> +	if ((start_pfn + nr_pfn) > altmap->end_pfn)
> +		return true;
> +
> +	if (start_pfn < altmap->base_pfn)
> +		return true;
> +
> +	return false;
> +}
> +
>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  		struct vmem_altmap *altmap)
>  {
> @@ -194,7 +209,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  		 * fail due to alignment issues when using 16MB hugepages, so
>  		 * fall back to system memory if the altmap allocation fail.
>  		 */
> -		if (altmap) {
> +		if (altmap && !altmap_cross_boundary(altmap, start, page_size)) {
>  			p = altmap_alloc_block_buf(page_size, altmap);
>  			if (!p)
>  				pr_debug("altmap block allocation failed, falling back to system memory");
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 3e7b11cf1aae..a616d69c8224 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -618,9 +618,11 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
>  	struct nd_namespace_common *ndns = nd_pfn->ndns;
>  	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
>  	resource_size_t base = nsio->res.start + start_pad;
> +	resource_size_t end = nsio->res.end - end_trunc;
>  	struct vmem_altmap __altmap = {
>  		.base_pfn = init_altmap_base(base),
>  		.reserve = init_altmap_reserve(base),
> +		.end_pfn = PHYS_PFN(end),
>  	};
>  
>  	memcpy(res, &nsio->res, sizeof(*res));
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index f8a5b2a19945..c70996fe48c8 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -17,6 +17,7 @@ struct device;
>   */
>  struct vmem_altmap {
>  	const unsigned long base_pfn;
> +	const unsigned long end_pfn;
>  	const unsigned long reserve;
>  	unsigned long free;
>  	unsigned long align;
> -- 
> 2.21.0
>
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
