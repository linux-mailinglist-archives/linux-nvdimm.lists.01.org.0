Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0DD21E902
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 09:04:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7191010056AFC;
	Tue, 14 Jul 2020 00:04:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3041D10056AF5
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 00:04:01 -0700 (PDT)
IronPort-SDR: cneN2jgNplluNmZZ4icINHkGY0adEVrmVhm3aibc83ffFhRts+T8o8hjl6zQESVvpIjhxSlied
 XC5AZEDyX5oQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="233684256"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="233684256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:01 -0700
IronPort-SDR: SSi5GJb0V/HMXSKbaAyXk6HDmW4dB1Grr5oZA4rgflGb+mamJz9w29PyxLPPix1ZRfBr/DOI4L
 Lp6bL5FQa6zg==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="429666461"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:00 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 01/15] x86/pkeys: Create pkeys_internal.h
Date: Tue, 14 Jul 2020 00:02:06 -0700
Message-Id: <20200714070220.3500839-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714070220.3500839-1-ira.weiny@intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: LT6QVHEZYVAVQ2RLRMF2DEDWKBODEN47
X-Message-ID-Hash: LT6QVHEZYVAVQ2RLRMF2DEDWKBODEN47
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LT6QVHEZYVAVQ2RLRMF2DEDWKBODEN47/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

Protection Keys User (PKU) and Protection Keys Supervisor (PKS) work in
similar fashions.

Share code between them by creating a header with common defines, move
those defines into this header, change their names to reflect the new
use, and include the header where needed.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/include/asm/pgtable.h        | 13 ++++++-------
 arch/x86/include/asm/pkeys.h          |  2 ++
 arch/x86/include/asm/pkeys_internal.h | 11 +++++++++++
 arch/x86/include/asm/processor.h      |  1 +
 arch/x86/kernel/fpu/xstate.c          |  8 ++++----
 arch/x86/mm/pkeys.c                   | 14 ++++++--------
 6 files changed, 30 insertions(+), 19 deletions(-)
 create mode 100644 arch/x86/include/asm/pkeys_internal.h

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 76aa21e8128d..30e97fc8a683 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1364,9 +1364,7 @@ static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
 }
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
-#define PKRU_AD_BIT 0x1
-#define PKRU_WD_BIT 0x2
-#define PKRU_BITS_PER_PKEY 2
+#include <asm/pkeys_internal.h>
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 extern u32 init_pkru_value;
@@ -1376,18 +1374,19 @@ extern u32 init_pkru_value;
 
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
 {
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
-	return !(pkru & (PKRU_AD_BIT << pkru_pkey_bits));
+	int pkru_pkey_bits = pkey * PKR_BITS_PER_PKEY;
+
+	return !(pkru & (PKR_AD_BIT << pkru_pkey_bits));
 }
 
 static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
 {
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
+	int pkru_pkey_bits = pkey * PKR_BITS_PER_PKEY;
 	/*
 	 * Access-disable disables writes too so we need to check
 	 * both bits here.
 	 */
-	return !(pkru & ((PKRU_AD_BIT|PKRU_WD_BIT) << pkru_pkey_bits));
+	return !(pkru & ((PKR_AD_BIT|PKR_WD_BIT) << pkru_pkey_bits));
 }
 
 static inline u16 pte_flags_pkey(unsigned long pte_flags)
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 2ff9b98812b7..be8b3e448f76 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PKEYS_H
 #define _ASM_X86_PKEYS_H
 
