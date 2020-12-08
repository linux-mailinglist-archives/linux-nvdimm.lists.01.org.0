Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0DA2D3115
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:30:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E792100EB827;
	Tue,  8 Dec 2020 09:30:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 05252100EB838
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:30:49 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HPa5v083230;
	Tue, 8 Dec 2020 17:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=LBzwQ398iHST3UKT538bsLuEEbD/c3Ows2/jGL1jAIY=;
 b=oXpLirFM6Qlbdf+Mtkrd46GYq4i7ZSwkEHsawSs3Mzpn+CvtLEqAs7ysR1mnC4EgUlb3
 q4FSO5XVJJp24q8JVnR0RllKAc77C7t8gXPg4cDOhwMrWOc9RtCRgN4hrJ7HapqBKy6U
 7iVEnu0d1MHDfPWsSsK5a4d1aL6YnAnVNjZwPHFLxgg0bxHEFdvBys6Xs7cQAwe6/Dc1
 nlRBu2lGlWvjw+yj1NNcCeDwL9sMZZHjmWldpWNoVK1iJvtns0bX7EeBz8iP0vkjLIkH
 IopzYpqxZGFPYWYjuLhh1MNkUG0lM24ygQv/2Dbt+ayjCQPZM4Nlc0ACYTe18caiABJs ww==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 357yqbv4ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 08 Dec 2020 17:30:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HOVs7195377;
	Tue, 8 Dec 2020 17:30:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 358m3y2fgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Dec 2020 17:30:41 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8HUfXr012449;
	Tue, 8 Dec 2020 17:30:41 GMT
Received: from paddy.uk.oracle.com (/10.175.194.215)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 09:30:40 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 7/9] mm/gup: Decrement head page once for group of subpages
Date: Tue,  8 Dec 2020 17:28:59 +0000
Message-Id: <20201208172901.17384-9-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201208172901.17384-1-joao.m.martins@oracle.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=1 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080107
Message-ID-Hash: NUQFE2TBJC3KH2MTXQQYJ4E4MEIP4H6N
X-Message-ID-Hash: NUQFE2TBJC3KH2MTXQQYJ4E4MEIP4H6N
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NUQFE2TBJC3KH2MTXQQYJ4E4MEIP4H6N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Rather than decrementing the ref count one by one, we
walk the page array and checking which belong to the same
compound_head. Later on we decrement the calculated amount
of references in a single write to the head page.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/gup.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 194e6981eb03..3a9a7229f418 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -212,6 +212,18 @@ static bool __unpin_devmap_managed_user_page(struct page *page)
 }
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
+static int record_refs(struct page **pages, int npages)
+{
+	struct page *head = compound_head(pages[0]);
+	int refs = 1, index;
+
+	for (index = 1; index < npages; index++, refs++)
+		if (compound_head(pages[index]) != head)
+			break;
+
+	return refs;
+}
+
 /**
  * unpin_user_page() - release a dma-pinned page
  * @page:            pointer to page to be released
@@ -221,9 +233,9 @@ static bool __unpin_devmap_managed_user_page(struct page *page)
  * that such pages can be separately tracked and uniquely handled. In
  * particular, interactions with RDMA and filesystems need special handling.
  */
-void unpin_user_page(struct page *page)
+static void __unpin_user_page(struct page *page, int refs)
 {
-	int refs = 1;
+	int orig_refs = refs;
 
 	page = compound_head(page);
 
@@ -237,14 +249,19 @@ void unpin_user_page(struct page *page)
 		return;
 
 	if (hpage_pincount_available(page))
-		hpage_pincount_sub(page, 1);
+		hpage_pincount_sub(page, refs);
 	else
-		refs = GUP_PIN_COUNTING_BIAS;
+		refs *= GUP_PIN_COUNTING_BIAS;
 
 	if (page_ref_sub_and_test(page, refs))
 		__put_page(page);
 
-	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, 1);
+	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, orig_refs);
+}
+
+void unpin_user_page(struct page *page)
+{
+	__unpin_user_page(page, 1);
 }
 EXPORT_SYMBOL(unpin_user_page);
 
@@ -274,6 +291,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 				 bool make_dirty)
 {
 	unsigned long index;
+	int refs = 1;
 
 	/*
 	 * TODO: this can be optimized for huge pages: if a series of pages is
@@ -286,8 +304,9 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 		return;
 	}
 
-	for (index = 0; index < npages; index++) {
+	for (index = 0; index < npages; index += refs) {
 		struct page *page = compound_head(pages[index]);
+
 		/*
 		 * Checking PageDirty at this point may race with
 		 * clear_page_dirty_for_io(), but that's OK. Two key
@@ -310,7 +329,8 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 		 */
 		if (!PageDirty(page))
 			set_page_dirty_lock(page);
-		unpin_user_page(page);
+		refs = record_refs(pages + index, npages - index);
+		__unpin_user_page(page, refs);
 	}
 }
 EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
@@ -327,6 +347,7 @@ EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
 void unpin_user_pages(struct page **pages, unsigned long npages)
 {
 	unsigned long index;
+	int refs = 1;
 
 	/*
 	 * If this WARN_ON() fires, then the system *might* be leaking pages (by
@@ -340,8 +361,10 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 	 * physically contiguous and part of the same compound page, then a
 	 * single operation to the head page should suffice.
 	 */
-	for (index = 0; index < npages; index++)
-		unpin_user_page(pages[index]);
+	for (index = 0; index < npages; index += refs) {
+		refs = record_refs(pages + index, npages - index);
+		__unpin_user_page(pages[index], refs);
+	}
 }
 EXPORT_SYMBOL(unpin_user_pages);
 
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
