Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631EA434DA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 11:44:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E6CD021296410;
	Thu, 13 Jun 2019 02:44:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+aff2f865c54b6c032bcd+5772+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C8FA121296407
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 02:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wPaWdCIL9H03r8HySQVqow//0jNnHtt/N2MgQJISZ8s=; b=avKv6xwbjUwP5JnIfmut07FD4E
 gJPJZ8ZQmWlKJYjAzKHwT0cqU9A36XKIAMssk8gQpq3IhjxldclzNcvSF1zNcI9FEe5J4DrlwynxU
 BOkf4ZqVPr5yBB+WsSzI5BaGpY9hBxi7Qh2og5bCGOdVDDRSHg1MVKNLMpKkG5YCrQBvTdqcEqdjK
 BIBwnNK0AKvH4MNtye6T+KQS+ymNK5QfOcLa6VAmU5b2i3i5m5oX14CGYl5bXnH+Ld0nP0t5HEDau
 tkrt/zZv4j5UrYFMV46EwV5BMV6zPYhoYxnhEc4quUvclTo0SfZwBQ7d4I6wYboawBdk9qACJlW6E
 gRpSlcmw==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hbMH8-0001rw-At; Thu, 13 Jun 2019 09:44:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 13/22] device-dax: use the dev_pagemap internal refcount
Date: Thu, 13 Jun 2019 11:43:16 +0200
Message-Id: <20190613094326.24093-14-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The functionality is identical to the one currently open coded in
device-dax.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/dax-private.h |  4 ---
 drivers/dax/device.c      | 52 +--------------------------------------
 2 files changed, 1 insertion(+), 55 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index a45612148ca0..ed04a18a35be 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -51,8 +51,6 @@ struct dax_region {
  * @target_node: effective numa node if dev_dax memory range is onlined
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
- * @ref: pgmap reference count (driver owned)
- * @cmp: @ref final put completion (driver owned)
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -60,8 +58,6 @@ struct dev_dax {
 	int target_node;
 	struct device dev;
 	struct dev_pagemap pgmap;
-	struct percpu_ref ref;
-	struct completion cmp;
 };
 
 static inline struct dev_dax *to_dev_dax(struct device *dev)
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index e23fa1bd8c97..a9d7c90ecf1e 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -14,37 +14,6 @@
 #include "dax-private.h"
 #include "bus.h"
 
-static struct dev_dax *ref_to_dev_dax(struct percpu_ref *ref)
-{
-	return container_of(ref, struct dev_dax, ref);
-}
-
-static void dev_dax_percpu_release(struct percpu_ref *ref)
-{
-	struct dev_dax *dev_dax = ref_to_dev_dax(ref);
-
-	dev_dbg(&dev_dax->dev, "%s\n", __func__);
-	complete(&dev_dax->cmp);
-}
-
-static void dev_dax_percpu_exit(void *data)
-{
-	struct percpu_ref *ref = data;
-	struct dev_dax *dev_dax = ref_to_dev_dax(ref);
-
-	dev_dbg(&dev_dax->dev, "%s\n", __func__);
-	wait_for_completion(&dev_dax->cmp);
-	percpu_ref_exit(ref);
-}
-
-static void dev_dax_percpu_kill(struct dev_pagemap *pgmap)
-{
-	struct dev_dax *dev_dax = container_of(pgmap, struct dev_dax, pgmap);
-
-	dev_dbg(&dev_dax->dev, "%s\n", __func__);
-	percpu_ref_kill(pgmap->ref);
-}
-
 static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		const char *func)
 {
@@ -442,10 +411,6 @@ static void dev_dax_kill(void *dev_dax)
 	kill_dev_dax(dev_dax);
 }
 
-static const struct dev_pagemap_ops dev_dax_pagemap_ops = {
-	.kill		= dev_dax_percpu_kill,
-};
-
 int dev_dax_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
@@ -463,24 +428,9 @@ int dev_dax_probe(struct device *dev)
 		return -EBUSY;
 	}
 
-	init_completion(&dev_dax->cmp);
-	rc = percpu_ref_init(&dev_dax->ref, dev_dax_percpu_release, 0,
-			GFP_KERNEL);
-	if (rc)
-		return rc;
-
-	rc = devm_add_action_or_reset(dev, dev_dax_percpu_exit, &dev_dax->ref);
-	if (rc)
-		return rc;
-
-	dev_dax->pgmap.ref = &dev_dax->ref;
-	dev_dax->pgmap.ops = &dev_dax_pagemap_ops;
 	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
-	if (IS_ERR(addr)) {
-		devm_remove_action(dev, dev_dax_percpu_exit, &dev_dax->ref);
-		percpu_ref_exit(&dev_dax->ref);
+	if (IS_ERR(addr))
 		return PTR_ERR(addr);
-	}
 
 	inode = dax_inode(dax_dev);
 	cdev = inode->i_cdev;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
