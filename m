Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 792CA379D72
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 May 2021 05:10:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 31EBC100EB83E;
	Mon, 10 May 2021 20:10:09 -0700 (PDT)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 8CB22100EB82F
	for <linux-nvdimm@lists.01.org>; Mon, 10 May 2021 20:10:06 -0700 (PDT)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ah6/KB6w18dSo8UouYdzgKrPwyr1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SK2lfqeV7Y0mPH7P+U4ssR4b6LO90cW7Lk80sKQFhbX5Xo3SOjUO2l?=
 =?us-ascii?q?HYTr2KhLGKq1aLdkHDH6xmpMBdmsNFaOEYY2IVsS+D2njcLz8/+qj6zImYwffZ?=
 =?us-ascii?q?02x2TRxnL4Vp7wJCAA6dFUFsLTM2f6YRJd6N4NZdvTq8dTAyZsS/PHMMWO/OvJ?=
 =?us-ascii?q?nlj5TjCCR2eiIP2U2fiy+y8r7mH1y91hcaaTlGxrAv6izkvmXCl96ej80=3D?=
X-IronPort-AV: E=Sophos;i="5.82,290,1613404800";
   d="scan'208";a="108110547"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 May 2021 11:10:05 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 04FF54D0BA7A;
	Tue, 11 May 2021 11:10:01 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 11 May 2021 11:09:52 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 11 May 2021 11:09:49 +0800
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
Date: Tue, 11 May 2021 11:09:29 +0800
Message-ID: <20210511030933.3080921-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 04FF54D0BA7A.A2DDA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Message-ID-Hash: GOCXM62IEWAEIDUWH4HBT27P74S5IZL4
X-Message-ID-Hash: GOCXM62IEWAEIDUWH4HBT27P74S5IZL4
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: darrick.wong@oracle.com, willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GOCXM62IEWAEIDUWH4HBT27P74S5IZL4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Punch hole on a reflinked file needs dax_copy_edge() too.  Otherwise,
data in not aligned area will be not correct.  So, add the srcmap to
dax_iomap_zero() and replace memset() as dax_copy_edge().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/dax.c               | 25 +++++++++++++++----------
 fs/iomap/buffered-io.c |  2 +-
 include/linux/dax.h    |  3 ++-
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index ef0e564e7904..ee9d28a79bfb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1186,7 +1186,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #endif /* CONFIG_FS_DAX_PMD */
 
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
+s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
@@ -1208,19 +1209,23 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 
 	if (page_aligned)
 		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
-	else
+	else {
 		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
-	if (rc < 0) {
-		dax_read_unlock(id);
-		return rc;
-	}
-
-	if (!page_aligned) {
-		memset(kaddr + offset, 0, size);
+		if (rc < 0)
+			goto out;
+		if (iomap->addr != srcmap->addr) {
+			rc = dax_iomap_cow_copy(offset, size, PAGE_SIZE, srcmap,
+						kaddr);
+			if (rc < 0)
+				goto out;
+		} else
+			memset(kaddr + offset, 0, size);
 		dax_flush(iomap->dax_dev, kaddr + offset, size);
 	}
+
+out:
 	dax_read_unlock(id);
-	return size;
+	return rc < 0 ? rc : size;
 }
 
 static loff_t
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f2cd2034a87b..2734955ea67f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -933,7 +933,7 @@ static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
 		s64 bytes;
 
 		if (IS_DAX(inode))
-			bytes = dax_iomap_zero(pos, length, iomap);
+			bytes = dax_iomap_zero(pos, length, iomap, srcmap);
 		else
 			bytes = iomap_zero(inode, pos, length, iomap, srcmap);
 		if (bytes < 0)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b52f084aa643..3275e01ed33d 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -237,7 +237,8 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
+s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
+		struct iomap *srcmap);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
-- 
2.31.1


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
