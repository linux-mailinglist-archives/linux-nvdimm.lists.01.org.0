Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF2A2D3112
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:30:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AF325100EB82F;
	Tue,  8 Dec 2020 09:30:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5025D100EB82C
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:30:42 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HNtEn191622;
	Tue, 8 Dec 2020 17:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=0kzwvkTGsVJKtEUrLZS4ix2by6zECgpKyc1dxPfDV8c=;
 b=pVCebdJtzI9QUzQ0H//+uylhQf6y3korcYr11DucMDxpH+BuW08f3LKVPVBmJsuafB3Y
 wUGJ38psjy6Jt5SifSt1xS0fPg1JVY1HGXUGPNzml5nclfLJLsVDvRDgvPxyWrB+AZof
 QyjWZ6sMqF363NoLPWWRoCwtBl4wtgJSo95efXD5d8qHxwiXLoiV/QuEm4k+YCm+5uKC
 /QlJMiNd8Uca9VZRN3AuDk02zWGPa1dnSMGTAyKF3wHOO+EmU8B6dWhF+ZgyxscvQwYn
 QsHk0Mt+nOpnVLiETG5xVDj6IiMcFchAkFmE1P69uIAwRsGGa/Psq5yDL9PrcylE71U7 xw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 3581mqv005-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 08 Dec 2020 17:30:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HOVhQ195364;
	Tue, 8 Dec 2020 17:30:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 358m3y2fca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Dec 2020 17:30:33 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B8HUVZk004537;
	Tue, 8 Dec 2020 17:30:31 GMT
Received: from paddy.uk.oracle.com (/10.175.194.215)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 09:30:31 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 4/9] mm/page_alloc: Reuse tail struct pages for compound pagemaps
Date: Tue,  8 Dec 2020 17:28:56 +0000
Message-Id: <20201208172901.17384-6-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201208172901.17384-1-joao.m.martins@oracle.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=3 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080107
Message-ID-Hash: G2T7LDPZPSDKVD3ZJI4MLKJCXW6IZ762
X-Message-ID-Hash: G2T7LDPZPSDKVD3ZJI4MLKJCXW6IZ762
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G2T7LDPZPSDKVD3ZJI4MLKJCXW6IZ762/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When PGMAP_COMPOUND is set, all pages are onlined at a given huge page
alignment and using compound pages to describe them as opposed to a
struct per 4K.

To minimize struct page overhead and given the usage of compound pages we
utilize the fact that most tail pages look the same, we online the
subsection while pointing to the same pages. Thus request VMEMMAP_REUSE
in add_pages.

With VMEMMAP_REUSE, provided we reuse most tail pages the amount of
struct pages we need to initialize is a lot smaller that the total
amount of structs we would normnally online. Thus allow an @init_order
to be passed to specify how much pages we want to prep upon creating a
compound page.

Finally when onlining all struct pages in memmap_init_zone_device, make
sure that we only initialize the unique struct pages i.e. the first 2
4K pages from @align which means 128 struct pages out of 32768 for 2M
@align or 262144 for a 1G @align.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/memremap.c   |  4 +++-
 mm/page_alloc.c | 23 ++++++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index ecfa74848ac6..3eca07916b9d 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -253,8 +253,10 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 			goto err_kasan;
 		}
 
-		if (pgmap->flags & PGMAP_COMPOUND)
+		if (pgmap->flags & PGMAP_COMPOUND) {
 			params->align = pgmap->align;
+			params->flags = MEMHP_REUSE_VMEMMAP;
+		}
 
 		error = arch_add_memory(nid, range->start, range_len(range),
 					params);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9716ecd58e29..180a7d4e9285 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -691,10 +691,11 @@ void free_compound_page(struct page *page)
 	__free_pages_ok(page, compound_order(page), FPI_NONE);
 }
 
-void prep_compound_page(struct page *page, unsigned int order)
+static void __prep_compound_page(struct page *page, unsigned int order,
+				 unsigned int init_order)
 {
 	int i;
-	int nr_pages = 1 << order;
+	int nr_pages = 1 << init_order;
 
 	__SetPageHead(page);
 	for (i = 1; i < nr_pages; i++) {
@@ -711,6 +712,11 @@ void prep_compound_page(struct page *page, unsigned int order)
 		atomic_set(compound_pincount_ptr(page), 0);
 }
 
+void prep_compound_page(struct page *page, unsigned int order)
+{
+	__prep_compound_page(page, order, order);
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 unsigned int _debug_guardpage_minorder;
 
@@ -6108,6 +6114,9 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 }
 
 #ifdef CONFIG_ZONE_DEVICE
+
+#define MEMMAP_COMPOUND_SIZE (2 * (PAGE_SIZE/sizeof(struct page)))
+
 void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long start_pfn,
 				   unsigned long nr_pages,
@@ -6138,6 +6147,12 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
+		/* Skip already initialized pages. */
+		if (compound && (pfn % align >= MEMMAP_COMPOUND_SIZE)) {
+			pfn = ALIGN(pfn, align) - 1;
+			continue;
+		}
+
 		__init_single_page(page, pfn, zone_idx, nid);
 
 		/*
@@ -6175,7 +6190,9 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 	if (compound) {
 		for (pfn = start_pfn; pfn < end_pfn; pfn += align)
-			prep_compound_page(pfn_to_page(pfn), order_base_2(align));
+			__prep_compound_page(pfn_to_page(pfn),
+					   order_base_2(align),
+					   order_base_2(MEMMAP_COMPOUND_SIZE));
 	}
 
 	pr_info("%s initialised %lu pages in %ums\n", __func__,
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
