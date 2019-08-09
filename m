Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF3F88648
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Aug 2019 00:58:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 628D32131BA57;
	Fri,  9 Aug 2019 16:01:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DF72321314743
 for <linux-nvdimm@lists.01.org>; Fri,  9 Aug 2019 16:01:26 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:58:45 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; d="scan'208";a="183030758"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:58:44 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 03/19] mm/gup: Pass flags down to __gup_device_huge*
 calls
Date: Fri,  9 Aug 2019 15:58:17 -0700
Message-Id: <20190809225833.6657-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809225833.6657-1-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
MIME-Version: 1.0
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
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Dave Chinner <david@fromorbit.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Ira Weiny <ira.weiny@intel.com>

In order to support checking for a layout lease on a FS DAX inode these
calls need to know if FOLL_LONGTERM was specified.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/gup.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b6a293bf1267..80423779a50a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1881,7 +1881,8 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 
 #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
 static int __gup_device_huge(unsigned long pfn, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+		unsigned long end, struct page **pages, int *nr,
+		unsigned int flags)
 {
 	int nr_start = *nr;
 	struct dev_pagemap *pgmap = NULL;
@@ -1907,30 +1908,33 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 }
 
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+		unsigned long end, struct page **pages, int *nr,
+		unsigned int flags)
 {
 	unsigned long fault_pfn;
 	int nr_start = *nr;
 
 	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
+	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags))
 		return 0;
 
 	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
 		undo_dev_pagemap(nr, nr_start, pages);
 		return 0;
 	}
+
 	return 1;
 }
 
 static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+		unsigned long end, struct page **pages, int *nr,
+		unsigned int flags)
 {
 	unsigned long fault_pfn;
 	int nr_start = *nr;
 
 	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
+	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags))
 		return 0;
 
 	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
@@ -1941,14 +1945,16 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 }
 #else
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+		unsigned long end, struct page **pages, int *nr,
+		unsigned int flags)
 {
 	BUILD_BUG();
 	return 0;
 }
 
 static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
-		unsigned long end, struct page **pages, int *nr)
+		unsigned long end, struct page **pages, int *nr,
+		unsigned int flags)
 {
 	BUILD_BUG();
 	return 0;
@@ -2051,7 +2057,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (pmd_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
-		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
+		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr,
+					     flags);
 	}
 
 	refs = 0;
@@ -2092,7 +2099,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (pud_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
-		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
+		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr,
+					     flags);
 	}
 
 	refs = 0;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
