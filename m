Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C96A2AA138
	for <lists+linux-nvdimm@lfdr.de>; Sat,  7 Nov 2020 00:29:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BEE5016466741;
	Fri,  6 Nov 2020 15:29:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4660C166D2533
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 15:29:23 -0800 (PST)
IronPort-SDR: m8RY2cbZn69wNiJIOz0acSyjoqi+M3zw4+v0rt68pIoIRed9pC+BaE7dsDQkJcrNI1qdV7jKnq
 EB3ts/qVgQBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="156614102"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400";
   d="scan'208";a="156614102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:22 -0800
IronPort-SDR: 3/S5cCn+EWPD7piEWFg8bT+4+Ras3ej4Ko9LX4eBZ2eVf2PEVSU+5ghE3Ehxw1wKc5JbOk4Cci
 aWGFIu8Y1pWg==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400";
   d="scan'208";a="529966019"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:22 -0800
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH V3 01/10] x86/pkeys: Create pkeys_common.h
Date: Fri,  6 Nov 2020 15:28:59 -0800
Message-Id: <20201106232908.364581-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201106232908.364581-1-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: PYQ5CWGEUAS4NQK7JWH3E36YK3A3C2JY
X-Message-ID-Hash: PYQ5CWGEUAS4NQK7JWH3E36YK3A3C2JY
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PYQ5CWGEUAS4NQK7JWH3E36YK3A3C2JY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

Protection Keys User (PKU) and Protection Keys Supervisor (PKS) work in
similar fashions and can share common defines.  Specifically PKS and PKU
each have:

	1. A single control register
	2. The same number of keys
	3. The same number of bits in the register per key
	4. Access and Write disable in the same bit locations

That means that we can share all the macros that synthesize and
manipulate register values between the two features.  Normally, these
macros would be put in asm/pkeys.h to be used internally and externally
to the arch code.  However, the defines are required in pgtable.h and
inclusion of pkeys.h in that header creates complex dependencies which
are best resolved in a separate header.

Share these defines by moving them into a new header, change their names
to reflect the common use, and include the header where needed.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
NOTE: The initialization of init_pkru_value cause checkpatch errors
because of the space after the '(' in the macros.  We leave this as is
because it is more readable in this format.  And it was existing code.

---
Changes from RFC V3
	Per Dave Hansen
		Update commit message
		Add comment to PKR_AD_KEY macro
---
 arch/x86/include/asm/pgtable.h      | 13 ++++++-------
 arch/x86/include/asm/pkeys.h        |  2 ++
 arch/x86/include/asm/pkeys_common.h | 15 +++++++++++++++
 arch/x86/kernel/fpu/xstate.c        |  8 ++++----
 arch/x86/mm/pkeys.c                 | 14 ++++++--------
 5 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 arch/x86/include/asm/pkeys_common.h

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a02c67291cfc..bfbfb951fe65 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1360,9 +1360,7 @@ static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
 }
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
-#define PKRU_AD_BIT 0x1
-#define PKRU_WD_BIT 0x2
-#define PKRU_BITS_PER_PKEY 2
+#include <asm/pkeys_common.h>
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 extern u32 init_pkru_value;
@@ -1372,18 +1370,19 @@ extern u32 init_pkru_value;
 
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
index 2ff9b98812b7..f9feba80894b 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PKEYS_H
 #define _ASM_X86_PKEYS_H
 
+#include <asm/pkeys_common.h>
+
 #define ARCH_DEFAULT_PKEY	0
 
 /*
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
new file mode 100644
index 000000000000..737d916f476c
--- /dev/null
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PKEYS_INTERNAL_H
+#define _ASM_X86_PKEYS_INTERNAL_H
+
+#define PKR_AD_BIT 0x1
+#define PKR_WD_BIT 0x2
+#define PKR_BITS_PER_PKEY 2
+
+/*
+ * Generate an Access-Disable mask for the given pkey.  Several of these can be
+ * OR'd together to generate pkey register values.
+ */
+#define PKR_AD_KEY(pkey)	(PKR_AD_BIT << ((pkey) * PKR_BITS_PER_PKEY))
+
+#endif /*_ASM_X86_PKEYS_INTERNAL_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 5d8047441a0a..a99afc70cc0a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -995,7 +995,7 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val)
 {
 	u32 old_pkru;
-	int pkey_shift = (pkey * PKRU_BITS_PER_PKEY);
+	int pkey_shift = (pkey * PKR_BITS_PER_PKEY);
 	u32 new_pkru_bits = 0;
 
 	/*
@@ -1014,16 +1014,16 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 
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
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
