Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 620E92106EF
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jul 2020 11:00:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9451111470AAD;
	Wed,  1 Jul 2020 02:00:19 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+501e1de201b53739768b+6156+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3C67A1145BDE1
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jul 2020 02:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tMUnz3Lcybn8dQofQ1ryTzIcUAQ8+R8Yiszv/2NG4rI=; b=Z/F5JgSBdsAyHAjWTFzaMp6g/q
	oUzASIPvrJSJhS8H/JfA1QH8G6IT7wmV5wLn36QX/aHDo/hsxYVlgCl6qoTtD6nZ6IvOBUe/JnXQt
	goBpJk9KmMg/PLs2u8o5kRTqrjTKbPsqjWXOy6JnNqrkKOfwRlEIIUz20TquRejre+i/DVwTPiltW
	jHYesHi+fT0Dd0T/0ANjA7isBclM9yDdn8EbcZjL2aV1xUSGZFyB4MPPtssG0ekb0Vesqf9t2hN5D
	7E5atGWNGy/7VUYWuHLULEFzZmWMZQO1JDyBMSdbTihaE6Swz+QOzO9Y+CnVIeWgK7UHJ4QLdU4Me
	+zEre2Dw==;
Received: from [2001:4bb8:184:76e3:ea38:596b:3e9e:422a] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqYbA-0008Ea-Rh; Wed, 01 Jul 2020 09:00:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/20] block: tidy up a warning in bio_check_ro
Date: Wed,  1 Jul 2020 10:59:40 +0200
Message-Id: <20200701085947.3354405-14-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701085947.3354405-1-hch@lst.de>
References: <20200701085947.3354405-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: X3OS5NLYLWCO5JI5GHAGPTDKXXVOJTT3
X-Message-ID-Hash: X3OS5NLYLWCO5JI5GHAGPTDKXXVOJTT3
X-MailFrom: BATV+501e1de201b53739768b+6156+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X3OS5NLYLWCO5JI5GHAGPTDKXXVOJTT3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The "generic_make_request: " prefix has no value, and will soon become
stale.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 76cfd5709f66cd..95dca74534ff73 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -869,8 +869,7 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 			return false;
 
 		WARN_ONCE(1,
-		       "generic_make_request: Trying to write "
-			"to read-only block-device %s (partno %d)\n",
+		       "Trying to write to read-only block-device %s (partno %d)\n",
 			bio_devname(bio, b), part->partno);
 		/* Older lvm-tools actually trigger this */
 		return false;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
