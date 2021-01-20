Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772CD2FD9D0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 20:39:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43BB6100EB32A;
	Wed, 20 Jan 2021 11:39:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E11F5100EB329
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 11:39:09 -0800 (PST)
IronPort-SDR: 6/hGecAgZZw3ZMznvqj12gmLg9M+pxamz1m1PYAwGRyilTUIht1o5gcNo3va1kdMCtd/xmt/38
 NWo9BQjWn7aA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="176593579"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400";
   d="scan'208";a="176593579"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:39:09 -0800
IronPort-SDR: a0DiGYPLDjEjiP3p67EMENjYRth53/ziMzAcr9jdE9HLzntZ/AAXc9oZyWXooRRNcO2FGGwRno
 F9mdKZaG7NMg==
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400";
   d="scan'208";a="399875943"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:39:08 -0800
Subject: [PATCH 3/3] libnvdimm/ioctl: Switch to cdev_register_queued()
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Date: Wed, 20 Jan 2021 11:39:08 -0800
Message-ID: <161117154856.2853729.1012816981381380656.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: XOAEGB63DJM2XMX6VZZBCZC2DTSXPDH6
X-Message-ID-Hash: XOAEGB63DJM2XMX6VZZBCZC2DTSXPDH6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: logang@deltatee.com, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XOAEGB63DJM2XMX6VZZBCZC2DTSXPDH6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ioctl implementation in libnvdimm is a case study in what can be
cleaned up when the cdev core handles synchronizing in-flight ioctls
with device removal. Switch to cdev_register_queued() which allows for
the ugly context lookup and activity tracking implementation to be
dropped, among other cleanups.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/bus.c       |  175 +++++++++++---------------------------------
 drivers/nvdimm/core.c      |   14 ++--
 drivers/nvdimm/dimm_devs.c |   51 +++++++++++--
 drivers/nvdimm/nd-core.h   |   14 ++--
 4 files changed, 101 insertions(+), 153 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 0258ec90dce6..4c73abb3bc1d 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -24,8 +24,7 @@
 #include "nd.h"
 #include "pfn.h"
 
-int nvdimm_major;
-static int nvdimm_bus_major;
+static dev_t nvdimm_bus_dev_t;
 struct class *nd_class;
 static DEFINE_IDA(nd_ida);
 
@@ -348,10 +347,9 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	nvdimm_bus = kzalloc(sizeof(*nvdimm_bus), GFP_KERNEL);
 	if (!nvdimm_bus)
 		return NULL;
-	INIT_LIST_HEAD(&nvdimm_bus->list);
 	INIT_LIST_HEAD(&nvdimm_bus->mapping_list);
 	init_waitqueue_head(&nvdimm_bus->wait);
-	nvdimm_bus->id = ida_alloc(&nd_ida, GFP_KERNEL);
+	nvdimm_bus->id = ida_alloc_range(&nd_ida, 0, NVDIMM_MAX_BUS, GFP_KERNEL);
 	if (nvdimm_bus->id < 0) {
 		kfree(nvdimm_bus);
 		return NULL;
@@ -408,6 +406,7 @@ static int child_unregister(struct device *dev, void *data)
 			dev_put = true;
 		nvdimm_bus_unlock(dev);
 		cancel_delayed_work_sync(&nvdimm->dwork);
+		cdev_del(&nvdimm->cdev);
 		if (dev_put)
 			put_device(dev);
 	}
