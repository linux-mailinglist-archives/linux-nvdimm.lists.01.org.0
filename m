Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 136B21B0C7A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 15:21:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B587F1010631D;
	Mon, 20 Apr 2020 06:21:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 17A77100DBB0B
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 06:20:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so12142233wrx.4
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPdZQyRabt6he4bhfa5uiDoDto3iaERte2f8Bkdq2dw=;
        b=tF2OVncK+ugkAA0A6/qVKJOT2F+p1Xs+5i9grlHooTDlg6Xh4UXsF6uAmEs1dcFDT8
         o5OhLCJ0mYBEMkKpj6VVsq0/afAdQ5ds/MC+4PXXMoeNk3a2vwbR87IoOZUN6B5CxzwZ
         aMJ35ThdS6B/A9OWe1PAyCfDQDve3XV3cc9d16fuGBEnbhpvNc0DLKAmR7bHc90tq/MO
         2g3eFdXnKnRJPwuiNPfBJWZhNYyTVC4s3siecJR2qEctGPo/a/Xxtt87gnoRpB1Y2jHT
         GHojSiqt35ROFpABxTxzHxAKnveIfz2S86dEoJNZAaY9011wZDahmwerFOoMRbuUs+BX
         kZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPdZQyRabt6he4bhfa5uiDoDto3iaERte2f8Bkdq2dw=;
        b=rB7+U7sjt2YZ23WqmSC5/FqicBu+4RtEFQwvqoywC8kYZV8gUu7Lto9KygbHp+i6+l
         a2krKmmMl5M8W/fhjVYMjKmPRLEglw7vajoX5O90+wiS50c9wpzaRys1yrERKWKv/Qua
         ZGM6jjbhK8EraUAVABJ5kIxl1OMI5GbVL3jv6y4Yhh7Tu/wWLD5DZSk8cFStzjDK8VV8
         ITSOiTCHs9Fu0nbgYbBQHmu00uYDyAxuYWMDLnNT3T8na1JaDlWJc4p3EGznVVIUzWBZ
         T6C51pJj0MxWxjbgl8GPNZBqQoTNczQDLT2OCZdjkfMcHL8Y+vNOiKWc8cwh6/ixXtQG
         CB3g==
X-Gm-Message-State: AGi0PuYdpOmAu9IOnqkr6UdoSwBpf+7hyY61gKyrVktzd3tGFqjMzp8I
	+XPyv/VpoMFLMy/77UqocfM=
X-Google-Smtp-Source: APiQypLTT+egxtT73HLwY0UOVwG+pILDTsDsZ1ej+0/Fx34zgMak60ZvBvwtp3mCSthkZBRng6HwzA==
X-Received: by 2002:adf:f748:: with SMTP id z8mr9539405wrp.45.1587388808377;
        Mon, 20 Apr 2020 06:20:08 -0700 (PDT)
Received: from PC192-168-2-103.speedport.ip (p5B05E57B.dip0.t-ipconnect.de. [91.5.229.123])
        by smtp.gmail.com with ESMTPSA id z76sm1545815wmc.9.2020.04.20.06.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:20:08 -0700 (PDT)
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org
Subject: [RFC 2/2] virtio_pmem: Async virtio-pmem flush
Date: Mon, 20 Apr 2020 15:19:47 +0200
Message-Id: <20200420131947.41991-3-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
References: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Message-ID-Hash: OO4W3ELF3ZP2FLKR2OSCYRVNYLOJ5AF3
X-Message-ID-Hash: OO4W3ELF3ZP2FLKR2OSCYRVNYLOJ5AF3
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: david@redhat.com, mst@redhat.com, pankaj.gupta@cloud.ionos.com, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OO4W3ELF3ZP2FLKR2OSCYRVNYLOJ5AF3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 This patch enables asynchronous flush for virtio pmem
 using work queue. Also, it coalesce the flush requests
 when a flush is already in process.

Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
 drivers/nvdimm/nd_virtio.c   | 62 ++++++++++++++++++++++++++----------
 drivers/nvdimm/virtio_pmem.c |  9 ++++++
 drivers/nvdimm/virtio_pmem.h | 14 ++++++++
 3 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 10351d5b49fa..ef53d0a0d134 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -97,29 +97,57 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	return err;
 };
 
