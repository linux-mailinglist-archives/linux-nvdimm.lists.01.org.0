Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 412991FA78
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 21:27:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 483BF212794D1;
	Wed, 15 May 2019 12:27:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D662521268FB5
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 12:27:33 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A40F90906;
 Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 257DA5D729;
 Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id BE116225482; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2 14/30] virtio: Add get_shm_region method
Date: Wed, 15 May 2019 15:26:59 -0400
Message-Id: <20190515192715.18000-15-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 15 May 2019 19:27:33 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: swhiteho@redhat.com, dgilbert@redhat.com, stefanha@redhat.com,
 miklos@szeredi.hu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

Virtio defines 'shared memory regions' that provide a continuously
shared region between the host and guest.

Provide a method to find a particular region on a device.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/linux/virtio_config.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index bb4cc4910750..c859f000a751 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -10,6 +10,11 @@
 
 struct irq_affinity;
 
+struct virtio_shm_region {
+       u64 addr;
+       u64 len;
+};
+
 /**
  * virtio_config_ops - operations for configuring a virtio device
  * Note: Do not assume that a transport implements all of the operations
@@ -65,6 +70,7 @@ struct irq_affinity;
  *      the caller can then copy.
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
+ * @get_shm_region: get a shared memory region based on the index.
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -88,6 +94,8 @@ struct virtio_config_ops {
 			       const struct cpumask *cpu_mask);
 	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
 			int index);
+	bool (*get_shm_region)(struct virtio_device *vdev,
+			       struct virtio_shm_region *region, u8 id);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
@@ -250,6 +258,15 @@ int virtqueue_set_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 	return 0;
 }
 
+static inline
+bool virtio_get_shm_region(struct virtio_device *vdev,
+                         struct virtio_shm_region *region, u8 id)
+{
+	if (!vdev->config->get_shm_region)
+		return false;
+	return vdev->config->get_shm_region(vdev, region, id);
+}
+
 static inline bool virtio_is_little_endian(struct virtio_device *vdev)
 {
 	return virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