+#include <asm/pkeys_internal.h>
+
 #define ARCH_DEFAULT_PKEY	0
 
 /*
diff --git a/arch/x86/include/asm/pkeys_internal.h b/arch/x86/include/asm/pkeys_internal.h
new file mode 100644
index 000000000000..a9f086f1e4b4
--- /dev/null
+++ b/arch/x86/include/asm/pkeys_internal.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PKEYS_INTERNAL_H
+#define _ASM_X86_PKEYS_INTERNAL_H
+
+#define PKR_AD_BIT 0x1
+#define PKR_WD_BIT 0x2
+#define PKR_BITS_PER_PKEY 2
+
+#define PKR_AD_KEY(pkey)	(PKR_AD_BIT << ((pkey) * PKR_BITS_PER_PKEY))
+
+#endif /*_ASM_X86_PKEYS_INTERNAL_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 03b7c4ca425a..7da9855b5068 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -27,6 +27,7 @@ struct vm86;
 #include <asm/unwind_hints.h>
 #include <asm/vmxfeatures.h>
 #include <asm/vdso/processor.h>
+#include <asm/pkeys_internal.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bda2e5eaca0e..fc1ec2986e03 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -955,7 +955,7 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val)
 {
 	u32 old_pkru;
-	int pkey_shift = (pkey * PKRU_BITS_PER_PKEY);
+	int pkey_shift = (pkey * PKR_BITS_PER_PKEY);
 	u32 new_pkru_bits = 0;
 
 	/*
@@ -974,16 +974,16 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 
 	/* Set the bits we need in PKRU:  */
 	if (init_val & PKEY_DISABLE_ACCESS)
-		new_pkru_bits |= PKRU_AD_BIT;
+		new_pkru_bits |= PKR_AD_BIT;
 	if (init_val & PKEY_DISABLE_WRITE)
-		new_pkru_bits |= PKRU_WD_BIT;
+		new_pkru_bits |= PKR_WD_BIT;
 
 	/* Shift the bits in to the correct place in PKRU for pkey: */
 	new_pkru_bits <<= pkey_shift;
 
 	/* Get old PKRU and mask off any old bits in place: */
 	old_pkru = read_pkru();
-	old_pkru &= ~((PKRU_AD_BIT|PKRU_WD_BIT) << pkey_shift);
+	old_pkru &= ~((PKR_AD_BIT|PKR_WD_BIT) << pkey_shift);
 
 	/* Write old part along with new part: */
 	write_pkru(old_pkru | new_pkru_bits);
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 8873ed1438a9..f5efb4007e74 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -111,19 +111,17 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
 	return vma_pkey(vma);
 }
 
-#define PKRU_AD_KEY(pkey)	(PKRU_AD_BIT << ((pkey) * PKRU_BITS_PER_PKEY))
-
 /*
  * Make the default PKRU value (at execve() time) as restrictive
  * as possible.  This ensures that any threads clone()'d early
  * in the process's lifetime will not accidentally get access
  * to data which is pkey-protected later on.
  */
-u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
-		      PKRU_AD_KEY( 4) | PKRU_AD_KEY( 5) | PKRU_AD_KEY( 6) |
-		      PKRU_AD_KEY( 7) | PKRU_AD_KEY( 8) | PKRU_AD_KEY( 9) |
-		      PKRU_AD_KEY(10) | PKRU_AD_KEY(11) | PKRU_AD_KEY(12) |
-		      PKRU_AD_KEY(13) | PKRU_AD_KEY(14) | PKRU_AD_KEY(15);
+u32 init_pkru_value = PKR_AD_KEY( 1) | PKR_AD_KEY( 2) | PKR_AD_KEY( 3) |
+		      PKR_AD_KEY( 4) | PKR_AD_KEY( 5) | PKR_AD_KEY( 6) |
+		      PKR_AD_KEY( 7) | PKR_AD_KEY( 8) | PKR_AD_KEY( 9) |
+		      PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) |
+		      PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15);
 
 /*
  * Called from the FPU code when creating a fresh set of FPU
@@ -173,7 +171,7 @@ static ssize_t init_pkru_write_file(struct file *file,
 	 * up immediately if someone attempts to disable access
 	 * or writes to pkey 0.
 	 */
-	if (new_init_pkru & (PKRU_AD_BIT|PKRU_WD_BIT))
+	if (new_init_pkru & (PKR_AD_BIT|PKR_WD_BIT))
 		return -EINVAL;
 
 	WRITE_ONCE(init_pkru_value, new_init_pkru);
-- 
2.25.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
