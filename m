Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C339121CA3A
	for <lists+linux-nvdimm@lfdr.de>; Sun, 12 Jul 2020 18:42:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 768101159132C;
	Sun, 12 Jul 2020 09:42:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 64D2911591331
	for <linux-nvdimm@lists.01.org>; Sun, 12 Jul 2020 09:42:54 -0700 (PDT)
IronPort-SDR: T39Hsj/eiAx+ZxZgFhkepaPxLt0/RLGsWQZxzqJ3CNKaJGFlgIDHsCNkvsUqtVDpsY1EuWUNXM
 xnr2Kz4a/Gng==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="128087068"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800";
   d="scan'208";a="128087068"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:42:54 -0700
IronPort-SDR: dHWrCRJ+HxfA5mS5m5a07vIUByQdHXhRhyHku++9gHnv8GIa0fupPpqzL860YfYMPw+fVAcKlc
 zgjvtM21YP5Q==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800";
   d="scan'208";a="429128322"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:42:54 -0700
Subject: [PATCH v2 06/22] x86: Move NUMA_KEEP_MEMINFO and related definition
 to x86-internals
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 12 Jul 2020 09:26:38 -0700
Message-ID: <159457119816.754248.17444705191598115716.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: FB4QCKMYXP5VQJLF7SLO54DZWQE5VO2R
X-Message-ID-Hash: FB4QCKMYXP5VQJLF7SLO54DZWQE5VO2R
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FB4QCKMYXP5VQJLF7SLO54DZWQE5VO2R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

x86 is the lone architecture that uses numa_meminfo. Move and rename
NUMA_KEEP_MEMINFO from the core mm/Kconfig to X86_NUMA_KEEP_MEMINFO in
arch/x86/mm/Kconfig. This is in preparation for defining a generic
memblock based implementation of memory_add_physaddr_to_nid() and
phys_to_target_node().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/Kconfig            |    7 ++++++-
 arch/x86/mm/numa.c          |    2 +-
 arch/x86/mm/numa_internal.h |    7 +++++++
 include/linux/numa.h        |    7 -------
 mm/Kconfig                  |    5 -----
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6a0cc524882d..fc9264ea4041 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1560,6 +1560,11 @@ config NUMA
 
 	  Otherwise, you should say N.
 
+# Keep NUMA mapping infrastructure post-init.
+config X86_NUMA_KEEP_MEMINFO
+	def_bool MEMORY_HOTPLUG
+	depends on NUMA
+
 config AMD_NUMA
 	def_bool y
 	prompt "Old style AMD Opteron NUMA detection"
@@ -1640,7 +1645,7 @@ config X86_PMEM_LEGACY
 	depends on PHYS_ADDR_T_64BIT
 	depends on BLK_DEV
 	select X86_PMEM_LEGACY_DEVICE
-	select NUMA_KEEP_MEMINFO if NUMA
+	select X86_NUMA_KEEP_MEMINFO if NUMA
 	select LIBNVDIMM
 	help
 	  Treat memory marked using the non-standard e820 type of 12 as used
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 44fdf06d497e..311d22cf8ac2 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -893,7 +893,7 @@ EXPORT_SYMBOL(cpumask_of_node);
 
 #endif	/* !CONFIG_DEBUG_PER_CPU_MAPS */
 
-#ifdef CONFIG_NUMA_KEEP_MEMINFO
+#ifdef CONFIG_X86_NUMA_KEEP_MEMINFO
 static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
 {
 	int i;
diff --git a/arch/x86/mm/numa_internal.h b/arch/x86/mm/numa_internal.h
index 86860f279662..7b843414335f 100644
--- a/arch/x86/mm/numa_internal.h
+++ b/arch/x86/mm/numa_internal.h
@@ -11,6 +11,13 @@ struct numa_memblk {
 	int			nid;
 };
 
+/* optionally keep NUMA memory info available post init */
+#ifdef CONFIG_X86_NUMA_KEEP_MEMINFO
+#define __initdata_or_meminfo
+#else
+#define __initdata_or_meminfo __initdata
+#endif
+
 struct numa_meminfo {
 	int			nr_blks;
 	struct numa_memblk	blk[NR_NODE_MEMBLKS];
diff --git a/include/linux/numa.h b/include/linux/numa.h
index a42df804679e..5d25c5de1322 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -13,13 +13,6 @@
 
 #define	NUMA_NO_NODE	(-1)
 
-/* optionally keep NUMA memory info available post init */
-#ifdef CONFIG_NUMA_KEEP_MEMINFO
-#define __initdata_or_meminfo
-#else
-#define __initdata_or_meminfo __initdata
-#endif
-
 #ifdef CONFIG_NUMA
 /* Generic implementation available */
 int numa_map_to_online_node(int node);
diff --git a/mm/Kconfig b/mm/Kconfig
index f2104cc0d35c..0051f735ad98 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -139,10 +139,6 @@ config HAVE_FAST_GUP
 config ARCH_KEEP_MEMBLOCK
 	bool
 
-# Keep arch NUMA mapping infrastructure post-init.
-config NUMA_KEEP_MEMINFO
-	bool
-
 config MEMORY_ISOLATION
 	bool
 
@@ -159,7 +155,6 @@ config MEMORY_HOTPLUG
 	depends on SPARSEMEM || X86_64_ACPI_NUMA
 	depends on ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on 64BIT || BROKEN
-	select NUMA_KEEP_MEMINFO if NUMA
 
 config MEMORY_HOTPLUG_SPARSE
 	def_bool y
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
