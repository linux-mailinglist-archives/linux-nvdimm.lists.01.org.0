Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B052CCF43
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Dec 2020 07:30:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E8326100EF25F;
	Wed,  2 Dec 2020 22:30:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7B45E100EF25B
	for <linux-nvdimm@lists.01.org>; Wed,  2 Dec 2020 22:30:40 -0800 (PST)
From: Mike Rapoport <rppt@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v14 03/10] set_memory: allow set_direct_map_*_noflush() for multiple pages
Date: Thu,  3 Dec 2020 08:29:42 +0200
Message-Id: <20201203062949.5484-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201203062949.5484-1-rppt@kernel.org>
References: <20201203062949.5484-1-rppt@kernel.org>
MIME-Version: 1.0
Message-ID-Hash: VZF2F3JB4R5QAOZRV54QW4T6ZYPKGWND
X-Message-ID-Hash: VZF2F3JB4R5QAOZRV54QW4T6ZYPKGWND
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <
 tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VZF2F3JB4R5QAOZRV54QW4T6ZYPKGWND/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Mike Rapoport <rppt@linux.ibm.com>

The underlying implementations of set_direct_map_invalid_noflush() and
set_direct_map_default_noflush() allow updating multiple contiguous pages
at once.

Add numpages parameter to set_direct_map_*_noflush() to expose this ability
with these APIs.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>	# arm64
---
 arch/arm64/include/asm/cacheflush.h |  4 ++--
 arch/arm64/mm/pageattr.c            | 10 ++++++----
 arch/riscv/include/asm/set_memory.h |  4 ++--
 arch/riscv/mm/pageattr.c            |  8 ++++----
 arch/x86/include/asm/set_memory.h   |  4 ++--
 arch/x86/mm/pat/set_memory.c        |  8 ++++----
 include/linux/set_memory.h          |  4 ++--
 kernel/power/snapshot.c             |  4 ++--
 mm/vmalloc.c                        |  5 +++--
 9 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 45217f21f1fe..d3598419a284 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -138,8 +138,8 @@ static __always_inline void __flush_icache_all(void)
 
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 
-int set_direct_map_invalid_noflush(struct page *page);
-int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_invalid_noflush(struct page *page, int numpages);
+int set_direct_map_default_noflush(struct page *page, int numpages);
 bool kernel_page_present(struct page *page);
 
 #include <asm-generic/cacheflush.h>
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 92eccaf595c8..b53ef37bf95a 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -148,34 +148,36 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 					__pgprot(PTE_VALID));
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int set_direct_map_invalid_noflush(struct page *page, int numpages)
 {
 	struct page_change_data data = {
 		.set_mask = __pgprot(0),
 		.clear_mask = __pgprot(PTE_VALID),
 	};
+	unsigned long size = PAGE_SIZE * numpages;
 
 	if (!debug_pagealloc_enabled() && !rodata_full)
 		return 0;
 
 	return apply_to_page_range(&init_mm,
 				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+				   size, change_page_range, &data);
 }
 
