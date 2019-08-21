Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEE3981FD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 19:58:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 506E920213F10;
	Wed, 21 Aug 2019 10:58:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AC8B620212CB8
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 10:58:54 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C1222300BEA4;
 Wed, 21 Aug 2019 17:57:44 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8FC757B6;
 Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id B8C7B223D08; Wed, 21 Aug 2019 13:57:32 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvdimm@lists.01.org
Subject: [PATCH 12/19] fuse, dax: add DAX mmap support
Date: Wed, 21 Aug 2019 13:57:13 -0400
Message-Id: <20190821175720.25901-13-vgoyal@redhat.com>
In-Reply-To: <20190821175720.25901-1-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 21 Aug 2019 17:57:44 +0000 (UTC)
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
Cc: virtio-fs@redhat.com, dgilbert@redhat.com, stefanha@redhat.com,
 miklos@szeredi.hu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Add DAX mmap() support.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/file.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f323b7b04414..32870bb862e7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2730,10 +2730,15 @@ static const struct vm_operations_struct fuse_file_vm_ops = {
 	.page_mkwrite	= fuse_page_mkwrite,
 };
 
+static int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma);
 static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct fuse_file *ff = file->private_data;
 
+	/* DAX mmap is superior to direct_io mmap */
+	if (IS_DAX(file_inode(file)))
+		return fuse_dax_mmap(file, vma);
+
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/* Can't provide the coherency needed for MAP_SHARED */
 		if (vma->vm_flags & VM_MAYSHARE)
@@ -2765,9 +2770,65 @@ static ssize_t fuse_file_splice_read(struct file *in, loff_t *ppos,
 
 }
 
+static int __fuse_dax_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
+			    bool write)
+{
+	vm_fault_t ret;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct super_block *sb = inode->i_sb;
+	pfn_t pfn;
+
+	if (write)
+		sb_start_pagefault(sb);
+
+	/* TODO inode semaphore to protect faults vs truncate */
+
+	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
+
+	if (ret & VM_FAULT_NEEDDSYNC)
+		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
+
+	if (write)
+		sb_end_pagefault(sb);
+
+	return ret;
+}
+
+static vm_fault_t fuse_dax_fault(struct vm_fault *vmf)
+{
+	return __fuse_dax_fault(vmf, PE_SIZE_PTE,
+				vmf->flags & FAULT_FLAG_WRITE);
+}
+
+static vm_fault_t fuse_dax_huge_fault(struct vm_fault *vmf,
+			       enum page_entry_size pe_size)
+{
+	return __fuse_dax_fault(vmf, pe_size, vmf->flags & FAULT_FLAG_WRITE);
+}
+
+static vm_fault_t fuse_dax_page_mkwrite(struct vm_fault *vmf)
+{
+	return __fuse_dax_fault(vmf, PE_SIZE_PTE, true);
+}
+
+static vm_fault_t fuse_dax_pfn_mkwrite(struct vm_fault *vmf)
+{
+	return __fuse_dax_fault(vmf, PE_SIZE_PTE, true);
+}
+
+static const struct vm_operations_struct fuse_dax_vm_ops = {
+	.fault		= fuse_dax_fault,
+	.huge_fault	= fuse_dax_huge_fault,
+	.page_mkwrite	= fuse_dax_page_mkwrite,
+	.pfn_mkwrite	= fuse_dax_pfn_mkwrite,
+};
+
 static int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	return -EINVAL; /* TODO */
+	file_accessed(file);
+	vma->vm_ops = &fuse_dax_vm_ops;
+	vma->vm_flags |= VM_MIXEDMAP | VM_HUGEPAGE;
+	return 0;
 }
 
 static int convert_fuse_file_lock(struct fuse_conn *fc,
@@ -3825,6 +3886,7 @@ static const struct file_operations fuse_file_operations = {
 	.release	= fuse_release,
 	.fsync		= fuse_fsync,
 	.lock		= fuse_file_lock,
+	.get_unmapped_area = thp_get_unmapped_area,
 	.flock		= fuse_file_flock,
 	.splice_read	= fuse_file_splice_read,
 	.splice_write	= iter_file_splice_write,
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
