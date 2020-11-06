Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DFE2AA13E
	for <lists+linux-nvdimm@lfdr.de>; Sat,  7 Nov 2020 00:29:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 326AB1646674E;
	Fri,  6 Nov 2020 15:29:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1C1A71646674E
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 15:29:29 -0800 (PST)
IronPort-SDR: l54lUpumAy09uWqOPl5mNX6nG0ir5sfERTgya8WrTpWB/5o1xBBddsFguaYtfKvQmGT8mJK83/
 OO1hDW3IHwrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="231243456"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400";
   d="scan'208";a="231243456"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:29 -0800
IronPort-SDR: 1ES4I5KGE9/iQYuHavLR3ZvLoW1cMW+esxCjx6rlsohqLFCcUWqfg0Pvf3vMvAgl1nEDHEOWnh
 npZOhvWYt5jw==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400";
   d="scan'208";a="321757360"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:29 -0800
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
Date: Fri,  6 Nov 2020 15:29:02 -0800
Message-Id: <20201106232908.364581-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201106232908.364581-1-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: WE2KWYJXEI3QZ6P4BADYF5JKE5C6R3DQ
X-Message-ID-Hash: WE2KWYJXEI3QZ6P4BADYF5JKE5C6R3DQ
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WE2KWYJXEI3QZ6P4BADYF5JKE5C6R3DQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

The PKRS MSR is defined as a per-logical-processor register.  This
isolates memory access by logical CPU.  Unfortunately, the MSR is not
managed by XSAVE.  Therefore, tasks must save/restore the MSR value on
context switch.

Define a saved PKRS value in the task struct, as well as a cached
per-logical-processor MSR value which mirrors the MSR value of the
current CPU.  Initialize all tasks with the default MSR value.  Then, on
schedule in, check the saved task MSR vs the per-cpu value.  If
different proceed to write the MSR.  If not avoid the overhead of the
MSR write and continue.

Follow on patches will update the saved PKRS as well as the MSR if
needed.

Finally it should be noted that the underlying WRMSR(MSR_IA32_PKRS) is
not serializing but still maintains ordering properties similar to
WRPKRU.  The current SDM section on PKRS needs updating but should be
the same as that of WRPKRU.  So to quote from the WRPKRU text:

	WRPKRU will never execute transiently. Memory accesses affected
	by PKRU register will not execute (even transiently) until all
	prior executions of WRPKRU have completed execution and updated
	the PKRU register.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2
	Adjust for PKS enable being final patch.

Changes from V1
	Rebase to latest tip/master
		Resolve conflicts with INIT_THREAD changes

Changes since RFC V3
	Per Dave Hansen
		Update commit message
		move saved_pkrs to be in a nicer place
	Per Peter Zijlstra
		Add Comment from Peter
		Clean up white space
		Update authorship
---
 arch/x86/include/asm/msr-index.h    |  1 +
 arch/x86/include/asm/pkeys_common.h | 20 +++++++++++++++++++
 arch/x86/include/asm/processor.h    | 18 ++++++++++++++++-
 arch/x86/kernel/process.c           | 26 ++++++++++++++++++++++++
 arch/x86/mm/pkeys.c                 | 31 +++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 972a34d93505..ddb125e44408 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -754,6 +754,7 @@
 
 #define MSR_IA32_TSC_DEADLINE		0x000006E0
 
+#define MSR_IA32_PKRS			0x000006E1
 
 #define MSR_TSX_FORCE_ABORT		0x0000010F
 
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
index 737d916f476c..801a75615209 100644
--- a/arch/x86/include/asm/pkeys_common.h
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -12,4 +12,24 @@
  */
 #define PKR_AD_KEY(pkey)	(PKR_AD_BIT << ((pkey) * PKR_BITS_PER_PKEY))
 
