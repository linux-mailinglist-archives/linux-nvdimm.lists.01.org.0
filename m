Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F31E231CAE8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Feb 2021 14:14:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9625C100EBB6A;
	Tue, 16 Feb 2021 05:13:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=dsterba@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AC3F1100EBBC1
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 05:13:53 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 9D362ACBF;
	Tue, 16 Feb 2021 13:13:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 8C951DA6EF; Tue, 16 Feb 2021 14:11:54 +0100 (CET)
Date: Tue, 16 Feb 2021 14:11:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 4/7] fsdax: Replace mmap entry in case of CoW
Message-ID: <20210216131154.GN1993@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz,
	Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	darrick.wong@oracle.com, dan.j.williams@intel.com,
	willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
	david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-5-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210207170924.2933035-5-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Message-ID-Hash: BHLYE7RMH3BDEKNTF2V5NP2A2BYL75BP
X-Message-ID-Hash: BHLYE7RMH3BDEKNTF2V5NP2A2BYL75BP
X-MailFrom: dsterba@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: dsterba@suse.cz
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BHLYE7RMH3BDEKNTF2V5NP2A2BYL75BP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 08, 2021 at 01:09:21AM +0800, Shiyang Ruan wrote:
> We replace the existing entry to the newly allocated one
> in case of CoW. Also, we mark the entry as PAGECACHE_TAG_TOWRITE
> so writeback marks this entry as writeprotected. This
> helps us snapshots so new write pagefaults after snapshots
> trigger a CoW.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  fs/dax.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index b2195cbdf2dc..29698a3d2e37 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -722,6 +722,9 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>  	return 0;
>  }
>  
> +#define DAX_IF_DIRTY		(1ULL << 0)
> +#define DAX_IF_COW		(1ULL << 1)

The constants are ULL, but I see other flags only 'unsigned long'

> +
>  /*
>   * By this point grab_mapping_entry() has ensured that we have a locked entry
>   * of the appropriate size so we don't have to worry about downgrading PMDs to
> @@ -731,14 +734,16 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>   */
>  static void *dax_insert_entry(struct xa_state *xas,
>  		struct address_space *mapping, struct vm_fault *vmf,
> -		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
> +		void *entry, pfn_t pfn, unsigned long flags, bool insert_flags)

insert_flags is bool

>  {
>  	void *new_entry = dax_make_entry(pfn, flags);
> +	bool dirty = insert_flags & DAX_IF_DIRTY;

"insert_flags & DAX_IF_DIRTY" is "bool & ULL", this can't be right

> +	bool cow = insert_flags & DAX_IF_COW;

Same

>  
>  	if (dirty)
>  		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>  
> -	if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
> +	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
>  		unsigned long index = xas->xa_index;
>  		/* we are replacing a zero page with block mapping */
>  		if (dax_is_pmd_entry(entry))
> @@ -750,7 +755,7 @@ static void *dax_insert_entry(struct xa_state *xas,
>  
>  	xas_reset(xas);
>  	xas_lock_irq(xas);
> -	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>  		void *old;
>  
>  		dax_disassociate_entry(entry, mapping, false);
> @@ -774,6 +779,9 @@ static void *dax_insert_entry(struct xa_state *xas,
>  	if (dirty)
>  		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
>  
> +	if (cow)
> +		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
> +
>  	xas_unlock_irq(xas);
>  	return entry;
>  }
> @@ -1319,6 +1327,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	void *entry;
>  	pfn_t pfn;
>  	void *kaddr;
> +	unsigned long insert_flags = 0;
>  
>  	trace_dax_pte_fault(inode, vmf, ret);
>  	/*
> @@ -1444,8 +1453,10 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  
>  		goto finish_iomap;
>  	case IOMAP_UNWRITTEN:
> -		if (write && iomap.flags & IOMAP_F_SHARED)
> +		if (write && (iomap.flags & IOMAP_F_SHARED)) {
> +			insert_flags |= DAX_IF_COW;

Here's an example of 'unsigned long = unsigned long long', though it'll
work, it would be better to unify all the types.

>  			goto cow;
> +		}
>  		fallthrough;
>  	case IOMAP_HOLE:
>  		if (!write) {
> @@ -1555,6 +1566,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	int error;
>  	pfn_t pfn;
>  	void *kaddr;
> +	unsigned long insert_flags = 0;
>  
>  	/*
>  	 * Check whether offset isn't beyond end of file now. Caller is
> @@ -1670,14 +1682,17 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		result = vmf_insert_pfn_pmd(vmf, pfn, write);
>  		break;
>  	case IOMAP_UNWRITTEN:
> -		if (write && iomap.flags & IOMAP_F_SHARED)
> +		if (write && (iomap.flags & IOMAP_F_SHARED)) {
> +			insert_flags |= DAX_IF_COW;
>  			goto cow;
> +		}
>  		fallthrough;
>  	case IOMAP_HOLE:
> -		if (WARN_ON_ONCE(write))
> +		if (!write) {
> +			result = dax_pmd_load_hole(&xas, vmf, &iomap, &entry);
>  			break;
> -		result = dax_pmd_load_hole(&xas, vmf, &iomap, &entry);
> -		break;
> +		}
> +		fallthrough;
>  	default:
>  		WARN_ON_ONCE(1);
>  		break;
> -- 
> 2.30.0
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
