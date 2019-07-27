Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D32775BA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 03:52:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E297212E2584;
	Fri, 26 Jul 2019 18:54:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 29088212E15AD
 for <linux-nvdimm@lists.01.org>; Fri, 26 Jul 2019 18:54:46 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jul 2019 18:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,313,1559545200"; d="scan'208";a="369715467"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2019 18:52:19 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v8 08/13] Documentation/daxctl: add a man page for
 daxctl-reconfigure-device
Date: Fri, 26 Jul 2019 19:52:07 -0600
Message-Id: <20190727015212.27092-9-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190727015212.27092-1-vishal.l.verma@intel.com>
References: <20190727015212.27092-1-vishal.l.verma@intel.com>
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
 .../daxctl/daxctl-reconfigure-device.txt      | 156 ++++++++++++++++++
 2 files changed, 158 insertions(+), 1 deletion(-)
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
index 0000000..fe87762
--- /dev/null
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -0,0 +1,156 @@
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
+    "target_node":2,
+    "mode":"system-ram"
+  }
+]
+----
+
+* Reconfigure dax0.0 to devdax mode, attempt to offline the memory
+----
+# daxctl reconfigure-device --human --mode=devdax --force dax0.0
+{
+  "chardev":"dax0.0",
+  "size":"15.63 GiB (16.78 GB)",
+  "target_node":2,
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
+    "target_node":2,
+    "mode":"system-ram"
+  },
+  {
+    "chardev":"dax0.1",
+    "size":16777216000,
+    "target_node":3,
+    "mode":"system-ram"
+  }
+]
+----
+
+* Run a process called 'some-service' using numactl to restrict its cpu
+nodes to '0' and '1', and  memory allocations to node 2 (determined using
+daxctl_dev_get_target_node() or 'daxctl list')
+----
+# daxctl reconfigure-device --mode=system-ram dax0.0
+[
+  {
+    "chardev":"dax0.0",
+    "size":16777216000,
+    "target_node":2,
+    "mode":"system-ram"
+  }
+]
+
+# numactl --cpunodebind=0-1 --membind=2 -- some-service --opt1 --opt2
+----
+
+DESCRIPTION
+-----------
+
+Reconfigure the operational mode of a dax device. This can be used to convert
+a regular 'devdax' mode device to the 'system-ram' mode which arranges for the
+dax range to be hot-plugged into the system as regular memory.
+
+NOTE: This is a destructive operation. Any data on the dax device *will* be
+lost.
+
+NOTE: Device reconfiguration depends on the dax-bus device model. See
+linkdaxctl:daxctl-migrate-device-model[1] for more information. If dax-class is
+in use (via the dax_pmem_compat driver), the reconfiguration will fail with an
+error such as the following:
+----
+# daxctl reconfigure-device --mode=system-ram --region=0 all
+dax3.0: dax-class device model unsupported
+error reconfiguring devices: No such device or address
+reconfigured 0 devices
+----
+
+OPTIONS
+-------
+-r::
+--region=::
+	Restrict the operation to devices belonging to the specified region(s).
+	A device-dax region is a contiguous range of memory that hosts one or
+	more /dev/daxX.Y devices, where X is the region id and Y is the device
+	instance id.
+
+-m::
+--mode=::
+	Specify the mode to which the dax device(s) should be reconfigured.
+	- "system-ram": hotplug the device into system memory.
+
+	- "devdax": switch to the normal "device dax" mode. This requires the
+	  kernel to support hot-unplugging 'kmem' based memory. If this is not
+	  available, a reboot is the only way to switch back to 'devdax' mode.
+
+-N::
+--no-online::
+	By default, memory sections provided by system-ram devices will be
+	brought online automatically and immediately with the 'online_movable'
+	policy. Use this option to disable the automatic onlining behavior.
+
+	NOTE: While this option prevents daxctl from automatically onlining
+	the memory sections, there may be other agents, notably system udev
+	rules, that online new memory sections as they appear. Coordinating
+	with such rules is out of scope of this utility, and the system
+	administrator is expected to remove them if they are undesirable.
+	If such an agent races to online memory sections, daxctl is prepared
+	to lose the race, and not fail the onlining operation as it only
+	cares that the memory section was onlined, not that it was the one
+	to do so.
+
+-f::
+--force::
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
+	Emit more debug messages
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkdaxctl:daxctl-list[1],daxctl-migrate-device-model[1]
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
