Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED90D15AE18
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Feb 2020 18:08:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5D7310FC3378;
	Wed, 12 Feb 2020 09:11:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5BE841007B1FC
	for <linux-nvdimm@lists.01.org>; Wed, 12 Feb 2020 09:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581527275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/c2s2GuSGDBWl7JNFoYav/ggi3RBj2wTD17cdDeOIw=;
	b=BDtF5561WN1SS62WBmKO4rAx8ODzkVCW4ttktz3qB0jH5shWyZIVN6g/t/s+FIIP75gf7I
	8OZ8E9uuradkOpbnTN6osCVfS4bLPUQPV2APjyLJDw9T0HvVJtNIiFqrKy2Un2OuWPlre/
	SU96itbmQdDI4STxLEUBdoOQIefCdc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-tIVHKbPON-S-T3zmRJIxnQ-1; Wed, 12 Feb 2020 12:07:51 -0500
X-MC-Unique: tIVHKbPON-S-T3zmRJIxnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0762010054E3;
	Wed, 12 Feb 2020 17:07:50 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3098E60BF1;
	Wed, 12 Feb 2020 17:07:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id BB6FD2257D6; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com,
	hch@infradead.org
Subject: [PATCH 4/6] dax, dm/md: Use dax_pgoff() instead of bdev_dax_pgoff()
Date: Wed, 12 Feb 2020 12:07:31 -0500
Message-Id: <20200212170733.8092-5-vgoyal@redhat.com>
In-Reply-To: <20200212170733.8092-1-vgoyal@redhat.com>
References: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: JFXKJMFMNMEYCF57MCDQESVCN4QG7WVS
X-Message-ID-Hash: JFXKJMFMNMEYCF57MCDQESVCN4QG7WVS
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JFXKJMFMNMEYCF57MCDQESVCN4QG7WVS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Replace usage of bdev_dax_pgoff() with dax_pgoff().

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/md/dm-linear.c     | 9 ++++++---
 drivers/md/dm-log-writes.c | 9 ++++++---
 drivers/md/dm-stripe.c     | 8 +++++---
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 8d07fdf63a47..05f654044185 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -167,7 +167,8 @@ static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
 
 	dev_sector = linear_map_sector(ti, sector);
-	ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
+	ret = dax_pgoff(get_start_sect(bdev), dev_sector, nr_pages * PAGE_SIZE,
+			&pgoff);
 	if (ret)
 		return ret;
 	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
@@ -182,7 +183,8 @@ static size_t linear_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
 	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
 
 	dev_sector = linear_map_sector(ti, sector);
-	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
+	if (dax_pgoff(get_start_sect(bdev), dev_sector, ALIGN(bytes, PAGE_SIZE),
+		      &pgoff))
 		return 0;
 	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
 }
@@ -196,7 +198,8 @@ static size_t linear_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
 	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
 
 	dev_sector = linear_map_sector(ti, sector);
-	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
+	if (dax_pgoff(get_start_sect(bdev), dev_sector, ALIGN(bytes, PAGE_SIZE),
+		      &pgoff))
 		return 0;
 	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
 }
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 99721c76225d..204fbceeb97e 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -952,7 +952,8 @@ static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 	sector_t sector = pgoff * PAGE_SECTORS;
 	int ret;
 
-	ret = bdev_dax_pgoff(lc->dev->bdev, sector, nr_pages * PAGE_SIZE, &pgoff);
+	ret = dax_pgoff(get_start_sect(lc->dev->bdev), sector,
+			nr_pages * PAGE_SIZE, &pgoff);
 	if (ret)
 		return ret;
 	return dax_direct_access(lc->dev->dax_dev, pgoff, nr_pages, kaddr, pfn);
@@ -966,7 +967,8 @@ static size_t log_writes_dax_copy_from_iter(struct dm_target *ti,
 	sector_t sector = pgoff * PAGE_SECTORS;
 	int err;
 
-	if (bdev_dax_pgoff(lc->dev->bdev, sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
+	if (dax_pgoff(get_start_sect(lc->dev->bdev), sector,
+		      ALIGN(bytes, PAGE_SIZE), &pgoff))
 		return 0;
 
 	/* Don't bother doing anything if logging has been disabled */
@@ -989,7 +991,8 @@ static size_t log_writes_dax_copy_to_iter(struct dm_target *ti,
 	struct log_writes_c *lc = ti->private;
 	sector_t sector = pgoff * PAGE_SECTORS;
 
-	if (bdev_dax_pgoff(lc->dev->bdev, sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
+	if (dax_pgoff(get_start_sect(lc->dev->bdev), sector,
+		      ALIGN(bytes, PAGE_SIZE), &pgoff))
 		return 0;
 	return dax_copy_to_iter(lc->dev->dax_dev, pgoff, addr, bytes, i);
 }
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 63bbcc20f49a..337cdc6e0951 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -316,7 +316,8 @@ static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 	dax_dev = sc->stripe[stripe].dev->dax_dev;
 	bdev = sc->stripe[stripe].dev->bdev;
 
-	ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
+	ret = dax_pgoff(get_start_sect(bdev), dev_sector, nr_pages * PAGE_SIZE,
+			&pgoff);
 	if (ret)
 		return ret;
 	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
@@ -336,7 +337,7 @@ static size_t stripe_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
 	dax_dev = sc->stripe[stripe].dev->dax_dev;
 	bdev = sc->stripe[stripe].dev->bdev;
 
-	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
+	if (dax_pgoff(get_start_sect(bdev), dev_sector, ALIGN(bytes, PAGE_SIZE),		      &pgoff))
 		return 0;
 	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
 }
@@ -355,7 +356,8 @@ static size_t stripe_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
 	dax_dev = sc->stripe[stripe].dev->dax_dev;
 	bdev = sc->stripe[stripe].dev->bdev;
 
-	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
+	if (dax_pgoff(get_start_sect(bdev), dev_sector, ALIGN(bytes, PAGE_SIZE),
+		      &pgoff))
 		return 0;
 	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
 }
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
