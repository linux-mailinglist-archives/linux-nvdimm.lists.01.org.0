Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2709C331F8C
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Mar 2021 07:54:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 33B04100EBB94;
	Mon,  8 Mar 2021 22:54:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1C0DE100EBB90
	for <linux-nvdimm@lists.01.org>; Mon,  8 Mar 2021 22:54:22 -0800 (PST)
IronPort-SDR: z+3no13qbkrupTlYFCFGqZDIO52Hn7RXot3v2onPrOOAXw8mMobNEkB2Q/qyZGT+UdZpFlBPlS
 pvpmMI2H2L0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="167444906"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400";
   d="scan'208";a="167444906"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 22:54:22 -0800
IronPort-SDR: dAdWMk+JmlDxVk9M4A/URs+ost3nLPKwcJrq77fVg6oR6mQ2pIIvTAH8qM+HEUGr7z6MhnKkF+
 bBc0A5Z9L0jg==
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400";
   d="scan'208";a="437569479"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 22:54:22 -0800
Subject: [PATCH] libnvdimm: Let revalidate_disk() revalidate region read-only
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 08 Mar 2021 22:54:22 -0800
Message-ID: <161527286194.446794.5215036039655765042.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: X427XFEGWGNQ5BCKDFIWONQRMDAFSYMJ
X-Message-ID-Hash: X427XFEGWGNQ5BCKDFIWONQRMDAFSYMJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>, kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X427XFEGWGNQ5BCKDFIWONQRMDAFSYMJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Previous kernels allowed the BLKROSET to override the disk's read-only
status. With that situation fixed the pmem driver needs to rely on
revalidate_disk() to clear the disk read-only status after the host
region has been marked read-write.

Recall that when libnvdimm determines that the persistent memory has
lost persistence (for example lack of energy to flush from DRAM to FLASH
on an NVDIMM-N device) it marks the region read-only, but that state can
be overridden by the user via:

   echo 0 > /sys/bus/nd/devices/regionX/read_only

...to date there is no notification that the region has restored
persistence, so the user override is the only recovery.

Fixes: 52f019d43c22 ("block: add a hard-readonly flag to struct gendisk")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/btt.c  |    7 +++++++
 drivers/nvdimm/bus.c  |   14 ++++++--------
 drivers/nvdimm/pmem.c |    7 +++++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 41aa1f01fc07..73d3bf5aa208 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1508,11 +1508,18 @@ static int btt_getgeo(struct block_device *bd, struct hd_geometry *geo)
 	return 0;
 }
 
+static int btt_revalidate(struct gendisk *disk)
+{
+	nvdimm_check_and_set_ro(disk);
+	return 0;
+}
+
 static const struct block_device_operations btt_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		btt_submit_bio,
 	.rw_page =		btt_rw_page,
 	.getgeo =		btt_getgeo,
+	.revalidate_disk =	btt_revalidate,
 };
 
 static int btt_blk_init(struct btt *btt)
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 48f0985ca8a0..3a777d0073b7 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -631,16 +631,14 @@ void nvdimm_check_and_set_ro(struct gendisk *disk)
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	int disk_ro = get_disk_ro(disk);
 
-	/*
-	 * Upgrade to read-only if the region is read-only preserve as
-	 * read-only if the disk is already read-only.
-	 */
-	if (disk_ro || nd_region->ro == disk_ro)
+	/* catch the disk up with the region ro state */
+	if (disk_ro == nd_region->ro)
 		return;
 
-	dev_info(dev, "%s read-only, marking %s read-only\n",
-			dev_name(&nd_region->dev), disk->disk_name);
-	set_disk_ro(disk, 1);
+	dev_info(dev, "%s read-%s, marking %s read-%s\n",
+		 dev_name(&nd_region->dev), nd_region->ro ? "only" : "write",
+		 disk->disk_name, nd_region->ro ? "only" : "write");
+	set_disk_ro(disk, nd_region->ro);
 }
 EXPORT_SYMBOL(nvdimm_check_and_set_ro);
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index b8a85bfb2e95..af204fce1b1c 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -276,10 +276,17 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	return PHYS_PFN(pmem->size - pmem->pfn_pad - offset);
 }
 
+static int pmem_revalidate(struct gendisk *disk)
+{
+	nvdimm_check_and_set_ro(disk);
+	return 0;
+}
+
 static const struct block_device_operations pmem_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		pmem_submit_bio,
 	.rw_page =		pmem_rw_page,
+	.revalidate_disk =	pmem_revalidate,
 };
 
 static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
