Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E4DDC29
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Oct 2019 05:23:58 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BEE731007A821;
	Sat, 19 Oct 2019 20:25:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 35AB41007B5C4
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 20:25:40 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 20:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,318,1566889200";
   d="scan'208";a="187207976"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2019 20:23:44 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 09/10] libdaxctl: add an API to online memory in a non-movable state
Date: Sat, 19 Oct 2019 21:23:31 -0600
Message-Id: <20191020032332.16776-10-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191020032332.16776-1-vishal.l.verma@intel.com>
References: <20191020032332.16776-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: FTCCJAZL7AXMZKDQCH2WZJVPXJPEGNY2
X-Message-ID-Hash: FTCCJAZL7AXMZKDQCH2WZJVPXJPEGNY2
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Olson <ben.olson@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FTCCJAZL7AXMZKDQCH2WZJVPXJPEGNY2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some users may want additional control over the state in which memory
gets onlined - specifically, controlling the 'movable' aspect of the
resulting memory blocks.

Until now, libdaxctl only brought up memory in the 'movable' state. Add
a new interface to online memory in the non-movable state.

Link: https://github.com/pmem/ndctl/issues/110
Cc: Ben Olson <ben.olson@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl-private.h |  6 +++++
 daxctl/lib/libdaxctl.c         | 47 ++++++++++++++++++++++++++++------
 daxctl/lib/libdaxctl.sym       |  1 +
 daxctl/libdaxctl.h             |  1 +
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index ebaecb8..9f9c70d 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -42,6 +42,7 @@ static const char *dax_modules[] = {
 enum memory_op {
 	MEM_SET_OFFLINE,
 	MEM_SET_ONLINE,
+	MEM_SET_ONLINE_NO_MOVABLE,
 	MEM_IS_ONLINE,
 	MEM_COUNT,
 	MEM_GET_ZONE,
@@ -65,6 +66,11 @@ static const char *zone_strings[] = {
 	[MEM_ZONE_MOVABLE] = "Movable",
 };
 
+static const char *state_strings[] = {
+	[MEM_ZONE_NORMAL] = "online",
+	[MEM_ZONE_MOVABLE] = "online_movable",
+};
+
 /**
  * struct daxctl_region - container for dax_devices
  */
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 49986ca..ee4a069 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1080,11 +1080,10 @@ static int memblock_is_online(struct daxctl_memory *mem, char *memblock)
 }
 
 static int online_one_memblock(struct daxctl_memory *mem, char *memblock,
-		int *status)
+		enum memory_zones zone, int *status)
 {
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
-	const char *mode = "online_movable";
 	int len = mem->buf_len, rc;
 	char *path = mem->mem_buf;
 	const char *node_path;
@@ -1101,7 +1100,14 @@ static int online_one_memblock(struct daxctl_memory *mem, char *memblock,
 	if (rc)
 		return rc;
 
-	rc = sysfs_write_attr_quiet(ctx, path, mode);
+	switch (zone) {
+	case MEM_ZONE_MOVABLE:
+	case MEM_ZONE_NORMAL:
+		rc = sysfs_write_attr_quiet(ctx, path, state_strings[zone]);
+		break;
+	default:
+		rc = -EINVAL;
+	}
 	if (rc) {
 		/*
 		 * If the block got onlined, potentially by some other agent,
@@ -1266,7 +1272,11 @@ static int op_for_one_memblock(struct daxctl_memory *mem, char *memblock,
 
 	switch (op) {
 	case MEM_SET_ONLINE:
-		return online_one_memblock(mem, memblock, status);
+		return online_one_memblock(mem, memblock, MEM_ZONE_MOVABLE,
+				status);
+	case MEM_SET_ONLINE_NO_MOVABLE:
+		return online_one_memblock(mem, memblock, MEM_ZONE_NORMAL,
+				status);
 	case MEM_SET_OFFLINE:
 		return offline_one_memblock(mem, memblock);
 	case MEM_IS_ONLINE:
@@ -1344,14 +1354,25 @@ out_dir:
 /*
  * daxctl_memory_online() will online to ZONE_MOVABLE by default
  */
-DAXCTL_EXPORT int daxctl_memory_online(struct daxctl_memory *mem)
+static int daxctl_memory_online_with_zone(struct daxctl_memory *mem,
+		enum memory_zones zone)
 {
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
 	int rc;
 
-	rc = daxctl_memory_op(mem, MEM_SET_ONLINE);
+	switch (zone) {
+	case MEM_ZONE_MOVABLE:
+		rc = daxctl_memory_op(mem, MEM_SET_ONLINE);
+		break;
+	case MEM_ZONE_NORMAL:
+		rc = daxctl_memory_op(mem, MEM_SET_ONLINE_NO_MOVABLE);
+		break;
+	default:
+		err(ctx, "%s: BUG: invalid zone for onlining\n", devname);
+		rc = -EINVAL;
+	}
 	if (rc)
 		return rc;
 
@@ -1361,10 +1382,10 @@ DAXCTL_EXPORT int daxctl_memory_online(struct daxctl_memory *mem)
 	 * any of the blocks are not in ZONE_MOVABLE, emit a warning.
 	 */
 	mem->zone = 0;
-	rc = daxctl_memory_op(mem, MEM_FIND_ZONE);
+	rc = daxctl_memory_op(mem, MEM_GET_ZONE);
 	if (rc)
 		return rc;
-	if (mem->zone != MEM_ZONE_MOVABLE) {
+	if (mem->zone != zone) {
 		err(ctx,
 		    "%s:\n  WARNING: detected a race while onlining memory\n"
 		    "  See 'man daxctl-reconfigure-device' for more details\n",
@@ -1375,6 +1396,16 @@ DAXCTL_EXPORT int daxctl_memory_online(struct daxctl_memory *mem)
 	return rc;
 }
 
+DAXCTL_EXPORT int daxctl_memory_online(struct daxctl_memory *mem)
+{
+	return daxctl_memory_online_with_zone(mem, MEM_ZONE_MOVABLE);
+}
+
+DAXCTL_EXPORT int daxctl_memory_online_no_movable(struct daxctl_memory *mem)
+{
+	return daxctl_memory_online_with_zone(mem, MEM_ZONE_NORMAL);
+}
+
 DAXCTL_EXPORT int daxctl_memory_offline(struct daxctl_memory *mem)
 {
 	return daxctl_memory_op(mem, MEM_SET_OFFLINE);
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 041d9a5..87d0236 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -73,4 +73,5 @@ global:
 LIBDAXCTL_7 {
 global:
 	daxctl_memory_is_movable;
+	daxctl_memory_online_no_movable;
 } LIBDAXCTL_6;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index 8d5f8b7..6c545e1 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -85,6 +85,7 @@ int daxctl_memory_offline(struct daxctl_memory *mem);
 int daxctl_memory_is_online(struct daxctl_memory *mem);
 int daxctl_memory_num_sections(struct daxctl_memory *mem);
 int daxctl_memory_is_movable(struct daxctl_memory *mem);
+int daxctl_memory_online_no_movable(struct daxctl_memory *mem);
 
 #define daxctl_dev_foreach(region, dev) \
         for (dev = daxctl_dev_get_first(region); \
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