@@ -430,14 +429,9 @@ static void free_badrange_list(struct list_head *badrange_list)
 static int nd_bus_remove(struct device *dev)
 {
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct cdev *cdev = &nvdimm_bus->cdev;
 
-	mutex_lock(&nvdimm_bus_list_mutex);
-	list_del_init(&nvdimm_bus->list);
-	mutex_unlock(&nvdimm_bus_list_mutex);
-
-	wait_event(nvdimm_bus->wait,
-			atomic_read(&nvdimm_bus->ioctl_active) == 0);
-
+	cdev_del(cdev);
 	nd_synchronize();
 	device_for_each_child(&nvdimm_bus->dev, NULL, child_unregister);
 
@@ -459,10 +453,6 @@ static int nd_bus_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	mutex_lock(&nvdimm_bus_list_mutex);
-	list_add_tail(&nvdimm_bus->list, &nvdimm_bus_list);
-	mutex_unlock(&nvdimm_bus_list_mutex);
-
 	/* enable bus provider attributes to look up their local context */
 	dev_set_drvdata(dev, nvdimm_bus->nd_desc);
 
@@ -733,23 +723,50 @@ const struct attribute_group nd_numa_attribute_group = {
 	.is_visible = nd_numa_attr_visible,
 };
 
+static long bus_ioctl(struct cdev *cdev, struct file *file, unsigned int cmd,
+		      void __user *arg)
+{
+	int ro = ((file->f_flags & O_ACCMODE) == O_RDONLY);
+
+	return nd_ioctl(file->private_data, NULL, ro, cmd, arg);
+}
+
+static int ndctl_open(struct cdev *cdev, struct file *file)
+{
+	file->private_data = container_of(cdev, struct nvdimm_bus, cdev);
+	return 0;
+}
+
+static const struct cdev_operations nvdimm_bus_ops = {
+	.open = ndctl_open,
+	.ioctl = bus_ioctl,
+};
+
 int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus)
 {
-	dev_t devt = MKDEV(nvdimm_bus_major, nvdimm_bus->id);
+	dev_t devt = MKDEV(MAJOR(nvdimm_bus_dev_t), nvdimm_bus->id);
+	struct cdev *cdev = &nvdimm_bus->cdev;
 	struct device *dev;
+	int rc;
+
+	rc = cdev_register_queued(cdev, devt, 1, &nvdimm_bus_ops);
+	if (rc)
+		return rc;
 
 	dev = device_create(nd_class, &nvdimm_bus->dev, devt, nvdimm_bus,
 			"ndctl%d", nvdimm_bus->id);
 
-	if (IS_ERR(dev))
+	if (IS_ERR(dev)) {
+		cdev_del(cdev);
 		dev_dbg(&nvdimm_bus->dev, "failed to register ndctl%d: %ld\n",
 				nvdimm_bus->id, PTR_ERR(dev));
+	}
 	return PTR_ERR_OR_ZERO(dev);
 }
 
 void nvdimm_bus_destroy_ndctl(struct nvdimm_bus *nvdimm_bus)
 {
-	device_destroy(nd_class, MKDEV(nvdimm_bus_major, nvdimm_bus->id));
+	device_destroy(nd_class, MKDEV(MAJOR(nvdimm_bus_dev_t), nvdimm_bus->id));
 }
 
 static const struct nd_cmd_desc __nd_cmd_dimm_descs[] = {
@@ -1004,14 +1021,13 @@ static int nd_cmd_clear_to_send(struct nvdimm_bus *nvdimm_bus,
 	return 0;
 }
 
-static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
-		int read_only, unsigned int ioctl_cmd, unsigned long arg)
+int nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
+	     int read_only, unsigned int ioctl_cmd, void __user *p)
 {
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 	const struct nd_cmd_desc *desc = NULL;
 	unsigned int cmd = _IOC_NR(ioctl_cmd);
 	struct device *dev = &nvdimm_bus->dev;
-	void __user *p = (void __user *) arg;
 	char *out_env = NULL, *in_env = NULL;
 	const char *cmd_name, *dimm_name;
 	u32 in_len = 0, out_len = 0;
@@ -1188,104 +1204,6 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 	return rc;
 }
 
