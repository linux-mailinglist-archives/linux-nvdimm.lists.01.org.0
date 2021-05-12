Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71D237B35E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 May 2021 03:17:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A54A100EB337;
	Tue, 11 May 2021 18:17:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83E7D100EB332
	for <linux-nvdimm@lists.01.org>; Tue, 11 May 2021 18:17:41 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E71546190A;
	Wed, 12 May 2021 01:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1620782261;
	bh=AktYlWaGr7394zUc1f2j8uMtJ2qB+r/wzZ9wf6oV66A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXn3fA5z7lcFlHNq1K5/lrzPmAD4sLs35bFf0SBCjrNayldftQjrT0yMGdZ9jQq7F
	 Lr7SWwMfvPyNfrLLwbcyF/fwWuvF/EfY4rc9r6Hs68jBirIPket2YspjOpdUpOgDqI
	 pK1NsJbJWQkOvlFyi2jLNj2RM51OLpGxKCoyWluGMjbz/OVgU8bTlKF7A6rtiT4+/g
	 VX08CYFx0KjL6KXquUC60FYGdbaqhL4q0QpGSkWCKiGzDHisrPw5HDpg1Kcoo9GqIb
	 LaGghtXdwbM0jSUmwh0hsgrS3H4ojO07YsoZ3fMlbl3M8eOaw+xDoQWNOBmFIu3xXe
	 Erw86DXRC0NeQ==
Date: Tue, 11 May 2021 18:17:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
Message-ID: <20210512011738.GT8582@magnolia>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210511030933.3080921-4-ruansy.fnst@fujitsu.com>
Message-ID-Hash: 6RAREEFFAAHKECLRCXXSIW7UX5RXLNVC
X-Message-ID-Hash: 6RAREEFFAAHKECLRCXXSIW7UX5RXLNVC
X-MailFrom: djwong@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6RAREEFFAAHKECLRCXXSIW7UX5RXLNVC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 11, 2021 at 11:09:29AM +0800, Shiyang Ruan wrote:
> Punch hole on a reflinked file needs dax_copy_edge() too.  Otherwise,
> data in not aligned area will be not correct.  So, add the srcmap to
> dax_iomap_zero() and replace memset() as dax_copy_edge().
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/dax.c               | 25 +++++++++++++++----------
>  fs/iomap/buffered-io.c |  2 +-
>  include/linux/dax.h    |  3 ++-
>  3 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index ef0e564e7904..ee9d28a79bfb 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1186,7 +1186,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  }
>  #endif /* CONFIG_FS_DAX_PMD */
>  
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> +		struct iomap *srcmap)
>  {
>  	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>  	pgoff_t pgoff;
> @@ -1208,19 +1209,23 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  
>  	if (page_aligned)
>  		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> -	else
> +	else {
>  		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
> -	if (rc < 0) {
> -		dax_read_unlock(id);
> -		return rc;
> -	}
> -
> -	if (!page_aligned) {
> -		memset(kaddr + offset, 0, size);
> +		if (rc < 0)
> +			goto out;
> +		if (iomap->addr != srcmap->addr) {

Why isn't this "if (srcmap->type != IOMAP_HOLE)" ?

I suppose it has the same effect, since @iomap should never be a hole
and we should never have a @srcmap that's the same as @iomap, but
still, we use IOMAP_HOLE checks in most other parts of fs/iomap/.

Other than that, the logic looks decent to me.

--D

> +			rc = dax_iomap_cow_copy(offset, size, PAGE_SIZE, srcmap,
> +						kaddr);
> +			if (rc < 0)
> +				goto out;
> +		} else
> +			memset(kaddr + offset, 0, size);
>  		dax_flush(iomap->dax_dev, kaddr + offset, size);
>  	}
> +
> +out:
>  	dax_read_unlock(id);
> -	return size;
> +	return rc < 0 ? rc : size;
>  }
>  
>  static loff_t
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f2cd2034a87b..2734955ea67f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -933,7 +933,7 @@ static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
>  		s64 bytes;
>  
>  		if (IS_DAX(inode))
> -			bytes = dax_iomap_zero(pos, length, iomap);
> +			bytes = dax_iomap_zero(pos, length, iomap, srcmap);
>  		else
>  			bytes = iomap_zero(inode, pos, length, iomap, srcmap);
>  		if (bytes < 0)
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b52f084aa643..3275e01ed33d 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -237,7 +237,8 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
>  int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  				      pgoff_t index);
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
> +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> +		struct iomap *srcmap);
>  static inline bool dax_mapping(struct address_space *mapping)
>  {
>  	return mapping->host && IS_DAX(mapping->host);
> -- 
> 2.31.1
> 
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
