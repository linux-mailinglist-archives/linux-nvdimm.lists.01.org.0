Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9BB2DECBF
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Dec 2020 03:41:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A672A100EF250;
	Fri, 18 Dec 2020 18:41:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 41FD8100EF24A
	for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 18:41:43 -0800 (PST)
IronPort-SDR: F/KvKDyqzRXJuAydgLcMK9rUgpwlYtAenvZakQJmbc+Bcg9UuRH3LP3wwZUNx2pOjt7WqjyT4g
 sbUhLevgCpEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="237112119"
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400";
   d="scan'208";a="237112119"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 18:41:41 -0800
IronPort-SDR: xSypGU4gHQhJKVtakX7aPx3JKV96LD61HJWIGRBGqB3Z/QGdE0teiNUwXWM92tRKiSmGHIVEX1
 aKY+2wUL9+lw==
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400";
   d="scan'208";a="414450765"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 18:41:41 -0800
Subject: [PATCH] device-dax: Fix range release
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Fri, 18 Dec 2020 18:41:41 -0800
Message-ID: <160834570161.1791850.14911670304441510419.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: CZ2YR7ZEK6DGHUQAJIZCIGT4UCUB6KI4
X-Message-ID-Hash: CZ2YR7ZEK6DGHUQAJIZCIGT4UCUB6KI4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Zhen Lei <thunder.leizhen@huawei.com>, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CZ2YR7ZEK6DGHUQAJIZCIGT4UCUB6KI4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are multiple locations that open-code the release of the last
range in a device-dax instance. Consolidate this into a new
dev_dax_trim_range() helper.

This also addresses a kmemleak report:

# cat /sys/kernel/debug/kmemleak
[..]
unreferenced object 0xffff976bd46f6240 (size 64):
   comm "ndctl", pid 23556, jiffies 4299514316 (age 5406.733s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 20 c3 37 00 00 00  .......... .7...
     ff ff ff 7f 38 00 00 00 00 00 00 00 00 00 00 00  ....8...........
   backtrace:
     [<00000000064003cf>] __kmalloc_track_caller+0x136/0x379
     [<00000000d85e3c52>] krealloc+0x67/0x92
     [<00000000d7d3ba8a>] __alloc_dev_dax_range+0x73/0x25c
     [<0000000027d58626>] devm_create_dev_dax+0x27d/0x416
     [<00000000434abd43>] __dax_pmem_probe+0x1c9/0x1000 [dax_pmem_core]
     [<0000000083726c1c>] dax_pmem_probe+0x10/0x1f [dax_pmem]
     [<00000000b5f2319c>] nvdimm_bus_probe+0x9d/0x340 [libnvdimm]
     [<00000000c055e544>] really_probe+0x230/0x48d
     [<000000006cabd38e>] driver_probe_device+0x122/0x13b
     [<0000000029c7b95a>] device_driver_attach+0x5b/0x60
     [<0000000053e5659b>] bind_store+0xb7/0xc3
     [<00000000d3bdaadc>] drv_attr_store+0x27/0x31
     [<00000000949069c5>] sysfs_kf_write+0x4a/0x57
     [<000000004a8b5adf>] kernfs_fop_write+0x150/0x1e5
     [<00000000bded60f0>] __vfs_write+0x1b/0x34
     [<00000000b92900f0>] vfs_write+0xd8/0x1d1

Reported-by: Jane Chu <jane.chu@oracle.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c |   44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 9761cb40d4bb..720cd140209f 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -367,19 +367,28 @@ void kill_dev_dax(struct dev_dax *dev_dax)
 }
 EXPORT_SYMBOL_GPL(kill_dev_dax);
 
-static void free_dev_dax_ranges(struct dev_dax *dev_dax)
+static void trim_dev_dax_range(struct dev_dax *dev_dax)
 {
+	int i = dev_dax->nr_range - 1;
+	struct range *range = &dev_dax->ranges[i].range;
 	struct dax_region *dax_region = dev_dax->region;
-	int i;
 
 	device_lock_assert(dax_region->dev);
-	for (i = 0; i < dev_dax->nr_range; i++) {
-		struct range *range = &dev_dax->ranges[i].range;
-
-		__release_region(&dax_region->res, range->start,
-				range_len(range));
+	dev_dbg(&dev_dax->dev, "delete range[%d]: %#llx:%#llx\n", i,
+		(unsigned long long)range->start,
+		(unsigned long long)range->end);
+
+	__release_region(&dax_region->res, range->start, range_len(range));
+	if (--dev_dax->nr_range == 0) {
+		kfree(dev_dax->ranges);
+		dev_dax->ranges = NULL;
 	}
-	dev_dax->nr_range = 0;
+}
+
+static void free_dev_dax_ranges(struct dev_dax *dev_dax)
+{
+	while (dev_dax->nr_range)
+		trim_dev_dax_range(dev_dax);
 }
 
 static void unregister_dev_dax(void *dev)
@@ -804,15 +813,10 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		return 0;
 
 	rc = devm_register_dax_mapping(dev_dax, dev_dax->nr_range - 1);
-	if (rc) {
-		dev_dbg(dev, "delete range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
-				&alloc->start, &alloc->end);
-		dev_dax->nr_range--;
-		__release_region(res, alloc->start, resource_size(alloc));
-		return rc;
-	}
+	if (rc)
+		trim_dev_dax_range(dev_dax);
 
-	return 0;
+	return rc;
 }
 
 static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, resource_size_t size)
@@ -885,12 +889,7 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 		if (shrink >= range_len(range)) {
 			devm_release_action(dax_region->dev,
 					unregister_dax_mapping, &mapping->dev);
-			__release_region(&dax_region->res, range->start,
-					range_len(range));
-			dev_dax->nr_range--;
-			dev_dbg(dev, "delete range[%d]: %#llx:%#llx\n", i,
-					(unsigned long long) range->start,
-					(unsigned long long) range->end);
+			trim_dev_dax_range(dev_dax);
 			to_shrink -= shrink;
 			if (!to_shrink)
 				break;
@@ -1267,7 +1266,6 @@ static void dev_dax_release(struct device *dev)
 	put_dax(dax_dev);
 	free_dev_dax_id(dev_dax);
 	dax_region_put(dax_region);
-	kfree(dev_dax->ranges);
 	kfree(dev_dax->pgmap);
 	kfree(dev_dax);
 }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