-enum nd_ioctl_mode {
-	BUS_IOCTL,
-	DIMM_IOCTL,
-};
-
-static int match_dimm(struct device *dev, void *data)
-{
-	long id = (long) data;
-
-	if (is_nvdimm(dev)) {
-		struct nvdimm *nvdimm = to_nvdimm(dev);
-
-		return nvdimm->id == id;
-	}
-
-	return 0;
-}
-
-static long nd_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
-		enum nd_ioctl_mode mode)
-
-{
-	struct nvdimm_bus *nvdimm_bus, *found = NULL;
-	long id = (long) file->private_data;
-	struct nvdimm *nvdimm = NULL;
-	int rc, ro;
-
-	ro = ((file->f_flags & O_ACCMODE) == O_RDONLY);
-	mutex_lock(&nvdimm_bus_list_mutex);
-	list_for_each_entry(nvdimm_bus, &nvdimm_bus_list, list) {
-		if (mode == DIMM_IOCTL) {
-			struct device *dev;
-
-			dev = device_find_child(&nvdimm_bus->dev,
-					file->private_data, match_dimm);
-			if (!dev)
-				continue;
-			nvdimm = to_nvdimm(dev);
-			found = nvdimm_bus;
-		} else if (nvdimm_bus->id == id) {
-			found = nvdimm_bus;
-		}
-
-		if (found) {
-			atomic_inc(&nvdimm_bus->ioctl_active);
-			break;
-		}
-	}
-	mutex_unlock(&nvdimm_bus_list_mutex);
-
-	if (!found)
-		return -ENXIO;
-
-	nvdimm_bus = found;
-	rc = __nd_ioctl(nvdimm_bus, nvdimm, ro, cmd, arg);
-
-	if (nvdimm)
-		put_device(&nvdimm->dev);
-	if (atomic_dec_and_test(&nvdimm_bus->ioctl_active))
-		wake_up(&nvdimm_bus->wait);
-
-	return rc;
-}
-
-static long bus_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	return nd_ioctl(file, cmd, arg, BUS_IOCTL);
-}
-
-static long dimm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	return nd_ioctl(file, cmd, arg, DIMM_IOCTL);
-}
-
-static int nd_open(struct inode *inode, struct file *file)
-{
-	long minor = iminor(inode);
-
-	file->private_data = (void *) minor;
-	return 0;
-}
-
-static const struct file_operations nvdimm_bus_fops = {
-	.owner = THIS_MODULE,
-	.open = nd_open,
-	.unlocked_ioctl = bus_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
-	.llseek = noop_llseek,
-};
-
-static const struct file_operations nvdimm_fops = {
-	.owner = THIS_MODULE,
-	.open = nd_open,
-	.unlocked_ioctl = dimm_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
-	.llseek = noop_llseek,
-};
-
 int __init nvdimm_bus_init(void)
 {
 	int rc;
@@ -1294,15 +1212,9 @@ int __init nvdimm_bus_init(void)
 	if (rc)
 		return rc;
 
-	rc = register_chrdev(0, "ndctl", &nvdimm_bus_fops);
-	if (rc < 0)
-		goto err_bus_chrdev;
-	nvdimm_bus_major = rc;
-
-	rc = register_chrdev(0, "dimmctl", &nvdimm_fops);
+	rc = alloc_chrdev_region(&nvdimm_bus_dev_t, 0, NVDIMM_MAX_BUS, "ndctl");
 	if (rc < 0)
-		goto err_dimm_chrdev;
-	nvdimm_major = rc;
+		goto err_chrdev;
 
 	nd_class = class_create(THIS_MODULE, "nd");
 	if (IS_ERR(nd_class)) {
@@ -1319,10 +1231,8 @@ int __init nvdimm_bus_init(void)
  err_nd_bus:
 	class_destroy(nd_class);
  err_class:
-	unregister_chrdev(nvdimm_major, "dimmctl");
- err_dimm_chrdev:
-	unregister_chrdev(nvdimm_bus_major, "ndctl");
- err_bus_chrdev:
+	unregister_chrdev_region(nvdimm_bus_dev_t, NVDIMM_MAX_BUS);
+ err_chrdev:
 	bus_unregister(&nvdimm_bus_type);
 
 	return rc;
@@ -1332,8 +1242,7 @@ void nvdimm_bus_exit(void)
 {
 	driver_unregister(&nd_bus_driver.drv);
 	class_destroy(nd_class);
-	unregister_chrdev(nvdimm_bus_major, "ndctl");
-	unregister_chrdev(nvdimm_major, "dimmctl");
+	unregister_chrdev_region(nvdimm_bus_dev_t, NVDIMM_MAX_BUS);
 	bus_unregister(&nvdimm_bus_type);
 	ida_destroy(&nd_ida);
 }
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 7de592d7eff4..017ae313a4bb 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -16,9 +16,6 @@
 #include "nd-core.h"
 #include "nd.h"
 
-LIST_HEAD(nvdimm_bus_list);
-DEFINE_MUTEX(nvdimm_bus_list_mutex);
-
 void nvdimm_bus_lock(struct device *dev)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
@@ -584,6 +581,9 @@ static __init int libnvdimm_init(void)
 	rc = nvdimm_bus_init();
 	if (rc)
 		return rc;
+	rc = nvdimm_devs_init();
+	if (rc)
+		goto err_dimm_devs;
 	rc = nvdimm_init();
 	if (rc)
 		goto err_dimm;
@@ -594,18 +594,20 @@ static __init int libnvdimm_init(void)
 	nd_label_init();
 
 	return 0;
- err_region:
+err_region:
 	nvdimm_exit();
- err_dimm:
+err_dimm:
+	nvdimm_devs_exit();
+err_dimm_devs:
 	nvdimm_bus_exit();
 	return rc;
 }
 
 static __exit void libnvdimm_exit(void)
 {
-	WARN_ON(!list_empty(&nvdimm_bus_list));
 	nd_region_exit();
 	nvdimm_exit();
+	nvdimm_devs_exit();
 	nvdimm_bus_exit();
 	nvdimm_devs_exit();
 }
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 3dec809ef20a..e2c3a58f712d 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -16,6 +16,7 @@
 #include "pmem.h"
 #include "nd.h"
 
+static dev_t nvdimm_dev_t;
 static DEFINE_IDA(dimm_ida);
 
 static bool noblk;
@@ -579,6 +580,26 @@ bool is_nvdimm(struct device *dev)
 	return dev->type == &nvdimm_device_type;
 }
 
