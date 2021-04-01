Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E247350F21
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Apr 2021 08:39:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 396BC100EB847;
	Wed, 31 Mar 2021 23:39:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=ritesh.list@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3B0E8100EBBAF
	for <linux-nvdimm@lists.01.org>; Wed, 31 Mar 2021 23:39:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h8so515503plt.7
        for <linux-nvdimm@lists.01.org>; Wed, 31 Mar 2021 23:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cdhn3hlT1LofiWiq9NSsZXRFtnuTmpkFOIZBKIG5BiA=;
        b=UTL5B1kymvtzLNP/91qrZli7L9K/RRc+t3YUJywMQyXnYDuvkYCGKiqHl2oJcMHHoy
         UGaOiavWcQuvbtsY1AjPK18htFJRFjqk3J5JdwTUPpjlDB0xyn5dXDyWUmP05ep0zZd3
         /PasjavPWANRdOiP9OF2XgmhE9kIQIp8A01zzEzf9Th+GbR4RZ3V8I8HEFY87DA13dkG
         txGDPNpeNWXZC+RFFqxjEarVoUhbMJnYh/2oHqJq6Qh6NIAaDiKc9Or3dcxwhb/yJSfj
         VqvUFcWPRWPOFWq4prpgIgVuKKW4b/yRynE+dhn2QPX62tiJcvfvYUdyKCX/c2u8m8US
         VzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cdhn3hlT1LofiWiq9NSsZXRFtnuTmpkFOIZBKIG5BiA=;
        b=X1PHoxDpFVhDNR0I5Uf25FkmTqfry14pGlecVLrzpgMRXpEW0pyZZfRg83WG49SmoG
         rIhwh9g11T2gzUXbwlOOF0PXktrIbiJd27buzVZcF6MPsUydEv7y4TNbHPD5K47e1dfw
         MKITGVMRFRyDcI2n2dhKKgC3TagDMHtKbPL3U08yuyHnllzQqh4BE0pj9fgPXX57KJk5
         cpAKEB4mIGo0TF0zb9cIzadSioWGd/85OgzcSmUG0cMrgpxPh79pme4dUkpEBbkxJvWi
         rIwbPwcOcXN25nt0/FyT0vMqc6XJ/GRRJPlnXx8fkSQDR6La4c32cby8zAI43WcHw/26
         hL7g==
X-Gm-Message-State: AOAM530RvGHlwZFZriqdAROWKmVh2cZyztkIIg4/yUQSvJpg15CPt5p6
	3uDM2E6gHSIDroEjFkFLv7A=
X-Google-Smtp-Source: ABdhPJxV7qnJmiKTK7vMsVhFFpLWa9nVg5l0P/yHHXGvs45jJWGW4/3YJNYe6mcpuHqq0YLrqeBnjw==
X-Received: by 2002:a17:90a:990a:: with SMTP id b10mr7368818pjp.178.1617259175255;
        Wed, 31 Mar 2021 23:39:35 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id w26sm4326195pfj.58.2021.03.31.23.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:39:34 -0700 (PDT)
Date: Thu, 1 Apr 2021 12:09:32 +0530
From: Ritesh Harjani <ritesh.list@gmail.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v3 05/10] fsdax: Replace mmap entry in case of CoW
Message-ID: <20210401063932.tro7a4hhy25zdmho@riteshh-domain>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319015237.993880-6-ruansy.fnst@fujitsu.com>
Message-ID-Hash: B73RXOSVO4PA2NBAEQ7KQSAULHT3HCPM
X-Message-ID-Hash: B73RXOSVO4PA2NBAEQ7KQSAULHT3HCPM
X-MailFrom: ritesh.list@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B73RXOSVO4PA2NBAEQ7KQSAULHT3HCPM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/03/19 09:52AM, Shiyang Ruan wrote:
> We replace the existing entry to the newly allocated one in case of CoW.
> Also, we mark the entry as PAGECACHE_TAG_TOWRITE so writeback marks this
> entry as writeprotected.  This helps us snapshots so new write
> pagefaults after snapshots trigger a CoW.
>

