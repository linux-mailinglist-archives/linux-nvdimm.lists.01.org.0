Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B602716E59
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 May 2019 02:39:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B1BD621BADAB9;
	Tue,  7 May 2019 17:39:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2B04D2194EB70
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 17:39:21 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 May 2019 17:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,443,1549958400"; d="scan'208";a="169427683"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga002.fm.intel.com with ESMTP; 07 May 2019 17:39:20 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 06/10] libdaxctl: add an interface to get the mode
 for a dax device
Date: Tue,  7 May 2019 18:38:47 -0600
Message-Id: <20190508003851.32416-7-vishal.l.verma@intel.com>
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

In preparation for a reconfigure-device command, add an interface to
retrieve the 'mode' of a dax device. This will allow the
reconfigure-device command (and via daxctl_dev_to_json()), also
daxctl-list) to print the mode on device listings via a list command or
immediately after a mode change.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl.c   | 43 ++++++++++++++++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym |  1 +
 daxctl/libdaxctl.h       |  1 +
 util/json.c              | 14 +++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index aab2364..a4919e0 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -12,6 +12,8 @@
  */
 #include <stdio.h>
 #include <errno.h>
+#include <limits.h>
+#include <libgen.h>
 #include <stdlib.h>
 #include <dirent.h>
 #include <unistd.h>
@@ -840,6 +842,47 @@ DAXCTL_EXPORT int daxctl_dev_disable(struct daxctl_dev *dev)
 	return 0;
 }
 
+DAXCTL_EXPORT enum daxctl_dev_mode daxctl_dev_get_mode(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	int rc = DAXCTL_DEV_MODE_UNKNOWN;
+	char path[200];
+	const int len = sizeof(path);
+	char *mod_path, *mod_base;
+
+	if (!daxctl_dev_is_enabled(dev))
+		return rc;
+
+	if (ctx->subsys != DAX_BUS) {
+		err(ctx, "%s: invalid operation for dax subsystem\n", devname);
+		err(ctx, "%s:  see daxctl-migrate-device-model(1)\n", devname);
+		return -ENXIO;
+	}
+
+	if (snprintf(path, len, "%s/driver/module", dev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n", devname);
+		return -ENXIO;
+	}
+
+	mod_path = realpath(path, NULL);
+	if (!mod_path) {
+		rc = -errno;
+		err(ctx, "%s:  unable to determine module: %s\n", devname,
+			strerror(errno));
+		return rc;
+	}
+
+	mod_base = basename(mod_path);
+	if (strcmp(mod_base, dax_modules[DAXCTL_DEV_MODE_RAM]) == 0)
+		rc = DAXCTL_DEV_MODE_RAM;
+	else if (strcmp(mod_base, dax_modules[DAXCTL_DEV_MODE_DEVDAX]) == 0)
+		rc = DAXCTL_DEV_MODE_DEVDAX;
+
+	free(mod_path);
+	return rc;
+}
+
 DAXCTL_EXPORT struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev)
 {
 	return dev->region->ctx;
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index cc47ed6..d53976d 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -62,4 +62,5 @@ global:
 	daxctl_dev_online_node;
 	daxctl_dev_offline_node;
 	daxctl_dev_node_is_online;
+	daxctl_dev_get_mode;
 } LIBDAXCTL_5;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index db0d4ea..4f9088f 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -76,6 +76,7 @@ int daxctl_dev_enable_ram(struct daxctl_dev *dev);
 int daxctl_dev_online_node(struct daxctl_dev *dev);
 int daxctl_dev_offline_node(struct daxctl_dev *dev);
 int daxctl_dev_node_is_online(struct daxctl_dev *dev);
+enum daxctl_dev_mode daxctl_dev_get_mode(struct daxctl_dev *dev);
 
 #define daxctl_dev_foreach(region, dev) \
         for (dev = daxctl_dev_get_first(region); \
diff --git a/util/json.c b/util/json.c
index b7ce719..4f13222 100644
--- a/util/json.c
+++ b/util/json.c
@@ -271,6 +271,7 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 {
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct json_object *jdev, *jobj;
+	enum daxctl_dev_mode mode;
 	int node;
 
 	jdev = json_object_new_object();
@@ -292,6 +293,19 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 			json_object_object_add(jdev, "numa_node", jobj);
 	}
 
+	mode = daxctl_dev_get_mode(dev);
+	if (mode > 0) {
+		jobj = NULL;
+		if (mode == DAXCTL_DEV_MODE_RAM)
+			jobj = json_object_new_string("system-ram");
+		else if (mode == DAXCTL_DEV_MODE_DEVDAX)
+			jobj = json_object_new_string("devdax");
+		else
+			jobj = json_object_new_string("unknown");
+		if (jobj)
+			json_object_object_add(jdev, "mode", jobj);
+	}
+
 	return jdev;
 }
 
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
