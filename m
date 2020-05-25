Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D16211E0D20
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 May 2020 13:31:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B0381221A1C2;
	Mon, 25 May 2020 04:27:14 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+ab9bb8b38cf50d3a9241+6119+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 065A11221A1C2
	for <linux-nvdimm@lists.01.org>; Mon, 25 May 2020 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4IXSrzF0DpdIQO5rnizUXwGVEZpXEBJnyHbP5aJAwuk=; b=lE+diA/tjTtgoCEqmasbvPGnOv
	pox14hYjAwC5xmAd6DqWLaaq47eFX6QKLSUPgMNqwSy0m960zOgOHildrpDDIipUhN5VQILka3NOx
	LmDz4W6SdgBU8cx3skeGyHQ1Wa30V3oZioLLne6zOVYBIPXFx/U6RTXFFy+pnIBHrtfejNmyA6LlT
	boJdOj6CqDm4fryFrrfMRbMlwM1RSSt28CN+rks9d6X4pm6eZ1qqky+AsK8NegjJB/jxtlt1h5vY+
	DOmNuovzfq3IhxrPsvY9eGVz7rDb0cIuGvZWFuBx3tW1PmsViLRODDhfb3AcK95XwnTYp3GTlPQuB
	edZWMJzA==;
Received: from [2001:4bb8:18c:5da7:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdBJw-0002cF-Pu; Mon, 25 May 2020 11:31:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/16] block: reduce part_stat_lock() scope
Date: Mon, 25 May 2020 13:30:14 +0200
Message-Id: <20200525113014.345997-17-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525113014.345997-1-hch@lst.de>
References: <20200525113014.345997-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: ADQ5AQBVQVAUVEIIMKK3RSYLLKYS2E6J
X-Message-ID-Hash: ADQ5AQBVQVAUVEIIMKK3RSYLLKYS2E6J
X-MailFrom: BATV+ab9bb8b38cf50d3a9241+6119+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ADQ5AQBVQVAUVEIIMKK3RSYLLKYS2E6J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We only need the stats lock (aka preempt_disable()) for updating the
states, not for looking up or dropping the hd_struct reference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c  | 5 +++--
 block/blk-merge.c | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bf2f7d4bc0c1c..a01fb2b508f0e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1437,9 +1437,9 @@ void blk_account_io_done(struct request *req, u64 now)
 		update_io_ticks(part, jiffies, true);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
+		part_stat_unlock();
 
 		hd_struct_put(part);
-		part_stat_unlock();
 	}
 }
 
@@ -1448,8 +1448,9 @@ void blk_account_io_start(struct request *rq)
 	if (!blk_do_io_stat(rq))
 		return;
 
-	part_stat_lock();
 	rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
+
+	part_stat_lock();
 	update_io_ticks(rq->part, jiffies, false);
 	part_stat_unlock();
 }
diff --git a/block/blk-merge.c b/block/blk-merge.c
index c3beae5c1be71..f0b0bae075a0c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -674,8 +674,9 @@ static void blk_account_io_merge_request(struct request *req)
 	if (blk_do_io_stat(req)) {
 		part_stat_lock();
 		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
-		hd_struct_put(req->part);
 		part_stat_unlock();
+
+		hd_struct_put(req->part);
 	}
 }
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
