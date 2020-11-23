Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0373D2BFDA3
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Nov 2020 01:41:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 46A98100ED4B4;
	Sun, 22 Nov 2020 16:41:54 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 8F056100ED498
	for <linux-nvdimm@lists.01.org>; Sun, 22 Nov 2020 16:41:49 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.78,361,1599494400";
   d="scan'208";a="101635246"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Nov 2020 08:41:47 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id 70B484CE5458;
	Mon, 23 Nov 2020 08:41:42 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 23 Nov 2020 08:41:43 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 23 Nov 2020 08:41:42 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
Subject: [RFC PATCH v2 3/6] md: implement ->block_lost() for memory-failure
Date: Mon, 23 Nov 2020 08:41:13 +0800
Message-ID: <20201123004116.2453-4-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 70B484CE5458.A9ED9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: O7LK6YSH3RGJX4BT7IMYODQ7MZOZTOL2
X-Message-ID-Hash: O7LK6YSH3RGJX4BT7IMYODQ7MZOZTOL2
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O7LK6YSH3RGJX4BT7IMYODQ7MZOZTOL2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Mapped device is a type of block device.  It could be created on the
pmem where memory-failure happens.  LVM created with pmem device is one
kind use case.

What we need to do is:
 1. find out the filesystem where lost block located in
      Iterate all targets and test if the target is the broken device.
 2. translate the offset on the one of target devices to the whole
    mapped device
      Intorduce ->remap() for each target, to reverse map the offset.
      It is implemented by each target.  The linear target's is
      implemented in this patch.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 drivers/md/dm-linear.c        |  8 +++++
 drivers/md/dm.c               | 64 +++++++++++++++++++++++++++++++++++
 include/linux/device-mapper.h |  2 ++
 3 files changed, 74 insertions(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 00774b5d7668..6595701800e6 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -119,6 +119,13 @@ static void linear_status(struct dm_target *ti, status_type_t type,
 	}
 }
 
+static sector_t linear_remap(struct dm_target *ti, sector_t offset)
+{
+	struct linear_c *lc = (struct linear_c *) ti->private;
+
+	return offset - dm_target_offset(ti, lc->start);
+}
+
 static int linear_prepare_ioctl(struct dm_target *ti, struct block_device **bdev)
 {
 	struct linear_c *lc = (struct linear_c *) ti->private;
@@ -238,6 +245,7 @@ static struct target_type linear_target = {
 	.ctr    = linear_ctr,
 	.dtr    = linear_dtr,
 	.map    = linear_map,
+	.remap  = linear_remap,
 	.status = linear_status,
 	.prepare_ioctl = linear_prepare_ioctl,
 	.iterate_devices = linear_iterate_devices,
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c18fc2548518..00e075fb4cdb 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -505,6 +505,69 @@ static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 #define dm_blk_report_zones		NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+struct dm_blk_block_lost {
+	struct block_device *bdev;
+	sector_t offset;
+};
+
+static int dm_blk_block_lost_fn(struct dm_target *ti, struct dm_dev *dev,
+				sector_t start, sector_t len, void *data)
+{
+	struct dm_blk_block_lost *bl = data;
+
+	return bl->bdev == (void *)dev->bdev &&
+			(start <= bl->offset && bl->offset < start + len);
+}
+
+static int dm_blk_block_lost(struct gendisk *disk,
+			     struct block_device *target_bdev,
+			     loff_t target_offset, void *data)
+{
+	struct mapped_device *md = disk->private_data;
+	struct block_device *md_bdev = md->bdev;
+	struct dm_table *map;
+	struct dm_target *ti;
+	struct super_block *sb;
+	int srcu_idx, i, rc = 0;
+	bool found = false;
+	sector_t disk_sec, target_sec = to_sector(target_offset);
+
+	map = dm_get_live_table(md, &srcu_idx);
+	if (!map)
+		return -ENODEV;
+
+	for (i = 0; i < dm_table_get_num_targets(map); i++) {
+		ti = dm_table_get_target(map, i);
+		if (ti->type->iterate_devices && ti->type->remap) {
+			struct dm_blk_block_lost bl = {target_bdev, target_sec};
+			found = ti->type->iterate_devices(ti, dm_blk_block_lost_fn, &bl);
+			if (!found)
+				continue;
+			disk_sec = ti->type->remap(ti, target_sec);
+			break;
+		}
+	}
+
+	if (!found) {
+		rc = -ENODEV;
+		goto out;
+	}
+
+	sb = get_super(md_bdev);
+	if (!sb) {
+		rc = bd_disk_holder_block_lost(md_bdev, disk_sec, data);
+		goto out;
+	} else if (sb->s_op->storage_lost) {
+		loff_t off = to_bytes(disk_sec - get_start_sect(md_bdev));
+		rc = sb->s_op->storage_lost(sb, md_bdev, off, data);
+	}
+	drop_super(sb);
+
+out:
+	dm_put_live_table(md, srcu_idx);
+	return rc;
+}
+
 static int dm_prepare_ioctl(struct mapped_device *md, int *srcu_idx,
 			    struct block_device **bdev)
 	__acquires(md->io_barrier)
@@ -3082,6 +3145,7 @@ static const struct block_device_operations dm_blk_dops = {
 	.ioctl = dm_blk_ioctl,
 	.getgeo = dm_blk_getgeo,
 	.report_zones = dm_blk_report_zones,
+	.block_lost = dm_blk_block_lost,
 	.pr_ops = &dm_pr_ops,
 	.owner = THIS_MODULE
 };
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 61a66fb8ebb3..bc28bd5bc436 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -58,6 +58,7 @@ typedef void (*dm_dtr_fn) (struct dm_target *ti);
  * = 2: The target wants to push back the io
  */
 typedef int (*dm_map_fn) (struct dm_target *ti, struct bio *bio);
+typedef sector_t (*dm_remap_fn) (struct dm_target *ti, sector_t offset);
 typedef int (*dm_clone_and_map_request_fn) (struct dm_target *ti,
 					    struct request *rq,
 					    union map_info *map_context,
@@ -175,6 +176,7 @@ struct target_type {
 	dm_ctr_fn ctr;
 	dm_dtr_fn dtr;
 	dm_map_fn map;
+	dm_remap_fn remap;
 	dm_clone_and_map_request_fn clone_and_map_rq;
 	dm_release_clone_request_fn release_clone_rq;
 	dm_endio_fn end_io;
-- 
2.29.2


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
