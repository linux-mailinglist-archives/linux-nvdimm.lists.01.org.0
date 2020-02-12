Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A109415AE26
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Feb 2020 18:08:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5700610FC3385;
	Wed, 12 Feb 2020 09:11:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 315F210FC3170
	for <linux-nvdimm@lists.01.org>; Wed, 12 Feb 2020 09:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581527284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFXOBK5kg+//3C1Cq5RJK/z4kqT5swnlhwxFrx47y84=;
	b=fais9dnFIufZPu49DWXnNHpwnAiSgOsB8/0CyMufSdBL4vQh57qPVROZqn4W5s469gPq1u
	qifgpBsareelXTdFy/FbNSar7+KfoqJR8C9ShQs7IIr8PinvrZaDsVuX0J/zX1qag9TY+t
	mX3mD7GqeoR25MBmjp/y5nSTTTjLyjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-mUGUErWkMiihwvXwGDO0Wg-1; Wed, 12 Feb 2020 12:07:54 -0500
X-MC-Unique: mUGUErWkMiihwvXwGDO0Wg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8EF5107ACCA;
	Wed, 12 Feb 2020 17:07:52 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 200F15D9E2;
	Wed, 12 Feb 2020 17:07:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id CAEF32257D8; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com,
	hch@infradead.org
Subject: [PATCH 6/6] dax: Remove bdev_dax_pgoff() helper
Date: Wed, 12 Feb 2020 12:07:33 -0500
Message-Id: <20200212170733.8092-7-vgoyal@redhat.com>
In-Reply-To: <20200212170733.8092-1-vgoyal@redhat.com>
References: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: VDYMQFC6LH4N3U42OUOGQS5PG762O4X4
X-Message-ID-Hash: VDYMQFC6LH4N3U42OUOGQS5PG762O4X4
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VDYMQFC6LH4N3U42OUOGQS5PG762O4X4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Now there don't seem to be anyuser of bdev_dax_pgoff(). All users have been
moved to dax_pgoff(). So remove this helper.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/dax/super.c | 13 -------------
 include/linux/dax.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index ee35ecc61545..371e391e6b1e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -43,19 +43,6 @@ EXPORT_SYMBOL_GPL(dax_read_unlock);
 #ifdef CONFIG_BLOCK
 #include <linux/blkdev.h>
 
-int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
-		pgoff_t *pgoff)
-{
-	phys_addr_t phys_off = (get_start_sect(bdev) + sector) * 512;
-
-	if (pgoff)
-		*pgoff = PHYS_PFN(phys_off);
-	if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
-		return -EINVAL;
-	return 0;
-}
-EXPORT_SYMBOL(bdev_dax_pgoff);
-
 int dax_pgoff(sector_t dax_offset, sector_t sector, size_t size, pgoff_t *pgoff)
 {
 	phys_addr_t phys_off = (dax_offset + sector) * 512;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 5101a4b5c1f9..84ed0e993190 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -110,7 +110,6 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 #endif
 
 struct writeback_control;
-int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
 int dax_pgoff(sector_t dax_offset, sector_t, size_t, pgoff_t *pgoff);
 #if IS_ENABLED(CONFIG_FS_DAX)
 bool __bdev_dax_supported(struct block_device *bdev, int blocksize);
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
