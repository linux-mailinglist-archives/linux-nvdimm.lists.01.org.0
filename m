Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2AAF249A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 02:57:16 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1B338100DC3F9;
	Wed,  6 Nov 2019 17:59:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EC06D100DC3F8
	for <linux-nvdimm@lists.01.org>; Wed,  6 Nov 2019 17:59:42 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 17:57:12 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400";
   d="scan'208";a="192668503"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 17:57:12 -0800
Subject: [PATCH v8 01/12] acpi/numa: Establish a new drivers/acpi/numa/
 directory
From: Dan Williams <dan.j.williams@intel.com>
To: mingo@redhat.com
Date: Wed, 06 Nov 2019 17:42:55 -0800
Message-ID: <157309097558.1579826.14734404718135954385.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: CXYBQIWQ5XZFLP7UFIWBEDL4DPTLNJPU
X-Message-ID-Hash: CXYBQIWQ5XZFLP7UFIWBEDL4DPTLNJPU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Len Brown <lenb@kernel.org>, Keith Busch <kbusch@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, peterz@infradead.org, ard.biesheuvel@linaro.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-efi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CXYBQIWQ5XZFLP7UFIWBEDL4DPTLNJPU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently hmat.c lives under an "hmat" directory which does not enhance
the description of the file. The initial motivation for giving hmat.c
its own directory was to delineate it as mm functionality in contrast to
ACPI device driver functionality.

As ACPI continues to play an increasing role in conveying
memory location and performance topology information to the OS take the
opportunity to co-locate these NUMA relevant tables in a combined
directory.

numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
hmat.c.

Cc: Len Brown <lenb@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/Kconfig       |    9 +--------
 drivers/acpi/Makefile      |    3 +--
 drivers/acpi/hmat/Makefile |    2 --
 drivers/acpi/numa/Kconfig  |    6 ++++++
 drivers/acpi/numa/Makefile |    3 +++
 drivers/acpi/numa/hmat.c   |    0 
 drivers/acpi/numa/srat.c   |    0 
 7 files changed, 11 insertions(+), 12 deletions(-)
 delete mode 100644 drivers/acpi/hmat/Makefile
 rename drivers/acpi/{hmat/Kconfig => numa/Kconfig} (77%)
 create mode 100644 drivers/acpi/numa/Makefile
 rename drivers/acpi/{hmat/hmat.c => numa/hmat.c} (100%)
 rename drivers/acpi/{numa.c => numa/srat.c} (100%)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ebe1e9e5fd81..8c7c46065e9d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -319,12 +319,6 @@ config ACPI_THERMAL
 	  To compile this driver as a module, choose M here:
 	  the module will be called thermal.
 
-config ACPI_NUMA
-	bool "NUMA support"
-	depends on NUMA
-	depends on (X86 || IA64 || ARM64)
-	default y if IA64 || ARM64
-
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
 	default ""
@@ -473,8 +467,7 @@ config ACPI_REDUCED_HARDWARE_ONLY
 	  If you are unsure what to do, do not enable this option.
 
 source "drivers/acpi/nfit/Kconfig"
-source "drivers/acpi/hmat/Kconfig"
-
+source "drivers/acpi/numa/Kconfig"
 source "drivers/acpi/apei/Kconfig"
 source "drivers/acpi/dptf/Kconfig"
 
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5d361e4e3405..f08a661274e8 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -55,7 +55,6 @@ acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
 acpi-$(CONFIG_X86)		+= x86/apple.o
 acpi-$(CONFIG_X86)		+= x86/utils.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
-acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 acpi-y				+= acpi_lpat.o
 acpi-$(CONFIG_ACPI_LPIT)	+= acpi_lpit.o
@@ -80,7 +79,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI)		+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_NFIT)		+= nfit/
-obj-$(CONFIG_ACPI_HMAT)		+= hmat/
+obj-$(CONFIG_ACPI_NUMA)		+= numa/
 obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
diff --git a/drivers/acpi/hmat/Makefile b/drivers/acpi/hmat/Makefile
deleted file mode 100644
index 1c20ef36a385..000000000000
--- a/drivers/acpi/hmat/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ACPI_HMAT) := hmat.o
diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/numa/Kconfig
similarity index 77%
rename from drivers/acpi/hmat/Kconfig
rename to drivers/acpi/numa/Kconfig
index 95a29964dbea..acbd5aa76e40 100644
--- a/drivers/acpi/hmat/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -1,4 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
+config ACPI_NUMA
+	bool "NUMA support"
+	depends on NUMA
+	depends on (X86 || IA64 || ARM64)
+	default y if IA64 || ARM64
+
 config ACPI_HMAT
 	bool "ACPI Heterogeneous Memory Attribute Table Support"
 	depends on ACPI_NUMA
diff --git a/drivers/acpi/numa/Makefile b/drivers/acpi/numa/Makefile
new file mode 100644
index 000000000000..517a6c689a94
--- /dev/null
+++ b/drivers/acpi/numa/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ACPI_NUMA) += srat.o
+obj-$(CONFIG_ACPI_HMAT) += hmat.o
diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/numa/hmat.c
similarity index 100%
rename from drivers/acpi/hmat/hmat.c
rename to drivers/acpi/numa/hmat.c
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa/srat.c
similarity index 100%
rename from drivers/acpi/numa.c
rename to drivers/acpi/numa/srat.c
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
