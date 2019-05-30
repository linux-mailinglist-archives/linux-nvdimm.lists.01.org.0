Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45F30548
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 May 2019 01:13:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 21DD42128A63A;
	Thu, 30 May 2019 16:13:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 719B72128A638
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 16:13:16 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 May 2019 16:13:16 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga004.jf.intel.com with ESMTP; 30 May 2019 16:13:15 -0700
Subject: [PATCH v2 1/8] acpi: Drop drivers/acpi/hmat/ directory
From: Dan Williams <dan.j.williams@intel.com>
To: linux-efi@vger.kernel.org
Date: Thu, 30 May 2019 15:59:27 -0700
Message-ID: <155925716783.3775979.13301455166290564145.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: ard.biesheuvel@linaro.org, x86@kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nvdimm@lists.01.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

As a single source file object there is no need for the hmat enabling to
have its own directory.

Cc: Len Brown <lenb@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/Kconfig       |   12 +++++++++++-
 drivers/acpi/Makefile      |    2 +-
 drivers/acpi/hmat.c        |    0 
 drivers/acpi/hmat/Kconfig  |   11 -----------
 drivers/acpi/hmat/Makefile |    2 --
 5 files changed, 12 insertions(+), 15 deletions(-)
 rename drivers/acpi/{hmat/hmat.c => hmat.c} (100%)
 delete mode 100644 drivers/acpi/hmat/Kconfig
 delete mode 100644 drivers/acpi/hmat/Makefile

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 283ee94224c6..ec8691e4152f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -475,7 +475,17 @@ config ACPI_REDUCED_HARDWARE_ONLY
 	  If you are unsure what to do, do not enable this option.
 
 source "drivers/acpi/nfit/Kconfig"
-source "drivers/acpi/hmat/Kconfig"
+
+config ACPI_HMAT
+	bool "ACPI Heterogeneous Memory Attribute Table Support"
+	depends on ACPI_NUMA
+	select HMEM_REPORTING
+	help
+	 If set, this option has the kernel parse and report the
+	 platform's ACPI HMAT (Heterogeneous Memory Attributes Table),
+	 register memory initiators with their targets, and export
+	 performance attributes through the node's sysfs device if
+	 provided.
 
 source "drivers/acpi/apei/Kconfig"
 source "drivers/acpi/dptf/Kconfig"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5d361e4e3405..fc89686498dd 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -80,7 +80,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI)		+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_NFIT)		+= nfit/
-obj-$(CONFIG_ACPI_HMAT)		+= hmat/
+obj-$(CONFIG_ACPI_HMAT)		+= hmat.o
 obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat.c
similarity index 100%
rename from drivers/acpi/hmat/hmat.c
rename to drivers/acpi/hmat.c
diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
deleted file mode 100644
index 95a29964dbea..000000000000
--- a/drivers/acpi/hmat/Kconfig
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config ACPI_HMAT
-	bool "ACPI Heterogeneous Memory Attribute Table Support"
-	depends on ACPI_NUMA
-	select HMEM_REPORTING
-	help
-	 If set, this option has the kernel parse and report the
-	 platform's ACPI HMAT (Heterogeneous Memory Attributes Table),
-	 register memory initiators with their targets, and export
-	 performance attributes through the node's sysfs device if
-	 provided.
diff --git a/drivers/acpi/hmat/Makefile b/drivers/acpi/hmat/Makefile
deleted file mode 100644
index 1c20ef36a385..000000000000
--- a/drivers/acpi/hmat/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ACPI_HMAT) := hmat.o

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
