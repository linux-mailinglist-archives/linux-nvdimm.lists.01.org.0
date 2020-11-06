Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 731D62AA13F
	for <lists+linux-nvdimm@lfdr.de>; Sat,  7 Nov 2020 00:29:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5311F1646674A;
	Fri,  6 Nov 2020 15:29:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 81AE61646674D
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 15:29:31 -0800 (PST)
IronPort-SDR: cJG3oVdBXs+rjdXvO8fTQPezAFt42Fm2eLAdhUc82BkCb/u+F6m/SXDrWKHHwYKLP4UuD3ah6e
 vUucTKgA3ICg==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="233779201"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400";
   d="scan'208";a="233779201"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:31 -0800
IronPort-SDR: wmHgR3eZM+ax+0GqkbkM6EdwKk+j06PP1yvCoHasp8mDFxsmSHHcigkSlYo1F477oZu7RoRuXB
 6eOXL1t7gwfQ==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400";
   d="scan'208";a="528523283"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:30 -0800
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH V3 05/10] x86/entry: Pass irqentry_state_t by reference
Date: Fri,  6 Nov 2020 15:29:03 -0800
Message-Id: <20201106232908.364581-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201106232908.364581-1-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 4RKSIB7O5NLSL2CBK5G2XDCKPRP6DSKA
X-Message-ID-Hash: 4RKSIB7O5NLSL2CBK5G2XDCKPRP6DSKA
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4RKSIB7O5NLSL2CBK5G2XDCKPRP6DSKA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

Currently struct irqentry_state_t only contains a single bool value
which makes passing it by value is reasonable.  However, future patches
propose to add information to this struct, for example the PKRS
register/thread state.

Adding information to irqentry_state_t makes passing by value less
efficient.  Therefore, change the entry/exit calls to pass irq_state by
reference.

While at it, make the code easier to follow by changing all the usage
sites to consistently use the variable name 'irq_state'.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1
	From Thomas: Update commit message
	Further clean up Kernel doc and comments
		Missed some 'return' comments which are no longer valid

Changes from RFC V3
	Clean up @irq_state comments
	Standardize on 'irq_state' for the state variable name
	Refactor based on new patch from Thomas Gleixner
		Also addresses Peter Zijlstra's comment
---
 arch/x86/entry/common.c         |  8 ++++----
 arch/x86/include/asm/idtentry.h | 25 ++++++++++++++----------
 arch/x86/kernel/cpu/mce/core.c  |  4 ++--
 arch/x86/kernel/kvm.c           |  6 +++---
 arch/x86/kernel/nmi.c           |  4 ++--
 arch/x86/kernel/traps.c         | 21 ++++++++++++--------
 arch/x86/mm/fault.c             |  6 +++---
 include/linux/entry-common.h    | 18 +++++++++--------
 kernel/entry/common.c           | 34 +++++++++++++--------------------
 9 files changed, 65 insertions(+), 61 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 18d8f17f755c..87dea56a15d2 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -259,9 +259,9 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 	bool inhcall;
-	irqentry_state_t state;
+	irqentry_state_t irq_state;
 
-	state = irqentry_enter(regs);
+	irqentry_enter(regs, &irq_state);
 	old_regs = set_irq_regs(regs);
 
 	instrumentation_begin();
@@ -271,13 +271,13 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 
 	inhcall = get_and_clear_inhcall();
-	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
+	if (inhcall && !WARN_ON_ONCE(irq_state.exit_rcu)) {
 		instrumentation_begin();
 		irqentry_exit_cond_resched();
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
-		irqentry_exit(regs, state);
+		irqentry_exit(regs, &irq_state);
 	}
 }
 #endif /* CONFIG_XEN_PV */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 247a60a47331..282d2413b6a1 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -49,12 +49,13 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t irq_state;						\
 									\
+	irqentry_enter(regs, &irq_state);					\
 	instrumentation_begin();					\
 	__##func (regs);						\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit(regs, &irq_state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
@@ -96,12 +97,13 @@ static __always_inline void __##func(struct pt_regs *regs,		\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t irq_state;						\
 									\
+	irqentry_enter(regs, &irq_state);					\
 	instrumentation_begin();					\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit(regs, &irq_state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs,		\
@@ -192,15 +194,16 @@ static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t irq_state;						\
 									\
+	irqentry_enter(regs, &irq_state);					\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs, (u8)error_code);				\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit(regs, &irq_state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector)
@@ -234,15 +237,16 @@ static void __##func(struct pt_regs *regs);				\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t irq_state;						\
 									\
+	irqentry_enter(regs, &irq_state);					\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit(regs, &irq_state);					\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs)
@@ -263,15 +267,16 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t irq_state;						\
 									\
+	irqentry_enter(regs, &irq_state);					\
 	instrumentation_begin();					\
 	__irq_enter_raw();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs);						\
 	__irq_exit_raw();						\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit(regs, &irq_state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f5c860b1a50b..6ed2fa2ea321 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1995,7 +1995,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	    mce_check_crashing_cpu())
 		return;
 
