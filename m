Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4A1321190
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 08:47:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 09C2E100EBBDD;
	Sun, 21 Feb 2021 23:47:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=xiaoguang.wang@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 05D8E100EBBD9
	for <linux-nvdimm@lists.01.org>; Sun, 21 Feb 2021 23:47:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UPD0JAf_1613980020;
Received: from 30.225.32.201(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0UPD0JAf_1613980020)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Feb 2021 15:47:00 +0800
Subject: Re: [PATCH 1/7] fsdax: Output address in dax_iomap_pfn() and rename
 it
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-fsdevel@vger.kernel.org
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-2-ruansy.fnst@cn.fujitsu.com>
From: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <cd067457-5aaf-a2a9-06b0-953f49437500@linux.alibaba.com>
Date: Mon, 22 Feb 2021 15:44:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210207170924.2933035-2-ruansy.fnst@cn.fujitsu.com>
Message-ID-Hash: OYJ3VIMHE4JJNSPIRKDJSYRKXME3FSEM
X-Message-ID-Hash: OYJ3VIMHE4JJNSPIRKDJSYRKXME3FSEM
X-MailFrom: xiaoguang.wang@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OYJ3VIMHE4JJNSPIRKDJSYRKXME3FSEM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

hi,

> Add address output in dax_iomap_pfn() in order to perform a memcpy() in
> CoW case.  Since this function both output address and pfn, rename it to
> dax_iomap_direct_access().
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>   fs/dax.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 5b47834f2e1b..b012b2db7ba2 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -998,8 +998,8 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
>   	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
>   }
>   
> -static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> -			 pfn_t *pfnp)
> +static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
> +		void **kaddr, pfn_t *pfnp)
>   {
>   	const sector_t sector = dax_iomap_sector(iomap, pos);
>   	pgoff_t pgoff;
> @@ -1011,11 +1011,13 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
>   		return rc;
>   	id = dax_read_lock();
>   	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
> -				   NULL, pfnp);
> +				   kaddr, pfnp);
>   	if (length < 0) {
>   		rc = length;
>   		goto out;
>   	}
> +	if (!pfnp)
Should this be "if (!*pfnp)"?

Regards,
Xiaoguang Wang
> +		goto out_check_addr;
>   	rc = -EINVAL;
>   	if (PFN_PHYS(length) < size)
>   		goto out;
> @@ -1025,6 +1027,12 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
>   	if (length > 1 && !pfn_t_devmap(*pfnp))
>   		goto out;
>   	rc = 0;
> +
> +out_check_addr:
> +	if (!kaddr)
> +		goto out;
> +	if (!*kaddr)
> +		rc = -EFAULT;
>   out:
>   	dax_read_unlock(id);
>   	return rc;
> @@ -1348,7 +1356,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>   			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
>   			major = VM_FAULT_MAJOR;
>   		}
> -		error = dax_iomap_pfn(&iomap, pos, PAGE_SIZE, &pfn);
> +		error = dax_iomap_direct_access(&iomap, pos, PAGE_SIZE,
> +						NULL, &pfn);
>   		if (error < 0)
>   			goto error_finish_iomap;
>   
> @@ -1566,7 +1575,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>   
>   	switch (iomap.type) {
>   	case IOMAP_MAPPED:
> -		error = dax_iomap_pfn(&iomap, pos, PMD_SIZE, &pfn);
> +		error = dax_iomap_direct_access(&iomap, pos, PMD_SIZE,
> +						NULL, &pfn);
>   		if (error < 0)
>   			goto finish_iomap;
>   
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
