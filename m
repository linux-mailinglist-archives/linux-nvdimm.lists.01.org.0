Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FE820D5A9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 21:40:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF269111F92BF;
	Mon, 29 Jun 2020 12:40:24 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DAB89111F92B5
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=N4V7c3aeDLuwhXVBAMVeI93XDU7dFLU/PzjjNBBA1go=; b=nNXRBgZrqUkYW06bN7kMVbhKQp
	BlmpXSCdMbqb/Ht5wWHvxJtfrr6svKWFTv8Tt4Ufg7qxppL3ei3dqO9x299z4vDWrKj32a6zAcqSL
	c4m4m8EqDQLV0obdwyzZum4rarDYDeASDBA573D5k0a3dJQxVCiz704FT+VKkYMJLXypm1xf73cB3
	AgGiAVOZh9k2lYQfWMzILfco++St1B3KjzFapwCHMQbwuELGSHYTtoro2+hJ5y8/MWUZ1ZK+LwL5b
	lBJH3BSbHoqbKdPThJr9UKdZ7VxtYLq5743jYblBgF7pRDOkMgWA5lO9m/s8jN+8qpJjWKBSVdf/p
	NcNA9Tjw==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzdP-0004KD-Bf; Mon, 29 Jun 2020 19:40:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/20] fs: remove a weird comment in submit_bh_wbc
Date: Mon, 29 Jun 2020 21:39:38 +0200
Message-Id: <20200629193947.2705954-12-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: SNWCYU2Y3POCXUNDTREY7SCWE5ZQDJB7
X-Message-ID-Hash: SNWCYU2Y3POCXUNDTREY7SCWE5ZQDJB7
X-MailFrom: BATV+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SNWCYU2Y3POCXUNDTREY7SCWE5ZQDJB7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

All bios can get remapped if submitted to partitions.  No need to
comment on that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 64fe82ec65ff1f..2725ebbcfdc246 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3040,12 +3040,7 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
 		clear_buffer_write_io_error(bh);
 
-	/*
-	 * from here on down, it's all bio -- do the initial mapping,
-	 * submit_bio -> generic_make_request may further map this bio around
-	 */
 	bio = bio_alloc(GFP_NOIO, 1);
-
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_write_hint = write_hint;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
