Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A76E16E5F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 May 2019 02:39:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2627D21BB2520;
	Tue,  7 May 2019 17:39:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0CA0521255842
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 17:39:22 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 May 2019 17:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,443,1549958400"; d="scan'208";a="169427691"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga002.fm.intel.com with ESMTP; 07 May 2019 17:39:21 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 08/10] Documentation/daxctl: add a man page for
 daxctl-reconfigure-device
Date: Tue,  7 May 2019 18:38:49 -0600
Message-Id: <20190508003851.32416-9-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508003851.32416-1-vishal.l.verma@intel.com>
References: <20190508003851.32416-1-vishal.l.verma@intel.com>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add a man page describing the new daxctl-reconfigure-device command.

Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/daxctl/Makefile.am              |   3 +-
 .../daxctl/daxctl-reconfigure-device.txt      | 118 ++++++++++++++++++
 2 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/daxctl/daxctl-reconfigure-device.txt

diff --git a/Documentation/daxctl/Makefile.am b/Documentation/daxctl/Makefile.am
index 6aba035..715fbad 100644
--- a/Documentation/daxctl/Makefile.am
+++ b/Documentation/daxctl/Makefile.am
@@ -28,7 +28,8 @@ endif
 man1_MANS = \
 	daxctl.1 \
 	daxctl-list.1 \
-	daxctl-migrate-device-model.1
+	daxctl-migrate-device-model.1 \
+	daxctl-reconfigure-device.1
 
 CLEANFILES = $(man1_MANS)
 
diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
new file mode 100644
index 0000000..b575091
--- /dev/null
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+
+daxctl-reconfigure-device(1)
+============================
+
+NAME
+----
+daxctl-reconfigure-device - Reconfigure a dax device into a different mode
+
+SYNOPSIS
+--------
+[verse]
+'daxctl reconfigure-device' <dax0.0> [<dax1.0>...<daxY.Z>] [<options>]
+
+EXAMPLES
+--------
+
+* Reconfigure dax0.0 to system-ram mode, don't online the memory
+----
+# daxctl reconfigure-device --mode=system-ram --no-online dax0.0
+[
+  {
+    "chardev":"dax0.0",
+    "size":16777216000,
+    "numa_node":2,
+    "mode":"system-ram"
+  }
+]
+----
+
+* Reconfigure dax0.0 to devdax mode, attempt to offline the memory
+----
+# daxctl reconfigure-device --human --mode=devdax --attempt-offline dax0.0
+{
+  "chardev":"dax0.0",
+  "size":"15.63 GiB (16.78 GB)",
+  "numa_node":2,
+  "mode":"devdax"
+}
+----
+
+* Reconfigure all dax devices on region0 to system-ram mode
+----
+# daxctl reconfigure-device --mode=system-ram --region=0 all
+[
+  {
+    "chardev":"dax0.0",
+    "size":16777216000,
+    "numa_node":2,
+    "mode":"system-ram"
+  },
+  {
+    "chardev":"dax0.1",
+    "size":16777216000,
+    "numa_node":3,
+    "mode":"system-ram"
+  }
+]
+----
+
+DESCRIPTION
+-----------
+
+Reconfigure the operational mode of a dax device. This can be used to convert
+a regular 'devdax' mode device to the 'system-ram' mode which allows for the dax
+range to be hot-plugged into the system as regular memory.
+
+NOTE: This is a destructive operation. Any data on the dax device *will* be
+lost.
+
+OPTIONS
+-------
+-r::
+--region=::
+	Restrict the reconfigure operation to devices belonging to the
+	specified region(s). A device-dax region is a contiguous range of
+	memory that hosts one or more /dev/daxX.Y devices, where X is the
+	region id and Y is the device instance id.
+
+-m::
+--mode=::
+	Specify the mode to which the dax device(s) should be reconfigured.
+	- "system-ram": hotplug the device into system memory.
+
+	- "devdax": switch to the normal "device dax" mode. This may not work
+	  on kernels prior to v5.2. In such a case, a reboot is the only way to
+	  switch back to 'devdax' mode.
+
+-N::
+--no-online::
+	By default, memory sections provided by system-ram devices will be
+	brought online automatically and immediately. Use this option to
+	disable the automatic onlining behavior.
+
+-O::
+--attempt-offline::
+	When converting from "system-ram" mode to "devdax", it is expected
+	that all the memory sections are first made offline. By default,
+	daxctl won't touch online memory. However with this option, attempt
+	to offline the memory on the NUMA node associated with the dax device
+	before converting it back to "devdax" mode.
+
+-u::
+--human::
+	By default the command will output machine-friendly raw-integer
+	data. Instead, with this flag, numbers representing storage size
+	will be formatted as human readable strings with units, other
+	fields are converted to hexadecimal strings.
+
+-v::
+--verbose::
+	Emit more debug messages for the reconfiguration process
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkdaxctl:daxctl-list[1]
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
