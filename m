Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961A312FC9
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 11:55:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 902B7100EB323;
	Mon,  8 Feb 2021 02:55:46 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 87246100EB322
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 02:55:42 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,161,1610380800";
   d="scan'208";a="104328061"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Feb 2021 18:55:40 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id F265F4CE6F7F;
	Mon,  8 Feb 2021 18:55:39 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 8 Feb 2021 18:55:42 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 18:55:41 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
Subject: [PATCH v3 06/11] mm, pmem: Implement ->memory_failure() in pmem driver
Date: Mon, 8 Feb 2021 18:55:25 +0800
Message-ID: <20210208105530.3072869-7-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: F265F4CE6F7F.A023F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: KOTDYBQALKPKWUGARPAQGPB32IIF4HV5
X-Message-ID-Hash: KOTDYBQALKPKWUGARPAQGPB32IIF4HV5
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, agk@redhat.com, snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KOTDYBQALKPKWUGARPAQGPB32IIF4HV5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Call the ->memory_failure() which is implemented by pmem driver, in
order to finally notify filesystem to handle the corrupted data.  The
handler which collects and kills processes are moved into
mf_dax_mapping_kill_procs(), which will be called by filesystem.

Keep the old handler in order to roll back if driver/device/filesystem
does not support ->memory_failure()/->corrupted_range().

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 drivers/nvdimm/pmem.c |  26 +++++++++++
 mm/memory-failure.c   | 102 +++++++++++++++++++++++++-----------------
 2 files changed, 87 insertions(+), 41 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 875076b0ea6c..c77c80e3d155 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -363,9 +363,35 @@ static void pmem_release_disk(void *__pmem)
 	put_disk(pmem->disk);
 }
 
+static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
+		unsigned long pfn, int flags)
+{
+	struct pmem_device *pdev;
+	struct gendisk *disk;
+	loff_t disk_offset;
+	int rc = 0;
+	unsigned long size = page_size(pfn_to_page(pfn));
+
+	pdev = container_of(pgmap, struct pmem_device, pgmap);
+	disk = pdev->disk;
+	if (!disk)
+		return -ENXIO;
+
+	disk_offset = PFN_PHYS(pfn) - pdev->phys_addr - pdev->data_offset;
+	if (disk->fops->corrupted_range) {
+		rc = disk->fops->corrupted_range(disk, NULL, disk_offset,
+						 size, &flags);
+		if (rc == -ENODEV)
+			rc = -ENXIO;
+	} else
+		rc = -EOPNOTSUPP;
+	return rc;
+}
+
 static const struct dev_pagemap_ops fsdax_pagemap_ops = {
 	.kill			= pmem_pagemap_kill,
 	.cleanup		= pmem_pagemap_cleanup,
+	.memory_failure		= pmem_pagemap_memory_failure,
 };
 
 static int pmem_attach_disk(struct device *dev,
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 158fe0c8e602..670e29cd263e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1219,6 +1219,54 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
 	return 0;
 }
 
+int mf_generic_kill_procs(unsigned long long pfn, int flags)
+{
+	struct page *page = pfn_to_page(pfn);
+	const bool unmap_success = true;
+	unsigned long size = 0;
+	struct to_kill *tk;
+	LIST_HEAD(to_kill);
+	loff_t start;
+	dax_entry_t cookie;
+
+	/*
+	 * Prevent the inode from being freed while we are interrogating
+	 * the address_space, typically this would be handled by
+	 * lock_page(), but dax pages do not use the page lock. This
+	 * also prevents changes to the mapping of this pfn until
+	 * poison signaling is complete.
+	 */
+	cookie = dax_lock_page(page);
+	if (!cookie)
+		return -EBUSY;
+	/*
+	 * Unlike System-RAM there is no possibility to swap in a
+	 * different physical page at a given virtual address, so all
+	 * userspace consumption of ZONE_DEVICE memory necessitates
+	 * SIGBUS (i.e. MF_MUST_KILL)
+	 */
+	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
+	collect_procs(page, &to_kill, flags & MF_ACTION_REQUIRED);
+
+	list_for_each_entry(tk, &to_kill, nd)
+		if (tk->size_shift)
+			size = max(size, 1UL << tk->size_shift);
+	if (size) {
+		/*
+		 * Unmap the largest mapping to avoid breaking up
+		 * device-dax mappings which are constant size. The
+		 * actual size of the mapping being torn down is
+		 * communicated in siginfo, see kill_proc()
+		 */
+		start = (page->index << PAGE_SHIFT) & ~(size - 1);
+		unmap_mapping_range(page->mapping, start, start + size, 0);
+	}
+	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
+
+	dax_unlock_page(page, cookie);
+	return 0;
+}
+
 int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags)
 {
 	const bool unmap_success = true;
@@ -1343,13 +1391,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
 	struct page *page = pfn_to_page(pfn);
-	const bool unmap_success = true;
-	unsigned long size = 0;
-	struct to_kill *tk;
-	LIST_HEAD(to_kill);
 	int rc = -EBUSY;
-	loff_t start;
-	dax_entry_t cookie;
 
 	if (flags & MF_COUNT_INCREASED)
 		/*
@@ -1357,20 +1399,9 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		 */
 		put_page(page);
 
-	/*
-	 * Prevent the inode from being freed while we are interrogating
-	 * the address_space, typically this would be handled by
-	 * lock_page(), but dax pages do not use the page lock. This
-	 * also prevents changes to the mapping of this pfn until
-	 * poison signaling is complete.
-	 */
-	cookie = dax_lock_page(page);
-	if (!cookie)
-		goto out;
-
 	if (hwpoison_filter(page)) {
 		rc = 0;
-		goto unlock;
+		goto out;
 	}
 
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
@@ -1378,7 +1409,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		 * TODO: Handle HMM pages which may need coordination
 		 * with device-side memory.
 		 */
-		goto unlock;
+		goto out;
 	}
 
 	/*
@@ -1388,32 +1419,21 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	SetPageHWPoison(page);
 
 	/*
-	 * Unlike System-RAM there is no possibility to swap in a
-	 * different physical page at a given virtual address, so all
-	 * userspace consumption of ZONE_DEVICE memory necessitates
-	 * SIGBUS (i.e. MF_MUST_KILL)
+	 * Call driver's implementation to handle the memory failure,
+	 * otherwise roll back to generic handler.
 	 */
-	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs_file(page, page->mapping, page->index, &to_kill,
-			   flags & MF_ACTION_REQUIRED);
-
-	list_for_each_entry(tk, &to_kill, nd)
-		if (tk->size_shift)
-			size = max(size, 1UL << tk->size_shift);
-	if (size) {
+	if (pgmap->ops->memory_failure) {
+		rc = pgmap->ops->memory_failure(pgmap, pfn, flags);
 		/*
-		 * Unmap the largest mapping to avoid breaking up
-		 * device-dax mappings which are constant size. The
-		 * actual size of the mapping being torn down is
-		 * communicated in siginfo, see kill_proc()
+		 * Roll back to generic handler too if operation is not
+		 * supported inside the driver/device/filesystem.
 		 */
-		start = (page->index << PAGE_SHIFT) & ~(size - 1);
-		unmap_mapping_range(page->mapping, start, start + size, 0);
+		if (rc != EOPNOTSUPP)
+			goto out;
 	}
-	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
-	rc = 0;
-unlock:
-	dax_unlock_page(page, cookie);
+
+	rc = mf_generic_kill_procs(pfn, flags);
+
 out:
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);
-- 
2.30.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
