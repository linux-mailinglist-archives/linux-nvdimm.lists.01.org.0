Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C354E2106DD
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jul 2020 11:00:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1273F1143B073;
	Wed,  1 Jul 2020 02:00:10 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+501e1de201b53739768b+6156+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3485C1142B3BE
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jul 2020 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=t6BqkN6Yxn/8o7GWQerTXSXZiT8M8tft7EnhoW3IIiE=; b=hAcTP892NCCovzX2RpSmkixMog
	HbSnGhzmiEi7CnPF5n2sxdgakapG2OHqqw5H6XKqc+ghl6qYzfNMLDnMaO1cBG69NDChGRSYU+UOH
	hQeiL/X6/qDLMAZoZHKVKkAKNRq83YhtRRPLSYV7C+e3TxLyt4WbCjNMs1CVf+mzmrs6yA0IRGK/a
	68kq/4RTXTzlT/aia1gZYh618fXe7Lfwpp2DSJuejMw4sErcKJz3WQY2UbphgLA0imC8+URm/7LX4
	1GYzzIg3zotDYqxd8qFVl4y4yd3DRKsYQunww+RsVy9GpkXOhrWRpW52iSzbH5TZxIHTdqsBscTPV
	u324UHxA==;
Received: from [2001:4bb8:184:76e3:ea38:596b:3e9e:422a] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqYb2-00089D-BO; Wed, 01 Jul 2020 09:00:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/20] zram: stop using ->queuedata
Date: Wed,  1 Jul 2020 10:59:35 +0200
Message-Id: <20200701085947.3354405-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701085947.3354405-1-hch@lst.de>
References: <20200701085947.3354405-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: MQ5MNBQROEPNDQ33C7Z2BYEEOGJT3DH2
X-Message-ID-Hash: MQ5MNBQROEPNDQ33C7Z2BYEEOGJT3DH2
X-MailFrom: BATV+501e1de201b53739768b+6156+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MQ5MNBQROEPNDQ33C7Z2BYEEOGJT3DH2/>
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
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6e2ad90b17a376..0564e3f384089e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1586,7 +1586,7 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
  */
 static blk_qc_t zram_make_request(struct request_queue *queue, struct bio *bio)
 {
-	struct zram *zram = queue->queuedata;
+	struct zram *zram = bio->bi_disk->private_data;
 
 	if (!valid_io_request(zram, bio->bi_iter.bi_sector,
 					bio->bi_iter.bi_size)) {
@@ -1912,7 +1912,6 @@ static int zram_add(void)
 	zram->disk->first_minor = device_id;
 	zram->disk->fops = &zram_devops;
 	zram->disk->queue = queue;
-	zram->disk->queue->queuedata = zram;
 	zram->disk->private_data = zram;
 	snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
