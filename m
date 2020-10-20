Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76432933C6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Oct 2020 06:08:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1A38E159C9D23;
	Mon, 19 Oct 2020 21:08:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB701159C9D22
	for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 21:08:04 -0700 (PDT)
IronPort-SDR: KY+vcSVpgHwVwXN9St2x6cuxSS7Vy5v8DpKf0PoeUGZg0VVZipSzlONsQk3yGMQ0l7GUm3Yqv9
 Mwei3Qg8hDDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="166375057"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400";
   d="scan'208";a="166375057"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 21:08:03 -0700
IronPort-SDR: 2/JVEyBVr3hl5clyPqcodFyRnkb4n8pV7SuTNfruTUrmbZMqT/dXDq/Dsc7dUdOM01LRwFKuZm
 2w8KTR9wYg/A==
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400";
   d="scan'208";a="320509150"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 21:08:03 -0700
Subject: [PATCH] x86, libnvdimm/test: Remove COPY_MC_TEST
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 19 Oct 2020 21:08:03 -0700
Message-ID: <160316688322.3374697.8648308115165836243.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: C5MCPYGZP4OCYQBH3E5625CUU24EVUB7
X-Message-ID-Hash: C5MCPYGZP4OCYQBH3E5625CUU24EVUB7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C5MCPYGZP4OCYQBH3E5625CUU24EVUB7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The COPY_MC_TEST facility has served its purpose for validating the
early termination conditions of the copy_mc_fragile() implementation.
Remove it and the EXPORT_SYMBOL_GPL of copy_mc_fragile().

Reported-by: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/Kconfig.debug              |    3 -
 arch/x86/include/asm/copy_mc_test.h |   75 -------------------------
 arch/x86/lib/copy_mc.c              |    4 -
 arch/x86/lib/copy_mc_64.S           |   10 ---
 tools/testing/nvdimm/test/nfit.c    |  103 -----------------------------------
 5 files changed, 195 deletions(-)
 delete mode 100644 arch/x86/include/asm/copy_mc_test.h

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 27b5e2bc6a01..80b57e7f4947 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -62,9 +62,6 @@ config EARLY_PRINTK_USB_XDBC
 	  You should normally say N here, unless you want to debug early
 	  crashes or need a very simple printk logging facility.
 
-config COPY_MC_TEST
-	def_bool n
-
 config EFI_PGT_DUMP
 	bool "Dump the EFI pagetable"
 	depends on EFI
diff --git a/arch/x86/include/asm/copy_mc_test.h b/arch/x86/include/asm/copy_mc_test.h
deleted file mode 100644
index e4991ba96726..000000000000
--- a/arch/x86/include/asm/copy_mc_test.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _COPY_MC_TEST_H_
-#define _COPY_MC_TEST_H_
-
-#ifndef __ASSEMBLY__
-#ifdef CONFIG_COPY_MC_TEST
-extern unsigned long copy_mc_test_src;
-extern unsigned long copy_mc_test_dst;
-
-static inline void copy_mc_inject_src(void *addr)
-{
-	if (addr)
-		copy_mc_test_src = (unsigned long) addr;
-	else
-		copy_mc_test_src = ~0UL;
-}
-
-static inline void copy_mc_inject_dst(void *addr)
-{
-	if (addr)
-		copy_mc_test_dst = (unsigned long) addr;
-	else
-		copy_mc_test_dst = ~0UL;
-}
-#else /* CONFIG_COPY_MC_TEST */
-static inline void copy_mc_inject_src(void *addr)
-{
-}
-
-static inline void copy_mc_inject_dst(void *addr)
-{
-}
-#endif /* CONFIG_COPY_MC_TEST */
-
-#else /* __ASSEMBLY__ */
-#include <asm/export.h>
-
-#ifdef CONFIG_COPY_MC_TEST
-.macro COPY_MC_TEST_CTL
-	.pushsection .data
-	.align 8
-	.globl copy_mc_test_src
-	copy_mc_test_src:
-		.quad 0
-	EXPORT_SYMBOL_GPL(copy_mc_test_src)
-	.globl copy_mc_test_dst
-	copy_mc_test_dst:
-		.quad 0
-	EXPORT_SYMBOL_GPL(copy_mc_test_dst)
-	.popsection
-.endm
-
-.macro COPY_MC_TEST_SRC reg count target
-	leaq \count(\reg), %r9
-	cmp copy_mc_test_src, %r9
-	ja \target
-.endm
-
-.macro COPY_MC_TEST_DST reg count target
-	leaq \count(\reg), %r9
-	cmp copy_mc_test_dst, %r9
-	ja \target
-.endm
-#else
-.macro COPY_MC_TEST_CTL
-.endm
-
-.macro COPY_MC_TEST_SRC reg count target
-.endm
-
-.macro COPY_MC_TEST_DST reg count target
-.endm
-#endif /* CONFIG_COPY_MC_TEST */
-#endif /* __ASSEMBLY__ */
-#endif /* _COPY_MC_TEST_H_ */
diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index c13e8c9ee926..80efd45a7761 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -10,10 +10,6 @@
 #include <asm/mce.h>
 
 #ifdef CONFIG_X86_MCE
