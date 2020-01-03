Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD54012FC9C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Jan 2020 19:33:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B76710097DF2;
	Fri,  3 Jan 2020 10:36:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EED2D10097DF1
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jan 2020 10:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1578076398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k9B8DZHWqzTB+Kt3rFqrnVZ5tO/IU+S24gouCA4CSXo=;
	b=F4jZz1Yk3WEdoRwk8jyXXb9lbOkqvg6ZdrLYzqE6ZQgToWUFE93XchR4RN4IbxYgHLsq8i
	6pQ/p44UCi05P5SoyWkSfByY6KeZYwEKHeqFjz9A+NUexlKSPXvYfSZOcJI0ztHsWGu+RU
	Gz2Vtjsbq5z1NuqXNv248Dboj5Aww5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-ymZGaeSoOde_Db7plRlGWA-1; Fri, 03 Jan 2020 13:33:14 -0500
X-MC-Unique: ymZGaeSoOde_Db7plRlGWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E90F164A7F;
	Fri,  3 Jan 2020 18:33:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B09397BA32;
	Fri,  3 Jan 2020 18:33:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 446632202E9; Fri,  3 Jan 2020 13:33:07 -0500 (EST)
Date: Fri, 3 Jan 2020 13:33:07 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
Message-ID: <20200103183307.GB13350@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org>
 <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com>
 <20200103141235.GA13350@redhat.com>
 <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
 <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: 5J35BRM5B5STYFM4LAPYBIKHLE7CEMGI
X-Message-ID-Hash: 5J35BRM5B5STYFM4LAPYBIKHLE7CEMGI
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoph Hellwig <hch@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5J35BRM5B5STYFM4LAPYBIKHLE7CEMGI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 03, 2020 at 10:18:22AM -0800, Dan Williams wrote:
> On Fri, Jan 3, 2020 at 10:12 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jan 3, 2020 at 6:12 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> [..]
> > > Hi Dan,
> > >
> > > Ping for this patch. I see christoph and Jan acked it. Can we take it. Not
> > > sure how to get ack from ext4 developers.
> >
> > Jan counts for ext4, I just missed this. Now merged.
> 
> Oh, this now collides with:
> 
>    30fa529e3b2e xfs: add a xfs_inode_buftarg helper
> 
> Care to rebase? I'll also circle back to your question about
> partitions on patch1.

Hi Dan,

Here is the updated patch.

Thanks
Vivek

Subject: dax: Pass dax_dev instead of bdev to dax_writeback_mapping_range()

As of now dax_writeback_mapping_range() takes "struct block_device" as a
parameter and dax_dev is searched from bdev name. This also involves taking
a fresh reference on dax_dev and putting that reference at the end of
function.

We are developing a new filesystem virtio-fs and using dax to access host
page cache directly. But there is no block device. IOW, we want to make
use of dax but want to get rid of this assumption that there is always
a block device associated with dax_dev.

So pass in "struct dax_device" as parameter instead of bdev.

ext2/ext4/xfs are current users and they already have a reference on
dax_device. So there is no need to take reference and drop reference to
dax_device on each call of this function.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c            |    8 +-------
 fs/ext2/inode.c     |    5 +++--
 fs/ext4/inode.c     |    2 +-
 fs/xfs/xfs_aops.c   |    2 +-
 include/linux/dax.h |    4 ++--
 5 files changed, 8 insertions(+), 13 deletions(-)

Index: rhvgoyal-linux-fuse/fs/dax.c
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/dax.c	2020-01-03 11:19:59.151186062 -0500
+++ rhvgoyal-linux-fuse/fs/dax.c	2020-01-03 11:20:05.602186062 -0500
@@ -937,12 +937,11 @@ static int dax_writeback_one(struct xa_s
  * on persistent storage prior to completion of the operation.
  */
 int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc)
