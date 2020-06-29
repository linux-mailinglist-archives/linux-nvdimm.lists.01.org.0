Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5386B20D5A3
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 21:40:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6D350111F370E;
	Mon, 29 Jun 2020 12:40:21 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7CBF3111C7C50
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 12:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=x/Lapiju/RCIeWIuz3o8sd6pkgFSKFSdWu2H7EUGYIE=; b=O9wCb3jp0iCF1CzuvdGMrrLzoB
	hUmM9g2VqtcNKR8cGfEwWvKwAuWyep1dCkN1TGIV6QFphRYIt2ecSV1/ZQtbW+fS7r3iCmyAbN5me
	x371kR78nTdJ8F38UoZxUFoO+t2KRh7aPoJEcdv3emVhv+ywJ1JWZOU4zoGpuqprHCnoiyUOgRPKp
	4frQBv8ziD+bikS/0M0ZAvAvo4amoKm9b9JV2ml9PXsCnOZjCsh8saZP7ylX/hR6jVbLLYLpMldWs
	Kx8wmm37ZbimiGJQEhj6VYGKYeoaROtCQL/LkVXhbVLbE7JrAyT+OD1jFrH6yRio4V89SD6rsVIUg
	qU3nOTnQ==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzdG-0004Fv-Mp; Mon, 29 Jun 2020 19:39:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/20] ps3vram: stop using ->queuedata
Date: Mon, 29 Jun 2020 21:39:32 +0200
Message-Id: <20200629193947.2705954-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: NKRYA643D5H4PFFNORDGNCOK3G2JH5RE
X-Message-ID-Hash: NKRYA643D5H4PFFNORDGNCOK3G2JH5RE
X-MailFrom: BATV+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NKRYA643D5H4PFFNORDGNCOK3G2JH5RE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Instead of setting up the queuedata as well just use one private data
field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ps3vram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 821d4d8b1d763e..5a1d1d137c7248 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -587,7 +587,7 @@ static struct bio *ps3vram_do_bio(struct ps3_system_bus_device *dev,
 
 static blk_qc_t ps3vram_make_request(struct request_queue *q, struct bio *bio)
 {
-	struct ps3_system_bus_device *dev = q->queuedata;
+	struct ps3_system_bus_device *dev = bio->bi_disk->private_data;
 	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	int busy;
 
@@ -745,7 +745,6 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 	}
 
 	priv->queue = queue;
-	queue->queuedata = dev;
 	blk_queue_max_segments(queue, BLK_MAX_SEGMENTS);
 	blk_queue_max_segment_size(queue, BLK_MAX_SEGMENT_SIZE);
 	blk_queue_max_hw_sectors(queue, BLK_SAFE_MAX_SECTORS);
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
