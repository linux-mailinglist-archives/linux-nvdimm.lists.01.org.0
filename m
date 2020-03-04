Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDD71795E1
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 17:59:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA13C10FC36DC;
	Wed,  4 Mar 2020 09:00:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 78C6310FC36D1
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583341155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ri13vTOknpetvDy7ElAZqwOtMgDlHO5b+O2XLP0jFKY=;
	b=VoztB/OmtX7lMnB8t/yDW9FB1pi7w7H8Weat2xfchTE1a269bCEh/LGvXB6bd+ymGaT/b/
	q2AaXm8f7BN020Yv2YGjfQac2/Nsh4GMLwo5bqa0CQYoDFlPlGPJgIfHL98+zN+StHWJkH
	0cQ4iJtGK43s+zGx6dEg73pIlaGVBrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-miPyIUfpM46Y_nUpRqKVLg-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: miPyIUfpM46Y_nUpRqKVLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7EBB800D4E;
	Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A38E75D9C9;
	Wed,  4 Mar 2020 16:59:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 45B4B2257D6; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Date: Wed,  4 Mar 2020 11:58:29 -0500
Message-Id: <20200304165845.3081-5-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: EJ32ETTXQEFCMOPLE4PGSGTSB4WDRCDR
X-Message-ID-Hash: EJ32ETTXQEFCMOPLE4PGSGTSB4WDRCDR
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>, kbuild test robot <lkp@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EJ32ETTXQEFCMOPLE4PGSGTSB4WDRCDR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

On PCI the shm regions are found using capability entries;
find a region by searching for the capability.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 drivers/virtio/virtio_pci_modern.c | 107 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h    |  11 ++-
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7abcc50838b8..52f179411015 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -443,6 +443,111 @@ static void del_vq(struct virtio_pci_vq_info *info)
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
+		if (cap_len != sizeof(struct virtio_pci_cap64)) {
+		        printk(KERN_ERR "%s: shm cap with bad size offset: %d size: %d\n",
+                               __func__, pos, cap_len);
+                        continue;
+                }
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
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
+                                      pos + offsetof(struct virtio_pci_cap64,
+                                                     offset_hi),
+                                      &tmp32);
+                res_offset |= ((u64)tmp32) << 32;
+                pci_read_config_dword(dev,
+                                      pos + offsetof(struct virtio_pci_cap64,
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
@@ -457,6 +562,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
+	.get_shm_region  = vp_get_shm_region,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -473,6 +579,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
+	.get_shm_region  = vp_get_shm_region,
 };
 
 /**
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 90007a1abcab..fe9f43680a1d 100644
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
@@ -121,11 +123,18 @@ struct virtio_pci_cap {
 	__u8 cap_len;		/* Generic PCI field: capability length */
 	__u8 cfg_type;		/* Identifies the structure. */
 	__u8 bar;		/* Where to find it. */
-	__u8 padding[3];	/* Pad to full dword. */
+	__u8 id;		/* Multiple capabilities of the same type */
+	__u8 padding[2];	/* Pad to full dword. */
 	__le32 offset;		/* Offset within bar. */
 	__le32 length;		/* Length of the structure, in bytes. */
 };
 
+struct virtio_pci_cap64 {
+       struct virtio_pci_cap cap;
+       __le32 offset_hi;             /* Most sig 32 bits of offset */
+       __le32 length_hi;             /* Most sig 32 bits of length */
+};
+
 struct virtio_pci_notify_cap {
 	struct virtio_pci_cap cap;
 	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
