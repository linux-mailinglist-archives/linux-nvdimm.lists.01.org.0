Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59230DDC27
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Oct 2019 05:23:55 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8E90C1007B5D0;
	Sat, 19 Oct 2019 20:25:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A0B31007B5D0
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 20:25:39 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 20:23:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,318,1566889200";
   d="scan'208";a="187207967"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2019 20:23:43 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 07/10] daxctl: detect races when onlining memory blocks
Date: Sat, 19 Oct 2019 21:23:29 -0600
Message-Id: <20191020032332.16776-8-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191020032332.16776-1-vishal.l.verma@intel.com>
References: <20191020032332.16776-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: NV3QWP33D2Y7QTXDO7YRIL4GRFO5BDES
X-Message-ID-Hash: NV3QWP33D2Y7QTXDO7YRIL4GRFO5BDES
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Olson <ben.olson@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NV3QWP33D2Y7QTXDO7YRIL4GRFO5BDES/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sometimes, system configuration can result in new memory blocks getting
onlined automatically. Often, these auto-onlining mechanisms don't
provide a choice or configurability in the matter of which zone is used
for these new blocks, and they just end up in ZONE_NORMAL.

Usually, for hot-plugged memory, ZONE_NORMAL is undesirable because:
 - An application might want total control over this memory
 - ZONE_NORMAL precludes hot-removal of this memory
 - Having kernel data structures in this memory, especially performance
   sensitive ones, such as page tables, may be undesirable.

Thus report if a race condition is encountered while onlining memory,
and provide the user options to remedy it.

Clarify the default zone expectations, and the race detection behavior
in the daxctl-reconfigure-device man page, and move the relevant section
under the 'Description' header, instead of hidden away under the
'--no-online' option.

Cc: Ben Olson <ben.olson@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/device.c        |  9 +++++++
 daxctl/lib/libdaxctl.c | 59 ++++++++++++++++++++++++++++--------------
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index 920efc6..28698bf 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -174,6 +174,15 @@ static int dev_online_memory(struct daxctl_dev *dev)
 			devname, strerror(-num_on));
 		return num_on;
 	}
+	if (num_on)
+		fprintf(stderr,
+		    "%s:\n  WARNING: detected a race while onlining memory\n"
+		    "  Some memory may not be in the expected zone. It is\n"
+		    "  recommended to disable any other onlining mechanisms,\n"
+		    "  and retry. If onlining is to be left to other agents,\n"
+		    "  use the --no-online option to suppress this warning\n",
+		    devname);
+
 	if (num_on == num_sections) {
 		fprintf(stderr, "%s: all memory sections (%d) already online\n",
 			devname, num_on);
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 65a09c8..49986ca 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1079,10 +1079,10 @@ static int memblock_is_online(struct daxctl_memory *mem, char *memblock)
 	return 0;
 }
 
-static int online_one_memblock(struct daxctl_memory *mem, char *memblock)
+static int online_one_memblock(struct daxctl_memory *mem, char *memblock,
+		int *status)
 {
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
-	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
 	const char *mode = "online_movable";
 	int len = mem->buf_len, rc;
@@ -1097,10 +1097,6 @@ static int online_one_memblock(struct daxctl_memory *mem, char *memblock)
 	if (rc < 0)
 		return -ENOMEM;
 
-	/*
-	 * if already online, possibly due to kernel config or a udev rule,
-	 * there is nothing to do and we can skip over the memblock
-	 */
 	rc = memblock_is_online(mem, memblock);
 	if (rc)
 		return rc;
@@ -1108,18 +1104,14 @@ static int online_one_memblock(struct daxctl_memory *mem, char *memblock)
 	rc = sysfs_write_attr_quiet(ctx, path, mode);
 	if (rc) {
 		/*
-		 * While we performed an already-online check above, there
-		 * is still a TOCTOU hole where someone (such as a udev rule)
-		 * may have raced to online the memory. In such a case,
-		 * the sysfs store will fail, however we can check for this
-		 * by simply reading the state again. If it changed to the
-		 * desired state, then we don't have to error out.
+		 * If the block got onlined, potentially by some other agent,
+		 * do nothing for now. There will be a full scan for zone
+		 * correctness later.
 		 */
-		if (memblock_is_online(mem, memblock))
-			return 1;
-		err(ctx, "%s: Failed to online %s: %s\n",
-			devname, path, strerror(-rc));
+		if (memblock_is_online(mem, memblock) == 1)
+			return 0;
 	}
+
 	return rc;
 }
 
@@ -1150,7 +1142,7 @@ static int offline_one_memblock(struct daxctl_memory *mem, char *memblock)
 
 	rc = sysfs_write_attr_quiet(ctx, path, mode);
 	if (rc) {
-		/* Close the TOCTOU hole like in online_one_memblock() above */
+		/* check if something raced us to offline (unlikely) */
 		if (!memblock_is_online(mem, memblock))
 			return 1;
 		err(ctx, "%s: Failed to offline %s: %s\n",
@@ -1274,7 +1266,7 @@ static int op_for_one_memblock(struct daxctl_memory *mem, char *memblock,
 
 	switch (op) {
 	case MEM_SET_ONLINE:
-		return online_one_memblock(mem, memblock);
+		return online_one_memblock(mem, memblock, status);
 	case MEM_SET_OFFLINE:
 		return offline_one_memblock(mem, memblock);
 	case MEM_IS_ONLINE:
@@ -1349,9 +1341,38 @@ out_dir:
 	return rc;
 }
 
+/*
+ * daxctl_memory_online() will online to ZONE_MOVABLE by default
+ */
 DAXCTL_EXPORT int daxctl_memory_online(struct daxctl_memory *mem)
 {
-	return daxctl_memory_op(mem, MEM_SET_ONLINE);
+	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	int rc;
+
+	rc = daxctl_memory_op(mem, MEM_SET_ONLINE);
+	if (rc)
+		return rc;
+
+	/*
+	 * Detect any potential races when blocks were being brought online by
+	 * checking the zone in which the memory blocks are at this point. If
+	 * any of the blocks are not in ZONE_MOVABLE, emit a warning.
+	 */
+	mem->zone = 0;
+	rc = daxctl_memory_op(mem, MEM_FIND_ZONE);
+	if (rc)
+		return rc;
+	if (mem->zone != MEM_ZONE_MOVABLE) {
+		err(ctx,
+		    "%s:\n  WARNING: detected a race while onlining memory\n"
+		    "  See 'man daxctl-reconfigure-device' for more details\n",
+		    devname);
+		return -EBUSY;
+	}
+
+	return rc;
 }
 
 DAXCTL_EXPORT int daxctl_memory_offline(struct daxctl_memory *mem)
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
