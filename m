Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9056A22F555
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Jul 2020 18:30:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 45435123E392A;
	Mon, 27 Jul 2020 09:30:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BC8BF123E3928
	for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020 09:30:38 -0700 (PDT)
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 9245C20719;
	Mon, 27 Jul 2020 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595867438;
	bh=EtHjzgniWiPXpM15YNvo+5Gcb8cwPdBCUgOLFSAcRWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2qowF2k3E6IzoSvyVCDxDhXiZ9mC/bdHex8EHHDxmfMbqtHJf8l1p2YMm3plWQvJO
	 PbvvxhREz9YtWMAp/pOSwI4fwwdSpRuXAkQTD1cwAj3N7QDNCCpICI/kO6Bg3kY1eC
	 KeJMAWyZ+Bm/2JItsoEJ60TG2Pw21K7f/I6RhTlU=
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] mm: secretmem: add ability to reserve memory at boot
Date: Mon, 27 Jul 2020 19:29:34 +0300
Message-Id: <20200727162935.31714-7-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727162935.31714-1-rppt@kernel.org>
References: <20200727162935.31714-1-rppt@kernel.org>
MIME-Version: 1.0
Message-ID-Hash: XHS4JDMFM6R7IGNPL6W2YJ6RZKP3QNNJ
X-Message-ID-Hash: XHS4JDMFM6R7IGNPL6W2YJ6RZKP3QNNJ
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XHS4JDMFM6R7IGNPL6W2YJ6RZKP3QNNJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Mike Rapoport <rppt@linux.ibm.com>

Taking pages out from the direct map and bringing them back may create
undesired fragmentation and usage of the smaller pages in the direct
mapping of the physical memory.

This can be avoided if a significantly large area of the physical memory
would be reserved for secretmem purposes at boot time.

Add ability to reserve physical memory for secretmem at boot time using
"secretmem" kernel parameter and then use that reserved memory as a global
pool for secret memory needs.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/secretmem.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 126 insertions(+), 8 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index da609701e10e..35616e3982a4 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -8,6 +8,7 @@
 #include <linux/pagemap.h>
 #include <linux/genalloc.h>
 #include <linux/syscalls.h>
+#include <linux/memblock.h>
 #include <linux/pseudo_fs.h>
 #include <linux/set_memory.h>
 #include <linux/sched/signal.h>
@@ -30,6 +31,39 @@ struct secretmem_ctx {
 	unsigned int mode;
 };
 
