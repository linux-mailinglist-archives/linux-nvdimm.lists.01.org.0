Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B62302F83
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 Jan 2021 23:55:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D734100EBBD7;
	Mon, 25 Jan 2021 14:55:50 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 45C37100EBBDA
	for <linux-nvdimm@lists.01.org>; Mon, 25 Jan 2021 14:55:47 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.79,374,1602518400";
   d="scan'208";a="103820587"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Jan 2021 06:55:45 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
	by cn.fujitsu.com (Postfix) with ESMTP id 143E24CE6014;
	Tue, 26 Jan 2021 06:55:42 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 26 Jan 2021 06:55:41 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 26 Jan 2021 06:55:40 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
Subject: [PATCH v2 10/10] fs/dax: Remove useless functions
Date: Tue, 26 Jan 2021 06:55:26 +0800
Message-ID: <20210125225526.1048877-11-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125225526.1048877-1-ruansy.fnst@cn.fujitsu.com>
References: <20210125225526.1048877-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 143E24CE6014.ACA70
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: IFGVWT45H6LJ2JWB26BQTRQGDVUVSTXW
X-Message-ID-Hash: IFGVWT45H6LJ2JWB26BQTRQGDVUVSTXW
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IFGVWT45H6LJ2JWB26BQTRQGDVUVSTXW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since owner tarcking is triggerred by pmem device, these functions are
useless.  So remove it.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c | 46 ----------------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index c64c3a0e76a6..e20a5df03eec 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -323,48 +323,6 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
-/*
- * TODO: for reflink+dax we need a way to associate a single page with
- * multiple address_space instances at different linear_page_index()
- * offsets.
- */
-static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address)
-{
-	unsigned long size = dax_entry_size(entry), pfn, index;
-	int i = 0;
-
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
-	index = linear_page_index(vma, address & ~(size - 1));
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		WARN_ON_ONCE(page->mapping);
-		page->mapping = mapping;
-		page->index = index + i++;
-	}
-}
-
-static void dax_disassociate_entry(void *entry, struct address_space *mapping,
-		bool trunc)
-{
-	unsigned long pfn;
-
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
-		page->mapping = NULL;
-		page->index = 0;
-	}
-}
-
 static struct page *dax_busy_page(void *entry)
 {
 	unsigned long pfn;
@@ -543,7 +501,6 @@ static void *grab_mapping_entry(struct xa_state *xas,
 			xas_lock_irq(xas);
 		}
 
-		dax_disassociate_entry(entry, mapping, false);
 		xas_store(xas, NULL);	/* undo the PMD join */
 		dax_wake_entry(xas, entry, true);
 		mapping->nrexceptional--;
@@ -680,7 +637,6 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	    (xas_get_mark(&xas, PAGECACHE_TAG_DIRTY) ||
 	     xas_get_mark(&xas, PAGECACHE_TAG_TOWRITE)))
 		goto out;
-	dax_disassociate_entry(entry, mapping, trunc);
 	xas_store(&xas, NULL);
 	mapping->nrexceptional--;
 	ret = 1;
@@ -774,8 +730,6 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
-		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
-- 
2.30.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
