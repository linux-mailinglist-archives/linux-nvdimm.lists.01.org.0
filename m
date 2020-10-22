Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CD1296732
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Oct 2020 00:27:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C710E16276A57;
	Thu, 22 Oct 2020 15:27:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 813FB16271500
	for <linux-nvdimm@lists.01.org>; Thu, 22 Oct 2020 15:27:14 -0700 (PDT)
IronPort-SDR: OcRs+uDAeEs8vqOZ95v9m1+7rkbJvhPKWyrlQ9Nkv7vjnZ3JSwtj8DU8gcjgCFynxv3Hr9kuko
 nAISQVl4J5Cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="167725381"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400";
   d="scan'208";a="167725381"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:27:13 -0700
IronPort-SDR: PgEON2dSDjhDgwJHX+QIzzPzwQILf6lmaeDrRVmCBuAgdJLZXquxiF992pN86zPkmZ3YD0ncVk
 vrUzZfm9e8uQ==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400";
   d="scan'208";a="524442538"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:27:13 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 02/10] x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
Date: Thu, 22 Oct 2020 15:26:53 -0700
Message-Id: <20201022222701.887660-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201022222701.887660-1-ira.weiny@intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: GYDNIA6JMCVI4GAERUL6AON57X22YAUY
X-Message-ID-Hash: GYDNIA6JMCVI4GAERUL6AON57X22YAUY
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GYDNIA6JMCVI4GAERUL6AON57X22YAUY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

Define a helper, update_pkey_val(), which will be used to support both
Protection Key User (PKU) and the new Protection Key for Supervisor
(PKS) in subsequent patches.

Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC V3:
	Per Dave Hansen
		Update and add comments per Dave's review
	Per Peter
		Correct attribution
---
 arch/x86/include/asm/pkeys.h |  2 ++
 arch/x86/kernel/fpu/xstate.c | 22 ++++------------------
 arch/x86/mm/pkeys.c          | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index f9feba80894b..4526245b03e5 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -136,4 +136,6 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
 }
 
+u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags);
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a99afc70cc0a..a3bca3211eba 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -994,9 +994,7 @@ const void *get_xsave_field_ptr(int xfeature_nr)
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val)
 {
-	u32 old_pkru;
-	int pkey_shift = (pkey * PKR_BITS_PER_PKEY);
-	u32 new_pkru_bits = 0;
+	u32 pkru;
 
 	/*
 	 * This check implies XSAVE support.  OSPKE only gets
@@ -1012,21 +1010,9 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	 */
 	WARN_ON_ONCE(pkey >= arch_max_pkey());
 
-	/* Set the bits we need in PKRU:  */
-	if (init_val & PKEY_DISABLE_ACCESS)
-		new_pkru_bits |= PKR_AD_BIT;
-	if (init_val & PKEY_DISABLE_WRITE)
-		new_pkru_bits |= PKR_WD_BIT;
-
-	/* Shift the bits in to the correct place in PKRU for pkey: */
-	new_pkru_bits <<= pkey_shift;
-
-	/* Get old PKRU and mask off any old bits in place: */
-	old_pkru = read_pkru();
-	old_pkru &= ~((PKR_AD_BIT|PKR_WD_BIT) << pkey_shift);
-
-	/* Write old part along with new part: */
-	write_pkru(old_pkru | new_pkru_bits);
+	pkru = read_pkru();
+	pkru = update_pkey_val(pkru, pkey, init_val);
+	write_pkru(pkru);
 
 	return 0;
 }
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index f5efb4007e74..d1dfe743e79f 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -208,3 +208,26 @@ static __init int setup_init_pkru(char *opt)
 	return 1;
 }
 __setup("init_pkru=", setup_init_pkru);
+
+/*
+ * Replace disable bits for @pkey with values from @flags
+ *
+ * Kernel users use the same flags as user space:
+ *     PKEY_DISABLE_ACCESS
+ *     PKEY_DISABLE_WRITE
+ */
+u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
+{
+	int pkey_shift = pkey * PKR_BITS_PER_PKEY;
+
+	/*  Mask out old bit values */
+	pk_reg &= ~(((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift);
+
+	/*  Or in new values */
+	if (flags & PKEY_DISABLE_ACCESS)
+		pk_reg |= PKR_AD_BIT << pkey_shift;
+	if (flags & PKEY_DISABLE_WRITE)
+		pk_reg |= PKR_WD_BIT << pkey_shift;
+
+	return pk_reg;
+}
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
