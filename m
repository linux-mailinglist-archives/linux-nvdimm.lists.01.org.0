Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 934321795ED
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 17:59:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 77A6D10FC377C;
	Wed,  4 Mar 2020 09:00:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 81C7710FC36DC
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583341158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIopJzsj++aiDVq7oYzrBdYDChpfyNBom1aJNIGl0sw=;
	b=Aa2uuZipMAbySWatcHLgxvlDTbAPzk+dLrMYdlN0/zIq5BvBpqZkOMmfaxKpqZHkaGgXuH
	UiULEAl3I9bMB+VWYFCgmErHymiIcB1AC00z7aq45m96oIZapatOAewuq1esFLIMXqfUnj
	7KvPxQ5SfiMAejEa0DVzXTTVF+Vkj7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-wFV-Go8GO2GAbrAt-RA3HQ-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: wFV-Go8GO2GAbrAt-RA3HQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51C12107ACC9;
	Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 293AA60FC2;
	Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 7CA0A225815; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH 15/20] fuse, dax: Take ->i_mmap_sem lock during dax page fault
Date: Wed,  4 Mar 2020 11:58:40 -0500
Message-Id: <20200304165845.3081-16-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: FXB7HSIWMPEB2QIPA3TNJZYJF36ISDNI
X-Message-ID-Hash: FXB7HSIWMPEB2QIPA3TNJZYJF36ISDNI
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FXB7HSIWMPEB2QIPA3TNJZYJF36ISDNI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We need some kind of locking mechanism here. Normal file systems like
ext4 and xfs seems to take their own semaphore to protect agains
truncate while fault is going on.

We have additional requirement to protect against fuse dax memory range
reclaim. When a range has been selected for reclaim, we need to make sure
no other read/write/fault can try to access that memory range while
reclaim is in progress. Once reclaim is complete, lock will be released
and read/write/fault will trigger allocation of fresh dax range.

Taking inode_lock() is not an option in fault path as lockdep complains
about circular dependencies. So define a new fuse_inode->i_mmap_sem.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dir.c    |  2 ++
 fs/fuse/file.c   | 15 ++++++++++++---
 fs/fuse/fuse_i.h |  7 +++++++
 fs/fuse/inode.c  |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index de1e2fde60bd..ad699a60ec03 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1609,8 +1609,10 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	 */
 	if ((is_truncate || !is_wb) &&
 	    S_ISREG(inode->i_mode) && oldsize != outarg.attr.size) {
+		down_write(&fi->i_mmap_sem);
 		truncate_pagecache(inode, outarg.attr.size);
 		invalidate_inode_pages2(inode->i_mapping);
+		up_write(&fi->i_mmap_sem);
 	}
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 303496e6617f..ab56396cf661 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2907,11 +2907,18 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
 
 	if (write)
 		sb_start_pagefault(sb);
-
+	/*
+	 * We need to serialize against not only truncate but also against
+	 * fuse dax memory range reclaim. While a range is being reclaimed,
+	 * we do not want any read/write/mmap to make progress and try
+	 * to populate page cache or access memory we are trying to free.
+	 */
+	down_read(&get_fuse_inode(inode)->i_mmap_sem);
 	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
 
 	if (ret & VM_FAULT_NEEDDSYNC)
 		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
+	up_read(&get_fuse_inode(inode)->i_mmap_sem);
 
 	if (write)
 		sb_end_pagefault(sb);
@@ -3869,9 +3876,11 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 			file_update_time(file);
 	}
 
-	if (mode & FALLOC_FL_PUNCH_HOLE)
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		down_write(&fi->i_mmap_sem);
 		truncate_pagecache_range(inode, offset, offset + length - 1);
-
+		up_write(&fi->i_mmap_sem);
+	}
 	fuse_invalidate_attr(inode);
 
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 490549862bda..3fea84411401 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -186,6 +186,13 @@ struct fuse_inode {
 	 */
 	struct rw_semaphore i_dmap_sem;
 
+	/**
+	 * Can't take inode lock in fault path (leads to circular dependency).
+	 * So take this in fuse dax fault path to make sure truncate and
+	 * punch hole etc. can't make progress in parallel.
+	 */
+	struct rw_semaphore i_mmap_sem;
+
 	/** Sorted rb tree of struct fuse_dax_mapping elements */
 	struct rb_root_cached dmap_tree;
 	unsigned long nr_dmaps;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 93bc65607a15..abc881e6acb0 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -88,6 +88,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->state = 0;
 	fi->nr_dmaps = 0;
 	mutex_init(&fi->mutex);
+	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_dmap_sem);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
