Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7447E1E51D7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 May 2020 01:32:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 321C91228E00A;
	Wed, 27 May 2020 16:28:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AD6FA11FED4A7
	for <linux-nvdimm@lists.01.org>; Wed, 27 May 2020 16:28:12 -0700 (PDT)
IronPort-SDR: b/4XojCPXqnc+/HJSNUaBDb56iTQqCioCBycxxsEqMStGo6s9rWW4Da5asTmxByjjaIJev7pp1
 N7LKjjTKS2PA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 16:32:26 -0700
IronPort-SDR: OKylZAZcc8PtV7NCARCR3EYA5HYGk5ASnPKYEcUefL3Qi9933RhwDeO/ls0/GkpKVBLJH4AsWv
 rMSBtPFJQ+xw==
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400";
   d="scan'208";a="267013064"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 16:32:26 -0700
Subject: [PATCH v5 2/2] x86/copy_mc: Introduce copy_mc_generic()
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@redhat.com
Date: Wed, 27 May 2020 16:16:13 -0700
Message-ID: <159062137392.2192412.6992576670321577768.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159062136234.2192412.7285856919306307817.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159062136234.2192412.7285856919306307817.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: MYRR2XAMYL3PRZSMWJ2YDMQYGI6BB7SL
X-Message-ID-Hash: MYRR2XAMYL3PRZSMWJ2YDMQYGI6BB7SL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, stable@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Erwin Tsaur <erwin.tsaur@intel.com>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MYRR2XAMYL3PRZSMWJ2YDMQYGI6BB7SL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The original copy_mc_fragile() implementation had negative performance
implications since it did not use the fast-string instruction sequence
to perform copies. For this reason copy_mc_to_kernel() fell back to
plain memcpy() to preserve performance on platform that did not indicate
the capability to recover from machine check exceptions. However, that
capability detection was not architectural and now that some platforms
can recover from fast-string consumption of memory errors the memcpy()
fallback now causes these more capable platforms to fail.

Introduce copy_mc_generic() as the fast default implementation of
copy_mc_to_kernel() and finalize the transition of copy_mc_fragile() to
be a platform quirk to indicate 'fragility'. With this in place
copy_mc_to_kernel() is fast and recovery-ready by default regardless of
hardware capability.

Thanks to Vivek for identifying that copy_user_generic() is not suitable
as the copy_mc_to_user() backend since the #MC handler explicitly checks
ex_has_fault_handler().

Cc: x86@kernel.org
Cc: <stable@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Erwin Tsaur <erwin.tsaur@intel.com>
Tested-by: Erwin Tsaur <erwin.tsaur@intel.com>
Fixes: 92b0729c34ca ("x86/mm, x86/mce: Add memcpy_mcsafe()")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/uaccess.h |    3 +++
 arch/x86/lib/copy_mc.c         |   12 +++++-------
 arch/x86/lib/copy_mc_64.S      |   40 ++++++++++++++++++++++++++++++++++++++++
 tools/objtool/check.c          |    1 +
 4 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 6e856e180096..05cf0acd65d1 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -464,6 +464,9 @@ copy_mc_to_user(void *to, const void *from, unsigned len);
 
 unsigned long __must_check
 copy_mc_fragile(void *dst, const void *src, unsigned cnt);
+
+unsigned long __must_check
+copy_mc_generic(void *dst, const void *src, unsigned cnt);
 #else
 static inline void enable_copy_mc_fragile(void)
 {
diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index cdb8f5dc403d..9e6fac1ab72e 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -23,7 +23,7 @@ void enable_copy_mc_fragile(void)
  *
  * Call into the 'fragile' version on systems that have trouble
  * actually do machine check recovery. Everyone else can just
- * use memcpy().
+ * use copy_mc_generic().
  *
  * Return 0 for success, or number of bytes not copied if there was an
  * exception.
@@ -33,8 +33,7 @@ copy_mc_to_kernel(void *dst, const void *src, unsigned cnt)
 {
 	if (static_branch_unlikely(&copy_mc_fragile_key))
 		return copy_mc_fragile(dst, src, cnt);
-	memcpy(dst, src, cnt);
-	return 0;
+	return copy_mc_generic(dst, src, cnt);
 }
 EXPORT_SYMBOL_GPL(copy_mc_to_kernel);
 
@@ -56,11 +55,10 @@ copy_mc_to_user(void *to, const void *from, unsigned len)
 {
 	unsigned long ret;
 
-	if (!static_branch_unlikely(&copy_mc_fragile_key))
-		return copy_user_generic(to, from, len);
-
 	__uaccess_begin();
-	ret = copy_mc_fragile(to, from, len);
+	if (static_branch_unlikely(&copy_mc_fragile_key))
+		ret = copy_mc_fragile(to, from, len);
+	ret = copy_mc_generic(to, from, len);
 	__uaccess_end();
 	return ret;
 }
diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index 35a67c50890b..a08e7a4d9e28 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -2,7 +2,9 @@
 /* Copyright(c) 2016-2020 Intel Corporation. All rights reserved. */
 
 #include <linux/linkage.h>
+#include <asm/alternative-asm.h>
 #include <asm/copy_mc_test.h>
+#include <asm/cpufeatures.h>
 #include <asm/export.h>
 #include <asm/asm.h>
 
@@ -122,4 +124,42 @@ EXPORT_SYMBOL_GPL(copy_mc_fragile)
 	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
 	_ASM_EXTABLE(.L_write_words, .E_write_words)
 	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
+
+/*
+ * copy_mc_generic - memory copy with exception handling
+ *
+ * Fast string copy + fault / exception handling. If the CPU does
+ * support machine check exception recovery, but does not support
+ * recovering from fast-string exceptions then this CPU needs to be
+ * added to the copy_mc_fragile_key set of quirks. Otherwise, absent any
+ * machine check recovery support this version should be no slower than
+ * standard memcpy.
+ */
+SYM_FUNC_START(copy_mc_generic)
+	ALTERNATIVE "jmp copy_mc_fragile", "", X86_FEATURE_ERMS
+	movq %rdi, %rax
+	movq %rdx, %rcx
+.L_copy:
+	rep movsb
+	/* Copy successful. Return zero */
+	xorl %eax, %eax
+	ret
+SYM_FUNC_END(copy_mc_generic)
+EXPORT_SYMBOL_GPL(copy_mc_generic)
+
+	.section .fixup, "ax"
+.E_copy:
+	/*
+	 * On fault %rcx is updated such that the copy instruction could
+	 * optionally be restarted at the fault position, i.e. it
+	 * contains 'bytes remaining'. A non-zero return indicates error
+	 * to copy_mc_generic() users, or indicate short transfers to
+	 * user-copy routines.
+	 */
+	movq %rcx, %rax
+	ret
+
+	.previous
+
+	_ASM_EXTABLE_FAULT(.L_copy, .E_copy)
 #endif
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f07adee5df9e..54c7467fa2fe 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -547,6 +547,7 @@ static const char *uaccess_safe_builtin[] = {
 	"__ubsan_handle_shift_out_of_bounds",
 	/* misc */
 	"csum_partial_copy_generic",
+	"copy_mc_generic",
 	"copy_mc_fragile",
 	"copy_mc_fragile_handle_tail",
 	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
