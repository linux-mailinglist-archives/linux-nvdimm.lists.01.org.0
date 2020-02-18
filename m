Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5755C16356E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 22:49:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29EC010FC35A4;
	Tue, 18 Feb 2020 13:50:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2C75F10FC3594
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 13:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582062543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua5wH/Fz9lZbyzCxi5AMLPX3L0G/B+dweayL4T+G0Qg=;
	b=Zn0kMNW0e0Zl6sM+hA74zWnm7a0kqEtwi8IWfIhUe99I5VWrjvx6oMLrqq0bGOR2hv8hi+
	iubX+VneOoTCCemIvYDZmQggE0eCItVAJj9XuHefo9buZ4Tbo5/3nQfCYOha7uwGC2dgL7
	4bRWKnpOFRaZknIMVSGGHl0sPrL9SXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-5diS3l_UO8ucu2yTve2aBg-1; Tue, 18 Feb 2020 16:49:00 -0500
X-MC-Unique: 5diS3l_UO8ucu2yTve2aBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11B06800D5A;
	Tue, 18 Feb 2020 21:48:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 58F9D90F5F;
	Tue, 18 Feb 2020 21:48:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id B31B12257D8; Tue, 18 Feb 2020 16:48:52 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	hch@infradead.org,
	dan.j.williams@intel.com
Subject: [PATCH v5 6/8] dm,dax: Add dax zero_page_range operation
Date: Tue, 18 Feb 2020 16:48:39 -0500
Message-Id: <20200218214841.10076-7-vgoyal@redhat.com>
In-Reply-To: <20200218214841.10076-1-vgoyal@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: HYFO2DKEM7DBQESBQF3WJI5LXMMEPA7C
X-Message-ID-Hash: HYFO2DKEM7DBQESBQF3WJI5LXMMEPA7C
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HYFO2DKEM7DBQESBQF3WJI5LXMMEPA7C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds support for dax zero_page_range operation to dm targets.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/md/dm-linear.c        | 21 +++++++++++++++++++++
 drivers/md/dm-log-writes.c    | 19 +++++++++++++++++++
 drivers/md/dm-stripe.c        | 26 ++++++++++++++++++++++++++
 drivers/md/dm.c               | 31 +++++++++++++++++++++++++++++++
 include/linux/device-mapper.h |  3 +++
 5 files changed, 100 insertions(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 8d07fdf63a47..03f99e6ad372 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -201,10 +201,30 @@ static size_t linear_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
 	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
 }
 
+static int linear_dax_zero_page_range(struct dm_target *ti, u64 offset,
+				      size_t len)
+{
+	int ret;
+	struct linear_c *lc = ti->private;
+	struct block_device *bdev = lc->dev->bdev;
+	struct dax_device *dax_dev = lc->dev->dax_dev;
+	pgoff_t pgoff = offset >> PAGE_SHIFT;
+	unsigned page_offset = offset_in_page(offset);
+	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
+
+	dev_sector = linear_map_sector(ti, sector);
+	ret = bdev_dax_pgoff(bdev, dev_sector, ALIGN(len, PAGE_SIZE), &pgoff);
+	if (ret)
+		return ret;
+	return dax_zero_page_range(dax_dev, (pgoff << PAGE_SHIFT) + page_offset,
+				   len);
+}
+
 #else
 #define linear_dax_direct_access NULL
 #define linear_dax_copy_from_iter NULL
 #define linear_dax_copy_to_iter NULL
