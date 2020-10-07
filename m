Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FB5286A74
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 23:49:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B5BA61537199E;
	Wed,  7 Oct 2020 14:49:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.65; helo=hqnvemgate26.nvidia.com; envelope-from=rcampbell@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com [216.228.121.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA3191537199E
	for <linux-nvdimm@lists.01.org>; Wed,  7 Oct 2020 14:49:37 -0700 (PDT)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5f7e37e40001>; Wed, 07 Oct 2020 14:49:24 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Oct
 2020 21:49:36 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 7 Oct 2020 21:49:36 +0000
From: Ralph Campbell <rcampbell@nvidia.com>
To: <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
	<linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>
Subject: [PATCH v2] ext4/xfs: add page refcount helper
Date: Wed, 7 Oct 2020 14:49:25 -0700
Message-ID: <20201007214925.11181-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1602107364; bh=REj8QP14NN2VWymC9pd1yxt9jHOscnBs9nwknQCUye0=;
	h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
	b=qVPPzYo5AsUUHwus/S8Ekhyio/IAdtBrC6rBk43gpPR44t506lOgv7FACMlrPcebX
	 ZLxuBFBl+bbjpwzC5xKe3ZNDanoYq3hpP9YuWHoKAUFkpmQzwlZtKUjo5MMT4ltMyS
	 Wduyz1Xy7k+v+rJnc/V1Qw8MiHeuuhrppUxCc/wNr9+xtaawmxmlOPjQKfE8ulelhi
	 XdmOd/vMiAsj5HqRLP3zkooeipjGcmVtyFPw5s1SjWeUqiFWlZt3xkIK7oyDXa8xkr
	 QgaPDWkuP1DQJ2io/rptyAJIfDUGJDOKgktAodAK73J42JSasCWO5KuvnY52qevauN
	 hd7lr9rnqU5jg==
Message-ID-Hash: DCNEN46TY2F5E3EYXYR2KV6XSABNYL3H
X-Message-ID-Hash: DCNEN46TY2F5E3EYXYR2KV6XSABNYL3H
X-MailFrom: rcampbell@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>, Ralph@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DCNEN46TY2F5E3EYXYR2KV6XSABNYL3H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are several places where ZONE_DEVICE struct pages assume a reference
count == 1 means the page is idle and free. Instead of open coding this,
add helper functions to hide this detail.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
Acked-by: Theodore Ts'o <tytso@mit.edu> # for fs/ext4/inode.c
---

Changes in v2:
I strongly resisted the idea of extending this patch but after Jan
Kara's comment about there being more places that could be cleaned
up, I felt compelled to make this one tensy wensy change to add
a dax_wakeup_page() to match the dax_wait_page().
I kept the Reviewed/Acked-bys since I don't think this substantially
changes the patch.

 fs/dax.c            |  4 ++--
 fs/ext4/inode.c     |  5 +----
 fs/xfs/xfs_file.c   |  4 +---
 include/linux/dax.h | 15 +++++++++++++++
 mm/memremap.c       |  3 ++-
 5 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5b47834f2e1b..85c63f735909 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -358,7 +358,7 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
+		WARN_ON_ONCE(trunc && !dax_layout_is_idle_page(page));
 		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
 		page->mapping = NULL;
 		page->index = 0;
@@ -372,7 +372,7 @@ static struct page *dax_busy_page(void *entry)
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		if (page_ref_count(page) > 1)
+		if (!dax_layout_is_idle_page(page))
 			return page;
 	}
 	return NULL;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 771ed8b1fadb..132620cbfa13 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3937,10 +3937,7 @@ int ext4_break_layouts(struct inode *inode)
 		if (!page)
 			return 0;
 
-		error = ___wait_var_event(&page->_refcount,
-				atomic_read(&page->_refcount) == 1,
-				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(ei));
+		error = dax_wait_page(ei, page, ext4_wait_dax_page);
 	} while (error == 0);
 
 	return error;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 3d1b95124744..a5304aaeaa3a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -749,9 +749,7 @@ xfs_break_dax_layouts(
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, xfs_wait_dax_page(inode));
+	return dax_wait_page(inode, page, xfs_wait_dax_page);
 }
 
 int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b52f084aa643..e2da78e87338 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -243,6 +243,21 @@ static inline bool dax_mapping(struct address_space *mapping)
 	return mapping->host && IS_DAX(mapping->host);
 }
 
+static inline bool dax_layout_is_idle_page(struct page *page)
+{
+	return page_ref_count(page) == 1;
+}
+
+static inline void dax_wakeup_page(struct page *page)
+{
+	wake_up_var(&page->_refcount);
+}
+
+#define dax_wait_page(_inode, _page, _wait_cb)				\
+	___wait_var_event(&(_page)->_refcount,				\
+		dax_layout_is_idle_page(_page),				\
+		TASK_INTERRUPTIBLE, 0, 0, _wait_cb(_inode))
+
 #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
 void hmem_register_device(int target_nid, struct resource *r);
 #else
diff --git a/mm/memremap.c b/mm/memremap.c
index 2bb276680837..504a10ff2edf 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/wait_bit.h>
 #include <linux/xarray.h>
+#include <linux/dax.h>
 
 static DEFINE_XARRAY(pgmap_array);
 
@@ -508,7 +509,7 @@ void free_devmap_managed_page(struct page *page)
 {
 	/* notify page idle for dax */
 	if (!is_device_private_page(page)) {
-		wake_up_var(&page->_refcount);
+		dax_wakeup_page(page);
 		return;
 	}
 
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
