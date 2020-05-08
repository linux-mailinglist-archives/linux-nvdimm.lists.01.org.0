Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D560F1CB4A5
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 May 2020 18:16:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E22FC1186988B;
	Fri,  8 May 2020 09:14:10 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+ade674efe42abf9194a0+6102+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3944A11887082
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xqUmHHy02koBEfSFWiUuHH2Y6nKAt/nZw4u/FVTv6zk=; b=BxJHu15IRW004JkxZY/KyYHUej
	74WLt+f/xjeWE/ehYrxDrBGRkkA//dnglHTvVOgtDoQzzOQKY1dyKm9LHMP9Eb4fGadhIpgkIojYI
	eUfKgVHrl9kbrdlcLpUqFRRrfnuJtQpdCIZOhmcoS+uShMnTu3r0x49dNbVwuLCKdArfz18AzF3RP
	cMF64rqnSdOmJClYev0alieJ13GC0i+TG8Fll/eotlYw7azmblEgoldOFuS3A1QUypcphrVGe4QCM
	Pu8SNC///ni4n5Z91Bl8/8JHT/Tow1csQjCnGXVp4YKgmxEo6KAjYrayvew3Qyg7WLowVbYI96tnF
	5JHSr8DA==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jX5fP-0004p9-Aa; Fri, 08 May 2020 16:16:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/15] nvdimm/btt: stop using ->queuedata
Date: Fri,  8 May 2020 18:15:16 +0200
Message-Id: <20200508161517.252308-15-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508161517.252308-1-hch@lst.de>
References: <20200508161517.252308-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: 24PFLKOKDQFRAZYWALXISEPIDBX6ZURQ
X-Message-ID-Hash: 24PFLKOKDQFRAZYWALXISEPIDBX6ZURQ
X-MailFrom: BATV+ade674efe42abf9194a0+6102+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>, Joshua Morris <josh.h.morris@us.ibm.com>, Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/24PFLKOKDQFRAZYWALXISEPIDBX6ZURQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvdimm/btt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3b09419218d6f..eca3e48fefda1 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1442,7 +1442,7 @@ static int btt_do_bvec(struct btt *btt, struct bio_integrity_payload *bip,
 static blk_qc_t btt_make_request(struct request_queue *q, struct bio *bio)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
-	struct btt *btt = q->queuedata;
+	struct btt *btt = bio->bi_disk->private_data;
 	struct bvec_iter iter;
 	unsigned long start;
 	struct bio_vec bvec;
@@ -1543,7 +1543,6 @@ static int btt_blk_init(struct btt *btt)
 	blk_queue_logical_block_size(btt->btt_queue, btt->sector_size);
 	blk_queue_max_hw_sectors(btt->btt_queue, UINT_MAX);
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, btt->btt_queue);
-	btt->btt_queue->queuedata = btt;
 
 	if (btt_meta_size(btt)) {
 		int rc = nd_integrity_init(btt->btt_disk, btt_meta_size(btt));
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