+		struct dax_device *dax_dev, struct writeback_control *wbc)
 {
 	XA_STATE(xas, &mapping->i_pages, wbc->range_start >> PAGE_SHIFT);
 	struct inode *inode = mapping->host;
 	pgoff_t end_index = wbc->range_end >> PAGE_SHIFT;
-	struct dax_device *dax_dev;
 	void *entry;
 	int ret = 0;
 	unsigned int scanned = 0;
@@ -953,10 +952,6 @@ int dax_writeback_mapping_range(struct a
 	if (!mapping->nrexceptional || wbc->sync_mode != WB_SYNC_ALL)
 		return 0;
 
-	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
-	if (!dax_dev)
-		return -EIO;
-
 	trace_dax_writeback_range(inode, xas.xa_index, end_index);
 
 	tag_pages_for_writeback(mapping, xas.xa_index, end_index);
@@ -977,7 +972,6 @@ int dax_writeback_mapping_range(struct a
 		xas_lock_irq(&xas);
 	}
 	xas_unlock_irq(&xas);
-	put_dax(dax_dev);
 	trace_dax_writeback_range_done(inode, xas.xa_index, end_index);
 	return ret;
 }
Index: rhvgoyal-linux-fuse/include/linux/dax.h
===================================================================
--- rhvgoyal-linux-fuse.orig/include/linux/dax.h	2020-01-03 11:19:59.151186062 -0500
+++ rhvgoyal-linux-fuse/include/linux/dax.h	2020-01-03 11:20:05.603186062 -0500
@@ -141,7 +141,7 @@ static inline void fs_put_dax(struct dax
 
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
 int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc);
+		struct dax_device *dax_dev, struct writeback_control *wbc);
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
 dax_entry_t dax_lock_page(struct page *page);
@@ -180,7 +180,7 @@ static inline struct page *dax_layout_bu
 }
 
 static inline int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc)
+		struct dax_device *dax_dev, struct writeback_control *wbc)
 {
 	return -EOPNOTSUPP;
 }
Index: rhvgoyal-linux-fuse/fs/xfs/xfs_aops.c
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/xfs/xfs_aops.c	2020-01-03 11:19:59.151186062 -0500
+++ rhvgoyal-linux-fuse/fs/xfs/xfs_aops.c	2020-01-03 11:20:05.605186062 -0500
@@ -587,7 +587,7 @@ xfs_dax_writepages(
 
 	xfs_iflags_clear(ip, XFS_ITRUNCATED);
 	return dax_writeback_mapping_range(mapping,
-			xfs_inode_buftarg(ip)->bt_bdev, wbc);
+			xfs_inode_buftarg(ip)->bt_daxdev, wbc);
 }
 
 STATIC sector_t
Index: rhvgoyal-linux-fuse/fs/ext4/inode.c
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/ext4/inode.c	2020-01-03 11:19:59.151186062 -0500
+++ rhvgoyal-linux-fuse/fs/ext4/inode.c	2020-01-03 11:20:05.606186062 -0500
@@ -2866,7 +2866,7 @@ static int ext4_dax_writepages(struct ad
 	percpu_down_read(&sbi->s_journal_flag_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
-	ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, wbc);
+	ret = dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
 	percpu_up_read(&sbi->s_journal_flag_rwsem);
Index: rhvgoyal-linux-fuse/fs/ext2/inode.c
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/ext2/inode.c	2020-01-03 11:19:59.151186062 -0500
+++ rhvgoyal-linux-fuse/fs/ext2/inode.c	2020-01-03 11:20:05.608186062 -0500
@@ -960,8 +960,9 @@ ext2_writepages(struct address_space *ma
 static int
 ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
-	return dax_writeback_mapping_range(mapping,
-			mapping->host->i_sb->s_bdev, wbc);
+	struct ext2_sb_info *sbi = EXT2_SB(mapping->host->i_sb);
+
+	return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
 }
 
 const struct address_space_operations ext2_aops = {
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
