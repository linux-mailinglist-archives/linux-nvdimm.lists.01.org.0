Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCB8181F4C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 18:24:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A62310FC36FC;
	Wed, 11 Mar 2020 10:25:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=bo.liu@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0768210FC36F4
	for <linux-nvdimm@lists.01.org>; Wed, 11 Mar 2020 10:25:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TsK.c7b_1583947470;
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TsK.c7b_1583947470)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Mar 2020 01:24:36 +0800
Date: Thu, 12 Mar 2020 01:24:30 +0800
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 20/20] fuse,virtiofs: Add logic to free up a memory range
Message-ID: <20200311172429.wmiflrlube3k2rkw@rsjd01523.et2sqa>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-21-vgoyal@redhat.com>
 <20200311051641.l6gonmmyb4o5rcrb@rsjd01523.et2sqa>
 <20200311125923.GA83257@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311125923.GA83257@redhat.com>
User-Agent: NeoMutt/20180223
Message-ID-Hash: YIGTYG4I6BROSLL7AE3J6AXCK2QTBDU6
X-Message-ID-Hash: YIGTYG4I6BROSLL7AE3J6AXCK2QTBDU6
X-MailFrom: bo.liu@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: bo.liu@linux.alibaba.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YIGTYG4I6BROSLL7AE3J6AXCK2QTBDU6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 11, 2020 at 08:59:23AM -0400, Vivek Goyal wrote:
> On Wed, Mar 11, 2020 at 01:16:42PM +0800, Liu Bo wrote:
> 
> [..]
> > > @@ -719,6 +723,7 @@ void fuse_conn_put(struct fuse_conn *fc)
> > >  	if (refcount_dec_and_test(&fc->count)) {
> > >  		struct fuse_iqueue *fiq = &fc->iq;
> > >  
> > > +		flush_delayed_work(&fc->dax_free_work);
> > 
> > Today while debugging another case, I realized that flushing work here
> > at the very last fuse_conn_put() is a bit too late, here's my analysis,
> > 
> >          umount                                                   kthread
> > 
> > deactivate_locked_super
> >   ->virtio_kill_sb                                            try_to_free_dmap_chunks
> >     ->generic_shutdown_super                                    ->igrab()
> >                                                                 ...
> >      ->evict_inodes()  -> check all inodes' count
> >      ->fuse_conn_put                                            ->iput
> >  ->virtio_fs_free_devs
> >    ->fuse_dev_free
> >      ->fuse_conn_put // vq1
> >    ->fuse_dev_free
> >      ->fuse_conn_put // vq2
> >        ->flush_delayed_work
> > 
> > The above can end up with a warning message reported by evict_inodes()
> > about stable inodes.
> 
> Hi Liu Bo,
> 
> Which warning is that? Can you point me to it in code.
>

Hmm, it was actually in generic_shutdow_super,
---
              printk("VFS: Busy inodes after unmount of %s. "
                           "Self-destruct in 5 seconds.  Have a nice day...\n",
---

> > So I think it's necessary to put either
> > cancel_delayed_work_sync() or flush_delayed_work() before going to
> > generic_shutdown_super().
> 
> In general I agree that shutting down memory range freeing worker
> earling in unmount/shutdown sequence makes sense. It does not seem
> to help to let it run while filesystem is going away. How about following
> patch.
> 
> ---
>  fs/fuse/inode.c     |    1 -
>  fs/fuse/virtio_fs.c |    5 +++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> Index: redhat-linux/fs/fuse/virtio_fs.c
> ===================================================================
> --- redhat-linux.orig/fs/fuse/virtio_fs.c	2020-03-10 14:11:10.970284651 -0400
> +++ redhat-linux/fs/fuse/virtio_fs.c	2020-03-11 08:27:08.103330039 -0400
> @@ -1295,6 +1295,11 @@ static void virtio_kill_sb(struct super_
>  	vfs = fc->iq.priv;
>  	fsvq = &vfs->vqs[VQ_HIPRIO];
>  
> +	/* Stop dax worker. Soon evict_inodes() will be called which will
> +	 * free all memory ranges belonging to all inodes.
> +	 */
> +	flush_delayed_work(&fc->dax_free_work);
> +
>  	/* Stop forget queue. Soon destroy will be sent */
>  	spin_lock(&fsvq->lock);
>  	fsvq->connected = false;
> Index: redhat-linux/fs/fuse/inode.c
> ===================================================================
> --- redhat-linux.orig/fs/fuse/inode.c	2020-03-10 09:13:35.132565666 -0400
> +++ redhat-linux/fs/fuse/inode.c	2020-03-11 08:22:02.685330039 -0400
> @@ -723,7 +723,6 @@ void fuse_conn_put(struct fuse_conn *fc)
>  	if (refcount_dec_and_test(&fc->count)) {
>  		struct fuse_iqueue *fiq = &fc->iq;
>  
> -		flush_delayed_work(&fc->dax_free_work);
>  		if (fc->dax_dev)
>  			fuse_free_dax_mem_ranges(&fc->free_ranges);
>  		if (fiq->ops->release)

Looks good, it should be safe now, but I feel like
cancel_delayed_work_sync() would be a good alternative for "stop dax
worker".

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

Fine with either folding directly or a new patch, thanks for fixing it.

thanks,
-liubo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
