Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1EF1B0C79
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 15:21:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9CCFE10106316;
	Mon, 20 Apr 2020 06:21:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0291A100DBB0B
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 06:20:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h2so10993115wmb.4
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kskdakcrRDDo91fKKn7OmT1ABdfxtHTqlHARV8i00xs=;
        b=aUkNkLAKtinYXOavLQJR4mxUih+wv7V9IIV5NCBglcrY2wRxfDYBx0oBY6UoEzaY1Z
         hWMx7UkJYRTqvGRUf9lsw5g/ubgsCVxTBkf1hCbl34ojscJs9LpOkazrxXwHwU7ik/HY
         GWfF8DuKreVT8/viaIGGkvEvoKu5s2yDarFWFW/vjCXNCzQ6gmBxOreUKkKeGK+8k5fx
         vgMyY2V9mje8RTJtMxQq/qbZrstI+AQA/hhG3xxfhnyO8dyzCxIGoR70O7FIMSYhRQYX
         WTPioZNGzmlfpgGRwJX2uMe13cobITxAoNpc34eFSxArzhWpp4YrmcdhnmY/VymONzVa
         Lu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kskdakcrRDDo91fKKn7OmT1ABdfxtHTqlHARV8i00xs=;
        b=ZPv+xDwVRdCBUNc0O3HRAvZEYhRfL5aplh7q99xMoMRSa4rh1RcNy4k0i0xzg9zRj8
         DodRnmF7sEC2ZH9TXoMRqMDQGHV39Va9LSX7iK5jJetyK6TEWnwoQpr6QJsoOVXGn6jN
         9cWXpY75KKatxxIqQvBNmKCzTxta2g7EcIg1vjMuy0id4/Cdv6bizyvmxc/jDhJUd24B
         a8nQRDWy59i+vNYqauqLq19CGkdA4OybgNaYwStM4AuF2F7XTkduYfn0wg8A4sG0vJND
         FV1GfJYYB8ijjGdS099CuhTDfLRy4S2HNMg7qO5lrjcz4fOQ5kbP3VAFORC4RYfl+6UK
         HLIw==
X-Gm-Message-State: AGi0PubXea8sbnjYILGG8AcHFDh1Hz4m8jXWhBWmZ5LXVfTwxZ7erMK/
	V8GYJks1DPfBAaxIAqzdNzk=
X-Google-Smtp-Source: APiQypK3K2b4fWenwyn8NZmGOaFzl5N6U9bT3lDViuWJnAwH7TScEy7QYI5qYpT7x6FJe48OXAjEXw==
X-Received: by 2002:a1c:2457:: with SMTP id k84mr15813838wmk.96.1587388805686;
        Mon, 20 Apr 2020 06:20:05 -0700 (PDT)
Received: from PC192-168-2-103.speedport.ip (p5B05E57B.dip0.t-ipconnect.de. [91.5.229.123])
        by smtp.gmail.com with ESMTPSA id z76sm1545815wmc.9.2020.04.20.06.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:20:05 -0700 (PDT)
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org
Subject: [RFC 1/2] pmem: make nvdimm_flush asynchronous
Date: Mon, 20 Apr 2020 15:19:46 +0200
Message-Id: <20200420131947.41991-2-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
References: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Message-ID-Hash: HWYT5K7V4RXET3XYL7CEZOUM5RFKE7NY
X-Message-ID-Hash: HWYT5K7V4RXET3XYL7CEZOUM5RFKE7NY
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: david@redhat.com, mst@redhat.com, pankaj.gupta@cloud.ionos.com, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HWYT5K7V4RXET3XYL7CEZOUM5RFKE7NY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 This patch converts nvdimm_flush to return when 
 asynchronous flush is in process.

Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
 drivers/nvdimm/pmem.c        | 15 ++++++++-------
 drivers/nvdimm/region_devs.c |  3 +--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4ffc6f7ca131..747ffaee513b 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -192,8 +192,10 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 	struct pmem_device *pmem = q->queuedata;
 	struct nd_region *nd_region = to_region(pmem);
 
-	if (bio->bi_opf & REQ_PREFLUSH)
-		ret = nvdimm_flush(nd_region, bio);
+	if ((bio->bi_opf & REQ_PREFLUSH) &&
+		nvdimm_flush(nd_region, bio)) {
+		return BLK_QC_T_NONE;
+	}
 
 	do_acct = nd_iostat_start(bio, &start);
 	bio_for_each_segment(bvec, bio, iter) {
@@ -207,11 +209,10 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 	if (do_acct)
 		nd_iostat_end(bio, start);
 
-	if (bio->bi_opf & REQ_FUA)
-		ret = nvdimm_flush(nd_region, bio);
-
-	if (ret)
-		bio->bi_status = errno_to_blk_status(ret);
+	if (bio->bi_opf & REQ_FUA) {
+		nvdimm_flush(nd_region, bio);
+		return BLK_QC_T_NONE;
+	}
 
 	bio_endio(bio);
 	return BLK_QC_T_NONE;
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index a19e535830d9..1caa13f1523f 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1091,8 +1091,7 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
 	if (!nd_region->flush)
 		rc = generic_nvdimm_flush(nd_region);
 	else {
-		if (nd_region->flush(nd_region, bio))
-			rc = -EIO;
+		rc = nd_region->flush(nd_region, bio);
 	}
 
 	return rc;
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
