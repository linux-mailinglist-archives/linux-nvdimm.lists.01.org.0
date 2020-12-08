Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D4A2D3120
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:32:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EE1F4100EB832;
	Tue,  8 Dec 2020 09:32:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42AB1100EB839
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:32:37 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HNu2p191716;
	Tue, 8 Dec 2020 17:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=nKx4vNi08XKSd2vYUrp5LU4TNVU8HPdOZixOh+DCJQg=;
 b=GN+BLh+4LMbe/27enMJEaPlyYS+9iHK9hIEYK3VDKzXf/ML+RAauwwXcCKZqhwXAiMYc
 ddf1SwL89/xuxzj9kc9o1Grf7m5yVldJiwoZsnZJbP68MmP4gGsxClw5+c1+LVC5eS7/
 IgpNEos+yf7BKl487rrIPfIanxb7MSh42KrUGRqgYQ7D3MsKb2kY+F9M2E3QuHY2tVyQ
 r5qBXLNrBA+z9+ZWyziflLTzp58v47/E0QaoUqzefCrjfplBo7+jlbyDn2c9UdtaVVkY
 lqalzQku+M2bvRCa94X3k6YZrA8THsOHWNH6JhOWxuc2jG4iW0kdFl6KywA9rR8tTv69 7w==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 3581mqv0ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 08 Dec 2020 17:32:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HOemi062823;
	Tue, 8 Dec 2020 17:30:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 358kyt8c6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Dec 2020 17:30:29 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8HUSFB031579;
	Tue, 8 Dec 2020 17:30:28 GMT
Received: from paddy.uk.oracle.com (/10.175.194.215)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 09:30:28 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 3/9] sparse-vmemmap: Reuse vmemmap areas for a given page size
Date: Tue,  8 Dec 2020 17:28:55 +0000
Message-Id: <20201208172901.17384-5-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201208172901.17384-1-joao.m.martins@oracle.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=1 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080107
Message-ID-Hash: KGT3F2PVHXMBC3UQ4R7H4MUB53J5VY5L
X-Message-ID-Hash: KGT3F2PVHXMBC3UQ4R7H4MUB53J5VY5L
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KGT3F2PVHXMBC3UQ4R7H4MUB53J5VY5L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce a new flag, MEMHP_REUSE_VMEMMAP, which signals that
struct pages are onlined with a given alignment, and should reuse the
tail pages vmemmap areas. On that circunstamce we reuse the PFN backing
only the tail pages subsections, while letting the head page PFN remain
different. This presumes that the backing page structs are compound
pages, such as the case for compound pagemaps (i.e. ZONE_DEVICE with
PGMAP_COMPOUND set)

On 2M compound pagemaps, it lets us save 6 pages out of the 8 necessary
PFNs necessary to describe the subsection's 32K struct pages we are
onlining. On a 1G compound pagemap it let us save 4096 pages.

Sections are 128M (or bigger/smaller), and such when initializing a
compound memory map where we are initializing compound struct pages, we
need to preserve the tail page to be reused across the rest of the areas
for pagesizes which bigger than a section.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
I wonder, rather than separating vmem_context and mhp_params, that
one would just pick the latter. Albeit  semantically the ctx aren't
necessarily paramters, context passed from multiple sections onlining
(i.e. multiple calls to populate_section_memmap). Also provided that
this is internal state, which isn't passed to external modules, except
 @align and @flags for page size and requesting whether to reuse tail
page areas.
---
 include/linux/memory_hotplug.h | 10 ++++
 include/linux/mm.h             |  2 +-
 mm/memory_hotplug.c            | 12 ++++-
 mm/memremap.c                  |  3 ++
 mm/sparse-vmemmap.c            | 93 ++++++++++++++++++++++++++++------
 5 files changed, 103 insertions(+), 17 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 73f8bcbb58a4..e15bb82805a3 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -70,6 +70,10 @@ typedef int __bitwise mhp_t;
  */
 #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
 
