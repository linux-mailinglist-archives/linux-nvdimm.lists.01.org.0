Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D0C2FD9CD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 20:39:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 154DA100EB329;
	Wed, 20 Jan 2021 11:39:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5FF04100EB32A
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 11:38:58 -0800 (PST)
IronPort-SDR: wx8y1TmSGeWRGovRBwwOO2DMAFeW5SoNbmwXYXSw6fvEcl8MsXlpNu36FQqJQJKcbTK5MPTDn2
 7z+w1xpvSCRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="175660877"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400";
   d="scan'208";a="175660877"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:38:58 -0800
IronPort-SDR: +uoJ2VIo09iZb72TexbnDfu2FVByYUW1qnKjyOhh6a1jb/PrYRG6vka8QbHNykR6jt31JHdwdX
 TElEYPY8lW4w==
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400";
   d="scan'208";a="407000135"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:38:58 -0800
Subject: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Date: Wed, 20 Jan 2021 11:38:57 -0800
Message-ID: <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: GOJVB5PGOXML4OEDPSHSFMTVDXZJ2DLI
X-Message-ID-Hash: GOJVB5PGOXML4OEDPSHSFMTVDXZJ2DLI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: logang@deltatee.com, Hans Verkuil <hans.verkuil@cisco.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GOJVB5PGOXML4OEDPSHSFMTVDXZJ2DLI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The cdev api aims to preclude many common mistakes of driver developers
with ioctl interface lifetime and lookup. However, one common concern
that is left to driver implementers to handle manually is synchronizing
device shutdown with in-flight calls to file_operations handlers.

Starting with commit:

233ed09d7fda ("chardev: add helper function to register char devs with a struct device")

...common reference count handling scenarios were addressed, but the
shutdown-synchronization problem was only mentioned as something driver
developers need to be aware in the following note:

    NOTE: This guarantees that associated sysfs callbacks are not running
    or runnable, however any cdevs already open will remain and their fops
    will still be callable even after this function returns.

Remove that responsibility from driver developers with the concept of a
'queued' mode for cdevs.

Recall that every 'struct request_queue' in the kernel (one per 'struct
gendisk') has a percpu_ref counter to represent the queue usage count.
One of the useful properties of a percpu_ref, outside of low overhead
multi-CPU reference counting, is the ability to stop new references from
being taken while awaiting outstanding references to be dropped. Add a
percpu_ref to 'struct cdev' to allow cdev_del() to not only assert 'no
future opens', but also 'stop future ops invocations' and 'flush all in
progress ops'.

Similar to how a 'struct request_queue' is shared by all bdevs parented
by a 'gendisk' the new per-cdev percpu_ref is shared by all the
device-minors hosted by a given cdev instance.

The cdev->qactive counter is elevated before calling a driver provided
'struct cdev_operations' handler, and dropped when that handler returns.
With the cdev_queued_ops taking percpu_ref_tryget_live(), then once
cdev_del() has executed percpu_ref_kill() new invocations of driver
operation handlers are blocked, and once all references are dropped
cdev_del() returns.

The fact that driver provided operations are now wrapped by the cdev
core allows for some type-safety to be added to 'struct
cdev_operations'. In particular, it provides @cdev as an argument, and
adds type-safety to @arg. It currently enforces the common case where an
ioctl() takes a pointer as an argument rather than a value. Other ops
like mmap() can be added later.

Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/char_dev.c        |  108 +++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/cdev.h |   21 +++++++++-
 2 files changed, 122 insertions(+), 7 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index ba0ded7842a7..c7239fbea0ff 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -367,6 +367,45 @@ void cdev_put(struct cdev *p)
 	}
 }
 
+static long cdev_queued_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	struct cdev *cdev = inode->i_cdev;
+	long rc;
+
+	if (!percpu_ref_tryget_live(&cdev->qactive))
+		return -ENXIO;
+
+	rc = cdev->qops->ioctl(cdev, file, cmd, (void __user *) arg);
+
+	percpu_ref_put(&cdev->qactive);
+
+	return rc;
+}
+
+static int cdev_queued_open(struct inode *inode, struct file *file)
+{
+	struct cdev *cdev = inode->i_cdev;
+	int rc;
+
+	if (!percpu_ref_tryget_live(&cdev->qactive))
+		return -ENXIO;
+
+	rc = cdev->qops->open(cdev, file);
+
+	percpu_ref_put(&cdev->qactive);
+
+	return rc;
+}
+
+static const struct file_operations cdev_queued_fops = {
+	.owner = THIS_MODULE,
+	.open = cdev_queued_open,
+	.unlocked_ioctl = cdev_queued_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.llseek = noop_llseek,
+};
+
 /*
  * Called every time a character special file is opened
  */
@@ -405,7 +444,10 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 		return ret;
 
 	ret = -ENXIO;
-	fops = fops_get(p->ops);
+	if (p->qregistered)
+		fops = &cdev_queued_fops;
+	else
+		fops = fops_get(p->ops);
 	if (!fops)
 		goto out_cdev_put;
 
