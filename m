Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C0329059A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Oct 2020 14:55:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1CA381595B100;
	Fri, 16 Oct 2020 05:55:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E24CD15628843
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 05:55:24 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1602852921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFWVugT+dTTDWBodFUMTGKF6FcevqFcG4mwU/SJ4v3Y=;
	b=SNrpEftLssya9LMStEuqL5omNeFMJKimnual6z3+V6aJAqwaUJ7YhPr4HzoDb5wJNKmhRa
	ERXtUA+56vN9HATCTKMxDnfdtRHBWpx51mO+jg65f8EUy0e8KQSw9VR/MgAZeIF2yb4pIJ
	I8n7wZQnZwcr+K19jvygnHDNq4Jk/L0IBKQg2QRt/1nxF+GrNzUTrIIeEE/5W9iFdWRaC8
	lUCpqI+kFsLqt/pBhvB4Tb9aeb+1JzLwvWXgr0Nn+pnOmqqfBQEZLUJDWw7Riu+RZAobpx
	u2dPba2xPUPusgwNKAatKpyuyYl0UYBTxqbdxYuQCB+X8rh00DTnvQrUQEncLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1602852921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFWVugT+dTTDWBodFUMTGKF6FcevqFcG4mwU/SJ4v3Y=;
	b=iwKyGQXNsIU0MpOOMuSbEs4FgUEjJn4OHYUpcfwCy4h0dcT5Zw7jZ+W1pdwzI3jGgKmLmi
	IWRicg8gEqquLqBg==
To: Peter Zijlstra <peterz@infradead.org>, ira.weiny@intel.com
Subject: Re: [PATCH RFC V3 6/9] x86/entry: Pass irqentry_state_t by reference
In-Reply-To: <20201016114510.GO2611@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com> <20201009194258.3207172-7-ira.weiny@intel.com> <20201016114510.GO2611@hirez.programming.kicks-ass.net>
Date: Fri, 16 Oct 2020 14:55:21 +0200
Message-ID: <87lfg6tjnq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: SLSWYVBLY6PXILQWR7FPWKWP72UO3NTY
X-Message-ID-Hash: SLSWYVBLY6PXILQWR7FPWKWP72UO3NTY
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SLSWYVBLY6PXILQWR7FPWKWP72UO3NTY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 16 2020 at 13:45, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 12:42:55PM -0700, ira.weiny@intel.com wrote:
>> @@ -238,7 +236,7 @@ noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
>>  
>>  	rcu_nmi_exit();
>>  	lockdep_hardirq_exit();
>> -	if (restore)
>> +	if (irq_state->exit_rcu)
>>  		lockdep_hardirqs_on(CALLER_ADDR0);
>>  	__nmi_exit();
>>  }
>
> That's not nice.. The NMI path is different from the IRQ path and has a
> different variable. Yes, this works, but *groan*.
>
> Maybe union them if you want to avoid bloating the structure, but the
> above makes it really hard to read.

Right, and also that nmi entry thing should not be in x86. Something
like the untested below as first cleanup.

Thanks,

        tglx
----
Subject: x86/entry: Move nmi entry/exit into common code
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 11 Sep 2020 10:09:56 +0200

Add blurb here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c         |   34 ----------------------------------
 arch/x86/include/asm/idtentry.h |    3 ---
 arch/x86/kernel/cpu/mce/core.c  |    6 +++---
 arch/x86/kernel/nmi.c           |    6 +++---
 arch/x86/kernel/traps.c         |   13 +++++++------
 include/linux/entry-common.h    |   20 ++++++++++++++++++++
 kernel/entry/common.c           |   36 ++++++++++++++++++++++++++++++++++++
 7 files changed, 69 insertions(+), 49 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -209,40 +209,6 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
-noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
-{
-	bool irq_state = lockdep_hardirqs_enabled();
-
-	__nmi_enter();
-	lockdep_hardirqs_off(CALLER_ADDR0);
-	lockdep_hardirq_enter();
-	rcu_nmi_enter();
-
-	instrumentation_begin();
-	trace_hardirqs_off_finish();
-	ftrace_nmi_enter();
-	instrumentation_end();
-
-	return irq_state;
-}
-
-noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
-{
-	instrumentation_begin();
-	ftrace_nmi_exit();
-	if (restore) {
-		trace_hardirqs_on_prepare();
-		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-	}
-	instrumentation_end();
-
-	rcu_nmi_exit();
-	lockdep_hardirq_exit();
-	if (restore)
-		lockdep_hardirqs_on(CALLER_ADDR0);
-	__nmi_exit();
-}
-
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,9 +11,6 @@
 
 #include <asm/irq_stack.h>
 
-bool idtentry_enter_nmi(struct pt_regs *regs);
-void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
-
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1983,7 +1983,7 @@ void (*machine_check_vector)(struct pt_r
 
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
-	bool irq_state;
+	irqentry_state_t irq_state;
 
 	WARN_ON_ONCE(user_mode(regs));
 
@@ -1995,7 +1995,7 @@ static __always_inline void exc_machine_
 	    mce_check_crashing_cpu())
 		return;
 
