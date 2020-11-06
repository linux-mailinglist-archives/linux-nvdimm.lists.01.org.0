Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4032AA144
	for <lists+linux-nvdimm@lfdr.de>; Sat,  7 Nov 2020 00:29:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 22AA716466760;
	Fri,  6 Nov 2020 15:29:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 269D116466762
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 15:29:43 -0800 (PST)
IronPort-SDR: ejFySXmB9vWt3j2davWdij+2mBKvTndt1Rh/PVyjBjmsbwb6DFFFvMWvD4rtV9ZNQRoPIsPXdM
 yhL1kcqaZSTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="167025668"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400";
   d="scan'208";a="167025668"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:37 -0800
IronPort-SDR: k4byyvrseYAeoBugGywJ+QOjnx9bAxJF6P0x70TOG2wyk/Qhysfn8ADhVz292RTBJTIDkyng9d
 GrFVwhEgV3Mw==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400";
   d="scan'208";a="307352972"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:37 -0800
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH V3 09/10] x86/pks: Enable Protection Keys Supervisor (PKS)
Date: Fri,  6 Nov 2020 15:29:07 -0800
Message-Id: <20201106232908.364581-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201106232908.364581-1-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: PZVBBDCTHD3WP6UG5QCGZO55HNUPYMPV
X-Message-ID-Hash: PZVBBDCTHD3WP6UG5QCGZO55HNUPYMPV
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PZVBBDCTHD3WP6UG5QCGZO55HNUPYMPV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Fenghua Yu <fenghua.yu@intel.com>

Protection Keys for Supervisor pages (PKS) enables fast, hardware thread
specific, manipulation of permission restrictions on supervisor page
mappings.  It uses the same mechanism of Protection Keys as those on
User mappings but applies that mechanism to supervisor mappings using a
supervisor specific MSR.

Kernel users can thus defines 'domains' of page mappings which have an
extra level of protection beyond those specified in the supervisor page
table entries.

Enable PKS on supported CPUS.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

---
Changes from V2
	From Thomas: Make this patch last so PKS is not enabled until
	all the PKS mechanisms are in place.  Specifically:
		1) Modify setup_pks() to call write_pkrs() to properly
		   set up the initial value when enabled.

		2) Split this patch into two. 1) a precursor patch with
		   the required defines/config options and 2) this patch
		   which actually enables feature on CPUs which support
		   it.

Changes since RFC V3
	Per Dave Hansen
		Update comment
		Add X86_FEATURE_PKS to disabled-features.h
	Rebase based on latest TIP tree
---
 arch/x86/include/asm/disabled-features.h |  6 +++++-
 arch/x86/kernel/cpu/common.c             | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 164587177152..82540f0c5b6c 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -44,7 +44,11 @@
 # define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
 #endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 
-#define DISABLE_PKS           (1<<(X86_FEATURE_PKS & 31))
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+# define DISABLE_PKS		0
+#else
+# define DISABLE_PKS		(1<<(X86_FEATURE_PKS & 31))
+#endif
 
 #ifdef CONFIG_X86_5LEVEL
 # define DISABLE_LA57	0
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 35ad8480c464..f8929a557d72 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -58,6 +58,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <linux/pkeys.h>
 
 #include "cpu.h"
 
@@ -1494,6 +1495,19 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 #endif
 }
 
+/*
+ * PKS is independent of PKU and either or both may be supported on a CPU.
+ * Configure PKS if the CPU supports the feature.
+ */
+static void setup_pks(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	write_pkrs(INIT_PKRS_VALUE);
+	cr4_set_bits(X86_CR4_PKS);
+}
+
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -1591,6 +1605,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	x86_init_rdrand(c);
 	setup_pku(c);
+	setup_pks();
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
