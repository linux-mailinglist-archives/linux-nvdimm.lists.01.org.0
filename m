Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E0137B36F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 May 2021 03:23:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA568100EB33A;
	Tue, 11 May 2021 18:23:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50121100EB337
	for <linux-nvdimm@lists.01.org>; Tue, 11 May 2021 18:23:41 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C074661928;
	Wed, 12 May 2021 01:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1620782619;
	bh=EuquOXa6sdUy29wXYEo+mtbqiM5nYJmbHZRuly0nuEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5WB+/fE83IHq4sPSz5Sxnzb9GVOiLU+OyuLr/iBkXDxxO/aTJxmUMXSdCFByTUj7
	 A1eoYI29ji7qed+aPUkVvg9T7PlPYrdgTkstrqMWrxYcLVCHFoLUwNmbUDt5LBvDkb
	 KxlkssBeoEZYzWp02e4uHr2GL7iJ5VN9erDOnK0/Mz0W1N1MR6FrdHN5m04yb09tD7
	 8FKa2DprYI4O0T9kYpQ4EadNT1Mo44zdBCHiVdNKp75be505egvBDCS5BeQhG13dC9
	 AxmSkIF829XgY8jq8Sb6XEOqQSKAnAiyNNEmhVmO7B11F1CVJ9HRE4TXyEadEaGcAW
	 BnvpPbszh8ZIg==
Date: Tue, 11 May 2021 18:23:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v5 5/7] fsdax: Dedup file range to use a compare function
Message-ID: <20210512012336.GU8582@magnolia>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210511030933.3080921-6-ruansy.fnst@fujitsu.com>
Message-ID-Hash: MRWPLCKO6GMUCZQDHNOXYK53U7FCD5IT
X-Message-ID-Hash: MRWPLCKO6GMUCZQDHNOXYK53U7FCD5IT
X-MailFrom: djwong@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MRWPLCKO6GMUCZQDHNOXYK53U7FCD5IT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 11, 2021 at 11:09:31AM +0800, Shiyang Ruan wrote:
> With dax we cannot deal with readpage() etc. So, we create a dax
> comparison funciton which is similar with
> vfs_dedupe_file_range_compare().
> And introduce dax_remap_file_range_prep() for filesystem use.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c             | 56 +++++++++++++++++++++++++++++++++++++++++++
>  fs/remap_range.c     | 57 +++++++++++++++++++++++++++++++++++++-------
>  fs/xfs/xfs_reflink.c |  8 +++++--
>  include/linux/dax.h  |  4 ++++
>  include/linux/fs.h   | 12 ++++++----
>  5 files changed, 123 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index ee9d28a79bfb..dedf1be0155c 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1853,3 +1853,59 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  	return dax_insert_pfn_mkwrite(vmf, pfn, order);
>  }
>  EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
> +
> +static loff_t dax_range_compare_actor(struct inode *ino1, loff_t pos1,
> +		struct inode *ino2, loff_t pos2, loff_t len, void *data,
> +		struct iomap *smap, struct iomap *dmap)
> +{
> +	void *saddr, *daddr;
> +	bool *same = data;
> +	int ret;
> +
> +	if (smap->type == IOMAP_HOLE && dmap->type == IOMAP_HOLE) {
> +		*same = true;
> +		return len;
> +	}
> +
> +	if (smap->type == IOMAP_HOLE || dmap->type == IOMAP_HOLE) {
> +		*same = false;
> +		return 0;
> +	}
> +
> +	ret = dax_iomap_direct_access(smap, pos1, ALIGN(pos1 + len, PAGE_SIZE),
> +				      &saddr, NULL);
> +	if (ret < 0)
> +		return -EIO;
> +
> +	ret = dax_iomap_direct_access(dmap, pos2, ALIGN(pos2 + len, PAGE_SIZE),
> +				      &daddr, NULL);
> +	if (ret < 0)
> +		return -EIO;
> +
> +	*same = !memcmp(saddr, daddr, len);
> +	return len;
> +}
> +
> +int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +		struct inode *dest, loff_t destoff, loff_t len, bool *is_same,
> +		const struct iomap_ops *ops)
> +{
> +	int id, ret = 0;
> +
> +	id = dax_read_lock();
> +	while (len) {
> +		ret = iomap_apply2(src, srcoff, dest, destoff, len, 0, ops,
> +				   is_same, dax_range_compare_actor);
> +		if (ret < 0 || !*is_same)
> +			goto out;
> +
> +		len -= ret;
> +		srcoff += ret;
> +		destoff += ret;
> +	}
> +	ret = 0;
> +out:
> +	dax_read_unlock(id);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dax_dedupe_file_range_compare);
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index e4a5fdd7ad7b..7bc4c8e3aa9f 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -14,6 +14,7 @@
>  #include <linux/compat.h>
>  #include <linux/mount.h>
>  #include <linux/fs.h>
> +#include <linux/dax.h>
>  #include "internal.h"
>  
>  #include <linux/uaccess.h>
> @@ -199,9 +200,9 @@ static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
>   * Compare extents of two files to see if they are the same.
>   * Caller must have locked both inodes to prevent write races.
>   */
> -static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> -					 struct inode *dest, loff_t destoff,
> -					 loff_t len, bool *is_same)
> +int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +				  struct inode *dest, loff_t destoff,
> +				  loff_t len, bool *is_same)
>  {
>  	loff_t src_poff;
>  	loff_t dest_poff;
> @@ -280,6 +281,7 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  out_error:
>  	return error;
>  }
> +EXPORT_SYMBOL(vfs_dedupe_file_range_compare);
>  
>  /*
>   * Check that the two inodes are eligible for cloning, the ranges make
> @@ -289,9 +291,11 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>   * If there's an error, then the usual negative error code is returned.
>   * Otherwise returns 0 with *len set to the request length.
>   */
> -int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> -				  struct file *file_out, loff_t pos_out,
> -				  loff_t *len, unsigned int remap_flags)
> +static int
> +__generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +				struct file *file_out, loff_t pos_out,
> +				loff_t *len, unsigned int remap_flags,
> +				const struct iomap_ops *dax_read_ops)
>  {
>  	struct inode *inode_in = file_inode(file_in);
>  	struct inode *inode_out = file_inode(file_out);
> @@ -351,8 +355,17 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  	if (remap_flags & REMAP_FILE_DEDUP) {
>  		bool		is_same = false;
>  
> -		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> -				inode_out, pos_out, *len, &is_same);
> +		if (!IS_DAX(inode_in))
> +			ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> +					inode_out, pos_out, *len, &is_same);
> +#ifdef CONFIG_FS_DAX
> +		else if (dax_read_ops)
> +			ret = dax_dedupe_file_range_compare(inode_in, pos_in,
> +					inode_out, pos_out, *len, &is_same,
> +					dax_read_ops);
> +#endif /* CONFIG_FS_DAX */