-	irq_state = idtentry_enter_nmi(regs);
+	irq_state = irqentry_nmi_enter(regs);
 	/*
 	 * The call targets are marked noinstr, but objtool can't figure
 	 * that out because it's an indirect call. Annotate it.
@@ -2006,7 +2006,7 @@ static __always_inline void exc_machine_
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
 	instrumentation_end();
-	idtentry_exit_nmi(regs, irq_state);
+	irqentry_nmi_exit(regs, irq_state);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -475,7 +475,7 @@ static DEFINE_PER_CPU(unsigned long, nmi
 
 DEFINE_IDTENTRY_RAW(exc_nmi)
 {
-	bool irq_state;
+	irqentry_state_t irq_state;
 
 	/*
 	 * Re-enable NMIs right here when running as an SEV-ES guest. This might
@@ -502,14 +502,14 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	this_cpu_write(nmi_dr7, local_db_save());
 
-	irq_state = idtentry_enter_nmi(regs);
+	irq_state = irqentry_nmi_enter(regs);
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
-	idtentry_exit_nmi(regs, irq_state);
+	irqentry_nmi_exit(regs, irq_state);
 
 	local_db_restore(this_cpu_read(nmi_dr7));
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -405,7 +405,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
-	idtentry_enter_nmi(regs);
+	irqentry_nmi_enter(regs);
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
@@ -651,12 +651,13 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
 	} else {
-		bool irq_state = idtentry_enter_nmi(regs);
+		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
+
 		instrumentation_begin();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
 		instrumentation_end();
-		idtentry_exit_nmi(regs, irq_state);
+		irqentry_nmi_exit(regs, irq_state);
 	}
 }
 
@@ -864,7 +865,7 @@ static __always_inline void exc_debug_ke
 	 * includes the entry stack is excluded for everything.
 	 */
 	unsigned long dr7 = local_db_save();
-	bool irq_state = idtentry_enter_nmi(regs);
+	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
 	instrumentation_begin();
 
 	/*
@@ -907,7 +908,7 @@ static __always_inline void exc_debug_ke
 		regs->flags &= ~X86_EFLAGS_TF;
 out:
 	instrumentation_end();
-	idtentry_exit_nmi(regs, irq_state);
+	irqentry_nmi_exit(regs, irq_state);
 
 	local_db_restore(dr7);
 }
@@ -925,7 +926,7 @@ static __always_inline void exc_debug_us
 
 	/*
 	 * NB: We can't easily clear DR7 here because
-	 * idtentry_exit_to_usermode() can invoke ptrace, schedule, access
+	 * irqentry_exit_to_usermode() can invoke ptrace, schedule, access
 	 * user memory, etc.  This means that a recursive #DB is possible.  If
 	 * this happens, that #DB will hit exc_debug_kernel() and clear DR7.
 	 * Since we're not on the IST stack right now, everything will be
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -343,6 +343,7 @@ void irqentry_exit_to_user_mode(struct p
 #ifndef irqentry_state
 typedef struct irqentry_state {
 	bool	exit_rcu;
+	bool	lockdep;
 } irqentry_state_t;
 #endif
 
@@ -402,4 +403,23 @@ void irqentry_exit_cond_resched(void);
  */
 void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
 
+/**
+ * irqentry_nmi_enter - Handle NMI entry
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Similar to irqentry_enter() but taking care of the NMI constraints.
+ */
+irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
+
+/**
+ * irqentry_nmi_exit - Handle return from NMI handling
+ * @regs:	Pointer to pt_regs (NMI entry regs)
+ * @state:	Return value from matching call to irqentry_nmi_enter()
+ *
+ * Last action before returning to the low level assmenbly code.
+ *
+ * Counterpart to irqentry_nmi_enter().
+ */
+void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
+
 #endif
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -398,3 +398,39 @@ noinstr void irqentry_exit(struct pt_reg
 			rcu_irq_exit();
 	}
 }
+
+irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
+{
+	irqentry_state_t irq_state;
+
+	irq_state.lockdep = lockdep_hardirqs_enabled();
+
+	__nmi_enter();
+	lockdep_hardirqs_off(CALLER_ADDR0);
+	lockdep_hardirq_enter();
+	rcu_nmi_enter();
+
+	instrumentation_begin();
+	trace_hardirqs_off_finish();
+	ftrace_nmi_enter();
+	instrumentation_end();
+
+	return irq_state;
+}
+
+void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
+{
+	instrumentation_begin();
+	ftrace_nmi_exit();
+	if (irq_state.lockdep) {
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	}
+	instrumentation_end();
+
+	rcu_nmi_exit();
+	lockdep_hardirq_exit();
+	if (irq_state.lockdep)
+		lockdep_hardirqs_on(CALLER_ADDR0);
+	__nmi_exit();
+}




_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
