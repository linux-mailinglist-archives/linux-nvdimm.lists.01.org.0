Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4196144A50
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Jan 2020 04:21:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BEA551007B8E8;
	Tue, 21 Jan 2020 19:24:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 919C11007B8EA
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 19:24:22 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 19:21:04 -0800
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400";
   d="scan'208";a="307405652"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 19:21:03 -0800
Subject: [PATCH v4 5/6] x86/numa: Provide a range-to-target_node lookup
 facility
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@redhat.com
Date: Tue, 21 Jan 2020 19:05:01 -0800
Message-ID: <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: Z7YD3VQWXIIEB36BKQSWSLVEBJCS4DKO
X-Message-ID-Hash: Z7YD3VQWXIIEB36BKQSWSLVEBJCS4DKO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, kbuild test robot <lkp@intel.com>, hch@lst.de, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z7YD3VQWXIIEB36BKQSWSLVEBJCS4DKO/>
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
 arch/x86/mm/numa.c   |   68 +++++++++++++++++++++++++++++++++++++++++++-------
 include/linux/numa.h |    8 +++++-
 mm/mempolicy.c       |    5 ++++
 3 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 5289d9d6799a..f2c8fca36f28 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -26,6 +26,7 @@ struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
 
 static struct numa_meminfo numa_meminfo __initdata_numa;
+static struct numa_meminfo numa_reserved_meminfo __initdata_numa;
 
 static int numa_distance_cnt;
 static u8 *numa_distance;
@@ -164,6 +165,26 @@ void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi)
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
@@ -233,14 +254,19 @@ int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
 	for (i = 0; i < mi->nr_blks; i++) {
 		struct numa_memblk *bi = &mi->blk[i];
 
-		/* make sure all blocks are inside the limits */
+		/* move / save reserved memory ranges */
+		if (!memblock_overlaps_region(&memblock.memory,
+					bi->start, bi->end - bi->start)) {
+			numa_move_memblk(&numa_reserved_meminfo, i--, mi);
+			continue;
+		}
+
+		/* make sure all non-reserved blocks are inside the limits */
 		bi->start = max(bi->start, low);
 		bi->end = min(bi->end, high);
 
-		/* and there's no empty or non-exist block */
-		if (bi->start >= bi->end ||
-		    !memblock_overlaps_region(&memblock.memory,
-			bi->start, bi->end - bi->start))
+		/* and there's no empty block */
+		if (bi->start >= bi->end)
 			numa_remove_memblk_from(i--, mi);
 	}
 
@@ -877,16 +903,38 @@ EXPORT_SYMBOL(cpumask_of_node);
 
 #endif	/* !CONFIG_DEBUG_PER_CPU_MAPS */
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-int memory_add_physaddr_to_nid(u64 start)
+#ifdef CONFIG_KEEP_NUMA
+static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
 {
-	struct numa_meminfo *mi = &numa_meminfo;
-	int nid = mi->blk[0].nid;
 	int i;
 
 	for (i = 0; i < mi->nr_blks; i++)
 		if (mi->blk[i].start <= start && mi->blk[i].end > start)
-			nid = mi->blk[i].nid;
+			return mi->blk[i].nid;
+	return NUMA_NO_NODE;
+}
+
+int phys_to_target_node(phys_addr_t start)
+{
+	int nid = meminfo_to_nid(&numa_meminfo, start);
+
+	/*
+	 * Prefer online nodes, but if reserved memory might be
+	 * hot-added continue the search with reserved ranges.
+	 */
+	if (nid != NUMA_NO_NODE)
+		return nid;
+
+	return meminfo_to_nid(&numa_reserved_meminfo, start);
+}
+EXPORT_SYMBOL_GPL(phys_to_target_node);
+
+int memory_add_physaddr_to_nid(u64 start)
+{
+	int nid = meminfo_to_nid(&numa_meminfo, start);
+
+	if (nid == NUMA_NO_NODE)
+		nid = numa_meminfo.blk[0].nid;
 	return nid;
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
diff --git a/include/linux/numa.h b/include/linux/numa.h
index c005ed6b807b..cad0ab165619 100644
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
@@ -21,11 +21,17 @@
 
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
index bcb012645809..ed376d57e527 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3011,3 +3011,8 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
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
