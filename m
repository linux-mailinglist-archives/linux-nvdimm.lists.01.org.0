Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7A4B06F2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 04:55:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2256221962301;
	Wed, 11 Sep 2019 19:55:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.212;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0212.hostedemail.com
 [216.40.44.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A1D9D202C8096
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 19:55:22 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id AF13B181D33FC;
 Thu, 12 Sep 2019 02:55:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:1:2:41:355:371:372:379:541:800:960:966:968:973:988:989:1260:1345:1359:1437:1605:1730:1747:1777:1792:2194:2196:2199:2200:2393:2538:2539:2559:2562:2894:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:4052:4250:4321:4385:4419:4605:5007:6119:6261:7558:7875:7903:7904:9010:9592:10004:10848:11026:11473:11658:11914:12043:12048:12296:12297:12438:12555:12895:12986:14096:14394:21080:21451:21627:21740:30054:30055:30056:30067:30069:30070:30083,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:1,
 LUA_SUMMARY:none
X-HE-Tag: hand80_84e6ee124be55
X-Filterd-Recvd-Size: 10239
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 02:55:13 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 06/13] nvdimm: Add and remove blank lines
Date: Wed, 11 Sep 2019 19:54:36 -0700
Message-Id: <025c3fdcb7c6a23f73486d5c7cd515a7bda37a04.1568256707.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1568256705.git.joe@perches.com>
References: <cover.1568256705.git.joe@perches.com>
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
Cc: linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 linux-nvdimm@lists.01.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Use a more common kernel style.

