Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8A1E37F5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 07:25:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78AF8122679F9;
	Tue, 26 May 2020 22:20:59 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0F2BE122679F7
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 22:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9XennrgwipSgDkcsh71JEE0YegAAd1Z7p+AJvSBp+LI=; b=KE/N/QUU7KEPg8KwFaByBxVm16
	6UVgeALZheCCC/5WRZ7tD/5KMAmgLmAWR4UAgXFISqpEQFvvshPhR7xaovhoiNCsgEOICUgq0pXla
	ebdmddx8T6oBlWKG05+ZpmhAiA1fKGN3B2PN2YKYFQ7W5495exwJOoHhhJ/pgfdB8Vsm97bCpnmsR
	hDB7EsMPcvACPQ2anG207HXBzX2lnwEQQgZsH4wNylFqZniDHe630r5pJbabxrW60loCtpXU6DYjs
	Ymp8VCHiro/kNu/cbtZMrNpFWRf84UEIQ4RmCFOF2rf67FoNQRBRThaQQ6ruizueZCgzqGZ+jTU5z
	5GvxG0/Q==;
Received: from [2001:4bb8:18c:5da7:8164:affc:3c20:853d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdoYn-0000vd-EV; Wed, 27 May 2020 05:25:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/16] block: remove rcu_read_lock() from part_stat_lock()
Date: Wed, 27 May 2020 07:24:17 +0200
Message-Id: <20200527052419.403583-15-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527052419.403583-1-hch@lst.de>
References: <20200527052419.403583-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: 627E5P2EC4WUYMMNLJDQICMPGIAWL5YZ
X-Message-ID-Hash: 627E5P2EC4WUYMMNLJDQICMPGIAWL5YZ
X-MailFrom: BATV+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/627E5P2EC4WUYMMNLJDQICMPGIAWL5YZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

The RCU lock is required only in disk_map_sector_rcu() to lookup the
partition.  After that request holds reference to related hd_struct.

Replace get_cpu() with preempt_disable() - returned cpu index is unused.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
[hch: rebased]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c             | 11 ++++++++---
 include/linux/part_stat.h |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 3e7df0a3e6bb0..1a76593276644 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -321,11 +321,12 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 	struct hd_struct *part;
 	int i;
 
+	rcu_read_lock();
 	ptbl = rcu_dereference(disk->part_tbl);
 
 	part = rcu_dereference(ptbl->last_lookup);
 	if (part && sector_in_part(part, sector) && hd_struct_try_get(part))
-		return part;
+		goto out_unlock;
 
 	for (i = 1; i < ptbl->len; i++) {
 		part = rcu_dereference(ptbl->part[i]);
@@ -339,10 +340,14 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 			if (!hd_struct_try_get(part))
 				break;
 			rcu_assign_pointer(ptbl->last_lookup, part);
-			return part;
+			goto out_unlock;
 		}
 	}
-	return &disk->part0;
+
+	part = &disk->part0;
+out_unlock:
+	rcu_read_unlock();
+	return part;
 }
 
 /**
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 6644197980b92..a6b0938ce82e9 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -21,8 +21,8 @@ struct disk_stats {
  *
  * part_stat_read() can be called at any time.
  */
-#define part_stat_lock()	({ rcu_read_lock(); get_cpu(); })
-#define part_stat_unlock()	do { put_cpu(); rcu_read_unlock(); } while (0)
+#define part_stat_lock()	preempt_disable()
+#define part_stat_unlock()	preempt_enable()
 
 #define part_stat_get_cpu(part, field, cpu)				\
 	(per_cpu_ptr((part)->dkstats, (cpu))->field)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