-	irq_state = irqentry_nmi_enter(regs);
+	irqentry_nmi_enter(regs, &irq_state);
 	/*
 	 * The call targets are marked noinstr, but objtool can't figure
 	 * that out because it's an indirect call. Annotate it.
@@ -2006,7 +2006,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
 	instrumentation_end();
-	irqentry_nmi_exit(regs, irq_state);
+	irqentry_nmi_exit(regs, &irq_state);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7f57ede3cb8e..ed7427c6e74d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -238,12 +238,12 @@ EXPORT_SYMBOL_GPL(kvm_read_and_reset_apf_flags);
 noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
 	u32 flags = kvm_read_and_reset_apf_flags();
-	irqentry_state_t state;
+	irqentry_state_t irq_state;
 
 	if (!flags)
 		return false;
 
-	state = irqentry_enter(regs);
+	irqentry_enter(regs, &irq_state);
 	instrumentation_begin();
 
 	/*
@@ -264,7 +264,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 	}
 
 	instrumentation_end();
-	irqentry_exit(regs, state);
+	irqentry_exit(regs, &irq_state);
 	return true;
 }
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index bf250a339655..1fd7780e99dd 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -502,14 +502,14 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	this_cpu_write(nmi_dr7, local_db_save());
 
-	irq_state = irqentry_nmi_enter(regs);
+	irqentry_nmi_enter(regs, &irq_state);
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
-	irqentry_nmi_exit(regs, irq_state);
+	irqentry_nmi_exit(regs, &irq_state);
 
 	local_db_restore(this_cpu_read(nmi_dr7));
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e1b78829d909..8481cc373794 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -245,7 +245,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 
 DEFINE_IDTENTRY_RAW(exc_invalid_op)
 {
-	irqentry_state_t state;
+	irqentry_state_t irq_state;
 
 	/*
 	 * We use UD2 as a short encoding for 'CALL __WARN', as such
@@ -255,11 +255,11 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 	if (!user_mode(regs) && handle_bug(regs))
 		return;
 
-	state = irqentry_enter(regs);
+	irqentry_enter(regs, &irq_state);
 	instrumentation_begin();
 	handle_invalid_op(regs);
 	instrumentation_end();
-	irqentry_exit(regs, state);
+	irqentry_exit(regs, &irq_state);
 }
 
 DEFINE_IDTENTRY(exc_coproc_segment_overrun)
@@ -343,6 +343,7 @@ __visible void __noreturn handle_stack_overflow(const char *message,
  */
 DEFINE_IDTENTRY_DF(exc_double_fault)
 {
+	irqentry_state_t irq_state;
 	static const char str[] = "double fault";
 	struct task_struct *tsk = current;
 
@@ -405,7 +406,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
-	irqentry_nmi_enter(regs);
+	irqentry_nmi_enter(regs, &irq_state);
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
@@ -651,13 +652,15 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
 	} else {
-		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
+		irqentry_state_t irq_state;
+
+		irqentry_nmi_enter(regs, &irq_state);
 
 		instrumentation_begin();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
 		instrumentation_end();
-		irqentry_nmi_exit(regs, irq_state);
+		irqentry_nmi_exit(regs, &irq_state);
 	}
 }
 
@@ -852,7 +855,9 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 * includes the entry stack is excluded for everything.
 	 */
 	unsigned long dr7 = local_db_save();
-	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
+	irqentry_state_t irq_state;
+
+	irqentry_nmi_enter(regs, &irq_state);
 	instrumentation_begin();
 
 	/*
@@ -909,7 +914,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 		regs->flags &= ~X86_EFLAGS_TF;
 out:
 	instrumentation_end();
-	irqentry_nmi_exit(regs, irq_state);
+	irqentry_nmi_exit(regs, &irq_state);
 
 	local_db_restore(dr7);
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 82bf37a5c9ec..8d20c4c13abf 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1441,7 +1441,7 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
 	unsigned long address = read_cr2();
-	irqentry_state_t state;
+	irqentry_state_t irq_state;
 
 	prefetchw(&current->mm->mmap_lock);
 
@@ -1479,11 +1479,11 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	 * code reenabled RCU to avoid subsequent wreckage which helps
 	 * debugability.
 	 */
-	state = irqentry_enter(regs);
+	irqentry_enter(regs, &irq_state);
 
 	instrumentation_begin();
 	handle_page_fault(regs, error_code, address);
 	instrumentation_end();
 
