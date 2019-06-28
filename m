Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF25A4E0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 21:11:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 018CD2194EB7F;
	Fri, 28 Jun 2019 12:11:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D65412129EBB7
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 12:11:18 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jun 2019 12:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; d="scan'208";a="173564731"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by orsmga002.jf.intel.com with ESMTP; 28 Jun 2019 12:11:17 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v5 04/13] libdaxctl: add a 'daxctl_memory' object for
 memory based operations
Date: Fri, 28 Jun 2019 13:11:01 -0600
Message-Id: <20190628191110.21428-5-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628191110.21428-1-vishal.l.verma@intel.com>
References: <20190628191110.21428-1-vishal.l.verma@intel.com>
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

Introduce a new 'daxctl_memory' object, which will be used for
operations related to managing dax devices in 'system-memory' modes.

Add libdaxctl APIs to get the target_node of a DAX device, and to
online, offline, and query the state of hotplugged memory sections
associated with a given device.

This adds the following new interfaces:

  daxctl_dev_get_target_node
  daxctl_dev_get_memory;
  daxctl_memory_get_dev;
  daxctl_memory_get_node_path;
  daxctl_memory_get_block_size;
  daxctl_memory_set_online
  daxctl_memory_set_offline
  daxctl_memory_is_online

Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl-private.h |  14 ++
 daxctl/lib/libdaxctl.c         | 333 +++++++++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym       |   8 +
 daxctl/libdaxctl.h             |  10 +
 4 files changed, 365 insertions(+)

diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index eb7c1ec..673be0f 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -33,6 +33,11 @@ static const char *dax_modules[] = {
 	[DAXCTL_DEV_MODE_RAM] = "kmem",
 };
 
+enum memory_state {
+	MEM_OFFLINE,
+	MEM_ONLINE,
+};
+
 /**
  * struct daxctl_region - container for dax_devices
  */
@@ -64,8 +69,17 @@ struct daxctl_dev {
 	struct kmod_module *module;
 	struct kmod_list *kmod_list;
 	struct daxctl_region *region;
+	struct daxctl_memory *mem;
+	int target_node;
 };
 
