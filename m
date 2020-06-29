Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 761BC20D5A0
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 21:40:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 22165111E7BFD;
	Mon, 29 Jun 2020 12:40:19 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 206CB111B33D6
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nyRpegl2g2GPLIzpDQmlwzdY5HJ2Dd3E7fu8tgbKXsw=; b=Z5WuTv+Do9WG6OUJCMBSyCZ2b5
	O1p4C2SSN/f3xWFbYtIwxeNfomJ8ZEq0SyrbzjwwaJ7XajjWQqbg6ne0HqOCf09DYkGBZuLJ26GaA
	G4PKscydGqFZq4vsVbnE1rTpc8Bo2tVVSK4F1kmA58blASqI3DWTdKKd47m0N+FAS6pL0AtHMv1O6
	IpIMByc9LvubnMGH0kyT3l4+R6otGS/DYqbaIdQnK858+Ds+y29BSNTq2oK2idVCG0GRGtireJqdx
	k6us9hxnXU0NJXpEDVxEYAA+aWE9bCfkF1cFo2a5rw/CqXimrtjmiB9oiY72NmNc0pENv/evP4NX4
	7YEoQNww==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzdD-0004F6-7d; Mon, 29 Jun 2020 19:39:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/20] drbd: stop using ->queuedata
Date: Mon, 29 Jun 2020 21:39:30 +0200
Message-Id: <20200629193947.2705954-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: 7FVYBTQBBAEBXIVFES7FPM52LKVBPGSW
X-Message-ID-Hash: 7FVYBTQBBAEBXIVFES7FPM52LKVBPGSW
X-MailFrom: BATV+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7FVYBTQBBAEBXIVFES7FPM52LKVBPGSW/>
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
 drivers/block/drbd/drbd_main.c | 1 -
 drivers/block/drbd/drbd_req.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 45fbd526c453bc..26f4e0aa7393b4 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2805,7 +2805,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	if (!q)
 		goto out_no_q;
 	device->rq_queue = q;
-	q->queuedata   = device;
 
 	disk = alloc_disk(1);
 	if (!disk)
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index c80a2f1c3c2a73..3f09b2ab977822 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1595,7 +1595,7 @@ void do_submit(struct work_struct *ws)
 
 blk_qc_t drbd_make_request(struct request_queue *q, struct bio *bio)
 {
-	struct drbd_device *device = (struct drbd_device *) q->queuedata;
+	struct drbd_device *device = bio->bi_disk->private_data;
 	unsigned long start_jif;
 
 	blk_queue_split(q, &bio);
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