+struct secretmem_pool {
+	struct gen_pool *pool;
+	unsigned long reserved_size;
+	void *reserved;
+};
+
+static struct secretmem_pool secretmem_pool;
+
+static struct page *secretmem_alloc_huge_page(gfp_t gfp)
+{
+	struct gen_pool *pool = secretmem_pool.pool;
+	unsigned long addr = 0;
+	struct page *page = NULL;
+
+	if (pool) {
+		if (gen_pool_avail(pool) < PMD_SIZE)
+			return NULL;
+
+		addr = gen_pool_alloc(pool, PMD_SIZE);
+		if (!addr)
+			return NULL;
+
+		page = virt_to_page(addr);
+	} else {
+		page = alloc_pages(gfp, PMD_PAGE_ORDER);
+
+		if (page)
+			split_page(page, PMD_PAGE_ORDER);
+	}
+
+	return page;
+}
+
 static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
 {
 	unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
@@ -38,12 +72,11 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
 	struct page *page;
 	int err;
 
-	page = alloc_pages(gfp, PMD_PAGE_ORDER);
+	page = secretmem_alloc_huge_page(gfp);
 	if (!page)
 		return -ENOMEM;
 
 	addr = (unsigned long)page_address(page);
-	split_page(page, PMD_PAGE_ORDER);
 
 	err = gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
 	if (err) {
@@ -269,11 +302,13 @@ SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
 	return err;
 }
 
-static void secretmem_cleanup_chunk(struct gen_pool *pool,
-				    struct gen_pool_chunk *chunk, void *data)
+static void secretmem_recycle_range(unsigned long start, unsigned long end)
+{
+	gen_pool_free(secretmem_pool.pool, start, PMD_SIZE);
+}
+
+static void secretmem_release_range(unsigned long start, unsigned long end)
 {
-	unsigned long start = chunk->start_addr;
-	unsigned long end = chunk->end_addr;
 	unsigned long nr_pages, addr;
 
 	nr_pages = (end - start + 1) / PAGE_SIZE;
@@ -283,6 +318,18 @@ static void secretmem_cleanup_chunk(struct gen_pool *pool,
 		put_page(virt_to_page(addr));
 }
 
+static void secretmem_cleanup_chunk(struct gen_pool *pool,
+				    struct gen_pool_chunk *chunk, void *data)
+{
+	unsigned long start = chunk->start_addr;
+	unsigned long end = chunk->end_addr;
+
+	if (secretmem_pool.pool)
+		secretmem_recycle_range(start, end);
+	else
+		secretmem_release_range(start, end);
+}
+
 static void secretmem_cleanup_pool(struct secretmem_ctx *ctx)
 {
 	struct gen_pool *pool = ctx->pool;
@@ -322,14 +369,85 @@ static struct file_system_type secretmem_fs = {
 	.kill_sb	= kill_anon_super,
 };
 
+static int secretmem_reserved_mem_init(void)
+{
+	struct gen_pool *pool;
+	struct page *page;
+	void *addr;
+	int err;
+
+	if (!secretmem_pool.reserved)
+		return 0;
+
+	pool = gen_pool_create(PMD_SHIFT, NUMA_NO_NODE);
+	if (!pool)
+		return -ENOMEM;
+
+	err = gen_pool_add(pool, (unsigned long)secretmem_pool.reserved,
+			   secretmem_pool.reserved_size, NUMA_NO_NODE);
+	if (err)
+		goto err_destroy_pool;
+
+	for (addr = secretmem_pool.reserved;
+	     addr < secretmem_pool.reserved + secretmem_pool.reserved_size;
+	     addr += PAGE_SIZE) {
+		page = virt_to_page(addr);
+		__ClearPageReserved(page);
+		set_page_count(page, 1);
+	}
+
+	secretmem_pool.pool = pool;
+	page = virt_to_page(secretmem_pool.reserved);
+	__kernel_map_pages(page, secretmem_pool.reserved_size / PAGE_SIZE, 0);
+	return 0;
+
+err_destroy_pool:
+	gen_pool_destroy(pool);
+	return err;
+}
+
 static int secretmem_init(void)
 {
-	int ret = 0;
+	int ret;
+
+	ret = secretmem_reserved_mem_init();
+	if (ret)
+		return ret;
 
 	secretmem_mnt = kern_mount(&secretmem_fs);
-	if (IS_ERR(secretmem_mnt))
+	if (IS_ERR(secretmem_mnt)) {
+		gen_pool_destroy(secretmem_pool.pool);
 		ret = PTR_ERR(secretmem_mnt);
+	}
 
 	return ret;
 }
 fs_initcall(secretmem_init);
+
+static int __init secretmem_setup(char *str)
+{
+	phys_addr_t align = PMD_SIZE;
+	unsigned long reserved_size;
+	void *reserved;
+
+	reserved_size = memparse(str, NULL);
+	if (!reserved_size)
+		return 0;
+
+	if (reserved_size * 2 > PUD_SIZE)
+		align = PUD_SIZE;
+
+	reserved = memblock_alloc(reserved_size, align);
+	if (!reserved) {
+		pr_err("failed to reserve %lu bytes\n", secretmem_pool.reserved_size);
+		return 0;
+	}
+
+	secretmem_pool.reserved_size = reserved_size;
+	secretmem_pool.reserved = reserved;
+
+	pr_info("reserved %luM\n", reserved_size >> 20);
+
+	return 1;
+}
+__setup("secretmem=", secretmem_setup);
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
