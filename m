Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F115AE23
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Feb 2020 18:08:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3CC9510FC338F;
	Wed, 12 Feb 2020 09:11:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3801C10FC317F
	for <linux-nvdimm@lists.01.org>; Wed, 12 Feb 2020 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581527277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QSDN4zqZX6JQThUAoXPpSXd0mGJ9FYDGlAgc1x+IyE=;
	b=BIeKNJE9IH21MlTFoU8IdIDKPcwHbeI0WbdzAR6xD2Vf7bcsWaUkM4t/nTX+M8ykSagalO
	wwF79z5PFVHeLR8CuBnZDAGyvPJtouL6cAZNNa+4ARyMhgfBeTbgJTQPN7XZBw+dIyJeRP
	uKOWXOf5rv0wNGekUchZ65qbLnyTXuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-k3JbxwhlOA2CwoxrbWTETw-1; Wed, 12 Feb 2020 12:07:51 -0500
X-MC-Unique: k3JbxwhlOA2CwoxrbWTETw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B7008017CC;
	Wed, 12 Feb 2020 17:07:50 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 20668388;
	Wed, 12 Feb 2020 17:07:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id AEE932257D3; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com,
	hch@infradead.org
Subject: [PATCH 1/6] dax: Define a helper dax_pgoff() which takes in dax_offset as argument
Date: Wed, 12 Feb 2020 12:07:28 -0500
Message-Id: <20200212170733.8092-2-vgoyal@redhat.com>
In-Reply-To: <20200212170733.8092-1-vgoyal@redhat.com>
References: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: WY5FSCC57WWVG7YUQQLFWSYOOFE2QTMK
X-Message-ID-Hash: WY5FSCC57WWVG7YUQQLFWSYOOFE2QTMK
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WY5FSCC57WWVG7YUQQLFWSYOOFE2QTMK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Create a new helper dax_pgoff() which will replace bdev_dax_pgoff(). Difference
between two is that dax_pgoff() takes in "sector_t dax_offset" as an argument
instead of "struct block_device".

dax_offset specifies any offset into dax device which should be added to
sector while calculating pgoff.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/dax/super.c | 12 ++++++++++++
 include/linux/dax.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0aa4b6bc5101..e9daa30e4250 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -56,6 +56,18 @@ int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
 }
 EXPORT_SYMBOL(bdev_dax_pgoff);
 
+int dax_pgoff(sector_t dax_offset, sector_t sector, size_t size, pgoff_t *pgoff)
+{
+	phys_addr_t phys_off = (dax_offset + sector) * 512;
+
+	if (pgoff)
+		*pgoff = PHYS_PFN(phys_off);
+	if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(dax_pgoff);
+
 #if IS_ENABLED(CONFIG_FS_DAX)
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 328c2dbb4409..5101a4b5c1f9 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -111,6 +111,7 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 
 struct writeback_control;
 int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
+int dax_pgoff(sector_t dax_offset, sector_t, size_t, pgoff_t *pgoff);
 #if IS_ENABLED(CONFIG_FS_DAX)
 bool __bdev_dax_supported(struct block_device *bdev, int blocksize);
 static inline bool bdev_dax_supported(struct block_device *bdev, int blocksize)
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
