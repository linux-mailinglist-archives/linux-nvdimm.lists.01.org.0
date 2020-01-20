Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C5514320E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jan 2020 20:19:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECFF11007B8CB;
	Mon, 20 Jan 2020 11:22:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 25D651007B8CB
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 11:22:34 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 11:19:15 -0800
X-IronPort-AV: E=Sophos;i="5.70,343,1574150400";
   d="scan'208";a="276230181"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 11:19:14 -0800
Subject: [PATCH v3 4/6] x86/mm: Introduce CONFIG_KEEP_NUMA
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@redhat.com
Date: Mon, 20 Jan 2020 11:03:11 -0800
Message-ID: <157954699175.2239526.11943452958490066628.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: DEWUUMIOF66RYTXQACOBW5MZHZSSE2XK
X-Message-ID-Hash: DEWUUMIOF66RYTXQACOBW5MZHZSSE2XK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, hch@lst.de, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DEWUUMIOF66RYTXQACOBW5MZHZSSE2XK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently x86 numa_meminfo is marked __initdata in the
CONFIG_MEMORY_HOTPLUG=n case. In support of a new facility to allow
drivers to map reserved memory to a 'target_node'
(phys_to_target_node()), add support for removing the __initdata
designation for those users. Both memory hotplug and
phys_to_target_node() users select CONFIG_KEEP_NUMA to tell the arch to
maintain its physical address to numa mapping infrastructure post init.

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
 arch/x86/mm/numa.c   |    6 +-----
 include/linux/numa.h |    6 ++++++
 mm/Kconfig           |    5 +++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 99f7a68738f0..5289d9d6799a 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -25,11 +25,7 @@ nodemask_t numa_nodes_parsed __initdata;
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
 
-static struct numa_meminfo numa_meminfo
-#ifndef CONFIG_MEMORY_HOTPLUG
-__initdata
-#endif
-;
+static struct numa_meminfo numa_meminfo __initdata_numa;
 
 static int numa_distance_cnt;
 static u8 *numa_distance;
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 20f4e44b186c..c005ed6b807b 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -13,6 +13,12 @@
 
 #define	NUMA_NO_NODE	(-1)
 
+#ifdef CONFIG_KEEP_NUMA
+#define __initdata_numa
+#else
+#define __initdata_numa __initdata
+#endif
+
 #ifdef CONFIG_NUMA
 int numa_map_to_online_node(int node);
 #else
diff --git a/mm/Kconfig b/mm/Kconfig
index ab80933be65f..001f1185eadf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -139,6 +139,10 @@ config HAVE_FAST_GUP
 config ARCH_KEEP_MEMBLOCK
 	bool
 
+# Keep arch numa mapping infrastructure post-init.
+config KEEP_NUMA
+	bool
+
 config MEMORY_ISOLATION
 	bool
 
@@ -154,6 +158,7 @@ config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
 	depends on SPARSEMEM || X86_64_ACPI_NUMA
 	depends on ARCH_ENABLE_MEMORY_HOTPLUG
+	select KEEP_NUMA if NUMA
 
 config MEMORY_HOTPLUG_SPARSE
 	def_bool y
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
