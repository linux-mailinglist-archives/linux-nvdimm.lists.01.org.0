Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD3DF2666
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 05:12:13 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 72D44100DC2B8;
	Wed,  6 Nov 2019 20:14:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 795A1100DC2BA
	for <linux-nvdimm@lists.01.org>; Wed,  6 Nov 2019 20:14:39 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:12:09 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400";
   d="scan'208";a="196430523"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:12:09 -0800
Subject: [PATCH 14/16] x86/numa: Provide a range-to-target_node lookup
 facility
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 06 Nov 2019 19:57:53 -0800
Message-ID: <157309907296.1582359.7986676987778026949.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: 37AR3G63GEKBQTSHEBREUCU2VI7Q7LFQ
X-Message-ID-Hash: 37AR3G63GEKBQTSHEBREUCU2VI7Q7LFQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/37AR3G63GEKBQTSHEBREUCU2VI7Q7LFQ/>
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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/numa.c             |   72 +++++++++++++++++++++++++++++++++++++---
 include/linux/memory_hotplug.h |    6 +++
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 4123100e0eaf..3bbae90b3197 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -31,6 +31,20 @@ __initdata
 #endif
 ;
 
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
 
@@ -168,6 +182,26 @@ void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi)
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
+void __init numa_move_memblk(struct numa_meminfo *dst, int idx,
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
@@ -245,7 +279,7 @@ int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
 		if (bi->start >= bi->end ||
 		    !memblock_overlaps_region(&memblock.memory,
 			bi->start, bi->end - bi->start))
-			numa_remove_memblk_from(i--, mi);
+			numa_move_memblk(numa_reserved_meminfo(), i--, mi);
 	}
 
 	/* merge neighboring / overlapping entries */
@@ -882,15 +916,43 @@ EXPORT_SYMBOL(cpumask_of_node);
 #endif	/* !CONFIG_DEBUG_PER_CPU_MAPS */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
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
+int memory_add_physaddr_to_target_node(u64 start)
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
+EXPORT_SYMBOL_GPL(memory_add_physaddr_to_target_node);
+
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
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f46ea71b4ffd..84efb0f20f7e 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -145,11 +145,17 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 
 #ifdef CONFIG_NUMA
 extern int memory_add_physaddr_to_nid(u64 start);
+extern int memory_add_physaddr_to_target_node(u64 start);
 #else
 static inline int memory_add_physaddr_to_nid(u64 start)
 {
 	return 0;
 }
+
+static inline int memory_add_physaddr_to_target_node(u64 start)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
