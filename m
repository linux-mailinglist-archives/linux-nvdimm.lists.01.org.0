Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 026A0358FA7
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 00:11:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 040D9100EB330;
	Thu,  8 Apr 2021 15:11:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5DC5B100EB82A
	for <linux-nvdimm@lists.01.org>; Thu,  8 Apr 2021 15:11:35 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C668361107;
	Thu,  8 Apr 2021 22:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1617919893;
	bh=JHtxDsKdHaTfSByGIt0LBvw1nnygzJIyZWR4wvxXFYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDiatDdZBUiYkGFU31JmrQVsKVFW+mN8umpeZ/t6bTNxSRnI5VgIPtNZ0MqMtEDqS
	 vilyR6P1dNLbbfLdTouNeKeSrC2k04mpG8ByCKDq/o+Ygtyj/AKYpYSD6Fbnz5oe7y
	 pkn3Xw+QZS8m0zNkxyRlaIeSJa5zWPvsxTYUxeExxOugb3cD79zY4yodH+5lpUWA56
	 s+G4R/UyRUko2Lw4YPpOwRyprb3A5jk4wbKXMlSAQ+dtkvuCalCzujDGYGQUy0I+DF
	 S2h8jZiMahtkDhjLIK7CDFpWe7FLBYBDXAItu5WnWcA93WgFhkFAr6NpuD/ZebOjsA
	 kNL51WVseojZQ==
Date: Thu, 8 Apr 2021 15:11:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v4 2/7] fsdax: Replace mmap entry in case of CoW
Message-ID: <20210408221131.GZ3957620@magnolia>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
 <20210408120432.1063608-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408120432.1063608-3-ruansy.fnst@fujitsu.com>
Message-ID-Hash: U3LPSRWLWFB3457URJ2QAK2A5SERKKY7
X-Message-ID-Hash: U3LPSRWLWFB3457URJ2QAK2A5SERKKY7
X-MailFrom: djwong@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U3LPSRWLWFB3457URJ2QAK2A5SERKKY7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 08, 2021 at 08:04:27PM +0800, Shiyang Ruan wrote:
> We replace the existing entry to the newly allocated one in case of CoW.
> Also, we mark the entry as PAGECACHE_TAG_TOWRITE so writeback marks this
> entry as writeprotected.  This helps us snapshots so new write
> pagefaults after snapshots trigger a CoW.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/dax.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index b4fd3813457a..e6c1354b27a8 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -722,6 +722,10 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>  	return 0;
>  }
>  
> +/* DAX Insert Flag for the entry we insert */

Might be worth mentioning that these are xarray marks for the inserted
entry, since this comment didn't help much.

> +#define DAX_IF_DIRTY		(1 << 0)
> +#define DAX_IF_COW		(1 << 1)
> +
>  /*
>   * By this point grab_mapping_entry() has ensured that we have a locked entry
>   * of the appropriate size so we don't have to worry about downgrading PMDs to
> @@ -729,16 +733,19 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>   * already in the tree, we will skip the insertion and just dirty the PMD as
>   * appropriate.
>   */
> -static void *dax_insert_entry(struct xa_state *xas,
> -		struct address_space *mapping, struct vm_fault *vmf,
> -		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
> +static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
> +		void *entry, pfn_t pfn, unsigned long flags,
> +		unsigned int insert_flags)

Urk, two flags arguments.  Oh, I see.  We insert (shifted) pfn_t values
into the mapping as xarray values, so @flags determines the state flags
of the new entry value, whereas @insert_flags determines what xarray
mark we're going to attach (if any) to the inserted value.

--D

>  {
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>  	void *new_entry = dax_make_entry(pfn, flags);
> +	bool dirty = insert_flags & DAX_IF_DIRTY;
> +	bool cow = insert_flags & DAX_IF_COW;
>  
>  	if (dirty)
>  		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>  
> -	if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
> +	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
>  		unsigned long index = xas->xa_index;
>  		/* we are replacing a zero page with block mapping */
>  		if (dax_is_pmd_entry(entry))
> @@ -750,7 +757,7 @@ static void *dax_insert_entry(struct xa_state *xas,
>  
>  	xas_reset(xas);
>  	xas_lock_irq(xas);
> -	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>  		void *old;
>  
>  		dax_disassociate_entry(entry, mapping, false);
> @@ -774,6 +781,9 @@ static void *dax_insert_entry(struct xa_state *xas,
>  	if (dirty)
>  		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
>  
> +	if (cow)
> +		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
> +
>  	xas_unlock_irq(xas);
>  	return entry;
>  }
> @@ -1109,8 +1119,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
>  	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
>  	vm_fault_t ret;
>  
> -	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -			DAX_ZERO_PAGE, false);
> +	*entry = dax_insert_entry(xas, vmf, *entry, pfn, DAX_ZERO_PAGE, 0);
>  
>  	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
>  	trace_dax_load_hole(inode, vmf, ret);
> @@ -1137,8 +1146,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  		goto fallback;
>  
>  	pfn = page_to_pfn_t(zero_page);
> -	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -			DAX_PMD | DAX_ZERO_PAGE, false);
> +	*entry = dax_insert_entry(xas, vmf, *entry, pfn,
> +				  DAX_PMD | DAX_ZERO_PAGE, 0);
>  
>  	if (arch_needs_pgtable_deposit()) {
>  		pgtable = pte_alloc_one(vma->vm_mm);
> @@ -1444,6 +1453,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	bool sync = dax_fault_is_synchronous(flags, vmf->vma, iomap);
>  	unsigned long entry_flags = pmd ? DAX_PMD : 0;
> +	unsigned int insert_flags = 0;
>  	int err = 0;
>  	pfn_t pfn;
>  	void *kaddr;
> @@ -1466,8 +1476,15 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
>  	if (err)
>  		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
>  
> -	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
> -				  write && !sync);
> +	if (write) {
> +		if (!sync)
> +			insert_flags |= DAX_IF_DIRTY;
> +		if (iomap->flags & IOMAP_F_SHARED)
> +			insert_flags |= DAX_IF_COW;
> +	}
> +
> +	*entry = dax_insert_entry(xas, vmf, *entry, pfn, entry_flags,
> +				  insert_flags);
>  
>  	if (write &&
>  	    srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
> -- 
> 2.31.0
> 
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