+/*
+ */
+#define MEMHP_REUSE_VMEMMAP	((__force mhp_t)BIT(1))
+
 /*
  * Extended parameters for memory hotplug:
  * altmap: alternative allocator for memmap array (optional)
@@ -79,10 +83,16 @@ typedef int __bitwise mhp_t;
 struct mhp_params {
 	struct vmem_altmap *altmap;
 	pgprot_t pgprot;
+	unsigned int align;
+	mhp_t flags;
 };
 
 struct vmem_context {
 	struct vmem_altmap *altmap;
+	mhp_t flags;
+	unsigned int align;
+	void *block;
+	unsigned long block_page;
 };
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2eb44318bb2d..8b0155441835 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3006,7 +3006,7 @@ p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
 pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
 pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
 pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-			    struct vmem_altmap *altmap);
+			    struct vmem_altmap *altmap, void *block);
 void *vmemmap_alloc_block(unsigned long size, int node);
 struct vmem_altmap;
 void *vmemmap_alloc_block_buf(unsigned long size, int node,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f8870c53fe5e..56121dfcc44b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -300,6 +300,14 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
 	return 0;
 }
 
+static void vmem_context_init(struct vmem_context *ctx, struct mhp_params *params)
+{
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->align = params->align;
+	ctx->altmap = params->altmap;
+	ctx->flags = params->flags;
+}
+
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
@@ -313,7 +321,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	unsigned long cur_nr_pages;
 	int err;
 	struct vmem_altmap *altmap = params->altmap;
-	struct vmem_context ctx = { .altmap = params->altmap };
+	struct vmem_context ctx;
 
 	if (WARN_ON_ONCE(!params->pgprot.pgprot))
 		return -EINVAL;
@@ -338,6 +346,8 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	if (err)
 		return err;
 
+	vmem_context_init(&ctx, params);
+
 	for (; pfn < end_pfn; pfn += cur_nr_pages) {
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages = min(end_pfn - pfn,
diff --git a/mm/memremap.c b/mm/memremap.c
index 287a24b7a65a..ecfa74848ac6 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -253,6 +253,9 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 			goto err_kasan;
 		}
 
+		if (pgmap->flags & PGMAP_COMPOUND)
+			params->align = pgmap->align;
+
 		error = arch_add_memory(nid, range->start, range_len(range),
 					params);
 	}
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index bcda68ba1381..364c071350e8 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -141,16 +141,20 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 }
 
 pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-				       struct vmem_altmap *altmap)
+				       struct vmem_altmap *altmap, void *block)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	if (pte_none(*pte)) {
 		pte_t entry;
-		void *p;
-
-		p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
-		if (!p)
-			return NULL;
+		void *p = block;
+
+		if (!block) {
+			p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
+			if (!p)
+				return NULL;
+		} else {
+			get_page(virt_to_page(block));
+		}
 		entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
@@ -216,8 +220,10 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 	return pgd;
 }
 
-int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
+static void *__meminit __vmemmap_populate_basepages(unsigned long start,
+					   unsigned long end, int node,
+					   struct vmem_altmap *altmap,
+					   void *block)
 {
 	unsigned long addr = start;
 	pgd_t *pgd;
@@ -229,38 +235,95 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 	for (; addr < end; addr += PAGE_SIZE) {
 		pgd = vmemmap_pgd_populate(addr, node);
 		if (!pgd)
-			return -ENOMEM;
+			return NULL;
 		p4d = vmemmap_p4d_populate(pgd, addr, node);
 		if (!p4d)
-			return -ENOMEM;
+			return NULL;
 		pud = vmemmap_pud_populate(p4d, addr, node);
 		if (!pud)
-			return -ENOMEM;
+			return NULL;
 		pmd = vmemmap_pmd_populate(pud, addr, node);
 		if (!pmd)
-			return -ENOMEM;
-		pte = vmemmap_pte_populate(pmd, addr, node, altmap);
+			return NULL;
+		pte = vmemmap_pte_populate(pmd, addr, node, altmap, block);
 		if (!pte)
-			return -ENOMEM;
+			return NULL;
 		vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 	}
 
+	return __va(__pfn_to_phys(pte_pfn(*pte)));
+}
+
+int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
+					 int node, struct vmem_altmap *altmap)
+{
+	if (!__vmemmap_populate_basepages(start, end, node, altmap, NULL))
+		return -ENOMEM;
 	return 0;
 }
 
+static struct page * __meminit vmemmap_populate_reuse(unsigned long start,
+					unsigned long end, int node,
+					struct vmem_context *ctx)
+{
+	unsigned long size, addr = start;
+	unsigned long psize = PHYS_PFN(ctx->align) * sizeof(struct page);
+
+	size = min(psize, end - start);
+
+	for (; addr < end; addr += size) {
+		unsigned long head = addr + PAGE_SIZE;
+		unsigned long tail = addr;
+		unsigned long last = addr + size;
+		void *area;
+
+		if (ctx->block_page &&
+		    IS_ALIGNED((addr - ctx->block_page), psize))
+			ctx->block = NULL;
+
+		area  = ctx->block;
+		if (!area) {
+			if (!__vmemmap_populate_basepages(addr, head, node,
+							  ctx->altmap, NULL))
+				return NULL;
+
+			tail = head + PAGE_SIZE;
+			area = __vmemmap_populate_basepages(head, tail, node,
+							    ctx->altmap, NULL);
+			if (!area)
+				return NULL;
+
+			ctx->block = area;
+			ctx->block_page = addr;
+		}
+
+		if (!__vmemmap_populate_basepages(tail, last, node,
+						  ctx->altmap, area))
+			return NULL;
+	}
+
+	return (struct page *) start;
+}
+
 struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_context *ctx)
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 	struct vmem_altmap *altmap = NULL;
+	int flags = 0;
 
 	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (ctx)
+	if (ctx) {
 		altmap = ctx->altmap;
+		flags = ctx->flags;
+	}
+
+	if (flags & MEMHP_REUSE_VMEMMAP)
+		return vmemmap_populate_reuse(start, end, nid, ctx);
 
 	if (vmemmap_populate(start, end, nid, altmap))
 		return NULL;
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
