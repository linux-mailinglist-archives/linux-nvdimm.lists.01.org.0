Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DF0FFB40
	for <lists+linux-nvdimm@lfdr.de>; Sun, 17 Nov 2019 19:00:27 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EE834100DC40F;
	Sun, 17 Nov 2019 10:01:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 27832100DC3F4
	for <linux-nvdimm@lists.01.org>; Sun, 17 Nov 2019 10:01:29 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 10:00:23 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400";
   d="scan'208";a="195907454"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 10:00:23 -0800
Subject: [PATCH v2 17/18] x86/numa: Provide a range-to-target_node lookup
 facility
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 17 Nov 2019 09:46:07 -0800
Message-ID: <157401276776.43284.12396353118982684546.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: YSMJ7X26TWJWX4B4UQLIHKKK5RG5HTOL
X-Message-ID-Hash: YSMJ7X26TWJWX4B4UQLIHKKK5RG5HTOL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, kbuild test robot <lkp@intel.com>, hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YSMJ7X26TWJWX4B4UQLIHKKK5RG5HTOL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The DEV_DAX_KMEM facility is a generic mechanism to allow device-dax
instances, fronting performance-differentiated-memory like pmem, to be
added to the System RAM pool. The numa node for that hot-added memory is
derived from the device-dax instance's 'target_node' attribute.

Recall that the 'target_node' is the ACPI-PXM-to-node translation for
memory when it comes online whereas the 'numa_node' attribute of the
device represents the closest online cpu node.

Presently useful target_node information from the ACPI SRAT is discarded
with the expectation that "Reserved" memory will never be onlined. Now,
DEV_DAX_KMEM violates that assumption, there is a need to retain the
translation. Move, rather than discard, numa_memblk data to a secondary
array that memory_add_physaddr_to_target_node() may consider at a later
point in time.

Note that memory_add_physaddr_to_nid() is currently only available on
CONFIG_MEMORY_HOTPLUG=y platforms whereas the target node information
may be useful on CONFIG_MEMORY_HOTPLUG=n builds, hence why it is calling
phys_to_target_node() and optionally defined by asm/io.h rather than a
memory_add_physaddr_to_target_nid() helper that lives in
include/linux/memory_hotplug.h.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/numa.c   |   76 +++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/numa.h |    8 +++++
 mm/mempolicy.c       |    5 +++
 3 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 4123100e0eaf..f4f02ac0c465 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -31,6 +31,24 @@ __initdata
 #endif
 ;
 
+/*
+ * Presently, DEV_DAX_KMEM is the only kernel facility that might
+ * convert Reserved or Soft Reserved memory to System RAM.
+ */
+#if IS_ENABLED(CONFIG_DEV_DAX_KMEM)
+static struct numa_meminfo __numa_reserved_meminfo;
+
+static struct numa_meminfo *numa_reserved_meminfo(void)
+{
+	return &__numa_reserved_meminfo;
+}
+#else
+static struct numa_meminfo *numa_reserved_meminfo(void)
+{
+	return NULL;
+}
+#endif
+
 static int numa_distance_cnt;
 static u8 *numa_distance;
 
@@ -168,6 +186,26 @@ void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi)
 		(mi->nr_blks - idx) * sizeof(mi->blk[0]));
 }
 
+/**
+ * numa_move_memblk - Move one numa_memblk from one numa_meminfo to another
+ * @dst: numa_meminfo to move block to
+ * @idx: Index of memblk to remove
+ * @src: numa_meminfo to remove memblk from
+ *
+ * If @dst is non-NULL add it at the @dst->nr_blks index and increment
+ * @dst->nr_blks, then remove it from @src.
+ */
+static void __init numa_move_memblk(struct numa_meminfo *dst, int idx,
+		struct numa_meminfo *src)
+{
+	if (dst) {
+		memcpy(&dst->blk[dst->nr_blks], &src->blk[idx],
+				sizeof(struct numa_memblk));
+		dst->nr_blks++;
+	}
+	numa_remove_memblk_from(idx, src);
+}
+
 /**
  * numa_add_memblk - Add one numa_memblk to numa_meminfo
  * @nid: NUMA node ID of the new memblk
@@ -245,7 +283,7 @@ int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
 		if (bi->start >= bi->end ||
 		    !memblock_overlaps_region(&memblock.memory,
 			bi->start, bi->end - bi->start))
-			numa_remove_memblk_from(i--, mi);
+			numa_move_memblk(numa_reserved_meminfo(), i--, mi);
 	}
 
 	/* merge neighboring / overlapping entries */
@@ -881,16 +919,44 @@ EXPORT_SYMBOL(cpumask_of_node);
 
 #endif	/* !CONFIG_DEBUG_PER_CPU_MAPS */
 
+static int meminfo_to_nid(struct numa_meminfo *mi, u64 start, int *nid)
+{
+	int i;
+
+	for (i = 0; mi && i < mi->nr_blks; i++)
+		if (mi->blk[i].start <= start && mi->blk[i].end > start) {
+			*nid = mi->blk[i].nid;
+			break;
+		}
+	return i;
+}
+
+int phys_to_target_node(phys_addr_t start)
+{
+	struct numa_meminfo *mi = &numa_meminfo;
+	int nid = mi->blk[0].nid;
+	int i = meminfo_to_nid(mi, start, &nid);
+
+	/*
+	 * Prefer online nodes, but if reserved memory might be
+	 * hot-added continue the search with reserved ranges.
+	 */
+	if (i < mi->nr_blks)
+		return nid;
+
+	mi = numa_reserved_meminfo();
+	meminfo_to_nid(mi, start, &nid);
+	return nid;
+}
+EXPORT_SYMBOL_GPL(phys_to_target_node);
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 int memory_add_physaddr_to_nid(u64 start)
 {
 	struct numa_meminfo *mi = &numa_meminfo;
 	int nid = mi->blk[0].nid;
-	int i;
 
-	for (i = 0; i < mi->nr_blks; i++)
-		if (mi->blk[i].start <= start && mi->blk[i].end > start)
-			nid = mi->blk[i].nid;
+	meminfo_to_nid(mi, start, &nid);
 	return nid;
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 20f4e44b186c..941790a0765b 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_NUMA_H
 #define _LINUX_NUMA_H
-
+#include <linux/types.h>
 
 #ifdef CONFIG_NODES_SHIFT
 #define NODES_SHIFT     CONFIG_NODES_SHIFT
@@ -15,11 +15,17 @@
 
 #ifdef CONFIG_NUMA
 int numa_map_to_online_node(int node);
+int phys_to_target_node(phys_addr_t addr);
 #else
 static inline int numa_map_to_online_node(int node)
 {
 	return NUMA_NO_NODE;
 }
+
+static inline int phys_to_target_node(phys_addr_t addr)
+{
+	return NUMA_NO_NODE;
+}
 #endif
 
 #endif /* _LINUX_NUMA_H */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d618121bcc17..0db8b446e23e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2996,3 +2996,8 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
 			       nodemask_pr_args(&nodes));
 }
+
+__weak int phys_to_target_node(phys_addr_t addr)
+{
+	return NUMA_NO_NODE;
+}
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
