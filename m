Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD1933FE08
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Mar 2021 05:08:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2EA5100EB333;
	Wed, 17 Mar 2021 21:08:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 23B73100EB332
	for <linux-nvdimm@lists.01.org>; Wed, 17 Mar 2021 21:08:29 -0700 (PDT)
IronPort-SDR: fBaXo68WzUkvBgKw52zqWyPv3e2CkXBCaNMMw2JvCWdQz4UBLR460cwRA2DJMHCAAbtDOrzXOM
 knrzrk34Bbcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="189688696"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400";
   d="scan'208";a="189688696"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 21:08:28 -0700
IronPort-SDR: hjXuI57s6BARQ8VjuN98OWw1m7Xbz+qmz7WFsT7KZ0Of7ZJkksW36XRaJlvxof+m/4aP+GrUyb
 uP7k9VGqpFwA==
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400";
   d="scan'208";a="372572789"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 21:08:28 -0700
Subject: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org, linux-nvdimm@lists.01.org
Date: Wed, 17 Mar 2021 21:08:28 -0700
Message-ID: <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: LWTCDSIQRJRLK5QM2YEWOVR6H4XKBCME
X-Message-ID-Hash: LWTCDSIQRJRLK5QM2YEWOVR6H4XKBCME
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, akpm@linux-foundation.org, david@fromorbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LWTCDSIQRJRLK5QM2YEWOVR6H4XKBCME/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Now that device-dax and filesystem-dax are guaranteed to unmap all user
mappings of devmap / DAX pages before tearing down the 'struct page'
array, get_user_pages_fast() can rely on its traditional synchronization
method "validate_pte(); get_page(); revalidate_pte()" to catch races with
device shutdown. Specifically the unmap guarantee ensures that gup-fast
either succeeds in taking a page reference (lock-less), or it detects a
need to fall back to the slow path where the device presence can be
revalidated with locks held.

Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/gup.c |   38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e40579624f10..dfeb47e4e8d4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1996,9 +1996,8 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			 unsigned int flags, struct page **pages, int *nr)
 {
-	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
 	pte_t *ptep, *ptem;
+	int ret = 0;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
 	do {
@@ -2015,16 +2014,10 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 			goto pte_unmap;
 
-		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
-				goto pte_unmap;
+		if (pte_devmap(pte) && (flags & FOLL_LONGTERM))
+			goto pte_unmap;
 
-			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
-			if (unlikely(!pgmap)) {
-				undo_dev_pagemap(nr, nr_start, flags, pages);
-				goto pte_unmap;
-			}
-		} else if (pte_special(pte))
+		if (pte_special(pte))
 			goto pte_unmap;
 
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
@@ -2063,8 +2056,6 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 	ret = 1;
 
 pte_unmap:
-	if (pgmap)
-		put_dev_pagemap(pgmap);
 	pte_unmap(ptem);
 	return ret;
 }
@@ -2087,21 +2078,26 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
 #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
+
 static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 			     unsigned long end, unsigned int flags,
 			     struct page **pages, int *nr)
 {
 	int nr_start = *nr;
-	struct dev_pagemap *pgmap = NULL;
 
 	do {
-		struct page *page = pfn_to_page(pfn);
+		struct page *page;
+
+		/*
+		 * Typically pfn_to_page() on a devmap pfn is not safe
+		 * without holding a live reference on the hosting
+		 * pgmap. In the gup-fast path it is safe because any
+		 * races will be resolved by either gup-fast taking a
+		 * reference or the shutdown path unmapping the pte to
+		 * trigger gup-fast to fall back to the slow path.
+		 */
+		page = pfn_to_page(pfn);
 
-		pgmap = get_dev_pagemap(pfn, pgmap);
-		if (unlikely(!pgmap)) {
-			undo_dev_pagemap(nr, nr_start, flags, pages);
-			return 0;
-		}
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		if (unlikely(!try_grab_page(page, flags))) {
@@ -2112,8 +2108,6 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 		pfn++;
 	} while (addr += PAGE_SIZE, addr != end);
 
-	if (pgmap)
-		put_dev_pagemap(pgmap);
 	return 1;
 }
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
