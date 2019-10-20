Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C98DDC24
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Oct 2019 05:23:50 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D75E1007B5C8;
	Sat, 19 Oct 2019 20:25:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC9141007B5C0
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 20:25:37 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 20:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,318,1566889200";
   d="scan'208";a="187207954"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2019 20:23:41 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 04/10] libdaxctl: add an API to determine if memory is movable
Date: Sat, 19 Oct 2019 21:23:26 -0600
Message-Id: <20191020032332.16776-5-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191020032332.16776-1-vishal.l.verma@intel.com>
References: <20191020032332.16776-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: SEHUI4LS5PSVEAAPZN4QVF4ECDQZBWVB
X-Message-ID-Hash: SEHUI4LS5PSVEAAPZN4QVF4ECDQZBWVB
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Olson <ben.olson@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SEHUI4LS5PSVEAAPZN4QVF4ECDQZBWVB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

By default, daxctl always attempts to online new memory sections as
'movable' so that routine kernel allocations aren't serviced from this
memory, and the memory is later removable via hot-unplug.

System configuration, or other agents (such as udev rules) may race
'daxctl' to online memory, and this may result in the memory not being
'movable'. Add an interface to query the movability of a memory object
associated with a dax device.

This is in preparation to both display a 'movable' attribute in device
listings, as well as optionally allowing memory to be onlined as
non-movable.

Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: Ben Olson <ben.olson@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl-private.h | 20 +++++++++
 daxctl/lib/libdaxctl.c         | 77 ++++++++++++++++++++++++++++++++--
 daxctl/lib/libdaxctl.sym       |  5 +++
 daxctl/libdaxctl.h             |  1 +
 4 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index 7ba3c46..ebaecb8 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -44,6 +44,25 @@ enum memory_op {
 	MEM_SET_ONLINE,
 	MEM_IS_ONLINE,
 	MEM_COUNT,
+	MEM_GET_ZONE,
+};
+
+/* OR-able flags, 1, 2, 4, 8 etc */
+enum memory_op_status {
+	MEM_ST_OK = 0,
+	MEM_ST_ZONE_INCONSISTENT = 1,
+};
+
+enum memory_zones {
+	MEM_ZONE_UNKNOWN = 1,
+	MEM_ZONE_MOVABLE,
+	MEM_ZONE_NORMAL,
+};
+
+static const char *zone_strings[] = {
+	[MEM_ZONE_UNKNOWN] = "mixed",
+	[MEM_ZONE_NORMAL] = "Normal",
+	[MEM_ZONE_MOVABLE] = "Movable",
 };
 
 /**
@@ -86,6 +105,7 @@ struct daxctl_memory {
 	size_t buf_len;
 	char *node_path;
 	unsigned long block_size;
+	enum memory_zones zone;
 };
 
 
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 6243857..03f38f2 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1159,6 +1159,58 @@ static int offline_one_memblock(struct daxctl_memory *mem, char *memblock)
 	return rc;
 }
 
+static int memblock_find_zone(struct daxctl_memory *mem, char *memblock,
+		int *status)
+{
+	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	enum memory_zones cur_zone;
+	int len = mem->buf_len, rc;
+	char buf[SYSFS_ATTR_SIZE];
+	char *path = mem->mem_buf;
+	const char *node_path;
+
+	rc = memblock_is_online(mem, memblock);
+	if (rc < 0)
+		return rc;
+	if (rc == 0)
+		return -ENXIO;
+
+	node_path = daxctl_memory_get_node_path(mem);
+	if (!node_path)
+		return -ENXIO;
+
+	rc = snprintf(path, len, "%s/%s/valid_zones", node_path, memblock);
+	if (rc < 0)
+		return -ENOMEM;
+
+	rc = sysfs_read_attr(ctx, path, buf);
+	if (rc) {
+		err(ctx, "%s: Failed to read %s: %s\n",
+			devname, path, strerror(-rc));
+		return rc;
+	}
+
+	if (strcmp(buf, zone_strings[MEM_ZONE_MOVABLE]) == 0)
+		cur_zone = MEM_ZONE_MOVABLE;
+	else if (strcmp(buf, zone_strings[MEM_ZONE_NORMAL]) == 0)
+		cur_zone = MEM_ZONE_NORMAL;
+	else
+		cur_zone = MEM_ZONE_UNKNOWN;
+
+	if (mem->zone) {
+		if (mem->zone == cur_zone)
+			return 0;
+		else
+			*status |= MEM_ST_ZONE_INCONSISTENT;
+	} else {
+		mem->zone = cur_zone;
+	}
+
+	return 0;
+}
+
 static bool memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
 {
 	const char *mem_base = "/sys/devices/system/memory/";
@@ -1211,7 +1263,7 @@ static bool memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
 }
 
 static int op_for_one_memblock(struct daxctl_memory *mem, char *memblock,
-		enum memory_op op)
+		enum memory_op op, int *status)
 {
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	const char *devname = daxctl_dev_get_devname(dev);
@@ -1234,6 +1286,8 @@ static int op_for_one_memblock(struct daxctl_memory *mem, char *memblock,
 		return !rc;
 	case MEM_COUNT:
 		return 0;
+	case MEM_GET_ZONE:
+		return memblock_find_zone(mem, memblock, status);
 	}
 
 	err(ctx, "%s: BUG: unknown op: %d\n", devname, op);
@@ -1245,8 +1299,8 @@ static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op op)
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	int rc, count = 0, status_flags = 0;
 	const char *node_path;
-	int rc, count = 0;
 	struct dirent *de;
 	DIR *node_dir;
 
@@ -1265,7 +1319,8 @@ static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op op)
 		if (strncmp(de->d_name, "memory", 6) == 0) {
 			if (!memblock_in_dev(mem, de->d_name))
 				continue;
-			rc = op_for_one_memblock(mem, de->d_name, op);
+			rc = op_for_one_memblock(mem, de->d_name, op,
+					&status_flags);
 			if (rc < 0)
 				goto out_dir;
 			if (rc == 0)
@@ -1273,6 +1328,10 @@ static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op op)
 		}
 		errno = 0;
 	}
+
+	if (status_flags & MEM_ST_ZONE_INCONSISTENT)
+		mem->zone = MEM_ZONE_UNKNOWN;
+
 	if (errno) {
 		rc = -errno;
 		goto out_dir;
@@ -1303,3 +1362,15 @@ DAXCTL_EXPORT int daxctl_memory_num_sections(struct daxctl_memory *mem)
 {
 	return daxctl_memory_op(mem, MEM_COUNT);
 }
+
+DAXCTL_EXPORT int daxctl_memory_is_movable(struct daxctl_memory *mem)
+{
+	int rc;
+
+	/* Start a fresh zone scan, clear any previous info */
+	mem->zone = 0;
+	rc = daxctl_memory_op(mem, MEM_GET_ZONE);
+	if (rc < 0)
+		return rc;
+	return (mem->zone == MEM_ZONE_MOVABLE) ? 1 : 0;
+}
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index bc18604..041d9a5 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -69,3 +69,8 @@ global:
 	daxctl_memory_is_online;
 	daxctl_memory_num_sections;
 } LIBDAXCTL_5;
+
+LIBDAXCTL_7 {
+global:
+	daxctl_memory_is_movable;
+} LIBDAXCTL_6;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index fb6c3b1..8d5f8b7 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -84,6 +84,7 @@ int daxctl_memory_online(struct daxctl_memory *mem);
 int daxctl_memory_offline(struct daxctl_memory *mem);
 int daxctl_memory_is_online(struct daxctl_memory *mem);
 int daxctl_memory_num_sections(struct daxctl_memory *mem);
+int daxctl_memory_is_movable(struct daxctl_memory *mem);
 
 #define daxctl_dev_foreach(region, dev) \
         for (dev = daxctl_dev_get_first(region); \
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
