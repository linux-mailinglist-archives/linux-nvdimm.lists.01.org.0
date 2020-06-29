Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C8F20D5A1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 21:40:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D1CC111F3707;
	Mon, 29 Jun 2020 12:40:19 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 336DE111B33D6
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=KYQPEhMrWwbjunajTA0tfrHgAEeVrpu9W222AN41VOw=; b=issiWcVcE17rTXmc/emvZD3eU6
	jUfqFX9yWi33QJVwNQeR+afNEP+LekYRpvYkthsYMa1a8Yu7FI3nAO0YArSteyHbLZmgZWUyasS0v
	LBHBv2oANz+Tpo/dhdp2qOFdN28GZvbxKtroCwuKozpo6kyW2ncugiXtpeEBJncpnUHLQ545MRMKX
	3RQc6lcNRw7+0xkawJY+p0gEJZR/SKfS+LPhz5fU0kYnZAGAHX5xscHtJTWOVUpvh3kO/7+0AGkEl
	+wQg6H27UfZ39ULPAmNtial/bGcKcS15zOGxvFnUKMEY3l3Kd23P9THR9KMB3a4ELRWQvnj+fSolb
	MhJ0MnxQ==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzdE-0004FI-Vs; Mon, 29 Jun 2020 19:39:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/20] null_blk: stop using ->queuedata for bio mode
Date: Mon, 29 Jun 2020 21:39:31 +0200
Message-Id: <20200629193947.2705954-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: BURV6UTFEMOC4ARMWVDY4R4WNK5JW5RK
X-Message-ID-Hash: BURV6UTFEMOC4ARMWVDY4R4WNK5JW5RK
X-MailFrom: BATV+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BURV6UTFEMOC4ARMWVDY4R4WNK5JW5RK/>
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
 drivers/block/null_blk_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 82259242b9b5c9..93ce0a00b2ae01 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1392,7 +1392,7 @@ static blk_qc_t null_queue_bio(struct request_queue *q, struct bio *bio)
 {
 	sector_t sector = bio->bi_iter.bi_sector;
 	sector_t nr_sectors = bio_sectors(bio);
-	struct nullb *nullb = q->queuedata;
+	struct nullb *nullb = bio->bi_disk->private_data;
 	struct nullb_queue *nq = nullb_to_queue(nullb);
 	struct nullb_cmd *cmd;
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
