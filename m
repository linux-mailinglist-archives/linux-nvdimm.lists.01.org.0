Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1658239EB5
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 07:18:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7D79A12A6D4C4;
	Sun,  2 Aug 2020 22:18:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6012F12A6D4C1
	for <linux-nvdimm@lists.01.org>; Sun,  2 Aug 2020 22:18:49 -0700 (PDT)
IronPort-SDR: s1nCWJr7lfo45IearMzCX90OFvW0zdgBFUFOWHFnOB3bkBqWov7pp1S9BYgdwu/izXy+ay0aLc
 FzRnR9Ux8I1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="131611077"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="131611077"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:18:48 -0700
IronPort-SDR: +LCo4bUedE9nSXjlPM0EiHjD/pUiDmLmNnkXsuPF93u0uWOap47Cu0f/ERcv+JjvZ3jZ5vs8Rq
 cro0K03v4+5A==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="275084755"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:18:48 -0700
Subject: [PATCH v4 01/23] x86/numa: Cleanup configuration dependent
 command-line options
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Sun, 02 Aug 2020 22:02:29 -0700
Message-ID: <159643094925.4062302.14979872973043772305.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: SPKNBZGUTK3V5A4HFMH3V2J4G3HPO4WJ
X-Message-ID-Hash: SPKNBZGUTK3V5A4HFMH3V2J4G3HPO4WJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, joao.m.martins@oracle.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SPKNBZGUTK3V5A4HFMH3V2J4G3HPO4WJ/>
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
