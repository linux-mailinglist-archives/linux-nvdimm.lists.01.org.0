Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF7241905
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 01:40:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB85721290D5C;
	Tue, 11 Jun 2019 16:40:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B081A2128A631
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 16:40:06 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jun 2019 16:40:06 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga003.jf.intel.com with ESMTP; 11 Jun 2019 16:40:05 -0700
Subject: [PATCH 1/6] drivers/base: Introduce kill_device()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Tue, 11 Jun 2019 16:25:49 -0700
Message-ID: <156029554901.419799.10072666658870843929.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156029554317.419799.1324389595953183385.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156029554317.419799.1324389595953183385.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, peterz@infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The libnvdimm subsystem arranges for devices to be destroyed as a result
of a sysfs operation. Since device_unregister() cannot be called from
an actively running sysfs attribute of the same device libnvdimm
arranges for device_unregister() to be performed in an out-of-line async
context.

The driver core maintains a 'dead' state for coordinating its own racing
async registration / de-registration requests. Rather than add local
'dead' state tracking infrastructure to libnvdimm device objects, export
the existing state tracking via a new kill_device() helper.

The kill_device() helper simply marks the device as dead, i.e. that it
is on its way to device_del(), or returns that the device was already
dead. This can be used in advance of calling device_unregister() for
subsystems like libnvdimm that might need to handle multiple user
threads racing to delete a device.

This refactoring does not change any behavior, but it is a pre-requisite
for follow-on fixes and therefore marked for -stable.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Fixes: 4d88a97aa9e8 ("libnvdimm, nvdimm: dimm driver and base libnvdimm device-driver...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c    |   27 +++++++++++++++++++--------
 include/linux/device.h |    1 +
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fd7511e04e62..eaf3aa0cb803 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2211,6 +2211,24 @@ void put_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(put_device);
 
+bool kill_device(struct device *dev)
+{
+	/*
+	 * Require the device lock and set the "dead" flag to guarantee that
+	 * the update behavior is consistent with the other bitfields near
+	 * it and that we cannot have an asynchronous probe routine trying
+	 * to run while we are tearing out the bus/class/sysfs from
+	 * underneath the device.
+	 */
+	lockdep_assert_held(&dev->mutex);
+
+	if (dev->p->dead)
+		return false;
+	dev->p->dead = true;
+	return true;
+}
+EXPORT_SYMBOL_GPL(kill_device);
+
 /**
  * device_del - delete device from system.
  * @dev: device.
@@ -2230,15 +2248,8 @@ void device_del(struct device *dev)
 	struct kobject *glue_dir = NULL;
 	struct class_interface *class_intf;
 
-	/*
-	 * Hold the device lock and set the "dead" flag to guarantee that
-	 * the update behavior is consistent with the other bitfields near
-	 * it and that we cannot have an asynchronous probe routine trying
-	 * to run while we are tearing out the bus/class/sysfs from
-	 * underneath the device.
-	 */
 	device_lock(dev);
-	dev->p->dead = true;
+	kill_device(dev);
 	device_unlock(dev);
 
 	/* Notify clients of device removal.  This call must come
diff --git a/include/linux/device.h b/include/linux/device.h
index e85264fb6616..0da5c67f6be1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1373,6 +1373,7 @@ extern int (*platform_notify_remove)(struct device *dev);
  */
 extern struct device *get_device(struct device *dev);
 extern void put_device(struct device *dev);
+extern bool kill_device(struct device *dev);
 
 #ifdef CONFIG_DEVTMPFS
 extern int devtmpfs_create_node(struct device *dev);

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
