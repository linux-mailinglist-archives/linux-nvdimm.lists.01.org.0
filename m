Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A16B2D3A35
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 06:19:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D078B100EB83C;
	Tue,  8 Dec 2020 21:18:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.143; helo=hqnvemgate24.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com [216.228.121.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 60582100EC1DD
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 21:18:58 -0800 (PST)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5fd05e410001>; Tue, 08 Dec 2020 21:18:57 -0800
Received: from [10.2.60.96] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 05:18:57 +0000
Subject: Re: [PATCH RFC 8/9] RDMA/umem: batch page unpin in __ib_mem_release()
To: Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-10-joao.m.martins@oracle.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <68d7bedf-99b4-6c7f-02f6-3188474b366c@nvidia.com>
Date: Tue, 8 Dec 2020 21:18:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201208172901.17384-10-joao.m.martins@oracle.com>
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1607491138; bh=QIEJYHHX8wLddTOoX4T648TxvHYICMB5vZPMjxdEFik=;
	h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
	 MIME-Version:In-Reply-To:Content-Type:Content-Language:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	b=UBqXVXVQ0ZPusuzw11Uvb2EZzo2pN3yvaTBSlnWfWprRioWNPt/B94GirFW8XZiK8
	 d8B9eSyKhv/EArJp+8sUgY0J7cGEjgvWapMDH7NeAI7yMkfqWgDT0gtnY857f8y/kh
	 0XSJwhkBaLT9GjGo5wgMOpNyY2/fbxdANAD6CNwBbd9vUIX/2t9DwcYGwefGda4tyj
	 bb6XkbhoMP3VNd7R4jeXtWFEiRbVrVopzCvfRxcO5/5thdKN1hqDr8dsr26/odhEQm
	 CgVapWU348QcTeWzDeE+0D3MvKPBsvqayCi3kKGYMgyDIGp7T7gO8DeDajGWPYMR1y
	 AJzqQ5xxBVcdA==
Message-ID-Hash: SZSOCYGGPOHQKJ4AUCL4VVUXJU2PYBTT
X-Message-ID-Hash: SZSOCYGGPOHQKJ4AUCL4VVUXJU2PYBTT
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>,
	"Jason Gunthorpe  <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song" <songmuchun@bytedance.com>,
	Mike Kravetz <mike.kravetz@oracle.com>, Andrew@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SZSOCYGGPOHQKJ4AUCL4VVUXJU2PYBTT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/8/20 9:29 AM, Joao Martins wrote:
> Take advantage of the newly added unpin_user_pages() batched
> refcount update, by calculating a page array from an SGL
> (same size as the one used in ib_mem_get()) and call
> unpin_user_pages() with that.
> 
> unpin_user_pages() will check on consecutive pages that belong
> to the same compound page set and batch the refcount update in
> a single write.
> 
> Running a test program which calls mr reg/unreg on a 1G in size
> and measures cost of both operations together (in a guest using rxe)
> with device-dax and hugetlbfs:
> 
> Before:
> 159 rounds in 5.027 sec: 31617.923 usec / round (device-dax)
> 466 rounds in 5.009 sec: 10748.456 usec / round (hugetlbfs)
> 
> After:
>   305 rounds in 5.010 sec: 16426.047 usec / round (device-dax)
> 1073 rounds in 5.004 sec: 4663.622 usec / round (hugetlbfs)
> 
> We also see similar improvements on a setup with pmem and RDMA hardware.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   drivers/infiniband/core/umem.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index e9fecbdf391b..493cfdcf7381 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -44,20 +44,40 @@
>   
>   #include "uverbs.h"
>   
> +#define PAGES_PER_LIST (PAGE_SIZE / sizeof(struct page *))

I was going to maybe suggest that this item, and the "bool make_dirty" cleanup,
be a separate patch, because they are just cleanups. But the memory allocation issue
below might make that whole (minor) point obsolete.

> +
>   static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
>   {
> +	bool make_dirty = umem->writable && dirty;
> +	struct page **page_list = NULL;
>   	struct sg_page_iter sg_iter;
> +	unsigned long nr = 0;
>   	struct page *page;
>   
> +	page_list = (struct page **) __get_free_page(GFP_KERNEL);

Yeah, allocating memory in a free/release path is not good. btw, for future use,
I see that kmalloc() is generally recommended these days (that's a change), when
you want a pointer to storage, as opposed to wanting struct pages:

https://lore.kernel.org/lkml/CA+55aFwyxJ+TOpaJZnC5MPJ-25xbLAEu8iJP8zTYhmA3LXFF8Q@mail.gmail.com/

> +
>   	if (umem->nmap > 0)
>   		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
>   				DMA_BIDIRECTIONAL);
>   
>   	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
>   		page = sg_page_iter_page(&sg_iter);
> -		unpin_user_pages_dirty_lock(&page, 1, umem->writable && dirty);
> +		if (page_list)
> +			page_list[nr++] = page;
> +
> +		if (!page_list) {
> +			unpin_user_pages_dirty_lock(&page, 1, make_dirty);
> +		} else if (nr == PAGES_PER_LIST) {
> +			unpin_user_pages_dirty_lock(page_list, nr, make_dirty);
> +			nr = 0;
> +		}
>   	}
>   
> +	if (nr)
> +		unpin_user_pages_dirty_lock(page_list, nr, make_dirty);
> +
> +	if (page_list)
> +		free_page((unsigned long) page_list);
>   	sg_free_table(&umem->sg_head);
>   }
>   
> @@ -212,8 +232,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>   		cond_resched();
>   		ret = pin_user_pages_fast(cur_base,
>   					  min_t(unsigned long, npages,
> -						PAGE_SIZE /
> -						sizeof(struct page *)),
> +						PAGES_PER_LIST),
>   					  gup_flags | FOLL_LONGTERM, page_list);
>   		if (ret < 0)
>   			goto umem_release;
> 

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
