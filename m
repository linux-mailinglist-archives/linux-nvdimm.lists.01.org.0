Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB9D1E0D19
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 May 2020 13:30:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CBC731221A1D4;
	Mon, 25 May 2020 04:27:00 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+ab9bb8b38cf50d3a9241+6119+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1475E1221A1D4
	for <linux-nvdimm@lists.01.org>; Mon, 25 May 2020 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Bqhnde9dFznWgi2aGOgRLd+HtchsYvr9PHZmbOGgvm4=; b=QGmVMQ6G27m4FVKtKV6q2jvKMh
	4fDojmxfMVIm7EeLnTbodXPQ/kgC4v+3zX7s+VtqGc/aNeHjfTFd0dejf+YwSDQIQqj0kMyIdhe6/
	bq2RJZmyplRJ5PHCtAIZkqMdneGW0euNDcjr1Tebjxl7TlGVPi/6JVydJjs4dqxiijT5mjjaYYaw2
	dL5TV0U+ISqh7cD6nBFBXNvxlwiEuy/LcVtzJHU/9R73P+EY//nGQD/0Tm87Am7ijP1+elGm72rXH
	QtQDEX7AfDKmbNLHbIGR+nSyzAppQJGVu8VM0MmwYcsrv0n2x2ZSltVBXsA/KXqZfd0sP6lfO7tSi
	Go6yyJ6g==;
Received: from [2001:4bb8:18c:5da7:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdBJk-0002WH-GK; Mon, 25 May 2020 11:30:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/16] block: account merge of two requests
Date: Mon, 25 May 2020 13:30:10 +0200
Message-Id: <20200525113014.345997-13-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525113014.345997-1-hch@lst.de>
References: <20200525113014.345997-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: 2HMAXRH7NIPEOHG6EL2SOWCEN6JGNHNV
X-Message-ID-Hash: 2HMAXRH7NIPEOHG6EL2SOWCEN6JGNHNV
X-MailFrom: BATV+ab9bb8b38cf50d3a9241+6119+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2HMAXRH7NIPEOHG6EL2SOWCEN6JGNHNV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Also rename blk_account_io_merge() into blk_account_io_merge_request() to
distinguish it from merging request and bio.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
[hch: rebased]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6a4538d39efd2..c3beae5c1be71 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -669,18 +669,16 @@ void blk_rq_set_mixed_merge(struct request *rq)
 	rq->rq_flags |= RQF_MIXED_MERGE;
 }
 
-static void blk_account_io_merge(struct request *req)
+static void blk_account_io_merge_request(struct request *req)
 {
 	if (blk_do_io_stat(req)) {
-		struct hd_struct *part;
-
 		part_stat_lock();
-		part = req->part;
-
-		hd_struct_put(part);
+		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
+		hd_struct_put(req->part);
 		part_stat_unlock();
 	}
 }
+
 /*
  * Two cases of handling DISCARD merge:
  * If max_discard_segments > 1, the driver takes every bio
@@ -792,7 +790,7 @@ static struct request *attempt_merge(struct request_queue *q,
 	/*
 	 * 'next' is going away, so update stats accordingly
 	 */
-	blk_account_io_merge(next);
+	blk_account_io_merge_request(next);
 
 	/*
 	 * ownership of bio passed from next to req, return 'next' for
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
