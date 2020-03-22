Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501CA18EA5E
	for <lists+linux-nvdimm@lfdr.de>; Sun, 22 Mar 2020 17:28:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60A3310FC3602;
	Sun, 22 Mar 2020 09:29:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 282B310FC35BF
	for <linux-nvdimm@lists.01.org>; Sun, 22 Mar 2020 09:29:33 -0700 (PDT)
IronPort-SDR: SjqDYWTsDn/UYuXOPBfN6dzYMzQh02qWQdZ/PRGiyI4auvTQTyDHM27iO3RnlGbu6gPLJpHnm7
 I0YU6+7p6zWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:42 -0700
IronPort-SDR: xjxO2EKMTrcHuqu+2bBXG9RZo4A2aIqynGuLHSmjXlIVizBScPoZEIlPf6VPVravz0jgNm2qgE
 QoxhnnnY/Sbg==
X-IronPort-AV: E=Sophos;i="5.72,293,1580803200";
   d="scan'208";a="445552569"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:41 -0700
Subject: [PATCH v2 2/6] x86/numa: Add 'nohmat' option
From: Dan Williams <dan.j.williams@intel.com>
To: linux-acpi@vger.kernel.org
Date: Sun, 22 Mar 2020 09:12:35 -0700
Message-ID: <158489355512.1457606.5473443384722523736.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: WAREXSSCI2ZZQ72B2DP5NVRZNKY6YX3A
X-Message-ID-Hash: WAREXSSCI2ZZQ72B2DP5NVRZNKY6YX3A
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, ard.biesheuvel@linaro.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WAREXSSCI2ZZQ72B2DP5NVRZNKY6YX3A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Disable parsing of the HMAT for debug, to workaround broken platform
instances, or cases where it is otherwise not wanted.

Cc: x86@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/numa.c       |    2 ++
 drivers/acpi/numa/hmat.c |    8 +++++++-
 include/acpi/acpi_numa.h |    8 ++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 9c1266b2628c..250a013cbbe0 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -41,6 +41,8 @@ static __init int numa_setup(char *opt)
 		return numa_emu_cmdline(opt + 5);
 	if (!strncmp(opt, "noacpi", 6))
 		disable_srat();
+	if (!strncmp(opt, "nohmat", 6))
+		disable_hmat();
 	return 0;
 }
 early_param("numa", numa_setup);
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c32cfb72370..a12e36a12618 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -26,6 +26,12 @@
 #include <linux/sysfs.h>
 
 static u8 hmat_revision;
+static int hmat_disable __initdata;
+
+void __init disable_hmat(void)
+{
+	hmat_disable = 1;
+}
 
 static LIST_HEAD(targets);
 static LIST_HEAD(initiators);
@@ -814,7 +820,7 @@ static __init int hmat_init(void)
 	enum acpi_hmat_type i;
 	acpi_status status;
 
-	if (srat_disabled())
+	if (srat_disabled() || hmat_disable)
 		return 0;
 
 	status = acpi_get_table(ACPI_SIG_SRAT, 0, &tbl);
diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index 8784183b2204..0e9302285f14 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -27,4 +27,12 @@ static inline void disable_srat(void)
 {
 }
 #endif				/* CONFIG_ACPI_NUMA */
+
+#ifdef CONFIG_ACPI_HMAT
+extern void disable_hmat(void);
+#else				/* CONFIG_ACPI_HMAT */
+static inline void disable_hmat(void)
+{
+}
+#endif				/* CONFIG_ACPI_HMAT */
 #endif				/* __ACP_NUMA_H */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
