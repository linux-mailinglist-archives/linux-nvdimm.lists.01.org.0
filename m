Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F657234FC0
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Aug 2020 05:41:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D10812963220;
	Fri, 31 Jul 2020 20:41:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C78071296135F
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 20:41:25 -0700 (PDT)
IronPort-SDR: XV0fKsQPyVO80g30ybHGKEn9V1t0YTqBi6CuANeHRGHmvbqqGZ9wrrP1rR/qsgiRrhbr6fEx5U
 a0p4rv5J1ZgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="213438721"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800";
   d="scan'208";a="213438721"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:41:25 -0700
IronPort-SDR: PzyT216fbru6TMGk6kyZBw0/yH7LXZvMLRgf4YvJzFkxdE6JuPNh+j4NhEom3gPVhtl22vACjz
 lcgJs0RG8Bmw==
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800";
   d="scan'208";a="331356834"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:41:25 -0700
Subject: [PATCH v3 01/23] x86/numa: Cleanup configuration dependent
 command-line options
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Fri, 31 Jul 2020 20:25:07 -0700
Message-ID: <159625230748.3040297.7810071890452186177.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: GDBPWLFZIHLIKDVNLAWYF7H42QT4V3QJ
X-Message-ID-Hash: GDBPWLFZIHLIKDVNLAWYF7H42QT4V3QJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, joao.m.martins@oracle.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GDBPWLFZIHLIKDVNLAWYF7H42QT4V3QJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for adding a new numa= option clean up the existing ones
to avoid ifdefs in numa_setup(), and provide feedback when the option is
numa=fake= option is invalid due to kernel config. The same does not
need to be done for numa=noacpi, since the capability is already hard
disabled at compile-time.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/numa.h  |    8 +++++++-
 arch/x86/mm/numa.c           |    8 ++------
 arch/x86/mm/numa_emulation.c |    3 ++-
 arch/x86/xen/enlighten_pv.c  |    2 +-
 drivers/acpi/numa/srat.c     |    9 +++++++--
 include/acpi/acpi_numa.h     |    6 +++++-
 6 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index bbfde3d2662f..0aecc0b629e0 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_NUMA_H
 
 #include <linux/nodemask.h>
+#include <linux/errno.h>
 
 #include <asm/topology.h>
 #include <asm/apicdef.h>
@@ -77,7 +78,12 @@ void debug_cpumask_set_cpu(int cpu, int node, bool enable);
 #ifdef CONFIG_NUMA_EMU
 #define FAKE_NODE_MIN_SIZE	((u64)32 << 20)
 #define FAKE_NODE_MIN_HASH_MASK	(~(FAKE_NODE_MIN_SIZE - 1UL))
-void numa_emu_cmdline(char *);
+int numa_emu_cmdline(char *str);
+#else /* CONFIG_NUMA_EMU */
+static inline int numa_emu_cmdline(char *str)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_NUMA_EMU */
 
 #endif	/* _ASM_X86_NUMA_H */
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index aa76ec2d359b..87c52822cc44 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -37,14 +37,10 @@ static __init int numa_setup(char *opt)
 		return -EINVAL;
 	if (!strncmp(opt, "off", 3))
 		numa_off = 1;
-#ifdef CONFIG_NUMA_EMU
 	if (!strncmp(opt, "fake=", 5))
-		numa_emu_cmdline(opt + 5);
-#endif
-#ifdef CONFIG_ACPI_NUMA
+		return numa_emu_cmdline(opt + 5);
 	if (!strncmp(opt, "noacpi", 6))
-		acpi_numa = -1;
-#endif
+		disable_srat();
 	return 0;
 }
 early_param("numa", numa_setup);
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index c5174b4e318b..847c23196e57 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -13,9 +13,10 @@
 static int emu_nid_to_phys[MAX_NUMNODES];
 static char *emu_cmdline __initdata;
 
-void __init numa_emu_cmdline(char *str)
+int __init numa_emu_cmdline(char *str)
 {
 	emu_cmdline = str;
+	return 0;
 }
 
 static int __init emu_find_memblk_by_nid(int nid, const struct numa_meminfo *mi)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 2aab43a13a8c..64b81ba5a4d6 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1350,7 +1350,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	 * any NUMA information the kernel tries to get from ACPI will
 	 * be meaningless.  Prevent it from trying.
 	 */
-	acpi_numa = -1;
+	disable_srat();
 #endif
 	WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_pv, xen_cpu_dead_pv));
 
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 15bbaab8500b..1b0ae0a1959b 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -27,7 +27,12 @@ static int node_to_pxm_map[MAX_NUMNODES]
 			= { [0 ... MAX_NUMNODES - 1] = PXM_INVAL };
 
 unsigned char acpi_srat_revision __initdata;
-int acpi_numa __initdata;
+static int acpi_numa __initdata;
+
+void __init disable_srat(void)
+{
+	acpi_numa = -1;
+}
 
 int pxm_to_node(int pxm)
 {
@@ -163,7 +168,7 @@ static int __init slit_valid(struct acpi_table_slit *slit)
 void __init bad_srat(void)
 {
 	pr_err("SRAT: SRAT not used.\n");
-	acpi_numa = -1;
+	disable_srat();
 }
 
 int __init srat_disabled(void)
diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index fdebcfc6c8df..8784183b2204 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -17,10 +17,14 @@ extern int pxm_to_node(int);
 extern int node_to_pxm(int);
 extern int acpi_map_pxm_to_node(int);
 extern unsigned char acpi_srat_revision;
-extern int acpi_numa __initdata;
+extern void disable_srat(void);
 
 extern void bad_srat(void);
 extern int srat_disabled(void);
 
+#else				/* CONFIG_ACPI_NUMA */
+static inline void disable_srat(void)
+{
+}
 #endif				/* CONFIG_ACPI_NUMA */
 #endif				/* __ACP_NUMA_H */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
