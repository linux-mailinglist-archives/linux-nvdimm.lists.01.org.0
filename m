Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348DA31D465
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 05:10:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1DDA4100EAB61;
	Tue, 16 Feb 2021 20:10:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EDA8E100EAB5D
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 20:10:09 -0800 (PST)
IronPort-SDR: pRFYphv4AFQl4t8JaTOBCC9tFLOyarLDm6tJE6daHRF9WZB6i8cyUQL7Z3XSfHDmNXUNcrueTW
 ULCsCDuuM4Vw==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="170229435"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400";
   d="scan'208";a="170229435"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 20:10:09 -0800
IronPort-SDR: wSqbwkWvxDVRMl49WJivd2eZnucLiI6BpQjEZVZu7ZdmOpQYftOL8T8CC4x/5WMvqhUYcXtc/W
 xebSO0kqKvDQ==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400";
   d="scan'208";a="384948820"
Received: from yxie-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.141])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 20:10:07 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v5 3/9] cxl/mem: Register CXL memX devices
Date: Tue, 16 Feb 2021 20:09:52 -0800
Message-Id: <20210217040958.1354670-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210217040958.1354670-1-ben.widawsky@intel.com>
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 54X6P2KTILDHL2LYGLIGS77OGOEB7Z7U
X-Message-ID-Hash: 54X6P2KTILDHL2LYGLIGS77OGOEB7Z7U
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/54X6P2KTILDHL2LYGLIGS77OGOEB7Z7U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Dan Williams <dan.j.williams@intel.com>

Create the /sys/bus/cxl hierarchy to enumerate:

* Memory Devices (per-endpoint control devices)

* Memory Address Space Devices (platform address ranges with
  interleaving, performance, and persistence attributes)

* Memory Regions (active provisioned memory from an address space device
  that is in use as System RAM or delegated to libnvdimm as Persistent
  Memory regions).

For now, only the per-endpoint control devices are registered on the
'cxl' bus. However, going forward it will provide a mechanism to
coordinate cross-device interleave.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> (v2)
---
 Documentation/ABI/testing/sysfs-bus-cxl       |  26 ++
 .../driver-api/cxl/memory-devices.rst         |   5 +
 drivers/cxl/Makefile                          |   3 +
 drivers/cxl/bus.c                             |  29 ++
 drivers/cxl/cxl.h                             |   3 +
 drivers/cxl/mem.c                             | 285 +++++++++++++++++-
 6 files changed, 349 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-cxl
 create mode 100644 drivers/cxl/bus.c

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
new file mode 100644
index 000000000000..2fe7490ad6a8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -0,0 +1,26 @@
+What:		/sys/bus/cxl/devices/memX/firmware_version
+Date:		December, 2020
+KernelVersion:	v5.12
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) "FW Revision" string as reported by the Identify
+		Memory Device Output Payload in the CXL-2.0
+		specification.
+
+What:		/sys/bus/cxl/devices/memX/ram/size
+Date:		December, 2020
+KernelVersion:	v5.12
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) "Volatile Only Capacity" as bytes. Represents the
+		identically named field in the Identify Memory Device Output
+		Payload in the CXL-2.0 specification.
+
+What:		/sys/bus/cxl/devices/memX/pmem/size
+Date:		December, 2020
+KernelVersion:	v5.12
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) "Persistent Only Capacity" as bytes. Represents the
+		identically named field in the Identify Memory Device Output
+		Payload in the CXL-2.0 specification.
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 43177e700d62..1fef2c0a167d 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -27,3 +27,8 @@ CXL Memory Device
 
 .. kernel-doc:: drivers/cxl/mem.c
    :internal:
+
+CXL Bus
+-------
+.. kernel-doc:: drivers/cxl/bus.c
+   :doc: cxl bus
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 4a30f7c3fc4a..a314a1891f4d 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CXL_BUS) += cxl_bus.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
+cxl_bus-y := bus.o
 cxl_mem-y := mem.o
