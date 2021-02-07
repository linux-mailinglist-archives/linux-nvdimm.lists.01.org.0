Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2831262E
	for <lists+linux-nvdimm@lfdr.de>; Sun,  7 Feb 2021 18:09:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CAFC0100EBB7D;
	Sun,  7 Feb 2021 09:09:38 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 326CA100EBB6F
	for <linux-nvdimm@lists.01.org>; Sun,  7 Feb 2021 09:09:35 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800";
   d="scan'208";a="104299366"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Feb 2021 01:09:32 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
	by cn.fujitsu.com (Postfix) with ESMTP id A5EAA4CE6F78;
	Mon,  8 Feb 2021 01:09:31 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 8 Feb 2021 01:09:32 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 01:09:33 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 3/7] fsdax: Copy data before write
Date: Mon, 8 Feb 2021 01:09:20 +0800
Message-ID: <20210207170924.2933035-4-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: A5EAA4CE6F78.AEB4A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: VCBQMJB35E6CNG77CKGTZRQVWF3UWWOB
X-Message-ID-Hash: VCBQMJB35E6CNG77CKGTZRQVWF3UWWOB
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VCBQMJB35E6CNG77CKGTZRQVWF3UWWOB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add dax_copy_edges() into each dax actor functions to perform CoW.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index ea4e8a434900..b2195cbdf2dc 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1161,7 +1161,8 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			return iov_iter_zero(min(length, end - pos), iter);
 	}
 
-	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
+	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
+			!(iomap->flags & IOMAP_F_SHARED)))
 		return -EIO;
 
 	/*
@@ -1200,6 +1201,12 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			break;
 		}
 
+		if (iomap != srcmap) {
+			ret = dax_copy_edges(pos, length, srcmap, kaddr, false);
+			if (ret)
+				break;
+		}
+
 		map_len = PFN_PHYS(map_len);
 		kaddr += offset;
 		map_len -= offset;
@@ -1311,6 +1318,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	vm_fault_t ret = 0;
 	void *entry;
 	pfn_t pfn;
+	void *kaddr;
 
 	trace_dax_pte_fault(inode, vmf, ret);
 	/*
@@ -1392,19 +1400,27 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 	switch (iomap.type) {
 	case IOMAP_MAPPED:
+cow:
 		if (iomap.flags & IOMAP_F_NEW) {
 			count_vm_event(PGMAJFAULT);
 			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
 			major = VM_FAULT_MAJOR;
 		}
 		error = dax_iomap_direct_access(&iomap, pos, PAGE_SIZE,
-						NULL, &pfn);
+						&kaddr, &pfn);
 		if (error < 0)
 			goto error_finish_iomap;
 
 		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
 						 0, write && !sync);
 
+		if (srcmap.type != IOMAP_HOLE) {
+			error = dax_copy_edges(pos, PAGE_SIZE, &srcmap, kaddr,
+					       false);
+			if (error)
+				goto error_finish_iomap;
+		}
+
 		/*
 		 * If we are doing synchronous page fault and inode needs fsync,
 		 * we can insert PTE into page tables only after that happens.
@@ -1428,6 +1444,9 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 		goto finish_iomap;
 	case IOMAP_UNWRITTEN:
+		if (write && iomap.flags & IOMAP_F_SHARED)
+			goto cow;
+		fallthrough;
 	case IOMAP_HOLE:
 		if (!write) {
 			ret = dax_load_hole(&xas, mapping, &entry, vmf);
@@ -1535,6 +1554,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	loff_t pos;
 	int error;
 	pfn_t pfn;
+	void *kaddr;
 
 	/*
 	 * Check whether offset isn't beyond end of file now. Caller is
@@ -1616,14 +1636,22 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 	switch (iomap.type) {
 	case IOMAP_MAPPED:
+cow:
 		error = dax_iomap_direct_access(&iomap, pos, PMD_SIZE,
-						NULL, &pfn);
+						&kaddr, &pfn);
 		if (error < 0)
 			goto finish_iomap;
 
 		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
 						DAX_PMD, write && !sync);
 
+		if (srcmap.type != IOMAP_HOLE) {
+			error = dax_copy_edges(pos, PMD_SIZE, &srcmap, kaddr,
+					       true);
+			if (error)
+				goto unlock_entry;
+		}
+
 		/*
 		 * If we are doing synchronous page fault and inode needs fsync,
 		 * we can insert PMD into page tables only after that happens.
@@ -1642,6 +1670,9 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		result = vmf_insert_pfn_pmd(vmf, pfn, write);
 		break;
 	case IOMAP_UNWRITTEN:
+		if (write && iomap.flags & IOMAP_F_SHARED)
+			goto cow;
+		fallthrough;
 	case IOMAP_HOLE:
 		if (WARN_ON_ONCE(write))
 			break;
-- 
2.30.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