@@ -582,7 +624,7 @@ static void cdev_unmap(dev_t dev, unsigned count)
 
 /**
  * cdev_del() - remove a cdev from the system
- * @p: the cdev structure to be removed
+ * @cdev: the cdev structure to be removed
  *
  * cdev_del() removes @p from the system, possibly freeing the structure
  * itself.
@@ -590,14 +632,22 @@ static void cdev_unmap(dev_t dev, unsigned count)
  * NOTE: This guarantees that cdev device will no longer be able to be
  * opened, however any cdevs already open will remain and their fops will
  * still be callable even after cdev_del returns.
+ *
+ * That is unless the cdev was initialized in queued mode. In queued
+ * mode new invocations of the fops are blocked and in-flight calls to
+ * the fops are drained before this returns.
  */
-void cdev_del(struct cdev *p)
+void cdev_del(struct cdev *cdev)
 {
-	cdev_unmap(p->dev, p->count);
-	kobject_put(&p->kobj);
+	cdev_unmap(cdev->dev, cdev->count);
+	kobject_put(&cdev->kobj);
+	if (!cdev->qregistered)
+		return;
+	percpu_ref_kill(&cdev->qactive);
+	wait_for_completion(&cdev->qdead);
+	percpu_ref_exit(&cdev->qactive);
 }
 
-
 static void cdev_default_release(struct kobject *kobj)
 {
 	struct cdev *p = container_of(kobj, struct cdev, kobj);
@@ -656,6 +706,52 @@ void cdev_init(struct cdev *cdev, const struct file_operations *fops)
 	cdev->ops = fops;
 }
 
+static void cdev_queued_release(struct percpu_ref *ref)
+{
+	struct cdev *cdev = container_of(ref, struct cdev, qactive);
+
+	complete(&cdev->qdead);
+}
+
+/**
+ * cdev_register_queued() - register a cdev structure with queued ops
+ * @cdev: the structure to init and add
+ * @owner: host module for the device + ops
+ * @dev: the first device number for which this device is responsible
+ * @count: the number of consecutive minor numbers corresponding to this
+ *         device
+ * @ops: the cdev_operations for this device
+ *
+ * In addition to base cdev_init() allocate and initialize a reference
+ * counter to track in-flight operations. With cdev_register_queued()
+ * cdev_del() guarantees no in-flight operations in addition to no new
+ * opens.
+ */
+__must_check int __cdev_register_queued(struct cdev *cdev, struct module *owner,
+					dev_t dev, unsigned count,
+					const struct cdev_operations *qops)
+{
+	int rc;
+
+	if (!qops->ioctl || !owner)
+		return -EINVAL;
+
+	cdev_init(cdev, NULL);
+	cdev->qops = qops;
+	cdev->owner = owner;
+	cdev->qregistered = true;
+	init_completion(&cdev->qdead);
+	rc = percpu_ref_init(&cdev->qactive, cdev_queued_release, 0, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	rc = cdev_add(cdev, dev, count);
+	if (rc)
+		percpu_ref_exit(&cdev->qactive);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(__cdev_register_queued);
+
 static struct kobject *base_probe(dev_t dev, int *part, void *data)
 {
 	if (request_module("char-major-%d-%d", MAJOR(dev), MINOR(dev)) > 0)
diff --git a/include/linux/cdev.h b/include/linux/cdev.h
index 0e8cd6293deb..5ef1bfb3b495 100644
--- a/include/linux/cdev.h
+++ b/include/linux/cdev.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_CDEV_H
 #define _LINUX_CDEV_H
 
+#include <linux/percpu-refcount.h>
 #include <linux/kobject.h>
 #include <linux/kdev_t.h>
 #include <linux/list.h>
@@ -10,17 +11,35 @@
 struct file_operations;
 struct inode;
 struct module;
+struct cdev;
+
+struct cdev_operations {
+	int (*open)(struct cdev *cdev, struct file *);
+	long (*ioctl)(struct cdev *cdev, struct file *file, unsigned int cmd,
+		      void __user *arg);
+};
 
 struct cdev {
 	struct kobject kobj;
 	struct module *owner;
-	const struct file_operations *ops;
+	union {
+		const struct file_operations *ops;
+		const struct cdev_operations *qops;
+	};
 	struct list_head list;
 	dev_t dev;
 	unsigned int count;
+	struct percpu_ref qactive;
+	struct completion qdead;
+	bool qregistered;
 } __randomize_layout;
 
 void cdev_init(struct cdev *, const struct file_operations *);
+#define cdev_register_queued(cdev, dev, count, ops)                            \
+	__cdev_register_queued(cdev, THIS_MODULE, dev, count, ops)
+__must_check int __cdev_register_queued(struct cdev *cdev, struct module *owner,
+					dev_t dev, unsigned count,
+					const struct cdev_operations *qops);
 
 struct cdev *cdev_alloc(void);
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