+static void submit_async_flush(struct work_struct *ws);
+
 /* The asynchronous flush callback function */
 int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 {
-	/*
-	 * Create child bio for asynchronous flush and chain with
-	 * parent bio. Otherwise directly call nd_region flush.
-	 */
-	if (bio && bio->bi_iter.bi_sector != -1) {
-		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
-
-		if (!child)
-			return -ENOMEM;
-		bio_copy_dev(child, bio);
-		child->bi_opf = REQ_PREFLUSH;
-		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
-		return 0;
+	struct virtio_device *vdev = nd_region->provider_data;
+	struct virtio_pmem *vpmem  = vdev->priv;
+	ktime_t start = ktime_get_boottime();
+
+	spin_lock_irq(&vpmem->lock);
+	wait_event_lock_irq(vpmem->sb_wait,
+			    !vpmem->flush_bio ||
+			    ktime_after(vpmem->last_flush, start),
+			    vpmem->lock);
+
+	if (!ktime_after(vpmem->last_flush, start)) {
+		WARN_ON(vpmem->flush_bio);
+		vpmem->flush_bio = bio;
+		bio = NULL;
 	}
-	if (virtio_pmem_flush(nd_region))
-		return -EIO;
+	spin_unlock_irq(&vpmem->lock);
 
+	if (!bio) {
+		INIT_WORK(&vpmem->flush_work, submit_async_flush);
+		queue_work(vpmem->pmem_wq, &vpmem->flush_work);
+		return 1;
+	}
+
+	bio->bi_opf &= ~REQ_PREFLUSH;
 	return 0;
 };
 EXPORT_SYMBOL_GPL(async_pmem_flush);
+
+static void submit_async_flush(struct work_struct *ws)
+{
+	struct virtio_pmem *vpmem = container_of(ws, struct virtio_pmem, flush_work);
+	struct bio *bio = vpmem->flush_bio;
+
+	vpmem->start_flush = ktime_get_boottime();
+	bio->bi_status = errno_to_blk_status(virtio_pmem_flush(vpmem->nd_region));
+	vpmem->last_flush = vpmem->start_flush;
+	vpmem->flush_bio = NULL;
+	wake_up(&vpmem->sb_wait);
+
+	/* Submit parent bio only for PREFLUSH */
+	if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
+		bio->bi_opf &= ~REQ_PREFLUSH;
+		submit_bio(bio);
+	} else if (bio && (bio->bi_opf & REQ_FUA)) {
+		bio->bi_opf &= ~REQ_FUA;
+		bio_endio(bio);
+	}
+}
 MODULE_LICENSE("GPL");
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 5e3d07b47e0c..4ab135d820fd 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -24,6 +24,7 @@ static int init_vq(struct virtio_pmem *vpmem)
 		return PTR_ERR(vpmem->req_vq);
 
 	spin_lock_init(&vpmem->pmem_lock);
+	spin_lock_init(&vpmem->lock);
 	INIT_LIST_HEAD(&vpmem->req_list);
 
 	return 0;
@@ -58,6 +59,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_err;
 	}
 
+	vpmem->pmem_wq = alloc_workqueue("vpmem_wq", WQ_MEM_RECLAIM, 0);
+	if (!vpmem->pmem_wq) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+	init_waitqueue_head(&vpmem->sb_wait);
 	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
 			start, &vpmem->start);
 	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
@@ -90,10 +97,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_nd;
 	}
 	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
+	vpmem->nd_region = nd_region;
 	return 0;
 out_nd:
 	nvdimm_bus_unregister(vpmem->nvdimm_bus);
 out_vq:
+	destroy_workqueue(vpmem->pmem_wq);
 	vdev->config->del_vqs(vdev);
 out_err:
 	return err;
diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index 0dddefe594c4..9d3615a324bf 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -35,9 +35,23 @@ struct virtio_pmem {
 	/* Virtio pmem request queue */
 	struct virtqueue *req_vq;
 
+	struct bio *flush_bio;
+	/* last_flush is when the last completed flush was started */
+	ktime_t last_flush, start_flush;
+
+	/* work queue for deferred flush */
+	struct work_struct flush_work;
+	struct workqueue_struct *pmem_wq;
+
+	/* Synchronize flush wait queue data */
+	spinlock_t lock;
+	/* for waiting for previous flush to complete */
+	wait_queue_head_t sb_wait;
+
 	/* nvdimm bus registers virtio pmem device */
 	struct nvdimm_bus *nvdimm_bus;
 	struct nvdimm_bus_descriptor nd_desc;
+	struct nd_region *nd_region;
 
 	/* List to store deferred work if virtqueue is full */
 	struct list_head req_list;
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
