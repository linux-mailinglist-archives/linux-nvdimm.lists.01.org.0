Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8068F2A89A2
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Nov 2020 23:20:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 89AE915871FDC;
	Thu,  5 Nov 2020 14:20:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2BA8C15871FDB
	for <linux-nvdimm@lists.01.org>; Thu,  5 Nov 2020 14:20:46 -0800 (PST)
IronPort-SDR: tuetu96YgXhI7U7rpw/e4HrA0cK9eEPONhNTIIo4ikPBGkJKHOMHFc/LR5ssa3bDSpBlWdW6RP
 6O4zzD6HKHYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="168687896"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400";
   d="scan'208";a="168687896"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 14:20:45 -0800
IronPort-SDR: bOAVfyu+KueSEN9nosKYs4vXRID1dOH9ydtKcBymqaFdCPjQAuHqTOH7fIiLI1bBy9wfg42tzh
 fae5qTi3wSJg==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400";
   d="scan'208";a="337391492"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 14:20:45 -0800
Subject: [PATCH v4] mm: Fix phys_to_target_node() and
 memory_add_physaddr_to_nid() exports
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Thu, 05 Nov 2020 14:20:45 -0800
Message-ID: <160461461867.1505359.5301571728749534585.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: XLFNMBR6OTOOM6L6IN4RAJHDR6SYY6JS
X-Message-ID-Hash: XLFNMBR6OTOOM6L6IN4RAJHDR6SYY6JS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Joao Martins <joao.m.martins@oracle.com>, x86@kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-mm@kvack.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XLFNMBR6OTOOM6L6IN4RAJHDR6SYY6JS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The core-mm has a default __weak implementation of phys_to_target_node()
to mirror the weak definition of memory_add_physaddr_to_nid(). That
symbol is exported for modules. However, while the export in
mm/memory_hotplug.c exported the symbol in the configuration cases of:

	CONFIG_NUMA_KEEP_MEMINFO=y
	CONFIG_MEMORY_HOTPLUG=y

...and:

	CONFIG_NUMA_KEEP_MEMINFO=n
	CONFIG_MEMORY_HOTPLUG=y

...it failed to export the symbol in the case of:

	CONFIG_NUMA_KEEP_MEMINFO=y
	CONFIG_MEMORY_HOTPLUG=n

Not only is that broken, but Christoph points out that the kernel should
not be exporting any __weak symbol, which means that
memory_add_physaddr_to_nid() example that phys_to_target_node() copied
is broken too.

Rework the definition of phys_to_target_node() and
memory_add_physaddr_to_nid() to not require weak symbols. Move to the
common arch override design-pattern of an asm header defining a symbol
to replace the default implementation.

The only common header that all memory_add_physaddr_to_nid() producing
architectures implement is asm/sparsemem.h. In fact, powerpc already
defines its memory_add_physaddr_to_nid() helper in sparsemem.h.
Double-down on that observation and define phys_to_target_node() where
necessary in asm/sparsemem.h. An alternate consideration that was
discarded was to put this override in asm/numa.h, but that entangles
with the definition of MAX_NUMNODES relative to the inclusion of
linux/nodemask.h, and requires powerpc to grow a new header.

The dependency on NUMA_KEEP_MEMINFO for DEV_DAX_HMEM_DEVICES is invalid
now that the symbol is properly exported / stubbed in all combinations
of CONFIG_NUMA_KEEP_MEMINFO and CONFIG_MEMORY_HOTPLUG.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: a035b6bf863e ("mm/memory_hotplug: introduce default phys_to_target_node() implementation")
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3 [1]:
- (Stephen) PowerPC header include dependencies make it difficult to
  include asm/sparsemem.h in linux/numa.h due to missing definition of
  pgprot.  Move the declaration of create_section_mapping() to
  asm/mmzone.h. This has received a build success notification from the
  kbuild-robot over 159 configs.

[1]: http://lore.kernel.org/r/160447639846.1133764.7044090803980177548.stgit@dwillia2-desk3.amr.corp.intel.com

 arch/ia64/include/asm/sparsemem.h    |    6 ++++++
 arch/powerpc/include/asm/mmzone.h    |    2 ++
 arch/powerpc/include/asm/sparsemem.h |    5 ++---
 arch/x86/include/asm/sparsemem.h     |   10 ++++++++++
 arch/x86/mm/numa.c                   |    2 ++
 drivers/dax/Kconfig                  |    1 -
 include/linux/memory_hotplug.h       |   14 --------------
 include/linux/numa.h                 |   30 +++++++++++++++++++++++++++++-
 mm/memory_hotplug.c                  |   18 ------------------
 9 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/arch/ia64/include/asm/sparsemem.h b/arch/ia64/include/asm/sparsemem.h
index 336d0570e1fa..dd8c166ffd7b 100644
--- a/arch/ia64/include/asm/sparsemem.h
+++ b/arch/ia64/include/asm/sparsemem.h
@@ -18,4 +18,10 @@
 #endif
 
 #endif /* CONFIG_SPARSEMEM */
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int memory_add_physaddr_to_nid(u64 addr);
+#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+#endif
+
 #endif /* _ASM_IA64_SPARSEMEM_H */
diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 91c69ff53a8a..177fd18caf83 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -33,6 +33,8 @@ extern struct pglist_data *node_data[];
 extern int numa_cpu_lookup_table[];
 extern cpumask_var_t node_to_cpumask_map[];
 #ifdef CONFIG_MEMORY_HOTPLUG
+extern int create_section_mapping(unsigned long start, unsigned long end,
+				  int nid, pgprot_t prot);
 extern unsigned long max_pfn;
 u64 memory_hotplug_max(void);
 #else
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 1e6fa371cc38..d072866842e4 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -13,9 +13,9 @@
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern int create_section_mapping(unsigned long start, unsigned long end,
-				  int nid, pgprot_t prot);
 extern int remove_section_mapping(unsigned long start, unsigned long end);
+extern int memory_add_physaddr_to_nid(u64 start);
+#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
 
 #ifdef CONFIG_NUMA
 extern int hot_add_scn_to_nid(unsigned long scn_addr);
@@ -26,6 +26,5 @@ static inline int hot_add_scn_to_nid(unsigned long scn_addr)
 }
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_MEMORY_HOTPLUG */
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_SPARSEMEM_H */
diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 6bfc878f6771..6a9ccc1b2be5 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -28,4 +28,14 @@
 #endif
 
 #endif /* CONFIG_SPARSEMEM */
+
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_NUMA_KEEP_MEMINFO
+extern int phys_to_target_node(phys_addr_t start);
+#define phys_to_target_node phys_to_target_node
+extern int memory_add_physaddr_to_nid(u64 start);
+#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+#endif
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_SPARSEMEM_H */
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 44148691d78b..5eb4dc2b97da 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -938,6 +938,7 @@ int phys_to_target_node(phys_addr_t start)
 
 	return meminfo_to_nid(&numa_reserved_meminfo, start);
 }
+EXPORT_SYMBOL_GPL(phys_to_target_node);
 
 int memory_add_physaddr_to_nid(u64 start)
 {
@@ -947,4 +948,5 @@ int memory_add_physaddr_to_nid(u64 start)
 		nid = numa_meminfo.blk[0].nid;
 	return nid;
 }
+EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #endif
diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 567428e10b7b..d2834c2cfa10 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -50,7 +50,6 @@ config DEV_DAX_HMEM
 	  Say M if unsure.
 
 config DEV_DAX_HMEM_DEVICES
-	depends on NUMA_KEEP_MEMINFO # for phys_to_target_node()
 	depends on DEV_DAX_HMEM && DAX=y
 	def_bool y
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index d65c6fdc5cfc..551093b74596 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -281,20 +281,6 @@ static inline bool movable_node_is_enabled(void)
 }
 #endif /* ! CONFIG_MEMORY_HOTPLUG */
 
-#ifdef CONFIG_NUMA
-extern int memory_add_physaddr_to_nid(u64 start);
-extern int phys_to_target_node(u64 start);
-#else
-static inline int memory_add_physaddr_to_nid(u64 start)
-{
-	return 0;
-}
-static inline int phys_to_target_node(u64 start)
-{
-	return 0;
-}
-#endif
-
 #if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_DEFERRED_STRUCT_PAGE_INIT)
 /*
  * pgdat resizing functions
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 8cb33ccfb671..cb44cfe2b725 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -21,13 +21,41 @@
 #endif
 
 #ifdef CONFIG_NUMA
+#include <linux/printk.h>
+#include <asm/sparsemem.h>
+
 /* Generic implementation available */
 int numa_map_to_online_node(int node);
-#else
+
+#ifndef memory_add_physaddr_to_nid
+static inline int memory_add_physaddr_to_nid(u64 start)
+{
+	pr_info_once("Unknown online node for memory at 0x%llx, assuming node 0\n",
+			start);
+	return 0;
+}
+#endif
+#ifndef phys_to_target_node
+static inline int phys_to_target_node(u64 start)
+{
+	pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
+			start);
+	return 0;
+}
+#endif
+#else /* !CONFIG_NUMA */
 static inline int numa_map_to_online_node(int node)
 {
 	return NUMA_NO_NODE;
 }
+static inline int memory_add_physaddr_to_nid(u64 start)
+{
+	return 0;
+}
+static inline int phys_to_target_node(u64 start)
+{
+	return 0;
+}
 #endif
 
 #endif /* _LINUX_NUMA_H */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b44d4c7ba73b..63b2e46b6555 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -350,24 +350,6 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	return err;
 }
 
-#ifdef CONFIG_NUMA
-int __weak memory_add_physaddr_to_nid(u64 start)
-{
-	pr_info_once("Unknown online node for memory at 0x%llx, assuming node 0\n",
-			start);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
-
-int __weak phys_to_target_node(u64 start)
-{
-	pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
-			start);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(phys_to_target_node);
-#endif
-
 /* find the smallest valid pfn in the range [start_pfn, end_pfn) */
 static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
 				     unsigned long start_pfn,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
