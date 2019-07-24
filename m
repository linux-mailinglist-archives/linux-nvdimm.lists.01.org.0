Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CA974115
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jul 2019 23:57:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D0502194EB7F;
	Wed, 24 Jul 2019 15:00:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E2A02212DA5ED
 for <linux-nvdimm@lists.01.org>; Wed, 24 Jul 2019 15:00:13 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jul 2019 14:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,304,1559545200"; d="scan'208";a="193602207"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2019 14:57:46 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v7 02/13] libdaxctl: add interfaces to enable/disable
 devices
Date: Wed, 24 Jul 2019 15:57:30 -0600
Message-Id: <20190724215741.18556-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724215741.18556-1-vishal.l.verma@intel.com>
References: <20190724215741.18556-1-vishal.l.verma@intel.com>
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

Add new libdaxctl interfaces to disable a device_dax based device, and
to enable it into the given mode. The modes available are 'devdax',
and 'system-ram', where devdax is the normal device DAX mode used
via a character device, and 'system-ram' uses the kernel's 'kmem'
facility to hotplug the device making it usable as normal memory.

This adds the following new interfaces:

  daxctl_dev_disable;
  daxctl_dev_enable_devdax;
  daxctl_dev_enable_ram;

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/Makefile.am         |   3 +-
 daxctl/lib/libdaxctl-private.h |  21 +++
 daxctl/lib/libdaxctl.c         | 234 +++++++++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym       |   3 +
 daxctl/libdaxctl.h             |   3 +
 5 files changed, 263 insertions(+), 1 deletion(-)

diff --git a/daxctl/lib/Makefile.am b/daxctl/lib/Makefile.am
index d3d4852..9f0e444 100644
--- a/daxctl/lib/Makefile.am
+++ b/daxctl/lib/Makefile.am
@@ -16,7 +16,8 @@ libdaxctl_la_SOURCES =\
 	libdaxctl.c
 
 libdaxctl_la_LIBADD =\
-	$(UUID_LIBS)
+	$(UUID_LIBS) \
+	$(KMOD_LIBS)
 
 daxctl_modprobe_data_DATA = daxctl.conf
 
diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index 4a462e7..120137f 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -13,6 +13,8 @@
 #ifndef _LIBDAXCTL_PRIVATE_H_
 #define _LIBDAXCTL_PRIVATE_H_
 
