Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09191E0D1C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 May 2020 13:31:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 37C2C1221A1D9;
	Mon, 25 May 2020 04:27:11 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+ab9bb8b38cf50d3a9241+6119+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2791A1221A1D8
	for <linux-nvdimm@lists.01.org>; Mon, 25 May 2020 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TB9a5RlSCttsRGqQbKXaUpDsmIDKmbhQMWP6LpH5XS4=; b=KOkjO60JkDEBMvWEo1GYPh4snb
	bJ8+zN9yjHGONDrfuMRNIvk0ajYpTp3a15bA3eUURd5e4/qCXCXNiZpcUtoiWhTebt10464OMCmt5
	ZutE+uf/7M9uCgwA/xcae6KddONx528UGxSX4KDYS2akaVx6+xI4w99vT1B6lodGweHuyBhMDLReq
	VtB1JdAARkAe3UAI2IjVp5dVdoKDm7MtnBE9Q6y43YZEcs7AkkAq0JSAfWY2zqZf86X+NLHx4vkJL
	KTSb1lE+ouCWGkG5qwbmjI/ub4Eaa6FO52sW6KFUDYjGfbrqDiDyzys+kBAFHmsQWfJIsRnctv7yR
	IiDWuxIA==;
Received: from [2001:4bb8:18c:5da7:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdBJt-0002ZD-Qy; Mon, 25 May 2020 11:31:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/16] block: use __this_cpu_add() instead of access by smp_processor_id()
Date: Mon, 25 May 2020 13:30:13 +0200
Message-Id: <20200525113014.345997-16-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525113014.345997-1-hch@lst.de>
References: <20200525113014.345997-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: WVIXCIZLVZJM22GSW54O525UGMUQ3WVS
X-Message-ID-Hash: WVIXCIZLVZJM22GSW54O525UGMUQ3WVS
X-MailFrom: BATV+ab9bb8b38cf50d3a9241+6119+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WVIXCIZLVZJM22GSW54O525UGMUQ3WVS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Most architectures have fast path to access percpu for current cpu.
The required preempt_disable() is provided by part_stat_lock().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
[hch: rebased]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/part_stat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index a6b0938ce82e9..24125778ef3ec 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -54,7 +54,7 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
 	 part_stat_read(part, field[STAT_DISCARD]))
 
 #define __part_stat_add(part, field, addnd)				\
-	(part_stat_get(part, field) += (addnd))
+	__this_cpu_add((part)->dkstats->field, addnd)
 
 #define part_stat_add(part, field, addnd)	do {			\
 	__part_stat_add((part), field, addnd);				\
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
