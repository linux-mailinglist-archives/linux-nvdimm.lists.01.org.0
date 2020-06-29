Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BA820D5B0
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 21:40:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE73E11202ACD;
	Mon, 29 Jun 2020 12:40:43 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8372D111B33D1
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pbP8zrg1Y/6opjqaCVyxx2r08m87DrQRXDirr0/HxNM=; b=B5xniw6N/Ks7z1YpV9+yP7BXgn
	5/pt5gaOOQx1f+3IVHDShmbIhdOMyl+IqVmfsLvHrGZwPWhicBoYVvKMhbSkKNmJwYZiIbMHvUk8+
	HbPDCb0Fvrlz4Q+puZk56OottxxAouTYgeaAczW0j8mNOpkqybQrK8MQUVcYtMHe8yNOf23xKnzCQ
	e4OWuYvaiTUPpmUL3pzJlcYTPZI/nHHF7e/0x19bs3VTQ9x7NudNjRAcGPpGvK6Paiw+QBC6d/+2B
	1unQ9QEgUyCUCwzriHLFslP9rfHfgngtd8yULGxrxxc6O5rgKKG1mRvnlDse+mGQk+VIk4lR5YfSE
	xk+2C9WQ==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzdi-0004Ou-F4; Mon, 29 Jun 2020 19:40:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/20] block: refator submit_bio_noacct
Date: Mon, 29 Jun 2020 21:39:45 +0200
Message-Id: <20200629193947.2705954-19-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: 2CRIAEDKJVOZTZQPMNXEFTL4XOW6LDBW
X-Message-ID-Hash: 2CRIAEDKJVOZTZQPMNXEFTL4XOW6LDBW
X-MailFrom: BATV+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2CRIAEDKJVOZTZQPMNXEFTL4XOW6LDBW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Split out a __submit_bio_noacct helper for the actual de-recursion
algorithm, and simplify the loop by using a continue when we can't
enter the queue for a bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 131 +++++++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 60 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1caeb01e127768..b82f48c86e6f7a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1085,6 +1085,74 @@ static blk_qc_t do_make_request(struct bio *bio)
 	return ret;
 }
 
