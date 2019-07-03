Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F875EAC5
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 19:49:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69064212ACECB;
	Wed,  3 Jul 2019 10:48:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=216.228.121.64; helo=hqemgate15.nvidia.com;
 envelope-from=rcampbell@nvidia.com; receiver=linux-nvdimm@lists.01.org 
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 34162212AB4F2
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 10:48:58 -0700 (PDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d1cea8d0000>; Wed, 03 Jul 2019 10:49:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 03 Jul 2019 10:48:57 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 03 Jul 2019 10:48:57 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Jul
 2019 17:48:56 +0000
Subject: Re: [PATCH 20/22] mm: move hmm_vma_fault to nouveau
To: Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jason Gunthorpe
 <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
References: <20190701062020.19239-1-hch@lst.de>
 <20190701062020.19239-21-hch@lst.de>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <a3108540-e431-2513-650e-3bb143f7f161@nvidia.com>
Date: Wed, 3 Jul 2019 10:48:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701062020.19239-21-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1562176141; bh=eH+hzh0l+0B3OvYJxCh+IGNb5c8I2ai/DLR8P5b1Gdg=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Ay8VbsRTZTawUVfdzioIYIEAkcetDCOkhbNxdQJcvtz4stk7arryEenoHujt1/2Jo
 9qabL8azIqOiMeLK/MmV2RdioTWJ7NHHpyYSja96yymhsq5pBbZbq97MIq3te+bAon
 bs/Y/N0PPXMcy80SSaxbmJfYk6pMoQA8kkl1Ls1aRu5u632sW+H7HBlI5Pggo5kNhJ
 Z5Ye/IWvj2SfBBlM/ouo9ZRmRqtA5+sXZVvBCZwaDotWg8dOVc5/PjPHQVSEz7m+w2
 xG3ZCO20Q1WNDTk3PwLykbGWuLgysV2ZM43Fuxe3QHUC/X7lOS7GHRSq7jkUakqGEU
 +f5bFGz1+9oxA==
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


On 6/30/19 11:20 PM, Christoph Hellwig wrote:
> hmm_vma_fault is marked as a legacy API to get rid of, but quite suites
> the current nouvea flow.  Move it to the only user in preparation for

I didn't quite parse the phrase "quite suites the current nouvea flow."
s/nouvea/nouveau/

> fixing a locking bug involving caller and callee.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I see where you are going with this and it
looks like straightforward code movement so,

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   drivers/gpu/drm/nouveau/nouveau_svm.c | 54 ++++++++++++++++++++++++++-
>   include/linux/hmm.h                   | 54 ---------------------------
>   2 files changed, 53 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 9d40114d7949..e831f4184a17 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -36,6 +36,13 @@
>   #include <linux/sort.h>
>   #include <linux/hmm.h>
>   
> +/*
> + * When waiting for mmu notifiers we need some kind of time out otherwise we
> + * could potentialy wait for ever, 1000ms ie 1s sounds like a long time to
> + * wait already.
> + */
> +#define NOUVEAU_RANGE_FAULT_TIMEOUT 1000
> +
>   struct nouveau_svm {
>   	struct nouveau_drm *drm;
>   	struct mutex mutex;
> @@ -475,6 +482,51 @@ nouveau_svm_fault_cache(struct nouveau_svm *svm,
>   		fault->inst, fault->addr, fault->access);
>   }
>   
> +static int
> +nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range,
> +		    bool block)
> +{
> +	long ret;
> +
> +	/*
> +	 * With the old API the driver must set each individual entries with
> +	 * the requested flags (valid, write, ...). So here we set the mask to
> +	 * keep intact the entries provided by the driver and zero out the
> +	 * default_flags.
> +	 */
> +	range->default_flags = 0;
> +	range->pfn_flags_mask = -1UL;
> +
> +	ret = hmm_range_register(range, mirror,
> +				 range->start, range->end,
> +				 PAGE_SHIFT);
> +	if (ret)
> +		return (int)ret;
> +
> +	if (!hmm_range_wait_until_valid(range, NOUVEAU_RANGE_FAULT_TIMEOUT)) {
> +		/*
> +		 * The mmap_sem was taken by driver we release it here and
> +		 * returns -EAGAIN which correspond to mmap_sem have been
> +		 * drop in the old API.
> +		 */
> +		up_read(&range->vma->vm_mm->mmap_sem);
> +		return -EAGAIN;
> +	}
> +
> +	ret = hmm_range_fault(range, block);
> +	if (ret <= 0) {
> +		if (ret == -EBUSY || !ret) {
> +			/* Same as above, drop mmap_sem to match old API. */
> +			up_read(&range->vma->vm_mm->mmap_sem);
> +			ret = -EBUSY;
> +		} else if (ret == -EAGAIN)
> +			ret = -EBUSY;
> +		hmm_range_unregister(range);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
>   static int
>   nouveau_svm_fault(struct nvif_notify *notify)
>   {
> @@ -649,7 +701,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
>   		range.values = nouveau_svm_pfn_values;
>   		range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
>   again:
> -		ret = hmm_vma_fault(&svmm->mirror, &range, true);
> +		ret = nouveau_range_fault(&svmm->mirror, &range, true);
>   		if (ret == 0) {
>   			mutex_lock(&svmm->mutex);
>   			if (!hmm_range_unregister(&range)) {
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 4b185d286c3b..3457cf9182e5 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -478,60 +478,6 @@ long hmm_range_dma_unmap(struct hmm_range *range,
>   			 dma_addr_t *daddrs,
>   			 bool dirty);
>   
> -/*
> - * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
> - *
> - * When waiting for mmu notifiers we need some kind of time out otherwise we
> - * could potentialy wait for ever, 1000ms ie 1s sounds like a long time to
> - * wait already.
> - */
> -#define HMM_RANGE_DEFAULT_TIMEOUT 1000
> -
> -/* This is a temporary helper to avoid merge conflict between trees. */
> -static inline int hmm_vma_fault(struct hmm_mirror *mirror,
> -				struct hmm_range *range, bool block)
> -{
> -	long ret;
> -
> -	/*
> -	 * With the old API the driver must set each individual entries with
> -	 * the requested flags (valid, write, ...). So here we set the mask to
> -	 * keep intact the entries provided by the driver and zero out the
> -	 * default_flags.
> -	 */
> -	range->default_flags = 0;
> -	range->pfn_flags_mask = -1UL;
> -
> -	ret = hmm_range_register(range, mirror,
> -				 range->start, range->end,
> -				 PAGE_SHIFT);
> -	if (ret)
> -		return (int)ret;
> -
> -	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
> -		/*
> -		 * The mmap_sem was taken by driver we release it here and
> -		 * returns -EAGAIN which correspond to mmap_sem have been
> -		 * drop in the old API.
> -		 */
> -		up_read(&range->vma->vm_mm->mmap_sem);
> -		return -EAGAIN;
> -	}
> -
> -	ret = hmm_range_fault(range, block);
> -	if (ret <= 0) {
> -		if (ret == -EBUSY || !ret) {
> -			/* Same as above, drop mmap_sem to match old API. */
> -			up_read(&range->vma->vm_mm->mmap_sem);
> -			ret = -EBUSY;
> -		} else if (ret == -EAGAIN)
> -			ret = -EBUSY;
> -		hmm_range_unregister(range);
> -		return ret;
> -	}
> -	return 0;
> -}
> -
>   /* Below are for HMM internal use only! Not to be used by device driver! */
>   static inline void hmm_mm_init(struct mm_struct *mm)
>   {
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