+#define linear_dax_zero_page_range NULL
 #endif
 
 static struct target_type linear_target = {
@@ -226,6 +246,7 @@ static struct target_type linear_target = {
 	.direct_access = linear_dax_direct_access,
 	.dax_copy_from_iter = linear_dax_copy_from_iter,
 	.dax_copy_to_iter = linear_dax_copy_to_iter,
+	.dax_zero_page_range = linear_dax_zero_page_range,
 };
 
 int __init dm_linear_init(void)
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 99721c76225d..f36ee223cb60 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -994,10 +994,28 @@ static size_t log_writes_dax_copy_to_iter(struct dm_target *ti,
 	return dax_copy_to_iter(lc->dev->dax_dev, pgoff, addr, bytes, i);
 }
 
+static int log_writes_dax_zero_page_range(struct dm_target *ti, u64 offset,
+					  size_t len)
+{
+	int ret;
+	struct log_writes_c *lc = ti->private;
+	pgoff_t pgoff = offset >> PAGE_SHIFT;
+	unsigned page_offset = offset_in_page(offset);
+	sector_t sector = pgoff * PAGE_SECTORS;
+
+	ret = bdev_dax_pgoff(lc->dev->bdev, sector, ALIGN(len, PAGE_SIZE),
+			     &pgoff);
+	if (ret)
+		return ret;
+	return dax_zero_page_range(lc->dev->dax_dev,
+				   (pgoff << PAGE_SHIFT) + page_offset, len);
+}
+
 #else
 #define log_writes_dax_direct_access NULL
 #define log_writes_dax_copy_from_iter NULL
 #define log_writes_dax_copy_to_iter NULL
+#define log_writes_dax_zero_page_range NULL
 #endif
 
 static struct target_type log_writes_target = {
@@ -1016,6 +1034,7 @@ static struct target_type log_writes_target = {
 	.direct_access = log_writes_dax_direct_access,
 	.dax_copy_from_iter = log_writes_dax_copy_from_iter,
 	.dax_copy_to_iter = log_writes_dax_copy_to_iter,
+	.dax_zero_page_range = log_writes_dax_zero_page_range,
 };
 
 static int __init dm_log_writes_init(void)
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 63bbcc20f49a..f5e17284c615 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -360,10 +360,35 @@ static size_t stripe_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
 	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
 }
 
+static int stripe_dax_zero_page_range(struct dm_target *ti, u64 offset,
+				      size_t len)
+{
+	int ret;
+	pgoff_t pgoff = offset >> PAGE_SHIFT;
+	unsigned page_offset = offset_in_page(offset);
+	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
+	struct stripe_c *sc = ti->private;
+	struct dax_device *dax_dev;
+	struct block_device *bdev;
+	uint32_t stripe;
+
+	stripe_map_sector(sc, sector, &stripe, &dev_sector);
+	dev_sector += sc->stripe[stripe].physical_start;
+	dax_dev = sc->stripe[stripe].dev->dax_dev;
+	bdev = sc->stripe[stripe].dev->bdev;
+
+	ret = bdev_dax_pgoff(bdev, dev_sector, ALIGN(len, PAGE_SIZE), &pgoff);
+	if (ret)
+		return ret;
+	return dax_zero_page_range(dax_dev, (pgoff << PAGE_SHIFT) + page_offset,
+				   len);
+}
+
 #else
 #define stripe_dax_direct_access NULL
 #define stripe_dax_copy_from_iter NULL
 #define stripe_dax_copy_to_iter NULL
+#define stripe_dax_zero_page_range NULL
 #endif
 
 /*
@@ -486,6 +511,7 @@ static struct target_type stripe_target = {
 	.direct_access = stripe_dax_direct_access,
 	.dax_copy_from_iter = stripe_dax_copy_from_iter,
 	.dax_copy_to_iter = stripe_dax_copy_to_iter,
+	.dax_zero_page_range = stripe_dax_zero_page_range,
 };
 
 int __init dm_stripe_init(void)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b89f07ee2eff..c87cabdf7f18 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1198,6 +1198,36 @@ static size_t dm_dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 	return ret;
 }
 
+static int dm_dax_zero_page_range(struct dax_device *dax_dev, u64 offset,
+				  size_t len)
+{
+	struct mapped_device *md = dax_get_private(dax_dev);
+	pgoff_t pgoff = offset >> PAGE_SHIFT;
+	sector_t sector = pgoff * PAGE_SECTORS;
+	struct dm_target *ti;
+	int ret = -EIO;
+	int srcu_idx;
+
+	ti = dm_dax_get_live_target(md, sector, &srcu_idx);
+
+	if (!ti)
+		goto out;
+	if (WARN_ON(!ti->type->dax_zero_page_range)) {
+		/*
+		 * ->zero_page_range() is mandatory dax operation. If we are
+		 *  here, something is wrong.
+		 */
+		dm_put_live_table(md, srcu_idx);
+		goto out;
+	}
+	ret = ti->type->dax_zero_page_range(ti, offset, len);
+
+ out:
+	dm_put_live_table(md, srcu_idx);
+
+	return ret;
+}
+
 /*
  * A target may call dm_accept_partial_bio only from the map routine.  It is
  * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_RESET,
@@ -3199,6 +3229,7 @@ static const struct dax_operations dm_dax_ops = {
 	.dax_supported = dm_dax_supported,
 	.copy_from_iter = dm_dax_copy_from_iter,
 	.copy_to_iter = dm_dax_copy_to_iter,
+	.zero_page_range = dm_dax_zero_page_range,
 };
 
 /*
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 475668c69dbc..b4ef5b07be74 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -141,6 +141,8 @@ typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn);
 typedef size_t (*dm_dax_copy_iter_fn)(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i);
+typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, u64 offset,
+		size_t len);
 #define PAGE_SECTORS (PAGE_SIZE / 512)
 
 void dm_error(const char *message);
@@ -195,6 +197,7 @@ struct target_type {
 	dm_dax_direct_access_fn direct_access;
 	dm_dax_copy_iter_fn dax_copy_from_iter;
 	dm_dax_copy_iter_fn dax_copy_to_iter;
+	dm_dax_zero_page_range_fn dax_zero_page_range;
 
 	/* For internal device-mapper use. */
 	struct list_head list;
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
