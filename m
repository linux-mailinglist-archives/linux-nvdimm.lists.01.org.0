Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E001E37F4
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 07:25:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 648A8122679F1;
	Tue, 26 May 2020 22:20:56 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BB3CB122679F7
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 22:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RoHwY3xPQkQOdyCje9JyMhmjLXPKYVZXj7/LksSFANA=; b=PNKRWR+gtDTWIiBva0Bd7tCn54
	gY3Djeij0cExl4f8R+kq0GVRm/X0QVv2UarGsPXAMFdfwSvRS/9VJ2ibYDPGiZCFu25fj+/umYhDW
	+zm43Na/czKInqfPrjZw2054BbA02h6NTZKpYQLXbKA7NtGb4b8+T0HpSPfgxmmCovRHGEbAbp8C9
	c5JaeAyMWU8PyHMrjodL5JXGjeTr7BvYVfv6di4t01MtnNoo+E1bZ6wqXs0mJV1a9JIYijMfuGoxi
	nY4IsqEJD7I2yt4p/5EDb0epwY0Wa/kTJ1pGc5c32jToB98sWj3VJnhJpzTejbTRPcbdnk4o3F2FU
	4eDsfuwQ==;
Received: from [2001:4bb8:18c:5da7:8164:affc:3c20:853d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdoYk-0000tw-MF; Wed, 27 May 2020 05:24:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/16] block: add a blk_account_io_merge_bio helper
Date: Wed, 27 May 2020 07:24:16 +0200
Message-Id: <20200527052419.403583-14-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527052419.403583-1-hch@lst.de>
References: <20200527052419.403583-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: GKWKLZSFLGP37NZXJWODG4BSCJAKSNP7
X-Message-ID-Hash: GKWKLZSFLGP37NZXJWODG4BSCJAKSNP7
X-MailFrom: BATV+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GKWKLZSFLGP37NZXJWODG4BSCJAKSNP7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Move the non-"new_io" branch of blk_account_io_start() into separate
function.  Fix merge accounting for discards (they were counted as write
merges).

The new blk_account_io_merge_bio() doesn't call update_io_ticks() unlike
blk_account_io_start(), as there is no reason for that.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
[hch: rebased]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 25 ++++++++++++++++---------
 block/blk-exec.c |  2 +-
 block/blk-mq.c   |  2 +-
 block/blk.h      |  2 +-
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c1675d43c2da0..bf2f7d4bc0c1c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -636,6 +636,16 @@ void blk_put_request(struct request *req)
 }
 EXPORT_SYMBOL(blk_put_request);
 
+static void blk_account_io_merge_bio(struct request *req)
+{
+	if (!blk_do_io_stat(req))
+		return;
+
+	part_stat_lock();
+	part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
+	part_stat_unlock();
+}
+
 bool bio_attempt_back_merge(struct request *req, struct bio *bio,
 		unsigned int nr_segs)
 {
@@ -656,7 +666,7 @@ bool bio_attempt_back_merge(struct request *req, struct bio *bio,
 
 	bio_crypt_free_ctx(bio);
 
-	blk_account_io_start(req, false);
+	blk_account_io_merge_bio(req);
 	return true;
 }
 
@@ -682,7 +692,7 @@ bool bio_attempt_front_merge(struct request *req, struct bio *bio,
 
 	bio_crypt_do_front_merge(req, bio);
 
-	blk_account_io_start(req, false);
+	blk_account_io_merge_bio(req);
 	return true;
 }
 
@@ -704,7 +714,7 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 	req->__data_len += bio->bi_iter.bi_size;
 	req->nr_phys_segments = segments + 1;
 
-	blk_account_io_start(req, false);
+	blk_account_io_merge_bio(req);
 	return true;
 no_merge:
 	req_set_nomerge(q, req);
@@ -1329,7 +1339,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 		return BLK_STS_IOERR;
 
 	if (blk_queue_io_stat(q))
-		blk_account_io_start(rq, true);
+		blk_account_io_start(rq);
 
 	/*
 	 * Since we have a scheduler attached on the top device,
@@ -1433,16 +1443,13 @@ void blk_account_io_done(struct request *req, u64 now)
 	}
 }
 
-void blk_account_io_start(struct request *rq, bool new_io)
+void blk_account_io_start(struct request *rq)
 {
 	if (!blk_do_io_stat(rq))
 		return;
 
 	part_stat_lock();
-	if (!new_io)
-		part_stat_inc(rq->part, merges[rq_data_dir(rq)]);
-	else
-		rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
+	rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
 	update_io_ticks(rq->part, jiffies, false);
 	part_stat_unlock();
 }
diff --git a/block/blk-exec.c b/block/blk-exec.c
index e20a852ae432d..85324d53d072f 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -55,7 +55,7 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
 	rq->rq_disk = bd_disk;
 	rq->end_io = done;
 
-	blk_account_io_start(rq, true);
+	blk_account_io_start(rq);
 
 	/*
 	 * don't check dying flag for MQ because the request won't
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cac11945f6023..c606c74463ccd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1822,7 +1822,7 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 	blk_rq_bio_prep(rq, bio, nr_segs);
 	blk_crypto_rq_bio_prep(rq, bio, GFP_NOIO);
 
-	blk_account_io_start(rq, true);
+	blk_account_io_start(rq);
 }
 
 static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk.h b/block/blk.h
index 0ecba2ab383d6..428f7e5d70a86 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -185,7 +185,7 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **same_queue_rq);
 
-void blk_account_io_start(struct request *req, bool new_io);
+void blk_account_io_start(struct request *req);
 void blk_account_io_done(struct request *req, u64 now);
 
 /*
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
