Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B15F289283
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 21:51:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5AA1159A284B;
	Fri,  9 Oct 2020 12:51:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E8767159A284A
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 12:51:23 -0700 (PDT)
IronPort-SDR: NrQMHTwvR9hCGU59S3GqkUujIjv78bui+qu+sR+RqDTHiijKF4elhGpy1jhjxIWO8wJu8sxjYr
 bopskpvLpYDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="165592004"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="165592004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:51:07 -0700
IronPort-SDR: q86t8daZNt+V6d8RNukEYKSCMEs+oCo1U1vd6Yq1DOlnqrvHVUOvZ3CGMAsBzz1plldsK41yyY
 6uUXC42AACQg==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="317146961"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:51:06 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC PKS/PMEM 06/58] kmap: Introduce k[un]map_thread debugging
Date: Fri,  9 Oct 2020 12:49:41 -0700
Message-Id: <20201009195033.3208459-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: GK6RYO3UNF7LP2MCXWVEUW4KBXABQSGJ
X-Message-ID-Hash: GK6RYO3UNF7LP2MCXWVEUW4KBXABQSGJ
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi@vger.kernel.org, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infr
 adead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GK6RYO3UNF7LP2MCXWVEUW4KBXABQSGJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

Most kmap() callers use the map within a single thread and have no need
for the protection domain to be enabled globally.

To differentiate these kmap users, new k[un]map_thread() calls were
introduced which are thread local.

To aid in debugging the new use of kmap_thread(), add a reference count,
a check on that count, and tracing to ID where mapping errors occur.

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/highmem.h            |  5 +++
 include/linux/sched.h              |  5 +++
 include/trace/events/kmap_thread.h | 56 ++++++++++++++++++++++++++++++
 init/init_task.c                   |  3 ++
 kernel/fork.c                      | 15 ++++++++
 lib/Kconfig.debug                  |  8 +++++
 mm/debug.c                         | 23 ++++++++++++
 7 files changed, 115 insertions(+)
 create mode 100644 include/trace/events/kmap_thread.h

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ef7813544719..22d1c000802e 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -247,6 +247,10 @@ static inline void kunmap(struct page *page)
 	__kunmap(page, true);
 }
 
+#ifdef CONFIG_DEBUG_KMAP_THREAD
+void *kmap_thread(struct page *page);
+void kunmap_thread(struct page *page);
+#else
 static inline void *kmap_thread(struct page *page)
 {
 	return __kmap(page, false);
@@ -255,6 +259,7 @@ static inline void kunmap_thread(struct page *page)
 {
 	__kunmap(page, false);
 }
+#endif
 
 /*
  * Prevent people trying to call kunmap_atomic() as if it were kunmap()
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 25d97ab6c757..4627ea4a49e6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1318,6 +1318,11 @@ struct task_struct {
 #ifdef CONFIG_ZONE_DEVICE_ACCESS_PROTECTION
 	unsigned int			dev_page_access_ref;
 #endif
+
+#ifdef CONFIG_DEBUG_KMAP_THREAD
+	unsigned int			kmap_thread_cnt;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/trace/events/kmap_thread.h b/include/trace/events/kmap_thread.h
new file mode 100644
index 000000000000..e7143cfe0daf
--- /dev/null
+++ b/include/trace/events/kmap_thread.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+
+/*
+ * Copyright (c) 2020 Intel Corporation.  All rights reserved.
+ *
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kmap_thread
+
+#if !defined(_TRACE_KMAP_THREAD_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_KMAP_THREAD_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(kmap_thread_template,
+	TP_PROTO(struct task_struct *tsk, struct page *page,
+		 void *caller_addr, int cnt),
+	TP_ARGS(tsk, page, caller_addr, cnt),
+
+	TP_STRUCT__entry(
+		__field(int, pid)
+		__field(struct page *, page)
+		__field(void *, caller_addr)
+		__field(int, cnt)
+	),
+
+	TP_fast_assign(
+		__entry->pid = tsk->pid;
+		__entry->page = page;
+		__entry->caller_addr = caller_addr;
+		__entry->cnt = cnt;
+	),
+
+	TP_printk("PID %d; (%d) %pS %p",
+		__entry->pid,
+		__entry->cnt,
+		__entry->caller_addr,
+		__entry->page
+	)
+);
+
+DEFINE_EVENT(kmap_thread_template, kmap_thread,
+	TP_PROTO(struct task_struct *tsk, struct page *page,
+		 void *caller_addr, int cnt),
+	TP_ARGS(tsk, page, caller_addr, cnt));
+
+DEFINE_EVENT(kmap_thread_template, kunmap_thread,
+	TP_PROTO(struct task_struct *tsk, struct page *page,
+		 void *caller_addr, int cnt),
+	TP_ARGS(tsk, page, caller_addr, cnt));
+
+
+#endif /* _TRACE_KMAP_THREAD_H */
+
+#include <trace/define_trace.h>
diff --git a/init/init_task.c b/init/init_task.c
index 9b39f25de59b..19f09965eb34 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -212,6 +212,9 @@ struct task_struct init_task
 #ifdef CONFIG_ZONE_DEVICE_ACCESS_PROTECTION
 	.dev_page_access_ref = 0,
 #endif
+#ifdef CONFIG_DEBUG_KMAP_THREAD
+	.kmap_thread_cnt = 0,
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index b6a3ee328a89..2c66e49b7614 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -722,6 +722,17 @@ static inline void put_signal_struct(struct signal_struct *sig)
 		free_signal_struct(sig);
 }
 