Please correct me here. So the flow is like this.
1. In case of CoW or a reflinked file, on an mmaped file if write is attempted,
   Then in DAX fault handler code, ->iomap_begin() on a given filesystem will
   populate iomap and srcmap. srcmap being from where the read needs to be
   attempted from and iomap on where the new write should go to.
2. So the dax_insert_entry() code as part of the fault handling will take care
   of removing the old entry and inserting the new pfn entry to xas and mark
   it with PAGECACHE_TAG_TOWRITE so that dax writeback can mark the entry as
   write protected.
Is my above understanding correct?

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 181aad97136a..cfe513eb111e 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -722,6 +722,9 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>  	return 0;
>  }
>
> +#define DAX_IF_DIRTY		(1 << 0)
> +#define DAX_IF_COW		(1 << 1)
> +
>
small comment expalining this means DAX insert flags used in dax_insert_entry()

>
>  /*
>   * By this point grab_mapping_entry() has ensured that we have a locked entry
>   * of the appropriate size so we don't have to worry about downgrading PMDs to
> @@ -729,16 +732,19 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>   * already in the tree, we will skip the insertion and just dirty the PMD as
>   * appropriate.
>   */
> -static void *dax_insert_entry(struct xa_state *xas,
> -		struct address_space *mapping, struct vm_fault *vmf,
> -		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
> +static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
> +		void *entry, pfn_t pfn, unsigned long flags,
> +		unsigned int insert_flags)
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
> @@ -750,7 +756,7 @@ static void *dax_insert_entry(struct xa_state *xas,
>
>  	xas_reset(xas);
>  	xas_lock_irq(xas);
> -	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>  		void *old;
>
>  		dax_disassociate_entry(entry, mapping, false);
> @@ -774,6 +780,9 @@ static void *dax_insert_entry(struct xa_state *xas,
>  	if (dirty)
>  		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
>
> +	if (cow)
> +		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
> +
>  	xas_unlock_irq(xas);
>  	return entry;
>  }
> @@ -1098,8 +1107,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
>  	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
>  	vm_fault_t ret;
>
> -	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -			DAX_ZERO_PAGE, false);
> +	*entry = dax_insert_entry(xas, vmf, *entry, pfn, DAX_ZERO_PAGE, 0);
>
>  	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
>  	trace_dax_load_hole(inode, vmf, ret);
> @@ -1126,8 +1134,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
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
> @@ -1431,6 +1439,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
>  	loff_t pos = (loff_t)xas->xa_offset << PAGE_SHIFT;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	bool sync = dax_fault_is_synchronous(flags, vmf->vma, iomap);
> +	unsigned int insert_flags = 0;
>  	int err = 0;
>  	pfn_t pfn;
>  	void *kaddr;
> @@ -1453,8 +1462,14 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
>  	if (err)
>  		return dax_fault_return(err);
>
> -	entry = dax_insert_entry(xas, mapping, vmf, entry, pfn, 0,
> -				 write && !sync);
> +	if (write) {
> +		if (!sync)
> +			insert_flags |= DAX_IF_DIRTY;
> +		if (iomap->flags & IOMAP_F_SHARED)
> +			insert_flags |= DAX_IF_COW;
> +	}
> +
> +	entry = dax_insert_entry(xas, vmf, entry, pfn, 0, insert_flags);
>
>  	if (write && srcmap->addr != iomap->addr) {
>  		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr, false);
>

Rest looks good to me. Please feel free to add
Reviewed-by: Ritesh Harjani <riteshh@gmail.com>

sorry about changing my email in between of this code review.
I am planning to use above gmail id as primary account for all upstream work
from now.

> --
> 2.30.1
>
>
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
