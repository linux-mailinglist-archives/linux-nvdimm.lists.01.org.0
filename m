Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4124BD18
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 14:59:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C19D1353AD98;
	Thu, 20 Aug 2020 05:59:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3CFEC134BE035
	for <linux-nvdimm@lists.01.org>; Thu, 20 Aug 2020 05:58:57 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 80BA9AC7D;
	Thu, 20 Aug 2020 12:59:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id E41321E1312; Thu, 20 Aug 2020 14:58:55 +0200 (CEST)
Date: Thu, 20 Aug 2020 14:58:55 +0200
From: Jan Kara <jack@suse.cz>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 02/18] dax: Create a range version of
 dax_layout_busy_page()
Message-ID: <20200820125855.GL1902@quack2.suse.cz>
References: <20200819221956.845195-1-vgoyal@redhat.com>
 <20200819221956.845195-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200819221956.845195-3-vgoyal@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 3AK3TH73IRQGCTFTYL7QUX52CTBXIHIC
X-Message-ID-Hash: 3AK3TH73IRQGCTFTYL7QUX52CTBXIHIC
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3AK3TH73IRQGCTFTYL7QUX52CTBXIHIC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed 19-08-20 18:19:40, Vivek Goyal wrote:
> virtiofs device has a range of memory which is mapped into file inodes
> using dax. This memory is mapped in qemu on host and maps different
> sections of real file on host. Size of this memory is limited
> (determined by administrator) and depending on filesystem size, we will
> soon reach a situation where all the memory is in use and we need to
> reclaim some.
> 
> As part of reclaim process, we will need to make sure that there are
> no active references to pages (taken by get_user_pages()) on the memory
> range we are trying to reclaim. I am planning to use
> dax_layout_busy_page() for this. But in current form this is per inode
> and scans through all the pages of the inode.
> 
> We want to reclaim only a portion of memory (say 2MB page). So we want
> to make sure that only that 2MB range of pages do not have any
> references  (and don't want to unmap all the pages of inode).
> 
> Hence, create a range version of this function named
> dax_layout_busy_page_range() which can be used to pass a range which
> needs to be unmapped.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: Jan Kara <jack@suse.cz>
> Cc: Vishal L Verma <vishal.l.verma@intel.com>
> Cc: "Weiny, Ira" <ira.weiny@intel.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c            | 29 +++++++++++++++++++++++------
>  include/linux/dax.h |  6 ++++++
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 95341af1a966..ddd705251d9f 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -559,7 +559,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
>  }
>  
>  /**
> - * dax_layout_busy_page - find first pinned page in @mapping
> + * dax_layout_busy_page_range - find first pinned page in @mapping
>   * @mapping: address space to scan for a page with ref count > 1

Please document additional function arguments in the kernel-doc comment.

Otherwise the patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

after fixing this nit.

								Honza

>   *
>   * DAX requires ZONE_DEVICE mapped pages. These pages are never
> @@ -572,13 +572,19 @@ static void *grab_mapping_entry(struct xa_state *xas,
>   * establishment of new mappings in this address_space. I.e. it expects
>   * to be able to run unmap_mapping_range() and subsequently not race
>   * mapping_mapped() becoming true.
> + *
> + * Partial pages are included. If 'end' is LLONG_MAX, pages in the range
> + * from 'start' to end of the file are inluded.
>   */
> -struct page *dax_layout_busy_page(struct address_space *mapping)
> +struct page *dax_layout_busy_page_range(struct address_space *mapping,
> +					loff_t start, loff_t end)
>  {
> -	XA_STATE(xas, &mapping->i_pages, 0);
>  	void *entry;
>  	unsigned int scanned = 0;
>  	struct page *page = NULL;
> +	pgoff_t start_idx = start >> PAGE_SHIFT;
> +	pgoff_t end_idx;
> +	XA_STATE(xas, &mapping->i_pages, start_idx);
>  
>  	/*
>  	 * In the 'limited' case get_user_pages() for dax is disabled.
> @@ -589,6 +595,11 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>  	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
>  		return NULL;
>  
> +	/* If end == LLONG_MAX, all pages from start to till end of file */
> +	if (end == LLONG_MAX)
> +		end_idx = ULONG_MAX;
> +	else
> +		end_idx = end >> PAGE_SHIFT;
>  	/*
>  	 * If we race get_user_pages_fast() here either we'll see the
>  	 * elevated page count in the iteration and wait, or
> @@ -596,15 +607,15 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>  	 * against is no longer mapped in the page tables and bail to the
>  	 * get_user_pages() slow path.  The slow path is protected by
>  	 * pte_lock() and pmd_lock(). New references are not taken without
> -	 * holding those locks, and unmap_mapping_range() will not zero the
> +	 * holding those locks, and unmap_mapping_pages() will not zero the
>  	 * pte or pmd without holding the respective lock, so we are
>  	 * guaranteed to either see new references or prevent new
>  	 * references from being established.
>  	 */
> -	unmap_mapping_range(mapping, 0, 0, 0);
> +	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
>  
>  	xas_lock_irq(&xas);
> -	xas_for_each(&xas, entry, ULONG_MAX) {
> +	xas_for_each(&xas, entry, end_idx) {
>  		if (WARN_ON_ONCE(!xa_is_value(entry)))
>  			continue;
>  		if (unlikely(dax_is_locked(entry)))
> @@ -625,6 +636,12 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>  	xas_unlock_irq(&xas);
>  	return page;
>  }
> +EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
> +
> +struct page *dax_layout_busy_page(struct address_space *mapping)
> +{
> +	return dax_layout_busy_page_range(mapping, 0, LLONG_MAX);
> +}
>  EXPORT_SYMBOL_GPL(dax_layout_busy_page);
>  
>  static int __dax_invalidate_entry(struct address_space *mapping,
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 6904d4e0b2e0..9016929db4c6 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -141,6 +141,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
>  		struct dax_device *dax_dev, struct writeback_control *wbc);
>  
>  struct page *dax_layout_busy_page(struct address_space *mapping);
> +struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
>  dax_entry_t dax_lock_page(struct page *page);
>  void dax_unlock_page(struct page *page, dax_entry_t cookie);
>  #else
> @@ -171,6 +172,11 @@ static inline struct page *dax_layout_busy_page(struct address_space *mapping)
>  	return NULL;
>  }
>  
> +static inline struct page *dax_layout_busy_page_range(struct address_space *mapping, pgoff_t start, pgoff_t nr_pages)
> +{
> +	return NULL;
> +}
> +
>  static inline int dax_writeback_mapping_range(struct address_space *mapping,
>  		struct dax_device *dax_dev, struct writeback_control *wbc)
>  {
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
