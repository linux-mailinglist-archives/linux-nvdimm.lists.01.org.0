Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E362A5EFB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Nov 2020 08:53:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D6B64100A01B0;
	Tue,  3 Nov 2020 23:53:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2DA8916576B23
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 23:53:35 -0800 (PST)
IronPort-SDR: 4LPzYn71U1hC5JZcNX9qUljdOyOPfdH2WoenOmYaahcYlyNtYKk2MIOPpgARF4g0AejMfkeLFs
 5jqbnOFhEbYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="169320875"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400";
   d="scan'208";a="169320875"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 23:53:35 -0800
IronPort-SDR: OJrcFKbT7KoP1CnLiIvdHIlx7bwAjoimk1aWHvFfA5WZLTfnMtKrkyZUp0Xv7+uuR0UkD1hTlK
 BV248dHFNyug==
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400";
   d="scan'208";a="353707452"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 23:53:34 -0800
Subject: [PATCH v3] mm: Fix phys_to_target_node() and
 memory_add_physaddr_to_nid() exports
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Tue, 03 Nov 2020 23:53:33 -0800
Message-ID: <160447639846.1133764.7044090803980177548.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: WKQMDBIY7VSP3HPGOW6LJLLSV4JL3DNV
X-Message-ID-Hash: WKQMDBIY7VSP3HPGOW6LJLLSV4JL3DNV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>, Joao Martins <joao.m.martins@oracle.com>, x86@kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-mm@kvack.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WKQMDBIY7VSP3HPGOW6LJLLSV4JL3DNV/>
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
Changes since v2 [1]:
- Fixed build on archs that don't have asm/sparsemem.h, but do use
  linux/numa.h (kbuild-robot)
- Fixed header include paths that need linux/printk.h for the
  pr_info_once() in the default implementations. (kbuild-robot)

[1]: http://lore.kernel.org/r/CAPcyv4gj9ibFuBY1yt79CdKRgYAftdveXT1Ow4QvyRxri4jBRA@mail.gmail.com

 arch/ia64/include/asm/sparsemem.h    |    6 ++++++
 arch/powerpc/include/asm/sparsemem.h |    3 ++-
 arch/x86/include/asm/sparsemem.h     |   10 ++++++++++
 arch/x86/mm/numa.c                   |    2 ++
 drivers/dax/Kconfig                  |    1 -
 include/linux/memory_hotplug.h       |   14 --------------
 include/linux/numa.h                 |   30 +++++++++++++++++++++++++++++-
 mm/memory_hotplug.c                  |   18 ------------------
 8 files changed, 49 insertions(+), 35 deletions(-)

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
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 1e6fa371cc38..52519d2c5713 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -16,6 +16,8 @@
 extern int create_section_mapping(unsigned long start, unsigned long end,
 				  int nid, pgprot_t prot);
 extern int remove_section_mapping(unsigned long start, unsigned long end);
+extern int memory_add_physaddr_to_nid(u64 start);
+#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
 
 #ifdef CONFIG_NUMA
 extern int hot_add_scn_to_nid(unsigned long scn_addr);
@@ -26,6 +28,5 @@ static inline int hot_add_scn_to_nid(unsigned long scn_addr)
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
