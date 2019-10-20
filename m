Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3ADDC21
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Oct 2019 05:23:46 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC5E71007B5C1;
	Sat, 19 Oct 2019 20:25:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 933111007B5C0
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 20:25:36 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 20:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,318,1566889200";
   d="scan'208";a="187207942"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2019 20:23:40 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 01/10] libdaxctl: refactor path construction in op_for_one_memblock()
Date: Sat, 19 Oct 2019 21:23:23 -0600
Message-Id: <20191020032332.16776-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191020032332.16776-1-vishal.l.verma@intel.com>
References: <20191020032332.16776-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 4ANTONWZSAYPL6QURVLMOCOC4T7SHG2B
X-Message-ID-Hash: 4ANTONWZSAYPL6QURVLMOCOC4T7SHG2B
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Olson <ben.olson@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4ANTONWZSAYPL6QURVLMOCOC4T7SHG2B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for memblock operations to check additional sysfs
attributes in the memoryXXX block, 'path' can't be prematurely set
to the memoryXXX/state file.

Push down path construction into each memory op helper, so that each
helper gets an opportunity to reconstruct and act upon multiple paths.

Cc: Dan Williams <dan.j.williams@intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl.c | 64 +++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 4dfc524..a828644 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1047,13 +1047,24 @@ DAXCTL_EXPORT unsigned long daxctl_memory_get_block_size(struct daxctl_memory *m
 	return mem->block_size;
 }
 
-static int online_one_memblock(struct daxctl_dev *dev, char *path)
+static int online_one_memblock(struct daxctl_memory *mem, char *memblock)
 {
+	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
 	const char *mode = "online_movable";
+	int len = mem->buf_len, rc;
 	char buf[SYSFS_ATTR_SIZE];
-	int rc;
+	char *path = mem->mem_buf;
+	const char *node_path;
+
+	node_path = daxctl_memory_get_node_path(mem);
+	if (!node_path)
+		return -ENXIO;
+
+	rc = snprintf(path, len, "%s/%s/state", node_path, memblock);
+	if (rc < 0)
+		return -ENOMEM;
 
 	rc = sysfs_read_attr(ctx, path, buf);
 	if (rc) {
@@ -1089,13 +1100,24 @@ static int online_one_memblock(struct daxctl_dev *dev, char *path)
 	return rc;
 }
 
-static int offline_one_memblock(struct daxctl_dev *dev, char *path)
+static int offline_one_memblock(struct daxctl_memory *mem, char *memblock)
 {
+	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
 	const char *mode = "offline";
+	int len = mem->buf_len, rc;
 	char buf[SYSFS_ATTR_SIZE];
-	int rc;
+	char *path = mem->mem_buf;
+	const char *node_path;
+
+	node_path = daxctl_memory_get_node_path(mem);
+	if (!node_path)
+		return -ENXIO;
+
+	rc = snprintf(path, len, "%s/%s/state", node_path, memblock);
+	if (rc < 0)
+		return -ENOMEM;
 
 	rc = sysfs_read_attr(ctx, path, buf);
 	if (rc) {
@@ -1121,12 +1143,23 @@ static int offline_one_memblock(struct daxctl_dev *dev, char *path)
 	return rc;
 }
 
-static int memblock_is_online(struct daxctl_dev *dev, char *path)
+static int memblock_is_online(struct daxctl_memory *mem, char *memblock)
 {
+	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	int len = mem->buf_len, rc;
 	char buf[SYSFS_ATTR_SIZE];
-	int rc;
+	char *path = mem->mem_buf;
+	const char *node_path;
+
+	node_path = daxctl_memory_get_node_path(mem);
+	if (!node_path)
+		return -ENXIO;
+
+	rc = snprintf(path, len, "%s/%s/state", node_path, memblock);
+	if (rc < 0)
+		return -ENOMEM;
 
 	rc = sysfs_read_attr(ctx, path, buf);
 	if (rc) {
@@ -1193,7 +1226,7 @@ static bool memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
 	return false;
 }
 
-static int op_for_one_memblock(struct daxctl_memory *mem, char *path,
+static int op_for_one_memblock(struct daxctl_memory *mem, char *memblock,
 		enum memory_op op)
 {
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
@@ -1203,11 +1236,11 @@ static int op_for_one_memblock(struct daxctl_memory *mem, char *path,
 
 	switch (op) {
 	case MEM_SET_ONLINE:
-		return online_one_memblock(dev, path);
+		return online_one_memblock(mem, memblock);
 	case MEM_SET_OFFLINE:
-		return offline_one_memblock(dev, path);
+		return offline_one_memblock(mem, memblock);
 	case MEM_IS_ONLINE:
-		rc = memblock_is_online(dev, path);
+		rc = memblock_is_online(mem, memblock);
 		if (rc < 0)
 			return rc;
 		/*
@@ -1245,19 +1278,10 @@ static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op op)
 
 	errno = 0;
 	while ((de = readdir(node_dir)) != NULL) {
-		char *path = mem->mem_buf;
-		int len = mem->buf_len;
-
 		if (strncmp(de->d_name, "memory", 6) == 0) {
 			if (!memblock_in_dev(mem, de->d_name))
 				continue;
-			rc = snprintf(path, len, "%s/%s/state",
-				node_path, de->d_name);
-			if (rc < 0) {
-				rc = -ENOMEM;
-				goto out_dir;
-			}
-			rc = op_for_one_memblock(mem, path, op);
+			rc = op_for_one_memblock(mem, de->d_name, op);
 			if (rc < 0)
 				goto out_dir;
 			if (rc == 0)
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
