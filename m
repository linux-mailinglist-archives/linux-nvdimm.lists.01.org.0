Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0357775B6
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 03:52:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29B20212E15B4;
	Fri, 26 Jul 2019 18:54:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CC265212BC46B
 for <linux-nvdimm@lists.01.org>; Fri, 26 Jul 2019 18:54:44 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jul 2019 18:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,313,1559545200"; d="scan'208";a="369715453"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2019 18:52:17 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v8 04/13] libdaxctl: add a 'daxctl_memory' object for
 memory based operations
Date: Fri, 26 Jul 2019 19:52:03 -0600
Message-Id: <20190727015212.27092-5-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190727015212.27092-1-vishal.l.verma@intel.com>
References: <20190727015212.27092-1-vishal.l.verma@intel.com>
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
  daxctl_dev_get_memory
  daxctl_memory_get_dev
  daxctl_memory_get_node_path
  daxctl_memory_get_block_size
  daxctl_memory_online
  daxctl_memory_offline
  daxctl_memory_is_online
  daxctl_memory_num_sections

Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
[for the memblock-already-online TOCTOU hole]
Reported-by: Fan Du <fan.du@intel.com>
Tested-by: Fan Du <fan.du@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl-private.h |  18 ++
 daxctl/lib/libdaxctl.c         | 386 +++++++++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym       |   9 +
 daxctl/libdaxctl.h             |  11 +
 4 files changed, 424 insertions(+)

diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index fee67d1..01091de 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -39,6 +39,13 @@ static const char *dax_modules[] = {
 	[DAXCTL_DEV_MODE_RAM] = "kmem",
 };
 
+enum memory_op {
+	MEM_SET_OFFLINE,
+	MEM_SET_ONLINE,
+	MEM_IS_ONLINE,
+	MEM_COUNT,
+};
+
 /**
  * struct daxctl_region - container for dax_devices
  */
@@ -70,8 +77,19 @@ struct daxctl_dev {
 	struct kmod_module *module;
 	struct kmod_list *kmod_list;
 	struct daxctl_region *region;
+	struct daxctl_memory *mem;
+	int target_node;
+};
+
+struct daxctl_memory {
+	struct daxctl_dev *dev;
+	void *mem_buf;
+	size_t buf_len;
+	char *node_path;
+	unsigned long block_size;
 };
 