+#include <libkmod.h>
+
 #define DAXCTL_EXPORT __attribute__ ((visibility("default")))
 
 enum dax_subsystem {
@@ -26,6 +28,17 @@ static const char *dax_subsystems[] = {
 	[DAX_BUS] = "/sys/bus/dax/devices",
 };
 
+enum daxctl_dev_mode {
+	DAXCTL_DEV_MODE_DEVDAX = 0,
+	DAXCTL_DEV_MODE_RAM,
+	DAXCTL_DEV_MODE_END,
+};
+
+static const char *dax_modules[] = {
+	[DAXCTL_DEV_MODE_DEVDAX] = "device_dax",
+	[DAXCTL_DEV_MODE_RAM] = "kmem",
+};
+
 /**
  * struct daxctl_region - container for dax_devices
  */
@@ -53,6 +66,14 @@ struct daxctl_dev {
 	char *dev_path;
 	struct list_node list;
 	unsigned long long size;
+	struct kmod_module *module;
+	struct kmod_list *kmod_list;
 	struct daxctl_region *region;
 };
+
+static inline int check_kmod(struct kmod_ctx *kmod_ctx)
+{
+	return kmod_ctx ? 0 : -ENXIO;
+}
+
 #endif /* _LIBDAXCTL_PRIVATE_H_ */
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 70f896b..85c4fbe 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -46,6 +46,7 @@ struct daxctl_ctx {
 	void *userdata;
 	int regions_init;
 	struct list_head regions;
+	struct kmod_ctx *kmod_ctx;
 };
 
 /**
@@ -84,20 +85,32 @@ DAXCTL_EXPORT void daxctl_set_userdata(struct daxctl_ctx *ctx, void *userdata)
  */
 DAXCTL_EXPORT int daxctl_new(struct daxctl_ctx **ctx)
 {
+	struct kmod_ctx *kmod_ctx;
 	struct daxctl_ctx *c;
+	int rc = 0;
 
 	c = calloc(1, sizeof(struct daxctl_ctx));
 	if (!c)
 		return -ENOMEM;
 
+	kmod_ctx = kmod_new(NULL, NULL);
+	if (check_kmod(kmod_ctx) != 0) {
+		rc = -ENXIO;
+		goto out;
+	}
+
 	c->refcount = 1;
 	log_init(&c->ctx, "libdaxctl", "DAXCTL_LOG");
 	info(c, "ctx %p created\n", c);
 	dbg(c, "log_priority=%d\n", c->ctx.log_priority);
 	*ctx = c;
 	list_head_init(&c->regions);
+	c->kmod_ctx = kmod_ctx;
 
 	return 0;
+out:
+	free(c);
+	return rc;
 }
 
 /**
@@ -132,6 +145,7 @@ DAXCTL_EXPORT void daxctl_unref(struct daxctl_ctx *ctx)
 	list_for_each_safe(&ctx->regions, region, _r, list)
 		free_region(region, &ctx->regions);
 
+	kmod_unref(ctx->kmod_ctx);
 	info(ctx, "context %p released\n", ctx);
 	free(ctx);
 }
@@ -189,6 +203,7 @@ static void free_dev(struct daxctl_dev *dev, struct list_head *head)
 {
 	if (head)
 		list_del_from(head, &dev->list);
+	kmod_module_unref_list(dev->kmod_list);
 	free(dev->dev_buf);
 	free(dev->dev_path);
 	free(dev);
@@ -306,6 +321,27 @@ DAXCTL_EXPORT struct daxctl_region *daxctl_new_region(struct daxctl_ctx *ctx,
 	return region;
 }
 
+static struct kmod_list *to_module_list(struct daxctl_ctx *ctx,
+		const char *alias)
+{
+	struct kmod_list *list = NULL;
+	int rc;
+
+	if (!ctx->kmod_ctx || !alias)
+		return NULL;
+	if (alias[0] == 0)
+		return NULL;
+
+	rc = kmod_module_new_from_lookup(ctx->kmod_ctx, alias, &list);
+	if (rc < 0 || !list) {
+		dbg(ctx, "failed to find modules for alias: %s %d list: %s\n",
+				alias, rc, list ? "populated" : "empty");
+		return NULL;
+	}
+
+	return list;
+}
+
 static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 {
 	const char *devname = devpath_to_devname(daxdev_base);
@@ -315,6 +351,7 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 	struct daxctl_dev *dev, *dev_dup;
 	char buf[SYSFS_ATTR_SIZE];
 	struct stat st;
+	int rc;
 
 	if (!path)
 		return NULL;
@@ -346,6 +383,14 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 		goto err_read;
 	dev->buf_len = strlen(daxdev_base) + 50;
 
+	sprintf(path, "%s/modalias", daxdev_base);
+	rc = sysfs_read_attr(ctx, path, buf);
+	/* older kernels may be lack the modalias attribute */
+	if (rc < 0 && rc != -ENOENT)
+		goto err_read;
+	if (rc == 0)
+		dev->kmod_list = to_module_list(ctx, buf);
+
 	daxctl_dev_foreach(region, dev_dup)
 		if (dev_dup->id == dev->id) {
 			free_dev(dev, NULL);
@@ -569,6 +614,92 @@ static int is_enabled(const char *drvpath)
 		return 1;
 }
 
+static int daxctl_bind(struct daxctl_ctx *ctx, const char *devname,
+		const char *mod_name)
+{
+	DIR *dir;
+	int rc = 0;
+	char path[200];
+	struct dirent *de;
+	const int len = sizeof(path);
+
+	if (!devname) {
+		err(ctx, "missing devname\n");
+		return -EINVAL;
+	}
+
+	if (snprintf(path, len, "/sys/bus/dax/drivers") >= len) {
+		err(ctx, "%s: buffer too small!\n", devname);
+		return -ENXIO;
+	}
+
+	dir = opendir(path);
+	if (!dir) {
+		err(ctx, "%s: opendir(\"%s\") failed\n", devname, path);
+		return -ENXIO;
+	}
+
+	while ((de = readdir(dir)) != NULL) {
+		char *drv_path;
+
+		if (de->d_ino == 0)
+			continue;
+		if (de->d_name[0] == '.')
+			continue;
+		if (strcmp(de->d_name, mod_name) != 0)
+			continue;
+
+		if (asprintf(&drv_path, "%s/%s/new_id", path, de->d_name) < 0) {
+			err(ctx, "%s: path allocation failure\n", devname);
+			rc = -ENOMEM;
+			break;
+		}
+		rc = sysfs_write_attr_quiet(ctx, drv_path, devname);
+		free(drv_path);
+
+		if (asprintf(&drv_path, "%s/%s/bind", path, de->d_name) < 0) {
+			err(ctx, "%s: path allocation failure\n", devname);
+			rc = -ENOMEM;
+			break;
+		}
+		rc = sysfs_write_attr_quiet(ctx, drv_path, devname);
+		free(drv_path);
+		break;
+	}
+	closedir(dir);
+
+	if (rc) {
+		dbg(ctx, "%s: bind failed\n", devname);
+		return rc;
+	}
+	return 0;
+}
+
+static int daxctl_unbind(struct daxctl_ctx *ctx, const char *devpath)
+{
+	const char *devname = devpath_to_devname(devpath);
+	char path[200];
+	const int len = sizeof(path);
+	int rc;
+
+	if (snprintf(path, len, "%s/driver/remove_id", devpath) >= len) {
+		err(ctx, "%s: buffer too small!\n", devname);
+		return -ENXIO;
+	}
+
+	rc = sysfs_write_attr(ctx, path, devname);
+	if (rc)
+		return rc;
+
+	if (snprintf(path, len, "%s/driver/unbind", devpath) >= len) {
+		err(ctx, "%s: buffer too small!\n", devname);
+		return -ENXIO;
+	}
+
+	return sysfs_write_attr(ctx, path, devname);
+
+}
+
 DAXCTL_EXPORT int daxctl_dev_is_enabled(struct daxctl_dev *dev)
 {
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
@@ -584,6 +715,109 @@ DAXCTL_EXPORT int daxctl_dev_is_enabled(struct daxctl_dev *dev)
 	return is_enabled(path);
 }
 
+static int daxctl_insert_kmod_for_mode(struct daxctl_dev *dev,
+		const char *mod_name)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	struct kmod_list *iter;
+	int rc = -ENXIO;
+
+	if (dev->kmod_list == NULL) {
+		err(ctx, "%s: a modalias lookup list was not created\n",
+				devname);
+		return rc;
+	}
+
+	kmod_list_foreach(iter, dev->kmod_list) {
+		struct kmod_module *mod = kmod_module_get_module(iter);
+		const char *name = kmod_module_get_name(mod);
+
+		if (strcmp(name, mod_name) != 0) {
+			kmod_module_unref(mod);
+			continue;
+		}
+		dbg(ctx, "%s inserting module: %s\n", devname, name);
+		rc = kmod_module_probe_insert_module(mod,
+				KMOD_PROBE_APPLY_BLACKLIST, NULL, NULL, NULL,
+				NULL);
+		if (rc < 0) {
+			err(ctx, "%s: insert failure: %d\n", devname, rc);
+			return rc;
+		}
+		dev->module = mod;
+	}
+
+	if (rc == -ENXIO)
+		err(ctx, "%s: Unable to find module: %s in alias list\n",
+				devname, mod_name);
+	return rc;
+}
+
+static int daxctl_dev_enable(struct daxctl_dev *dev, enum daxctl_dev_mode mode)
+{
+	struct daxctl_region *region = daxctl_dev_get_region(dev);
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	const char *mod_name = dax_modules[mode];
+	int rc;
+
+	if (daxctl_dev_is_enabled(dev))
+		return 0;
+
+	if (mode >= DAXCTL_DEV_MODE_END || mod_name == NULL) {
+		err(ctx, "%s: Invalid mode: %d\n", devname, mode);
+		return -EINVAL;
+	}
+
+	rc = daxctl_insert_kmod_for_mode(dev, mod_name);
+	if (rc)
+		return rc;
+
+	rc = daxctl_bind(ctx, devname, mod_name);
+	if (!daxctl_dev_is_enabled(dev)) {
+		err(ctx, "%s: failed to enable\n", devname);
+		return rc ? rc : -ENXIO;
+	}
+
+	region->devices_init = 0;
+	dax_devices_init(region);
+	rc = 0;
+	dbg(ctx, "%s: enabled\n", devname);
+	return rc;
+}
+
+DAXCTL_EXPORT int daxctl_dev_enable_devdax(struct daxctl_dev *dev)
+{
+	return daxctl_dev_enable(dev, DAXCTL_DEV_MODE_DEVDAX);
+}
+
+DAXCTL_EXPORT int daxctl_dev_enable_ram(struct daxctl_dev *dev)
+{
+	return daxctl_dev_enable(dev, DAXCTL_DEV_MODE_RAM);
+}
+
+DAXCTL_EXPORT int daxctl_dev_disable(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+
+	if (!daxctl_dev_is_enabled(dev))
+		return 0;
+
+	daxctl_unbind(ctx, dev->dev_path);
+
+	if (daxctl_dev_is_enabled(dev)) {
+		err(ctx, "%s: failed to disable\n", devname);
+		return -EBUSY;
+	}
+
+	kmod_module_unref(dev->module);
+	dbg(ctx, "%s: disabled\n", devname);
+
+	return 0;
+}
+
 DAXCTL_EXPORT struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev)
 {
 	return dev->region->ctx;
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index c4af9a7..19904a2 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -55,4 +55,7 @@ LIBDAXCTL_6 {
 global:
 	daxctl_dev_get_ctx;
 	daxctl_dev_is_enabled;
+	daxctl_dev_disable;
+	daxctl_dev_enable_devdax;
+	daxctl_dev_enable_ram;
 } LIBDAXCTL_5;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index e20ccb4..407f459 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -69,6 +69,9 @@ int daxctl_dev_get_minor(struct daxctl_dev *dev);
 unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev);
 struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev);
 int daxctl_dev_is_enabled(struct daxctl_dev *dev);
+int daxctl_dev_disable(struct daxctl_dev *dev);
+int daxctl_dev_enable_devdax(struct daxctl_dev *dev);
+int daxctl_dev_enable_ram(struct daxctl_dev *dev);
 
 #define daxctl_dev_foreach(region, dev) \
         for (dev = daxctl_dev_get_first(region); \
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
