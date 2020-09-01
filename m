Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A641259601
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Sep 2020 17:58:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DD531396FC0D;
	Tue,  1 Sep 2020 08:58:18 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+00d723da4443b0556009+6218+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 546F21396FC06
	for <linux-nvdimm@lists.01.org>; Tue,  1 Sep 2020 08:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nRA6JK+4aMp60Yu0KbqG4/pNdu09ibxhHSJ5/A99bDI=; b=k2qZddWw1U3EZJUTGVu0rHSLJs
	W5NgwgDkMU4Tctn8sp6QDS8uXrMAVU8TzWoAL6ToIpC7KJoKBS+hR10VJaRx7HUlCrn23sdr2GXXV
	PivvROx3tTElb1yMRSSSuseDaTpRWJpVWM5KD/wTw/IT+YTPLspEFsL9wpeIKfruOS68OSavOcO3b
	eKoyZN9jt6fhjHPyiO1n+Ltd23usEmrStZ0nhKSCgpp0vMkbLWmtuxBHj1SB6Hdbonp7qcS/5sHw1
	h6xT9GKSHXVkxt4Y/hHRE/O0vpV4ONoMUaFGKU12gPJqvqq6SOLh88NGCQe1kbJ3s68Vas9hCHfw2
	AZ8ApNWw==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD8fa-0004R3-Ip; Tue, 01 Sep 2020 15:58:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/9] sd: open code revalidate_disk
Date: Tue,  1 Sep 2020 17:57:46 +0200
Message-Id: <20200901155748.2884-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: IPLDS6UYYQAZHCDGQHBZKPAUWX3HB7EC
X-Message-ID-Hash: IPLDS6UYYQAZHCDGQHBZKPAUWX3HB7EC
X-MailFrom: BATV+00d723da4443b0556009+6218+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Josef Bacik <josef@toxicpanda.com>, dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IPLDS6UYYQAZHCDGQHBZKPAUWX3HB7EC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Instead of calling revalidate_disk just do the work directly by
calling sd_revalidate_disk, and revalidate_disk_size where needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 95018e650f2d0c..2bec8cd526164d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -217,7 +217,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 			sd_print_sense_hdr(sdkp, &sshdr);
 		return -EINVAL;
 	}
-	revalidate_disk(sdkp->disk);
+	sd_revalidate_disk(sdkp->disk);
 	return count;
 }
 
@@ -1706,8 +1706,10 @@ static int sd_sync_cache(struct scsi_disk *sdkp, struct scsi_sense_hdr *sshdr)
 static void sd_rescan(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	int ret;
 
-	revalidate_disk(sdkp->disk);
+	ret = sd_revalidate_disk(sdkp->disk);
+	revalidate_disk_size(sdkp->disk, ret == 0);
 }
 
 static int sd_ioctl(struct block_device *bdev, fmode_t mode,
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