+/*
+ * The loop in this function may be a bit non-obvious, and so deserves some
+ * explanation:
+ *
+ *  - Before entering the loop, bio->bi_next is NULL (as all callers ensure
+ *    that), so we have a list with a single bio.
+ *  - We pretend that we have just taken it off a longer list, so we assign
+ *    bio_list to a pointer to the bio_list_on_stack, thus initialising the
+ *    bio_list of new bios to be added.  ->submit_bio() may indeed add some more
+ *    bios through a recursive call to submit_bio_noacct.  If it did, we find a
+ *    non-NULL value in bio_list and re-enter the loop from the top.
+ *  - In this case we really did just take the bio of the top of the list (no
+ *    pretending) and so remove it from bio_list, and call into ->submit_bio()
+ *    again.
+ *
+ * bio_list_on_stack[0] contains bios submitted by the current ->submit_bio.
+ * bio_list_on_stack[1] contains bios that were submitted before the current
+ *	->submit_bio_bio, but that haven't been processed yet.
+ */
+static blk_qc_t __submit_bio_noacct(struct bio *bio)
+{
+	struct bio_list bio_list_on_stack[2];
+	blk_qc_t ret = BLK_QC_T_NONE;
+
+	BUG_ON(bio->bi_next);
+
+	bio_list_init(&bio_list_on_stack[0]);
+	current->bio_list = bio_list_on_stack;
+
+	do {
+		struct request_queue *q = bio->bi_disk->queue;
+		struct bio_list lower, same;
+
+		if (unlikely(bio_queue_enter(bio) != 0))
+			continue;
+
+		/*
+		 * Create a fresh bio_list for all subordinate requests.
+		 */
+		bio_list_on_stack[1] = bio_list_on_stack[0];
+		bio_list_init(&bio_list_on_stack[0]);
+
+		ret = do_make_request(bio);
+
+		/*
+		 * Sort new bios into those for a lower level and those for the
+		 * same level.
+		 */
+		bio_list_init(&lower);
+		bio_list_init(&same);
+		while ((bio = bio_list_pop(&bio_list_on_stack[0])) != NULL)
+			if (q == bio->bi_disk->queue)
+				bio_list_add(&same, bio);
+			else
+				bio_list_add(&lower, bio);
+
+		/*
+		 * Now assemble so we handle the lowest level first.
+		 */
+		bio_list_merge(&bio_list_on_stack[0], &lower);
+		bio_list_merge(&bio_list_on_stack[0], &same);
+		bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
+	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
+
+	current->bio_list = NULL;
+	return ret;
+}
+
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -1096,17 +1164,8 @@ static blk_qc_t do_make_request(struct bio *bio)
  */
 blk_qc_t submit_bio_noacct(struct bio *bio)
 {
-	/*
-	 * bio_list_on_stack[0] contains bios submitted by the current
-	 * ->submit_bio.
-	 * bio_list_on_stack[1] contains bios that were submitted before the
-	 * current ->submit_bio_bio, but that haven't been processed yet.
-	 */
-	struct bio_list bio_list_on_stack[2];
-	blk_qc_t ret = BLK_QC_T_NONE;
-
 	if (!submit_bio_checks(bio))
-		goto out;
+		return BLK_QC_T_NONE;
 
 	/*
 	 * We only want one ->submit_bio to be active at a time, else
@@ -1120,58 +1179,10 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 	 */
 	if (current->bio_list) {
 		bio_list_add(&current->bio_list[0], bio);
-		goto out;
+		return BLK_QC_T_NONE;
 	}
 
-	/* following loop may be a bit non-obvious, and so deserves some
-	 * explanation.
-	 * Before entering the loop, bio->bi_next is NULL (as all callers
-	 * ensure that) so we have a list with a single bio.
-	 * We pretend that we have just taken it off a longer list, so
-	 * we assign bio_list to a pointer to the bio_list_on_stack,
-	 * thus initialising the bio_list of new bios to be
-	 * added.  ->submit_bio() may indeed add some more bios
-	 * through a recursive call to submit_bio_noacct.  If it
-	 * did, we find a non-NULL value in bio_list and re-enter the loop
-	 * from the top.  In this case we really did just take the bio
-	 * of the top of the list (no pretending) and so remove it from
-	 * bio_list, and call into ->submit_bio() again.
-	 */
-	BUG_ON(bio->bi_next);
-	bio_list_init(&bio_list_on_stack[0]);
-	current->bio_list = bio_list_on_stack;
-	do {
-		struct request_queue *q = bio->bi_disk->queue;
-
-		if (likely(bio_queue_enter(bio) == 0)) {
-			struct bio_list lower, same;
-
-			/* Create a fresh bio_list for all subordinate requests */
-			bio_list_on_stack[1] = bio_list_on_stack[0];
-			bio_list_init(&bio_list_on_stack[0]);
-			ret = do_make_request(bio);
-
-			/* sort new bios into those for a lower level
-			 * and those for the same level
-			 */
-			bio_list_init(&lower);
-			bio_list_init(&same);
-			while ((bio = bio_list_pop(&bio_list_on_stack[0])) != NULL)
-				if (q == bio->bi_disk->queue)
-					bio_list_add(&same, bio);
-				else
-					bio_list_add(&lower, bio);
-			/* now assemble so we handle the lowest level first */
-			bio_list_merge(&bio_list_on_stack[0], &lower);
-			bio_list_merge(&bio_list_on_stack[0], &same);
-			bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
-		}
-		bio = bio_list_pop(&bio_list_on_stack[0]);
-	} while (bio);
-	current->bio_list = NULL; /* deactivate */
-
-out:
-	return ret;
+	return __submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
