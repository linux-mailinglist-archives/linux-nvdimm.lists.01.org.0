Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1682846E0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Oct 2020 09:13:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C8601557A1B4;
	Tue,  6 Oct 2020 00:13:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 096D51557A1B4
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 00:13:44 -0700 (PDT)
IronPort-SDR: 7R0kyzJjOOxC17DYBntw28C/TVdpv9eci9r6VUNNCY0PZB1flhTNWuQ02PxxnUUuOeblKIQZk1
 yFvfY4FDJ/Vw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="151325738"
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400";
   d="scan'208";a="151325738"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:43 -0700
IronPort-SDR: /H7parRTWdQ6xT6vqX0KtJfS4ccLT3Lsj+wtA9ZIq334B4nO2TKY1CUcYK95BRmWTzPTsXMy0+
 rdc5jK1YqjcA==
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400";
   d="scan'208";a="517006390"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:42 -0700
Subject: [PATCH v6 05/11] device-dax: introduce 'struct dev_dax'
 typed-driver operations
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Mon, 05 Oct 2020 23:55:12 -0700
Message-ID: <160196731254.2166475.15779124872548332662.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: RNIQ5XXYWLLIKWKXZU6MDSOFEGBZLA3B
X-Message-ID-Hash: RNIQ5XXYWLLIKWKXZU6MDSOFEGBZLA3B
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jason Yan <yanaijie@huawei.com>, Brice Goglin <Brice.Goglin@inria.fr>, Dave Hansen <dave.hansen@linux.intel.com>, david@redhat.com, Jia He <justin.he@arm.com>, joao.m.martins@oracle.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Hulk Robot <hulkci@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RNIQ5XXYWLLIKWKXZU6MDSOFEGBZLA3B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for introducing seed devices the dax-bus core needs to be
able to intercept ->probe() and ->remove() operations. Towards that end
arrange for the bus and drivers to switch from raw 'struct device'
driver operations to 'struct dev_dax' typed operations.

Cc: Jason Yan <yanaijie@huawei.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jia He <justin.he@arm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |   18 ++++++++++++++++++
 drivers/dax/bus.h         |    4 +++-
 drivers/dax/device.c      |   12 +++++-------
 drivers/dax/kmem.c        |   18 ++++++++----------
 drivers/dax/pmem/compat.c |    2 +-
 5 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 0a48ce378686..9549f11ebed0 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -135,10 +135,28 @@ static bool is_static(struct dax_region *dax_region)
 	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
 }
 
+static int dax_bus_probe(struct device *dev)
+{
+	struct dax_device_driver *dax_drv = to_dax_drv(dev->driver);
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return dax_drv->probe(dev_dax);
+}
+
+static int dax_bus_remove(struct device *dev)
+{
+	struct dax_device_driver *dax_drv = to_dax_drv(dev->driver);
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return dax_drv->remove(dev_dax);
+}
+
 static struct bus_type dax_bus_type = {
 	.name = "dax",
 	.uevent = dax_bus_uevent,
 	.match = dax_bus_match,
+	.probe = dax_bus_probe,
+	.remove = dax_bus_remove,
 	.drv_groups = dax_drv_groups,
 };
 
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 44592a8cac0f..da27ea70a19a 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -38,6 +38,8 @@ struct dax_device_driver {
 	struct device_driver drv;
 	struct list_head ids;
 	int match_always;
+	int (*probe)(struct dev_dax *dev);
+	int (*remove)(struct dev_dax *dev);
 };
 
 int __dax_driver_register(struct dax_device_driver *dax_drv,
@@ -48,7 +50,7 @@ void dax_driver_unregister(struct dax_device_driver *dax_drv);
 void kill_dev_dax(struct dev_dax *dev_dax);
 
 #if IS_ENABLED(CONFIG_DEV_DAX_PMEM_COMPAT)
-int dev_dax_probe(struct device *dev);
+int dev_dax_probe(struct dev_dax *dev_dax);
 #endif
 
 /*
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 287cf0a3db23..9833fa83b537 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -392,11 +392,11 @@ static void dev_dax_kill(void *dev_dax)
 	kill_dev_dax(dev_dax);
 }
 
-int dev_dax_probe(struct device *dev)
+int dev_dax_probe(struct dev_dax *dev_dax)
 {
-	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct dax_device *dax_dev = dev_dax->dax_dev;
 	struct range *range = &dev_dax->range;
+	struct device *dev = &dev_dax->dev;
 	struct dev_pagemap *pgmap;
 	struct inode *inode;
 	struct cdev *cdev;
@@ -446,17 +446,15 @@ int dev_dax_probe(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_dax_probe);
 
-static int dev_dax_remove(struct device *dev)
+static int dev_dax_remove(struct dev_dax *dev_dax)
 {
 	/* all probe actions are unwound by devm */
 	return 0;
 }
 
 static struct dax_device_driver device_dax_driver = {
-	.drv = {
-		.probe = dev_dax_probe,
-		.remove = dev_dax_remove,
-	},
+	.probe = dev_dax_probe,
+	.remove = dev_dax_remove,
 	.match_always = 1,
 };
 
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a415bc239db4..5fb27fd3eb61 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -34,10 +34,10 @@ struct dax_kmem_data {
 	struct resource *res;
 };
 
-int dev_dax_kmem_probe(struct device *dev)
+static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
-	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct range range = dax_kmem_range(dev_dax);
+	struct device *dev = &dev_dax->dev;
 	struct dax_kmem_data *data;
 	struct resource *new_res;
 	int rc = -ENOMEM;
@@ -105,12 +105,12 @@ int dev_dax_kmem_probe(struct device *dev)
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-static int dev_dax_kmem_remove(struct device *dev)
+static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
-	struct dev_dax *dev_dax = to_dev_dax(dev);
+	int rc;
+	struct device *dev = &dev_dax->dev;
 	struct range range = dax_kmem_range(dev_dax);
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
-	int rc;
 
 	/*
 	 * We have one shot for removing memory, if some memory blocks were not
@@ -135,7 +135,7 @@ static int dev_dax_kmem_remove(struct device *dev)
 	return 0;
 }
 #else
-static int dev_dax_kmem_remove(struct device *dev)
+static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
 	/*
 	 * Without hotremove purposely leak the request_mem_region() for the
@@ -150,10 +150,8 @@ static int dev_dax_kmem_remove(struct device *dev)
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 static struct dax_device_driver device_dax_kmem_driver = {
-	.drv = {
-		.probe = dev_dax_kmem_probe,
-		.remove = dev_dax_kmem_remove,
-	},
+	.probe = dev_dax_kmem_probe,
+	.remove = dev_dax_kmem_remove,
 };
 
 static int __init dax_kmem_init(void)
diff --git a/drivers/dax/pmem/compat.c b/drivers/dax/pmem/compat.c
index d7b15e6f30c5..863c114fd88c 100644
--- a/drivers/dax/pmem/compat.c
+++ b/drivers/dax/pmem/compat.c
@@ -22,7 +22,7 @@ static int dax_pmem_compat_probe(struct device *dev)
 		return -ENOMEM;
 
 	device_lock(&dev_dax->dev);
-	rc = dev_dax_probe(&dev_dax->dev);
+	rc = dev_dax_probe(dev_dax);
 	device_unlock(&dev_dax->dev);
 
 	devres_close_group(&dev_dax->dev, dev_dax);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
