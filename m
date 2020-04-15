Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC461AAF69
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Apr 2020 19:22:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E01141010632B;
	Wed, 15 Apr 2020 10:23:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=bo.liu@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0E2C71010632A
	for <linux-nvdimm@lists.01.org>; Wed, 15 Apr 2020 10:23:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvdP111_1586971349;
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TvdP111_1586971349)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Apr 2020 01:22:35 +0800
Date: Thu, 16 Apr 2020 01:22:29 +0800
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 20/20] fuse,virtiofs: Add logic to free up a memory range
Message-ID: <20200415172229.GA121484@rsjd01523.et2sqa>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-21-vgoyal@redhat.com>
 <20200326000904.GA34937@rsjd01523.et2sqa>
 <20200327140114.GB32717@redhat.com>
 <20200327220606.GA119028@rsjd01523.et2sqa>
 <20200414193045.GB210453@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200414193045.GB210453@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Message-ID-Hash: RTXZ4VTNV7KGPZBP5JKT4FL6S5EYHV3Y
X-Message-ID-Hash: RTXZ4VTNV7KGPZBP5JKT4FL6S5EYHV3Y
X-MailFrom: bo.liu@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: bo.liu@linux.alibaba.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RTXZ4VTNV7KGPZBP5JKT4FL6S5EYHV3Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 14, 2020 at 03:30:45PM -0400, Vivek Goyal wrote:
> On Sat, Mar 28, 2020 at 06:06:06AM +0800, Liu Bo wrote:
> > On Fri, Mar 27, 2020 at 10:01:14AM -0400, Vivek Goyal wrote:
> > > On Thu, Mar 26, 2020 at 08:09:05AM +0800, Liu Bo wrote:
> > > 
> > > [..]
> > > > > +/*
> > > > > + * Find first mapping in the tree and free it and return it. Do not add
> > > > > + * it back to free pool. If fault == true, this function should be called
> > > > > + * with fi->i_mmap_sem held.
> > > > > + */
> > > > > +static struct fuse_dax_mapping *inode_reclaim_one_dmap(struct fuse_conn *fc,
> > > > > +							 struct inode *inode,
> > > > > +							 bool fault)
> > > > > +{
> > > > > +	struct fuse_inode *fi = get_fuse_inode(inode);
> > > > > +	struct fuse_dax_mapping *dmap;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (!fault)
> > > > > +		down_write(&fi->i_mmap_sem);
> > > > > +
> > > > > +	/*
> > > > > +	 * Make sure there are no references to inode pages using
> > > > > +	 * get_user_pages()
> > > > > +	 */
> > > > > +	ret = fuse_break_dax_layouts(inode, 0, 0);
> > > > 
> > > > Hi Vivek,
> > > > 
> > > > This patch is enabling inline reclaim for fault path, but fault path
> > > > has already holds a locked exceptional entry which I believe the above
> > > > fuse_break_dax_layouts() needs to wait for, can you please elaborate
> > > > on how this can be avoided?
> > > > 
> > > 
> > > Hi Liubo,
> > > 
> > > Can you please point to the exact lock you are referring to. I will
> > > check it out. Once we got rid of needing to take inode lock in
> > > reclaim path, that opended the door to do inline reclaim in fault
> > > path as well. But I was not aware of this exceptional entry lock.
> > 
> > Hi Vivek,
> > 
> > dax_iomap_{pte,pmd}_fault has called grab_mapping_entry to get a
> > locked entry, when this fault gets into inline reclaim, would
> > fuse_break_dax_layouts wait for the locked exceptional entry which is
> > locked in dax_iomap_{pte,pmd}_fault?
> 
> Hi Liu Bo,
> 
> This is a good point. Indeed it can deadlock the way code is written
> currently.
>

It's 100% reproducible on 4.19, but not on 5.x which has xarray for
dax_layout_busy_page.

It was weird that on 5.x kernel the deadlock is gone, it turned out
that xarray search in dax_layout_busy_page simply skips the empty
locked exceptional entry, I didn't get deeper to find out whether it's
reasonable, but with that 5.x doesn't run to deadlock.

thanks,
liubo

> Currently we are calling fuse_break_dax_layouts() on the whole file
> in memory inline reclaim path. I am thinking of changing that. Instead,
> find a mapped memory range and file offset and call
> fuse_break_dax_layouts() only on that range (2MB). This should ensure
> that we don't try to break dax layout in the range where we are holding
> exceptional entry lock and avoid deadlock possibility.
> 
> This also has added benefit that we don't have to unmap the whole
> file in an attempt to reclaim one memory range. We will unmap only
> a portion of file and that should be good from performance point of
> view.
> 
> Here is proof of concept patch which applies on top of my internal 
> tree.
> 
> ---
>  fs/fuse/file.c |   72 +++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 50 insertions(+), 22 deletions(-)
> 
> Index: redhat-linux/fs/fuse/file.c
> ===================================================================
> --- redhat-linux.orig/fs/fuse/file.c	2020-04-14 13:47:19.493780528 -0400
> +++ redhat-linux/fs/fuse/file.c	2020-04-14 14:58:26.814079643 -0400
> @@ -4297,13 +4297,13 @@ static int fuse_break_dax_layouts(struct
>          return ret;
>  }
>  
> -/* Find first mapping in the tree and free it. */
> -static struct fuse_dax_mapping *
> -inode_reclaim_one_dmap_locked(struct fuse_conn *fc, struct inode *inode)
> +/* Find first mapped dmap for an inode and return file offset. Caller needs
> + * to hold inode->i_dmap_sem lock either shared or exclusive. */
> +static struct fuse_dax_mapping *inode_lookup_first_dmap(struct fuse_conn *fc,
> +							struct inode *inode)
>  {
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  	struct fuse_dax_mapping *dmap;
> -	int ret;
>  
>  	for (dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, 0, -1);
>  	     dmap;
> @@ -4312,18 +4312,6 @@ inode_reclaim_one_dmap_locked(struct fus
>  		if (refcount_read(&dmap->refcnt) > 1)
>  			continue;
>  
> -		ret = reclaim_one_dmap_locked(fc, inode, dmap);
> -		if (ret < 0)
> -			return ERR_PTR(ret);
> -
> -		/* Clean up dmap. Do not add back to free list */
> -		dmap_remove_busy_list(fc, dmap);
> -		dmap->inode = NULL;
> -		dmap->start = dmap->end = 0;
> -
> -		pr_debug("fuse: %s: reclaimed memory range. inode=%px,"
> -			 " window_offset=0x%llx, length=0x%llx\n", __func__,
> -			 inode, dmap->window_offset, dmap->length);
>  		return dmap;
>  	}
>  
> @@ -4335,30 +4323,70 @@ inode_reclaim_one_dmap_locked(struct fus
>   * it back to free pool. If fault == true, this function should be called
>   * with fi->i_mmap_sem held.
>   */
> -static struct fuse_dax_mapping *inode_reclaim_one_dmap(struct fuse_conn *fc,
> -							 struct inode *inode,
> -							 bool fault)
> +static struct fuse_dax_mapping *
> +inode_inline_reclaim_one_dmap(struct fuse_conn *fc, struct inode *inode,
> +			      bool fault)
>  {
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  	struct fuse_dax_mapping *dmap;
> +	u64 dmap_start, dmap_end;
>  	int ret;
>  
>  	if (!fault)
>  		down_write(&fi->i_mmap_sem);
>  
> +	/* Lookup a dmap and corresponding file offset to reclaim. */
> +	down_read(&fi->i_dmap_sem);
> +	dmap = inode_lookup_first_dmap(fc, inode);
> +	if (dmap) {
> +		dmap_start = dmap->start;
> +		dmap_end = dmap->end;
> +	}
> +	up_read(&fi->i_dmap_sem);
> +
> +	if (!dmap)
> +		goto out_mmap_sem;
>  	/*
>  	 * Make sure there are no references to inode pages using
>  	 * get_user_pages()
>  	 */
> -	ret = fuse_break_dax_layouts(inode, 0, 0);
> +	ret = fuse_break_dax_layouts(inode, dmap_start, dmap_end);
>  	if (ret) {
>  		printk("virtio_fs: fuse_break_dax_layouts() failed. err=%d\n",
>  		       ret);
>  		dmap = ERR_PTR(ret);
>  		goto out_mmap_sem;
>  	}
> +
>  	down_write(&fi->i_dmap_sem);
> -	dmap = inode_reclaim_one_dmap_locked(fc, inode);
> +	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, dmap_start,
> +						 dmap_start);
> +	/* Range already got reclaimed by somebody else */
> +	if (!dmap)
> +		goto out_write_dmap_sem;
> +
> +	/* still in use. */
> +	if (refcount_read(&dmap->refcnt) > 1) {
> +		dmap = NULL;
> +		goto out_write_dmap_sem;
> +	}
> +
> +	ret = reclaim_one_dmap_locked(fc, inode, dmap);
> +	if (ret < 0) {
> +		dmap = NULL;
> +		goto out_write_dmap_sem;
> +	}
> +
> +	/* Clean up dmap. Do not add back to free list */
> +	dmap_remove_busy_list(fc, dmap);
> +	dmap->inode = NULL;
> +	dmap->start = dmap->end = 0;
> +
> +	pr_debug("fuse: %s: inline reclaimed memory range. inode=%px,"
> +		 " window_offset=0x%llx, length=0x%llx\n", __func__,
> +		 inode, dmap->window_offset, dmap->length);
> +
> +out_write_dmap_sem:
>  	up_write(&fi->i_dmap_sem);
>  out_mmap_sem:
>  	if (!fault)
> @@ -4379,7 +4407,7 @@ static struct fuse_dax_mapping *alloc_da
>  			return dmap;
>  
>  		if (fi->nr_dmaps) {
> -			dmap = inode_reclaim_one_dmap(fc, inode, fault);
> +			dmap = inode_inline_reclaim_one_dmap(fc, inode, fault);
>  			if (dmap)
>  				return dmap;
>  			/* If we could not reclaim a mapping because it
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
