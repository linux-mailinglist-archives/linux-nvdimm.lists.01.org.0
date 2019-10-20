Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD66DDC22
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Oct 2019 05:23:47 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0FEB81007B5CA;
	Sat, 19 Oct 2019 20:25:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E18541007B5C0
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 20:25:36 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 20:23:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,318,1566889200";
   d="scan'208";a="187207946"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2019 20:23:40 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 02/10] libdaxctl: refactor memblock_is_online() checks
Date: Sat, 19 Oct 2019 21:23:24 -0600
Message-Id: <20191020032332.16776-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191020032332.16776-1-vishal.l.verma@intel.com>
References: <20191020032332.16776-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: WRSPNCKQ5ZOLCMSK77FOOT62VLRO5PFN
X-Message-ID-Hash: WRSPNCKQ5ZOLCMSK77FOOT62VLRO5PFN
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Olson <ben.olson@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WRSPNCKQ5ZOLCMSK77FOOT62VLRO5PFN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The {online,offline}_one_memblock() helpers both open-coded the check
for whether a block is online. There is already a function to perform
this check - memblock_is_online(). Consolidate the checking using this
helper everywhere it is applicable.

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl.c | 90 +++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 53 deletions(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index a828644..6243857 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1047,12 +1047,11 @@ DAXCTL_EXPORT unsigned long daxctl_memory_get_block_size(struct daxctl_memory *m
 	return mem->block_size;
 }
 
-static int online_one_memblock(struct daxctl_memory *mem, char *memblock)
+static int memblock_is_online(struct daxctl_memory *mem, char *memblock)
 {
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
-	const char *mode = "online_movable";
 	int len = mem->buf_len, rc;
 	char buf[SYSFS_ATTR_SIZE];
 	char *path = mem->mem_buf;
@@ -1073,41 +1072,20 @@ static int online_one_memblock(struct daxctl_memory *mem, char *memblock)
 		return rc;
 	}
 
-	/*
-	 * if already online, possibly due to kernel config or a udev rule,
-	 * there is nothing to do and we can skip over the memblock
-	 */
 	if (strncmp(buf, "online", 6) == 0)
 		return 1;
 
-	rc = sysfs_write_attr_quiet(ctx, path, mode);
-	if (rc) {
-		/*
-		 * While we performed an already-online check above, there
-		 * is still a TOCTOU hole where someone (such as a udev rule)
-		 * may have raced to online the memory. In such a case,
-		 * the sysfs store will fail, however we can check for this
-		 * by simply reading the state again. If it changed to the
-		 * desired state, then we don't have to error out.
-		 */
-		if (sysfs_read_attr(ctx, path, buf) == 0) {
-			if (strncmp(buf, "online", 6) == 0)
-				return 1;
-		}
-		err(ctx, "%s: Failed to online %s: %s\n",
-			devname, path, strerror(-rc));
-	}
-	return rc;
+	/* offline */
+	return 0;
 }
 
-static int offline_one_memblock(struct daxctl_memory *mem, char *memblock)
+static int online_one_memblock(struct daxctl_memory *mem, char *memblock)
 {
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
-	const char *mode = "offline";
+	const char *mode = "online_movable";
 	int len = mem->buf_len, rc;
-	char buf[SYSFS_ATTR_SIZE];
 	char *path = mem->mem_buf;
 	const char *node_path;
 
@@ -1119,37 +1097,39 @@ static int offline_one_memblock(struct daxctl_memory *mem, char *memblock)
 	if (rc < 0)
 		return -ENOMEM;
 
-	rc = sysfs_read_attr(ctx, path, buf);
-	if (rc) {
-		err(ctx, "%s: Failed to read %s: %s\n",
-			devname, path, strerror(-rc));
+	/*
+	 * if already online, possibly due to kernel config or a udev rule,
+	 * there is nothing to do and we can skip over the memblock
+	 */
+	rc = memblock_is_online(mem, memblock);
+	if (rc)
 		return rc;
-	}
-
-	/* if already offline, there is nothing to do */
-	if (strncmp(buf, "offline", 7) == 0)
-		return 1;
 
 	rc = sysfs_write_attr_quiet(ctx, path, mode);
 	if (rc) {
-		/* Close the TOCTOU hole like in online_one_memblock() above */
-		if (sysfs_read_attr(ctx, path, buf) == 0) {
-			if (strncmp(buf, "offline", 7) == 0)
-				return 1;
-		}
-		err(ctx, "%s: Failed to offline %s: %s\n",
+		/*
+		 * While we performed an already-online check above, there
+		 * is still a TOCTOU hole where someone (such as a udev rule)
+		 * may have raced to online the memory. In such a case,
+		 * the sysfs store will fail, however we can check for this
+		 * by simply reading the state again. If it changed to the
+		 * desired state, then we don't have to error out.
+		 */
+		if (memblock_is_online(mem, memblock))
+			return 1;
+		err(ctx, "%s: Failed to online %s: %s\n",
 			devname, path, strerror(-rc));
 	}
 	return rc;
 }
 
-static int memblock_is_online(struct daxctl_memory *mem, char *memblock)
+static int offline_one_memblock(struct daxctl_memory *mem, char *memblock)
 {
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	const char *mode = "offline";
 	int len = mem->buf_len, rc;
-	char buf[SYSFS_ATTR_SIZE];
 	char *path = mem->mem_buf;
 	const char *node_path;
 
@@ -1161,18 +1141,22 @@ static int memblock_is_online(struct daxctl_memory *mem, char *memblock)
 	if (rc < 0)
 		return -ENOMEM;
 
-	rc = sysfs_read_attr(ctx, path, buf);
-	if (rc) {
-		err(ctx, "%s: Failed to read %s: %s\n",
-			devname, path, strerror(-rc));
+	/* if already offline, there is nothing to do */
+	rc = memblock_is_online(mem, memblock);
+	if (rc < 0)
 		return rc;
-	}
-
-	if (strncmp(buf, "online", 6) == 0)
+	if (!rc)
 		return 1;
 
-	/* offline */
-	return 0;
+	rc = sysfs_write_attr_quiet(ctx, path, mode);
+	if (rc) {
+		/* Close the TOCTOU hole like in online_one_memblock() above */
+		if (!memblock_is_online(mem, memblock))
+			return 1;
+		err(ctx, "%s: Failed to offline %s: %s\n",
+			devname, path, strerror(-rc));
+	}
+	return rc;
 }
 
 static bool memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
