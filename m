Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E7E24A91D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 00:21:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C0DC6134BE076;
	Wed, 19 Aug 2020 15:21:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7C857134BE05E
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 15:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1597875670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNzImEKffgBBrRILbRqWkPn7W48F7RsVK64WzriJRtY=;
	b=HHzxo9itGVP+02LblQlBP7FegrItxWyld7WZ42vIfABZlngVOLYECddTXm7uHF9yzWlGUB
	IOfp0EZ21elCeb2cHHvAEWKszsAQKy5svgitxFLmcIyHL1wbwtot23VSYAuU15wdDhleRB
	qOT3miU/Gx43gIPfwEZfWI0Op3SlJRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-G1v28SMvPaOjwJ9ww0lUIA-1; Wed, 19 Aug 2020 18:21:06 -0400
X-MC-Unique: G1v28SMvPaOjwJ9ww0lUIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C7DF1007472;
	Wed, 19 Aug 2020 22:21:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66F0B756C8;
	Wed, 19 Aug 2020 22:21:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id F143C2256E6; Wed, 19 Aug 2020 18:20:53 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com
Subject: [PATCH v3 08/18] virtio_fs, dax: Set up virtio_fs dax_device
Date: Wed, 19 Aug 2020 18:19:46 -0400
Message-Id: <20200819221956.845195-9-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: SLVUSHVB67UX3XTJO63JM4X56EMZUXYB
X-Message-ID-Hash: SLVUSHVB67UX3XTJO63JM4X56EMZUXYB
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>, Liu Bo <bo.liu@linux.alibaba.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SLVUSHVB67UX3XTJO63JM4X56EMZUXYB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Stefan Hajnoczi <stefanha@redhat.com>

Setup a dax device.

Use the shm capability to find the cache entry and map it.

The DAX window is accessed by the fs/dax.c infrastructure and must have
struct pages (at least on x86).  Use devm_memremap_pages() to map the
DAX window PCI BAR and allocate struct page.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 fs/fuse/virtio_fs.c            | 139 +++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_fs.h |   3 +
 2 files changed, 142 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 47ecdc15f25d..0fd3b5cecc5f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -5,12 +5,16 @@
  */
 
 #include <linux/fs.h>
+#include <linux/dax.h>
+#include <linux/pci.h>
+#include <linux/pfn_t.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
 #include <linux/virtio_fs.h>
 #include <linux/delay.h>
 #include <linux/fs_context.h>
 #include <linux/highmem.h>
+#include <linux/uio.h>
 #include "fuse_i.h"
 
 /* List of virtio-fs device instances and a lock for the list. Also provides
@@ -49,6 +53,12 @@ struct virtio_fs {
 	struct virtio_fs_vq *vqs;
 	unsigned int nvqs;               /* number of virtqueues */
 	unsigned int num_request_queues; /* number of request queues */
+	struct dax_device *dax_dev;
+
+	/* DAX memory window where file contents are mapped */
+	void *window_kaddr;
+	phys_addr_t window_phys_addr;
+	size_t window_len;
 };
 
 struct virtio_fs_forget_req {
@@ -686,6 +696,131 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev,
 	vdev->config->del_vqs(vdev);
 }
 
