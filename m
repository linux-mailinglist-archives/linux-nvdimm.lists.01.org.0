Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A66322355A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 09:21:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B7DE811EB8DF2;
	Fri, 17 Jul 2020 00:21:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E6DC911571BF6
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 00:21:02 -0700 (PDT)
IronPort-SDR: ATCqbaVWb51xLTUnyFY219XS7ZrXMw6jYPSY/pK3y+O8RBhnT1CAwWc79WwJDtUjJwrpxB60aU
 613mQjYePkBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129632992"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="129632992"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:02 -0700
IronPort-SDR: 8i/TZE8qfmw3EhMgZhG/RVSFnd+u3sPC5jkD2v98KRJWRdSZ/qmdi+GKnE2LirhYp+nvpHB/Ax
 DUj5ubNB3hxw==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="300484565"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:01 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC V2 02/17] x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
Date: Fri, 17 Jul 2020 00:20:41 -0700
Message-Id: <20200717072056.73134-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: QHQP5P24K3MSW235DGCN7EMRMCXCHRIE
X-Message-ID-Hash: QHQP5P24K3MSW235DGCN7EMRMCXCHRIE
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QHQP5P24K3MSW235DGCN7EMRMCXCHRIE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Fenghua Yu <fenghua.yu@intel.com>

Define a helper, get_new_pkr(), which will be used to support both
Protection Key User (PKU) and the new Protection Key for Supervisor
(PKS) in subsequent patches.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/pkeys.h |  2 ++
 arch/x86/kernel/fpu/xstate.c | 17 +++--------------
 arch/x86/mm/pkeys.c          | 28 ++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index be8b3e448f76..34cef29fed20 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -136,4 +136,6 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
 }
 
+u32 get_new_pkr(u32 old_pkr, int pkey, unsigned long init_val);
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index fc1ec2986e03..1def71dc8105 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -954,9 +954,7 @@ const void *get_xsave_field_ptr(int xfeature_nr)
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val)
 {
-	u32 old_pkru;
-	int pkey_shift = (pkey * PKR_BITS_PER_PKEY);
-	u32 new_pkru_bits = 0;
+	u32 old_pkru, new_pkru;
 
 	/*
 	 * This check implies XSAVE support.  OSPKE only gets
@@ -972,21 +970,12 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
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
 	/* Get old PKRU and mask off any old bits in place: */
 	old_pkru = read_pkru();
-	old_pkru &= ~((PKR_AD_BIT|PKR_WD_BIT) << pkey_shift);
+	new_pkru = get_new_pkr(old_pkru, pkey, init_val);
 
 	/* Write old part along with new part: */
-	write_pkru(old_pkru | new_pkru_bits);
+	write_pkru(new_pkru);
 
 	return 0;
 }
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index f5efb4007e74..a5c680d32930 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -208,3 +208,31 @@ static __init int setup_init_pkru(char *opt)
 	return 1;
 }
 __setup("init_pkru=", setup_init_pkru);
+
+/*
+ * Get a new pkey register value from the user values specified.
+ *
+ * Kernel users use the same flags as user space:
+ *     PKEY_DISABLE_ACCESS
+ *     PKEY_DISABLE_WRITE
+ */
+u32 get_new_pkr(u32 old_pkr, int pkey, unsigned long init_val)
+{
+	int pkey_shift = (pkey * PKR_BITS_PER_PKEY);
+	u32 new_pkr_bits = 0;
+
+	/* Set the bits we need in the register:  */
+	if (init_val & PKEY_DISABLE_ACCESS)
+		new_pkr_bits |= PKR_AD_BIT;
+	if (init_val & PKEY_DISABLE_WRITE)
+		new_pkr_bits |= PKR_WD_BIT;
+
+	/* Shift the bits in to the correct place: */
+	new_pkr_bits <<= pkey_shift;
+
+	/* Mask off any old bits in place: */
+	old_pkr &= ~((PKR_AD_BIT | PKR_WD_BIT) << pkey_shift);
+
+	/* Return the old part along with the new part: */
+	return old_pkr | new_pkr_bits;
+}
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
