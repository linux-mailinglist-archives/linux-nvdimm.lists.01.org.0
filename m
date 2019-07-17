Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DE16C33C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 00:54:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 125742194EB76;
	Wed, 17 Jul 2019 15:56:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C88BB212ABA55
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 15:56:35 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2019 15:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,275,1559545200"; d="scan'208";a="191413557"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2019 15:54:06 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v6 03/13] libdaxctl: add an interface to retrieve the
 device resource
Date: Wed, 17 Jul 2019 16:53:50 -0600
Message-Id: <20190717225400.9494-4-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717225400.9494-1-vishal.l.verma@intel.com>
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
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
 Pavel Tatashin <pasha.tatashin@soleen.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add an interface to retrieve the 'resource' attribute for a dax device.

Attempt to retrieve it as usual via sysfs, but since older kernels may
be missing this attribute, as a fallback, attempt to retrieve it from
/proc/iomem

Cc: Dan Williams <dan.j.williams@intel.com>
[fscanf format string problem and diagnosis]
Reported-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Makefile.am                    |  3 ++-
 daxctl/lib/Makefile.am         |  2 ++
 daxctl/lib/libdaxctl-private.h |  1 +
 daxctl/lib/libdaxctl.c         | 12 +++++++++++
 daxctl/lib/libdaxctl.sym       |  1 +
 daxctl/libdaxctl.h             |  1 +
 util/iomem.c                   | 37 ++++++++++++++++++++++++++++++++++
 util/iomem.h                   | 12 +++++++++++
 8 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 util/iomem.c
 create mode 100644 util/iomem.h

diff --git a/Makefile.am b/Makefile.am
index df8797e..8d10a10 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -74,6 +74,7 @@ libutil_a_SOURCES = \
 	util/wrapper.c \
 	util/filter.c \
 	util/bitmap.c \
-	util/abspath.c
+	util/abspath.c \
+	util/iomem.c
 
 nobase_include_HEADERS = daxctl/libdaxctl.h
diff --git a/daxctl/lib/Makefile.am b/daxctl/lib/Makefile.am
index 9f0e444..7704b1b 100644
--- a/daxctl/lib/Makefile.am
+++ b/daxctl/lib/Makefile.am
@@ -9,6 +9,8 @@ lib_LTLIBRARIES = libdaxctl.la
 libdaxctl_la_SOURCES =\
 	../libdaxctl.h \
 	libdaxctl-private.h \
+	../../util/iomem.c \
+	../../util/iomem.h \
 	../../util/sysfs.c \
 	../../util/sysfs.h \
 	../../util/log.c \
diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index e64d0a7..eb7c1ec 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -59,6 +59,7 @@ struct daxctl_dev {
 	size_t buf_len;
 	char *dev_path;
 	struct list_node list;
+	unsigned long long resource;
 	unsigned long long size;
 	struct kmod_module *module;
 	struct kmod_list *kmod_list;
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 05f013b..5431063 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -24,6 +24,7 @@
 
 #include <util/log.h>
 #include <util/sysfs.h>
+#include <util/iomem.h>
 #include <daxctl/libdaxctl.h>
 #include "libdaxctl-private.h"
 
@@ -369,6 +370,12 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 	dev->major = major(st.st_rdev);
 	dev->minor = minor(st.st_rdev);
 
+	sprintf(path, "%s/resource", daxdev_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		dev->resource = strtoull(buf, NULL, 0);
+	else
+		dev->resource = iomem_get_dev_resource(ctx, daxdev_base);
+
 	sprintf(path, "%s/size", daxdev_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
@@ -878,6 +885,11 @@ DAXCTL_EXPORT int daxctl_dev_get_minor(struct daxctl_dev *dev)
 	return dev->minor;
 }
 
+DAXCTL_EXPORT unsigned long long daxctl_dev_get_resource(struct daxctl_dev *dev)
+{
+	return dev->resource;
+}
+
 DAXCTL_EXPORT unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev)
 {
 	return dev->size;
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 19904a2..1692624 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -58,4 +58,5 @@ global:
 	daxctl_dev_disable;
 	daxctl_dev_enable_devdax;
 	daxctl_dev_enable_ram;
+	daxctl_dev_get_resource;
 } LIBDAXCTL_5;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index b80488e..7214cd3 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -66,6 +66,7 @@ int daxctl_dev_get_id(struct daxctl_dev *dev);
 const char *daxctl_dev_get_devname(struct daxctl_dev *dev);
 int daxctl_dev_get_major(struct daxctl_dev *dev);
 int daxctl_dev_get_minor(struct daxctl_dev *dev);
+unsigned long long daxctl_dev_get_resource(struct daxctl_dev *dev);
 unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev);
 struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev);
 int daxctl_dev_is_enabled(struct daxctl_dev *dev);
diff --git a/util/iomem.c b/util/iomem.c
new file mode 100644
index 0000000..a3c23f5
--- /dev/null
+++ b/util/iomem.c
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
+
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <util/log.h>
+#include <util/iomem.h>
+#include <util/sysfs.h>
+
+unsigned long long __iomem_get_dev_resource(struct log_ctx *ctx,
+		const char *devpath)
+{
+	const char *devname = devpath_to_devname(devpath);
+	FILE *fp = fopen("/proc/iomem", "r");
+	unsigned long long res;
+	char name[256];
+
+	if (fp == NULL) {
+		log_err(ctx, "%s: open /proc/iomem: %s\n", devname,
+				strerror(errno));
+		return 0;
+	}
+
+	while (fscanf(fp, "%llx-%*x : %254[^\n]\n", &res, name) == 2) {
+		if (strcmp(name, devname) == 0) {
+			log_dbg(ctx, "%s: got resource via iomem: %#llx\n",
+					devname, res);
+			fclose(fp);
+			return res;
+		}
+	}
+
+	log_dbg(ctx, "%s: not found in iomem\n", devname);
+	fclose(fp);
+	return 0;
+}
diff --git a/util/iomem.h b/util/iomem.h
new file mode 100644
index 0000000..aaaf6a7
--- /dev/null
+++ b/util/iomem.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
+#ifndef _NDCTL_IOMEM_H_
+#define _NDCTL_IOMEM_H_
+
+struct log_ctx;
+unsigned long long __iomem_get_dev_resource(struct log_ctx *ctx,
+		const char *path);
+
+#define iomem_get_dev_resource(c, p) __iomem_get_dev_resource(&(c)->ctx, (p))
+
+#endif /* _NDCTL_IOMEM_H_ */
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
