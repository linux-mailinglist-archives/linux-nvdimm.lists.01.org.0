Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F13DF20D5AD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 21:40:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 74D8E111B33D1;
	Mon, 29 Jun 2020 12:40:34 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 558AB111F370E
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=MVPFkWqT27H+EK/gr/8Zgz6Ls+wUfbhG+l5NiS06UDM=; b=cWpKHTPUn3rA32xoo333LDplGG
	/0xAWYcWkkFDjIBXGHO+45kIoIvtpWwTdJKbTnhm3os86dmo4mBSUI/NlHDdmV2gaqavEMZMtq3gr
	M3snlpc+56l3kOCu7MnQN7N8WQWb3nphprLavnWPrBA4mxdkJSQ8Tut/tMvH3ls/uG8kN7J9CITXs
	A7iClohCANn04aASv5Pb/v3HjCVtqEJIIyqmnMeFPQEhuHkV0uuQWfF7wIH1afLqTWPS6uIq2i+kb
	8Tr2FGLqiWdoGJayxvKNyukUZkTuV8pg9R5jKUz7TmEOASWR1oATE02aF8Ax3xwDPyvtVg3FdUUNQ
	Bmg5Q2MA==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzdY-0004MD-RU; Mon, 29 Jun 2020 19:40:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/20] block: remove the nr_sectors variable in generic_make_request_checks
Date: Mon, 29 Jun 2020 21:39:42 +0200
Message-Id: <20200629193947.2705954-16-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: OGPQJNXE2GULCISCDWMM6MINAFDNVL5Q
X-Message-ID-Hash: OGPQJNXE2GULCISCDWMM6MINAFDNVL5Q
X-MailFrom: BATV+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OGPQJNXE2GULCISCDWMM6MINAFDNVL5Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The variable is only used once, so just open code the bio_sector()
there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 37435d0d433564..28f60985dc75cc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -974,7 +974,6 @@ static noinline_for_stack bool
 generic_make_request_checks(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_disk->queue;
-	int nr_sectors = bio_sectors(bio);
 	blk_status_t status = BLK_STS_IOERR;
 
 	might_sleep();
@@ -1007,7 +1006,7 @@ generic_make_request_checks(struct bio *bio)
 	if (op_is_flush(bio->bi_opf) &&
 	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
 		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
-		if (!nr_sectors) {
+		if (!bio_sectors(bio)) {
 			status = BLK_STS_OK;
 			goto end_io;
 		}
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