+static long dimm_ioctl(struct cdev *cdev, struct file *file, unsigned int cmd,
+		       void __user *arg)
+{
+	struct nvdimm *nvdimm = file->private_data;
+	int ro = ((file->f_flags & O_ACCMODE) == O_RDONLY);
+
+	return nd_ioctl(nvdimm_to_bus(nvdimm), nvdimm, ro, cmd, arg);
+}
+
+static int nmem_open(struct cdev *cdev, struct file *file)
+{
+	file->private_data = container_of(cdev, struct nvdimm, cdev);
+	return 0;
+}
+
+static const struct cdev_operations nvdimm_ops = {
+	.open = nmem_open,
+	.ioctl = dimm_ioctl,
+};
+
 struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 		void *provider_data, const struct attribute_group **groups,
 		unsigned long flags, unsigned long cmd_mask, int num_flush,
@@ -587,16 +608,15 @@ struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 		const struct nvdimm_fw_ops *fw_ops)
 {
 	struct nvdimm *nvdimm = kzalloc(sizeof(*nvdimm), GFP_KERNEL);
-	struct device *dev;
+	struct cdev *cdev = &nvdimm->cdev;
+	struct device *dev = &nvdimm->dev;
 
 	if (!nvdimm)
 		return NULL;
 
-	nvdimm->id = ida_alloc(&dimm_ida, GFP_KERNEL);
-	if (nvdimm->id < 0) {
-		kfree(nvdimm);
-		return NULL;
-	}
+	nvdimm->id = ida_alloc_range(&dimm_ida, 0, NVDIMM_MAX_NVDIMM, GFP_KERNEL);
+	if (nvdimm->id < 0)
+		goto err_id;
 
 	nvdimm->dimm_id = dimm_id;
 	nvdimm->provider_data = provider_data;
@@ -607,16 +627,18 @@ struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 	nvdimm->num_flush = num_flush;
 	nvdimm->flush_wpq = flush_wpq;
 	atomic_set(&nvdimm->busy, 0);
-	dev = &nvdimm->dev;
 	dev_set_name(dev, "nmem%d", nvdimm->id);
 	dev->parent = &nvdimm_bus->dev;
 	dev->type = &nvdimm_device_type;
-	dev->devt = MKDEV(nvdimm_major, nvdimm->id);
+	dev->devt = MKDEV(MAJOR(nvdimm_dev_t), nvdimm->id);
 	dev->groups = groups;
 	nvdimm->sec.ops = sec_ops;
 	nvdimm->fw_ops = fw_ops;
 	nvdimm->sec.overwrite_tmo = 0;
 	INIT_DELAYED_WORK(&nvdimm->dwork, nvdimm_security_overwrite_query);
+	if (cdev_register_queued(cdev, dev->devt, 1, &nvdimm_ops) != 0)
+		goto err_cdev;
+
 	/*
 	 * Security state must be initialized before device_add() for
 	 * attribute visibility.
@@ -627,6 +649,11 @@ struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 	nd_device_register(dev);
 
 	return nvdimm;
+err_cdev:
+	ida_free(&dimm_ida, nvdimm->id);
+err_id:
+	kfree(nvdimm);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(__nvdimm_create);
 
@@ -1007,7 +1034,13 @@ int nvdimm_bus_check_dimm_count(struct nvdimm_bus *nvdimm_bus, int dimm_count)
 }
 EXPORT_SYMBOL_GPL(nvdimm_bus_check_dimm_count);
 
-void __exit nvdimm_devs_exit(void)
+int __init nvdimm_devs_init(void)
+{
+	return alloc_chrdev_region(&nvdimm_dev_t, 0, NVDIMM_MAX_NVDIMM, "nmem");
+}
+
+void nvdimm_devs_exit(void)
 {
 	ida_destroy(&dimm_ida);
+	unregister_chrdev_region(nvdimm_dev_t, NVDIMM_MAX_NVDIMM);
 }
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 564faa36a3ca..cf32e0cad7a3 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -8,30 +8,31 @@
 #include <linux/device.h>
 #include <linux/sizes.h>
 #include <linux/mutex.h>
+#include <linux/cdev.h>
 #include <linux/nd.h>
 #include "nd.h"
 
-extern struct list_head nvdimm_bus_list;
-extern struct mutex nvdimm_bus_list_mutex;
 extern int nvdimm_major;
 extern struct workqueue_struct *nvdimm_wq;
 
+#define NVDIMM_MAX_BUS 64
 struct nvdimm_bus {
 	struct nvdimm_bus_descriptor *nd_desc;
 	wait_queue_head_t wait;
-	struct list_head list;
+	struct cdev cdev;
 	struct device dev;
 	int id, probe_active;
-	atomic_t ioctl_active;
 	struct list_head mapping_list;
 	struct mutex reconfig_mutex;
 	struct badrange badrange;
 };
 
+#define NVDIMM_MAX_NVDIMM 256
 struct nvdimm {
 	unsigned long flags;
 	void *provider_data;
 	unsigned long cmd_mask;
+	struct cdev cdev;
 	struct device dev;
 	atomic_t busy;
 	int id, num_flush;
@@ -48,6 +49,9 @@ struct nvdimm {
 	const struct nvdimm_fw_ops *fw_ops;
 };
 
+int nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
+	     int read_only, unsigned int ioctl_cmd, void __user *p);
+
 static inline unsigned long nvdimm_security_flags(
 		struct nvdimm *nvdimm, enum nvdimm_passphrase_type ptype)
 {
@@ -98,7 +102,6 @@ struct blk_alloc_info {
 	resource_size_t available, busy;
 	struct resource *res;
 };
-
 bool is_nvdimm(struct device *dev);
 bool is_nd_pmem(struct device *dev);
 bool is_nd_volatile(struct device *dev);
@@ -114,6 +117,7 @@ static inline bool is_memory(struct device *dev)
 struct nvdimm_bus *walk_to_nvdimm_bus(struct device *nd_dev);
 int __init nvdimm_bus_init(void);
 void nvdimm_bus_exit(void);
+int __init nvdimm_devs_init(void);
 void nvdimm_devs_exit(void);
 struct nd_region;
 void nd_region_advance_seeds(struct nd_region *nd_region, struct device *dev);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
