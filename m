Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5C721E904
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 09:04:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8679610056B00;
	Tue, 14 Jul 2020 00:04:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4494110056AF5
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 00:04:04 -0700 (PDT)
IronPort-SDR: FiYQOQlE4V106baBvZ3jnkENt8BmKVAUN0cXJWnznX5+d35z4A3NPhMwJTiBg6FQGj5Yzjm8H8
 Iub0SPJigJdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146839866"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="146839866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:03 -0700
IronPort-SDR: nY/DFM9nVSCaOf42CJfiKh58xiTvUpfFPmJqpldQG8mdSpoKtENIWvEW6a2fSkGue2L/MLfD8V
 mS8Mw6tqq+8g==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="485774305"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:03 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 02/15] x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
Date: Tue, 14 Jul 2020 00:02:07 -0700
Message-Id: <20200714070220.3500839-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714070220.3500839-1-ira.weiny@intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: SPVCTJREW4TFDUBKMO3VR2TD24ZJZDXE
X-Message-ID-Hash: SPVCTJREW4TFDUBKMO3VR2TD24ZJZDXE
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SPVCTJREW4TFDUBKMO3VR2TD24ZJZDXE/>
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
2.25.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