+#ifdef CONFIG_DEBUG_KMAP_THREAD
+static void check_outstanding_kmap_thread(struct task_struct *tsk)
+{
+	if (tsk->kmap_thread_cnt)
+		pr_warn(KERN_ERR "WARNING: PID %d; Failed to kunmap_thread() [cnt %d]\n",
+			tsk->pid, tsk->kmap_thread_cnt);
+}
+#else
+static void check_outstanding_kmap_thread(struct task_struct *tsk) { }
+#endif
+
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!tsk->exit_state);
@@ -734,6 +745,7 @@ void __put_task_struct(struct task_struct *tsk)
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
+	check_outstanding_kmap_thread(tsk);
 
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
@@ -943,6 +955,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 #ifdef CONFIG_ZONE_DEVICE_ACCESS_PROTECTION
 	tsk->dev_page_access_ref = 0;
+#endif
+#ifdef CONFIG_DEBUG_KMAP_THREAD
+	tsk->kmap_thread_cnt = 0;
 #endif
 	return tsk;
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f015c09ba5a1..6507b43d5b0c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -858,6 +858,14 @@ config DEBUG_HIGHMEM
 	  This option enables additional error checking for high memory
 	  systems.  Disable for production systems.
 
+config DEBUG_KMAP_THREAD
+	bool "Kmap debugging"
+	depends on DEBUG_KERNEL
+	help
+	  This option enables additional error checking for kernel mapping code
+	  specifically the k[un]map_thread() calls.  Disable for production
+	  systems.
+
 config HAVE_DEBUG_STACKOVERFLOW
 	bool
 
diff --git a/mm/debug.c b/mm/debug.c
index ca8d1cacdecc..68d186f3570e 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -320,3 +320,26 @@ void page_init_poison(struct page *page, size_t size)
 }
 EXPORT_SYMBOL_GPL(page_init_poison);
 #endif		/* CONFIG_DEBUG_VM */
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/kmap_thread.h>
+
+#ifdef CONFIG_DEBUG_KMAP_THREAD
+void *kmap_thread(struct page *page)
+{
+	trace_kmap_thread(current, page, __builtin_return_address(0),
+			  current->kmap_thread_cnt);
+	current->kmap_thread_cnt++;
+	return __kmap(page, false);
+}
+EXPORT_SYMBOL_GPL(kmap_thread);
+
+void kunmap_thread(struct page *page)
+{
+	__kunmap(page, false);
+	current->kmap_thread_cnt--;
+	trace_kunmap_thread(current, page, __builtin_return_address(0),
+			    current->kmap_thread_cnt);
+}
+EXPORT_SYMBOL_GPL(kunmap_thread);
+#endif
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
