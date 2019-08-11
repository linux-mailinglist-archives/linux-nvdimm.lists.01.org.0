Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E247789084
	for <lists+linux-nvdimm@lfdr.de>; Sun, 11 Aug 2019 10:13:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A9732194EB77;
	Sun, 11 Aug 2019 01:15:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+ae155d32c5e98ef18dee+5831+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 11115212CFEB9
 for <linux-nvdimm@lists.01.org>; Sun, 11 Aug 2019 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uoRjcc+yME8yAPa9Xc310HToAkfl96lLd5QwWON1ovM=; b=KEcMyEGDGTyU3DR/tZsAvRAvj9
 QaPfx4IIxQLHeN3VZwLRrkp0R0j7CmmPQUVfzE8mMwlkhfRUD3xuliZaBVBv9otQoT4AHLPWmezWS
 F+D0GqnHXxyke5eZl9lkRS0BcdFFyJpNgV5hnecQACoQKhye9zNIdmNKIqg4Dz+0R4HKBTYR19bke
 rXAlZJSfjmblsw1SNe5dAmUOMP7l7GiiEjuTLIzqzp4jabaFnG0cUGH2TNG5kGU9CdwHwgyeM4lkp
 ga9KAp+07OYjdaeNXIU6yUDKkujJcokbaSDnaTQg5z2Qi6tQvzxBbiKperT51YI2zsAUexe3SnR95
 sw7YqVUg==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hwiyC-0005CY-IP; Sun, 11 Aug 2019 08:12:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 1/5] resource: pass a name argument to
 devm_request_free_mem_region
Date: Sun, 11 Aug 2019 10:12:43 +0200
Message-Id: <20190811081247.22111-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190811081247.22111-1-hch@lst.de>
References: <20190811081247.22111-1-hch@lst.de>
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
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add an explicit resource name argument to devm_request_free_mem_region.
Besides allowing drivers to request multiple regions per device with
different names, this also prepares for a not device managed version of
the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 3 ++-
 include/linux/ioport.h                 | 2 +-
 kernel/resource.c                      | 5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 1333220787a1..aedf18a44789 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -605,7 +605,8 @@ nouveau_dmem_init(struct nouveau_drm *drm)
 	 * and latter if we want to do thing like over commit then we
 	 * could revisit this.
 	 */
-	res = devm_request_free_mem_region(device, &iomem_resource, size);
+	res = devm_request_free_mem_region(device, &iomem_resource, size,
+			dev_name(device));
 	if (IS_ERR(res))
 		goto out_free;
 	drm->dmem->pagemap.type = MEMORY_DEVICE_PRIVATE;
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5b6a7121c9f0..0dcc48cafa80 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -296,7 +296,7 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
 }
 
 struct resource *devm_request_free_mem_region(struct device *dev,
-		struct resource *base, unsigned long size);
+		struct resource *base, unsigned long size, const char *name);
 
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index 7ea4306503c5..0ddc558586a7 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1650,13 +1650,14 @@ EXPORT_SYMBOL(resource_list_free);
  * @dev: device struct to bind the resource to
  * @size: size in bytes of the device memory to add
  * @base: resource tree to look in
+ * @name: identifying name for the new resource
  *
  * This function tries to find an empty range of physical address big enough to
  * contain the new resource, so that it can later be hotplugged as ZONE_DEVICE
  * memory, which in turn allocates struct pages.
  */
 struct resource *devm_request_free_mem_region(struct device *dev,
-		struct resource *base, unsigned long size)
+		struct resource *base, unsigned long size, const char *name)
 {
 	resource_size_t end, addr;
 	struct resource *res;
@@ -1670,7 +1671,7 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 				REGION_DISJOINT)
 			continue;
 
-		res = devm_request_mem_region(dev, addr, size, dev_name(dev));
+		res = devm_request_mem_region(dev, addr, size, name);
 		if (!res)
 			return ERR_PTR(-ENOMEM);
 		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
