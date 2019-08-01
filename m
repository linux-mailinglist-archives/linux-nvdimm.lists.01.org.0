Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379D37D243
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Aug 2019 02:29:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ABBF52194EB77;
	Wed, 31 Jul 2019 17:32:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 43F9B212E1592
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 17:32:09 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jul 2019 17:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,332,1559545200"; d="scan'208";a="256388829"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by orsmga001.jf.intel.com with ESMTP; 31 Jul 2019 17:29:37 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v9 01/13] libdaxctl: add interfaces to get ctx and check
 device state
Date: Wed, 31 Jul 2019 18:29:20 -0600
Message-Id: <20190801002932.26430-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801002932.26430-1-vishal.l.verma@intel.com>
References: <20190801002932.26430-1-vishal.l.verma@intel.com>
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

In preparation for libdaxctl and daxctl to grow operational modes for
DAX devices, add the following supporting APIs:

  daxctl_dev_get_ctx
  daxctl_dev_is_enabled

It also adds and uses a helper to verify the device model for the
_is_enabled API, since enable/disable only make sense for the dax-bus
model.

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl.c   | 70 ++++++++++++++++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym |  6 ++++
 daxctl/libdaxctl.h       |  2 ++
 3 files changed, 78 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index c2e3a52..916a49e 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -306,6 +306,43 @@ DAXCTL_EXPORT struct daxctl_region *daxctl_new_region(struct daxctl_ctx *ctx,
 	return region;
 }
 
+static bool device_model_is_dax_bus(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char *path = dev->dev_buf, *resolved;
+	size_t len = dev->buf_len;
+	struct stat sb;
+
+	if (snprintf(path, len, "/dev/%s", devname) < 0)
+		return false;
+
+	if (lstat(path, &sb) < 0) {
+		err(ctx, "%s: stat for %s failed: %s\n",
+			devname, path, strerror(errno));
+		return false;
+	}
+
+	if (snprintf(path, len, "/sys/dev/char/%d:%d/subsystem",
+			major(sb.st_rdev), minor(sb.st_rdev)) < 0)
+		return false;
+
+	resolved = realpath(path, NULL);
+	if (!resolved) {
+		err(ctx, "%s:  unable to determine subsys: %s\n",
+			devname, strerror(errno));
+		return false;
+	}
+
+	if (strcmp(resolved, "/sys/bus/dax") == 0) {
+		free(resolved);
+		return true;
+	}
+
+	free(resolved);
+	return false;
+}
+
 static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 {
 	const char *devname = devpath_to_devname(daxdev_base);
@@ -559,6 +596,39 @@ static void dax_regions_init(struct daxctl_ctx *ctx)
 	}
 }
 
+static int is_enabled(const char *drvpath)
+{
+	struct stat st;
+
+	if (lstat(drvpath, &st) < 0 || !S_ISLNK(st.st_mode))
+		return 0;
+	else
+		return 1;
+}
+
+DAXCTL_EXPORT int daxctl_dev_is_enabled(struct daxctl_dev *dev)
+{
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char *path = dev->dev_buf;
+	int len = dev->buf_len;
+
+	if (!device_model_is_dax_bus(dev))
+		return 1;
+
+	if (snprintf(path, len, "%s/driver", dev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_dev_get_devname(dev));
+		return 0;
+	}
+
+	return is_enabled(path);
+}
+
+DAXCTL_EXPORT struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev)
+{
+	return dev->region->ctx;
+}
+
 DAXCTL_EXPORT struct daxctl_dev *daxctl_dev_get_first(struct daxctl_region *region)
 {
 	dax_devices_init(region);
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 84d3a69..c4af9a7 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -50,3 +50,9 @@ LIBDAXCTL_5 {
 global:
 	daxctl_region_get_path;
 } LIBDAXCTL_4;
+
+LIBDAXCTL_6 {
+global:
+	daxctl_dev_get_ctx;
+	daxctl_dev_is_enabled;
+} LIBDAXCTL_5;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index 1d13ea2..e20ccb4 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -67,6 +67,8 @@ const char *daxctl_dev_get_devname(struct daxctl_dev *dev);
 int daxctl_dev_get_major(struct daxctl_dev *dev);
 int daxctl_dev_get_minor(struct daxctl_dev *dev);
 unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev);
+struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev);
+int daxctl_dev_is_enabled(struct daxctl_dev *dev);
 
 #define daxctl_dev_foreach(region, dev) \
         for (dev = daxctl_dev_get_first(region); \
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
