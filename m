Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5718284E
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 01:57:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4CCE213281F9;
	Mon,  5 Aug 2019 17:00:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 70426213281EB
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 17:00:01 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 16:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; d="scan'208";a="178993377"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga006.jf.intel.com with ESMTP; 05 Aug 2019 16:57:29 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 5 Aug 2019 16:57:29 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.86]) by
 fmsmsx156.amr.corp.intel.com ([169.254.13.183]) with mapi id 14.03.0439.000;
 Mon, 5 Aug 2019 16:57:28 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH v9 04/13] libdaxctl: add a 'daxctl_memory' object
 for memory based operations
Thread-Topic: [ndctl PATCH v9 04/13] libdaxctl: add a 'daxctl_memory' object
 for memory based operations
Thread-Index: AQHVSAA1C9UcCSPPT0+nRWYWkHdsgqbtuGmA
Date: Mon, 5 Aug 2019 23:57:28 +0000
Message-ID: <a772141b4fec163cd52f6edd64fcb5e7e0a3f801.camel@intel.com>
References: <20190801002932.26430-1-vishal.l.verma@intel.com>
 <20190801002932.26430-5-vishal.l.verma@intel.com>
In-Reply-To: <20190801002932.26430-5-vishal.l.verma@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <8F3CBFC134588347B337D919F31A1B21@intel.com>
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
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 2019-07-31 at 18:29 -0600, Vishal Verma wrote:
> Introduce a new 'daxctl_memory' object, which will be used for
> operations related to managing dax devices in 'system-memory' modes.
> 
> Add libdaxctl APIs to get the target_node of a DAX device, and to
> online, offline, and query the state of hotplugged memory sections
> associated with a given device.
> 
> This adds the following new interfaces:
> 
>   daxctl_dev_get_target_node
>   daxctl_dev_get_memory
>   daxctl_memory_get_dev
>   daxctl_memory_get_node_path
>   daxctl_memory_get_block_size
>   daxctl_memory_online
>   daxctl_memory_offline
>   daxctl_memory_is_online
>   daxctl_memory_num_sections
> 
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> [for the memblock-already-online TOCTOU hole]
> Reported-by: Fan Du <fan.du@intel.com>
> Tested-by: Fan Du <fan.du@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  daxctl/lib/libdaxctl-private.h |  18 ++
>  daxctl/lib/libdaxctl.c         | 384
+++++++++++++++++++++++++++++++++
>  daxctl/lib/libdaxctl.sym       |   9 +
>  daxctl/libdaxctl.h             |  11 +
>  4 files changed, 422 insertions(+)
> 
[..]
> +
> +static bool memblock_in_dev(struct daxctl_dev *dev, const char
*memblock)
> +{
> +	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
> 
Static analysis complains that this can potentially cause a NULL
dereference. Fix it by passing the mem object to memblock_in_dev(),
since it has already been validated by that time.

3<----


From e8bf803e359b784259f645d1ff68e964b2c8618f Mon Sep 17 00:00:00 2001
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Fri, 3 May 2019 13:27:35 -0600
Subject: [ndctl PATCH] libdaxctl: add a 'daxctl_memory' object for
memory
 based operations

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
 daxctl/lib/libdaxctl.c         | 384 +++++++++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym       |   9 +
 daxctl/libdaxctl.h             |  11 +
 4 files changed, 422 insertions(+)

diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-
private.h
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
index aa0d2f2..bcc77b6 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -200,6 +200,15 @@ DAXCTL_EXPORT void daxctl_region_get_uuid(struct
daxctl_region *region, uuid_t u
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
@@ -207,6 +216,7 @@ static void free_dev(struct daxctl_dev *dev, struct
list_head *head)
 	kmod_module_unref_list(dev->kmod_list);
 	free(dev->dev_buf);
 	free(dev->dev_path);
+	free_mem(dev);
 	free(dev);
 }
 
@@ -380,6 +390,94 @@ static struct kmod_list *to_module_list(struct
daxctl_ctx *ctx,
 	return list;
 }
 
+static int dev_is_system_ram_capable(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char *mod_path, *mod_base;
+	char path[200];
+	const int len = sizeof(path);
+
+	if (!device_model_is_dax_bus(dev))
+		return false;
+
+	if (!daxctl_dev_is_enabled(dev))
+		return false;
+
+	if (snprintf(path, len, "%s/driver/module", dev->dev_path) >=
len) {
+		err(ctx, "%s: buffer too small!\n", devname);
+		return false;
+	}
+
+	mod_path = realpath(path, NULL);
+	if (!mod_path)
+		return false;
+
+	mod_base = basename(mod_path);
+	if (strcmp(mod_base, dax_modules[DAXCTL_DEV_MODE_RAM]) == 0) {
+		free(mod_path);
+		return true;
+	}
+
+	free(mod_path);
+	return false;
+}
+
+/*
+ * This checks for the device to be in system-ram mode, so calling
+ * daxctl_dev_get_memory() on a devdax mode device will always return
NULL.
+ */
+static struct daxctl_memory *daxctl_dev_alloc_mem(struct daxctl_dev
*dev)
+{
+	const char *size_path =
"/sys/devices/system/memory/block_size_bytes";
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
+		if (mem->block_size == 0 || mem->block_size ==
ULONG_MAX) {
+			err(ctx, "%s: Unable to determine memblock size:
%s\n",
+				devname, strerror(errno));
+			mem->block_size = 0;
+		}
+	}
+
+	node_num = daxctl_dev_get_target_node(dev);
+	if (node_num >= 0) {
+		if (asprintf(&mem->node_path, "%s%d", node_base,
+				node_num) < 0) {
+			err(ctx, "%s: Unable to set node_path\n",
devname);
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
@@ -435,6 +533,12 @@ static void *add_dax_dev(void *parent, int id,
const char *daxdev_base)
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
@@ -862,6 +966,9 @@ DAXCTL_EXPORT int daxctl_dev_disable(struct
daxctl_dev *dev)
 	if (!daxctl_dev_is_enabled(dev))
 		return 0;
 
+	/* If there is a memory object, first free that */
+	free_mem(dev);
+
 	daxctl_unbind(ctx, dev->dev_path);
 
 	if (daxctl_dev_is_enabled(dev)) {
@@ -944,3 +1051,280 @@ DAXCTL_EXPORT unsigned long long
daxctl_dev_get_size(struct daxctl_dev *dev)
 {
 	return dev->size;
 }
+
+DAXCTL_EXPORT int daxctl_dev_get_target_node(struct daxctl_dev *dev)
+{
+	return dev->target_node;
+}
+
+DAXCTL_EXPORT struct daxctl_memory *daxctl_dev_get_memory(struct
daxctl_dev *dev)
+{
+	if (dev->mem)
+		return dev->mem;
+	else
+		return daxctl_dev_alloc_mem(dev);
+}
+
+DAXCTL_EXPORT struct daxctl_dev *daxctl_memory_get_dev(struct
daxctl_memory *mem)
+{
+	return mem->dev;
+}
+
+DAXCTL_EXPORT const char *daxctl_memory_get_node_path(struct
daxctl_memory *mem)
+{
+	return mem->node_path;
+}
+
+DAXCTL_EXPORT unsigned long daxctl_memory_get_block_size(struct
daxctl_memory *mem)
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
+	 * if already online, possibly due to kernel config or a udev
rule,
+	 * there is nothing to do and we can skip over the memblock
+	 */
+	if (strncmp(buf, "online", 6) == 0)
+		return 1;
+
+	rc = sysfs_write_attr_quiet(ctx, path, mode);
+	if (rc) {
+		/*
+		 * While we performed an already-online check above,
there
+		 * is still a TOCTOU hole where someone (such as a udev
rule)
+		 * may have raced to online the memory. In such a case,
+		 * the sysfs store will fail, however we can check for
this
+		 * by simply reading the state again. If it changed to
the
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
+		/* Close the TOCTOU hole like in online_one_memblock()
above */
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
+static bool memblock_in_dev(struct daxctl_memory *mem, const char
*memblock)
+{
+	const char *mem_base = "/sys/devices/system/memory/";
+	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
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
+			err(ctx, "%s: %s: Unable to determine
phys_index: %s\n",
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
+		 * Retain the 'normal' semantics for if
(memblock_is_online()),
+		 * but since count needs rc == 0, we'll just flip rc for
this op
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
+static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op
op)
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
+			if (!memblock_in_dev(mem, de->d_name))
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
