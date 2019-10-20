Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E49DDC25
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Oct 2019 05:23:53 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 631B61007B5C4;
	Sat, 19 Oct 2019 20:25:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 587C61007B5C0
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 20:25:38 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 20:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,318,1566889200";
   d="scan'208";a="187207957"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2019 20:23:42 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 05/10] libdaxctl: allow memblock_in_dev() to return an error
Date: Sat, 19 Oct 2019 21:23:27 -0600
Message-Id: <20191020032332.16776-6-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191020032332.16776-1-vishal.l.verma@intel.com>
References: <20191020032332.16776-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: REEREWOELLGMHXJT3S3TZO5HMOETQRXW
X-Message-ID-Hash: REEREWOELLGMHXJT3S3TZO5HMOETQRXW
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Olson <ben.olson@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/REEREWOELLGMHXJT3S3TZO5HMOETQRXW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With the MEM_FIND_ZONE operation, and the expectation that it will be
called from 'daxctl list' listings, it is possible that memblock_in_dev()
gets called without sufficient privileges. If this happens, currently,
the above simply returns a 'false'. This was acceptable when the only
operations were onlining/offlining (as there would be an actual failure
later). However, it is not acceptable in the MEM_FIND_ZONE case, as it
could yeild a different answer based on the privilege level.

Change memblock_in_dev() to return an 'int' instead of a 'bool' so that
error cases can be distinguished from actual address range test.

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 03f38f2..65a09c8 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1211,40 +1211,42 @@ static int memblock_find_zone(struct daxctl_memory *mem, char *memblock,
 	return 0;
 }
 
-static bool memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
+static int memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
 {
 	const char *mem_base = "/sys/devices/system/memory/";
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	unsigned long long memblock_res, dev_start, dev_end;
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	int rc, path_len = mem->buf_len;
 	unsigned long memblock_size;
-	int path_len = mem->buf_len;
 	char buf[SYSFS_ATTR_SIZE];
 	unsigned long phys_index;
 	char *path = mem->mem_buf;
 
 	if (snprintf(path, path_len, "%s/%s/phys_index",
 			mem_base, memblock) < 0)
-		return false;
+		return -ENXIO;
 
-	if (sysfs_read_attr(ctx, path, buf) == 0) {
+	rc = sysfs_read_attr(ctx, path, buf);
+	if (rc == 0) {
 		phys_index = strtoul(buf, NULL, 16);
 		if (phys_index == 0 || phys_index == ULONG_MAX) {
+			rc = -errno;
 			err(ctx, "%s: %s: Unable to determine phys_index: %s\n",
-				devname, memblock, strerror(errno));
-			return false;
+				devname, memblock, strerror(-rc));
+			return rc;
 		}
 	} else {
 		err(ctx, "%s: %s: Unable to determine phys_index: %s\n",
-			devname, memblock, strerror(errno));
-		return false;
+			devname, memblock, strerror(-rc));
+		return rc;
 	}
 
 	dev_start = daxctl_dev_get_resource(dev);
 	if (!dev_start) {
 		err(ctx, "%s: Unable to determine resource\n", devname);
-		return false;
+		return -EACCES;
 	}
 	dev_end = dev_start + daxctl_dev_get_size(dev);
 
@@ -1252,14 +1254,14 @@ static bool memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
 	if (!memblock_size) {
 		err(ctx, "%s: Unable to determine memory block size\n",
 			devname);
-		return false;
+		return -ENXIO;
 	}
 	memblock_res = phys_index * memblock_size;
 
 	if (memblock_res >= dev_start && memblock_res <= dev_end)
-		return true;
+		return 1;
 
-	return false;
+	return 0;
 }
 
 static int op_for_one_memblock(struct daxctl_memory *mem, char *memblock,
@@ -1317,8 +1319,12 @@ static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op op)
 	errno = 0;
 	while ((de = readdir(node_dir)) != NULL) {
 		if (strncmp(de->d_name, "memory", 6) == 0) {
-			if (!memblock_in_dev(mem, de->d_name))
+			rc = memblock_in_dev(mem, de->d_name);
+			if (rc < 0)
+				goto out_dir;
+			if (rc == 0) /* memblock not in dev */
 				continue;
+			/* memblock is in dev, perform op */
 			rc = op_for_one_memblock(mem, de->d_name, op,
 					&status_flags);
 			if (rc < 0)
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