+/* Map a window offset to a page frame number.  The window offset will have
+ * been produced by .iomap_begin(), which maps a file offset to a window
+ * offset.
+ */
+static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
+				    long nr_pages, void **kaddr, pfn_t *pfn)
+{
+	struct virtio_fs *fs = dax_get_private(dax_dev);
+	phys_addr_t offset = PFN_PHYS(pgoff);
+	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
+
+	if (kaddr)
+		*kaddr = fs->window_kaddr + offset;
+	if (pfn)
+		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
+					PFN_DEV | PFN_MAP);
+	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
+}
+
+static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
+				       pgoff_t pgoff, void *addr,
+				       size_t bytes, struct iov_iter *i)
+{
+	return copy_from_iter(addr, bytes, i);
+}
+
+static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
+				       pgoff_t pgoff, void *addr,
+				       size_t bytes, struct iov_iter *i)
+{
+	return copy_to_iter(addr, bytes, i);
+}
+
+static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
+				     pgoff_t pgoff, size_t nr_pages)
+{
+	long rc;
+	void *kaddr;
+
+	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL);
+	if (rc < 0)
+		return rc;
+	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
+	dax_flush(dax_dev, kaddr, nr_pages << PAGE_SHIFT);
+	return 0;
+}
+
+static const struct dax_operations virtio_fs_dax_ops = {
+	.direct_access = virtio_fs_direct_access,
+	.copy_from_iter = virtio_fs_copy_from_iter,
+	.copy_to_iter = virtio_fs_copy_to_iter,
+	.zero_page_range = virtio_fs_zero_page_range,
+};
+
+static void virtio_fs_cleanup_dax(void *data)
+{
+	struct dax_device *dax_dev = data;
+
+	kill_dax(dax_dev);
+	put_dax(dax_dev);
+}
+
+static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
+{
+	struct virtio_shm_region cache_reg;
+	struct dev_pagemap *pgmap;
+	bool have_cache;
+
+	if (!IS_ENABLED(CONFIG_DAX_DRIVER))
+		return 0;
+
+	/* Get cache region */
+	have_cache = virtio_get_shm_region(vdev, &cache_reg,
+					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
+	if (!have_cache) {
+		dev_notice(&vdev->dev, "%s: No cache capability\n", __func__);
+		return 0;
+	}
+
+	if (!devm_request_mem_region(&vdev->dev, cache_reg.addr, cache_reg.len,
+				     dev_name(&vdev->dev))) {
+		dev_warn(&vdev->dev, "could not reserve region addr=0x%llx"
+			 " len=0x%llx\n", cache_reg.addr, cache_reg.len);
+		return -EBUSY;
+	}
+
+	dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n", cache_reg.len,
+		   cache_reg.addr);
+
+	pgmap = devm_kzalloc(&vdev->dev, sizeof(*pgmap), GFP_KERNEL);
+	if (!pgmap)
+		return -ENOMEM;
+
+	pgmap->type = MEMORY_DEVICE_FS_DAX;
+
+	/* Ideally we would directly use the PCI BAR resource but
+	 * devm_memremap_pages() wants its own copy in pgmap.  So
+	 * initialize a struct resource from scratch (only the start
+	 * and end fields will be used).
+	 */
+	pgmap->res = (struct resource){
+		.name = "virtio-fs dax window",
+		.start = (phys_addr_t) cache_reg.addr,
+		.end = (phys_addr_t) cache_reg.addr + cache_reg.len - 1,
+	};
+
+	fs->window_kaddr = devm_memremap_pages(&vdev->dev, pgmap);
+	if (IS_ERR(fs->window_kaddr))
+		return PTR_ERR(fs->window_kaddr);
+
+	fs->window_phys_addr = (phys_addr_t) cache_reg.addr;
+	fs->window_len = (phys_addr_t) cache_reg.len;
+
+	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx"
+		" len 0x%llx\n", __func__, fs->window_kaddr, cache_reg.addr,
+		cache_reg.len);
+
+	fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops, 0);
+	if (IS_ERR(fs->dax_dev))
+		return PTR_ERR(fs->dax_dev);
+
+	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
+					fs->dax_dev);
+}
+
 static int virtio_fs_probe(struct virtio_device *vdev)
 {
 	struct virtio_fs *fs;
@@ -707,6 +842,10 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 
 	/* TODO vq affinity */
 
+	ret = virtio_fs_setup_dax(vdev, fs);
+	if (ret < 0)
+		goto out_vqs;
+
 	/* Bring the device online in case the filesystem is mounted and
 	 * requests need to be sent before we return.
 	 */
diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
index 3056b6e9f8ce..bea38291421b 100644
--- a/include/uapi/linux/virtio_fs.h
+++ b/include/uapi/linux/virtio_fs.h
@@ -16,4 +16,7 @@ struct virtio_fs_config {
 	__le32 num_request_queues;
 } __attribute__((packed));
 
+/* For the id field in virtio_pci_shm_cap */
+#define VIRTIO_FS_SHMCAP_ID_CACHE 0
+
 #endif /* _UAPI_LINUX_VIRTIO_FS_H */
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
