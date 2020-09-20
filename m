Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 641C227159B
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Sep 2020 18:13:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 81A6E14C10C66;
	Sun, 20 Sep 2020 09:13:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6100914C10C64
	for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 09:13:06 -0700 (PDT)
IronPort-SDR: ooritLJI75x9qyuaTYCjh3m6212mnF2ORPo4jOpv8IwcwliyY7BdkOxisxTd9h4/CLKbbUT5mN
 t0p3/y7Cq3JQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="157634897"
X-IronPort-AV: E=Sophos;i="5.77,283,1596524400";
   d="scan'208";a="157634897"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 09:13:02 -0700
IronPort-SDR: yj9pH4Dh9wal3PfBOIQJvHpSqfNHkQyrOcsKm59NQaCAEq3RE3CPuIrRXaYK1S+sxGO1eYq2Nb
 GMImt7ZQYgqg==
X-IronPort-AV: E=Sophos;i="5.77,283,1596524400";
   d="scan'208";a="308659989"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 09:13:01 -0700
Subject: [PATCH v4] dm: Call proper helper to determine dax support
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 20 Sep 2020 08:54:42 -0700
Message-ID: <160061715195.13131.5503173247632041975.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: OYPGDPYY42XHM3PSGMKRVVZCONVYWBZ4
X-Message-ID-Hash: OYPGDPYY42XHM3PSGMKRVVZCONVYWBZ4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stable@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>, Jan Kara <jack@suse.cz>, snitzer@redhat.com, kernel test robot <lkp@intel.com>, dm-devel@redhat.com, linux-kernel@vger.kernel.org, mpatocka@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OYPGDPYY42XHM3PSGMKRVVZCONVYWBZ4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jan Kara <jack@suse.cz>

DM was calling generic_fsdax_supported() to determine whether a device
referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
they don't have to duplicate common generic checks. High level code
should call dax_supported() helper which that calls into appropriate
helper for the particular device. This problem manifested itself as
kernel messages:

dm-3: error: dax access failed (-95)

when lvm2-testsuite run in cases where a DM device was stacked on top of
another DM device.

Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
Cc: <stable@vger.kernel.org>
Tested-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Acked-by: Mike Snitzer <snitzer@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3 [1]:
- One more kbuild-robot report on dax_read_lock() needing to be guarded
  by "#if IS_ENABLED(CONFIG_DAX)" instead of "#ifdef CONFIG_DAX" since
  the latter does not handle the "=m" case.

[2]: http://lore.kernel.org/r/160046028990.22670.15271558589864899328.stgit@dwillia2-desk3.amr.corp.intel.com

 drivers/dax/super.c   |    4 ++++
 drivers/md/dm-table.c |   10 +++++++---
 include/linux/dax.h   |   22 ++++++++++++++++++++--
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e5767c83ea23..b6284c5cae0a 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -325,11 +325,15 @@ EXPORT_SYMBOL_GPL(dax_direct_access);
 bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
 		int blocksize, sector_t start, sector_t len)
 {
+	if (!dax_dev)
+		return false;
+
 	if (!dax_alive(dax_dev))
 		return false;
 
 	return dax_dev->ops->dax_supported(dax_dev, bdev, blocksize, start, len);
 }
+EXPORT_SYMBOL_GPL(dax_supported);
 
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 5edc3079e7c1..229f461e7def 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -860,10 +860,14 @@ EXPORT_SYMBOL_GPL(dm_table_set_type);
 int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 			sector_t start, sector_t len, void *data)
 {
-	int blocksize = *(int *) data;
+	int blocksize = *(int *) data, id;
+	bool rc;
 
-	return generic_fsdax_supported(dev->dax_dev, dev->bdev, blocksize,
-				       start, len);
+	id = dax_read_lock();
+	rc = dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
+	dax_read_unlock(id);
+
+	return rc;
 }
 
 /* Check devices support synchronous DAX */
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 6904d4e0b2e0..497031392e0a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -130,6 +130,8 @@ static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
 	return __generic_fsdax_supported(dax_dev, bdev, blocksize, start,
 			sectors);
 }
+bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
+		int blocksize, sector_t start, sector_t len);
 
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
@@ -157,6 +159,13 @@ static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
 	return false;
 }
 
+static inline bool dax_supported(struct dax_device *dax_dev,
+		struct block_device *bdev, int blocksize, sector_t start,
+		sector_t len)
+{
+	return false;
+}
+
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 }
@@ -189,14 +198,23 @@ static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
 void dax_read_unlock(int id);
+#else
+static inline int dax_read_lock(void)
+{
+	return 0;
+}
+
+static inline void dax_read_unlock(int id)
+{
+}
+#endif /* CONFIG_DAX */
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 		void **kaddr, pfn_t *pfn);
-bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
-		int blocksize, sector_t start, sector_t len);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
