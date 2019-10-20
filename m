Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D8DDC2A
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Oct 2019 05:23:59 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D543A1007A825;
	Sat, 19 Oct 2019 20:25:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A8A0A1007B5D1
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 20:25:40 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 20:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,318,1566889200";
   d="scan'208";a="187207980"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2019 20:23:44 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 10/10] daxctl: add --no-movable option for onlining memory
Date: Sat, 19 Oct 2019 21:23:32 -0600
Message-Id: <20191020032332.16776-11-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191020032332.16776-1-vishal.l.verma@intel.com>
References: <20191020032332.16776-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: XLJ5BLHUL6LTYNJ7ZZ7JXLQVN7J6BQ2C
X-Message-ID-Hash: XLJ5BLHUL6LTYNJ7ZZ7JXLQVN7J6BQ2C
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Olson <ben.olson@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XLJ5BLHUL6LTYNJ7ZZ7JXLQVN7J6BQ2C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a new '--no-movable' option to daxctl commands that may online
memory - i.e. daxctl-reconfigure-device and daxctl-online-memory.

Users may wish additional control over the state of the newly added
memory. Retain the daxctl default for onlining memory as 'movable', but
allow it to be overridden using the above option.

Link: https://github.com/pmem/ndctl/issues/110
Cc: Ben Olson <ben.olson@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/daxctl/daxctl-online-memory.txt |  2 ++
 .../daxctl/daxctl-reconfigure-device.txt      |  2 ++
 Documentation/daxctl/movable-options.txt      |  9 +++++
 daxctl/device.c                               | 34 ++++++++++++++++---
 4 files changed, 43 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/daxctl/movable-options.txt

diff --git a/Documentation/daxctl/daxctl-online-memory.txt b/Documentation/daxctl/daxctl-online-memory.txt
index 5ac1cbf..08b45cc 100644
--- a/Documentation/daxctl/daxctl-online-memory.txt
+++ b/Documentation/daxctl/daxctl-online-memory.txt
@@ -62,6 +62,8 @@ OPTIONS
 	more /dev/daxX.Y devices, where X is the region id and Y is the device
 	instance id.
 
+include::movable-options.txt[]
+
 -u::
 --human::
 	By default the command will output machine-friendly raw-integer
diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
index 4663529..cb28fed 100644
--- a/Documentation/daxctl/daxctl-reconfigure-device.txt
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -135,6 +135,8 @@ OPTIONS
 	brought online automatically and immediately with the 'online_movable'
 	policy. Use this option to disable the automatic onlining behavior.
 
+include::movable-options.txt[]
+
 -f::
 --force::
 	When converting from "system-ram" mode to "devdax", it is expected
diff --git a/Documentation/daxctl/movable-options.txt b/Documentation/daxctl/movable-options.txt
new file mode 100644
index 0000000..cecd401
--- /dev/null
+++ b/Documentation/daxctl/movable-options.txt
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--no-movable::
+	'--movable' is the default. This can be overridden to online new
+	memory such that is is not 'movable'. This allows any allocation
+	to potentially be served from this memory. This may preclude subsequent
+	removal. With the '--movable' behavior (which is default), kernel
+	allocations will not consider this memory, and it will be reserved
+	for application use.
diff --git a/daxctl/device.c b/daxctl/device.c
index 28698bf..72e506e 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -21,6 +21,7 @@ static struct {
 	const char *mode;
 	int region_id;
 	bool no_online;
+	bool no_movable;
 	bool force;
 	bool human;
 	bool verbose;
@@ -37,6 +38,12 @@ enum dev_mode {
 static enum dev_mode reconfig_mode = DAXCTL_DEV_MODE_UNKNOWN;
 static unsigned long flags;
 
+enum memory_zone {
+	MEM_ZONE_MOVABLE,
+	MEM_ZONE_NORMAL,
+};
+static enum memory_zone mem_zone = MEM_ZONE_MOVABLE;
+
 enum device_action {
 	ACTION_RECONFIG,
 	ACTION_ONLINE,
@@ -55,13 +62,24 @@ OPT_BOOLEAN('N', "no-online", &param.no_online, \
 OPT_BOOLEAN('f', "force", &param.force, \
 		"attempt to offline memory sections before reconfiguration")
 
+#define ZONE_OPTIONS() \
+OPT_BOOLEAN('\0', "no-movable", &param.no_movable, \
+		"online memory in ZONE_NORMAL")
+
 static const struct option reconfig_options[] = {
 	BASE_OPTIONS(),
 	RECONFIG_OPTIONS(),
+	ZONE_OPTIONS(),
+	OPT_END(),
+};
+
+static const struct option online_options[] = {
+	BASE_OPTIONS(),
+	ZONE_OPTIONS(),
 	OPT_END(),
 };
 
-static const struct option memory_options[] = {
+static const struct option offline_options[] = {
 	BASE_OPTIONS(),
 	OPT_END(),
 };
@@ -126,6 +144,8 @@ static const char *parse_device_options(int argc, const char **argv,
 		}
 		if (strcmp(param.mode, "system-ram") == 0) {
 			reconfig_mode = DAXCTL_DEV_MODE_RAM;
+			if (param.no_movable)
+				mem_zone = MEM_ZONE_NORMAL;
 		} else if (strcmp(param.mode, "devdax") == 0) {
 			reconfig_mode = DAXCTL_DEV_MODE_DEVDAX;
 			if (param.no_online) {
@@ -136,6 +156,9 @@ static const char *parse_device_options(int argc, const char **argv,
 		}
 		break;
 	case ACTION_ONLINE:
+		if (param.no_movable)
+			mem_zone = MEM_ZONE_NORMAL;
+		/* fall through */
 	case ACTION_OFFLINE:
 		/* nothing special */
 		break;
@@ -194,7 +217,10 @@ static int dev_online_memory(struct daxctl_dev *dev)
 			num_on == 1 ? "" : "s");
 
 	/* online the remaining sections */
-	rc = daxctl_memory_online(mem);
+	if (param.no_movable)
+		rc = daxctl_memory_online_no_movable(mem);
+	else
+		rc = daxctl_memory_online(mem);
 	if (rc < 0) {
 		fprintf(stderr, "%s: failed to online memory: %s\n",
 			devname, strerror(-rc));
@@ -521,7 +547,7 @@ int cmd_online_memory(int argc, const char **argv, struct daxctl_ctx *ctx)
 {
 	char *usage = "daxctl online-memory <device> [<options>]";
 	const char *device = parse_device_options(argc, argv, ACTION_ONLINE,
-			memory_options, usage, ctx);
+			online_options, usage, ctx);
 	int processed, rc;
 
 	rc = do_xaction_device(device, ACTION_ONLINE, ctx, &processed);
@@ -538,7 +564,7 @@ int cmd_offline_memory(int argc, const char **argv, struct daxctl_ctx *ctx)
 {
 	char *usage = "daxctl offline-memory <device> [<options>]";
 	const char *device = parse_device_options(argc, argv, ACTION_OFFLINE,
-			memory_options, usage, ctx);
+			offline_options, usage, ctx);
 	int processed, rc;
 
 	rc = do_xaction_device(device, ACTION_OFFLINE, ctx, &processed);
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
