Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB45239EBA
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 07:18:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 99E9D12A6D4C7;
	Sun,  2 Aug 2020 22:18:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1914E12A6D4C0
	for <linux-nvdimm@lists.01.org>; Sun,  2 Aug 2020 22:18:54 -0700 (PDT)
IronPort-SDR: lQZ2dWcEFmPwUmt+pH6eYWP/+Ay0DiQn380d1+fvEczGjgIJBT1FafML9OPX3KRXui2gcOfx8C
 HuN+vnPon+2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="170149588"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="170149588"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:18:54 -0700
IronPort-SDR: 5/uk95UVnaMbZWyxeU7dTtYZhuFlj2wOtG7bigVO/6+5nFuEJNdAXlTZNRMdq1Y362/HNuckmO
 C6sN7TVeb4PQ==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="466357180"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:18:53 -0700
Subject: [PATCH v4 02/23] x86/numa: Add 'nohmat' option
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Sun, 02 Aug 2020 22:02:35 -0700
Message-ID: <159643095540.4062302.732962081968036212.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 4KLQBWGQDJJFQ3ACFGMZ5AK7WCRTVZPH
X-Message-ID-Hash: 4KLQBWGQDJJFQ3ACFGMZ5AK7WCRTVZPH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, joao.m.martins@oracle.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4KLQBWGQDJJFQ3ACFGMZ5AK7WCRTVZPH/>
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
 Documentation/x86/x86_64/boot-options.rst |    4 ++++
 arch/x86/mm/numa.c                        |    2 ++
 drivers/acpi/numa/hmat.c                  |    8 +++++++-
 include/acpi/acpi_numa.h                  |    8 ++++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 2b98efb5ba7f..324cefff92e7 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -173,6 +173,10 @@ NUMA
   numa=noacpi
     Don't parse the SRAT table for NUMA setup
 
+  numa=nohmat
+    Don't parse the HMAT table for NUMA setup, or soft-reserved memory
+    partitioning.
+
   numa=fake=<size>[MG]
     If given as a memory unit, fills all system RAM with nodes of
     size interleaved over physical nodes.
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 87c52822cc44..f3805bbaa784 100644
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
