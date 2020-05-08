Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B41CB4A4
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 May 2020 18:16:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9801111887098;
	Fri,  8 May 2020 09:14:06 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+ade674efe42abf9194a0+6102+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7B35311887098
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rZtsV1PDBMttxVZ0UQKr9n1WRMbI8yQyqdUS8peoGRI=; b=lwbrDiZRTLg37IrLiDUB1xU6OB
	XQ5Yja7qHRUxU0W9ZWUn/ofYF/eNcFQEGhja1Sno6TfsoqgdOxl36hEOZBaMPzBztAndx4GWjnlFw
	ftI0M9CJzMZ7ZbReKJapBuhwamtRkaGgCNvVlT4GREU3byg+o0mo4BLbfbSJZwpYLvAW5AGuHkSmw
	IbVlPxX1BVr1XMNjcXOKVht9vSCLQD/E+FykqUvb7pBxc+gb0ZA/st2VP9Bu0mTIbFoQ2iJNgZpN1
	3Q1aZzgQ82hMy8J9tYWVlKyEFGz/MNiDE01wdHaBJ628HjW1z6HvjLHdwq8UIEHfpdeXqrN5ixxkg
	ToFrPouQ==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jX5fM-0004oE-Ap; Fri, 08 May 2020 16:16:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/15] nvdimm/blk: stop using ->queuedata
Date: Fri,  8 May 2020 18:15:15 +0200
Message-Id: <20200508161517.252308-14-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508161517.252308-1-hch@lst.de>
References: <20200508161517.252308-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: UXI67FFO4EZL5CNBYS7A56GKI3JYUUXR
X-Message-ID-Hash: UXI67FFO4EZL5CNBYS7A56GKI3JYUUXR
X-MailFrom: BATV+ade674efe42abf9194a0+6102+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>, Joshua Morris <josh.h.morris@us.ibm.com>, Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UXI67FFO4EZL5CNBYS7A56GKI3JYUUXR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvdimm/blk.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 43751fab9d36a..ffe4728bad8b1 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -165,7 +165,7 @@ static int nsblk_do_bvec(struct nd_namespace_blk *nsblk,
 static blk_qc_t nd_blk_make_request(struct request_queue *q, struct bio *bio)
 {
 	struct bio_integrity_payload *bip;
-	struct nd_namespace_blk *nsblk;
+	struct nd_namespace_blk *nsblk = bio->bi_disk->private_data;
 	struct bvec_iter iter;
 	unsigned long start;
 	struct bio_vec bvec;
@@ -176,7 +176,6 @@ static blk_qc_t nd_blk_make_request(struct request_queue *q, struct bio *bio)
 		return BLK_QC_T_NONE;
 
 	bip = bio_integrity(bio);
-	nsblk = q->queuedata;
 	rw = bio_data_dir(bio);
 	do_acct = nd_iostat_start(bio, &start);
 	bio_for_each_segment(bvec, bio, iter) {
@@ -258,7 +257,6 @@ static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
 	blk_queue_max_hw_sectors(q, UINT_MAX);
 	blk_queue_logical_block_size(q, nsblk_sector_size(nsblk));
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
-	q->queuedata = nsblk;
 
 	disk = alloc_disk(0);
 	if (!disk)
@@ -268,6 +266,7 @@ static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
 	disk->fops		= &nd_blk_fops;
 	disk->queue		= q;
 	disk->flags		= GENHD_FL_EXT_DEVT;
+	disk->private_data	= nsblk;
 	nvdimm_namespace_disk_name(&nsblk->common, disk->disk_name);
 
 	if (devm_add_action_or_reset(dev, nd_blk_release_disk, disk))
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
