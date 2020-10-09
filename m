Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D062891F6
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 21:43:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B6707159A282B;
	Fri,  9 Oct 2020 12:43:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 071BF1594D299
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 12:43:25 -0700 (PDT)
IronPort-SDR: Il+996TFCNzM95ZF+AtPqRZ91zdV3KV79EsA6V6Wkj75vXS7BLq00MyfmXuWcLIYLCoOKHAJIR
 2gqe/HOfDnng==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="165642262"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="165642262"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:43:24 -0700
IronPort-SDR: f326VtQ/J/RWkxFiCpz/kiD7Xj+cSFF0pP15xotiHGZI291vspb/kEX97RQyX66SyO79RXGHu/
 vUNLWJVFNkxw==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="355860009"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:43:24 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC V3 7/9] x86/entry: Preserve PKRS MSR across exceptions
Date: Fri,  9 Oct 2020 12:42:56 -0700
Message-Id: <20201009194258.3207172-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009194258.3207172-1-ira.weiny@intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: JSCFLY2LWA32A4FEFSSBHRSMGGX7NFQP
X-Message-ID-Hash: JSCFLY2LWA32A4FEFSSBHRSMGGX7NFQP
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JSCFLY2LWA32A4FEFSSBHRSMGGX7NFQP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

The PKRS MSR is not managed by XSAVE.  It is preserved through a context
switch but this support leaves exception handling code open to memory
accesses during exceptions.

2 possible places for preserving this state were considered,
irqentry_state_t or pt_regs.[1]  pt_regs was much more complicated and
was potentially fraught with unintended consequences.[2]
irqentry_state_t was already an object being used in the exception
handling and is straightforward.  It is also easy for any number of
nested states to be tracked and eventually can be enhanced to store the
reference counting required to support PKS through kmap reentry

Preserve the current task's PKRS values in irqentry_state_t on exception
entry and restoring them on exception exit.

Each nested exception is further saved allowing for any number of levels
of exception handling.

Peter and Thomas both suggested parts of the patch, IDT and NMI respectively.

[1] https://lore.kernel.org/lkml/CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com/
[2] https://lore.kernel.org/lkml/874kpxx4jf.fsf@nanos.tec.linutronix.de/#t

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/entry/common.c             | 43 +++++++++++++++++++++++++++++
 arch/x86/include/asm/pkeys_common.h |  5 ++--
 arch/x86/kernel/cpu/mce/core.c      |  4 +++
 arch/x86/mm/pkeys.c                 |  2 +-
 include/linux/entry-common.h        | 12 ++++++++
 kernel/entry/common.c               | 12 ++++++--
 6 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 305da13770b6..324a8fd5ac10 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/pkeys.h>
 
 #ifdef CONFIG_XEN_PV
 #include <xen/xen-ops.h>
@@ -222,6 +223,8 @@ noinstr void idtentry_enter_nmi(struct pt_regs *regs, irqentry_state_t *irq_stat
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
 	instrumentation_end();
+
+	irq_save_pkrs(irq_state);
 }
 
 noinstr void idtentry_exit_nmi(struct pt_regs *regs, irqentry_state_t *irq_state)
@@ -238,9 +241,47 @@ noinstr void idtentry_exit_nmi(struct pt_regs *regs, irqentry_state_t *irq_state
 	lockdep_hardirq_exit();
 	if (irq_state->exit_rcu)
 		lockdep_hardirqs_on(CALLER_ADDR0);
+
+	irq_restore_pkrs(irq_state);
 	__nmi_exit();
 }
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+/*
+ * PKRS is a per-logical-processor MSR which overlays additional protection for
+ * pages which have been mapped with a protection key.
+ *
+ * The register is not maintained with XSAVE so we have to maintain the MSR
+ * value in software during context switch and exception handling.
+ *
+ * Context switches save the MSR in the task struct thus taking that value to
+ * other processors if necessary.
+ *
+ * To protect against exceptions having access to this memory we save the
+ * current running value and set the default PKRS value for the duration of the
+ * exception.  Thus preventing exception handlers from having the elevated
+ * access of the interrupted task.
+ */
+noinstr void irq_save_pkrs(irqentry_state_t *state)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	state->thread_pkrs = current->thread.saved_pkrs;
+	state->pkrs = this_cpu_read(pkrs_cache);
+	write_pkrs(INIT_PKRS_VALUE);
+}
+
+noinstr void irq_restore_pkrs(irqentry_state_t *state)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	write_pkrs(state->pkrs);
+	current->thread.saved_pkrs = state->thread_pkrs;
+}
+#endif /* CONFIG_ARCH_HAS_SUPERVISOR_PKEYS */
+
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
@@ -304,6 +345,8 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
+		/* Normally called by irqentry_exit, we must restore pkrs here */
+		irq_restore_pkrs(&state);
 		instrumentation_begin();
 		irqentry_exit_cond_resched();
 		instrumentation_end();
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
index 40464c170522..8961e2ddd6ff 100644
--- a/arch/x86/include/asm/pkeys_common.h
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -27,9 +27,10 @@
 #define        PKS_NUM_KEYS            16
 
 #ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