-int set_direct_map_default_noflush(struct page *page)
+int set_direct_map_default_noflush(struct page *page, int numpages)
 {
 	struct page_change_data data = {
 		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
 		.clear_mask = __pgprot(PTE_RDONLY),
 	};
+	unsigned long size = PAGE_SIZE * numpages;
 
 	if (!debug_pagealloc_enabled() && !rodata_full)
 		return 0;
 
 	return apply_to_page_range(&init_mm,
 				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+				   size, change_page_range, &data);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index d690b08dff2a..92b9bb26bf5e 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -22,8 +22,8 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
-int set_direct_map_invalid_noflush(struct page *page);
-int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_invalid_noflush(struct page *page, int numpages);
+int set_direct_map_default_noflush(struct page *page, int numpages);
 bool kernel_page_present(struct page *page);
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 87ba5a68bbb8..0454f2d052c4 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -150,11 +150,11 @@ int set_memory_nx(unsigned long addr, int numpages)
 	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_EXEC));
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int set_direct_map_invalid_noflush(struct page *page, int numpages)
 {
 	int ret;
 	unsigned long start = (unsigned long)page_address(page);
-	unsigned long end = start + PAGE_SIZE;
+	unsigned long end = start + PAGE_SIZE * numpages;
 	struct pageattr_masks masks = {
 		.set_mask = __pgprot(0),
 		.clear_mask = __pgprot(_PAGE_PRESENT)
@@ -167,11 +167,11 @@ int set_direct_map_invalid_noflush(struct page *page)
 	return ret;
 }
 
-int set_direct_map_default_noflush(struct page *page)
+int set_direct_map_default_noflush(struct page *page, int numpages)
 {
 	int ret;
 	unsigned long start = (unsigned long)page_address(page);
-	unsigned long end = start + PAGE_SIZE;
+	unsigned long end = start + PAGE_SIZE * numpages;
 	struct pageattr_masks masks = {
 		.set_mask = PAGE_KERNEL,
 		.clear_mask = __pgprot(0)
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 4352f08bfbb5..6224cb291f6c 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -80,8 +80,8 @@ int set_pages_wb(struct page *page, int numpages);
 int set_pages_ro(struct page *page, int numpages);
 int set_pages_rw(struct page *page, int numpages);
 
-int set_direct_map_invalid_noflush(struct page *page);
-int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_invalid_noflush(struct page *page, int numpages);
+int set_direct_map_default_noflush(struct page *page, int numpages);
 bool kernel_page_present(struct page *page);
 
 extern int kernel_set_to_readonly;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 16f878c26667..d157fd617c99 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2184,14 +2184,14 @@ static int __set_pages_np(struct page *page, int numpages)
 	return __change_page_attr_set_clr(&cpa, 0);
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int set_direct_map_invalid_noflush(struct page *page, int numpages)
 {
-	return __set_pages_np(page, 1);
+	return __set_pages_np(page, numpages);
 }
 
-int set_direct_map_default_noflush(struct page *page)
+int set_direct_map_default_noflush(struct page *page, int numpages)
 {
-	return __set_pages_p(page, 1);
+	return __set_pages_p(page, numpages);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index fe1aa4e54680..c650f82db813 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -15,11 +15,11 @@ static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
 #ifndef CONFIG_ARCH_HAS_SET_DIRECT_MAP
-static inline int set_direct_map_invalid_noflush(struct page *page)
+static inline int set_direct_map_invalid_noflush(struct page *page, int numpages)
 {
 	return 0;
 }
-static inline int set_direct_map_default_noflush(struct page *page)
+static inline int set_direct_map_default_noflush(struct page *page, int numpages)
 {
 	return 0;
 }
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 069576704c57..d40bb6666735 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -89,9 +89,9 @@ static inline void hibernate_map_page(struct page *page, int enable)
 		 * changes and this will no longer be the case.
 		 */
 		if (enable)
-			ret = set_direct_map_default_noflush(page);
+			ret = set_direct_map_default_noflush(page, 1);
 		else
-			ret = set_direct_map_invalid_noflush(page);
+			ret = set_direct_map_invalid_noflush(page, 1);
 
 		if (ret) {
 			pr_warn_once("Failed to remap page\n");
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d7075ad340aa..7e903524e002 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2179,13 +2179,14 @@ struct vm_struct *remove_vm_area(const void *addr)
 }
 
 static inline void set_area_direct_map(const struct vm_struct *area,
-				       int (*set_direct_map)(struct page *page))
+				       int (*set_direct_map)(struct page *page,
+							     int numpages))
 {
 	int i;
 
 	for (i = 0; i < area->nr_pages; i++)
 		if (page_address(area->pages[i]))
-			set_direct_map(area->pages[i]);
+			set_direct_map(area->pages[i], 1);
 }
 
 /* Handle removing and resetting vm mappings related to the vm_struct. */
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
