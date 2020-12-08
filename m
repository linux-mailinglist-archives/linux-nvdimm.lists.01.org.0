Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 362432D3110
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:30:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 674BB100EB825;
	Tue,  8 Dec 2020 09:30:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4395E100EB824
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:30:38 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HNtD2191701;
	Tue, 8 Dec 2020 17:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=S4Dp0+htpEglgK/1Ic/K1B8geFHI1bZ/iiN4YE5pPk0=;
 b=Hbdf1PR23+K2cH7wMRqBuAjYHhoUQPjPnQ5OhQa9p/yQgNaqk5+wdFq5pg1xMAzcZaJD
 7L3Jm4ePyJVmsFqpdFugX9C3n9ewkm8aEJKahhwqIDL7Zi9gwKte1TsMbVXd80e0MTWN
 yNz5YIM5fexkUw1ZStxPWMO/qaxFm7Qx+s55UFK0ZhgO3DrP4If4p3KlhjJhe3c4Eg/b
 VjUU23WiE3xnoWw1C1IeeF5UV8QJWW28UQ481ylhbx9n073N9i8WkJbenFn7dTESATXn
 pVFiXTGK4hSBdMy8ng2InZ3B+9FxrzaEneRlinywNiue+J8XPPhy6lOkTpTd0gp+zOD9 lg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 3581mquyyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 08 Dec 2020 17:30:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HOVZR195439;
	Tue, 8 Dec 2020 17:30:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 358m3y2f4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Dec 2020 17:30:24 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8HUMgc031509;
	Tue, 8 Dec 2020 17:30:22 GMT
Received: from paddy.uk.oracle.com (/10.175.194.215)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 09:30:22 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 2/9] sparse-vmemmap: Consolidate arguments in vmemmap section populate
Date: Tue,  8 Dec 2020 17:28:53 +0000
Message-Id: <20201208172901.17384-3-joao.m.martins@oracle.com>
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
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080107
Message-ID-Hash: K54KT4ICJ5CXDRIQFBLHPHY223U23QZY
X-Message-ID-Hash: K54KT4ICJ5CXDRIQFBLHPHY223U23QZY
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K54KT4ICJ5CXDRIQFBLHPHY223U23QZY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Replace vmem_altmap with an vmem_context argument. That let us
express how the vmemmap is gonna be initialized e.g. passing
flags and a page size for reusing pages upon initializing the
vmemmap.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/linux/memory_hotplug.h |  6 +++++-
 include/linux/mm.h             |  2 +-
 mm/memory_hotplug.c            |  3 ++-
 mm/sparse-vmemmap.c            |  6 +++++-
 mm/sparse.c                    | 16 ++++++++--------
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 551093b74596..73f8bcbb58a4 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -81,6 +81,10 @@ struct mhp_params {
 	pgprot_t pgprot;
 };
 
+struct vmem_context {
+	struct vmem_altmap *altmap;
+};
+
 /*
  * Zone resizing functions
  *
@@ -353,7 +357,7 @@ extern void remove_pfn_range_from_zone(struct zone *zone,
 				       unsigned long nr_pages);
 extern bool is_memblock_offlined(struct memory_block *mem);
 extern int sparse_add_section(int nid, unsigned long pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap);
+		unsigned long nr_pages, struct vmem_context *ctx);
 extern void sparse_remove_section(struct mem_section *ms,
 		unsigned long pfn, unsigned long nr_pages,
 		unsigned long map_offset, struct vmem_altmap *altmap);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3fb4e..2eb44318bb2d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3000,7 +3000,7 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap);
+		unsigned long nr_pages, int nid, struct vmem_context *ctx);
 pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
 p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
 pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 63b2e46b6555..f8870c53fe5e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -313,6 +313,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	unsigned long cur_nr_pages;
 	int err;
 	struct vmem_altmap *altmap = params->altmap;
+	struct vmem_context ctx = { .altmap = params->altmap };
 
 	if (WARN_ON_ONCE(!params->pgprot.pgprot))
 		return -EINVAL;
@@ -341,7 +342,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages = min(end_pfn - pfn,
 				   SECTION_ALIGN_UP(pfn + 1) - pfn);
-		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap);
+		err = sparse_add_section(nid, pfn, cur_nr_pages, &ctx);
 		if (err)
 			break;
 		cond_resched();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 16183d85a7d5..bcda68ba1381 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -249,15 +249,19 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 }
 
 struct page * __meminit __populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
+		unsigned long nr_pages, int nid, struct vmem_context *ctx)
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
+	struct vmem_altmap *altmap = NULL;
 
 	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
+	if (ctx)
+		altmap = ctx->altmap;
+
 	if (vmemmap_populate(start, end, nid, altmap))
 		return NULL;
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 7bd23f9d6cef..47ca494398a7 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -443,7 +443,7 @@ static unsigned long __init section_map_size(void)
 }
 
 struct page __init *__populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
+		unsigned long nr_pages, int nid, struct vmem_context *ctx)
 {
 	unsigned long size = section_map_size();
 	struct page *map = sparse_buffer_alloc(size);
@@ -648,9 +648,9 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
+		unsigned long nr_pages, int nid, struct vmem_context *ctx)
 {
-	return __populate_section_memmap(pfn, nr_pages, nid, altmap);
+	return __populate_section_memmap(pfn, nr_pages, nid, ctx);
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
@@ -842,7 +842,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 }
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap)
+		unsigned long nr_pages, struct vmem_context *ctx)
 {
 	struct mem_section *ms = __pfn_to_section(pfn);
 	struct mem_section_usage *usage = NULL;
@@ -874,9 +874,9 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
 		return pfn_to_page(pfn);
 
-	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap);
+	memmap = populate_section_memmap(pfn, nr_pages, nid, ctx);
 	if (!memmap) {
-		section_deactivate(pfn, nr_pages, altmap);
+		section_deactivate(pfn, nr_pages, ctx->altmap);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -902,7 +902,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
  * * -ENOMEM	- Out of memory.
  */
 int __meminit sparse_add_section(int nid, unsigned long start_pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap)
+		unsigned long nr_pages, struct vmem_context *ctx)
 {
 	unsigned long section_nr = pfn_to_section_nr(start_pfn);
 	struct mem_section *ms;
@@ -913,7 +913,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	if (ret < 0)
 		return ret;
 
-	memmap = section_activate(nid, start_pfn, nr_pages, altmap);
+	memmap = section_activate(nid, start_pfn, nr_pages, ctx);
 	if (IS_ERR(memmap))
 		return PTR_ERR(memmap);
 
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
