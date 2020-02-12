Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6959C15AE17
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Feb 2020 18:08:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D14E710FC317F;
	Wed, 12 Feb 2020 09:11:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F1FD91007B1FC
	for <linux-nvdimm@lists.01.org>; Wed, 12 Feb 2020 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581527274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wp1678TYHxcRdW/SymzuQImvfcwDJWWzwf8rp6Sn0Cc=;
	b=jNAPH0t2hM12FJXvx0RLyrVUjnUQp5CVeM4VQiMoM1F6BeflDYI58WIbyWGHBMBdid8qx0
	VsWqSbCyAZiGDOgti/lH0Q8kazUlW1MgdaeZdiDSwNb99VgncWlgZ8nIn+2vOBzTcet3S+
	IXoirbsii9t8E1CQvRjH35QmmRT9O9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-Lvxy7clxM6SiJcwNjeQDmA-1; Wed, 12 Feb 2020 12:07:50 -0500
X-MC-Unique: Lvxy7clxM6SiJcwNjeQDmA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A23661800D6B;
	Wed, 12 Feb 2020 17:07:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 281445C101;
	Wed, 12 Feb 2020 17:07:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id B29462257D4; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com,
	hch@infradead.org
Subject: [PATCH 2/6] dax,iomap,ext4,ext2,xfs: Save dax_offset in "struct iomap"
Date: Wed, 12 Feb 2020 12:07:29 -0500
Message-Id: <20200212170733.8092-3-vgoyal@redhat.com>
In-Reply-To: <20200212170733.8092-1-vgoyal@redhat.com>
References: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: SNRN5RHTKVUF32IENSMVWRLQWG2VE2H4
X-Message-ID-Hash: SNRN5RHTKVUF32IENSMVWRLQWG2VE2H4
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SNRN5RHTKVUF32IENSMVWRLQWG2VE2H4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a new field "sector_t dax_offset" to "struct iomap". This will be
filled by filesystems and dax code will make use of this to convert
sector into page offset (dax_pgoff()), instead of bdev_dax_pgoff(). This
removes the dependency of having to pass in block device for dax operations.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/ext2/inode.c       | 1 +
 fs/ext4/inode.c       | 1 +
 fs/xfs/xfs_iomap.c    | 2 ++
 include/linux/iomap.h | 1 +
 4 files changed, 5 insertions(+)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index c885cf7d724b..5c3379e78d49 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -823,6 +823,7 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->offset = (u64)first_block << blkbits;
 	iomap->dax_dev = sbi->s_daxdev;
+	iomap->dax_offset = get_start_sect(iomap->bdev);
 
 	if (ret == 0) {
 		iomap->type = IOMAP_HOLE;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1305b810c44a..0ea7fbb8076f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3330,6 +3330,7 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
+	iomap->dax_offset = get_start_sect(iomap->bdev);
 	iomap->offset = (u64) map->m_lblk << blkbits;
 	iomap->length = (u64) map->m_len << blkbits;
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index bb590a267a7f..ad8b18fc96fd 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -80,6 +80,7 @@ xfs_bmbt_to_iomap(
 	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
 	iomap->bdev = target->bt_bdev;
 	iomap->dax_dev = target->bt_daxdev;
+	iomap->dax_offset = get_start_sect(iomap->bdev);
 	iomap->flags = flags;
 
 	if (xfs_ipincount(ip) &&
@@ -103,6 +104,7 @@ xfs_hole_to_iomap(
 	iomap->length = XFS_FSB_TO_B(ip->i_mount, end_fsb - offset_fsb);
 	iomap->bdev = target->bt_bdev;
 	iomap->dax_dev = target->bt_daxdev;
+	iomap->dax_offset = get_start_sect(iomap->bdev);
 }
 
 static inline xfs_fileoff_t
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..cac5d667aa74 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -84,6 +84,7 @@ struct iomap {
 	u16			flags;	/* flags for mapping */
 	struct block_device	*bdev;	/* block device for I/O */
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
+	sector_t		dax_offset; /* offset in dax device */
 	void			*inline_data;
 	void			*private; /* filesystem private */
 	const struct iomap_page_ops *page_ops;
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
