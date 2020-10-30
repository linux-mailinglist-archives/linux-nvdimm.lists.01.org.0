Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF3429FB3D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Oct 2020 03:29:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 014071624BC1F;
	Thu, 29 Oct 2020 19:29:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CEB20159BE226
	for <linux-nvdimm@lists.01.org>; Thu, 29 Oct 2020 19:29:46 -0700 (PDT)
IronPort-SDR: 6QvmBF04H+h0+1NYMbBfX7qlTsilyCtguFSYtJt1vmuNbuBp5sc0MKM++81CRYBlrMVpLVef8U
 tljK9Xf3ifAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="253256297"
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400";
   d="scan'208";a="253256297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 19:29:46 -0700
IronPort-SDR: 0m9zSQ8Ulvc9GCrW6m5p/5A7Eo0WvOT6RcYkfymBIH3tsBgCJGtLsWEZfarcpK8N3kCHMJXU50
 K+XkQwr1gaqg==
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400";
   d="scan'208";a="319177425"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 19:29:45 -0700
Subject: [PATCH] x86/mm: Fix phys_to_target_node() export
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Thu, 29 Oct 2020 19:29:45 -0700
Message-ID: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: E2CQYIAIDLUCP6CFCG3PLXORSYXUNKZ2
X-Message-ID-Hash: E2CQYIAIDLUCP6CFCG3PLXORSYXUNKZ2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>, Joao Martins <joao.m.martins@oracle.com>, x86@kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E2CQYIAIDLUCP6CFCG3PLXORSYXUNKZ2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The core-mm has a default __weak implementation of phys_to_target_node()
when the architecture does not override it. That symbol is exported
for modules. However, while the export in mm/memory_hotplug.c exported
the symbol in the configuration cases of:

	CONFIG_NUMA_KEEP_MEMINFO=y
	CONFIG_MEMORY_HOTPLUG=y

...and:

	CONFIG_NUMA_KEEP_MEMINFO=n
	CONFIG_MEMORY_HOTPLUG=y

...it failed to export the symbol in the case of:

	CONFIG_NUMA_KEEP_MEMINFO=y
	CONFIG_MEMORY_HOTPLUG=n

Always export the symbol from the CONFIG_NUMA_KEEP_MEMINFO section of
arch/x86/mm/numa.c, and teach mm/memory_hotplug.c to optionally export
in case arch/x86/mm/numa.c has already performed the export.

The dependency on NUMA_KEEP_MEMINFO for DEV_DAX_HMEM_DEVICES is invalid
now that the symbol is properly exported in all combinations of
CONFIG_NUMA_KEEP_MEMINFO and CONFIG_MEMORY_HOTPLUG. Note that in the
CONFIG_NUMA=n case no export is needed since their is a dummy static
inline implementation of phys_to_target_node() in that case.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: kernel test robot <lkp@intel.com>
Fixes: a035b6bf863e ("mm/memory_hotplug: introduce default phys_to_target_node() implementation")
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/numa.c  |    1 +
 drivers/dax/Kconfig |    1 -
 mm/memory_hotplug.c |    5 +++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 44148691d78b..e025947f19e0 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -938,6 +938,7 @@ int phys_to_target_node(phys_addr_t start)
 
 	return meminfo_to_nid(&numa_reserved_meminfo, start);
 }
+EXPORT_SYMBOL_GPL(phys_to_target_node);
 
 int memory_add_physaddr_to_nid(u64 start)
 {
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
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b44d4c7ba73b..ed326b489674 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -365,9 +365,14 @@ int __weak phys_to_target_node(u64 start)
 			start);
 	return 0;
 }
+
+/* If the arch did not export a strong symbol, export the weak one. */
+#ifndef CONFIG_NUMA_KEEP_MEMINFO
 EXPORT_SYMBOL_GPL(phys_to_target_node);
 #endif
 
+#endif
+
 /* find the smallest valid pfn in the range [start_pfn, end_pfn) */
 static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
 				     unsigned long start_pfn,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