Hmm, can you add an entry to the !IS_ENABLED(CONFIG_DAX) part of dax.h
that defines dax_dedupe_file_range_compare as a dummy function that
returns -EOPNOTSUPP?  We try not to sprinkle preprocessor directives
into the middle of functions, per Linus rules.

> +		else
> +			return -EINVAL;
>  		if (ret)
>  			return ret;
>  		if (!is_same)
> @@ -370,6 +383,34 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  
>  	return ret;
>  }
> +
> +#ifdef CONFIG_FS_DAX
> +int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +			      struct file *file_out, loff_t pos_out,
> +			      loff_t *len, unsigned int remap_flags,
> +			      const struct iomap_ops *ops)
> +{
> +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> +					       pos_out, len, remap_flags, ops);
> +}
> +#else
> +int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +			      struct file *file_out, loff_t pos_out,
> +			      loff_t *len, unsigned int remap_flags,
> +			      const struct iomap_ops *ops)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_FS_DAX */
> +EXPORT_SYMBOL(dax_remap_file_range_prep);

I think this symbol belongs in fs/dax.c and the declaration in dax.h?

--D

> +int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +				  struct file *file_out, loff_t pos_out,
> +				  loff_t *len, unsigned int remap_flags)
> +{
> +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> +					       pos_out, len, remap_flags, NULL);
> +}
>  EXPORT_SYMBOL(generic_remap_file_range_prep);
>  
>  loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 060695d6d56a..d25434f93235 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1329,8 +1329,12 @@ xfs_reflink_remap_prep(
>  	if (IS_DAX(inode_in) || IS_DAX(inode_out))
>  		goto out_unlock;
>  
> -	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
> -			len, remap_flags);
> +	if (!IS_DAX(inode_in))
> +		ret = generic_remap_file_range_prep(file_in, pos_in, file_out,
> +				pos_out, len, remap_flags);
> +	else
> +		ret = dax_remap_file_range_prep(file_in, pos_in, file_out,
> +				pos_out, len, remap_flags, &xfs_read_iomap_ops);
>  	if (ret || *len == 0)
>  		goto out_unlock;
>  
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 3275e01ed33d..32e1c34349f2 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -239,6 +239,10 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  				      pgoff_t index);
>  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
>  		struct iomap *srcmap);
> +int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +				  struct inode *dest, loff_t destoff,
> +				  loff_t len, bool *is_same,
> +				  const struct iomap_ops *ops);
>  static inline bool dax_mapping(struct address_space *mapping)
>  {
>  	return mapping->host && IS_DAX(mapping->host);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c3c88fdb9b2a..e2c348553d87 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -71,6 +71,7 @@ struct fsverity_operations;
>  struct fs_context;
>  struct fs_parameter_spec;
>  struct fileattr;
> +struct iomap_ops;
>  
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -2126,10 +2127,13 @@ extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
>  extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  				       struct file *file_out, loff_t pos_out,
>  				       size_t len, unsigned int flags);
> -extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> -					 struct file *file_out, loff_t pos_out,
> -					 loff_t *count,
> -					 unsigned int remap_flags);
> +int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +				  struct file *file_out, loff_t pos_out,
> +				  loff_t *count, unsigned int remap_flags);
> +int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +			      struct file *file_out, loff_t pos_out,
> +			      loff_t *len, unsigned int remap_flags,
> +			      const struct iomap_ops *ops);
>  extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
>  				  struct file *file_out, loff_t pos_out,
>  				  loff_t len, unsigned int remap_flags);
> -- 
> 2.31.1
> 
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
