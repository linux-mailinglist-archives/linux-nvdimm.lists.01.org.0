Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1AF1FA79
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 21:27:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 87E8A212794BB;
	Wed, 15 May 2019 12:27:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E90CD21CE7418
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 12:27:33 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D84333027E;
 Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5491B1001DE1;
 Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id C56EC225483; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2 15/30] virtio: Implement get_shm_region for PCI transport
Date: Wed, 15 May 2019 15:27:00 -0400
Message-Id: <20190515192715.18000-16-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On PCI the shm regions are found using capability entries;
find a region by searching for the capability.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 108 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h    |  10 +++
 2 files changed, 118 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 07571daccfec..51c9e6eca5ac 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -446,6 +446,112 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	vring_del_virtqueue(vq);
 }
 
+static int virtio_pci_find_shm_cap(struct pci_dev *dev,
+                                   u8 required_id,
+                                   u8 *bar, u64 *offset, u64 *len)
+{
+	int pos;
+
+        for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
+             pos > 0;
+             pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
+		u8 type, cap_len, id;
+                u32 tmp32;
+                u64 res_offset, res_length;
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         cfg_type),
+                                     &type);
+                if (type != VIRTIO_PCI_CAP_SHARED_MEMORY_CFG)
+                        continue;
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         cap_len),
+                                     &cap_len);
+                if (cap_len != sizeof(struct virtio_pci_shm_cap)) {
+		        printk(KERN_ERR "%s: shm cap with bad size offset: %d size: %d\n",
+                               __func__, pos, cap_len);
+                        continue;
+                };
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_shm_cap,
+                                                         id),
+                                     &id);
+                if (id != required_id)
+                        continue;
+
+                /* Type, and ID match, looks good */
+                pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         bar),
+                                     bar);
+
+                /* Read the lower 32bit of length and offset */
+                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, offset),
+                                      &tmp32);
+                res_offset = tmp32;
+                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, length),
+                                      &tmp32);
+                res_length = tmp32;
+
+                /* and now the top half */
+                pci_read_config_dword(dev,
+                                      pos + offsetof(struct virtio_pci_shm_cap,
+                                                     offset_hi),
+                                      &tmp32);
+                res_offset |= ((u64)tmp32) << 32;
+                pci_read_config_dword(dev,
+                                      pos + offsetof(struct virtio_pci_shm_cap,
+                                                     length_hi),
+                                      &tmp32);
+                res_length |= ((u64)tmp32) << 32;
+
+                *offset = res_offset;
+                *len = res_length;
+
+                return pos;
+        }
+        return 0;
+}
+
+static bool vp_get_shm_region(struct virtio_device *vdev,
+			      struct virtio_shm_region *region, u8 id)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct pci_dev *pci_dev = vp_dev->pci_dev;
+	u8 bar;
+	u64 offset, len;
+	phys_addr_t phys_addr;
+	size_t bar_len;
+	char *bar_name;
+	int ret;
+
+	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
+		return false;
+	}
+
+	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
+	if (ret < 0) {
+		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
+			__func__);
+		return false;
+	}
+
+	phys_addr = pci_resource_start(pci_dev, bar);
+	bar_len = pci_resource_len(pci_dev, bar);
+
+        if (offset + len > bar_len) {
+                dev_err(&pci_dev->dev,
+                        "%s: bar shorter than cap offset+len\n",
+                        __func__);
+                return false;
+        }
+
+	region->len = len;
+	region->addr = (u64) phys_addr + offset;
+
+	return true;
+}
+
 static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get		= NULL,
 	.set		= NULL,
@@ -460,6 +566,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
+	.get_shm_region  = vp_get_shm_region,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -476,6 +583,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
+	.get_shm_region  = vp_get_shm_region,
 };
 
 /**
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 90007a1abcab..31841a60a4ad 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -113,6 +113,8 @@
 #define VIRTIO_PCI_CAP_DEVICE_CFG	4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG		5
+/* Additional shared memory capability */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
 
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
@@ -163,6 +165,14 @@ struct virtio_pci_cfg_cap {
 	__u8 pci_cfg_data[4]; /* Data for BAR access. */
 };
 
+/* Fields in VIRTIO_PCI_CAP_SHARED_MEMORY_CFG */
+struct virtio_pci_shm_cap {
+       struct virtio_pci_cap cap;
+       __le32 offset_hi;             /* Most sig 32 bits of offset */
+       __le32 length_hi;             /* Most sig 32 bits of length */
+        __u8   id;                    /* To distinguish shm chunks */
+};
+
 /* Macro versions of offsets for the Old Timers! */
 #define VIRTIO_PCI_CAP_VNDR		0
 #define VIRTIO_PCI_CAP_NEXT		1
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