+struct daxctl_memory {
+struct daxctl_dev *dev;
+	char *node_path;
+	unsigned long block_size;
+};
+
+
 static inline int check_kmod(struct kmod_ctx *kmod_ctx)
 {
 	return kmod_ctx ? 0 : -ENXIO;
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 5431063..b22df50 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -200,6 +200,12 @@ DAXCTL_EXPORT void daxctl_region_get_uuid(struct daxctl_region *region, uuid_t u
 	uuid_copy(uu, region->uuid);
 }
 
+static void free_mem(struct daxctl_memory *mem)
+{
+	free(mem->node_path);
+	free(mem);
+}
+
 static void free_dev(struct daxctl_dev *dev, struct list_head *head)
 {
 	if (head)
@@ -207,6 +213,7 @@ static void free_dev(struct daxctl_dev *dev, struct list_head *head)
 	kmod_module_unref_list(dev->kmod_list);
 	free(dev->dev_buf);
 	free(dev->dev_path);
+	free_mem(dev->mem);
 	free(dev);
 }
 
@@ -343,6 +350,44 @@ static struct kmod_list *to_module_list(struct daxctl_ctx *ctx,
 	return list;
 }
 
+static struct daxctl_memory *daxctl_dev_init_mem(struct daxctl_dev *dev)
+{
+	const char *size_path = "/sys/devices/system/memory/block_size_bytes";
+	const char *node_base = "/sys/devices/system/node/node";
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	struct daxctl_memory *mem;
+	char buf[SYSFS_ATTR_SIZE];
+	int node_num;
+
+	mem = calloc(1, sizeof(*mem));
+	if (!mem)
+		return NULL;
+
+	mem->dev = dev;
+
+	/*
+	 * Everything here is best-effort, we won't fail the device add
+	 * for anything other than the ENOMEM case above.
+	 */
+	if (sysfs_read_attr(ctx, size_path, buf) == 0) {
+		mem->block_size = strtoul(buf, NULL, 16);
+		if (mem->block_size == 0 || mem->block_size == ULONG_MAX) {
+			err(ctx, "%s: Unable to determine memblock size: %s\n",
+				devname, strerror(errno));
+			mem->block_size = 0;
+		}
+	}
+
+	node_num = daxctl_dev_get_target_node(dev);
+	if (node_num >= 0) {
+		if (asprintf(&mem->node_path, "%s%d", node_base, node_num) < 0)
+			err(ctx, "%s: Unable to set node_path\n", devname);
+	}
+
+	return mem;
+}
+
 static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 {
 	const char *devname = devpath_to_devname(daxdev_base);
@@ -398,6 +443,16 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 	if (rc == 0)
 		dev->kmod_list = to_module_list(ctx, buf);
 
+	sprintf(path, "%s/target_node", daxdev_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		dev->target_node = strtol(buf, NULL, 0);
+	else
+		dev->target_node = -1;
+
+	dev->mem = daxctl_dev_init_mem(dev);
+	if (!dev->mem)
+		goto err_read;
+
 	daxctl_dev_foreach(region, dev_dup)
 		if (dev_dup->id == dev->id) {
 			free_dev(dev, NULL);
@@ -894,3 +949,281 @@ DAXCTL_EXPORT unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev)
 {
 	return dev->size;
 }
+
+DAXCTL_EXPORT int daxctl_dev_get_target_node(struct daxctl_dev *dev)
+{
+	return dev->target_node;
+}
+
+DAXCTL_EXPORT struct daxctl_memory *daxctl_dev_get_memory(struct daxctl_dev *dev)
+{
+	return dev->mem;
+}
+
+DAXCTL_EXPORT struct daxctl_dev *daxctl_memory_get_dev(struct daxctl_memory *mem)
+{
+	return mem->dev;
+}
+
+DAXCTL_EXPORT const char *daxctl_memory_get_node_path(struct daxctl_memory *mem)
+{
+	return mem->node_path;
+}
+
+DAXCTL_EXPORT unsigned long daxctl_memory_get_block_size(struct daxctl_memory *mem)
+{
+	return mem->block_size;
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
+		return 1;
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
+		return 1;
+
+	rc = sysfs_write_attr_quiet(ctx, path, mode);
+	if (rc)
+		err(ctx, "%s: Failed to offline %s: %s\n",
+			devname, path, strerror(-rc));
+	return rc;
+}
+
+static bool memblock_in_dev(struct daxctl_dev *dev, const char *memblock)
+{
+	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
+	const char *mem_base = "/sys/devices/system/memory/";
+	unsigned long long memblock_res, dev_start, dev_end;
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	unsigned long memblock_size;
+	char buf[SYSFS_ATTR_SIZE];
+	unsigned long phys_index;
+	char *index_path;
+
+	if (asprintf(&index_path, "%s/%s/phys_index", mem_base, memblock) < 0)
+		return false;
+
+	if (sysfs_read_attr(ctx, index_path, buf) == 0) {
+		phys_index = strtoul(buf, NULL, 16);
+		if (phys_index == 0 || phys_index == ULONG_MAX) {
+			err(ctx, "%s: %s: Unable to determine phys_index: %s\n",
+				devname, memblock, strerror(errno));
+			goto out_err;
+		}
+	} else {
+		err(ctx, "%s: %s: Unable to determine phys_index: %s\n",
+			devname, memblock, strerror(errno));
+		goto out_err;
+	}
+
+	dev_start = daxctl_dev_get_resource(dev);
+	if (!dev_start) {
+		err(ctx, "%s: Unable to determine resource\n", devname);
+		goto out_err;
+	}
+	dev_end = dev_start + daxctl_dev_get_size(dev);
+
+	memblock_size = daxctl_memory_get_block_size(mem);
+	if (!memblock_size) {
+		err(ctx, "%s: Unable to determine memory block size\n",
+			devname);
+		goto out_err;
+	}
+	memblock_res = phys_index * memblock_size;
+
+	if (memblock_res >= dev_start && memblock_res <= dev_end) {
+		free(index_path);
+		return true;
+	}
+
+out_err:
+	free(index_path);
+	return false;
+}
+
+static int daxctl_memory_set_state(struct daxctl_memory *mem,
+		enum memory_state state)
+{
+	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	const char *node_path;
+	int rc, changed = 0;
+	struct dirent *de;
+	DIR *node_dir;
+
+	node_path = daxctl_memory_get_node_path(mem);
+	if (!node_path) {
+		err(ctx, "%s: Failed to get node_path\n", devname);
+		return -ENXIO;
+	}
+
+	node_dir = opendir(node_path);
+	if (!node_dir)
+		return -errno;
+
+	errno = 0;
+	while ((de = readdir(node_dir)) != NULL) {
+		char *mem_path;
+
+		if (strncmp(de->d_name, "memory", 6) == 0) {
+			if (!memblock_in_dev(dev, de->d_name))
+				continue;
+			rc = asprintf(&mem_path, "%s/%s/state",
+				node_path, de->d_name);
+			if (rc < 0) {
+				rc = -ENOMEM;
+				goto out_dir;
+			}
+			if (state == MEM_ONLINE)
+				rc = online_one_memblock(dev, mem_path);
+			else if (state == MEM_OFFLINE)
+				rc = offline_one_memblock(dev, mem_path);
+			else
+				rc = -EINVAL;
+			free(mem_path);
+			if (rc < 0)
+				goto out_dir;
+			if (rc == 0)
+				changed++;
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
+	return rc;
+}
+
+DAXCTL_EXPORT int daxctl_memory_set_online(struct daxctl_memory *mem)
+{
+	return daxctl_memory_set_state(mem, MEM_ONLINE);
+}
+
+DAXCTL_EXPORT int daxctl_memory_set_offline(struct daxctl_memory *mem)
+{
+	return daxctl_memory_set_state(mem, MEM_OFFLINE);
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
+DAXCTL_EXPORT int daxctl_memory_is_online(struct daxctl_memory *mem)
+{
+	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	int rc, num_online = 0;
+	const char *node_path;
+	struct dirent *de;
+	DIR *node_dir;
+
+	node_path = daxctl_memory_get_node_path(mem);
+	if (!node_path) {
+		err(ctx, "%s: Failed to get node_path\n", devname);
+		return -ENXIO;
+	}
+
+	node_dir = opendir(node_path);
+	if (!node_dir)
+		return -errno;
+
+	errno = 0;
+	while ((de = readdir(node_dir)) != NULL) {
+		char *mem_path;
+
+		if (strncmp(de->d_name, "memory", 6) == 0) {
+			if (!memblock_in_dev(dev, de->d_name))
+				continue;
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
+	return rc;
+}
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 1692624..53eb700 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -59,4 +59,12 @@ global:
 	daxctl_dev_enable_devdax;
 	daxctl_dev_enable_ram;
 	daxctl_dev_get_resource;
+	daxctl_dev_get_target_node;
+	daxctl_dev_get_memory;
+	daxctl_memory_get_dev;
+	daxctl_memory_get_node_path;
+	daxctl_memory_get_block_size;
+	daxctl_memory_set_online;
+	daxctl_memory_set_offline;
+	daxctl_memory_is_online;
 } LIBDAXCTL_5;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index 7214cd3..a5a2bab 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -73,6 +73,16 @@ int daxctl_dev_is_enabled(struct daxctl_dev *dev);
 int daxctl_dev_disable(struct daxctl_dev *dev);
 int daxctl_dev_enable_devdax(struct daxctl_dev *dev);
 int daxctl_dev_enable_ram(struct daxctl_dev *dev);
+int daxctl_dev_get_target_node(struct daxctl_dev *dev);
+
+struct daxctl_memory;
+struct daxctl_memory *daxctl_dev_get_memory(struct daxctl_dev *dev);
+struct daxctl_dev *daxctl_memory_get_dev(struct daxctl_memory *mem);
+const char *daxctl_memory_get_node_path(struct daxctl_memory *mem);
+unsigned long daxctl_memory_get_block_size(struct daxctl_memory *mem);
+int daxctl_memory_set_online(struct daxctl_memory *mem);
+int daxctl_memory_set_offline(struct daxctl_memory *mem);
+int daxctl_memory_is_online(struct daxctl_memory *mem);
 
 #define daxctl_dev_foreach(region, dev) \
         for (dev = daxctl_dev_get_first(region); \
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
