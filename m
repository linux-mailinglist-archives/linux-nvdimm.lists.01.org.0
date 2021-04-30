Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F29C36F31F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Apr 2021 02:08:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67C76100EBBCB;
	Thu, 29 Apr 2021 17:08:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182; helo=linux.microsoft.com; envelope-from=tstark@linux.microsoft.com; receiver=<UNKNOWN> 
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by ml01.01.org (Postfix) with ESMTP id 09A00100EC1EE
	for <linux-nvdimm@lists.01.org>; Thu, 29 Apr 2021 17:08:38 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1096)
	id 996C220B7188; Thu, 29 Apr 2021 17:08:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 996C220B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1619741318;
	bh=n3WgG3yGHD7CgEOHnOo4LjqQiT3HkPXJc1TTPzfq1L0=;
	h=Date:From:To:Cc:Subject:From;
	b=Pregs/jhWxM7XSLtZbVtu/tz5Mpx+He6Nd1HOnUG14whtSZm9WnbBTmHSn1D2rLyp
	 UUI3QYEQqFucJwpXNJkgIzobpvmOD8DZCfmAbqv4KJyQOOkzv1FWE2oAkjYqL3dyWT
	 LC0uX9wPgMeHDauoAgJ+QGr9nnFe5RjU6QsK2ZV4=
Date: Thu, 29 Apr 2021 17:08:38 -0700
From: Taylor Stark <tstark@linux.microsoft.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH] virtio-pmem: Support PCI BAR-relative addresses
Message-ID: <20210430000838.GA8191@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Message-ID-Hash: EIVA4CL6PYEKZ2G6XHSPF5Y6HXUG3KG4
X-Message-ID-Hash: EIVA4CL6PYEKZ2G6XHSPF5Y6HXUG3KG4
X-MailFrom: tstark@linux.microsoft.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: graham.wong@microsoft.com, john.starks@microsoft.com, ben.hillis@microsoft.com, tyler.hicks@microsoft.com, tstark@microsoft.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EIVA4CL6PYEKZ2G6XHSPF5Y6HXUG3KG4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update virtio-pmem to allow for the pmem region to be specified in either
guest absolute terms or as a PCI BAR-relative address. This is required
to support virtio-pmem in Hyper-V, since Hyper-V only allows PCI devices
to operate on PCI memory ranges defined via BARs.

Virtio-pmem will check for a shared memory window and use that if found,
else it will fallback to using the guest absolute addresses in
virtio_pmem_config. This was chosen over defining a new feature bit,
since it's similar to how virtio-fs is configured.

Signed-off-by: Taylor Stark <tstark@linux.microsoft.com>
---
 drivers/nvdimm/virtio_pmem.c | 21 +++++++++++++++++----
 drivers/nvdimm/virtio_pmem.h |  3 +++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 726c7354d465..43c1d835a449 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -37,6 +37,8 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 	struct virtio_pmem *vpmem;
 	struct resource res;
 	int err = 0;
+	bool have_shm_region;
+	struct virtio_shm_region pmem_region;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -58,10 +60,21 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_err;
 	}
 
-	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
-			start, &vpmem->start);
-	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
-			size, &vpmem->size);
+	/* Retrieve the pmem device's address and size. It may have been supplied
+	 * as a PCI BAR-relative shared memory region, or as a guest absolute address.
+	 */
+	have_shm_region = virtio_get_shm_region(vpmem->vdev, &pmem_region,
+						VIRTIO_PMEM_SHMCAP_ID_PMEM_REGION);
+
+	if (have_shm_region) {
+		vpmem->start = pmem_region.addr;
+		vpmem->size = pmem_region.len;
+	} else {
+		virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
+				start, &vpmem->start);
+		virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
+				size, &vpmem->size);
+	}
 
 	res.start = vpmem->start;
 	res.end   = vpmem->start + vpmem->size - 1;
diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index 0dddefe594c4..62bb564e81cb 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -50,6 +50,9 @@ struct virtio_pmem {
 	__u64 size;
 };
 
+/* For the id field in virtio_pci_shm_cap */
+#define VIRTIO_PMEM_SHMCAP_ID_PMEM_REGION 0
+
 void virtio_pmem_host_ack(struct virtqueue *vq);
 int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
 #endif
-- 
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
