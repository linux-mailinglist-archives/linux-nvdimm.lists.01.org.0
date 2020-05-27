Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DC21E37E3
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 07:24:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 51F891225F266;
	Tue, 26 May 2020 22:20:32 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C00681225F26A
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 22:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BoE9LPw2oUO3NHvNjCZuG9y6ne8/lIjQVC7yN88KH00=; b=au7HokE0bZOtEUIYi9XKtdmXJh
	iILFYm6nSw4YwEgYmqWTci3irvj6mGEu0DIOyoOLaZBJyQYGhxSVuuKNsaWqlWe0RIKauXSfrRBqE
	IvNdBZ5NNmeuUaIMQvVMRdzITUPU9BltNAHbol/EHeS1+TUcfMNOnvcHBpK1UspVIum+bX8Oqnv8O
	HrovPzyj17VacYYIiWjIJmULkhYr6pOri2dEv837UAOnlQAcOPbfIF5YlFuuhCFf9GiNj0B2FTBss
	cVNMAZoff+zoSDx1GMWkM+iNBbm0jZnHF9MWPOhXzlZf21SnmYJ6THHJVZpm7FTr5Ks3pOKtiCp+X
	q0iuPy3A==;
Received: from [2001:4bb8:18c:5da7:8164:affc:3c20:853d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdoYI-0000nL-5P; Wed, 27 May 2020 05:24:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/16] rsxx: use bio_{start,end}_io_acct
Date: Wed, 27 May 2020 07:24:06 +0200
Message-Id: <20200527052419.403583-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527052419.403583-1-hch@lst.de>
References: <20200527052419.403583-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: NRVPQIHIPO7NYPN7T7F3P3A4E56ZZWHU
X-Message-ID-Hash: NRVPQIHIPO7NYPN7T7F3P3A4E56ZZWHU
X-MailFrom: BATV+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NRVPQIHIPO7NYPN7T7F3P3A4E56ZZWHU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Switch rsxx to use the nicer bio accounting helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/block/rsxx/dev.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index 8ffa8260dcafe..3ba07ab30c84f 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -96,20 +96,6 @@ static const struct block_device_operations rsxx_fops = {
 	.ioctl		= rsxx_blkdev_ioctl,
 };
 
-static void disk_stats_start(struct rsxx_cardinfo *card, struct bio *bio)
-{
-	generic_start_io_acct(card->queue, bio_op(bio), bio_sectors(bio),
-			     &card->gendisk->part0);
-}
-
-static void disk_stats_complete(struct rsxx_cardinfo *card,
-				struct bio *bio,
-				unsigned long start_time)
-{
-	generic_end_io_acct(card->queue, bio_op(bio),
-			    &card->gendisk->part0, start_time);
-}
-
 static void bio_dma_done_cb(struct rsxx_cardinfo *card,
 			    void *cb_data,
 			    unsigned int error)
@@ -121,7 +107,7 @@ static void bio_dma_done_cb(struct rsxx_cardinfo *card,
 
 	if (atomic_dec_and_test(&meta->pending_dmas)) {
 		if (!card->eeh_state && card->gendisk)
-			disk_stats_complete(card, meta->bio, meta->start_time);
+			bio_end_io_acct(meta->bio, meta->start_time);
 
 		if (atomic_read(&meta->error))
 			bio_io_error(meta->bio);
@@ -167,10 +153,9 @@ static blk_qc_t rsxx_make_request(struct request_queue *q, struct bio *bio)
 	bio_meta->bio = bio;
 	atomic_set(&bio_meta->error, 0);
 	atomic_set(&bio_meta->pending_dmas, 0);
-	bio_meta->start_time = jiffies;
 
 	if (!unlikely(card->halt))
-		disk_stats_start(card, bio);
+		bio_meta->start_time = bio_start_io_acct(bio);
 
 	dev_dbg(CARD_TO_DEV(card), "BIO[%c]: meta: %p addr8: x%llx size: %d\n",
 		 bio_data_dir(bio) ? 'W' : 'R', bio_meta,
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