-void write_pkrs(u32 new_pkrs);
+DECLARE_PER_CPU(u32, pkrs_cache);
+noinstr void write_pkrs(u32 new_pkrs);
 #else
-static inline void write_pkrs(u32 new_pkrs) { }
+static __always_inline void write_pkrs(u32 new_pkrs) { }
 #endif
 
 #endif /*_ASM_X86_PKEYS_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f43a78bde670..abcd41f19669 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1904,6 +1904,8 @@ void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
+	irqentry_state_t irq_state = { };
+
 	WARN_ON_ONCE(user_mode(regs));
 
 	/*
@@ -1915,6 +1917,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 		return;
 
 	nmi_enter();
+	irq_save_pkrs(&irq_state);
 	/*
 	 * The call targets are marked noinstr, but objtool can't figure
 	 * that out because it's an indirect call. Annotate it.
@@ -1925,6 +1928,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
 	instrumentation_end();
+	irq_restore_pkrs(&irq_state);
 	nmi_exit();
 }
 
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 1d9f451b4b78..2431c68ef752 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -247,7 +247,7 @@ DEFINE_PER_CPU(u32, pkrs_cache);
  * 	until all prior executions of WRPKRU have completed execution
  * 	and updated the PKRU register.
  */
-void write_pkrs(u32 new_pkrs)
+noinstr void write_pkrs(u32 new_pkrs)
 {
 	u32 *pkrs;
 
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index de4f24c554ee..c3b361ffa059 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -342,10 +342,22 @@ void irqentry_exit_to_user_mode(struct pt_regs *regs);
 
 #ifndef irqentry_state
 typedef struct irqentry_state {
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+	u32 pkrs;
+	u32 thread_pkrs;
+#endif
 	bool	exit_rcu;
 } irqentry_state_t;
 #endif
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+noinstr void irq_save_pkrs(irqentry_state_t *state);
+noinstr void irq_restore_pkrs(irqentry_state_t *state);
+#else
+static __always_inline void irq_save_pkrs(irqentry_state_t *state) { }
+static __always_inline void irq_restore_pkrs(irqentry_state_t *state) { }
+#endif
+
 /**
  * irqentry_enter - Handle state tracking on ordinary interrupt entries
  * @regs:	Pointer to pt_regs of interrupted context
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 21601993ad1b..b6fb3f580673 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -327,7 +327,7 @@ noinstr void irqentry_enter(struct pt_regs *regs, irqentry_state_t *state)
 		instrumentation_end();
 
 		state->exit_rcu = true;
-		return;
+		goto done;
 	}
 
 	/*
@@ -341,6 +341,9 @@ noinstr void irqentry_enter(struct pt_regs *regs, irqentry_state_t *state)
 	/* Use the combo lockdep/tracing function */
 	trace_hardirqs_off();
 	instrumentation_end();
+
+done:
+	irq_save_pkrs(state);
 }
 
 void irqentry_exit_cond_resched(void)
@@ -362,7 +365,12 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t *state)
 	/* Check whether this returns to user mode */
 	if (user_mode(regs)) {
 		irqentry_exit_to_user_mode(regs);
-	} else if (!regs_irqs_disabled(regs)) {
+		return;
+	}
+
+	irq_restore_pkrs(state);
+
+	if (!regs_irqs_disabled(regs)) {
 		/*
 		 * If RCU was not watching on entry this needs to be done
 		 * carefully and needs the same ordering of lockdep/tracing
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
