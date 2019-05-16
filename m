Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D62109C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 00:41:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 725F221255850;
	Thu, 16 May 2019 15:41:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DD08A212532F5
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 15:41:00 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 May 2019 15:41:00 -0700
X-ExtLoop1: 1
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by FMSMGA003.fm.intel.com with ESMTP; 16 May 2019 15:41:00 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v3 04/10] libdaxctl: add interfaces to get/set the
 online state for a node
Date: Thu, 16 May 2019 16:40:47 -0600
Message-Id: <20190516224053.3655-5-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516224053.3655-1-vishal.l.verma@intel.com>
References: <20190516224053.3655-1-vishal.l.verma@intel.com>
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

In preparation for converting DAX devices for use as system-ram via the
kernel's 'kmem' facility, add libndctl helpers to manipulate the sysfs
interfaces to get the target_node of a DAX device, and to online,
offline, and query the state of hotplugged memory sections associated
with a given node.

This adds the following new interfaces:

  daxctl_dev_get_target_node
  daxctl_dev_online_node
  daxctl_dev_offline_node
  daxctl_dev_node_is_online

Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl-private.h |   6 +
 daxctl/lib/libdaxctl.c         | 228 +++++++++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym       |   4 +
 daxctl/libdaxctl.h             |   4 +
 4 files changed, 242 insertions(+)

diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index e64d0a7..ef443aa 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -33,6 +33,11 @@ static const char *dax_modules[] = {
 	[DAXCTL_DEV_MODE_RAM] = "kmem",
 };
 
+enum node_state {
+	NODE_OFFLINE,
+	NODE_ONLINE,
+};
+
 /**
  * struct daxctl_region - container for dax_devices
  */
@@ -63,6 +68,7 @@ struct daxctl_dev {
 	struct kmod_module *module;
 	struct kmod_list *kmod_list;
 	struct daxctl_region *region;
+	int target_node;
 };
 
 static inline int check_kmod(struct kmod_ctx *kmod_ctx)
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index d50b321..aab2364 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -28,6 +28,7 @@
 #include "libdaxctl-private.h"
 
 static const char *attrs = "dax_region";
+static const char *node_base = "/sys/devices/system/node";
 
 static void free_region(struct daxctl_region *region, struct list_head *head);
 
@@ -397,6 +398,12 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 	} else
 		dbg(ctx, "%s: modalias attribute missing\n", devname);
 
