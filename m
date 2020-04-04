Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5924619E1EA
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Apr 2020 02:25:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 33BB4100DD86A;
	Fri,  3 Apr 2020 17:26:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=bo.liu@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 92437100DD869
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 17:26:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TuXvZ6z_1585959921;
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TuXvZ6z_1585959921)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Apr 2020 08:25:25 +0800
Date: Sat, 4 Apr 2020 08:25:21 +0800
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 13/20] fuse, dax: Implement dax read/write operations
Message-ID: <20200404002521.GA125697@rsjd01523.et2sqa>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-14-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200304165845.3081-14-vgoyal@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Message-ID-Hash: 4XSRCXDUNHE7KFSNYZ5MB3I5C7IS4ZEE
X-Message-ID-Hash: 4XSRCXDUNHE7KFSNYZ5MB3I5C7IS4ZEE
X-MailFrom: bo.liu@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Peng Tao <tao.peng@linux.alibaba.com>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: bo.liu@linux.alibaba.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4XSRCXDUNHE7KFSNYZ5MB3I5C7IS4ZEE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 04, 2020 at 11:58:38AM -0500, Vivek Goyal wrote:
> This patch implements basic DAX support. mmap() is not implemented
> yet and will come in later patches. This patch looks into implemeting
> read/write.
> 
> We make use of interval tree to keep track of per inode dax mappings.
> 
> Do not use dax for file extending writes, instead just send WRITE message
> to daemon (like we do for direct I/O path). This will keep write and
> i_size change atomic w.r.t crash.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> ---
>  fs/fuse/file.c            | 597 +++++++++++++++++++++++++++++++++++++-
>  fs/fuse/fuse_i.h          |  23 ++
>  fs/fuse/inode.c           |   6 +
>  include/uapi/linux/fuse.h |   1 +
>  4 files changed, 621 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 9d67b830fb7a..9effdd3dc6d6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -18,6 +18,12 @@
>  #include <linux/swap.h>
>  #include <linux/falloc.h>
>  #include <linux/uio.h>
> +#include <linux/dax.h>
> +#include <linux/iomap.h>
> +#include <linux/interval_tree_generic.h>
> +
> +INTERVAL_TREE_DEFINE(struct fuse_dax_mapping, rb, __u64, __subtree_last,
> +                     START, LAST, static inline, fuse_dax_interval_tree);
>  
>  static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
>  				      struct fuse_page_desc **desc)
> @@ -187,6 +193,242 @@ static void fuse_link_write_file(struct file *file)
>  	spin_unlock(&fi->lock);
>  }
>  
> +static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
> +{
> +	struct fuse_dax_mapping *dmap = NULL;
> +
> +	spin_lock(&fc->lock);
> +
> +	if (fc->nr_free_ranges <= 0) {
> +		spin_unlock(&fc->lock);
> +		return NULL;
> +	}
> +
> +	WARN_ON(list_empty(&fc->free_ranges));
> +
> +	/* Take a free range */
> +	dmap = list_first_entry(&fc->free_ranges, struct fuse_dax_mapping,
> +					list);
> +	list_del_init(&dmap->list);
> +	fc->nr_free_ranges--;
> +	spin_unlock(&fc->lock);
> +	return dmap;
> +}
> +
> +/* This assumes fc->lock is held */
> +static void __dmap_add_to_free_pool(struct fuse_conn *fc,
> +				struct fuse_dax_mapping *dmap)
> +{
> +	list_add_tail(&dmap->list, &fc->free_ranges);
> +	fc->nr_free_ranges++;
> +}
> +
> +static void dmap_add_to_free_pool(struct fuse_conn *fc,
> +				struct fuse_dax_mapping *dmap)
> +{
> +	/* Return fuse_dax_mapping to free list */
> +	spin_lock(&fc->lock);
> +	__dmap_add_to_free_pool(fc, dmap);
> +	spin_unlock(&fc->lock);
> +}
> +
> +/* offset passed in should be aligned to FUSE_DAX_MEM_RANGE_SZ */
> +static int fuse_setup_one_mapping(struct inode *inode, loff_t offset,
> +				  struct fuse_dax_mapping *dmap, bool writable,
> +				  bool upgrade)
> +{
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_setupmapping_in inarg;
> +	FUSE_ARGS(args);
> +	ssize_t err;
> +
> +	WARN_ON(offset % FUSE_DAX_MEM_RANGE_SZ);
> +	WARN_ON(fc->nr_free_ranges < 0);
> +
> +	/* Ask fuse daemon to setup mapping */
> +	memset(&inarg, 0, sizeof(inarg));
> +	inarg.foffset = offset;
> +	inarg.fh = -1;
> +	inarg.moffset = dmap->window_offset;
> +	inarg.len = FUSE_DAX_MEM_RANGE_SZ;
> +	inarg.flags |= FUSE_SETUPMAPPING_FLAG_READ;
> +	if (writable)
> +		inarg.flags |= FUSE_SETUPMAPPING_FLAG_WRITE;
> +	args.opcode = FUSE_SETUPMAPPING;
> +	args.nodeid = fi->nodeid;
> +	args.in_numargs = 1;
> +	args.in_args[0].size = sizeof(inarg);
> +	args.in_args[0].value = &inarg;
> +	err = fuse_simple_request(fc, &args);
> +	if (err < 0) {
> +		printk(KERN_ERR "%s request failed at mem_offset=0x%llx %zd\n",
> +				 __func__, dmap->window_offset, err);
> +		return err;
> +	}
> +
> +	pr_debug("fuse_setup_one_mapping() succeeded. offset=0x%llx writable=%d"
> +		 " err=%zd\n", offset, writable, err);
> +
> +	dmap->writable = writable;
> +	if (!upgrade) {
> +		dmap->start = offset;
> +		dmap->end = offset + FUSE_DAX_MEM_RANGE_SZ - 1;
> +		/* Protected by fi->i_dmap_sem */
> +		fuse_dax_interval_tree_insert(dmap, &fi->dmap_tree);
> +		fi->nr_dmaps++;
> +	}
> +	return 0;
> +}
> +
> +static int
> +fuse_send_removemapping(struct inode *inode,
> +			struct fuse_removemapping_in *inargp,
> +			struct fuse_removemapping_one *remove_one)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +	FUSE_ARGS(args);
> +
> +	args.opcode = FUSE_REMOVEMAPPING;
> +	args.nodeid = fi->nodeid;
> +	args.in_numargs = 2;
> +	args.in_args[0].size = sizeof(*inargp);
> +	args.in_args[0].value = inargp;
> +	args.in_args[1].size = inargp->count * sizeof(*remove_one);
> +	args.in_args[1].value = remove_one;
> +	return fuse_simple_request(fc, &args);
> +}
> +
> +static int dmap_removemapping_list(struct inode *inode, unsigned num,
> +				   struct list_head *to_remove)
> +{
> +	struct fuse_removemapping_one *remove_one, *ptr;
> +	struct fuse_removemapping_in inarg;
> +	struct fuse_dax_mapping *dmap;
> +	int ret, i = 0, nr_alloc;
> +
> +	nr_alloc = min_t(unsigned int, num, FUSE_REMOVEMAPPING_MAX_ENTRY);
> +	remove_one = kmalloc_array(nr_alloc, sizeof(*remove_one), GFP_NOFS);
> +	if (!remove_one)
> +		return -ENOMEM;
> +
> +	ptr = remove_one;
> +	list_for_each_entry(dmap, to_remove, list) {
> +		ptr->moffset = dmap->window_offset;
> +		ptr->len = dmap->length;
> +		ptr++;
> +		i++;
> +		num--;
> +		if (i >= nr_alloc || num == 0) {
> +			memset(&inarg, 0, sizeof(inarg));
> +			inarg.count = i;
> +			ret = fuse_send_removemapping(inode, &inarg,
> +						      remove_one);
> +			if (ret)
> +				goto out;
> +			ptr = remove_one;
> +			i = 0;
> +		}
> +	}
> +out:
> +	kfree(remove_one);
> +	return ret;
> +}
> +
> +/*
> + * Cleanup dmap entry and add back to free list. This should be called with
> + * fc->lock held.
> + */
> +static void dmap_reinit_add_to_free_pool(struct fuse_conn *fc,
> +					    struct fuse_dax_mapping *dmap)
> +{
> +	pr_debug("fuse: freeing memory range start=0x%llx end=0x%llx "
> +		 "window_offset=0x%llx length=0x%llx\n", dmap->start,
> +		 dmap->end, dmap->window_offset, dmap->length);
> +	dmap->start = dmap->end = 0;
> +	__dmap_add_to_free_pool(fc, dmap);
> +}
> +
> +/*
> + * Free inode dmap entries whose range falls entirely inside [start, end].
> + * Does not take any locks. At this point of time it should only be
> + * called from evict_inode() path where we know all dmap entries can be
> + * reclaimed.
> + */
> +static void inode_reclaim_dmap_range(struct fuse_conn *fc, struct inode *inode,
> +				      loff_t start, loff_t end)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_dax_mapping *dmap, *n;
> +	int err, num = 0;
> +	LIST_HEAD(to_remove);
> +
> +	pr_debug("fuse: %s: start=0x%llx, end=0x%llx\n", __func__, start, end);
> +
> +	/*
> +	 * Interval tree search matches intersecting entries. Adjust the range
> +	 * to avoid dropping partial valid entries.
> +	 */
> +	start = ALIGN(start, FUSE_DAX_MEM_RANGE_SZ);
> +	end = ALIGN_DOWN(end, FUSE_DAX_MEM_RANGE_SZ);
> +
> +	while (1) {
> +		dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, start,
> +							 end);
> +		if (!dmap)
> +			break;
> +		fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
> +		num++;
> +		list_add(&dmap->list, &to_remove);
> +	}
> +
> +	/* Nothing to remove */
> +	if (list_empty(&to_remove))
> +		return;
> +
> +	WARN_ON(fi->nr_dmaps < num);
> +	fi->nr_dmaps -= num;
> +	/*
> +	 * During umount/shutdown, fuse connection is dropped first
> +	 * and evict_inode() is called later. That means any
> +	 * removemapping messages are going to fail. Send messages
> +	 * only if connection is up. Otherwise fuse daemon is
> +	 * responsible for cleaning up any leftover references and
> +	 * mappings.
> +	 */
> +	if (fc->connected) {
> +		err = dmap_removemapping_list(inode, num, &to_remove);
> +		if (err) {
> +			pr_warn("Failed to removemappings. start=0x%llx"
> +				" end=0x%llx\n", start, end);
> +		}
> +	}
> +	spin_lock(&fc->lock);
> +	list_for_each_entry_safe(dmap, n, &to_remove, list) {
> +		list_del_init(&dmap->list);
> +		dmap_reinit_add_to_free_pool(fc, dmap);
> +	}
> +	spin_unlock(&fc->lock);
> +}
> +
> +/*
> + * It is called from evict_inode() and by that time inode is going away. So
> + * this function does not take any locks like fi->i_dmap_sem for traversing
> + * that fuse inode interval tree. If that lock is taken then lock validator
> + * complains of deadlock situation w.r.t fs_reclaim lock.
> + */
> +void fuse_cleanup_inode_mappings(struct inode *inode)
> +{
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +	/*
> +	 * fuse_evict_inode() has alredy called truncate_inode_pages_final()
> +	 * before we arrive here. So we should not have to worry about
> +	 * any pages/exception entries still associated with inode.
> +	 */
> +	inode_reclaim_dmap_range(fc, inode, 0, -1);
> +}
> +
>  void fuse_finish_open(struct inode *inode, struct file *file)
>  {
>  	struct fuse_file *ff = file->private_data;
> @@ -1562,32 +1804,364 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	return res;
>  }
>  
> +static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
>  static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct fuse_file *ff = file->private_data;
> +	struct inode *inode = file->f_mapping->host;
>  
>  	if (is_bad_inode(file_inode(file)))
>  		return -EIO;
>  
> -	if (!(ff->open_flags & FOPEN_DIRECT_IO))
> -		return fuse_cache_read_iter(iocb, to);
> -	else
> +	if (IS_DAX(inode))
> +		return fuse_dax_read_iter(iocb, to);
> +
> +	if (ff->open_flags & FOPEN_DIRECT_IO)
>  		return fuse_direct_read_iter(iocb, to);
> +
> +	return fuse_cache_read_iter(iocb, to);
>  }
>  
> +static ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
>  static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct fuse_file *ff = file->private_data;
> +	struct inode *inode = file->f_mapping->host;
>  
>  	if (is_bad_inode(file_inode(file)))
>  		return -EIO;
>  
> -	if (!(ff->open_flags & FOPEN_DIRECT_IO))
> -		return fuse_cache_write_iter(iocb, from);
> -	else
> +	if (IS_DAX(inode))
> +		return fuse_dax_write_iter(iocb, from);
> +
> +	if (ff->open_flags & FOPEN_DIRECT_IO)
>  		return fuse_direct_write_iter(iocb, from);
> +
> +	return fuse_cache_write_iter(iocb, from);
> +}
> +
> +static void fuse_fill_iomap_hole(struct iomap *iomap, loff_t length)
> +{
> +	iomap->addr = IOMAP_NULL_ADDR;
> +	iomap->length = length;
> +	iomap->type = IOMAP_HOLE;
> +}
> +
> +static void fuse_fill_iomap(struct inode *inode, loff_t pos, loff_t length,
> +			struct iomap *iomap, struct fuse_dax_mapping *dmap,
> +			unsigned flags)
> +{
> +	loff_t offset, len;
> +	loff_t i_size = i_size_read(inode);
> +
> +	offset = pos - dmap->start;
> +	len = min(length, dmap->length - offset);
> +
> +	/* If length is beyond end of file, truncate further */
> +	if (pos + len > i_size)
> +		len = i_size - pos;
> +
> +	if (len > 0) {
> +		iomap->addr = dmap->window_offset + offset;
> +		iomap->length = len;
> +		if (flags & IOMAP_FAULT)
> +			iomap->length = ALIGN(len, PAGE_SIZE);
> +		iomap->type = IOMAP_MAPPED;
> +		pr_debug("%s: returns iomap: addr 0x%llx offset 0x%llx"
> +				" length 0x%llx\n", __func__, iomap->addr,
> +				iomap->offset, iomap->length);
> +	} else {
> +		/* Mapping beyond end of file is hole */
> +		fuse_fill_iomap_hole(iomap, length);
> +		pr_debug("%s: returns iomap: addr 0x%llx offset 0x%llx"
> +				"length 0x%llx\n", __func__, iomap->addr,
> +				iomap->offset, iomap->length);
> +	}
> +}
> +
> +static int iomap_begin_setup_new_mapping(struct inode *inode, loff_t pos,
> +					 loff_t length, unsigned flags,
> +					 struct iomap *iomap)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +	struct fuse_dax_mapping *dmap, *alloc_dmap = NULL;
> +	int ret;
> +	bool writable = flags & IOMAP_WRITE;
> +
> +	alloc_dmap = alloc_dax_mapping(fc);
> +	if (!alloc_dmap)
> +		return -EBUSY;
> +
> +	/*
> +	 * Take write lock so that only one caller can try to setup mapping
> +	 * and other waits.
> +	 */
> +	down_write(&fi->i_dmap_sem);
> +	/*
> +	 * We dropped lock. Check again if somebody else setup
> +	 * mapping already.
> +	 */
> +	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos,
> +						pos);
> +	if (dmap) {
> +		fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
> +		dmap_add_to_free_pool(fc, alloc_dmap);
> +		up_write(&fi->i_dmap_sem);
> +		return 0;
> +	}
> +
> +	/* Setup one mapping */
> +	ret = fuse_setup_one_mapping(inode,
> +				     ALIGN_DOWN(pos, FUSE_DAX_MEM_RANGE_SZ),
> +				     alloc_dmap, writable, false);
> +	if (ret < 0) {
> +		printk("fuse_setup_one_mapping() failed. err=%d"
> +			" pos=0x%llx, writable=%d\n", ret, pos, writable);
> +		dmap_add_to_free_pool(fc, alloc_dmap);
> +		up_write(&fi->i_dmap_sem);
> +		return ret;
> +	}
> +	fuse_fill_iomap(inode, pos, length, iomap, alloc_dmap, flags);
> +	up_write(&fi->i_dmap_sem);
> +	return 0;
> +}
> +
> +static int iomap_begin_upgrade_mapping(struct inode *inode, loff_t pos,
> +					 loff_t length, unsigned flags,
> +					 struct iomap *iomap)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_dax_mapping *dmap;
> +	int ret;
> +
> +	/*
> +	 * Take exclusive lock so that only one caller can try to setup
> +	 * mapping and others wait.
> +	 */
> +	down_write(&fi->i_dmap_sem);
> +	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos, pos);
> +
> +	/* We are holding either inode lock or i_mmap_sem, and that should
> +	 * ensure that dmap can't reclaimed or truncated and it should still
> +	 * be there in tree despite the fact we dropped and re-acquired the
> +	 * lock.
> +	 */
> +	ret = -EIO;
> +	if (WARN_ON(!dmap))
> +		goto out_err;
> +
> +	/* Maybe another thread already upgraded mapping while we were not
> +	 * holding lock.
> +	 */
> +	if (dmap->writable)