+
 static inline int check_kmod(struct kmod_ctx *kmod_ctx)
 {
 	return kmod_ctx ? 0 : -ENXIO;
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 9bbf256..a14954b 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -200,6 +200,15 @@ DAXCTL_EXPORT void daxctl_region_get_uuid(struct daxctl_region *region, uuid_t u
 	uuid_copy(uu, region->uuid);
 }
 
+static void free_mem(struct daxctl_dev *dev)
+{
+	if (dev && dev->mem) {
+		free(dev->mem->node_path);
+		free(dev->mem);
+		dev->mem = NULL;
+	}
+}
+
 static void free_dev(struct daxctl_dev *dev, struct list_head *head)
 {
 	if (head)
@@ -207,6 +216,7 @@ static void free_dev(struct daxctl_dev *dev, struct list_head *head)
 	kmod_module_unref_list(dev->kmod_list);
 	free(dev->dev_buf);
 	free(dev->dev_path);
+	free_mem(dev);
 	free(dev);
 }
 
@@ -343,6 +353,96 @@ static struct kmod_list *to_module_list(struct daxctl_ctx *ctx,
 	return list;
 }
 
+static int dev_is_system_ram_capable(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char *mod_path, *mod_base;
+	char path[200];
+	int rc = 0;
+	const int len = sizeof(path);
+
+	if (!daxctl_dev_is_enabled(dev))
+		return rc;
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
+		rc = 1;
+	else if (strcmp(mod_base, dax_modules[DAXCTL_DEV_MODE_DEVDAX]) == 0)
+		rc = 0;
+
+	free(mod_path);
+	return rc;
+}
+
+/*
+ * This checks for the device to be in system-ram mode, so calling
+ * daxctl_dev_get_memory() on a devdax mode device will always return NULL.
+ */
+static struct daxctl_memory *daxctl_dev_alloc_mem(struct daxctl_dev *dev)
+{
+	const char *size_path = "/sys/devices/system/memory/block_size_bytes";
+	const char *node_base = "/sys/devices/system/node/node";
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	struct daxctl_memory *mem;
+	char buf[SYSFS_ATTR_SIZE];
+	int node_num;
+
+	if (!dev_is_system_ram_capable(dev))
+		return NULL;
+
+	mem = calloc(1, sizeof(*mem));
+	if (!mem)
+		return NULL;
+
+	mem->dev = dev;
+
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
+		if (asprintf(&mem->node_path, "%s%d", node_base,
+				node_num) < 0) {
+			err(ctx, "%s: Unable to set node_path\n", devname);
+			goto err_mem;
+		}
+	}
+
+	mem->mem_buf = calloc(1, strlen(node_base) + 256);
+	if (!mem->mem_buf)
+		goto err_node;
+	mem->buf_len = strlen(node_base) + 256;
+
+	return mem;
+
+err_node:
+	free(mem->node_path);
+err_mem:
+	free(mem);
+	return NULL;
+}
+
 static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 {
 	const char *devname = devpath_to_devname(daxdev_base);
@@ -398,6 +498,12 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 	if (rc == 0)
 		dev->kmod_list = to_module_list(ctx, buf);
 
+	sprintf(path, "%s/target_node", daxdev_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		dev->target_node = strtol(buf, NULL, 0);
+	else
+		dev->target_node = -1;
+
 	daxctl_dev_foreach(region, dev_dup)
 		if (dev_dup->id == dev->id) {
 			free_dev(dev, NULL);
@@ -812,6 +918,9 @@ DAXCTL_EXPORT int daxctl_dev_disable(struct daxctl_dev *dev)
 	if (!daxctl_dev_is_enabled(dev))
 		return 0;
 
+	/* If there is a memory object, first free that */
+	free_mem(dev);
+
 	daxctl_unbind(ctx, dev->dev_path);
 
 	if (daxctl_dev_is_enabled(dev)) {
@@ -894,3 +1003,280 @@ DAXCTL_EXPORT unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev)
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
+	if (dev->mem)
+		return dev->mem;
+	else
+		return daxctl_dev_alloc_mem(dev);
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
+	if (rc) {
+		/*
+		 * While we performed an already-online check above, there
+		 * is still a TOCTOU hole where someone (such as a udev rule)
+		 * may have raced to online the memory. In such a case,
+		 * the sysfs store will fail, however we can check for this
+		 * by simply reading the state again. If it changed to the
+		 * desired state, then we don't have to error out.
+		 */
+		if (sysfs_read_attr(ctx, path, buf) == 0) {
+			if (strncmp(buf, "online", 6) == 0)
+				return 1;
+		}
+		err(ctx, "%s: Failed to online %s: %s\n",
+			devname, path, strerror(-rc));
+	}
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
+	if (strncmp(buf, "offline", 7) == 0)
+		return 1;
+
+	rc = sysfs_write_attr_quiet(ctx, path, mode);
+	if (rc) {
+		/* Close the TOCTOU hole like in online_one_memblock() above */
+		if (sysfs_read_attr(ctx, path, buf) == 0) {
+			if (strncmp(buf, "offline", 7) == 0)
+				return 1;
+		}
+		err(ctx, "%s: Failed to offline %s: %s\n",
+			devname, path, strerror(-rc));
+	}
+	return rc;
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
+	/* offline */
+	return 0;
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
+	int path_len = mem->buf_len;
+	char buf[SYSFS_ATTR_SIZE];
+	unsigned long phys_index;
+	char *path = mem->mem_buf;
+
+	if (snprintf(path, path_len, "%s/%s/phys_index",
+			mem_base, memblock) < 0)
+		return false;
+
+	if (sysfs_read_attr(ctx, path, buf) == 0) {
+		phys_index = strtoul(buf, NULL, 16);
+		if (phys_index == 0 || phys_index == ULONG_MAX) {
+			err(ctx, "%s: %s: Unable to determine phys_index: %s\n",
+				devname, memblock, strerror(errno));
+			return false;
+		}
+	} else {
+		err(ctx, "%s: %s: Unable to determine phys_index: %s\n",
+			devname, memblock, strerror(errno));
+		return false;
+	}
+
+	dev_start = daxctl_dev_get_resource(dev);
+	if (!dev_start) {
+		err(ctx, "%s: Unable to determine resource\n", devname);
+		return false;
+	}
+	dev_end = dev_start + daxctl_dev_get_size(dev);
+
+	memblock_size = daxctl_memory_get_block_size(mem);
+	if (!memblock_size) {
+		err(ctx, "%s: Unable to determine memory block size\n",
+			devname);
+		return false;
+	}
+	memblock_res = phys_index * memblock_size;
+
+	if (memblock_res >= dev_start && memblock_res <= dev_end)
+		return true;
+
+	return false;
+}
+
+static int op_for_one_memblock(struct daxctl_memory *mem, char *path,
+		enum memory_op op)
+{
+	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	int rc;
+
+	switch (op) {
+	case MEM_SET_ONLINE:
+		return online_one_memblock(dev, path);
+	case MEM_SET_OFFLINE:
+		return offline_one_memblock(dev, path);
+	case MEM_IS_ONLINE:
+		rc = memblock_is_online(dev, path);
+		if (rc < 0)
+			return rc;
+		/*
+		 * Retain the 'normal' semantics for if (memblock_is_online()),
+		 * but since count needs rc == 0, we'll just flip rc for this op
+		 */
+		return !rc;
+	case MEM_COUNT:
+		return 0;
+	}
+
+	err(ctx, "%s: BUG: unknown op: %d\n", devname, op);
+	return -EINVAL;
+}
+
+static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op op)
+{
+	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	const char *node_path;
+	int rc, count = 0;
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
+		char *path = mem->mem_buf;
+		int len = mem->buf_len;
+
+		if (strncmp(de->d_name, "memory", 6) == 0) {
+			if (!memblock_in_dev(dev, de->d_name))
+				continue;
+			rc = snprintf(path, len, "%s/%s/state",
+				node_path, de->d_name);
+			if (rc < 0) {
+				rc = -ENOMEM;
+				goto out_dir;
+			}
+			rc = op_for_one_memblock(mem, path, op);
+			if (rc < 0)
+				goto out_dir;
+			if (rc == 0)
+				count++;
+		}
+		errno = 0;
+	}
+	if (errno) {
+		rc = -errno;
+		goto out_dir;
+	}
+	rc = count;
+
+out_dir:
+	closedir(node_dir);
+	return rc;
+}
+
+DAXCTL_EXPORT int daxctl_memory_online(struct daxctl_memory *mem)
+{
+	return daxctl_memory_op(mem, MEM_SET_ONLINE);
+}
+
+DAXCTL_EXPORT int daxctl_memory_offline(struct daxctl_memory *mem)
+{
+	return daxctl_memory_op(mem, MEM_SET_OFFLINE);
+}
+
+DAXCTL_EXPORT int daxctl_memory_is_online(struct daxctl_memory *mem)
+{
+	return daxctl_memory_op(mem, MEM_IS_ONLINE);
+}
+
+DAXCTL_EXPORT int daxctl_memory_num_sections(struct daxctl_memory *mem)
+{
+	return daxctl_memory_op(mem, MEM_COUNT);
+}
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 1692624..bc18604 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -59,4 +59,13 @@ global:
 	daxctl_dev_enable_devdax;
 	daxctl_dev_enable_ram;
 	daxctl_dev_get_resource;
+	daxctl_dev_get_target_node;
+	daxctl_dev_get_memory;
+	daxctl_memory_get_dev;
+	daxctl_memory_get_node_path;
+	daxctl_memory_get_block_size;
+	daxctl_memory_online;
+	daxctl_memory_offline;
+	daxctl_memory_is_online;
+	daxctl_memory_num_sections;
 } LIBDAXCTL_5;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index adf55f3..fb6c3b1 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -73,6 +73,17 @@ int daxctl_dev_is_enabled(struct daxctl_dev *dev);
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
+int daxctl_memory_online(struct daxctl_memory *mem);
+int daxctl_memory_offline(struct daxctl_memory *mem);
+int daxctl_memory_is_online(struct daxctl_memory *mem);
+int daxctl_memory_num_sections(struct daxctl_memory *mem);
 
 #define daxctl_dev_foreach(region, dev) \
         for (dev = daxctl_dev_get_first(region); \
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
