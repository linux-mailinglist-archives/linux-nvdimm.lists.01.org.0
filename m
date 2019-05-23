Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E29727E47
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 May 2019 15:38:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08C6F21276B86;
	Thu, 23 May 2019 06:38:47 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 57CA4212532F0
 for <linux-nvdimm@lists.01.org>; Thu, 23 May 2019 06:38:44 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 98947AD7F;
 Thu, 23 May 2019 13:38:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id E08A21E3C69; Thu, 23 May 2019 15:38:41 +0200 (CEST)
Date: Thu, 23 May 2019 15:38:41 +0200
From: Jan Kara <jack@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: Re: [PATCH 10/18] dax: replace mmap entry in case of CoW
Message-ID: <20190523133841.GB2949@quack2.suse.cz>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-11-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190429172649.8288-11-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: kilobyte@angband.pl, jack@suse.cz, darrick.wong@oracle.com,
 nborisov@suse.com, linux-nvdimm@lists.01.org, david@fromorbit.com,
 dsterba@suse.cz, willy@infradead.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
 linux-fsdevel@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon 29-04-19 12:26:41, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> We replace the existing entry to the newly allocated one
> in case of CoW. Also, we mark the entry as PAGECACHE_TAG_TOWRITE
> so writeback marks this entry as writeprotected. This
> helps us snapshots so new write pagefaults after snapshots
> trigger a CoW.

I don't understand why do you need to mark the new entry with
PAGECACHE_TAG_TOWRITE. dax_insert_entry() will unmap the entry from all
page tables so what's there left to writeprotect?

>  /*
>   * By this point grab_mapping_entry() has ensured that we have a locked entry
>   * of the appropriate size so we don't have to worry about downgrading PMDs to
> @@ -709,14 +712,17 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
>   */
>  static void *dax_insert_entry(struct xa_state *xas,
>  		struct address_space *mapping, struct vm_fault *vmf,
> -		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
> +		void *entry, pfn_t pfn, unsigned long flags,
> +		unsigned long insert_flags)
>  {
>  	void *new_entry = dax_make_entry(pfn, flags);
> +	bool dirty = insert_flags & DAX_IF_DIRTY;
> +	bool cow = insert_flags & DAX_IF_COW;

Does 'cow' really need to be a separate flag? dax_insert_entry() can just
figure out the right thing to do on its own based on old entry value and
new entry to be inserted...

>  
>  	if (dirty)
>  		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>  
> -	if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
> +	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {

E.g. here we need to unmap if old entry is not 'empty' and the pfns differ
(well, the pfns differ check should better be done like I outline below to
make pmd + pte match work correctly).

>  		unsigned long index = xas->xa_index;
>  		/* we are replacing a zero page with block mapping */
>  		if (dax_is_pmd_entry(entry))
> @@ -728,12 +734,12 @@ static void *dax_insert_entry(struct xa_state *xas,
>  
>  	xas_reset(xas);
>  	xas_lock_irq(xas);
> -	if (dax_entry_size(entry) != dax_entry_size(new_entry)) {
> +	if (cow || (dax_entry_size(entry) != dax_entry_size(new_entry))) {

This needs to be done if entries are different at all...

>  		dax_disassociate_entry(entry, mapping, false);
>  		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
>  	}
>  
> -	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {

This is the only place that will be a bit more subtle - you need to check
whether the new entry is not a subset of the old one (i.e., a PTE inside a
PMD) and skip setting in that case. So something like:

	if (xa_to_value(new_entry) | DAX_LOCKED == xa_to_value(entry) ||
	    (dax_is_pmd_entry(entry) && dax_is_pte_entry(new_entry) &&
	     dax_to_pfn(entry) + (xas->xa_index & PG_PMD_COLOUR) ==
	     dax_to_pfn(new_entry))) {
		/* New entry is a subset of the current one? Skip update... */
		xas_load(xas);
	} else {
		do work...
	}


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
