Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD67A091A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Aug 2019 19:58:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56AD420218C5A;
	Wed, 28 Aug 2019 11:00:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B10B620215F45
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 11:00:49 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 280B9107DD00;
 Wed, 28 Aug 2019 17:58:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6668E5D9E2;
 Wed, 28 Aug 2019 17:58:44 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id EB41B2206F5; Wed, 28 Aug 2019 13:58:43 -0400 (EDT)
Date: Wed, 28 Aug 2019 13:58:43 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20190828175843.GB912@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org>
 <20190827163828.GA6859@redhat.com>
 <20190828065809.GA27426@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190828065809.GA27426@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Wed, 28 Aug 2019 17:58:49 +0000 (UTC)
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
Cc: linux-nvdimm@lists.01.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org,
 dgilbert@redhat.com, virtio-fs@redhat.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 27, 2019 at 11:58:09PM -0700, Christoph Hellwig wrote:
> On Tue, Aug 27, 2019 at 12:38:28PM -0400, Vivek Goyal wrote:
> > > For bdev_dax_pgoff
> > > I'd much rather have the partition offset if there is on in the daxdev
> > > somehow so that we can get rid of the block device entirely.
> > 
> > IIUC, there is one block_device per partition while there is only one
> > dax_device for the whole disk. So we can't directly move bdev logical
> > offset into dax_device.
> 
> Well, then we need to find a way to get partitions for dax devices,
> as we really should not expect a block device hiding behind a dax
> dev.  That is just a weird legacy assumption - block device need to
> layer on top of the dax device optionally.
> 
> > 
> > We probably could put this in "iomap" and leave it to filesystems to
> > report offset into dax_dev in iomap that way dax generic code does not
> > have to deal with it. But that probably will be a bigger change.
> 
> And where would the file system get that information from?

File system knows about block device, can it just call get_start_sect()
while filling iomap->addr. And this means we don't have to have
parition information in dax device. Will something like following work?
(Just a proof of concept patch).


---
 drivers/dax/super.c |   11 +++++++++++
 fs/dax.c            |    6 +++---
 fs/ext4/inode.c     |    6 +++++-
 include/linux/dax.h |    1 +
 4 files changed, 20 insertions(+), 4 deletions(-)

Index: rhvgoyal-linux/fs/ext4/inode.c
===================================================================
--- rhvgoyal-linux.orig/fs/ext4/inode.c	2019-08-28 13:51:16.051937204 -0400
+++ rhvgoyal-linux/fs/ext4/inode.c	2019-08-28 13:51:44.453937204 -0400
@@ -3589,7 +3589,11 @@ retry:
 			WARN_ON_ONCE(1);
 			return -EIO;
 		}
-		iomap->addr = (u64)map.m_pblk << blkbits;
+		if (IS_DAX(inode))
+			iomap->addr = ((u64)map.m_pblk << blkbits) +
+				      (get_start_sect(iomap->bdev) * 512);
+		else
+			iomap->addr = (u64)map.m_pblk << blkbits;
 	}
 
 	if (map.m_flags & EXT4_MAP_NEW)
Index: rhvgoyal-linux/fs/dax.c
===================================================================
--- rhvgoyal-linux.orig/fs/dax.c	2019-08-28 13:51:16.051937204 -0400
+++ rhvgoyal-linux/fs/dax.c	2019-08-28 13:51:44.457937204 -0400
@@ -688,7 +688,7 @@ static int copy_user_dax(struct block_de
 	long rc;
 	int id;
 
-	rc = bdev_dax_pgoff(bdev, sector, size, &pgoff);
+	rc = dax_pgoff(sector, size, &pgoff);
 	if (rc)
 		return rc;
 
@@ -995,7 +995,7 @@ static int dax_iomap_pfn(struct iomap *i
 	int id, rc;
 	long length;
 
-	rc = bdev_dax_pgoff(iomap->bdev, sector, size, &pgoff);
+	rc = dax_pgoff(sector, size, &pgoff);
 	if (rc)
 		return rc;
 	id = dax_read_lock();
@@ -1137,7 +1137,7 @@ dax_iomap_actor(struct inode *inode, lof
 			break;
 		}
 
-		ret = bdev_dax_pgoff(bdev, sector, size, &pgoff);
+		ret = dax_pgoff(sector, size, &pgoff);
 		if (ret)
 			break;
 
Index: rhvgoyal-linux/drivers/dax/super.c
===================================================================
--- rhvgoyal-linux.orig/drivers/dax/super.c	2019-08-28 13:51:51.802937204 -0400
+++ rhvgoyal-linux/drivers/dax/super.c	2019-08-28 13:51:56.905937204 -0400
@@ -43,6 +43,17 @@ EXPORT_SYMBOL_GPL(dax_read_unlock);
 #ifdef CONFIG_BLOCK
 #include <linux/blkdev.h>
 
+int dax_pgoff(sector_t sector, size_t size, pgoff_t *pgoff)
+{
+	phys_addr_t phys_off = sector * 512;
+
+	if (pgoff)
+		*pgoff = PHYS_PFN(phys_off);
+	if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
+		return -EINVAL;
+	return 0;
+}
+
 int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
 		pgoff_t *pgoff)
 {
Index: rhvgoyal-linux/include/linux/dax.h
===================================================================
--- rhvgoyal-linux.orig/include/linux/dax.h	2019-08-28 13:51:51.802937204 -0400
+++ rhvgoyal-linux/include/linux/dax.h	2019-08-28 13:51:56.908937204 -0400
@@ -111,6 +111,7 @@ static inline bool daxdev_mapping_suppor
 
 struct writeback_control;
 int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
+int dax_pgoff(sector_t, size_t, pgoff_t *pgoff);
 #if IS_ENABLED(CONFIG_FS_DAX)
 bool __bdev_dax_supported(struct block_device *bdev, int blocksize);
 static inline bool bdev_dax_supported(struct block_device *bdev, int blocksize)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