Remove unnecessary multiple blank lines.
Remove blank lines before and after braces.
Add blank lines after functions definitions and enums.
Add blank lines around #define pr_fmt.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/btt.c            | 2 --
 drivers/nvdimm/bus.c            | 5 ++---
 drivers/nvdimm/dimm.c           | 1 -
 drivers/nvdimm/dimm_devs.c      | 2 ++
 drivers/nvdimm/label.c          | 1 -
 drivers/nvdimm/namespace_devs.c | 5 -----
 drivers/nvdimm/nd-core.h        | 4 ++++
 drivers/nvdimm/nd.h             | 6 ++++++
 drivers/nvdimm/nd_virtio.c      | 1 -
 drivers/nvdimm/region_devs.c    | 1 +
 drivers/nvdimm/security.c       | 2 --
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 28b65413abd8..0927cbdc5cc6 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1354,7 +1354,6 @@ static int btt_write_pg(struct btt *btt, struct bio_integrity_payload *bip,
 			while (arena->rtt[i] == (RTT_VALID | new_postmap))
 				cpu_relax();
 
-
 		if (new_postmap >= arena->internal_nlba) {
 			ret = -EIO;
 			goto out_lane;
@@ -1496,7 +1495,6 @@ static int btt_rw_page(struct block_device *bdev, sector_t sector,
 	return rc;
 }
 
-
 static int btt_getgeo(struct block_device *bd, struct hd_geometry *geo)
 {
 	/* some standard values */
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 35591f492d27..5ffd61c9c4b7 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -2,7 +2,9 @@
 /*
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
+
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/libnvdimm.h>
 #include <linux/sched/mm.h>
 #include <linux/vmalloc.h>
@@ -643,7 +645,6 @@ int nvdimm_revalidate_disk(struct gendisk *disk)
 	set_disk_ro(disk, 1);
 
 	return 0;
-
 }
 EXPORT_SYMBOL(nvdimm_revalidate_disk);
 
@@ -881,7 +882,6 @@ u32 nd_cmd_out_size(struct nvdimm *nvdimm, int cmd,
 		return pkg->nd_size_out;
 	}
 
-
 	return UINT_MAX;
 }
 EXPORT_SYMBOL_GPL(nd_cmd_out_size);
@@ -940,7 +940,6 @@ static int nd_pmem_forget_poison_check(struct device *dev, void *data)
 		return -EBUSY;
 
 	return 0;
-
 }
 
 static int nd_ns_forget_poison_check(struct device *dev, void *data)
diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
index 916710ae647f..5783c6d6dbdc 100644
--- a/drivers/nvdimm/dimm.c
+++ b/drivers/nvdimm/dimm.c
@@ -62,7 +62,6 @@ static int nvdimm_probe(struct device *dev)
 	if (rc < 0)
 		dev_dbg(dev, "failed to unlock dimm: %d\n", rc);
 
-
 	/*
 	 * EACCES failures reading the namespace label-area-properties
 	 * are interpreted as the DIMM capacity being locked but the
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index cb5598b3c389..873df96795b0 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -2,7 +2,9 @@
 /*
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
+
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/device.h>
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 5700d9b35b8f..bf58357927c4 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -972,7 +972,6 @@ static int __blk_label_update(struct nd_region *nd_region,
 	}
 	/* from here on we need to abort on error */
 
-
 	/* assign all resources to the namespace before writing the labels */
 	nsblk->res = NULL;
 	nsblk->num_resources = 0;
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 2bf4b6344926..600df84b4d2d 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -367,7 +367,6 @@ resource_size_t nd_namespace_blk_validate(struct nd_namespace_blk *nsblk)
 }
 EXPORT_SYMBOL(nd_namespace_blk_validate);
 
-
 static int nd_namespace_label_update(struct nd_region *nd_region,
 				     struct device *dev)
 {
@@ -543,7 +542,6 @@ static resource_size_t init_dpa_allocation(struct nd_label_id *label_id,
 	return rc ? n : 0;
 }
 
-
 /**
  * space_valid() - validate free dpa space against constraints
  * @nd_region: hosting region of the free space
@@ -2009,7 +2007,6 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 		if (namespace_label_has(ndd, abstraction_guid))
 			nspm->nsio.common.claim_class
 				= to_nvdimm_cclass(&label0->abstraction_guid);
-
 	}
 
 	if (!nspm->alt_name || !nspm->uuid) {
@@ -2217,7 +2214,6 @@ static int add_namespace_resource(struct nd_region *nd_region,
 static struct device *create_namespace_blk(struct nd_region *nd_region,
 					   struct nd_namespace_label *nd_label, int count)
 {
-
 	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -2362,7 +2358,6 @@ static struct device **scan_labels(struct nd_region *nd_region)
 			}
 		} else
 			devs[count++] = dev;
-
 	}
 
 	dev_dbg(&nd_region->dev, "discovered %d %s namespace%s\n",
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index b9163fff27b0..3b48fba4629b 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -66,6 +66,7 @@ static inline unsigned long nvdimm_security_flags(
 		      (unsigned long long)flags);
 	return flags;
 }
+
 int nvdimm_security_freeze(struct nvdimm *nvdimm);
 #if IS_ENABLED(CONFIG_NVDIMM_KEYS)
 ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len);
@@ -76,6 +77,7 @@ static inline ssize_t nvdimm_security_store(struct device *dev,
 {
 	return -EOPNOTSUPP;
 }
+
 static inline void nvdimm_security_overwrite_query(struct work_struct *work)
 {
 }
@@ -106,10 +108,12 @@ static inline bool is_nd_region(struct device *dev)
 {
 	return is_nd_pmem(dev) || is_nd_blk(dev) || is_nd_volatile(dev);
 }
+
 static inline bool is_memory(struct device *dev)
 {
 	return is_nd_pmem(dev) || is_nd_volatile(dev);
 }
+
 struct nvdimm_bus *walk_to_nvdimm_bus(struct device *nd_dev);
 int __init nvdimm_bus_init(void);
 void nvdimm_bus_exit(void);
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 1636061b1f93..d434041ca2e5 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -108,6 +108,7 @@ struct nd_percpu_lane {
 enum nd_label_flags {
 	ND_LABEL_REAP,
 };
+
 struct nd_label_ent {
 	struct list_head list;
 	unsigned long flags;
@@ -384,11 +385,13 @@ static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
 {
 	return -ENXIO;
 }
+
 static inline int devm_nsio_enable(struct device *dev,
 				   struct nd_namespace_io *nsio)
 {
 	return -ENXIO;
 }
+
 static inline void devm_nsio_disable(struct device *dev,
 				     struct nd_namespace_io *nsio)
 {
@@ -409,12 +412,14 @@ static inline bool nd_iostat_start(struct bio *bio, unsigned long *start)
 			      &disk->part0);
 	return true;
 }
+
 static inline void nd_iostat_end(struct bio *bio, unsigned long start)
 {
 	struct gendisk *disk = bio->bi_disk;
 
 	generic_end_io_acct(disk->queue, bio_op(bio), &disk->part0, start);
 }
+
 static inline bool is_bad_pmem(struct badblocks *bb, sector_t sector,
 			       unsigned int len)
 {
@@ -428,6 +433,7 @@ static inline bool is_bad_pmem(struct badblocks *bb, sector_t sector,
 
 	return false;
 }
+
 resource_size_t nd_namespace_blk_validate(struct nd_namespace_blk *nsblk);
 const u8 *nd_dev_to_uuid(struct device *dev);
 bool pmem_should_map_pages(struct device *dev);
diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index e4f553633759..f09541bf3d5d 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -68,7 +68,6 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	 */
 	while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req_data,
 					GFP_ATOMIC)) == -ENOSPC) {
-
 		dev_info(&vdev->dev, "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
 		req_data->wq_buf_avail = false;
 		list_add_tail(&req_data->list, &vpmem->req_list);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 9265a2b0018c..76b08b64b0b1 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1141,6 +1141,7 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
 
 	return rc;
 }
+
 /**
  * nvdimm_flush - flush any posted write queues between the cpu and pmem media
  * @nd_region: blk or interleaved pmem region
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index ac23cd4480bd..13bc5d54f0b6 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -135,7 +135,6 @@ static const void *nvdimm_get_user_key_payload(struct nvdimm *nvdimm,
 	return key_data(*key);
 }
 
-
 static int nvdimm_key_revalidate(struct nvdimm *nvdimm)
 {
 	struct key *key;
@@ -439,7 +438,6 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 
 	rc = nvdimm->sec.ops->query_overwrite(nvdimm);
 	if (rc == -EBUSY) {
-
 		/* setup delayed work again */
 		tmo += 10;
 		queue_delayed_work(system_wq, &nvdimm->dwork, tmo * HZ);
-- 
2.15.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
