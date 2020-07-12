Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F2A21CA3D
	for <lists+linux-nvdimm@lfdr.de>; Sun, 12 Jul 2020 18:43:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D2F71003F509;
	Sun, 12 Jul 2020 09:43:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2780A11591330
	for <linux-nvdimm@lists.01.org>; Sun, 12 Jul 2020 09:43:00 -0700 (PDT)
IronPort-SDR: dOV50sTLGkwt+MzTapj9HP/JuvjfCn0G2X11tTrx2TWsoKjPHj19NQTNu0FUy0a7COvRmBiVi7
 93WLhcKIm8cA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="233371277"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800";
   d="scan'208";a="233371277"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:42:59 -0700
IronPort-SDR: wKh/mkWpfbLzS/7XA/a+hOZMMV8DFeGdi9/Hom+z8d2kEX+RFAYAHlZYGDznOwJngG0SVv6zF8
 30sN3xvpN09g==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800";
   d="scan'208";a="485205254"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:42:59 -0700
Subject: [PATCH v2 07/22] numa: Introduce a generic
 memory_add_physaddr_to_nid()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 12 Jul 2020 09:26:43 -0700
Message-ID: <159457120334.754248.12908401960465408733.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: ZHM5AEYV3V5X2MBSCURFYSMN63EPTPA5
X-Message-ID-Hash: ZHM5AEYV3V5X2MBSCURFYSMN63EPTPA5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mike Rapoport <rppt@linux.ibm.com>, Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZHM5AEYV3V5X2MBSCURFYSMN63EPTPA5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For architectures that opt into storing their numa data in memblock
(only ARM64 currently), add a memblock generic way to interrogate that
data for memory_add_physaddr_to_nid(). This requires ARCH_KEEP_MEMBLOCK
to keep memblock text and data around after boot.

Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Jia He <justin.he@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mm.h |   11 +++++++++++
 mm/Kconfig         |    6 ++++++
 mm/page_alloc.c    |   23 ++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..1e76ee5da20b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2425,6 +2425,17 @@ unsigned long __absent_pages_in_range(int nid, unsigned long start_pfn,
 						unsigned long end_pfn);
 extern unsigned long absent_pages_in_range(unsigned long start_pfn,
 						unsigned long end_pfn);
+
+/*
+ * Allow archs to opt-in to keeping get_pfn_range_for_nid() available
+ * after boot.
+ */
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+#define __init_or_memblock
+#else
+#define __init_or_memblock __init
+#endif
+
 extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
 extern unsigned long find_min_pfn_with_active_regions(void);
diff --git a/mm/Kconfig b/mm/Kconfig
index 0051f735ad98..178ed76cae1b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -139,6 +139,12 @@ config HAVE_FAST_GUP
 config ARCH_KEEP_MEMBLOCK
 	bool
 
+# If the arch populates numa data into memblock, it can use memblock
+# apis to interrogate that data at runtime.
+config MEMBLOCK_NUMA_INFO
+	bool
+	depends on ARCH_KEEP_MEMBLOCK
+
 config MEMORY_ISOLATION
 	bool
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..df8bd169dbb4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6351,7 +6351,7 @@ void __init sparse_memory_present_with_active_regions(int nid)
  * with no available memory, a warning is printed and the start and end
  * PFNs will be 0.
  */
-void __init get_pfn_range_for_nid(unsigned int nid,
+void __init_or_memblock get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn)
 {
 	unsigned long this_start_pfn, this_end_pfn;
@@ -6369,6 +6369,27 @@ void __init get_pfn_range_for_nid(unsigned int nid,
 		*start_pfn = 0;
 }
 
+/*
+ * Generic implementation of memory_add_physaddr_to_nid() depends on
+ * architecture using memblock data for numa information.
+ */
+#ifdef CONFIG_MEMBLOCK_NUMA_INFO
+int __init_or_memblock memory_add_physaddr_to_nid(u64 addr)
+{
+	unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
+	int nid;
+
+	for_each_online_node(nid) {
+		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		if (pfn >= start_pfn && pfn <= end_pfn)
+			return nid;
+	}
+	/* Default to node0 as not all callers are prepared for this to fail */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+#endif /* CONFIG_MEMBLOCK_NUMA_INFO */
+
 /*
  * This finds a zone that can be used for ZONE_MOVABLE pages. The
  * assumption is made that zones within a node are ordered in monotonic
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