-/*
- * See COPY_MC_TEST for self-test of the copy_mc_fragile()
- * implementation.
- */
 static DEFINE_STATIC_KEY_FALSE(copy_mc_fragile_key);
 
 void enable_copy_mc_fragile(void)
diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index 892d8915f609..e5f77e293034 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -2,14 +2,11 @@
 /* Copyright(c) 2016-2020 Intel Corporation. All rights reserved. */
 
 #include <linux/linkage.h>
-#include <asm/copy_mc_test.h>
-#include <asm/export.h>
 #include <asm/asm.h>
 
 #ifndef CONFIG_UML
 
 #ifdef CONFIG_X86_MCE
-COPY_MC_TEST_CTL
 
 /*
  * copy_mc_fragile - copy memory with indication if an exception / fault happened
@@ -38,8 +35,6 @@ SYM_FUNC_START(copy_mc_fragile)
 	subl %ecx, %edx
 .L_read_leading_bytes:
 	movb (%rsi), %al
-	COPY_MC_TEST_SRC %rsi 1 .E_leading_bytes
-	COPY_MC_TEST_DST %rdi 1 .E_leading_bytes
 .L_write_leading_bytes:
 	movb %al, (%rdi)
 	incq %rsi
@@ -55,8 +50,6 @@ SYM_FUNC_START(copy_mc_fragile)
 
 .L_read_words:
 	movq (%rsi), %r8
-	COPY_MC_TEST_SRC %rsi 8 .E_read_words
-	COPY_MC_TEST_DST %rdi 8 .E_write_words
 .L_write_words:
 	movq %r8, (%rdi)
 	addq $8, %rsi
@@ -73,8 +66,6 @@ SYM_FUNC_START(copy_mc_fragile)
 	movl %edx, %ecx
 .L_read_trailing_bytes:
 	movb (%rsi), %al
-	COPY_MC_TEST_SRC %rsi 1 .E_trailing_bytes
-	COPY_MC_TEST_DST %rdi 1 .E_trailing_bytes
 .L_write_trailing_bytes:
 	movb %al, (%rdi)
 	incq %rsi
@@ -88,7 +79,6 @@ SYM_FUNC_START(copy_mc_fragile)
 .L_done:
 	ret
 SYM_FUNC_END(copy_mc_fragile)
-EXPORT_SYMBOL_GPL(copy_mc_fragile)
 
 	.section .fixup, "ax"
 	/*
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 2ac0fff6dad8..9b185bf82da8 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -23,7 +23,6 @@
 #include "nfit_test.h"
 #include "../watermark.h"
 
-#include <asm/copy_mc_test.h>
 #include <asm/mce.h>
 
 /*
@@ -3284,107 +3283,6 @@ static struct platform_driver nfit_test_driver = {
 	.id_table = nfit_test_id,
 };
 
-static char copy_mc_buf[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
-
-enum INJECT {
-	INJECT_NONE,
-	INJECT_SRC,
-	INJECT_DST,
-};
-
-static void copy_mc_test_init(char *dst, char *src, size_t size)
-{
-	size_t i;
-
-	memset(dst, 0xff, size);
-	for (i = 0; i < size; i++)
-		src[i] = (char) i;
-}
-
-static bool copy_mc_test_validate(unsigned char *dst, unsigned char *src,
-		size_t size, unsigned long rem)
-{
-	size_t i;
-
-	for (i = 0; i < size - rem; i++)
-		if (dst[i] != (unsigned char) i) {
-			pr_info_once("%s:%d: offset: %zd got: %#x expect: %#x\n",
-					__func__, __LINE__, i, dst[i],
-					(unsigned char) i);
-			return false;
-		}
-	for (i = size - rem; i < size; i++)
-		if (dst[i] != 0xffU) {
-			pr_info_once("%s:%d: offset: %zd got: %#x expect: 0xff\n",
-					__func__, __LINE__, i, dst[i]);
-			return false;
-		}
-	return true;
-}
-
-void copy_mc_test(void)
-{
-	char *inject_desc[] = { "none", "source", "destination" };
-	enum INJECT inj;
-
-	if (IS_ENABLED(CONFIG_COPY_MC_TEST)) {
-		pr_info("%s: run...\n", __func__);
-	} else {
-		pr_info("%s: disabled, skip.\n", __func__);
-		return;
-	}
-
-	for (inj = INJECT_NONE; inj <= INJECT_DST; inj++) {
-		int i;
-
-		pr_info("%s: inject: %s\n", __func__, inject_desc[inj]);
-		for (i = 0; i < 512; i++) {
-			unsigned long expect, rem;
-			void *src, *dst;
-			bool valid;
-
-			switch (inj) {
-			case INJECT_NONE:
-				copy_mc_inject_src(NULL);
-				copy_mc_inject_dst(NULL);
-				dst = &copy_mc_buf[2048];
-				src = &copy_mc_buf[1024 - i];
-				expect = 0;
-				break;
-			case INJECT_SRC:
-				copy_mc_inject_src(&copy_mc_buf[1024]);
-				copy_mc_inject_dst(NULL);
-				dst = &copy_mc_buf[2048];
-				src = &copy_mc_buf[1024 - i];
-				expect = 512 - i;
-				break;
-			case INJECT_DST:
-				copy_mc_inject_src(NULL);
-				copy_mc_inject_dst(&copy_mc_buf[2048]);
-				dst = &copy_mc_buf[2048 - i];
-				src = &copy_mc_buf[1024];
-				expect = 512 - i;
-				break;
-			}
-
-			copy_mc_test_init(dst, src, 512);
-			rem = copy_mc_fragile(dst, src, 512);
-			valid = copy_mc_test_validate(dst, src, 512, expect);
-			if (rem == expect && valid)
-				continue;
-			pr_info("%s: copy(%#lx, %#lx, %d) off: %d rem: %ld %s expect: %ld\n",
-					__func__,
-					((unsigned long) dst) & ~PAGE_MASK,
-					((unsigned long ) src) & ~PAGE_MASK,
-					512, i, rem, valid ? "valid" : "bad",
-					expect);
-		}
-	}
-
-	copy_mc_inject_src(NULL);
-	copy_mc_inject_dst(NULL);
-}
-
 static __init int nfit_test_init(void)
 {
 	int rc, i;
@@ -3393,7 +3291,6 @@ static __init int nfit_test_init(void)
 	libnvdimm_test();
 	acpi_nfit_test();
 	device_dax_test();
-	copy_mc_test();
 	dax_pmem_test();
 	dax_pmem_core_test();
 #ifdef CONFIG_DEV_DAX_PMEM_COMPAT
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
