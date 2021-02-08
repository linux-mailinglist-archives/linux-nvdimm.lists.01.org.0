Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B659A312FC7
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 11:55:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4BAB8100EB322;
	Mon,  8 Feb 2021 02:55:45 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 9A173100EB325
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 02:55:41 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,161,1610380800";
   d="scan'208";a="104328064"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Feb 2021 18:55:40 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 58EDC4CE6F82;
	Mon,  8 Feb 2021 18:55:37 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 8 Feb 2021 18:55:40 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 18:55:39 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
Subject: [PATCH v3 04/11] block_dev: Introduce bd_corrupted_range() for block device
Date: Mon, 8 Feb 2021 18:55:23 +0800
Message-ID: <20210208105530.3072869-5-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 58EDC4CE6F82.A0C98
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: ZP35454YEDJJR2FTCQQM2WMGONXIEVO2
X-Message-ID-Hash: ZP35454YEDJJR2FTCQQM2WMGONXIEVO2
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, agk@redhat.com, snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZP35454YEDJJR2FTCQQM2WMGONXIEVO2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

As is show in the call tree:
 ...
 pgmap->ops->memory_failure()
  gendisk->fops->corrupted_range()
   sb->s_ops->currupted_range()
    ...
currupted_range() is called from disk(pmem) to superblock(filesystem).
Thus, we need to introduce a helper function to obtain the superblock
from a given disk.

Normally, a filesystem can be created by mkfs directly on a block device
or a parted disk. We can obtain the superblock by calling get_super().

But get_super() is not suitable for mapped device, such as LVM. To
obtain MD's superblock, we can iterate bd_holder_disks of a block device
to find out the MD that contains it. By this way, MD is able to call
corrupted_range() from its target block device.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/block_dev.c        | 47 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/genhd.h |  2 ++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 3b8963e228a1..755b0d351479 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1079,6 +1079,28 @@ struct bd_holder_disk {
 	int			refcnt;
 };
 
+static int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off,
+					  size_t len, void *data)
+{
+	struct bd_holder_disk *holder;
+	struct gendisk *disk;
+	int rc = 0;
+
+	if (list_empty(&(bdev->bd_holder_disks)))
+		return -ENODEV;
+
+	list_for_each_entry(holder, &bdev->bd_holder_disks, list) {
+		disk = holder->disk;
+		if (disk->fops->corrupted_range) {
+			rc = disk->fops->corrupted_range(disk, bdev, off,
+							 len, data);
+			if (rc != -ENODEV)
+				break;
+		}
+	}
+	return rc;
+}
+
 static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
 						  struct gendisk *disk)
 {
@@ -1212,7 +1234,30 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	mutex_unlock(&bdev->bd_mutex);
 }
 EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
-#endif
+#else
+static inline int bd_disk_holder_corrupted_range(struct block_device *bdev,
+					loff_t off, size_t len, void *data)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_SYSFS */
+
+int bd_corrupted_range(struct block_device *bdev, loff_t disk_off,
+		       loff_t bdev_off, size_t len, void *data)
+{
+	struct super_block *sb = get_super(bdev);
+	int rc = -EOPNOTSUPP;
+
+	if (!sb) {
+		rc = bd_disk_holder_corrupted_range(bdev, disk_off, len, data);
+		return rc;
+	} else if (sb->s_op->corrupted_range)
+		rc = sb->s_op->corrupted_range(sb, bdev, bdev_off, len, data);
+	drop_super(sb);
+
+	return rc;
+}
+EXPORT_SYMBOL(bd_corrupted_range);
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 809aaa32d53c..751cbd559bba 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -314,6 +314,8 @@ void unregister_blkdev(unsigned int major, const char *name);
 bool bdev_check_media_change(struct block_device *bdev);
 int __invalidate_device(struct block_device *bdev, bool kill_dirty);
 void set_capacity(struct gendisk *disk, sector_t size);
+int bd_corrupted_range(struct block_device *bdev, loff_t disk_off,
+		       loff_t bdev_off, size_t len, void *data);
 
 /* for drivers/char/raw.c: */
 int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
-- 
2.30.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
