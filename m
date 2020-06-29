Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A7D20D59D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 21:40:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F915111B33DB;
	Mon, 29 Jun 2020 12:40:17 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6FDBE111B33D6
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=mXzFKc+c1347jb3Dn9ppL+M5YgGcOuGfnfqDijAsZ3Y=; b=Ge8U7tfkj6TJq59wba22lmgv3c
	aAemZb5IgwaUNQOae1JEUBdtcswQzq0bY+RkjL+cTiX7JQaRw0wKApdyej6KuRrwQcPRWgxraeMMA
	TRAiHmd4zKY6MICuQtRpDg7hYKpnFjf/7DtIwALc7xQoNLa9rD29+80j1LO021MhBvPwrXo28MZ1f
	ZI3vQ/ibrnOyTsGvTDFTwfsRSh+F2rdsCBmlwhrLDzZmWqXRXzrWeZZDt82bL0P7uOtvcTvpY3l6s
	9SSEQXyks5o5YtnDn26Su7A+VbDq23m/m3Y7zWk8dcBd8mM3rtP2IpU7gNAZDnqWBedx63nIA1Il2
	GyzjCyLQ==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzdB-0004Ez-KW; Mon, 29 Jun 2020 19:39:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/20] simdisk: stop using ->queuedata
Date: Mon, 29 Jun 2020 21:39:29 +0200
Message-Id: <20200629193947.2705954-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: 3YTCL6HHG3U3IVAMZUTX2GBIDNAEF22U
X-Message-ID-Hash: 3YTCL6HHG3U3IVAMZUTX2GBIDNAEF22U
X-MailFrom: BATV+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3YTCL6HHG3U3IVAMZUTX2GBIDNAEF22U/>
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
 arch/xtensa/platforms/iss/simdisk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 49322b66cda931..31b5020077a059 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -103,7 +103,7 @@ static void simdisk_transfer(struct simdisk *dev, unsigned long sector,
 
 static blk_qc_t simdisk_make_request(struct request_queue *q, struct bio *bio)
 {
-	struct simdisk *dev = q->queuedata;
+	struct simdisk *dev = bio->bi_disk->private_data;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	sector_t sector = bio->bi_iter.bi_sector;
@@ -273,8 +273,6 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 		goto out_alloc_queue;
 	}
 
-	dev->queue->queuedata = dev;
-
 	dev->gd = alloc_disk(SIMDISK_MINORS);
 	if (dev->gd == NULL) {
 		pr_err("alloc_disk failed\n");
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