+	sprintf(path, "%s/target_node", daxdev_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		dev->target_node = strtol(buf, NULL, 0);
+	else
+		dev->target_node = -1;
+
 	daxctl_dev_foreach(region, dev_dup)
 		if (dev_dup->id == dev->id) {
 			free_dev(dev, NULL);
@@ -897,3 +904,224 @@ DAXCTL_EXPORT unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev)
 {
 	return dev->size;
 }
+
+DAXCTL_EXPORT int daxctl_dev_get_target_node(struct daxctl_dev *dev)
+{
+	return dev->target_node;
+}
+
+static int online_one_memblock(struct daxctl_dev *dev, char *path)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	const char *mode = "online_movable";
+	char buf[SYSFS_ATTR_SIZE];
+	int rc;
+
+	rc = sysfs_read_attr(ctx, path, buf);
+	if (rc) {
+		err(ctx, "%s: Failed to read %s: %s\n",
+			devname, path, strerror(-rc));
+		return rc;
+	}
+
+	/*
+	 * if already online, possibly due to kernel config or a udev rule,
+	 * there is nothing to do and we can skip over the memblock
+	 */
+	if (strncmp(buf, "online", 6) == 0)
+		return 0;
+
+	rc = sysfs_write_attr_quiet(ctx, path, mode);
+	if (rc)
+		err(ctx, "%s: Failed to online %s: %s\n",
+			devname, path, strerror(-rc));
+	return rc;
+}
+
+static int offline_one_memblock(struct daxctl_dev *dev, char *path)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	const char *mode = "offline";
+	char buf[SYSFS_ATTR_SIZE];
+	int rc;
+
+	rc = sysfs_read_attr(ctx, path, buf);
+	if (rc) {
+		err(ctx, "%s: Failed to read %s: %s\n",
+			devname, path, strerror(-rc));
+		return rc;
+	}
+
+	/* if already offline, there is nothing to do */
+	if (strncmp(buf, "offline", 6) == 0)
+		return 0;
+
+	rc = sysfs_write_attr_quiet(ctx, path, mode);
+	if (rc)
+		err(ctx, "%s: Failed to offline %s: %s\n",
+			devname, path, strerror(-rc));
+	return rc;
+}
+
+static int daxctl_dev_node_set_state(struct daxctl_dev *dev,
+		enum node_state state)
+{
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	int target_node, rc, changed = 0;
+	struct dirent *de;
+	char *node_path;
+	DIR *node_dir;
+
+	target_node = daxctl_dev_get_target_node(dev);
+	if (target_node < 0) {
+		err(ctx, "%s: Unable to get target node\n",
+			daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+
+	rc = asprintf(&node_path, "%s/node%d", node_base, target_node);
+	if (rc < 0)
+		return -ENOMEM;
+
+	node_dir = opendir(node_path);
+	if (!node_dir) {
+		rc = -errno;
+		goto out_path;
+	}
+
+	errno = 0;
+	while ((de = readdir(node_dir)) != NULL) {
+		char *mem_path;
+
+		if (strcmp(de->d_name, ".") == 0 ||
+				strcmp(de->d_name, "..") == 0)
+			continue;
+		if (strncmp(de->d_name, "memory", 6) == 0) {
+			rc = asprintf(&mem_path, "%s/%s/state",
+				node_path, de->d_name);
+			if (rc < 0) {
+				rc = -ENOMEM;
+				goto out_dir;
+			}
+			if (state == NODE_ONLINE)
+				rc = online_one_memblock(dev, mem_path);
+			else if (state == NODE_OFFLINE)
+				rc = offline_one_memblock(dev, mem_path);
+			else
+				rc = -EINVAL;
+			free(mem_path);
+			if (rc)
+				goto out_dir;
+			changed++;
+		}
+		errno = 0;
+	}
+	if (errno) {
+		rc = -errno;
+		goto out_dir;
+	}
+	rc = changed;
+
+out_dir:
+	closedir(node_dir);
+out_path:
+	free(node_path);
+	return rc;
+}
+
+DAXCTL_EXPORT int daxctl_dev_online_node(struct daxctl_dev *dev)
+{
+	return daxctl_dev_node_set_state(dev, NODE_ONLINE);
+}
+
+DAXCTL_EXPORT int daxctl_dev_offline_node(struct daxctl_dev *dev)
+{
+	return daxctl_dev_node_set_state(dev, NODE_OFFLINE);
+}
+
+static int memblock_is_online(struct daxctl_dev *dev, char *path)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char buf[SYSFS_ATTR_SIZE];
+	int rc;
+
+	rc = sysfs_read_attr(ctx, path, buf);
+	if (rc) {
+		err(ctx, "%s: Failed to read %s: %s\n",
+			devname, path, strerror(-rc));
+		return rc;
+	}
+
+	if (strncmp(buf, "online", 6) == 0)
+		return 1;
+
+	return 0;
+}
+
+DAXCTL_EXPORT int daxctl_dev_node_is_online(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	int target_node, rc, num_online = 0;
+	struct dirent *de;
+	char *node_path;
+	DIR *node_dir;
+
+	target_node = daxctl_dev_get_target_node(dev);
+	if (target_node < 0) {
+		err(ctx, "%s: Unable to get target node\n", devname);
+		return -ENXIO;
+	}
+
+	rc = asprintf(&node_path, "%s/node%d", node_base, target_node);
+	if (rc < 0)
+		return -ENOMEM;
+
+	node_dir = opendir(node_path);
+	if (!node_dir) {
+		rc = -errno;
+		goto out_path;
+	}
+
+	errno = 0;
+	while ((de = readdir(node_dir)) != NULL) {
+		char *mem_path;
+
+		if (strcmp(de->d_name, ".") == 0 ||
+				strcmp(de->d_name, "..") == 0)
+			continue;
+		if (strncmp(de->d_name, "memory", 6) == 0) {
+			rc = asprintf(&mem_path, "%s/%s/state",
+				node_path, de->d_name);
+			if (rc < 0) {
+				rc = -ENOMEM;
+				goto out_dir;
+			}
+			rc = memblock_is_online(dev, mem_path);
+			if (rc < 0) {
+				err(ctx, "%s: Unable to determine state: %s\n",
+					devname, mem_path);
+				goto out_dir;
+			}
+			if (rc > 0)
+				num_online++;
+			free(mem_path);
+		}
+		errno = 0;
+	}
+	if (errno) {
+		rc = -errno;
+		goto out_dir;
+	}
+	rc = num_online;
+
+out_dir:
+	closedir(node_dir);
+out_path:
+	free(node_path);
+	return rc;
+
+}
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 19904a2..cc47ed6 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -54,8 +54,12 @@ global:
 LIBDAXCTL_6 {
 global:
 	daxctl_dev_get_ctx;
+	daxctl_dev_get_target_node;
 	daxctl_dev_is_enabled;
 	daxctl_dev_disable;
 	daxctl_dev_enable_devdax;
 	daxctl_dev_enable_ram;
+	daxctl_dev_online_node;
+	daxctl_dev_offline_node;
+	daxctl_dev_node_is_online;
 } LIBDAXCTL_5;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index b80488e..db0d4ea 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -68,10 +68,14 @@ int daxctl_dev_get_major(struct daxctl_dev *dev);
 int daxctl_dev_get_minor(struct daxctl_dev *dev);
 unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev);
 struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev);
+int daxctl_dev_get_target_node(struct daxctl_dev *dev);
 int daxctl_dev_is_enabled(struct daxctl_dev *dev);
 int daxctl_dev_disable(struct daxctl_dev *dev);
 int daxctl_dev_enable_devdax(struct daxctl_dev *dev);
 int daxctl_dev_enable_ram(struct daxctl_dev *dev);
+int daxctl_dev_online_node(struct daxctl_dev *dev);
+int daxctl_dev_offline_node(struct daxctl_dev *dev);
+int daxctl_dev_node_is_online(struct daxctl_dev *dev);
 
 #define daxctl_dev_foreach(region, dev) \
         for (dev = daxctl_dev_get_first(region); \
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
