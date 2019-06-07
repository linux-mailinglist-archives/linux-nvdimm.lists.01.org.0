Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F5D395F1
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 21:41:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 81A0F21290DEA;
	Fri,  7 Jun 2019 12:41:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 91C6521290D4F
 for <linux-nvdimm@lists.01.org>; Fri,  7 Jun 2019 12:41:35 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jun 2019 12:41:35 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga006.jf.intel.com with ESMTP; 07 Jun 2019 12:41:34 -0700
Subject: [PATCH v3 01/10] acpi/numa: Establish a new drivers/acpi/numa/
 directory
From: Dan Williams <dan.j.williams@intel.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2019 12:27:18 -0700
Message-ID: <155993563815.3036719.5542204455414415743.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: x86@kernel.org, ard.biesheuvel@linaro.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-nvdimm@lists.01.org, linux-efi@vger.kernel.org,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

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
Cc: Keith Busch <keith.busch@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/Kconfig       |    9 +--------
 drivers/acpi/Makefile      |    3 +--
 drivers/acpi/hmat/Makefile |    2 --
 drivers/acpi/numa/Kconfig  |    7 ++++++-
 drivers/acpi/numa/Makefile |    3 +++
 drivers/acpi/numa/hmat.c   |    0 
 drivers/acpi/numa/srat.c   |    0 
 7 files changed, 11 insertions(+), 13 deletions(-)
 delete mode 100644 drivers/acpi/hmat/Makefile
 rename drivers/acpi/{hmat/Kconfig => numa/Kconfig} (72%)
 create mode 100644 drivers/acpi/numa/Makefile
 rename drivers/acpi/{hmat/hmat.c => numa/hmat.c} (100%)
 rename drivers/acpi/{numa.c => numa/srat.c} (100%)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 283ee94224c6..82c4a31c8701 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -321,12 +321,6 @@ config ACPI_THERMAL
 	  To compile this driver as a module, choose M here:
 	  the module will be called thermal.
 
-config ACPI_NUMA
-	bool "NUMA support"
-	depends on NUMA
-	depends on (X86 || IA64 || ARM64)
-	default y if IA64_GENERIC || IA64_SGI_SN2 || ARM64
-
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
 	default ""
@@ -475,8 +469,7 @@ config ACPI_REDUCED_HARDWARE_ONLY
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
similarity index 72%
rename from drivers/acpi/hmat/Kconfig
rename to drivers/acpi/numa/Kconfig
index 95a29964dbea..d14582387ed0 100644
--- a/drivers/acpi/hmat/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -1,4 +1,9 @@
-# SPDX-License-Identifier: GPL-2.0
+config ACPI_NUMA
+	bool "NUMA support"
+	depends on NUMA
+	depends on (X86 || IA64 || ARM64)
+	default y if IA64_GENERIC || IA64_SGI_SN2 || ARM64
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
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
