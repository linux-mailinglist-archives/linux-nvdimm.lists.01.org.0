Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7F0259602
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Sep 2020 17:58:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CE731396FBF8;
	Tue,  1 Sep 2020 08:58:18 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+00d723da4443b0556009+6218+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 148AB1396FBF7
	for <linux-nvdimm@lists.01.org>; Tue,  1 Sep 2020 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=EF13r0+0d9O9nMlCm01+oM4tKYciqyKnGXIGW3kVD84=; b=HYmAhoZ63YSCjnl8OuIdMgC24+
	OLAuE5Qyl8+SSIbmk3g4PfdSIPkzBGGetTuDOxX+Qs71QQjZWAzLKzMrACN8ulp7QR2iOUqE4ZVNK
	06RJaa6wr36QFWrQPzM/l+J7VvHyUnAfWlNLm19OPiozI/Qs9/Fc/6hqOVJv0n5/Jq2e9uyN/MvTB
	Erk1SKzkRxjElLUaV/1kuC3vG+fazzPUHr4TI0+fOEtxoYuO96ZKZJCwD4DZy25U4usxk60CTBX5g
	JMOaZAOsbMVbuPX09gGZ17T4KknRMsn/fTvw5ptusMsDfDiH90pDKkOVpM+A202zJTr0td5QYxw9u
	KPNZLITw==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD8fc-0004RL-8h; Tue, 01 Sep 2020 15:58:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 8/9] nvdimm: simplify revalidate_disk handling
Date: Tue,  1 Sep 2020 17:57:47 +0200
Message-Id: <20200901155748.2884-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: 25ZQW4YBXJHWVM5SYA4VXAR4SA5RAMHY
X-Message-ID-Hash: 25ZQW4YBXJHWVM5SYA4VXAR4SA5RAMHY
X-MailFrom: BATV+00d723da4443b0556009+6218+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Josef Bacik <josef@toxicpanda.com>, dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/25ZQW4YBXJHWVM5SYA4VXAR4SA5RAMHY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The nvdimm block driver abuse revalidate_disk in a strange way, and
totally unrelated to what other drivers do.  Simplify this by just
calling nvdimm_revalidate_disk (which seems rather misnamed) from the
probe routines, as the additional bdev size revalidation is pointless
at this point, and remove the revalidate_disk methods given that
it can only be triggered from add_disk, which is right before the
manual calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvdimm/blk.c  | 3 +--
 drivers/nvdimm/btt.c  | 3 +--
 drivers/nvdimm/bus.c  | 9 +++------
 drivers/nvdimm/nd.h   | 2 +-
 drivers/nvdimm/pmem.c | 3 +--
 5 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 1f718381a04553..22e5617b2cea14 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -226,7 +226,6 @@ static int nsblk_rw_bytes(struct nd_namespace_common *ndns,
 static const struct block_device_operations nd_blk_fops = {
 	.owner = THIS_MODULE,
 	.submit_bio =  nd_blk_submit_bio,
-	.revalidate_disk = nvdimm_revalidate_disk,
 };
 
 static void nd_blk_release_queue(void *q)
@@ -284,7 +283,7 @@ static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
 
 	set_capacity(disk, available_disk_size >> SECTOR_SHIFT);
 	device_add_disk(dev, disk, NULL);
-	revalidate_disk(disk);
+	nvdimm_check_and_set_ro(disk);
 	return 0;
 }
 
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 0ff610e728ff6f..0d710140bf93be 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1513,7 +1513,6 @@ static const struct block_device_operations btt_fops = {
 	.submit_bio =		btt_submit_bio,
 	.rw_page =		btt_rw_page,
 	.getgeo =		btt_getgeo,
-	.revalidate_disk =	nvdimm_revalidate_disk,
 };
 
 static int btt_blk_init(struct btt *btt)
@@ -1558,7 +1557,7 @@ static int btt_blk_init(struct btt *btt)
 	set_capacity(btt->btt_disk, btt->nlba * btt->sector_size >> 9);
 	device_add_disk(&btt->nd_btt->dev, btt->btt_disk, NULL);
 	btt->nd_btt->size = btt->nlba * (u64)btt->sector_size;
-	revalidate_disk(btt->btt_disk);
+	nvdimm_check_and_set_ro(btt->btt_disk);
 
 	return 0;
 }
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 955265656b96c7..2304c6183822e9 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -628,7 +628,7 @@ int __nd_driver_register(struct nd_device_driver *nd_drv, struct module *owner,
 }
 EXPORT_SYMBOL(__nd_driver_register);
 
-int nvdimm_revalidate_disk(struct gendisk *disk)
+void nvdimm_check_and_set_ro(struct gendisk *disk)
 {
 	struct device *dev = disk_to_dev(disk)->parent;
 	struct nd_region *nd_region = to_nd_region(dev->parent);
@@ -639,16 +639,13 @@ int nvdimm_revalidate_disk(struct gendisk *disk)
 	 * read-only if the disk is already read-only.
 	 */
 	if (disk_ro || nd_region->ro == disk_ro)
-		return 0;
+		return;
 
 	dev_info(dev, "%s read-only, marking %s read-only\n",
 			dev_name(&nd_region->dev), disk->disk_name);
 	set_disk_ro(disk, 1);
-
-	return 0;
-
 }
-EXPORT_SYMBOL(nvdimm_revalidate_disk);
+EXPORT_SYMBOL(nvdimm_check_and_set_ro);
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 85c1ae813ea318..72740108ba4206 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -361,7 +361,7 @@ u64 nd_region_interleave_set_altcookie(struct nd_region *nd_region);
 void nvdimm_bus_lock(struct device *dev);
 void nvdimm_bus_unlock(struct device *dev);
 bool is_nvdimm_bus_locked(struct device *dev);
-int nvdimm_revalidate_disk(struct gendisk *disk);
+void nvdimm_check_and_set_ro(struct gendisk *disk);
 void nvdimm_drvdata_release(struct kref *kref);
 void put_ndd(struct nvdimm_drvdata *ndd);
 int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index fab29b514372d0..140cf3b9000c60 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -281,7 +281,6 @@ static const struct block_device_operations pmem_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		pmem_submit_bio,
 	.rw_page =		pmem_rw_page,
-	.revalidate_disk =	nvdimm_revalidate_disk,
 };
 
 static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
@@ -501,7 +500,7 @@ static int pmem_attach_disk(struct device *dev,
 	if (devm_add_action_or_reset(dev, pmem_release_disk, pmem))
 		return -ENOMEM;
 
-	revalidate_disk(disk);
+	nvdimm_check_and_set_ro(disk);
 
 	pmem->bb_state = sysfs_get_dirent(disk_to_dev(disk)->kobj.sd,
 					  "badblocks");
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
