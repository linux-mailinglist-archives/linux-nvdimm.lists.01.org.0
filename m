Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B91E37E2
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 07:24:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3C0481225F265;
	Tue, 26 May 2020 22:20:27 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 37A231225F262
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 22:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5LFbl+1u6fs2VTDnFYoFyNCkVgiJa2DLTkAp8608ZsA=; b=G4zCBkuASjNCa2c9rwAHr+qPGJ
	S54mjipGj/5FyoDo9F3/S2qB8tzO1JnuOooR4zK3y32G0eReFUe5pDoK80zFo0JDNXZ0HlA1LQ4a7
	gXwOCnEZbPB0ddpfEt+vQd5KVgIB5e+bCSN1Y8Pwsw4ir+78kr02g38dlAPh99dzMbIEK2SmdrN9w
	IaaRhEnyO+MQjZuJjOCDkyHRnu9unuZ1J+rYFfYz8TKzmMzgjwGOnWIwyEWbAi2g41p3BIENpcpWr
	HQt+IB7TqWP18nEU295n/1n44IN/9n+QlWYvb+vfjTYxFrrxIla1qE6+k9WuPAIabcOFpL1QTqTyQ
	AZIAEM0Q==;
Received: from [2001:4bb8:18c:5da7:8164:affc:3c20:853d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdoYF-0000nC-4j; Wed, 27 May 2020 05:24:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/16] drbd: use bio_{start,end}_io_acct
Date: Wed, 27 May 2020 07:24:05 +0200
Message-Id: <20200527052419.403583-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527052419.403583-1-hch@lst.de>
References: <20200527052419.403583-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: 6TRBBQEBKL3WPTA2TJRUMQOKWTZ33MQY
X-Message-ID-Hash: 6TRBBQEBKL3WPTA2TJRUMQOKWTZ33MQY
X-MailFrom: BATV+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6TRBBQEBKL3WPTA2TJRUMQOKWTZ33MQY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Switch drbd to use the nicer bio accounting helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/block/drbd/drbd_req.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 840c3aef3c5c9..c80a2f1c3c2a7 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -21,24 +21,6 @@
 
 static bool drbd_may_do_local_read(struct drbd_device *device, sector_t sector, int size);
 
-/* Update disk stats at start of I/O request */
-static void _drbd_start_io_acct(struct drbd_device *device, struct drbd_request *req)
-{
-	struct request_queue *q = device->rq_queue;
-
-	generic_start_io_acct(q, bio_op(req->master_bio),
-				req->i.size >> 9, &device->vdisk->part0);
-}
-
-/* Update disk stats when completing request upwards */
-static void _drbd_end_io_acct(struct drbd_device *device, struct drbd_request *req)
-{
-	struct request_queue *q = device->rq_queue;
-
-	generic_end_io_acct(q, bio_op(req->master_bio),
-			    &device->vdisk->part0, req->start_jif);
-}
-
 static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio *bio_src)
 {
 	struct drbd_request *req;
@@ -263,7 +245,7 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 		start_new_tl_epoch(first_peer_device(device)->connection);
 
 	/* Update disk stats */
-	_drbd_end_io_acct(device, req);
+	bio_end_io_acct(req->master_bio, req->start_jif);
 
 	/* If READ failed,
 	 * have it be pushed back to the retry work queue,
@@ -1222,16 +1204,15 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio, unsigned long
 		bio_endio(bio);
 		return ERR_PTR(-ENOMEM);
 	}
-	req->start_jif = start_jif;
+
+	/* Update disk stats */
+	req->start_jif = bio_start_io_acct(req->master_bio);
 
 	if (!get_ldev(device)) {
 		bio_put(req->private_bio);
 		req->private_bio = NULL;
 	}
 
-	/* Update disk stats */
-	_drbd_start_io_acct(device, req);
-
 	/* process discards always from our submitter thread */
 	if (bio_op(bio) == REQ_OP_WRITE_ZEROES ||
 	    bio_op(bio) == REQ_OP_DISCARD)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