oops, looks like it's still returning -EIO here, %ret should be zero.

thanks,
liubo

> +		goto out_fill_iomap;
> +
> +	ret = fuse_setup_one_mapping(inode,
> +				     ALIGN_DOWN(pos, FUSE_DAX_MEM_RANGE_SZ),
> +				     dmap, true, true);
> +	if (ret < 0) {
> +		printk("fuse_setup_one_mapping() failed. err=%d pos=0x%llx\n",
> +		       ret, pos);
> +		goto out_err;
> +	}
> +
> +out_fill_iomap:
> +	fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
> +out_err:
> +	up_write(&fi->i_dmap_sem);
> +	return ret;
> +}
> +
> +/* This is just for DAX and the mapping is ephemeral, do not use it for other
> + * purposes since there is no block device with a permanent mapping.
> + */
> +static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
> +			    unsigned flags, struct iomap *iomap,
> +			    struct iomap *srcmap)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +	struct fuse_dax_mapping *dmap;
> +	bool writable = flags & IOMAP_WRITE;
> +
> +	/* We don't support FIEMAP */
> +	BUG_ON(flags & IOMAP_REPORT);
> +
> +	pr_debug("fuse_iomap_begin() called. pos=0x%llx length=0x%llx\n",
> +			pos, length);
> +
> +	/*
> +	 * Writes beyond end of file are not handled using dax path. Instead
> +	 * a fuse write message is sent to daemon
> +	 */
> +	if (flags & IOMAP_WRITE && pos >= i_size_read(inode))
> +		return -EIO;
> +
> +	iomap->offset = pos;
> +	iomap->flags = 0;
> +	iomap->bdev = NULL;
> +	iomap->dax_dev = fc->dax_dev;
> +
> +	/*
> +	 * Both read/write and mmap path can race here. So we need something
> +	 * to make sure if we are setting up mapping, then other path waits
> +	 *
> +	 * For now, use a semaphore for this. It probably needs to be
> +	 * optimized later.
> +	 */
> +	down_read(&fi->i_dmap_sem);
> +	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos, pos);
> +
> +	if (dmap) {
> +		if (writable && !dmap->writable) {
> +			/* Upgrade read-only mapping to read-write. This will
> +			 * require exclusive i_dmap_sem lock as we don't want
> +			 * two threads to be trying to this simultaneously
> +			 * for same dmap. So drop shared lock and acquire
> +			 * exclusive lock.
> +			 */
> +			up_read(&fi->i_dmap_sem);
> +			pr_debug("%s: Upgrading mapping at offset 0x%llx"
> +				 " length 0x%llx\n", __func__, pos, length);
> +			return iomap_begin_upgrade_mapping(inode, pos, length,
> +							   flags, iomap);
> +		} else {
> +			fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
> +			up_read(&fi->i_dmap_sem);
> +			return 0;
> +		}
> +	} else {
> +		up_read(&fi->i_dmap_sem);
> +		pr_debug("%s: no mapping at offset 0x%llx length 0x%llx\n",
> +				__func__, pos, length);
> +		if (pos >= i_size_read(inode))
> +			goto iomap_hole;
> +
> +		return iomap_begin_setup_new_mapping(inode, pos, length, flags,
> +						     iomap);
> +	}
> +
> +	/*
> +	 * If read beyond end of file happnes, fs code seems to return
> +	 * it as hole
> +	 */
> +iomap_hole:
> +	fuse_fill_iomap_hole(iomap, length);
> +	pr_debug("fuse_iomap_begin() returning hole mapping. pos=0x%llx length_asked=0x%llx length_returned=0x%llx\n", pos, length, iomap->length);
> +	return 0;
> +}
> +
> +static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length,
> +			  ssize_t written, unsigned flags,
> +			  struct iomap *iomap)
> +{
> +	/* DAX writes beyond end-of-file aren't handled using iomap, so the
> +	 * file size is unchanged and there is nothing to do here.
> +	 */
> +	return 0;
> +}
> +
> +static const struct iomap_ops fuse_iomap_ops = {
> +	.iomap_begin = fuse_iomap_begin,
> +	.iomap_end = fuse_iomap_end,
> +};
> +
> +static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	ssize_t ret;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock_shared(inode))
> +			return -EAGAIN;
> +	} else {
> +		inode_lock_shared(inode);
> +	}
> +
> +	ret = dax_iomap_rw(iocb, to, &fuse_iomap_ops);
> +	inode_unlock_shared(inode);
> +
> +	/* TODO file_accessed(iocb->f_filp) */
> +	return ret;
> +}
> +
> +static bool file_extending_write(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	return (iov_iter_rw(from) == WRITE &&
> +		((iocb->ki_pos) >= i_size_read(inode)));
> +}
> +
> +static ssize_t fuse_dax_direct_write(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
> +	ssize_t ret;
> +
> +	ret = fuse_direct_io(&io, from, &iocb->ki_pos, FUSE_DIO_WRITE);
> +	if (ret < 0)
> +		return ret;
> +
> +	fuse_invalidate_attr(inode);
> +	fuse_write_update_size(inode, iocb->ki_pos);
> +	return ret;
> +}
> +
> +static ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	ssize_t ret, count;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode))
> +			return -EAGAIN;
> +	} else {
> +		inode_lock(inode);
> +	}
> +
> +	ret = generic_write_checks(iocb, from);
> +	if (ret <= 0)
> +		goto out;
> +
> +	ret = file_remove_privs(iocb->ki_filp);
> +	if (ret)
> +		goto out;
> +	/* TODO file_update_time() but we don't want metadata I/O */
> +
> +	/* Do not use dax for file extending writes as its an mmap and
> +	 * trying to write beyong end of existing page will generate
> +	 * SIGBUS.
> +	 */
> +	if (file_extending_write(iocb, from)) {
> +		ret = fuse_dax_direct_write(iocb, from);
> +		goto out;
> +	}
> +
> +	ret = dax_iomap_rw(iocb, from, &fuse_iomap_ops);
> +	if (ret < 0)
> +		goto out;
> +
> +	/*
> +	 * If part of the write was file extending, fuse dax path will not
> +	 * take care of that. Do direct write instead.
> +	 */
> +	if (iov_iter_count(from) && file_extending_write(iocb, from)) {
> +		count = fuse_dax_direct_write(iocb, from);
> +		if (count < 0)
> +			goto out;
> +		ret += count;
> +	}
> +
> +out:
> +	inode_unlock(inode);
> +
> +	if (ret > 0)
> +		ret = generic_write_sync(iocb, ret);
> +	return ret;
>  }
>  
>  static void fuse_writepage_free(struct fuse_writepage_args *wpa)
> @@ -2318,6 +2892,11 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +static int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	return -EINVAL; /* TODO */
> +}
> +
>  static int convert_fuse_file_lock(struct fuse_conn *fc,
>  				  const struct fuse_file_lock *ffl,
>  				  struct file_lock *fl)
> @@ -3387,6 +3966,7 @@ static const struct address_space_operations fuse_file_aops  = {
>  void fuse_init_file_inode(struct inode *inode)
>  {
>  	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_conn *fc = get_fuse_conn(inode);
>  
>  	inode->i_fop = &fuse_file_operations;
>  	inode->i_data.a_ops = &fuse_file_aops;
> @@ -3396,4 +3976,9 @@ void fuse_init_file_inode(struct inode *inode)
>  	fi->writectr = 0;
>  	init_waitqueue_head(&fi->page_waitq);
>  	INIT_LIST_HEAD(&fi->writepages);
> +	fi->dmap_tree = RB_ROOT_CACHED;
> +
> +	if (fc->dax_dev) {
> +		inode->i_flags |= S_DAX;
> +	}
>  }
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index b41275f73e4c..490549862bda 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -70,16 +70,29 @@ struct fuse_forget_link {
>  	struct fuse_forget_link *next;
>  };
>  
> +#define START(node) ((node)->start)
> +#define LAST(node) ((node)->end)
> +
>  /** Translation information for file offsets to DAX window offsets */
>  struct fuse_dax_mapping {
>  	/* Will connect in fc->free_ranges to keep track of free memory */
>  	struct list_head list;
>  
> +	/* For interval tree in file/inode */
> +	struct rb_node rb;
> +	/** Start Position in file */
> +	__u64 start;
> +	/** End Position in file */
> +	__u64 end;
> +	__u64 __subtree_last;
>  	/** Position in DAX window */
>  	u64 window_offset;
>  
>  	/** Length of mapping, in bytes */
>  	loff_t length;
> +
> +	/* Is this mapping read-only or read-write */
> +	bool writable;
>  };
>  
>  /** FUSE inode */
> @@ -167,6 +180,15 @@ struct fuse_inode {
>  
>  	/** Lock to protect write related fields */
>  	spinlock_t lock;
> +
> +	/*
> +	 * Semaphore to protect modifications to dmap_tree
> +	 */
> +	struct rw_semaphore i_dmap_sem;
> +
> +	/** Sorted rb tree of struct fuse_dax_mapping elements */
> +	struct rb_root_cached dmap_tree;
> +	unsigned long nr_dmaps;
>  };
>  
>  /** FUSE inode state bits */
> @@ -1127,5 +1149,6 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
>   */
>  u64 fuse_get_unique(struct fuse_iqueue *fiq);
>  void fuse_free_conn(struct fuse_conn *fc);
> +void fuse_cleanup_inode_mappings(struct inode *inode);
>  
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 36cb9c00bbe5..93bc65607a15 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -86,7 +86,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
>  	fi->attr_version = 0;
>  	fi->orig_ino = 0;
>  	fi->state = 0;
> +	fi->nr_dmaps = 0;
>  	mutex_init(&fi->mutex);
> +	init_rwsem(&fi->i_dmap_sem);
>  	spin_lock_init(&fi->lock);
>  	fi->forget = fuse_alloc_forget();
>  	if (!fi->forget) {
> @@ -114,6 +116,10 @@ static void fuse_evict_inode(struct inode *inode)
>  	clear_inode(inode);
>  	if (inode->i_sb->s_flags & SB_ACTIVE) {
>  		struct fuse_conn *fc = get_fuse_conn(inode);
> +		if (IS_DAX(inode)) {
> +			fuse_cleanup_inode_mappings(inode);
> +			WARN_ON(fi->nr_dmaps);
> +		}
>  		fuse_queue_forget(fc, fi->forget, fi->nodeid, fi->nlookup);
>  		fi->forget = NULL;
>  	}
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 62633555d547..36d824b82ebc 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -896,6 +896,7 @@ struct fuse_copy_file_range_in {
>  
>  #define FUSE_SETUPMAPPING_ENTRIES 8
>  #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> +#define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
>  struct fuse_setupmapping_in {
>  	/* An already open handle */
>  	uint64_t	fh;
> -- 
> 2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
