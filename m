Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE12D3114
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:30:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECEDD100EB834;
	Tue,  8 Dec 2020 09:30:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DB567100EB827
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:30:47 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HPdL3083242;
	Tue, 8 Dec 2020 17:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=IPG6ZsD2a9Vym4C7OJ7uGrMcb9WiYMai81wXH8Ceros=;
 b=ItJYq/GAYBlTpQ2+u9W58j+n1sLVJfQUncmsCa4l8a5JA0XzRIhI91E2xhIKrsyojKxy
 CoBIhDGix1VWOQD/F7/Pcj9gM9Y8Sje0ivYHftqDj9mK6SF0O+Jbw24qppTJEQLZx+hQ
 htvuqA9Z79Y3pQCaZqlGbbjVi6P5/1XErtwUfRI1MEz1Gu705eXUlaRGfJRIgbv3QM1o
 1HExNkS3AqgDDNdifWbX0rr/AFbEpFn26VmTVt+XWosGj+EBoYHDFpAmhiIu5I9CQfAA
 BSRj90dpG6f2Vs7mf53V9h948yc6j5fPt4VTClvygM747y9KeJfwsExaA/ieQNLEubOM tw==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 357yqbv4eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 08 Dec 2020 17:30:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HPhk3032074;
	Tue, 8 Dec 2020 17:30:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 358m4y6sv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Dec 2020 17:30:39 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8HUcsQ031614;
	Tue, 8 Dec 2020 17:30:38 GMT
Received: from paddy.uk.oracle.com (/10.175.194.215)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 09:30:37 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 6/9] mm/gup: Grab head page refcount once for group of subpages
Date: Tue,  8 Dec 2020 17:28:58 +0000
Message-Id: <20201208172901.17384-8-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201208172901.17384-1-joao.m.martins@oracle.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=904
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=930
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080107
Message-ID-Hash: EBMRSZF764T2VXMYXD64NZUWT2BFWXNV
X-Message-ID-Hash: EBMRSZF764T2VXMYXD64NZUWT2BFWXNV
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EBMRSZF764T2VXMYXD64NZUWT2BFWXNV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Much like hugetlbfs or THPs, we treat device pagemaps with
compound pages like the rest of GUP handling of compound pages.

Rather than incrementing the refcount every 4K, we record
all sub pages and increment by @refs amount *once*.

Performance measured by gup_benchmark improves considerably
get_user_pages_fast() and pin_user_pages_fast():

 $ gup_benchmark -f /dev/dax0.2 -m 16384 -r 10 -S [-u,-a] -n 512 -w

(get_user_pages_fast 2M pages) ~75k us -> ~3.6k us
(pin_user_pages_fast 2M pages) ~125k us -> ~3.8k us

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/gup.c | 67 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 98eb8e6d2609..194e6981eb03 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2250,22 +2250,68 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
+
+static int record_subpages(struct page *page, unsigned long addr,
+			   unsigned long end, struct page **pages)
+{
+	int nr;
+
+	for (nr = 0; addr != end; addr += PAGE_SIZE)
+		pages[nr++] = page++;
+
+	return nr;
+}
+
 #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static int __gup_device_huge(unsigned long pfn, unsigned long addr,
-			     unsigned long end, unsigned int flags,
-			     struct page **pages, int *nr)
+static int __gup_device_compound_huge(struct dev_pagemap *pgmap,
+				      struct page *head, unsigned long sz,
+				      unsigned long addr, unsigned long end,
+				      unsigned int flags, struct page **pages)
+{
+	struct page *page;
+	int refs;
+
+	if (!(pgmap->flags & PGMAP_COMPOUND))
+		return -1;
+
+	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
+	refs = record_subpages(page, addr, end, pages);
+
+	SetPageReferenced(page);
+	head = try_grab_compound_head(head, refs, flags);
+	if (!head) {
+		ClearPageReferenced(page);
+		return 0;
+	}
+
+	return refs;
+}
+
+static int __gup_device_huge(unsigned long pfn, unsigned long sz,
+			     unsigned long addr, unsigned long end,
+			     unsigned int flags, struct page **pages, int *nr)
 {
 	int nr_start = *nr;
 	struct dev_pagemap *pgmap = NULL;
 
 	do {
 		struct page *page = pfn_to_page(pfn);
+		int refs;
 
 		pgmap = get_dev_pagemap(pfn, pgmap);
 		if (unlikely(!pgmap)) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
 			return 0;
 		}
+
+		refs = __gup_device_compound_huge(pgmap, page, sz, addr, end,
+						  flags, pages + *nr);
+		if (refs >= 0) {
+			*nr += refs;
+			put_dev_pagemap(pgmap);
+			return refs ? 1 : 0;
+		}
+
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		if (unlikely(!try_grab_page(page, flags))) {
@@ -2289,7 +2335,7 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	int nr_start = *nr;
 
 	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
+	if (!__gup_device_huge(fault_pfn, PMD_SHIFT, addr, end, flags, pages, nr))
 		return 0;
 
 	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
@@ -2307,7 +2353,7 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	int nr_start = *nr;
 
 	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
+	if (!__gup_device_huge(fault_pfn, PUD_SHIFT, addr, end, flags, pages, nr))
 		return 0;
 
 	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
@@ -2334,17 +2380,6 @@ static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
 }
 #endif
 
-static int record_subpages(struct page *page, unsigned long addr,
-			   unsigned long end, struct page **pages)
-{
-	int nr;
-
-	for (nr = 0; addr != end; addr += PAGE_SIZE)
-		pages[nr++] = page++;
-
-	return nr;
-}
-
 #ifdef CONFIG_ARCH_HAS_HUGEPD
 static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 				      unsigned long sz)
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