-	irqentry_exit(regs, state);
+	irqentry_exit(regs, &irq_state);
 }
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 66938121c4b1..1193a70bcf1b 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -372,6 +372,8 @@ typedef struct irqentry_state {
 /**
  * irqentry_enter - Handle state tracking on ordinary interrupt entries
  * @regs:	Pointer to pt_regs of interrupted context
+ * @irq_state:	Pointer to an opaque object to store state information; to be
+ *              passed back to irqentry_exit()
  *
  * Invokes:
  *  - lockdep irqflag state tracking as low level ASM entry disabled
@@ -397,10 +399,8 @@ typedef struct irqentry_state {
  * For user mode entries irqentry_enter_from_user_mode() is invoked to
  * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
  * would not be possible.
- *
- * Returns: An opaque object that must be passed to idtentry_exit()
  */
-irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
+void noinstr irqentry_enter(struct pt_regs *regs, irqentry_state_t *irq_state);
 
 /**
  * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
@@ -412,7 +412,7 @@ void irqentry_exit_cond_resched(void);
 /**
  * irqentry_exit - Handle return from exception that used irqentry_enter()
  * @regs:	Pointer to pt_regs (exception entry regs)
- * @state:	Return value from matching call to irqentry_enter()
+ * @irq_state:	Pointer to state information passed to irqentry_enter()
  *
  * Depending on the return target (kernel/user) this runs the necessary
  * preemption and work checks if possible and required and returns to
@@ -423,25 +423,27 @@ void irqentry_exit_cond_resched(void);
  *
  * Counterpart to irqentry_enter().
  */
-void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
+void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t *irq_state);
 
 /**
  * irqentry_nmi_enter - Handle NMI entry
  * @regs:	Pointer to currents pt_regs
+ * @irq_state:	Pointer to an opaque object to store state information; to be
+ *              passed back to irqentry_nmi_exit()
  *
  * Similar to irqentry_enter() but taking care of the NMI constraints.
  */
-irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
+void noinstr irqentry_nmi_enter(struct pt_regs *regs, irqentry_state_t *irq_state);
 
 /**
  * irqentry_nmi_exit - Handle return from NMI handling
  * @regs:	Pointer to pt_regs (NMI entry regs)
- * @irq_state:	Return value from matching call to irqentry_nmi_enter()
+ * @irq_state:	Pointer to state information passed to irqentry_nmi_enter()
  *
  * Last action before returning to the low level assmebly code.
  *
  * Counterpart to irqentry_nmi_enter().
  */
-void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
+void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t *irq_state);
 
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index fa17baadf63e..5ed9d45fb41b 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -289,15 +289,13 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	exit_to_user_mode();
 }
 
-noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
+noinstr void irqentry_enter(struct pt_regs *regs, irqentry_state_t *irq_state)
 {
-	irqentry_state_t ret = {
-		.exit_rcu = false,
-	};
+	irq_state->exit_rcu = false;
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		return ret;
+		return;
 	}
 
 	/*
@@ -335,8 +333,8 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		trace_hardirqs_off_finish();
 		instrumentation_end();
 
-		ret.exit_rcu = true;
-		return ret;
+		irq_state->exit_rcu = true;
+		return;
 	}
 
 	/*
@@ -350,8 +348,6 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	rcu_irq_enter_check_tick();
 	trace_hardirqs_off_finish();
 	instrumentation_end();
-
-	return ret;
 }
 
 void irqentry_exit_cond_resched(void)
@@ -366,7 +362,7 @@ void irqentry_exit_cond_resched(void)
 	}
 }
 
-noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
+noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t *irq_state)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -379,7 +375,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		 * carefully and needs the same ordering of lockdep/tracing
 		 * and RCU as the return to user mode path.
 		 */
-		if (state.exit_rcu) {
+		if (irq_state->exit_rcu) {
 			instrumentation_begin();
 			/* Tell the tracer that IRET will enable interrupts */
 			trace_hardirqs_on_prepare();
@@ -401,16 +397,14 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		 * IRQ flags state is correct already. Just tell RCU if it
 		 * was not watching on entry.
 		 */
-		if (state.exit_rcu)
+		if (irq_state->exit_rcu)
 			rcu_irq_exit();
 	}
 }
 
-irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
+void noinstr irqentry_nmi_enter(struct pt_regs *regs, irqentry_state_t *irq_state)
 {
-	irqentry_state_t irq_state;
-
-	irq_state.lockdep = lockdep_hardirqs_enabled();
+	irq_state->lockdep = lockdep_hardirqs_enabled();
 
 	__nmi_enter();
 	lockdep_hardirqs_off(CALLER_ADDR0);
@@ -421,15 +415,13 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
 	instrumentation_end();
-
-	return irq_state;
 }
 
-void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
+void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t *irq_state)
 {
 	instrumentation_begin();
 	ftrace_nmi_exit();
-	if (irq_state.lockdep) {
+	if (irq_state->lockdep) {
 		trace_hardirqs_on_prepare();
 		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	}
@@ -437,7 +429,7 @@ void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
 
 	rcu_nmi_exit();
 	lockdep_hardirq_exit();
-	if (irq_state.lockdep)
+	if (irq_state->lockdep)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 	__nmi_exit();
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
