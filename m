Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92E302F7F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 Jan 2021 23:55:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EFD1F100EBB62;
	Mon, 25 Jan 2021 14:55:43 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id B972E100EBBDB
	for <linux-nvdimm@lists.01.org>; Mon, 25 Jan 2021 14:55:40 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.79,374,1602518400";
   d="scan'208";a="103820575"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Jan 2021 06:55:38 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
	by cn.fujitsu.com (Postfix) with ESMTP id 7F0044CE6782;
	Tue, 26 Jan 2021 06:55:37 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 26 Jan 2021 06:55:37 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 26 Jan 2021 06:55:35 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
Subject: [PATCH v2 06/10] pmem: Implement ->corrupted_range() for pmem driver
Date: Tue, 26 Jan 2021 06:55:22 +0800
Message-ID: <20210125225526.1048877-7-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125225526.1048877-1-ruansy.fnst@cn.fujitsu.com>
References: <20210125225526.1048877-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 7F0044CE6782.AAEB5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: SUGPHK253N3ATSVHJYZFUBDDNFRKA7PC
X-Message-ID-Hash: SUGPHK253N3ATSVHJYZFUBDDNFRKA7PC
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SUGPHK253N3ATSVHJYZFUBDDNFRKA7PC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Obtain the superblock of a pmem disk, and call filesystem's
->corrupted_range() to handle the corrupted data.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 block/genhd.c         |  6 ++++++
 drivers/nvdimm/pmem.c | 24 ++++++++++++++++++++++++
 include/linux/genhd.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 419548e92d82..fd7cf03b65a8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -936,6 +936,12 @@ struct block_device *bdget_disk(struct gendisk *disk, int partno)
 	return bdev;
 }
 
+struct block_device *bdget_disk_sector(struct gendisk *disk, sector_t sector)
+{
+	return disk_map_sector_rcu(disk, sector);
+}
+EXPORT_SYMBOL(bdget_disk_sector);
+
 /*
  * print a full list of all partitions - intended for places where the root
  * filesystem can't be mounted and thus to give the victim some idea of what
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index c9e4fb38f94a..501959947d48 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -253,6 +253,29 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 	return blk_status_to_errno(rc);
 }
 
+static int pmem_corrupted_range(struct gendisk *disk, struct block_device *bdev,
+				loff_t disk_offset, size_t len, void *data)
+{
+	struct super_block *sb;
+	loff_t bdev_offset;
+	sector_t disk_sector = disk_offset >> SECTOR_SHIFT;
+	int rc = 0;
+
+	bdev = bdget_disk_sector(disk, disk_sector);
+	if (!bdev)
+		return -ENODEV;
+
+	bdev_offset = (disk_sector - get_start_sect(bdev)) << SECTOR_SHIFT;
+	sb = get_super(bdev);
+	if (sb && sb->s_op->corrupted_range) {
+		rc = sb->s_op->corrupted_range(sb, bdev, bdev_offset, len, data);
+		drop_super(sb);
+	}
+
+	bdput(bdev);
+	return rc;
+}
+
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn)
@@ -281,6 +304,7 @@ static const struct block_device_operations pmem_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		pmem_submit_bio,
 	.rw_page =		pmem_rw_page,
+	.corrupted_range =	pmem_corrupted_range,
 };
 
 static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 809aaa32d53c..4da480798955 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -248,6 +248,7 @@ static inline void add_disk_no_queue_reg(struct gendisk *disk)
 
 extern void del_gendisk(struct gendisk *gp);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
+extern struct block_device *bdget_disk_sector(struct gendisk *disk, sector_t sector);
 
 extern void set_disk_ro(struct gendisk *disk, int flag);
 
-- 
2.30.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
