Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B34941A6B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 04:33:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 71CB721962301;
	Tue, 11 Jun 2019 19:33:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=kirill@shutemov.name; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D37E321290D20
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 19:33:38 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w13so23198935eds.4
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MAd9VAiJz95Llz8BbTxV4sHt55dwKHdH+hoX3bTDkOM=;
 b=aGF0m5qDaDj87qvNo5iPDYjLHNHkvWmDaEpCNpwbFSa4HzQDh4bwYk/ghq2akBh7gf
 mvYvGFQKDZIuN9zsuuccUcDr6CwuBRbat9mNrwjJNqAHXk5LoA66Npn1J32iT2rcDfpw
 f+i5zMYkljrX+ld9mYuVrJTtg30/15VL5s9Sh6uBssTfZ57JtMnhkfDzQKGLfLD7rQjV
 yZWlPSz0HiFXV9SmWRGoEhN14rWIRN5p0NtTtgElcRvgA+7FrrckEiVoMyoE3ze2sQbQ
 dYnPsIewsFSO+WvWMcODJaKcHE2ujN58RlX4DWlbu9H2vKMtJdLSA9GH2kSSCsbTERm9
 IihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MAd9VAiJz95Llz8BbTxV4sHt55dwKHdH+hoX3bTDkOM=;
 b=rhcvQvR6LgRyMfWQeIdzXo6n1LYLXbmTJrW7uJKD4nu2ctRVyE5EmkXkvwfgIy8d2X
 y3njzS2LHRb9j+zo1jVNXkHvnIxj03BE/tfPmGVj2Y4JpahN0x+sYPOP+e2gqREKXoWH
 QsVBY+rFyTmf3D9l3SNucObPR/Rp+P2dOF681aMvNEFhtgBY3EXgl1IMOqDyy4s88Oxx
 dGWohvNQ8V+bOuIVuYFS+3CbfiRhiNlYqCzzt3dYmqoMLKeEI/Wq1lC7u5dsaZuLzTzO
 Yd2liQrT+6UenbI+iybLUzB5qApBzcUluWGQI2gtq/SwU/dJRmBsHb2AS3m+8eKFROt+
 g5bw==
X-Gm-Message-State: APjAAAWcOjmEoeCNzRe91Fi0l3cbqrxND76tUJcFqNt1mEQ3dL51eeJq
 KNjxSVD0Zbvm9KP7JG5O3hmPow==
X-Google-Smtp-Source: APXvYqyhtZl/3SjW+LtLwuO7S7BeZoKmz1DOjU/1ktZsjjlPzNNDP6SQvVctNXiGwdDMlV9oY2pG6A==
X-Received: by 2002:a17:906:53c1:: with SMTP id
 p1mr5138534ejo.241.1560306817323; 
 Tue, 11 Jun 2019 19:33:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id i31sm4161836edd.90.2019.06.11.19.33.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 19:33:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id C01BA10081B; Wed, 12 Jun 2019 05:33:36 +0300 (+03)
Date: Wed, 12 Jun 2019 05:33:36 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Larry Bassel <larry.bassel@oracle.com>
Subject: Re: [RFC PATCH v2 2/2] Implement sharing/unsharing of PMDs for FS/DAX
Message-ID: <20190612023336.hbqs2ag4bv2qv2eh@box>
References: <1559937063-8323-1-git-send-email-larry.bassel@oracle.com>
 <1559937063-8323-3-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1559937063-8323-3-git-send-email-larry.bassel@oracle.com>
User-Agent: NeoMutt/20180716
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
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 07, 2019 at 12:51:03PM -0700, Larry Bassel wrote:
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3a54c9d..1c1ed4e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4653,9 +4653,9 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  }
>  
>  #ifdef CONFIG_ARCH_HAS_HUGE_PMD_SHARE
> -static unsigned long page_table_shareable(struct vm_area_struct *svma,
> -				struct vm_area_struct *vma,
> -				unsigned long addr, pgoff_t idx)
> +unsigned long page_table_shareable(struct vm_area_struct *svma,
> +				   struct vm_area_struct *vma,
> +				   unsigned long addr, pgoff_t idx)
>  {
>  	unsigned long saddr = ((idx - svma->vm_pgoff) << PAGE_SHIFT) +
>  				svma->vm_start;
> @@ -4678,7 +4678,7 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
>  	return saddr;
>  }
>  
> -static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> +bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	unsigned long base = addr & PUD_MASK;
>  	unsigned long end = base + PUD_SIZE;

This is going to be build error. mm/hugetlb.o doesn't build unlessp CONFIG_HUGETLBFS=y.

And I think both functions doesn't cover all DAX cases: VMA can be not
aligned (due to vm_start and/or vm_pgoff) to 2M even if the file has 2M
ranges allocated. See transhuge_vma_suitable().

And as I said before, nothing guarantees contiguous 2M ranges on backing
storage.

And in general I found piggybacking on hugetlb hacky.

The solution has to stand on its own with own justification. Saying it
worked for hugetlb and it has to work here would not fly. hugetlb is much
more restrictive on use cases. THP has more corner cases.

> diff --git a/mm/memory.c b/mm/memory.c
> index ddf20bd..1ca8f75 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3932,6 +3932,109 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_HUGE_PMD_SHARE
> +static pmd_t *huge_pmd_offset(struct mm_struct *mm,
> +			      unsigned long addr, unsigned long sz)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	pgd = pgd_offset(mm, addr);
> +	if (!pgd_present(*pgd))
> +		return NULL;
> +	p4d = p4d_offset(pgd, addr);
> +	if (!p4d_present(*p4d))
> +		return NULL;
> +
> +	pud = pud_offset(p4d, addr);
> +	if (sz != PUD_SIZE && pud_none(*pud))
> +		return NULL;
> +	/* hugepage or swap? */
> +	if (pud_huge(*pud) || !pud_present(*pud))
> +		return (pmd_t *)pud;

So do we or do we not support PUD pages? This is just broken.
> +
> +	pmd = pmd_offset(pud, addr);
> +	if (sz != PMD_SIZE && pmd_none(*pmd))
> +		return NULL;
> +	/* hugepage or swap? */
> +	if (pmd_huge(*pmd) || !pmd_present(*pmd))
> +		return pmd;
> +
> +	return NULL;
> +}
> +

-- 
 Kirill A. Shutemov
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
