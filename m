Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1A31E37F1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 07:24:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 26EF9122679E3;
	Tue, 26 May 2020 22:20:48 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 68A84122679EF
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 22:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jAURZKlR3wABF7HVZ7jgwwb3T9+sEOkFONnpRICBtxk=; b=b9lpto70CQqiKdI3uzCEpMlbCf
	S0IgWN79A13NXEagh9OH9+Qh+JTDTOeMoPjVIuUNfJiAQ+P7WzUbKwDKQk3vPhbGqHsJrVSk4utl2
	rE2/SU1j43BMRA/XFHmWBPxMeSz9zQ0oiXDhfvPgsGJAMrsPJXTrGLcxfBBf8qGIfJynA3Mobq3E+
	mjfsUtnhu0yeIU4MY49hiV9ahnzRBQyET4zmj6BzzQpIjttHnvEwO+71DYXKl/DaMmQljzKYxd6aJ
	NND9YGXuZ3liozt0LHGnA/lee1fDLPc7pwEf9Q19tbT96+Z0qcD37iWSLoJ4ojAms6K5BNdcZ5fSX
	fU8Jbe+Q==;
Received: from [2001:4bb8:18c:5da7:8164:affc:3c20:853d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdoYb-0000s4-VW; Wed, 27 May 2020 05:24:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/16] block: move update_io_ticks to blk-core.c
Date: Wed, 27 May 2020 07:24:13 +0200
Message-Id: <20200527052419.403583-11-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527052419.403583-1-hch@lst.de>
References: <20200527052419.403583-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: FSK7CKZXLV5G3RGJHME3VDSPXGZ6W74E
X-Message-ID-Hash: FSK7CKZXLV5G3RGJHME3VDSPXGZ6W74E
X-MailFrom: BATV+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FSK7CKZXLV5G3RGJHME3VDSPXGZ6W74E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

All callers are in blk-core.c, so move update_io_ticks over.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/bio.c      | 16 ----------------
 block/blk-core.c | 15 +++++++++++++++
 block/blk.h      |  1 -
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3e89c7b37855a..5235da6434aab 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1376,22 +1376,6 @@ void bio_check_pages_dirty(struct bio *bio)
 	schedule_work(&bio_dirty_work);
 }
 
-void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
-{
-	unsigned long stamp;
-again:
-	stamp = READ_ONCE(part->stamp);
-	if (unlikely(stamp != now)) {
-		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
-			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
-		}
-	}
-	if (part->partno) {
-		part = &part_to_disk(part)->part0;
-		goto again;
-	}
-}
-
 static inline bool bio_remaining_done(struct bio *bio)
 {
 	/*
diff --git a/block/blk-core.c b/block/blk-core.c
index 8973104f88d90..c1675d43c2da0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1381,6 +1381,21 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
 
+static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
+{
+	unsigned long stamp;
+again:
+	stamp = READ_ONCE(part->stamp);
+	if (unlikely(stamp != now)) {
+		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
+			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
+	}
+	if (part->partno) {
+		part = &part_to_disk(part)->part0;
+		goto again;
+	}
+}
+
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
diff --git a/block/blk.h b/block/blk.h
index 5db4ec1e85f7b..bdf5e94467aa2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -344,7 +344,6 @@ void blk_queue_free_zone_bitmaps(struct request_queue *q);
 static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
 #endif
 
-void update_io_ticks(struct hd_struct *part, unsigned long now, bool end);
 struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
 
 int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
