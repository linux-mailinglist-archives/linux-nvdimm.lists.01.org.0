Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CAF23EDD6
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Aug 2020 15:13:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9294712C2F615;
	Fri,  7 Aug 2020 06:13:55 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id DEECC12C2F603
	for <linux-nvdimm@lists.01.org>; Fri,  7 Aug 2020 06:13:49 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.75,445,1589212800";
   d="scan'208";a="97774925"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Aug 2020 21:13:48 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 6F1EC4CE34F1;
	Fri,  7 Aug 2020 21:13:44 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 7 Aug 2020 21:13:40 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 7 Aug 2020 21:13:38 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>
Subject: [RFC PATCH 3/8] fsdax: introduce dax_copy_edges() for COW
Date: Fri, 7 Aug 2020 21:13:31 +0800
Message-ID: <20200807131336.318774-4-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 6F1EC4CE34F1.ACA37
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: 3L7NRJDN3XFFVFJXYWPBV3TR2HPRYIT7
X-Message-ID-Hash: 3L7NRJDN3XFFVFJXYWPBV3TR2HPRYIT7
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3L7NRJDN3XFFVFJXYWPBV3TR2HPRYIT7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add address output in dax_iomap_pfn() in order to perform a memcpy() in CoW
case.  Since this function both output address and pfn, rename it to
dax_iomap_direct_access().

dax_copy_edges() is a helper functions performs a copy from one part of
the device to another for data not page aligned.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 47380f75ef38..308678c58d4d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1043,8 +1043,8 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
 }
 
-static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
-			 pfn_t *pfnp)
+static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
+			 pfn_t *pfnp, void **addr)
 {
 	const sector_t sector = dax_iomap_sector(iomap, pos);
 	pgoff_t pgoff;
@@ -1055,12 +1055,14 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
 	if (rc)
 		return rc;
 	id = dax_read_lock();
-	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
-				   NULL, pfnp);
+	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size), addr,
+				   pfnp);
 	if (length < 0) {
 		rc = length;
 		goto out;
 	}
+	if (!pfnp)
+		goto out_check_addr;
 	rc = -EINVAL;
 	if (PFN_PHYS(length) < size)
 		goto out;
@@ -1070,11 +1072,59 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
 	if (length > 1 && !pfn_t_devmap(*pfnp))
 		goto out;
 	rc = 0;
+
+out_check_addr:
+	if (!addr)
+		goto out;
+	if (!*addr)
+		rc = -EFAULT;
 out:
 	dax_read_unlock(id);
 	return rc;
 }
 
+/*
+ * dax_copy_edges - Copies the part of the pages not included in
+ *		    the write, but required for CoW because
+ *		    offset/offset+length are not page aligned.
+ */
+static int dax_copy_edges(loff_t pos, loff_t length, struct iomap *srcmap,
+			  void *daddr, bool pmd)
+{
+	size_t page_size = pmd ? PMD_SIZE : PAGE_SIZE;
+	loff_t offset = pos & (page_size - 1);
+	size_t size = ALIGN(offset + length, page_size);
+	loff_t end = pos + length;
+	loff_t pg_end = round_up(end, page_size);
+	void *saddr = 0;
+	int ret = 0;
+
+	ret = dax_iomap_direct_access(srcmap, pos, size, NULL, &saddr);
+	if (ret)
+		return ret;
+	/*
+	 * Copy the first part of the page
+	 * Note: we pass offset as length
+	 */
+	if (offset) {
+		if (saddr)
+			ret = memcpy_mcsafe(daddr, saddr, offset);
+		else
+			memset(daddr, 0, offset);
+	}
+
+	/* Copy the last part of the range */
+	if (end < pg_end) {
+		if (saddr)
+			ret = memcpy_mcsafe(daddr + offset + length,
+			       saddr + offset + length,	pg_end - end);
+		else
+			memset(daddr + offset + length, 0,
+					pg_end - end);
+	}
+	return ret;
+}
+
 /*
  * The user has performed a load from a hole in the file.  Allocating a new
  * page in the file would cause excessive storage usage for workloads with
@@ -1394,7 +1444,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
 			major = VM_FAULT_MAJOR;
 		}
-		error = dax_iomap_pfn(&iomap, pos, PAGE_SIZE, &pfn);
+		error = dax_iomap_direct_access(&iomap, pos, PAGE_SIZE, &pfn,
+						NULL);
 		if (error < 0)
 			goto error_finish_iomap;
 
@@ -1612,7 +1663,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 	switch (iomap.type) {
 	case IOMAP_MAPPED:
-		error = dax_iomap_pfn(&iomap, pos, PMD_SIZE, &pfn);
+		error = dax_iomap_direct_access(&iomap, pos, PMD_SIZE, &pfn,
+						NULL);
 		if (error < 0)
 			goto finish_iomap;
 
-- 
2.27.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