+/*
+ * Define a default PKRS value for each task.
+ *
+ * Key 0 has no restriction.  All other keys are set to the most restrictive
+ * value which is access disabled (AD=1).
+ *
+ * NOTE: This needs to be a macro to be used as part of the INIT_THREAD macro.
+ */
+#define INIT_PKRS_VALUE (PKR_AD_KEY(1) | PKR_AD_KEY(2) | PKR_AD_KEY(3) | \
+			 PKR_AD_KEY(4) | PKR_AD_KEY(5) | PKR_AD_KEY(6) | \
+			 PKR_AD_KEY(7) | PKR_AD_KEY(8) | PKR_AD_KEY(9) | \
+			 PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) | \
+			 PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15))
+
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+void write_pkrs(u32 new_pkrs);
+#else
+static inline void write_pkrs(u32 new_pkrs) { }
+#endif
+
 #endif /*_ASM_X86_PKEYS_INTERNAL_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 82a08b585818..e9c65368b0b2 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -18,6 +18,7 @@ struct vm86;
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
+#include <asm/pkeys_common.h>
 #include <asm/percpu.h>
 #include <asm/msr.h>
 #include <asm/desc_defs.h>
@@ -520,6 +521,12 @@ struct thread_struct {
 	unsigned long		cr2;
 	unsigned long		trap_nr;
 	unsigned long		error_code;
+
+#ifdef	CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+	/* Saved Protection key register for supervisor mappings */
+	u32			saved_pkrs;
+#endif
+
 #ifdef CONFIG_VM86
 	/* Virtual 86 mode info */
 	struct vm86		*vm86;
@@ -785,7 +792,16 @@ static inline void spin_lock_prefetch(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 #else
-#define INIT_THREAD { }
+
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+#define INIT_THREAD_PKRS	.saved_pkrs = INIT_PKRS_VALUE
+#else
+#define INIT_THREAD_PKRS	0
+#endif
+
+#define INIT_THREAD  {						\
+	INIT_THREAD_PKRS,					\
+}
 
 extern unsigned long KSTK_ESP(struct task_struct *task);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ba4593a913fa..aa2ae5292ff1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -43,6 +43,7 @@
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
 #include <asm/frame.h>
+#include <asm/pkeys_common.h>
 
 #include "process.h"
 
@@ -187,6 +188,27 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	return ret;
 }
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+DECLARE_PER_CPU(u32, pkrs_cache);
+static inline void pks_init_task(struct task_struct *tsk)
+{
+	/* New tasks get the most restrictive PKRS value */
+	tsk->thread.saved_pkrs = INIT_PKRS_VALUE;
+}
+static inline void pks_sched_in(void)
+{
+	/*
+	 * PKRS is only temporarily changed during specific code paths.  Only a
+	 * preemption during these windows away from the default value would
+	 * require updating the MSR.  write_pkrs() handles this optimization.
+	 */
+	write_pkrs(current->thread.saved_pkrs);
+}
+#else
+static inline void pks_init_task(struct task_struct *tsk) { }
+static inline void pks_sched_in(void) { }
+#endif
+
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
@@ -195,6 +217,8 @@ void flush_thread(void)
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
 	fpu__clear_all(&tsk->thread.fpu);
+
+	pks_init_task(tsk);
 }
 
 void disable_TSC(void)
@@ -644,6 +668,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 
 	if ((tifp ^ tifn) & _TIF_SLD)
 		switch_to_sld(tifn);
+
+	pks_sched_in();
 }
 
 /*
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index d1dfe743e79f..76a62419c446 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -231,3 +231,34 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
 
 	return pk_reg;
 }
+
+DEFINE_PER_CPU(u32, pkrs_cache);
+
+/**
+ * write_pkrs() optimizes MSR writes by maintaining a per cpu cache which can
+ * be checked quickly.
+ *
+ * It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
+ * serializing but still maintains ordering properties similar to WRPKRU.
+ * The current SDM section on PKRS needs updating but should be the same as
+ * that of WRPKRU.  So to quote from the WRPKRU text:
+ *
+ *     WRPKRU will never execute transiently. Memory accesses
+ *     affected by PKRU register will not execute (even transiently)
+ *     until all prior executions of WRPKRU have completed execution
+ *     and updated the PKRU register.
+ */
+void write_pkrs(u32 new_pkrs)
+{
+	u32 *pkrs;
+
+	if (!static_cpu_has(X86_FEATURE_PKS))
+		return;
+
+	pkrs = get_cpu_ptr(&pkrs_cache);
+	if (*pkrs != new_pkrs) {
+		*pkrs = new_pkrs;
+		wrmsrl(MSR_IA32_PKRS, new_pkrs);
+	}
+	put_cpu_ptr(pkrs);
+}
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
