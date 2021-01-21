Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C942FEA05
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 13:29:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C5A1100EB359;
	Thu, 21 Jan 2021 04:29:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1BECE100EB357
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 04:29:00 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEAD6239FF;
	Thu, 21 Jan 2021 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1611232139;
	bh=0FIDx2HilEZBzfBHTwB/3do9lxZLUmSzqfQ+KNSAkko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3q4Zj1fPwNHXX7u+q92p7e2Bx8HgrmXjAXxil46IXYidoNyrB1+gmFssLBGCTP2e
	 L/BZKdkPkXcZ9Tu28mgKVF6qUKsbJ6jYHdcOcGb+epLzau0GQ4XegrgAz0xtt33piR
	 n/ahOOXBaroN8wtxpZTeSA2j0Ux5n0vj/5HbOHhxzT2VCd84UfUhew78dic1Ql6oux
	 EnkI5RPuQ2Wgn4Z9cb+62xwsWVsDP9tK7+HYB/h6BLPr9OUWjkeLu4zVGNLnF2kKsH
	 SYFPmc4VhpFJtu/2oFlwZHM/rzYdvp61G7CzrXOjbPrV2d4/1efYWao0/sRsHMbuAT
	 fPBjkDzsw0d4g==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v16 08/11] secretmem: add memcg accounting
Date: Thu, 21 Jan 2021 14:27:20 +0200
Message-Id: <20210121122723.3446-9-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210121122723.3446-1-rppt@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
MIME-Version: 1.0
Message-ID-Hash: UKK74ZVHNLQ4P2L6T4CUDPNQ6TUWLKO7
X-Message-ID-Hash: UKK74ZVHNLQ4P2L6T4CUDPNQ6TUWLKO7
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <
 tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UKK74ZVHNLQ4P2L6T4CUDPNQ6TUWLKO7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Mike Rapoport <rppt@linux.ibm.com>

Account memory consumed by secretmem to memcg. The accounting is updated
when the memory is actually allocated and freed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christopher Lameter <cl@linux.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: Will Deacon <will@kernel.org>
---
 mm/filemap.c   |  3 ++-
 mm/secretmem.c | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2d0c6721879d..bb28dd6d9e22 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -42,6 +42,7 @@
 #include <linux/psi.h>
 #include <linux/ramfs.h>
 #include <linux/page_idle.h>
+#include <linux/secretmem.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -839,7 +840,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 	page->mapping = mapping;
 	page->index = offset;
 
-	if (!huge) {
+	if (!huge && !page_is_secretmem(page)) {
 		error = mem_cgroup_charge(page, current->mm, gfp);
 		if (error)
 			goto error;
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 469211c7cc3a..05026460e2ee 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/pseudo_fs.h>
 #include <linux/secretmem.h>
+#include <linux/memcontrol.h>
 #include <linux/set_memory.h>
 #include <linux/sched/signal.h>
 
@@ -44,6 +45,32 @@ struct secretmem_ctx {
 
 static struct cma *secretmem_cma;
 
+static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
+{
+	int err;
+
+	err = memcg_kmem_charge_page(page, gfp, order);
+	if (err)
+		return err;
+
+	/*
+	 * seceremem caches are unreclaimable kernel allocations, so treat
+	 * them as unreclaimable slab memory for VM statistics purposes
+	 */
+	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+			      PAGE_SIZE << order);
+
+	return 0;
+}
+
+static void secretmem_unaccount_pages(struct page *page, int order)
+{
+
+	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+			      -PAGE_SIZE << order);
+	memcg_kmem_uncharge_page(page, order);
+}
+
 static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
 {
 	unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
@@ -56,6 +83,10 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
 	if (!page)
 		return -ENOMEM;
 
+	err = secretmem_account_pages(page, gfp, PMD_PAGE_ORDER);
+	if (err)
+		goto err_cma_release;
+
 	/*
 	 * clear the data left from the prevoius user before dropping the
 	 * pages from the direct map
@@ -65,7 +96,7 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
 
 	err = set_direct_map_invalid_noflush(page, nr_pages);
 	if (err)
-		goto err_cma_release;
+		goto err_memcg_uncharge;
 
 	addr = (unsigned long)page_address(page);
 	err = gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
@@ -83,6 +114,8 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
 	 * won't fail
 	 */
 	set_direct_map_default_noflush(page, nr_pages);
+err_memcg_uncharge:
+	secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
 err_cma_release:
 	cma_release(secretmem_cma, page, nr_pages);
 	return err;
@@ -314,6 +347,7 @@ static void secretmem_cleanup_chunk(struct gen_pool *pool,
 	int i;
 
 	set_direct_map_default_noflush(page, nr_pages);
+	secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
 
 	for (i = 0; i < nr_pages; i++)
 		clear_highpage(page + i);
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