diff --git a/drivers/cxl/bus.c b/drivers/cxl/bus.c
new file mode 100644
index 000000000000..58f74796d525
--- /dev/null
+++ b/drivers/cxl/bus.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+
+/**
+ * DOC: cxl bus
+ *
+ * The CXL bus provides namespace for control devices and a rendezvous
+ * point for cross-device interleave coordination.
+ */
+struct bus_type cxl_bus_type = {
+	.name = "cxl",
+};
+EXPORT_SYMBOL_GPL(cxl_bus_type);
+
+static __init int cxl_bus_init(void)
+{
+	return bus_register(&cxl_bus_type);
+}
+
+static void cxl_bus_exit(void)
+{
+	bus_unregister(&cxl_bus_type);
+}
+
+module_init(cxl_bus_init);
+module_exit(cxl_bus_exit);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index baac26d9e63b..8fd4a177fe25 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -57,6 +57,7 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
+struct cxl_memdev;
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
@@ -74,6 +75,7 @@
 struct cxl_mem {
 	struct pci_dev *pdev;
 	void __iomem *regs;
+	struct cxl_memdev *cxlmd;
 
 	void __iomem *status_regs;
 	void __iomem *mbox_regs;
@@ -87,4 +89,5 @@ struct cxl_mem {
 	struct range ram_range;
 };
 
+extern struct bus_type cxl_bus_type;
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 04e15759bc9b..1c0195b07063 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/cdev.h>
+#include <linux/idr.h>
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
@@ -23,6 +26,12 @@
  *  - Handle and manage error conditions.
  */
 
+/*
+ * An entire PCI topology full of devices should be enough for any
+ * config
+ */
+#define CXL_MEM_MAX_DEVS 65536
+
 #define cxl_doorbell_busy(cxlm)                                                \
 	(readl((cxlm)->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET) &                  \
 	 CXLDEV_MBOX_CTRL_DOORBELL)
@@ -65,6 +74,27 @@ struct mbox_cmd {
 #define CXL_MBOX_SUCCESS 0
 };
 
+/**
+ * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
+ * @dev: driver core device object
+ * @cdev: char dev core object for ioctl operations
+ * @cxlm: pointer to the parent device driver data
+ * @ops_active: active user of @cxlm in ops handlers
+ * @ops_dead: completion when all @cxlm ops users have exited
+ * @id: id number of this memdev instance.
+ */
+struct cxl_memdev {
+	struct device dev;
+	struct cdev cdev;
+	struct cxl_mem *cxlm;
+	struct percpu_ref ops_active;
+	struct completion ops_dead;
+	int id;
+};
+
+static int cxl_mem_major;
+static DEFINE_IDA(cxl_memdev_ida);
+
 static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
 {
 	const unsigned long start = jiffies;
@@ -294,6 +324,33 @@ static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
 	mutex_unlock(&cxlm->mbox_mutex);
 }
 
+static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct cxl_memdev *cxlmd;
+	struct inode *inode;
+	int rc = -ENOTTY;
+
+	inode = file_inode(file);
+	cxlmd = container_of(inode->i_cdev, typeof(*cxlmd), cdev);
+
+	if (!percpu_ref_tryget_live(&cxlmd->ops_active))
+		return -ENXIO;
+
+	/* TODO: ioctl body */
+
+	percpu_ref_put(&cxlmd->ops_active);
+
+	return rc;
+}
+
+static const struct file_operations cxl_memdev_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = cxl_memdev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.llseek = noop_llseek,
+};
+
 /**
  * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
  * @cxlm: The CXL memory device to communicate with.
@@ -512,6 +569,197 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
+static struct cxl_memdev *to_cxl_memdev(struct device *dev)
+{
+	return container_of(dev, struct cxl_memdev, dev);
+}
+
+static void cxl_memdev_release(struct device *dev)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
+	percpu_ref_exit(&cxlmd->ops_active);
+	ida_free(&cxl_memdev_ida, cxlmd->id);
+	kfree(cxlmd);
+}
+
+static char *cxl_memdev_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
+				kgid_t *gid)
+{
+	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
+}
+
+static ssize_t firmware_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	return sprintf(buf, "%.16s\n", cxlm->firmware_version);
+}
+static DEVICE_ATTR_RO(firmware_version);
+
+static ssize_t payload_max_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	return sprintf(buf, "%zu\n", cxlm->payload_size);
+}
+static DEVICE_ATTR_RO(payload_max);
+
+static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	unsigned long long len = range_len(&cxlm->ram_range);
+
+	return sprintf(buf, "%#llx\n", len);
+}
+
+static struct device_attribute dev_attr_ram_size =
+	__ATTR(size, 0444, ram_size_show, NULL);
+
+static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	unsigned long long len = range_len(&cxlm->pmem_range);
+
+	return sprintf(buf, "%#llx\n", len);
+}
+
+static struct device_attribute dev_attr_pmem_size =
+	__ATTR(size, 0444, pmem_size_show, NULL);
+
+static struct attribute *cxl_memdev_attributes[] = {
+	&dev_attr_firmware_version.attr,
+	&dev_attr_payload_max.attr,
+	NULL,
+};
+
+static struct attribute *cxl_memdev_pmem_attributes[] = {
+	&dev_attr_pmem_size.attr,
+	NULL,
+};
+
+static struct attribute *cxl_memdev_ram_attributes[] = {
+	&dev_attr_ram_size.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_memdev_attribute_group = {
+	.attrs = cxl_memdev_attributes,
+};
+
+static struct attribute_group cxl_memdev_ram_attribute_group = {
+	.name = "ram",
+	.attrs = cxl_memdev_ram_attributes,
+};
+
+static struct attribute_group cxl_memdev_pmem_attribute_group = {
+	.name = "pmem",
+	.attrs = cxl_memdev_pmem_attributes,
+};
+
+static const struct attribute_group *cxl_memdev_attribute_groups[] = {
+	&cxl_memdev_attribute_group,
+	&cxl_memdev_ram_attribute_group,
+	&cxl_memdev_pmem_attribute_group,
+	NULL,
+};
+
+static const struct device_type cxl_memdev_type = {
+	.name = "cxl_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+	.groups = cxl_memdev_attribute_groups,
+};
+
+static void cxlmdev_unregister(void *_cxlmd)
+{
+	struct cxl_memdev *cxlmd = _cxlmd;
+	struct device *dev = &cxlmd->dev;
+
+	percpu_ref_kill(&cxlmd->ops_active);
+	cdev_device_del(&cxlmd->cdev, dev);
+	wait_for_completion(&cxlmd->ops_dead);
+	cxlmd->cxlm = NULL;
+	put_device(dev);
+}
+
+static void cxlmdev_ops_active_release(struct percpu_ref *ref)
+{
+	struct cxl_memdev *cxlmd =
+		container_of(ref, typeof(*cxlmd), ops_active);
+
+	complete(&cxlmd->ops_dead);
+}
+
+static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
+{
+	struct pci_dev *pdev = cxlm->pdev;
+	struct cxl_memdev *cxlmd;
+	struct device *dev;
+	struct cdev *cdev;
+	int rc;
+
+	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
+	if (!cxlmd)
+		return -ENOMEM;
+	init_completion(&cxlmd->ops_dead);
+
+	/*
+	 * @cxlm is deallocated when the driver unbinds so operations
+	 * that are using it need to hold a live reference.
+	 */
+	cxlmd->cxlm = cxlm;
+	rc = percpu_ref_init(&cxlmd->ops_active, cxlmdev_ops_active_release, 0,
+			     GFP_KERNEL);
+	if (rc)
+		goto err_ref;
+
+	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
+	if (rc < 0)
+		goto err_id;
+	cxlmd->id = rc;
+
+	dev = &cxlmd->dev;
+	device_initialize(dev);
+	dev->parent = &pdev->dev;
+	dev->bus = &cxl_bus_type;
+	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
+	dev->type = &cxl_memdev_type;
+	dev_set_name(dev, "mem%d", cxlmd->id);
+
+	cdev = &cxlmd->cdev;
+	cdev_init(cdev, &cxl_memdev_fops);
+
+	rc = cdev_device_add(cdev, dev);
+	if (rc)
+		goto err_add;
+
+	return devm_add_action_or_reset(dev->parent, cxlmdev_unregister, cxlmd);
+
+err_add:
+	ida_free(&cxl_memdev_ida, cxlmd->id);
+err_id:
+	/*
+	 * Theoretically userspace could have already entered the fops,
+	 * so flush ops_active.
+	 */
+	percpu_ref_kill(&cxlmd->ops_active);
+	wait_for_completion(&cxlmd->ops_dead);
+	percpu_ref_exit(&cxlmd->ops_active);
+err_ref:
+	kfree(cxlmd);
+
+	return rc;
+}
+
 /**
  * cxl_mem_identify() - Send the IDENTIFY command to the device.
  * @cxlm: The device to identify.
@@ -612,7 +860,11 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	return cxl_mem_identify(cxlm);
+	rc = cxl_mem_identify(cxlm);
+	if (rc)
+		return rc;
+
+	return cxl_mem_add_memdev(cxlm);
 }
 
 static const struct pci_device_id cxl_mem_pci_tbl[] = {
@@ -631,5 +883,34 @@ static struct pci_driver cxl_mem_driver = {
 	},
 };
 
+static __init int cxl_mem_init(void)
+{
+	dev_t devt;
+	int rc;
+
+	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
+	if (rc)
+		return rc;
+
+	cxl_mem_major = MAJOR(devt);
+
+	rc = pci_register_driver(&cxl_mem_driver);
+	if (rc) {
+		unregister_chrdev_region(MKDEV(cxl_mem_major, 0),
+					 CXL_MEM_MAX_DEVS);
+		return rc;
+	}
+
+	return 0;
+}
+
+static __exit void cxl_mem_exit(void)
+{
+	pci_unregister_driver(&cxl_mem_driver);
+	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
+}
+
 MODULE_LICENSE("GPL v2");
-module_pci_driver(cxl_mem_driver);
+module_init(cxl_mem_init);
+module_exit(cxl_mem_exit);
+MODULE_IMPORT_NS(CXL);
-- 
2.30.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
